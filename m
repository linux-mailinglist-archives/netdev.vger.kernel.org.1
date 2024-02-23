Return-Path: <netdev+bounces-74562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C798861DB6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2301F246B1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66C143C77;
	Fri, 23 Feb 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aperture.us header.i=@aperture.us header.b="KcBzGNeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F310A11
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720732; cv=none; b=UYiBC9S+Bn/MfP2k6cQu1+MYeEmhZHYw9VSSf9RWnDQ4l7mU8DLZMWwGuuQUjbKBxddextyj46gSazId3M3t0Xlm4jiFLx0vfqRAKlL/3lSfDNR2iLXAAZIIs3JoDs1Fso10zSU6jyCg1bDteO3NS23NI25+vv8HQLv68rUCXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720732; c=relaxed/simple;
	bh=R8YRr7TMTZ45PhenbzFOoGMD1g36kmrxiiTtEBB4hEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e72dukzgHSo9Ci1vUUZCcmZE2ZgHGLYPcmB3M4BDEnCoAd6TGH6DQCwFHRqyT+VLYPIDh1ZldNDSMZ3crvaXh+FXbBXe8tDhn4cDUB3Kiv19l+A5khilobw+8sQ+9WU80W4npr5n/Bc6CjmX2nCAlVG44FoTF2c2UFaw7F5zrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aperture.us; spf=pass smtp.mailfrom=aperture.us; dkim=pass (2048-bit key) header.d=aperture.us header.i=@aperture.us header.b=KcBzGNeO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aperture.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aperture.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d484a58f6so182206066b.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aperture.us; s=google; t=1708720729; x=1709325529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8YRr7TMTZ45PhenbzFOoGMD1g36kmrxiiTtEBB4hEs=;
        b=KcBzGNeOSFwv7uwgizc+W6BWPu5TbbUPUeTPwres+YMt6+0E3fYV3VlLlYYKDFRfWF
         9aDS3xZ8Qb3QHqUpJ4DcDrztHLJa5aJhDC5b95XSQyRsSTFCjzvGgLoJ+yL7XTa11maJ
         5cyCfocyHZot1ZaGeGaHRG4fT5XQz9huZejm3qQbZsFPVM/EMgoz1WswBRhXWyxdAs59
         pbQTQdJnMhQSkCYGvUs41LCWspKhmsMsKbv34O+ij7dak8IfC9XrDypibxaGDLJ27lLI
         1UuJFYZhn3xmINw/AHi7hZedAQI342+veKGOwv23MkZl5/yu5CetkOmWfcSH+1eSnT4v
         o98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720729; x=1709325529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8YRr7TMTZ45PhenbzFOoGMD1g36kmrxiiTtEBB4hEs=;
        b=mhjuT3C+zeOYNznVjAqr9ECMvbLUuo8PAJSybRSKqonFDNJF8OzrxkwhN1NWOVoCNI
         Dw+dWh67lsbfZYlo/Ur4Er8bgxpT4mfJ99mwCTim7aBBWTAAWj1d/CK2QMVK59SXfJsm
         fJ4qJcPFyqt+PWDN6RAKc8R7e7ETY2HrkPDoF3GnbF6Y8RPHgYw1ACV9HfdJ24ed+9Hc
         O5qAR+OgrTHtxHcnsjzcMdhhxs+3lFfT+bv0+xQ8PCqCnwwETBgj7hWt7tZCoD0s+d1x
         yI7g4u3UejEX9kzlmyCZ9c2967/ZjHi3Pu0oApXDFhGfHcY5aHelysqXZFasOJj0Ys/Z
         LHlw==
X-Forwarded-Encrypted: i=1; AJvYcCVTuwEYj0zmGMkXX71OJ45FFX+HskIdtWQHUAk78Nw/Tc33tetKM5s34hGXIZsnJPYbT/N79JPdfKv0qI8MyRmND1IXM6QH
X-Gm-Message-State: AOJu0YwF4biJezzlStT9PsILxhj9Qf0rBEWpHtPavgaAZBNat7GrbPcn
	o+NT36PJskjs/lCdtD9kKgJDcDw65+jTXaMMl6EsL0yGsR1+P/2juOuJgVnIecNCKgZ7sbjQUs4
	UZd/6sQ==
X-Google-Smtp-Source: AGHT+IHRLjQFZgptt+Eb0ejxM2BfKTbrzlZTs2slLERKxzLUYkl99tCutbvovJUeOIXhbVsodhFZHA==
X-Received: by 2002:a17:906:c35a:b0:a40:75e8:388b with SMTP id ci26-20020a170906c35a00b00a4075e8388bmr623605ejb.7.1708720729294;
        Fri, 23 Feb 2024 12:38:49 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id kt19-20020a1709079d1300b00a3fc49d2e67sm884661ejc.46.2024.02.23.12.38.48
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 12:38:48 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3d484a58f6so182201166b.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:38:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMKxjBU//7wetjA9dFsKEMGxE/0YzWhBIqUhOTsHfQGwwkJ3i9eNN+H2GDZD256dNHa76nQ7U8IhcN/dy1JfC06ePu6g+1
X-Received: by 2002:a17:906:aed5:b0:a3f:ee60:4e15 with SMTP id
 me21-20020a170906aed500b00a3fee604e15mr552895ejb.55.1708720727719; Fri, 23
 Feb 2024 12:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch> <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch> <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
 <20240126085122.21e0a8a2@meshulam.tesarici.cz> <ZbOPXAFfWujlk20q@torres.zugschlus.de>
 <20240126121028.2463aa68@meshulam.tesarici.cz> <ZcFBL6tCPMtmcc7c@torres.zugschlus.de>
 <0ba9eb60-9634-4378-8cbb-aea40b947142@gmail.com> <20240206092351.59b10030@meshulam.tesarici.cz>
 <ZcoL0MseDC69s2_P@torres.zugschlus.de> <CA+h8R2okfaYn-=toQPCkQUEZ6oLuwfjZ0ZZ-zRiN9A2fBFmzHQ@mail.gmail.com>
 <20240219204421.2f6019c1@meshulam.tesarici.cz> <20240220065941.6efa100f@kernel.org>
In-Reply-To: <20240220065941.6efa100f@kernel.org>
From: Christian Stewart <christian@aperture.us>
Date: Fri, 23 Feb 2024 12:38:36 -0800
X-Gmail-Original-Message-ID: <CA+h8R2oQNAoiXetiLF3taAp8KZdP-3t-sYNPe+BPoB0yuhG9xw@mail.gmail.com>
Message-ID: <CA+h8R2oQNAoiXetiLF3taAp8KZdP-3t-sYNPe+BPoB0yuhG9xw@mail.gmail.com>
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Marc Haber <mh+netdev@zugschlus.de>, Florian Fainelli <f.fainelli@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, alexandre.torgue@foss.st.com, 
	Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 6:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 19 Feb 2024 20:44:21 +0100 Petr Tesa=C5=99=C3=ADk wrote:
> > This new report has not yet been properly understood, but FWIW I've
> > been running stable with my patch for over a month now.
>
> Christian got an actual soft lockup, not just a lockdep warning, tho.
> Christian, could you run the stack trace thru scripts/decode_stacktrace
> and tell us which loop it's stuck on?

This was a crash report from a user and unfortunately I don't have the
kernel sources & build artifacts from that device to be able to run
decode_stacktrace. If it happens again I will request the user send me
their kernel build tree & will report back with the decoded
stacktrace.

Thanks!
Christian Stewart

