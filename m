Return-Path: <netdev+bounces-193754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40207AC5B6B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 22:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C2E1BC0938
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771920A5DD;
	Tue, 27 May 2025 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxowmldE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5B156CA;
	Tue, 27 May 2025 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378238; cv=none; b=GfwcanW1qd+kKmMufo5/eodBaAz0YQt1vY7DTi5+zWVMC0nbNdmDMuJJz1wNvVgBK/FbR5M7/uRGo5TgnoRUQdz+Vr0Ygyg/5ppJDlqZCE/U3b4sltgTltkjtulPDILPjf5IEqu3Dg/s3m+I3i2IMXcyverKYWI+bW/nTpIhByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378238; c=relaxed/simple;
	bh=6ID6k8G/m1AUKE94pO2jDeI/QTg83jtJQKI9yRG0MB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxV7b2B/vnDHpdG1qNDC95Ht/kH82W3YWopGSz2ulqVWuXMb4Kd61Alv6S9bGpaijPLwm55QITGYnhK3YJY+P9uD5wDkhR3LuCGyjejIKThaJi1n065I5cKonWvRvUbIb5jUHamq0Vv4NiW6Z4u2ZI1Hz1q6A4sznISiko6d3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxowmldE; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87de47585acso2465256241.3;
        Tue, 27 May 2025 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748378236; x=1748983036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ID6k8G/m1AUKE94pO2jDeI/QTg83jtJQKI9yRG0MB4=;
        b=kxowmldENXwSlCuYH8gwmCEFdwWVcYK9cKuPP1RRs1ZJ6QSX9vkA1MZAdM+krpjvNE
         twWAzpS4cwPaEJvnAvX10citzLV/GVMw1BH1HpZB+FwCYEjRcd/65YpCHgTdHZSuVAkK
         QuldWrG/7mHK9SU51fBxAtUn/L0fHxC1vH+c2BX/VRhnvwM4YYIBF8vgarycru03gzwG
         MpGN8qXEt1ntk7ZJSKsMQkMEvWmXegEOr+K4ChlSQY4MzCSOU4Y/aNBAEigp344XjUa9
         FyTAPp5IyJWRFJ/rgVmUa8LJNI7UcS5aaA8KnxqNtCFWp/yiPWtN4QCubEeyv3NEY0s8
         0RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748378236; x=1748983036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ID6k8G/m1AUKE94pO2jDeI/QTg83jtJQKI9yRG0MB4=;
        b=Xqy30kgJdu1CBYRcs4IDwnPnal/QoXRZK4dGUZBiL5UW0/BTxy+JBSbXljVRsMXV3U
         UHsMhQeudRrcJujfutzZMu+lX6GUomf+UyiKmeIGT3ooD2RheujcdfNOLZjZE5GB0lWo
         Ey0PsB3zWknibR3bH/Bg5oTB29IIzKRUe+MCKQQMyyaxcOVwome1HLQ7PHHi5J2hIW2z
         ggHjg0g4na9pcytxnGGC0DrfoWbtsuXD51MCac/wdy7tZMiKwhAlsH54F/5G7Gxmndbq
         9o7NdIe53+71ppWjKLPVUMgRBYnS4KJI2qddjLgSJsvfSc2gllrEQdA6D/mDCkZ3NVdX
         /jRA==
X-Forwarded-Encrypted: i=1; AJvYcCXb3ig7iTOSh1SwYysk3ww/T6nvOQB8qOEvPiZ46Gha/zZZflE7Wtk34SQxpTCAmwAR5rm42B5a4X7R5lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVkCy+ajLBAigjd0j/UAyWaGU1SKqpEgUCjsEts8T1ZoXAx5Q
	9ac1u1b/UAOps2LvG9oxmeD9tAdkxiH6WrffvT4SJjEvupc3jyw9MIT2hKpmH4TX1FsEfcwuLcp
	tqkms5u+jTabqCk+gVYXaeP6Tw9QCFMg=
X-Gm-Gg: ASbGncvDPKCU8aLyFe7MMfrVyK+mX8dP/IP4P/9oyMg330LVD7Jcd5tYoRexwrDk6fX
	kKhOUL2DcbRP9lw/bcnz1IuopalFF6tSdNE/igFWuRp89NcG0FKeaoT7GTmznAVoqnW0r92Jtsi
	Tt6pGFeXr+n+TEowqqNn7i4OKbz5gmDu23aQ==
X-Google-Smtp-Source: AGHT+IE6IGadDKaQe14cmUEPJjOThWelmyPbRkm0rWeExh7Z+iiuaCMzGmZ+bOotchpiLT4AwMawTY9UCWRMvMcye3A=
X-Received: by 2002:a05:6102:cd1:b0:4e2:91ce:8cad with SMTP id
 ada2fe7eead31-4e4241911f0mr12890455137.24.1748378235982; Tue, 27 May 2025
 13:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527175558.2738342-1-james.hilliard1@gmail.com>
 <631ed4fe-f28a-443b-922b-7f41c20f31f3@lunn.ch> <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch> <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch>
In-Reply-To: <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 May 2025 14:37:03 -0600
X-Gm-Features: AX0GCFsHvzxiinsPSv0WqpWYNJug5PA_MZLWR3SDuULgtlfcH0M8oGfitOEajfo
Message-ID: <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Furong Xu <0x1207@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 2:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Sure, that may make sense to do as well, but I still don't see
> > how that impacts the need to runtime select the PHY which
> > is configured for the correct MFD.
>
> If you know what variant you have, you only include the one PHY you
> actually have, and phy-handle points to it, just as normal. No runtime
> selection.

Oh, so here's the issue, we have both PHY variants, older hardware
generally has AC200 PHY's while newer ships AC300 PHY's, but
when I surveyed our deployed hardware using these boards many
systems of similar age would randomly mix AC200 and AC300 PHY's.

It appears there was a fairly long transition period where both variants
were being shipped.

