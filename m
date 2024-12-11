Return-Path: <netdev+bounces-151013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E216A9EC5D0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32AD18819FE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08031C5F21;
	Wed, 11 Dec 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Eh2uPC2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B691C1F06
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903089; cv=none; b=KVSvBN8z9Bb1y0carCscnhTG7rTLAEP5zo/zhVAdhLolu9MGfuilvm+9oqN2R+DRSc2uMlenudD2HiFVmWu5EyUwYL8cMdpeOcM6HNvi4T5s34YI+OGo5jI472yhRu/XSrDrhGm2cJFO3aMTqweEf34amski+oNOr4j2duEblTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903089; c=relaxed/simple;
	bh=sxIVMt2/hjD756uf6JvOJ1KnrBG+5g6ANXFrmIgtwkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk9pBn4f4EqimO/59bD/js61R8JVvT4K0gYrRDuDV2oeoooQneBAG8lTPPM2BnkLJiFlmg7WrCup+FVyEXRbJ2oGywYFQ3x5LzVo6CL8vBQFZEBP3TmloAldS1uU/Y5d095yTfprVC+jdPApvy0pRnH9FN+h0xFLOdYgoIYzXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Eh2uPC2J; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so10018491a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903086; x=1734507886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D97EgHWZotyjd7s/d3GBn8KBQp5+lUYmXrY11fzr0yo=;
        b=Eh2uPC2JnIxcl1XZXws60JnnYP74xWciU98zGloUD3FFIDAgKyJuPOOpS/Qn6Pb7G9
         6983NlQ1hyTG/BMCbRYXKGU5HifKa9qyh2VSRtmTIQ/Z9I20uiQeUEzDGUx88zzZ01Hz
         DYosQyGPc/M72N9m5V8Linx4RuiSnM88ZZhFH20gJ3jZt6C0hDASB0VdGLxbJpNjaqNx
         uFkkBuv243YfhEJ2VOfc+q5VN0uK/MznAGiogl/3h1wIC7LIjnHWB7Hc25VwWzHDMTSh
         WAsd1eu74x3dp7QldLx6i38O8+hIsldtFNTdXT1clYDcvG+yCEOY65801n263ZsmcHmK
         ImEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903086; x=1734507886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D97EgHWZotyjd7s/d3GBn8KBQp5+lUYmXrY11fzr0yo=;
        b=UkFYQLB9o4Nb81wjxRpfcc8kSylibYfWi2UhrQ4oUVxSkd2+UpaJFR5JYHjg3EJDnW
         Sno3jQoM3hX1YPoF6HvjISfFpepR0QxH1OQibwFfJgL7LsARBjI+iGROVwwOk2iGurvn
         1l++OdYkP9nA4NMp0ju6D45DL4HG6DeURGyERU1Ncp9wh2BHg1ZyJ9B9tOKJPGEa757d
         JYFZMHGHVDA/x7+YD0GpA+Tsw40pUhSk/swr9KTDQtVcb9DvlMCuKpQRDiG0kRh7QjIk
         LDyA/PlaOWvucvGZd/VX6TtcHIiR5oh8LJyGUTbWfIlIM44cgjTj7VhVUcpxo6R/6Tub
         bG9A==
X-Forwarded-Encrypted: i=1; AJvYcCUdVOsFOM/IFeb1FuPRSC1ESdiJ132C/pMlf8dRJhXzkj5RCgBqMftc6heqgsiLFanvx7/7o54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aGMhN4ni8R4RpUaRB5wacVA4+yZO9y+pgmsGa6Q5BL+UcZV5
	Njct/jv1uMsafCo6Geho2Xp2KaKiXMjZReY9qBK0dXMXxm7UmNu7EFYG/sw6Zr4s6yxoynovpoy
	3
X-Gm-Gg: ASbGncuf8ofg9ckP49HbnM78lIn2pMkujRzTwDgAQlk6/zDw2WSHCQVYDkkvjuIv/rg
	FinI1wSOGVqiRszxjw18r6NkjALt9oFMLK3fKhuvKhIPYva1mwDGLQdooaXtp18KUWpvmhEzdoc
	dbijSoYKmef/F3NDm5+W5gBoYoSR5D35TNVWjFyI0uW1x7W0aqM+7NNE/T1690yRpqalDCH1gQr
	a+w3kIf278JvPTY7Y4w1Voo4iGVBcgixKPG0oEFejducGzdzIBuU9wG
X-Google-Smtp-Source: AGHT+IH5dw3FTzIpV1e0MSOD0zhH7/Ngnd7ahJWo+lQxTTpdSZqNLLX26PwbmrntQk9dug+yImGlmA==
X-Received: by 2002:a17:906:3ca9:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-aa6b11b6dc2mr153987966b.31.1733903086202;
        Tue, 10 Dec 2024 23:44:46 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm450821966b.108.2024.12.10.23.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:44:45 -0800 (PST)
Message-ID: <63fe7c7e-f45f-454a-ac07-db758661d15b@blackwall.org>
Date: Wed, 11 Dec 2024 09:44:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] bonding: Fix initial {vlan,mpls}_feature set in
 bond_compute_features
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> If a bonding device has slave devices, then the current logic to derive
> the feature set for the master bond device is limited in that flags which
> are fully supported by the underlying slave devices cannot be propagated
> up to vlan devices which sit on top of bond devices. Instead, these get
> blindly masked out via current NETIF_F_ALL_FOR_ALL logic.
> 
> vlan_features and mpls_features should reuse netdev_base_features() in
> order derive the set in the same way as ndo_fix_features before iterating
> through the slave devices to refine the feature set.
> 
> Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
> Fixes: 2e770b507ccd ("net: bonding: Inherit MPLS features from slave devices")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 42c835c60cd8..320dd71392ef 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1563,8 +1563,9 @@ static void bond_compute_features(struct bonding *bond)
>  
>  	if (!bond_has_slaves(bond))
>  		goto done;
> -	vlan_features &= NETIF_F_ALL_FOR_ALL;
> -	mpls_features &= NETIF_F_ALL_FOR_ALL;
> +
> +	vlan_features = netdev_base_features(vlan_features);
> +	mpls_features = netdev_base_features(mpls_features);
>  
>  	bond_for_each_slave(bond, slave, iter) {
>  		vlan_features = netdev_increment_features(vlan_features,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


