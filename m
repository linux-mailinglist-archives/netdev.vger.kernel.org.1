Return-Path: <netdev+bounces-201582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE6AE9FA9
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3A93AF163
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871EB2E972A;
	Thu, 26 Jun 2025 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avac+T7/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE632E719B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946327; cv=none; b=b5XAUvl5G29Cqfac5rHAVO7idXe0nI5iUSxWM8HXfSPtvINMHcAnqagbC6uSQOW6/53u2p1wF3YQ2deOF7zjh/ErhRdcJKSIa5reRLChPTlAwqQtecddVFSwERiFQ0lfSgUDPbIHw9/92e9Vw5DDzAPSppItSG4MRooaJYjbMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946327; c=relaxed/simple;
	bh=/hUsmBdq7JHrVX78eTp0pNVjE+hDqdnstUPMeOksYEo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LWb2QTJ9eJqiO72uVMnfSdsLZCndkoml930HjbTwrjtnwbPZZ/ZWCkd8v/h9qaqfVlMw7Q0nXvI/d3IPgPG4Mf7bBbszglLYf4oGDH5rUUIdlVGaeqveLnXnPrB/y7J1Pw3CAjak+8vnOjAUf6AwMl1Whmp6ISVujzpqo04veNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avac+T7/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8187601f85so863270276.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750946325; x=1751551125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/a/uwukRee9I+owiJuRRoWfzpF5f85HnpfBPVZIZZQ=;
        b=Avac+T7/xIXy5fxrNioVcSZJ39a5YMyRjZxAo5D8nRcAyVIk4fxl5QF5uR9eAPIdS4
         BzMnNOuBxR6Ey07nsZJvlaHOq2IMjWvy4WIM7HNauxxrT5W1mD0HS9uYEOGlzvSazGqB
         ztquFpbIbJKBLsKss8/kcbxbEYSGQJnTDpPfZmOHPOckDjcxJPBTdS8kihXX71dso1Bb
         pYTAieiU2aSuHb61VMWJPFWDL1gziMSsUYRFlwiOlFf11XjUD+s45PqeZS1mc9l9Lf30
         m4+2prwZBsDm8uNghtt266FbETMKUvJvauUYSYxAkTyNBUAcHkPuh2j8knDFda4NCVcK
         2LYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750946325; x=1751551125;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k/a/uwukRee9I+owiJuRRoWfzpF5f85HnpfBPVZIZZQ=;
        b=VPx/ij0tCgwhsOmp37eBxBRkvpt8+4XySHn3su377qePDtZj9dSJHgi6a1VoGqg+wN
         o0RJOTIUdKSgP0/s9feAK1PBcIS/jCnP81/jpXowFBKG4WdJHfbtJ8LXmpUmxWMNWJjJ
         dw8RygrjUrgUMaqFD6pXLW1IHm+Gur81MD7I54GJwi91Cis9QElBiYNPkqw6AWhX21qP
         2XC9DryikMhgNv2yEEJRGo7eSsQNWuQ12Sa8qi859lb+hWULTbTv0SqrwGFJCYMEfFs9
         b2ya2VRV69hnZiTZ+JCCYXZP5Ybi9fP7GkVUZMF3GEjEapnJPpHHeUivLOraQvzClb2d
         X8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUC56aG0KUpZuIJ+REhbRQsYCrY7L/AhV4VADVakpF7She/5ZU0e+55DjwrzaROWeVrzMHGnqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EgZJmRI608zKeEMW3KDeWQBZfAFvqI8DXJoSDf4KQS5MDFdq
	hjFGTN4VGv8DtNc0ci/MEFCDDzLyy21e4mCW7B9tGaRzm9m6lZQ87xXB
X-Gm-Gg: ASbGnct6AnSV9sQfhLpXH/3BC61TN9Xp/Ov2fm2fAK5/hqcAIs1YTz3mlBA7iXdoSfI
	h356MQhQfEKIg+rsmvx/KYeQQyCJ2R0zj4l2mUM0HxjFG0AlhGJ3qavCH33x3luWFEHY+ExDtoc
	S5M0UVnDCfmgVBj2bSGXEWvprhobrBjqc5npzpmmljntoSwbX1KdyQ3IlAJQTu1nJL72eVw5XLy
	UKXRwjYFGsnLVF0BBXRqEL4NnSOrdaJXTNbztILqJkKV80HubcbE08FH2bBPlNdXxIsG4E6Zrty
	4rblfybUVS5ma7JTDEcEYIRzu5UabprJqxUfC8OtYGhlh+T09HfXJcy400YPP/CynC8GZ+XwcR8
	B7N905f10fNfJjNC6b8+Fq77hY2P3B7fOxYFT8IO2NA==
X-Google-Smtp-Source: AGHT+IHbwnK0JsB685mpgugYpvE81pY3ML7R9vcfimbr9A+ACb4jAGTKKpGsxBzsPljXLYFWPpgRbw==
X-Received: by 2002:a05:6902:18ca:b0:e82:5dca:92fc with SMTP id 3f1490d57ef6-e8601714a69mr9470429276.21.1750946324805;
        Thu, 26 Jun 2025 06:58:44 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e87a6bd0402sm14350276.29.2025.06.26.06.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:58:44 -0700 (PDT)
Date: Thu, 26 Jun 2025 09:58:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Daniel Zahka <daniel.zahka@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685d5213a7682_2dcd9a29452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250626064932.1be18542@kernel.org>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-2-daniel.zahka@gmail.com>
 <685c89596e525_2a5da429467@willemb.c.googlers.com.notmuch>
 <edaa7ae7-87f3-4566-b196-49c3ec97ed7d@gmail.com>
 <20250626064932.1be18542@kernel.org>
Subject: Re: [PATCH v2 01/17] psp: add documentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 26 Jun 2025 07:55:34 -0400 Daniel Zahka wrote:
> > >> +after ``psp-versions-ena`` has been disabled. User may also disable
> > >> +``psp-versions-ena`` while there are active associations, which will
> > >> +break all PSP Rx processing.
> > >> +
> > >> +Drivers are expected to ensure that device key is usable upon init
> > >> +(working keys can be allocated), and that no duplicate keys may be generated
> > >> +(reuse of SPI without key rotation). Drivers may achieve this by rotating
> > >> +keys twice before registering the PSP device.  
> > > Since the device returns a { session_key, spi } pair, risk of reuse
> > > is purely in firmware.
> 
> I don't think this is a requirement put forward in the spec?
> Specifically if a device wants to allow partitioning of the SPI
> space it may let the host pick the SPI. To me the device allocating 
> the SPIs seemed more like a convenience thing that a security feature
> to prevent reuse.

That's fair. AFAIK it is not a requirement.

Allowing the host to request a key for a specific SPI will open up the
risk of requesting the same key multiple times.

The simpler device implementation of only incrementing an internal SPI
counter from 1 until ((1<<31) - 1) and then triggering a rotation
trivially avoids that risk.

But indeed this may complicate partitioning between hosts (or even PFs
and VFs) compared to explicit allocation of an SPI space partition to
each.

