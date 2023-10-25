Return-Path: <netdev+bounces-44303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723D27D784C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD3281B37
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064B3418C;
	Wed, 25 Oct 2023 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXtimsUX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12450749F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238A2C433C8;
	Wed, 25 Oct 2023 23:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698274817;
	bh=U4U92NhAWTlUJKDTHhkeb5vu9mAzLBIAeKvwYktnV8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IXtimsUXLsqa8ueqNljNu2E4+B8NZk3sWi/RcEoGOS8cb7M6gAOdaOCF+uQ7ituv7
	 5Bs8cra7EOk8m7rdMtHGaaIgnR6pVIpz+g5NKagIxopfcIyN8scVrE7iLq5MILinOf
	 V1A6E5PekBW4QFRATIr+8jnXLodPOsen8wo5udg5q+AzkcUna9KPRK4sraFhB/mrmw
	 4J1BFazSzOtenb8QW+9+C+6butNhlCRgqvpuXTF1ZUXLYMcLmFZWGyld02DgerE3Yr
	 CegyPGqctYGLduMIj4TmRZiuPK8pruGjytWtsQqTiQL6RgeW/y+DJVMvjL2rkt9Gqg
	 YFV1Aix1mkN2A==
Date: Wed, 25 Oct 2023 16:00:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Willem de Bruijn <willemb@google.com>,
 syzbot+a8c7be6dee0de1b669cc@syzkaller.appspotmail.com,
 joonwpark81@gmail.com
Subject: Re: [PATCH net] llc: verify mac len before reading mac header
Message-ID: <20231025160016.0ffecfac@kernel.org>
In-Reply-To: <CAF=yD-L8MobHEPvELTKkvpm4WAZAVPbJKqXnjnkaD7qr32NBEQ@mail.gmail.com>
References: <20231024194958.3522281-1-willemdebruijn.kernel@gmail.com>
	<CAF=yD-L8MobHEPvELTKkvpm4WAZAVPbJKqXnjnkaD7qr32NBEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 23:12:13 -0400 Willem de Bruijn wrote:
> Fixes: f83f1768f833 ("[LLC]: skb allocation size for responses")
> 
> Can respin if necessary.
> 
> At least one of the three eth_hdr uses goes back to before the start
> of git history.

Right, good enough.

> But the one that syzbot exercises is introduced in this commit.
> 
> That commit is old enough (2008), that effectively all stable kernels
> should receive this. This commit also introduces llc_mac_header_len,
> which shows at least one valid L2 header that is not an Ethernet
> header, back in the day:
> 
> +#ifdef CONFIG_TR
> +       case ARPHRD_IEEE802_TR:
> +               return sizeof(struct trh_hdr);
> +#endif
> 
> But that token ring variant was removed in 2012 in commit 211ed865108e
> ("net: delete all instances of special processing for token ring").

