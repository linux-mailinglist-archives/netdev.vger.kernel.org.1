Return-Path: <netdev+bounces-232139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F036C01B2F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5E188AB9E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC28329C44;
	Thu, 23 Oct 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="vG1O0PbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF99328B45
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228980; cv=none; b=LKjeVBJVbczTnPZqy9E7unA/Q8i6G0NibC14HpPS/Lq7HLST8mr57MXHrb+rA7hwZn86TsYjVesjPePrCSiRmyHe0D4udQjooZWz7v/RoZFLWFEJ/y9i5bVlfCYqIKN7QRKeqGFqczG+lR4T/YihBXfwm3hMrPdfULz43ZMBPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228980; c=relaxed/simple;
	bh=8swN7KtuhVvi0TDUEyTegS9asp92L5TDHf58Mq+JiWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gog4L1o5Qvk3C4Amu5Lvgznb3WWJsx0Tx+aNQvpbCjnK5pG/xErr25NE2iLBQwj6FEKzmzZPIs3489oLGnBbkY90Gfu53H1rmAMueE/j0aVjqxAsBb6zWTIuMp0NLTHT2yFZRz0aNjCCe2zbGUn/zxzKQQQEwVf0X9I+TAjZoR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=vG1O0PbX; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso164992866b.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 07:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1761228976; x=1761833776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8swN7KtuhVvi0TDUEyTegS9asp92L5TDHf58Mq+JiWI=;
        b=vG1O0PbX8LUArUQElJfODLqXdty6Tgk0HZmexHGk7o/N7IBNsSoeisXHuTOun9oKE0
         sa7GLKgLYU/9GpdMbQC0e/hTnzJobZ9kakppJY2NpyfJ7HweudKC0Bff93ndi5JjyrTN
         u1+ZdT12Q1yA1E0aefrn2M1UypPgb2pMoMt3fXdc1UK3/Dv6b2cU4Js2VAGVelBjS5qp
         An5I6W1xoaDFdF5XlHp9nejEb/PRWdvZyFKWQv7jpR57Loi7ON9/eSyjCzYIy9zLd0LK
         9F0+W0LNQm7JZ7my4tqkjDQUf9nX0slfjpRmj3KRImz9XyBWUH75edBDBScJGbevRQqX
         rTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228976; x=1761833776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8swN7KtuhVvi0TDUEyTegS9asp92L5TDHf58Mq+JiWI=;
        b=Jtru9wCRydWVL56brRA64YA023Wsn5gcGaO+vKFAbBDrUTGv6WeUO8o7mNSIsI4RwI
         zZ0ilmy8kPcLG0wDNuEbwIISQQ0UiMBYU3OsvnFGaZl2rCPPu6uXYsgGudFrwOG7zCMN
         pot5im8ptnC2U6uGytvAi9c4DIDPVCNEnJlsHA69sw7rlB4cSvRSGHh+tWxC+o6DwIDm
         q2JdJk9OEqBmm938EqeNQSgSKBAIvSCS13zedb99tBtj4IItEjUTrrLsHH/cX6F1a6Er
         CelI++/LYX/kgVAIXfY6KQV1H1r4tjRdG7mVfx/TDA2absyD+XJ9fZuoG0aWIcmYVhMT
         anIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeKhVjLIs4e03bzCUyCaFRjGaKqPf1cmgemdMtRn7WkchClNwymxc4qZByHiQb1yvbZJp/PJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgLqWJT93iKDXrG8HYGYvAUCZRWFVOXPZe88yXoFPVP5mot2y3
	C/d+F9LWznmd4Dk9VA1+FM4Flge2U1fTZV4JzKV6grM9d0w0SChK8vMMAbVmdAvxRa1SMPepC9V
	LzF8IN0As8TppE3LhKSdMxaG8J80Xc34ptRr8f/usczTD6f+IlvxftG9r/w==
X-Gm-Gg: ASbGncts3O25dTQfVYOm0XgqsS5VnN2QZeaBW/dHQXmQVcPAjdS0uuP9eABy089jHKy
	GC2sm0uOR9dtvrsvZzGyip3yb7tN7Woy9QICKKlxzJNSpV5P/uwvYbemcU+Mefy17v5pjWn06ni
	yZ4sAlHXC73HfBafBTS9qz7vWaaAKlPq3p3NJv8XbsC/RmmMZ8sCtxyIURVV2HW0b2IN3RGMxZB
	UD+ZEdXLtgeBHzIoKmdlPtyq/MKsGrJjhCRoUXj/rh8sr9tIkW6oE4O1DQasLIOPHBbSIo=
X-Google-Smtp-Source: AGHT+IGIyGJJ99PeYZlaQ6MjoQmxSRIa3t+ZKNTFQYFm83cua+32nxVpX7AsScchgRt8ap+1Sljt5WrxKURWTnFkyb0=
X-Received: by 2002:a17:907:d06:b0:b43:b740:b35d with SMTP id
 a640c23a62f3a-b6474b36015mr3040615866b.33.1761228976224; Thu, 23 Oct 2025
 07:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021132034.983936-1-robert.marko@sartura.hr> <20251023071259.77076fd4@kernel.org>
In-Reply-To: <20251023071259.77076fd4@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 23 Oct 2025 16:16:03 +0200
X-Gm-Features: AWmQ_bnzDYyVwW4DzdqK0aZTJogqn8ANoiNeNSQ6Cy_USvCaSUqJiUX_t61_3SQ
Message-ID: <CA+HBbNGwAK2PKEA-cY6e0wyjbE3KLWPvoRPbSt4hou_SeJRvMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: micrel: always set shared->phydev for LAN8814
To: Jakub Kicinski <kuba@kernel.org>
Cc: daniel.machon@microchip.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vadim.fedorenko@linux.dev, horatiu.vultur@microchip.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 21 Oct 2025 15:20:26 +0200 Robert Marko wrote:
> > Currently, during the LAN8814 PTP probe shared->phydev is only set if P=
TP
> > clock gets actually set, otherwise the function will return before sett=
ing
> > it.
> >
> > This is an issue as shared->phydev is unconditionally being used when I=
RQ
> > is being handled, especially in lan8814_gpio_process_cap and since it w=
as
> > not set it will cause a NULL pointer exception and crash the kernel.
> >
> > So, simply always set shared->phydev to avoid the NULL pointer exceptio=
n.
> >
> > Fixes: b3f1a08fcf0d ("net: phy: micrel: Add support for PTP_PF_EXTTS fo=
r lan8814")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>
> Hopefully I'm not misunderstanding the situation, but since we're
> considering taking the other patchset via net-next I'll apply
> already this to prevent crashes in net..


That would be great, as Horatiu explained, if PTP_1588_CLOCK is not
enabled in the kernel config
kernel will crash with a NULL pointer exception as soon as the first
interrupt is being handled.

It is not tied to the pending [PATCH net-next v2] net: phy: micrel:
Add support for non-PTP SKUs for lan8814
patch.

Regards,
Robert


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

