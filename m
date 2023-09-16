Return-Path: <netdev+bounces-34218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552957A2D9D
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 05:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5846D1C20960
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347A6121;
	Sat, 16 Sep 2023 03:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0321117
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 03:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8802C433C7;
	Sat, 16 Sep 2023 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694834421;
	bh=gv8ym2Lyn5u77YU9R2c/JvN/eWjA7mufZAg/wowkbGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eIwwRLcvjcU2uPYLf5POzomQCN9L7CU+82Yf0/dP/M+n+d6k7MszRqrQ68HHLSRjd
	 Y7cRXozHYOPyidAWbD69D7Yv5vxrsetB95NO1l1V0hrWozEPP5Pm1WWZbxIv8ZYTAq
	 FBUQHGiObCvv5gFMRTM639ge5NLaOAOi6lGgb4pUyO/C2q4AYWskIpKP3fn6yqgDMi
	 Bp3hp7xBEL+2nDqiSBHdt6XlICXhMlfGV6ia6aq3CK2+U7iCz66kJ5u5pHHqNjDnh9
	 DyzAbOMzVQ9DboAMMp9EIbvv0GTPtBFsIkLcX/t74Ba0u9xniK/pJGDdYlM6yi1dPh
	 3n8IMKQWw55dw==
Message-ID: <a0f77ac5-369b-adb9-506c-429ec4e3fc86@kernel.org>
Date: Fri, 15 Sep 2023 21:20:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 net-next 0/5] Analyze and Reorganize core Networking
 Structs to optimize cacheline consumption
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/23 7:06 PM, Coco Li wrote:
> Currently, variable-heavy structs in the networking stack is organized
> chronologically, logically and sometimes by cache line access.
> 
> This patch series attempts to reorganize the core networking stack
> variables to minimize cacheline consumption during the phase of data
> transfer. Specifically, we looked at the TCP/IP stack and the fast
> path definition in TCP.
> 
> For documentation purposes, we also added new files for each core data
> structure we considered, although not all ended up being modified due
> to the amount of existing cache line they span in the fast path. In 
> the documentation, we recorded all variables we identified on the
> fast path and the reasons. We also hope that in the future when
> variables are added/modified, the document can be referred to and
> updated accordingly to reflect the latest variable organization.
> 
> Tested:
> Our tests were run with neper tcp_rr using tcp traffic. The tests have $cpu
> number of threads and variable number of flows (see below).
> 
> Tests were run on 6.5-rc1
> 
> Efficiency is computed as cpu seconds / throughput (one tcp_rr round trip).
> The following result shows Efficiency delta before and after the patch
> series is applied.
> 
> On AMD platforms with 100Gb/s NIC and 256Mb L3 cache:
> IPv4
> Flows	with patches	clean kernel	  Percent reduction
> 30k	0.0001736538065	0.0002741191042	-36.65%
> 20k	0.0001583661752	0.0002712559158	-41.62%
> 10k	0.0001639148817	0.0002951800751	-44.47%
> 5k	0.0001859683866	0.0003320642536	-44.00%
> 1k	0.0002035190546	0.0003152056382	-35.43%
> 
> IPv6
> Flows	with patches  clean kernel    Percent reduction
> 30k	0.000202535503	0.0003275329163 -38.16%
> 20k	0.0002020654777	0.0003411304786 -40.77%
> 10k	0.0002122427035	0.0003803674705 -44.20%
> 5k	0.0002348776729	0.0004030403953 -41.72%
> 1k	0.0002237384583	0.0002813646157 -20.48%
> 
> On Intel platforms with 200Gb/s NIC and 105Mb L3 cache:
> IPv6
> Flows	with patches	clean kernel	Percent reduction
> 30k	0.0006296537873	0.0006370427753	-1.16%
> 20k	0.0003451029365	0.0003628016076	-4.88%
> 10k	0.0003187646958	0.0003346835645	-4.76%
> 5k	0.0002954676348	0.000311807592	-5.24%
> 1k	0.0001909169342	0.0001848069709	3.31%
> 

This is awesome. How much of the work leveraged tools vs manually going
through code to do the reorganization of the structs? e.g., was the perf
c2c of use?


