Return-Path: <netdev+bounces-201865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E547AEB46C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC56C1636E0
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870AE29C32C;
	Fri, 27 Jun 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VE8XFQX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295B299AB1
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019581; cv=none; b=dbfxsCHapxOrvyhEzUuKmfoH2pYLzC5uApnEicPXI4YDIbhNX7v51YAeVd0Y6OE/Fw3nsbpHUNGg2zMhyh6Wa9cnuexspEedoKYhrqQYTG33kYXufbxNbESjefI43ya7pObdFOlcLZp8O1tp2J8GR/bE5+1TLy2X4aiSxz70sqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019581; c=relaxed/simple;
	bh=VT0SNElymWMyAmHo/BlHqxqUjs2SuhiKv/mBEoBfRe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy2i2BkLCz3wDkdGhGGMROSIU8p76PC6L3LR/1QZMg89b8wbgBPePfzXY7IswHTme+zsYGP9iko21mXQUcNJIWwxRNIhte5txq8ZiD5odh/LfqSjDdB/VJ1XWM34dm9z2CYlgf0xVv9BewHW29Dp56XADKzciG6upF9mo4MdKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VE8XFQX/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d2107eb668so321030585a.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751019578; x=1751624378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W27Bdrl+lJBvU0tDOv/G18DYor/BrpM+MFHb+g+6E4=;
        b=VE8XFQX/75BtcYLSXterYAbvaupMBVdsEtiy+6rsAxuZLiTeV0nA+h9UZlX90WfMKS
         jYGfCy2Y/zUXLAlaGPtsEWTlIoN/Z+7VB6wDxhc8sKNrvuq4mfX9LvwTmWWirdLOUN3P
         /vwW63jaJim6e0wCwhWEtamdy/pp0Y1QmuWcEVrxfyMIljRQivBaheScYddXYVQ0wAkl
         aZ92NcQGLbFuCywwRSJSejXc9VA3fVBWFadwOLFsQiw/s2LFyUZJPb8xC2r+VA/EAwhB
         4zjI+/Vf06k5/xbZs+Y3GMCNLzsYuCFixAzXhzUcvWxjdE/H+bTwY8N9S2pLDGpmIMj7
         6QOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751019578; x=1751624378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W27Bdrl+lJBvU0tDOv/G18DYor/BrpM+MFHb+g+6E4=;
        b=jhtgQLoCU/c5ElStnm05uynaGOKHdeoViPLQxg209BMB/mTaQ9E1grZEX6G7Y0EPR0
         moAomUG1Ne60Noznrl3rjKkh2H223Hp3ikHE0AqXj4LMJCNBoJ0iDiYa0ofOUceFbMcj
         xvpPzkbE3RPktJH77ZqaSC3fnlLvOap59s8PO2aiiUF1g7IpEr0qXk2aczgGHIrLH/bx
         I9wWH5rWyA6EVrqsvhC5kguqmrfJLiGhPPPP0vVriW/kghkasWjHy4+zAVCJWT2tmvS4
         cFVw2LZNvtWnBujz6InHRTw8EC41F/iog6aVcI5tBFpnDkE1yBMHUPCEyI9AFRqHZ8sc
         RNCA==
X-Forwarded-Encrypted: i=1; AJvYcCW2f6F+4VndK5YsF4InRqedOJZoFGIZrjjmFuW3PZ1ZQ9VdKb/wwaqkzixxet2M1PFzr8tzZHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyso/lG3tvgZwtSRItaTzfxiayj9B6Lb0U8c0DnlKBPJp37y29u
	tKbUxEWCWpV1dwE3/dI12xIUNtYclacQZCDKmxeXdaO+W05tE7nUNmWxyVBOYB1wOFNawkEUDTP
	9JRUt6MniaEDY/oIFFi94BsRqIJW3maMuWdQ8M4fX
X-Gm-Gg: ASbGncvcW/zuWTZP5x+zGwbDqvvw++RCM8DoF91D/lfUv7M6v4FJAGmHPeIAEtV+QcI
	5Yjq0tU7bPcY6hhtXeYV7vdJNig8tNLxgJFjW4DBJxjmg8ryWjAGBxSuvFmmX8XOnZOurEICmo6
	ha/gwDwpOBUMfvZjhNVGyii3uNlQ0XOusg7QMdzMN2Og==
X-Google-Smtp-Source: AGHT+IGhssF/7OwJw+s/lmqvSRhKlybAUXJRtUQ5h6FWADwBZyzZMTJ8Pf6cmRE/TiIyagH7u4kAOPO7J2gAwcqURbc=
X-Received: by 2002:a05:620a:3624:b0:7d4:219:50d4 with SMTP id
 af79cd13be357-7d443992b74mr269767885a.34.1751019578183; Fri, 27 Jun 2025
 03:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627094406.100919-1-yangfeng59949@163.com>
In-Reply-To: <20250627094406.100919-1-yangfeng59949@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Jun 2025 03:19:27 -0700
X-Gm-Features: Ac12FXw-auM3OX9rpgkyk_nstk8T5gkiOxE7Zr8Bgud1mZDhXjqhjvhmZDAmdJ4
Message-ID: <CANn89i+JziB6-WTqyK47=Otn8i6jShTz=kzTJbJdJgC0=Kfw6A@mail.gmail.com>
Subject: Re: [PATCH v2] skbuff: Improve the sending efficiency of __skb_send_sock
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, almasrymina@google.com, kerneljasonxing@gmail.com, 
	ebiggers@google.com, asml.silence@gmail.com, aleksander.lobakin@intel.com, 
	stfomichev@gmail.com, yangfeng@kylinos.cn, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 2:44=E2=80=AFAM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> By aggregating skb data into a bvec array for transmission, when using so=
ckmap to forward large packets,
> what previously required multiple transmissions now only needs a single t=
ransmission, which significantly enhances performance.
> For small packets, the performance remains comparable to the original lev=
el.
>
> When using sockmap for forwarding, the average latency for different pack=
et sizes
> after sending 10,000 packets is as follows:
> size    old(us)         new(us)
> 512     56              55
> 1472    58              58
> 1600    106             79
> 3000    145             108
> 5000    182             123
>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Instead of changing everything, have you tried strategically adding
MSG_MORE in this function ?

