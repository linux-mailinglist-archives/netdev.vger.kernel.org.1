Return-Path: <netdev+bounces-111806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92F932F5A
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03881C2237C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881919FA94;
	Tue, 16 Jul 2024 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="jSbIiMZR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D354BD4
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 17:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152126; cv=none; b=qVaLxdNILV58Tkjed3JhFFigH87sWeaVKgpYC/heYd6S7ljylz3giriNhZhL+MtlOEaaI6nvIGvl1LrvbmwhwlCWKltNH4dsHshVJj+VhwF3RmGIZywzSmI8eQDT6XMYEZTB2dG46KPYfB99l1w6J/lAU/yFzVs0uNEUvCdr4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152126; c=relaxed/simple;
	bh=raeOIprojEAXyk5ne6rsnBfmNtcpuMh35GTJs4cYRYo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iF/zRLrI6MmypTHCe+UyK0ByMuP5APjE8F16p7WB8TCSaKrCcWLGUQwYmL0kIGj9M+IZ0keahSlMd9t2waFIkptENWBSifltEaaSvIjkxribL1neBTNmd3nPPlDLeKRZ9QJnOVmoAn9QWdIDneH85sCz3YJFh2HZmYJPO/KTNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=jSbIiMZR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367a081d1cdso3084734f8f.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1721152123; x=1721756923; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNQ8X7dNt4x3kIdWz1GBCSIw2yVprX6g72c4mbs0NKo=;
        b=jSbIiMZRXdCfHj3lR2MeTjqFel5f6bFEutqq67gQ+GTOnUe9lDZ/P9ZGcTN6kqmM0B
         yKgL7Oejk/HIL9vgdA25KSYzMhw5zncXOzROhmir09rODFpWwZ+2LncJko0amCEOt0l8
         LjqX6YhIPx+7SKaGJazu5ly9Ch6uwfwVv4shMF2OaHwTk2sslFoeE/TbnP4+19Sq8gPS
         BECSU6EJDyE95IJqC3mXtg+wxSzAf1ByBdLLueJWvRyZZBOkczXIFoSMhPMgvvCwzX7V
         EO6KCX4OEiyNJxgORvv0jHf4k57xGIYKj4VuH8HDQWcDnoCZ9QrU9HeplmgOTkY219vz
         pBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152123; x=1721756923;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNQ8X7dNt4x3kIdWz1GBCSIw2yVprX6g72c4mbs0NKo=;
        b=cEifLsApVaqs6nZRedVDuh2VlxU7x1QNWjQFZveHqAlbBc0cqJgC+1Sd5SQGbz6j0V
         DAmNcQu3kbY+DlysRCz/ObfFNyhBU27K/OyN83fv3SrZ6L7Ia1vWZiQORhmZvdX9ajK/
         DZaNbV5MQIpsmT97GVPiL1eCoIo0fgyoTYUvZD8poWiC5tW1QA2libhblN++QOg0jrgP
         OECye+rxH2RokvpIJsZLJZZK4WBTq9PIDW14esqRu33+GbvJhcRSKCYPGXjfp6CclHcI
         2/D3kU2hi+ZFLMXvmVHWmCPd3QLlHZhUJlvrnbkfGWukIKYCz76MbEBq7w543gNRW7iV
         mAKg==
X-Forwarded-Encrypted: i=1; AJvYcCU43PrQtoI3gA6yOfdVOfc/6h0RoLNnU3Odv6BlK5DHnliuc5LRczXmRwOmNcguV+uHMgN3CT1ZvsH42Jle/3iQfqABv/tR
X-Gm-Message-State: AOJu0YxNVcIFXNxufbrKHveqLIp6jyakMD8zUKzUOpOrN9xB12TS47nS
	R4Su0yzAmk3LkDsJrVwatCnMcd3+VGYFeluRdTJjHbJdw4uzkf+dmloN+iWwo5o=
X-Google-Smtp-Source: AGHT+IGWKabxP/OJJTLUYgjsuTiSdT0uqw/NqeK2JS5nqvpacbKOZx1/S+qHAieKxjAq2YP9XmNEgw==
X-Received: by 2002:a05:6000:d09:b0:367:9571:ceee with SMTP id ffacd0b85a97d-36826144706mr2030805f8f.37.1721152122939;
        Tue, 16 Jul 2024 10:48:42 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:f844:6ed2:1a28:3f1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3e1csm9638912f8f.2.2024.07.16.10.48.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2024 10:48:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net-next] net: mvpp2: Improve data types and use min()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
Date: Tue, 16 Jul 2024 19:48:31 +0200
Cc: marcin.s.wojtas@gmail.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2AAC5AF-59D0-4985-A3DD-EC9E72324CD7@toblux.com>
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
 <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Mailer: Apple Mail (2.3774.600.62)

On 15. Jul 2024, at 17:44, Russell King (Oracle) <linux@armlinux.org.uk> =
wrote:
> On Thu, Jul 11, 2024 at 05:47:43PM +0200, Thorsten Blum wrote:
>> Change the data type of the variable freq in mvpp2_rx_time_coal_set()
>> and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
>> the data type u32.
>>=20
>> Change the data type of the function parameter clk_hz in
>> mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
>> and remove the following Coccinelle/coccicheck warning reported by
>> do_div.cocci:
>>=20
>>  WARNING: do_div() does a 64-by-32 division, please consider using =
div64_ul instead
>>=20
>> Use min() to simplify the code and improve its readability.
>>=20
>> Compile-tested only.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>=20
> I'm still on holiday, but it's a wet day today. Don't expect replies
> from me to be regular.
>=20
> I don't think this is a good idea.
>=20
> priv->tclk comes from clk_get_rate() which returns an unsigned long.
> tclk should _also_ be an unsigned long, not a u32, so that the range
> of values clk_get_rate() returns can be represented without being
> truncted.
>=20
> Thus the use of unsigned long elsewhere where tclk is passed into is
> actually correct.

I don't think tclk should be an unsigned long.

In [1] Eric Dumazet wrote:

  "This is silly, clk_hz fits in a u32, why pretends it is 64bit ?"

and all functions in mvpp2_main.c (mvpp2_write(), do_div(),
device_property_read_u32(), and mvpp22_gop_fca_set_timer()), which have
tclk as a direct or indirect argument, assume tclk is a u32.

Although mvpp2_cycles_to_usec() suggests it can be called with an
unsigned long clk_hz, do_div() then immediately casts it to a u32
anyway.

Yes, the function clk_get_rate() returns an unsigned long according to
its signature, but tclk is always used as a u32 afterwards.

I'm not familiar with the hardware, but I guess the clock rate always
fits into 32 bits (just like Eric wrote)?

Thanks,
Thorsten

> If we need to limit tclk to values that u32 can represent, then that
> needs to be done here:
>=20
>                priv->tclk =3D clk_get_rate(priv->pp_clk);
>=20
> by assigning the return value to an unsigned long local variable,
> then checking its upper liit before assigning it to priv->tclk.

[1] =
https://lore.kernel.org/linux-kernel/cbcdb354-04de-2a9a-1754-c32dd014e859@=
gmail.com/=

