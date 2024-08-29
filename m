Return-Path: <netdev+bounces-123521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD69652A2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 835FBB22643
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B994018DF7A;
	Thu, 29 Aug 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUh0B7Jz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2818A927;
	Thu, 29 Aug 2024 22:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969311; cv=none; b=Ik3v7DoO1+o+BPMZ9Ss0GSUxZOGCV4qZ3fMgTQvHuWazdPTvaqcvXBs96gGmllDZ6dj0W6cPSb8smpPji/Z8+s5qMfdCRzB2sS/JZD1pNAA3M6vp/d/JXOH/tuGZHlyRbv50jWxeTK5i2lmZZjkngjGYkLm2491s/U5nCmBSm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969311; c=relaxed/simple;
	bh=2wCSCJDAlGikmDpXMn2E8PSpPV7Xo9qKJgl6eKReLsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj1q3KyN3GZyTfKZXmhWSWl1ugw9f46w24DoiTmX8cWQ2wEH6KlLcgwL49DSMAGK8MDusIRtcksWd7K1gH4F0tby1Vb1Why3HBr5OGWkhxxjLQZqtxkWNWl5GNBD0J3DvuGVn6ikduUL+M5SH0j2eqpRqABUOjlmdwB2ZJMFiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUh0B7Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009D2C4CEC1;
	Thu, 29 Aug 2024 22:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724969309;
	bh=2wCSCJDAlGikmDpXMn2E8PSpPV7Xo9qKJgl6eKReLsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUh0B7Jzd0wK79YFdMZSeZMJ/Enz7Nh2UVE2bPfylLJUbjFwG83aHobyWrxnBAXKM
	 ENoqHa7T5c7609om6AqMFLOcebMHV/It4INjEbuv5dQseyH4KCpIu153ZjlWS8mk3N
	 mx/M+rLvpPLx0w4y6QQ2zgrrpJMzXmbeGnpwRXDRcMSObTjXj6eZRXp9rFGsr10SmA
	 Csf34A60JKjKSsLx9wt+2HSeyzLwU2jHzEdXjmGoCSA7qTqibnBSpFCq/AXFN7/SdH
	 ePKfPOyj8c9Bi0IGp/hYAsUjbejU5GFCsRkXe8wtQlIyf6SvRYvbW5ZgO2kBwRrlWa
	 87SQCDaObdZLw==
Date: Thu, 29 Aug 2024 15:08:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
 hch@infradead.org, willy@infradead.org, willemdebruijn.kernel@gmail.com,
 skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 2/5] netdev-genl: Dump napi_defer_hard_irqs
Message-ID: <20240829150828.2ec79b73@kernel.org>
In-Reply-To: <20240829131214.169977-3-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 13:11:58 +0000 Joe Damato wrote:
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 959755be4d7f..ee4f99fd4574 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -244,6 +244,11 @@ attribute-sets:
>               threaded mode. If NAPI is not in threaded mode (i.e. uses n=
ormal
>               softirq context), the attribute will be absent.
>          type: u32
> +      -
> +        name: defer-hard-irqs
> +        doc: The number of consecutive empty polls before IRQ deferral e=
nds
> +             and hardware IRQs are re-enabled.
> +        type: s32

Why is this a signed value? =F0=9F=A4=94=EF=B8=8F
You can use:

	check:
		max: s32-max

to have netlink validate the overflow if you switch to u32.

>    -
>      name: queue
>      attributes:

> @@ -188,6 +189,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct =
napi_struct *napi,
>  			goto nla_put_failure;
>  	}
> =20
> +	napi_defer_hard_irqs =3D napi_get_defer_hard_irqs(napi);

Here, for example the READ_ONCE() wouldn't have been necessary, right?
Cause we are holding rtnl_lock(), just a random thought, not really
actionable.

> +	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irq=
s))
> +		goto nla_put_failure;

