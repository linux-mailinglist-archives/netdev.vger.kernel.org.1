Return-Path: <netdev+bounces-144077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B454E9C583B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC68B235B0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B75F1F778A;
	Tue, 12 Nov 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IU5UoRao"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABE39FCE
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414223; cv=none; b=PG7YKCAp+2vPYzvlBUxvB1IhGLlKkkd9OnKxsLSiA2tFqCAMwY+0ka/+jVOVlh2/a0Jt5k4efi71evunHdhvZWX6CZb1dMM758oJ/udXQlMXn0LmKi2H34AI9yQ7Gc9yM8dMzYXBwQt38BnbwMPfceF4xDpcAaO3UirFz/y0CJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414223; c=relaxed/simple;
	bh=kH1BRaqpKKJdbyQ+vNIlLrJFqxgQWkg0jLphTu3YoWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhAgKHS67YJlVm1YTa5BKSq4kXpQGefRmelejH4S/67eA5ZNZSQERwe0QTVZXn0P1lpsjIBC3fGJtA7RbCbO/YFVpaknMMFQW6y/hYBon5So/+JjpsjLF49IWZvn5KXR9+Zvo4Ui5gelx5Ez4NaZw53AmizR2shc8FrKG4/3Cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IU5UoRao; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so4449005a91.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731414220; x=1732019020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH1BRaqpKKJdbyQ+vNIlLrJFqxgQWkg0jLphTu3YoWU=;
        b=IU5UoRaoldlDDsWwTv9z1whPDZzdIQ5AiGdTOOqQPj2y0pGd4RfDrCWOaMQftLcHwY
         b0VsYsbklHpKSwoEqXwRA+7K8raVwrvdyq+04Q0uVhKKXPMDB41B5SCYg2TULuBPENul
         qoWZY4zZFijYLbsk5AjhER/pMq9JRllKkXuZ8ElM4/Ax4SV6K5UH3X615k/XDU/PdDOY
         TwZCaG0v/nIKSzAr/LQ2+jEHTahhTyoO48hQLoW7r4Sy8dpMl3+bk37EPVHoetHWDMnB
         pkPlanUjzRje95WutEFeSZSCYHSmLwUdeMjbvYTRU7Vg0GCMJQ+9OnLzG9lEFPG6IewH
         FyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731414220; x=1732019020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kH1BRaqpKKJdbyQ+vNIlLrJFqxgQWkg0jLphTu3YoWU=;
        b=XXVb7Sb7a61ribCs2oxDfczzaHAOyr1NEgm7uT10840K21vBi97adbCWJOS8a+tMXM
         PYqTiH22/HQW0lj0b6SbzH94XEIuzLUjo05IHfrr+71ftHlnx1yZgbFv/RiYwF732ZDL
         jKtm30B4ENGsVna0meXbKnbf37ba9ncFRScb/50ZQBv5Zb2Y18JjnnL1VENQPFtcay8g
         +nFF+EQ7Ga9BFHuShjlQ2thK07zKih+J6TlgIAVm+ND76fSLz0TCirK3TdMJ6hmLadyz
         JMtvra72TMDtebgUw62qVr9dJFm0ViNjZDRbCKiDWYufcakA0RS1OlkXRRj1IoBh1uTO
         0bLA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8/pXxPzlrh6sDjIK55eQG0HNjRUGQthP0W+irbOq/WudifNhVU3sDKWZOhxw3SbFJjNVPcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEUPoohCQRGdFgNPRBcDVtfkS+Eto1km8eHSb8xQmrSPndBr/
	WiKfjWhKBcpmgKzUlfxWzfUAIArjoorpMw24yuPQdS/hBZY5NOIqLuizvUjM9Vf7VD34rYu5iHi
	KjMD1GZrSakgRuilbafkUv83szx3HeAFwJ3wYpM5qHsXP5Pk=
X-Google-Smtp-Source: AGHT+IG9P9o1GCfAvE15JqZHBtv6fuVkrohpKJfN2tMUYcLadKcBuSum1ZXkGkzECROQkUHzdsoHhH9slDa9lJLIez8=
X-Received: by 2002:a17:90b:2b8e:b0:2e2:b69c:2a9 with SMTP id
 98e67ed59e1d1-2e9b1770362mr21828421a91.26.1731414219947; Tue, 12 Nov 2024
 04:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
 <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com> <20241111102632.74573faa@kernel.org>
In-Reply-To: <20241111102632.74573faa@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 12 Nov 2024 07:23:29 -0500
Message-ID: <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	alexandre.ferrieux@orange.com, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 9 Nov 2024 07:50:53 -0500 Jamal Hadi Salim wrote:
> > Please split the test into a separate patch targeting net-next.
>
> Separate patch - okay, but why are you asking people to send the tests
> to net-next? These sort of requests lead people to try to run
> linux-next tests on stable trees.

AFAIK, those are the rules.
The test case is not a fix therefore cant go to -net.
You wait until the fix shows up in net-next then you push the test
case into net-next.
I should have clarified to Alexandre the "wait until the fix shows up
in net-next" part.

cheers,
jamal

