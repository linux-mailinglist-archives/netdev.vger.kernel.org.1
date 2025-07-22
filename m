Return-Path: <netdev+bounces-208967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0994B0DC23
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A0C18885C2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F72EA478;
	Tue, 22 Jul 2025 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyasHfEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3A230D0E;
	Tue, 22 Jul 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192575; cv=none; b=LYvekB7NoLXtZNHBsKX89kTEOpqqsBjzAiOs3+PDl2UEHRWp4oiZ8/HUUTQfxHwxhzOpZJhd0TtzbBySil/LaC0ehpeaVsyOzqGPRImDq9wFuxIY+IdkJxsQ0oPgsFj7FLT1NUrHlzQT1iiXmLyiiA93MuKMEbJGHvAjv1Eg1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192575; c=relaxed/simple;
	bh=DhzF5l7I2J9PMPvJauS2hdz6oE81hLeHaGvhhBQ0rcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFzhVnoy1cyw/B6SkUkNjcskSMWgNrBJ1QvJYhSu7twUA7P+I9gMMEk6cca7xNSgpTEUK/2ox2KqMZUDPL3+PpOqMcDZgzGxChB2u7TlP6m4gNqXmGrQqsDxvtAU8djZhv4k0lRDW25rQk81BfA6DhFVxw1yimO4UHm0KenIC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyasHfEo; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e810dc03bso788102a34.3;
        Tue, 22 Jul 2025 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753192573; x=1753797373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Cx7Gr4DreWZzf57vT5GiVKqhh9yn9qywfvm6GXChIo=;
        b=QyasHfEoniwNEZ/WZ4vEw+Yb5U0nuMBSUDVmwr7UvuS41TC4Mhh1NNszvoPHXmC53Q
         ThxBUmXiOVCZTL4et0DFG8YLBBzw9Akj/bglpTm50//woDIOp3S2QwURUv9PZAIk2A9P
         ZjdTw0RarJNiJmjoZqaC1Ms6BwTTKAezHepe+L7gE06BjAtuiisxyXBJgwvGWRiFJJ1m
         E0LpGf2cMvEUVqc3SinfIjk4cOjqUAO4nLX4vj/4KuYKADG2UXoSZFApS0WmtxIq3uBT
         hxz7xekUOzpGXK28R0xC0wWcEOiR8kQbo+Br63K188O8/hmuL4qC8f4hZoJAjdIznIuS
         o0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192573; x=1753797373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Cx7Gr4DreWZzf57vT5GiVKqhh9yn9qywfvm6GXChIo=;
        b=QqyUGzpHKo+P0RFkrC0Nixn6p4Hv2dreqM/6MGE08/QBGb9ojGnXLTjst8u3JRLXxa
         jS9oHRjuN9LR529ijh1FzDpcOVz6XIkMZW3uigbhVlXBder6v75MagLG12xP/MDPCgS1
         jakuuQg/vYt7MBX+CDjLED5ooG4xDHTnCY35Iem5Tka58x4Bzb6Foupqr8PuaY+/MTZ3
         qwlZrOJWEfgCIkrtGMUoMm6UM81SpbCxVIqC+9GMKibAASQyJZTYCn0VTYh0h3pYpKqM
         we6wIORzNyKIWzLrPXOAP/xSp4Wvi47uvEc9KR/M9L33jer765+8YdRQbKamI+zFEo6g
         VwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipxcBZW6T9RUeesb949bPbaqYoLqi2O4kwBa9pWDitPVmn+VH+fREWdInX0lhI0JAXew/fTD8@vger.kernel.org, AJvYcCX2Qeo+DM6O06/V0sG6qmZJpKbjoCRkZNhDyrahcYGyPOEK2nLRsWMYe2fLmlbIFCoGzTj7w85UQjuNhr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0BIRTkGYU+VSUnmgL64G6dlNMIW65Aa6MrZaWjzI5n514rjg
	XBNoAMp4a4kr1hWhbzukwdloXDBG0zqhlkGCGQaxzmxuTRLaOg+SAtmnMchaLyD6EFX6ne0tFsA
	igi01CvBNjUSulP93pFgjdGQsDT7k1t4=
X-Gm-Gg: ASbGncsFc+632p1Tj281BuIv/o0aGBRt7A1G5DtUjntCZgOBV7HpKJ1tQLRc5LnvA6x
	8AgW2yHqBMttm/oEufa30Y406R5x6/eHs+u4CRW2erTG2Jx5Kz2VSYVfs5BFqZ4AB1fEHI1jHsB
	Bpc2PxvIA5rXiEWQcK85qLl6yWzeRAswZ/BONuw/OOCmZEmvPdEZKZHJcGb8cROLY4bthzdLe6J
	R89mjOS
X-Google-Smtp-Source: AGHT+IFNCuAiMFBJ+qLVy6zUGnB/dKh48G/ViCbOJGiiFqe/aDQhU/3ZxV4HrZVa0+3fH4m9NVoCspjXq3ql+dJ3ppY=
X-Received: by 2002:a05:6830:4d95:b0:73e:93a2:3ab1 with SMTP id
 46e09a7af769-73e93a2430bmr8842207a34.18.1753192573261; Tue, 22 Jul 2025
 06:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071508.12497-1-suchitkarunakaran@gmail.com> <20250722063659.3a439879@kernel.org>
In-Reply-To: <20250722063659.3a439879@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 22 Jul 2025 19:26:01 +0530
X-Gm-Features: Ac12FXwq_HIr-ERaVbidZeD0S6zF25cECaoEambmLTcpXNj5Hl8y43qwAqmpj3Q
Message-ID: <CAO9wTFhghrrzH2ysTiBqNrZ1dbb001Y6rWYiKRTC2R8PBm-Zog@mail.gmail.com>
Subject: Re: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 at 19:07, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 22 Jul 2025 12:45:08 +0530 Suchit Karunakaran wrote:
> > +             while (i >=3D 0) {
> > +                     qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
> > +                     i--;
>
> i is unsigned, this loop will never end
> --
> pw-bot: cr

Hi Jakub,
I'm sorry for the oversight. I'll send a v2 patch shortly to fix it.
In the meantime, could you please give me some insights on testing
this change? Also, apart from the unsigned int blunder, does the
overall approach look reasonable? I=E2=80=99d be grateful for any suggestio=
ns
or comments. Thank you.

