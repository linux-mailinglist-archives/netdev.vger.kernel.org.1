Return-Path: <netdev+bounces-34215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC887A2D98
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 05:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2986F282E5B
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26455691;
	Sat, 16 Sep 2023 03:17:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6DD6121
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 03:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC456C433C7;
	Sat, 16 Sep 2023 03:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694834234;
	bh=2wB441IMxW8Bf7RtH4ko5Zr4H9uiqW4tNC79dzwyam8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BqpaqrYv2+kabDFSlaO8QKd5URC9L2aR8Ozcdd3r73I7zk2oeZDQ7PVCBF5nrFAXZ
	 NZgso7PBcG50oeoNArMbJbvV/MmoCPCt5m2VJkhPJ1g9Z4eFltXdb+B2suIpYCZsw/
	 vcbwbxNQSyupE6r2VfIal1pU4qUn9pumwFY51OOBO930DDi3OJ19wJEXTg+bDgXasy
	 u2XvOGwxmcqL63KcDzm6BCYhd9bMZS5pe24n2aAvPrDIASGLknaL8vBPmsEHsjnK8J
	 5fMGrm5KNVDsTDO5NhnHScYr7YxIyUh7qLN5sycpopkoAtqh8ptg5O22yBrGuLAoE3
	 1qCZ0vLgwrxbA==
Message-ID: <ab927036-a7d1-8729-ff06-e821e8253570@kernel.org>
Date: Fri, 15 Sep 2023 21:17:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
 path variables
Content-Language: en-US
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-4-lixiaoyan@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230916010625.2771731-4-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/23 7:06 PM, Coco Li wrote:
> Reorganize fast path variables on tx-txrx-rx order.
> Fastpath cacheline ends after sysctl_tcp_rmem.
> There are only read-only variables here. (write is on the control path
> and not considered in this case)
> 
> Below data generated with pahole on x86 architecture.
> 
> Fast path variables span cache lines before change: 4
> Fast path variables span cache lines after change: 2
> 
> Tested:
> Built and installed.
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Wei Wang <weiwan@google.com>
> ---
>  include/net/netns/ipv4.h | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



