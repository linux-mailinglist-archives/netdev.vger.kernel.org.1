Return-Path: <netdev+bounces-133344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9B995B81
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331AF2852C9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814DE218589;
	Tue,  8 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxudDEe+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0921791F;
	Tue,  8 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429561; cv=none; b=Kjsxm7JFrXu9b1y1XIv37Up5ArkI8potHAgAatvv8n2HSEbbYuNTWVscqs9tCWcm8VVhkRwrb+z6/0NJAUiYXgezRPkRLpq2rw8rbYebZK4LtCkYGJbB2+bMl6n5gRWnbxT8J/NkShLCEUiTfMuzfr6ZwdW6C7KQvcEv7fCnRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429561; c=relaxed/simple;
	bh=gTWGsv7uY1K8VWvpLbEDVgebMOy2fP6ul+31O5zb9Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+wZwRndqkVIp6nek5FalUlM3CebBbhFGUqOE5EIaFODtgfW15r3+LMgZMxVczkAHNpygncyiOBQEiS3KkZpcD1OOx7sT3csV/gNVPG67oVLCdZHLO6URgHTPPCNoJmWkJ2q9aMQG0LmVG+gEJK3mLV1HoUUYOdV0Bsl6W+1JQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxudDEe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CE4C4CEC7;
	Tue,  8 Oct 2024 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429560;
	bh=gTWGsv7uY1K8VWvpLbEDVgebMOy2fP6ul+31O5zb9Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KxudDEe+/+es8cheWwkaUSFhkaqAL6qR9o8mErV+SRzv+gU6FNQ+FVbO4DU+K6wtG
	 4QctfNcDI+ObWlAKZAeekBILuKkwlqBalR1+S1DCkObQ2s/CedwUoU4rDfnfbsXLJk
	 BnfC6fv0/PvDSXWf6EqsSwEr+wZd61yI4KX97ZxmxJJUrCoSDub1CTfR/YQf0gFaXz
	 W38Z1qlBMZ7ApGqhCI0337h0EjK7qA3MMthVQwwNhPZSIzUClXIAlfVvIuvWcZRTqU
	 JfAPJc3dJkPnY5kK7IexO8XVqtE+h0OgEcJZaha/FGTAJav6N/i9Rm82y780gsZQXT
	 J2lRJ7DwJPphg==
Date: Tue, 8 Oct 2024 16:19:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens
 <danielj@nvidia.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20241008161919.026488d9@kernel.org>
In-Reply-To: <ZwW5md5SlrxBeVCN@LQ3V64L9R2>
References: <20241001235302.57609-1-jdamato@fastly.com>
	<20241001235302.57609-7-jdamato@fastly.com>
	<ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
	<20241008151934.58f124f1@kernel.org>
	<ZwW5md5SlrxBeVCN@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 16:00:41 -0700 Joe Damato wrote:
> > Make sure you edit the spec, not the output. Looks like there may be 
> > a problem here (napi-id vs id in the attributes).  
> 
> I'm not sure I follow this part, sorry if I'm just missing something
> here.
> 
> I was referring to NETDEV_A_NAPI_DEFER_HARD_IRQS which in RFCv4 is
> listed as NLA_S32 (in this patch):
> 
> static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
>      [NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
>      [NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },
> 
> However, in the yaml spec (patch 2/9):
> 
> +      -
> +        name: defer-hard-irqs
> +        doc: The number of consecutive empty polls before IRQ deferral ends
> +             and hardware IRQs are re-enabled.
> +        type: u32
> +        checks:
> +          max: s32-max
> 
> So the type is u32 but with a "checks" to match what happens now in
> sysfs.
> 
> That's why I mentioned changing NLA_S32 to NLA_U32.
> 
> Am I missing something?

YNL will generate the correct code for your - the right type
and the right range validation. Run the command below to see.

> Not sure what you meant by "napi-id vs id" ?

I can't apply the series now, but when it was posted the YNL code
generation failed here complaining about napi-id not existing in
the attribute set in which it is used. In the napi attribute set
the NAPI ID is called just "id", not "napi-id".

> > Make sure you run: ./tools/net/ynl/ynl-regen.sh -f
> > and the tree is clean afterwards  
> 
> OK, will do.

