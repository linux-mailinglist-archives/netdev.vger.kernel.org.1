Return-Path: <netdev+bounces-41628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448867CB7B4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751501C209EA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164C17CD;
	Tue, 17 Oct 2023 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucgE/qvZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387A17CB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3144BC433C8;
	Tue, 17 Oct 2023 00:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697504344;
	bh=TRjjaJWIMEYvYdxtNEflFxzBXlU1jl3PE2M8HoVQ6QE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ucgE/qvZri7ll4+VsoI27Jhy+PY9iWoXSvupZhCDn9VgiR777q/4ouZWIcAlz4ckT
	 YsmBERO+WUO8rzfobDPQBbb0FmR8V4/EupAG92HqOds0nWdNGG5SrdtxHWB0E5V9vi
	 W4KfI2TQoRrZlZl2u8eQr0ghTYPOaqK59Cn5fTUGeHJGu3++ooXGS5ZvN9XYb4EXZh
	 DrbKkel8t99ktbHevmI0omMYZElCIUejM6dh7u+pnCAOh0Ewxe9s3YxBhrSrEczXwJ
	 lu1RLta1HMvtT8lIjBxDYDNo0SixcQibR2F91rQtbDovjyKZ7CPEsFtaIdbL24f4MH
	 Cj5Ce9kZ0nkIA==
Date: Mon, 16 Oct 2023 17:59:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v2] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231016175903.605f61aa@kernel.org>
In-Reply-To: <20231016110222.465453-1-jiri@resnulli.us>
References: <20231016110222.465453-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Oct 2023 13:02:22 +0200 Jiri Pirko wrote:
> +class FakeSpecAttr:
> +    def __init__(self, name):
> +        self.dict = {"name": name, "type": None}
> +        self.is_multi = False
> +
> +    def __getitem__(self, key):
> +        return self.dict[key]
> +
> +    def __contains__(self, key):
> +        return key in self.dict

Why the new class? Why not attach the NlAttr object directly?

I have an idea knocking about in my head to support "polymorphic"
nests (nests where decoding depends on value of another attr,
link rtnl link attrs or tc object attrs). The way I'm thinking 
about doing it is to return NlAttr / struct nla_attr back to the user.
And let the users call a sub-parser of choice by hand.

So returning a raw NlAttr appeals to me more.

> +                if not self.process_unknown:
> +                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
> +                if attr._type & Netlink.NLA_F_NESTED:
> +                    subdict = self._decode(NlAttrs(attr.raw), None)
> +                    decoded = subdict
> +                else:
> +                    decoded = attr.as_bin()

Again, I wouldn't descend at all.

