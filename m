Return-Path: <netdev+bounces-122026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC495F9A8
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87B91F2113A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45551990C1;
	Mon, 26 Aug 2024 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTZ0ApyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB45644E;
	Mon, 26 Aug 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700403; cv=none; b=t695FNQwv08F2Yng13fgZADIcHDIqxK6WUAbJwhqDtI3WxzSX1MVl0Hcdm2aaAIQuNIpgCv+k19NgSXC4i3kUpXYkBHykyGD46xatmBdicKs0i1/HqOqfyV3HTS4g2hqut4mp7FIwXxJoX5kMqZeIxC91uZYEGcElfyIi3gp9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700403; c=relaxed/simple;
	bh=65uliSN1zlkrMTiXhmK7z4yAYkwnC22ywBlZurdhwgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3WeDDNrBTYwQN9BM0THeS3EoV3qZK695BU7wW2lyZevG33aT5wEHNtXSKEPzdZcRvJVm2WuSfmErwHOnMGt+vyPYqIaybKiW+pRYoJuAkOSiHrE5n2jN5PLWp22Wc+XJXh/crmI97NDpYPR7viVseEl4h0+qIiTmNbTbL1Tg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTZ0ApyF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-68518bc1407so50980407b3.2;
        Mon, 26 Aug 2024 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724700401; x=1725305201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxQngEcaD1uDUqWEjjVUhX6wDvJFx9V15Q1uV7a0Z+M=;
        b=GTZ0ApyFbbqGip+8Ej3Hrs39rh+Zt3BIM5D0b4EF6s4DMrMvyOWqU8FVdkLl5GHmF0
         +RNXnZpV4wcuavRnhBV/sIDXDjZHfwa7F2eTsakkHVwmr07dgxnDK4vUrk75X2U5gInX
         my65s4nm0w1Ck/FociPHU6zKoZyFlv5vq7tUyGwUxvBv2JFQElYYqXGEERonEQGb5+tN
         qVdi5IssNhx56CbJj/69GRoJgQZioSlJST8VVUze/IP1Xf6ELCkdZwkbetxk/4u9A/li
         qdKT/pqWWRNJ1/DYxAlmSuwdU6P1JPCSmD6kgInqTUxA5o/kShICkudBUi0oTFh0sK7g
         LQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724700401; x=1725305201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxQngEcaD1uDUqWEjjVUhX6wDvJFx9V15Q1uV7a0Z+M=;
        b=H3LHVt8gMvpS2Pfe6nAxxJKUusCmhLSB13oR69cV7Cyjmpv88lz0bL06bIGH7QVYTO
         1++MyRYH0CR/0zewsu0LAWMPLykbCDh0DwbzZQKibOXd0Q2PV/lpSbFTu1FWcCGt4r0N
         Book6SD3laLIde0myLyp/PzqvoNLQmpe8aseS7ql27lFhOgphVy1Z0HU1HftnK8gvsfx
         jk7eyohoizQRj+1Zne6Oar1i/bLq1uLsenz/TZoi5Aj3AdCSq5pHcR9sL16Hk/YV9iNz
         fUShPqs+FLUhB9eljcOZWkZZ77xzSyOJ/9rJ/bm589zCGxG4DaLjHalf/ur5jUPFPtD4
         wOjg==
X-Forwarded-Encrypted: i=1; AJvYcCXFCZATVXoo6SrRs+TYoXUdU8cGyZ28e9IMgvwIwojEE24TzjiiN4l80yEiMoa9mY3wgDmyqlOrqekhiF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrK3+ANXqtgLtLus0A9Wl5SacGFEq/aKJBLCPTHbL2o2y9ctjl
	Z7CBgnBP+ZbiahFzS3SsBW9k9ll60nMvo02AMgmeraA1sDk1KvZ4ZjlAkb9Kox81xEnR8qLO5Uh
	HIkbTa6dDk3naV4dYg4RDkJt8Ro0=
X-Google-Smtp-Source: AGHT+IFaXQbs3L/nshET3XSprfnpEcdgcpZYh2Be9M6/9EH+LPGmPkRNnFfZMlaUL99tq84ExQ1/3twtnVdIUXAb4Qs=
X-Received: by 2002:a05:690c:6603:b0:6b3:a6ff:768e with SMTP id
 00721157ae682-6c61f1b925cmr138425357b3.0.1724700401414; Mon, 26 Aug 2024
 12:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824181908.122369-1-rosenp@gmail.com> <20240826095900.0f8f8c89@kernel.org>
In-Reply-To: <20240826095900.0f8f8c89@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 26 Aug 2024 12:26:30 -0700
Message-ID: <CAKxU2N8wJkw2zZXkvAF1SOt+La5Kcqyk7f2s+S-JhgMdfNLjQA@mail.gmail.com>
Subject: Re: [PATCHv3 net-next] net: ag71xx: get reset control using devm api
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, 
	o.rempel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 9:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 24 Aug 2024 11:18:56 -0700 Rosen Penev wrote:
> > -     struct reset_control *mdio_reset;
> >       struct clk *clk_mdio;
> >  };
>
> If you send multiple patches which depend on each other they must be
> part of one series. I'll apply the clk_eth patch shortly but you gotta
> resend this one, our CI couldn't apply and test it.
Isn't the CI x86 only?
> --
> pw-bot: cr
>

