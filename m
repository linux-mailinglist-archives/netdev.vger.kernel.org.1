Return-Path: <netdev+bounces-169758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E7A459E2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F563AB9D3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C891DC997;
	Wed, 26 Feb 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYrz9dkK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB8017F7
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561855; cv=none; b=HyRrd9YoG+brDlf69RX6BA7jMxwniaXB9NYmJCzgWykpy190EJtyeoju1PC+5vnfYOfQHb/JAhkTHSA0vuyMgY/BJdULvT44u6OLZmw9pu3ZPT5tJ0aMThY/4kn5yAHE3zlmyElwm01yTvK/EhjqBiN2C4DfJ83WauuveVQ6o4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561855; c=relaxed/simple;
	bh=nU61OwGTFXCZvdDVmhJ6WEVErE8fmVERbyw/HXcxy0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKpK+OW/RQ73l0gUBTj815dgnRnfFRrSnl5c6AEsa6372MR5wQjRQMUzMobcYbJj1WbX89lVwV12M/IJ53sY2Y/lv8oUeobIQPQFWEB7178j4wCinBnr71GeddeP7ueTQe9qYmekJM0rFRTp2LBrlRlE5MFsSZJQb5qWP2qFyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYrz9dkK; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1933710241.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740561853; x=1741166653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU61OwGTFXCZvdDVmhJ6WEVErE8fmVERbyw/HXcxy0E=;
        b=ZYrz9dkKpqI+QG9l7ajh23SwSvWNVga6+CNuuutxEvogTbnaRNnjPHpRV4EZQbAye8
         f/hB1PwljJ78bhmpTb19Scyw21bAPjcNI6j5I/EPQ5CD/2i+366njEVjckCSbnlQFsSw
         RU5rbQohT9U2ioDCEkQVQTigTM+IImsGVfeXghScKyJI5TfsCSUaYcGtXZCnWV4h4oup
         NxnMTe+WBPoNAPNBzEPLfwQ0in3zUSrJWDoZ2oxa61Jxs1fgT7TNzTRAHp/hGol3sNRR
         3HyM0HSUzckMPKry1Z1HOK841NCgBnRgSMuBW6gRjkxslPOhyUfeuydB23KCFLCR5WpL
         8L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740561853; x=1741166653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU61OwGTFXCZvdDVmhJ6WEVErE8fmVERbyw/HXcxy0E=;
        b=suEo8gdIsNgVzr3aWkbWtrDbxzhxHu2+xv62gH3nlDYK8uzpJiP06l4syawlCOnTn8
         2R5odanxIJjAaOx3IjMyoYu03XFd1hY4xQC4flDWdRnHihOIEo1ADK/o1PCWbunf777d
         PDKf7O7g3BlM1CtJY73VKdeiRbiblyWwiIP0w2CJ6E4RM3lz+1pLJihgUIDQvmAntlEf
         RmaMRa7+ZVKikGxvOGGfdUw6Cw+3KFbkPzAaR32R1kO6Y89gh1gNikbXd77SqXcSEVnz
         +UaptzTQcw41UnWo/+gtkKuPmbh+q15S5Rx4rBGlUFIwHoNAtWYsP9Y0aYAIH0nDlZaM
         qbdQ==
X-Gm-Message-State: AOJu0YzYuIQ97GYN1r4Y31lO4t8XXrjIsyPaRvuhTayLt4OfuC8VzE/I
	avZC3lMDq2IpG8sXg4faF1A2WfyEZ0FfwfDEgJJLY4zql9GiV2WCRcPf1Fd9Tbjpp5LOdL+egq0
	qF+1k8IEuHX+0apQQoKQCwpcrjDJSTg==
X-Gm-Gg: ASbGncv6V6/r3RonlSE8ufBoUPQ0b9UACg5xQQevN3HHdR1Bmv9GJ/U/8f3G1whoU1K
	vRNx/Gget4utP6tO7oaojd26RFR4/cbDxWiwBS2gBXQEX45mNPO7nN92E9GhV8L+VmYORY5dDku
	MEYf1pZQ==
X-Google-Smtp-Source: AGHT+IHsSRcEFX3BB9H9y2lGuhYeojYKZOjN1TgBl4dYo2xQhkXbUkk4NgmKRd3bP2k5tUoz1bOlKY37bsJpY9wqNoQ=
X-Received: by 2002:a05:6122:4286:b0:516:240b:58ff with SMTP id
 71dfb90a1353d-5223cc120b2mr3547547e0c.5.1740561853123; Wed, 26 Feb 2025
 01:24:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com> <20250225170545.315d896c@kernel.org>
In-Reply-To: <20250225170545.315d896c@kernel.org>
From: Ian Kumlien <ian.kumlien@gmail.com>
Date: Wed, 26 Feb 2025 10:24:01 +0100
X-Gm-Features: AQ5f1Jqt9X_nRfJT9SD5gJPqfOzsj2oKoD6eFhDmALP_iudBlTgNJ16RyGCnZBc
Message-ID: <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
> > Same thing happens in 6.13.4, FYI
>
> Could you do a minor bisection? Does it not happen with 6.11?
> Nothing jumps out at quick look.

I have to admint that i haven't been tracking it too closely until it
turned out to be an issue
(makes network traffic over wireguard, through that node very slow)

But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bisect tho=
ugh
(it's a gw to reach a internal server network in the basement, so not
the best setup for this)

