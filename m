Return-Path: <netdev+bounces-92618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23498B81E9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F51C21AD9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BED41A38F0;
	Tue, 30 Apr 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haUxRrSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C81A38F7
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512605; cv=none; b=A3JU4w2wEmqbXxfbvhgcUxrB/U7Mei38C8zlXZqOd25E1KnWlCpDpjXtYqW5dx2NU98eeD/cZ0C+xlhhcgT11Gc/2ZntSd3EUOq7Ms7wEVOhqIXG0fmKP77elBJxRC7Wx0AaqyZSO3JTbQc3ijmgEBge6cFMbO2E/IUJFfrZBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512605; c=relaxed/simple;
	bh=/nMcLL52CPmhMWwtSpJT644rotz8VWxnYXyDjqOEdMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzSn8XB9lHn8IwcCTy8j4zTpr0qF3t2oPb5DjYm3+NQ0DXAtUjrmJ8OAjud7QXxJxxUzRIBsEY2pKiIFYOONW8xn9uoB2XySuK3UmrKd/USw36Av0IAevPKDdbMcGLOepk4RpJKrLUyhfIoSPezPJ2QWWfbCQP+m59wln7YeraY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haUxRrSs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ac9b225a91so4925310a91.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714512603; x=1715117403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeBJE2Lsg8IW1WMcSyfQtyWH8n5zhoMbe+vL+PwU74Q=;
        b=haUxRrSsAnTfT4/99aI7JHsISxskHVMQW2KTUyOTQwWqcTNXsjS7lkJdVysnvlMYT/
         xivtiS6NPDHzzaHGEVCE0DiOY4jncgj8PBKwZxgw0ODe8biEGh2N3pyg1qeZISb28lCp
         d6N450o9lUkiips/m9+a6InmFAY5yi98yBEv/xbi+PKoxsQu5EMpoYBl99x6JXEJDdA3
         NMsDCDKmd+1CrwEmPh+a4XpV16MYkhvA6FLwNOzQGmpbIPj1YzQZCmhbEucETTKvgM2d
         b0TF0PnTc0F/taB0OktD85HiRGfRMM4VkSl/hWMSY/cd3wPLI8YPHZklAjF/WmzfKYaf
         SRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512603; x=1715117403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeBJE2Lsg8IW1WMcSyfQtyWH8n5zhoMbe+vL+PwU74Q=;
        b=JrPqaw3x8dtfY1DJXz+GSv/yF+Qs1Z4kWhG/0vBxSa624XpzUVHQvZH3s4efOSos1P
         BnnTb51RCXDpaiRv3XkiCqeuTxIJr4M6KrvRZq/0NK843I+896zDH8BlBa8oDE+M/jpk
         7GoXrKJSGh4ZH/uM7ZIVbxGaxtWKTPtus4FOaXtAWAPit1j0W0GbzK5oZ8Cvah3Ah5uF
         t3VKBNeFBV0GRoyWsID3rLfhmyykiTIub7dbU0ehFl/Hl64cFrLy0scxAqSxWraL58lB
         EQ5fXBVddJ1pQSR+U7DMP4z4s8NhGTGCgwgznjRov0YNe7AxODqJ5dUdlFzYCI4KxfxS
         4aBA==
X-Gm-Message-State: AOJu0Yz5dNwUvVCLyO6zXJy2+rRSQZf+79NO9CzaupLfFonFBCRyJWiA
	vbcAGuhONhS6cxCuc+Jm0+PZ1MCGvaBwDhTAKrdS86yLkd1dX/HTeWy3oiMKW7kY1LPuNC+m1Cs
	qTnLre7VreqW/Nz5X7bfN5qBO3A9aOLYd
X-Google-Smtp-Source: AGHT+IFR3CX8gcO/gio4xoKLNko1TUlMpgusV62PX1zCkXWOlW9ODMTxYiqgzlecP3bGg1VoGsMqnbFdtvfrXZXeIRw=
X-Received: by 2002:a17:90a:ea8e:b0:2b2:1c42:492 with SMTP id
 h14-20020a17090aea8e00b002b21c420492mr707107pjz.22.1714512603256; Tue, 30 Apr
 2024 14:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>
 <ZizS4MlZcIE0KoHq@nanopsycho> <CAFtQo5BxQR56e5PNFQoRXNHOfssPZNdTDMEFpHFVS07FPpKCKg@mail.gmail.com>
 <Zi-Epjj3eiznjEyQ@nanopsycho>
In-Reply-To: <Zi-Epjj3eiznjEyQ@nanopsycho>
From: Shane Miller <gshanemiller6@gmail.com>
Date: Tue, 30 Apr 2024 17:29:26 -0400
Message-ID: <CAFtQo5B5oveWMr9PoUEmFnsbxwjQbxtHDcFpsUg646=Z__fJtw@mail.gmail.com>
Subject: Re: SR-IOV + switchdev + vlan + Mellanox: Cannot ping
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 7:29=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
> Nope. Think of it as another switch inside the NIC that connects VFs and
> uplink port. You have representors that represent the switch port. Each
> representor has counter part VF. You have to configure the forwarding
> between the representor, similar to switch ports. In switch, there is
> also no default forwarding.

The salient phrase is "forward between the representor". You seem to
be saying to forward ARP packets from the uplink port (ieth3 e.g.
the NIC that was virtualized) to a port representer (ieth3r0)? Are those
the correct endpoints?

Second, what UNIX tool do I use to forward? As far as I can tell, the
correct methodology is to first create a bridge:

    ip link add name br0 type bridge
    ip link set br0 up

Then do something (but what?) with bridge fdr add as described
here:

https://www.kernel.org/doc/html/v5.8/networking/switchdev.html#static-fdb-e=
ntries

