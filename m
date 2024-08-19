Return-Path: <netdev+bounces-119762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C658956E04
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F03284B41
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED87173357;
	Mon, 19 Aug 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGEGNE9U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918DC166F07;
	Mon, 19 Aug 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079555; cv=none; b=MxIiQgZHZvoaqvHA+PNryP+3DCIx3XkxpCv+exPyUknKmVrYdpg8XZvdl7jIo3iFqLdmteja/R5uvWCysDHgZnO42J5GergBtpgkV9PZTF2hfVQAvArNzexb9QciKpkcPKNRqGqxVj2rkKk6t5aE3LOPFkK1Ebw5Kjq8cLG9Wfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079555; c=relaxed/simple;
	bh=8ngr4+KouXdYxpOVU4j9msCJ8k9vKwBsQ6Tum1BELug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxz9zVw8xIKw83Rs4yBprdQ+ViDaK7ANsyPdD6NU/KcMfGKXtJcuGkclfIe1YpWws59eaxKhrC+Hglsf5oL4T1Vo5nkoXs7wIpDB9XCoNUA6IZcxTDmfeB8xDG3BsPO0IODnbonwR5JoI52KTgNNgAOs+lVuDmmVVvH7XHLX/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGEGNE9U; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5da775a15e3so2200474eaf.1;
        Mon, 19 Aug 2024 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724079552; x=1724684352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ngr4+KouXdYxpOVU4j9msCJ8k9vKwBsQ6Tum1BELug=;
        b=SGEGNE9UNLwpcKxHtpJnJfq9ncFh9CJskU4+TOfkImBEqiD17/o7V/zaLx+kSj3VUH
         OqbeS5u74ULOB/sCsXncYvvOpZgrx0AzGhFlnwAeZnyfeEFmMHMQHJp+sQbOVajYQRIv
         G3/mL1fimlXLSJn+IR5JNU9AFXD1hgqVhRlRb9xZQMoclE+LJXy5u55z3SA+Mu+7EgEQ
         etiP1H9oxnfaNKgi1viUZZ4Rg5UPu3jv7PRN1KvJKyFJiXI3OgAccm54DqyygBotHjAj
         GIkMDorfQ5NMq2L5SHZ34tUprftSD4DXM9+FWv5qvPGkDcpT29pbnyu2y72OdU5uQIu9
         Q+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724079552; x=1724684352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ngr4+KouXdYxpOVU4j9msCJ8k9vKwBsQ6Tum1BELug=;
        b=vgswx5QRXsJycIr6G8y2E2Kyqzw+6L2RCBoACLbduWETMQZjLyqikZ7u+D+bOfsYy0
         OyNQKN7wSSi5VSIpFeEBg9Z8VP/1fVOZ2sQ29M4PS+rVkSEcYJ7EWMo0QSKrDNQjtA3G
         OJ7UCf8AZoOaf+J5l4C+LGUhAxOBx672e2RZXii5KCaZSGh3rKvCTc7M5vlhxiwdqxAW
         3d9XQWEXe5GgV/9RWTomAefVuXtT5A1LLE88/kAY5M079vDcwyC+IWPiBeVIvwsViwRB
         qEwnzYGXJPOyTsscjA7DGpO9BZkm1KODrlHUN07dV2THE47yY6Ldl3zT0cA8/pZPFcJk
         jWmA==
X-Forwarded-Encrypted: i=1; AJvYcCVixn1C8NOOmhpue5qv54nuGhnV++ebRaHuC8npKFhdKlN/Ubp5zZlWg/W50HQNhOB0FARYeVTziKVTt1C5YiBO7up5O6q1P8wdxLdbYqkqeT/i57+RfxUevA9tvg4/LRg/S15P
X-Gm-Message-State: AOJu0Yx9K1YXDYoza2xBtz8twX6PEZUDbrcRMcw2tOKx0a7VLwn8Je2F
	XrEobL6cYwJ4h+GmRwujzC+kLIrUm4674KD1+bFixA6+OKOS5W4Wi83pqFASLTeTl47/HD25Vwl
	JS/Z7sngN0ZBgIV0979QcmUOLRZs=
X-Google-Smtp-Source: AGHT+IGXW+XPyrVH3PGOB761sBifsnoX/Mr/RbArTiDaUSN0lBoxpOB4hq6iopHT6eMJygO/5Syv1vYtR5JqHBvGW5Q=
X-Received: by 2002:a05:6820:13a:b0:5da:9cea:4f30 with SMTP id
 006d021491bc7-5da9cea5503mr4429466eaf.3.1724079552710; Mon, 19 Aug 2024
 07:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819104112.gi2egnjbf3b67scu@skbuf> <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch> <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch> <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf> <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>
 <a45ef0cf-068e-4535-8857-fbea25603f32@lunn.ch> <CAHvy4ArnEy+28xO3_m6EPFQxOKR1cJNkWLEVbx6JFBzLj6VMUg@mail.gmail.com>
 <20240819144422.fxop5fkg4ruoqh43@skbuf>
In-Reply-To: <20240819144422.fxop5fkg4ruoqh43@skbuf>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 19 Aug 2024 16:59:01 +0200
Message-ID: <CAHvy4AqMM74ObHwP9cc57AgGdaxkTWMkZLenPftfrnHzYeUa-A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> > It works as you said, I will have to do some changes to userspace to
> > ensure the DHCP client uses br0 instead of eth0 but that's it.
> > I just tried and br0 obtains the IP address and all is good, with
> > DSA tagging enabled.
> >
> > This patch can be dropped, sorry for the hassle.
>
> I'm pretty baffled. Was this unclear from the user documentation at:
> https://www.kernel.org/doc/html/next/networking/dsa/configuration.html
> ? Maybe we should change something to make it more clear that this is
> what is expected.

It was to me but that's rather due to my limited knowledge of the network
stack and routing than to the quality of that documentation per se.

Cheers, Pieter

