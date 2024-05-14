Return-Path: <netdev+bounces-96330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C502C8C51A4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F561C2169F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CAF13AA4F;
	Tue, 14 May 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsi3XaSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582913AA37
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684835; cv=none; b=MDOdm6bRIB8xX1QuQ67In2RfBICue+0jSpZ0gztVqyssHkoRnL4dFO11lBZGIclmdFyyC96KL0+p1QizWgcxmnNaxI4AS7rjVRRhVysjlXmIlNHzmX+hsTJJos4TkhST6QKDXJ/empB4TUjghY0kGwM3WO0bIMMn2oV/+8sH0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684835; c=relaxed/simple;
	bh=m/cF/qaYxxzaqBNtgsoVEJ/OoR9arx8PP+cVAc/fZco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqEspdj9JJEZqNoYg3c403yyvq3lKTmP2B1Bts6Cifuqvwl2lgxCeZ5UUXLlqA8m6eI+qrvnR6plYwVUMyG3EQEg+m8WYp/zv+f0uWFd6z1bQ55GeQfDQVIWgiXggrYg5OoOUvbcddViKJsQ7/yKXwHiXEiYes/hFLkGB8aGC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsi3XaSb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420107286ecso173485e9.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715684832; x=1716289632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/cF/qaYxxzaqBNtgsoVEJ/OoR9arx8PP+cVAc/fZco=;
        b=gsi3XaSbB/OsTIWzGgaQ/oYcBBDjY9eu3KNvcuFckTLWzhLITwJ74Qct8xVm6fEU9H
         9mzvC6fBHach1iI0wOWBv7DfGTgdWVDbxWIDBXTu4UMlSpvRLXgI6/+G3NSwum2JPdOb
         9lMF5JkUryQIdDGCdhvyh2emlMK/1BOmCxiy9V/K3Fp4eUsVuR7/8mjFMOIKdVADmFJV
         JW147EFVUh9ar8hu0LmIAoI2E4qclSD3LYWcFl0mH8qnD83Pz0hyQvqkwzK/iJueN6SI
         4nn2ZfGMk7BpqSTkiYwhqhWYj52Ly/FRd1RhzwW+8N0zFmmnznSnT7JlJPgwjAlY5mag
         RmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715684832; x=1716289632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/cF/qaYxxzaqBNtgsoVEJ/OoR9arx8PP+cVAc/fZco=;
        b=uXrhd3eQdwdX543eMwD1A1PHmZk4S3RSfyJR7x8irYrKMZjlM3GWYoo1+FdtvLHe/l
         E8PH91gGtpVoeX6JAmOSxtK8mZsoOF+DbOWv0CSCAGc4KSQMQgtUkaDF6bhqYYj1UmU1
         34G4j6AZF9u7Q12UAXwFvrO3pyyv5KQp3yWq/qgwOm5bLVaYLTbhn12DZ4WLEHEtqv03
         9wqR5oTZfqko1c1ua5TMM0cAgBzVnecRfCg2c29gChPe3Qs7ZKoVtS41GeFPpwtulLkZ
         GD+W31qbVSgapiSF/IZ7moShiXuP3wpFAoxXs3d7NYtJkhTNGUhmwj9G7q81gYEbx4B/
         3MGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxPbsCLqlfc8vaTrILyiSogXnl9Uqzx2GfZw2Uohtr1emXEyXyUUwz3f5RcbfQsW29Ze32jLelmj35WErc5xWZbgRJJe+h
X-Gm-Message-State: AOJu0YyKgFn3ZGyvD3RzeiE2XFShSyFViDlzfYahiDIfM7RTgQyAHwOV
	Zdy+qs3bR5j15+gWJrxA4xuuX5w7nZDHjfX9lN1RReUaGDJkUVbnEytw/wkJlEAfDfLGSPNg4Wl
	v9GQX2+245iOvfUfP81LkMRC6MOERev/sPqJB
X-Google-Smtp-Source: AGHT+IHju4XW7+GejfegURslgVOp+TGyH+S2ya5uBrNA0CRJr4I5Uqyw0Ya0H20Wg+L/gezfahI1d1y+1hGur6yhpU0=
X-Received: by 2002:a05:600c:a4a:b0:41c:a1b:2476 with SMTP id
 5b1f17b1804b1-4200ee3824fmr6168035e9.6.1715684831378; Tue, 14 May 2024
 04:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com> <d739aa6d-f1e0-45fa-aad8-b4a1da779b30@gmail.com>
In-Reply-To: <d739aa6d-f1e0-45fa-aad8-b4a1da779b30@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 May 2024 13:07:00 +0200
Message-ID: <CANn89iKGRuHpHJwWe3FYB9km2=V5S3g3a_-SxMmf5pkPNCUjeQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: add napi_schedule_prep variant with more
 granular return value
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ken Milmore <ken.milmore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:50=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> For deciding whether to disable device interrupts, drivers may need the
> information whether NAPIF_STATE_DISABLE or NAPIF_STATE_SCHED was set.
> Therefore add a __napi_schedule_prep() which returns -1 in case
> NAPIF_STATE_DISABLE was set.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

net-next is closed.

See my feedback on the other patch.

