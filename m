Return-Path: <netdev+bounces-24430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AECE7702C7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048332826B3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCCACA50;
	Fri,  4 Aug 2023 14:17:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7928BA4F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C23C433C8;
	Fri,  4 Aug 2023 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691158628;
	bh=ApkfPRCB7TcjMWBCpeisWeMpBBs1DqAxZdkPRk8zHOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feDjZ8KkGFQ13Fj63EyCGelIBXB5ZtKGGRbSNHEPHEx3OXrCqWQc+OGredJ6Li3of
	 U70LnjcieQAkcPQAt75wjPdFSJgtZ4tn12aaGaaOX0FJGsegTqp8H651vITB0SaA7v
	 TcCf2+hw64XQDFD6QVl7mRcE3cJyH9ovhlV8Y31cnwHW1OLlGrWYL11qlNe3gvn8An
	 WoDlTgLmMocIgV8qKEhVfcbqpFI77iqFs3IYPG7/hQc+0yUFqmq+G8DAL5ehup/sDN
	 eSmAbUA7lcxkH/g0h00ffM9PHgJiEMfdChtPWP6bxwyo1zttJNcbQYN3rNQfn4PXDQ
	 TctT3H+rFI4Zw==
Date: Fri, 4 Aug 2023 16:17:03 +0200
From: Simon Horman <horms@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net/smc: Fix effective buffer size
Message-ID: <ZM0IX/YnaawWT9sm@kernel.org>
References: <20230803144605.477903-1-gbayer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803144605.477903-1-gbayer@linux.ibm.com>

On Thu, Aug 03, 2023 at 04:46:03PM +0200, Gerd Bayer wrote:
> Hi all,
> 
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> and make them tunable") started to derive the effective buffer size for
> SMC connections inconsistently in case a TCP fallback was used and
> memory consumption of SMC with the default settings was doubled when
> a connection negotiated SMC. That was not what we want.
> 
> This series consolidates the resulting effective buffer size that is
> used with SMC sockets, which is based on Jan Karcher's effort (see 
> [1]). For all TCP exchanges (in particular in case of a fall back when
> no SMC connection was possible) the values from net.ipv4.tcp_[rw]mem
> are used. If SMC succeeds in establishing a SMC connection, the newly
> introduced values from net.smc.[rw]mem are used.
> 
> net.smc.[rw]mem is initialized to 64kB, respectively. Internal test 
> have show this to be a good compromise between throughput/latency 
> and memory consumption. Also net.smc.[rw]mem is now decoupled completely
> from any tuning through net.ipv4.tcp_[rw]mem.
> 
> If a user chose to tune a socket's receive or send buffer size with
> setsockopt, this tuning is now consistently applied to either fall-back
> TCP or proper SMC connections over the socket.
> 
> Thanks,
> Gerd 
> 
> v1 - v2:
>  - In second patch, use sock_net() helper as suggested by Tony and demanded
>    by kernel test robot.
> 
> [1] https://lore.kernel.org/netdev/20221123104907.14624-1-jaka@linux.ibm.com

Hi Gerd,

unfortunately this patchset does not appear to apply to current 'net'.

Could you rebase and send a v3?

-- 
pw-bot: changes-requested


