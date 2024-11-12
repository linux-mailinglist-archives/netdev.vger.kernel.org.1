Return-Path: <netdev+bounces-144175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBA9C5E86
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E9E283FA3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7E2123EF;
	Tue, 12 Nov 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="lQz6tllB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B120A5CE
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431244; cv=none; b=KrLMTYbqK1ZDypqAfpApmA9nASfgzhCyZW27F8AyNiMQhsBVfCkVw54UHVh5d/tjjj4Nx4v/caJFlUv2mtgn/mv0pqiKhSdfPsNyEzbYHo0qrXvHQ5rd0z04XVKc4RLwGKjlVD6tegjJHjcHTloy8XKYSg05HeOr12cNK7xdJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431244; c=relaxed/simple;
	bh=pjtQiqp/WPtaPB+Seq6kxtxAcQjRYpC6Q/5D6m8tl58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnJt6HMAgtojy5GZo9dKjE7uv/+Qz0w0i6ZT51I5a/gncsbhY/S///Q3wBbvZaEiJPTCMBpPF8mSC4wGrEr08ACdcZycK2hXFW13c0rAnqt5QlmzRRDYtA5r57vfjGrLQIsBgsslOLXAcezdwWLdhqCNQTdtLVkCARu8ZoqLLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=lQz6tllB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso4891754b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731431241; x=1732036041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCsEh3OshPxaXbpGdh/3Hu70pXjiPpoRbcmGEV33j/Q=;
        b=lQz6tllBQhMCd+tiui2/GrpkvZ1OTkZTc0tz1NDyjxIbHBS3c/LTjgJyaD3G1YNgwu
         FIYhypW/z1HhuQDnqZifYhuc8TDFNnhIEoMAnaQ+0CMXMq4s5Sqxtg0LuA5qJfaPLhez
         7KCM0kfceb0COMLKimSuaGQgVGn/m/bKhqx/wUGNLYILJUyEvAWW2fUJEV9KokoH5Tz5
         1TyhlhEPFA2MXRlpHZxH64dx5ukYZ/pDCEyV/+MzKUbiOULxE2c3nh7JfNz6PPzCYxn6
         8Nbd/pDsQImehbZDcPHYVj2GlAGup2O3b/M5YYz8UtgbOQ+ugIQOTLvbn3wGCluLVKpx
         OpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431241; x=1732036041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCsEh3OshPxaXbpGdh/3Hu70pXjiPpoRbcmGEV33j/Q=;
        b=h2X5SaEduu7DUjpgXuZa5hXL9OOE5m11syEwFX/4X+Ijfb/+hZIWzPpIzliyAbxUBV
         6qevV1pAMdmFrLAjy7qPHDLnxASx/7w0+ZGHB2/mXR/6/vM1xJpUi5dHiEMRc67AX1Vk
         8TsRcMiSYeqSrNEyKcqr58OPCait8+WqsB/+bPeSpGMiqrLt57EPzsjidgNPpb09GNwl
         lufjFXEv4KD1109hFHVt+ODesf0LQbuNM8v7h8dMPZLvHK5kBSEYXNJTxvmnfkAxfJvf
         cz5qTBQ7xLtqoswhjBuRlZ0De2H2BCCZA2BCeIvsAIuw/gcYWzA+9cjF4J0r5Xzm3l7D
         rAYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMNArpabxjnHM0BkRHAAcLhq3zOXwtHaEpPu+h836csHR3TLoSYs8M7/Z5hsUlGoMIlCDodg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHez5h3h9bG+I3FiEHgLo4x8re1DBuC0VFUulo8kHnvv8BWPRn
	8BUSobT/FU9bsy74gtR2zw0yqeeFi5/UDK9XX94YqD774InZwHFiut1pEI68EB+VLEGjdPIdLtw
	poKv6sS+bhDmXDRNrYOLKfuKUMGXoEXN8O20M
X-Google-Smtp-Source: AGHT+IEJ3VPShluXTM3fWKH9GntE3CxZDJujTT6jJDBOLP5o9D/6sq6oC2fY+FFPiQ4YpSNRfuDtl0Fy09Wz7P9R/DU=
X-Received: by 2002:a05:6a00:887:b0:71e:6122:5919 with SMTP id
 d2e1a72fcca58-7241335bd23mr22008354b3a.20.1731431241054; Tue, 12 Nov 2024
 09:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108141159.305966-1-alexandre.ferrieux@orange.com>
 <CAM0EoMn+7tntXK10eT5twh6Bc62Gx2tE+3beVY99h6EMnFs6AQ@mail.gmail.com>
 <20241111102632.74573faa@kernel.org> <CAM0EoMk=1dsi1C02si9MV_E-wX5hu01bi5yTfyMmL9i2FLys1g@mail.gmail.com>
 <20241112071822.1a6f3c9a@kernel.org>
In-Reply-To: <20241112071822.1a6f3c9a@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 12 Nov 2024 12:07:10 -0500
Message-ID: <CAM0EoMkQUqpkGJADfYUupp5zP7vZdd7=4MVo5TTJbWqEYDkq7g@mail.gmail.com>
Subject: Re: [PATCH net v6] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	alexandre.ferrieux@orange.com, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 12 Nov 2024 07:23:29 -0500 Jamal Hadi Salim wrote:
> > > Separate patch - okay, but why are you asking people to send the test=
s
> > > to net-next? These sort of requests lead people to try to run
> > > linux-next tests on stable trees.
> >
> > AFAIK, those are the rules.
>
> Do you have more info, or this is more of a "your understanding" thing?
> E.g. rules for which subsystem? are they specified somewhere?

More "tribal knowledge" than written scripture onn networking subsystem.
Over time i have seen pushback from people of that nature and have
always followed that rule.

> I'm used to merging the fix with the selftest, two minor reasons pro:
>  - less burden on submitter
>  - backporters can see and use the test to validate, immediately
> con:
>  - higher risk of conflicts, but that's my problem (we really need to
>    alpha-sort the makefiles, sigh)

Sounds sensible to me - would help to burn it into scripture.

cheers,
jamal

