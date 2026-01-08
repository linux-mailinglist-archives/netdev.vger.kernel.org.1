Return-Path: <netdev+bounces-248088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B07D03ACF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4097308F157
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFC53A1CFF;
	Thu,  8 Jan 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk/0VyX7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2D350299
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880046; cv=none; b=jGr2Z8xlMI08+Jy1QQqPGFePkH2+IDuia9ogSbnOFZ6K4N/1AbIM83KRY7IfaShbeZ1MYPiUO9o5PY5P1qe7mQsddFzoxl6X7Om1jsXi+ocKRbJodkibsnfR0fclGwqufhmvyR9SFl4D3zIJaRddU5brQ8j7n0ATf913e/G2yog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880046; c=relaxed/simple;
	bh=AsTBs1zplB9PE0EemI+IzF5HTdMDYfpXC1Vio8/7U1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYct/zlmMIgEFoyBuJX6E98XUhcKK+0Bw8BBSVUWRLwo38PN1EyGA0mr/aytbi/4/ZkajWFWLhFcX99lgEGReoyScq36s3hNFlgBAHcq1UYR8cM25hrKrToOcUWRechbCRxM0dSkythxozCSGHggb7mMYdfgSeHuA7WpGzwLQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk/0VyX7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fed090e5fso1692546f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767880040; x=1768484840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsTBs1zplB9PE0EemI+IzF5HTdMDYfpXC1Vio8/7U1c=;
        b=Vk/0VyX7DNb30bEhvxtc7jAbXkpOLSUHrv3jOQhhKiT9CTqhiZdDU4bI1KkpUu6zl4
         MmsHDkpCURk3dBky3eMQtOMwaKHafT/evDK6UsGozbSHbblgl3SbUGoegu+EzmfO8v/v
         Y8i7WES5mNbYQtbfXny40+V7jjTxMSn1w0rrnPOS6OVaJrpxpNYHxoz1oRDiBpls0Bqd
         dHdPvaE8Wq6dl1C7ePXkpEB5AZlpIsEi1tO40xI12xtrlJKgpFQQHydBjPFVD6bkDhjK
         R//9msup3ANjCs4ITJHZiNxe6osYiQnSo/ktwCPxSGX/N+5/Ds/JB1QQ6R/a0kq2Mi8h
         zQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767880040; x=1768484840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsTBs1zplB9PE0EemI+IzF5HTdMDYfpXC1Vio8/7U1c=;
        b=IRBQ5/SDcEA9b+kCsUk7ECrGIWsaeZMA88KCkCG7PHBeTodHY2htNhTJkJaOwyBWMu
         MhQk6W7ML8OOb5TE+ZCBNiZjBFdtJOPxwDGfwiVb+W7O/Tab/TIq0YAiuCk6IlbEiW32
         XlpAIqT8IsWMd+6T+oIMoC8k8soZ6CuFLruFHKUpyIBiANknkuB8l2OpihZp09wVsviZ
         Oqy3Y1HINuldBLxkYAmBZWtWuBjaOejwkWMitB6A/GI/8w8w23OIzXfeiMdj7uRKH+QG
         pG2o+G1/COU7nC++5VyNugtrWLTqyyZar1/eM0BKm9rRi0+kgk2NvEiK8/p9EGQDUFmi
         aCPw==
X-Forwarded-Encrypted: i=1; AJvYcCVvEGSxpo2xUgRXuaTKdv6zanJctV+UVSqEZtF2DtQAMDyApXmyGmbK2M4iX3EwjG81VNxE1Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rVP5DVNwZPTkLnQzeMfHslOnnlJ4ZBgXZ0WIZeNy/QqYZO1a
	151xA5vs1Xn2mljfm+65xSj4IvSV3RHTxUnPNw3yULFhxogkX3eYB++j
X-Gm-Gg: AY/fxX6tls0S6KdaNxr1LWOTCQ84i43eJN8WYNKI1JVXlxjrF/hZgbqAR9ITRa+43DI
	J9UQP/DX3Og759UZfnMz+v2uSB0EkVwNUB1VNnjvNilpS8P7F+WVZW6xyb5QpgFxbFXc8cVOnoa
	8GDxjL3kBkPrMeESqbz+6DmhxPw+imfHXGFQLbNXnlQQaTebpqf1kOiGIfpXePJt+xzHF7pCf+x
	sF6BU/IymkmYHapw6lA0NlKdUVHc57yCcqwtWCBUjdV09zkPsKI8uz8mumCYcVamEAak6IOJRKI
	Xf1DfDc364GpzT4jp9YN1JMgbiuhc/qLlCQNEgNeaGk9RtYevd3pAHqtPDsxk2dkcn4AY0t4Tdr
	eNEP5ZYeUYqlQFNON8c4UkyTxt4RnihbIuNYZ6c+w4+FJjU8whdVfxeov4TWjuygLHj7OBW5Gum
	Kf1+xU1k4Jg/DjTEsaN78=
X-Google-Smtp-Source: AGHT+IHpcRhjJIaGs9/3XPwm5P4jdWGxU0k62+y4o2BsG+/ugCwsW+GDh8vsVkFK1Y8CIzRz/D5Ksw==
X-Received: by 2002:a05:6000:2509:b0:431:327:5dc2 with SMTP id ffacd0b85a97d-432c3761063mr7732078f8f.51.1767880039952;
        Thu, 08 Jan 2026 05:47:19 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm16185509f8f.37.2026.01.08.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:47:19 -0800 (PST)
Message-ID: <a5e6003b7e81abeaca4f57fe07d2974cf4eb7a8f.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] net: phy: adin: enable configuration of the LP
 Termination Register
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Osose Itua <osose.itua@savoirfairelinux.com>, netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, jerome.oufella@savoirfairelinux.com
Date: Thu, 08 Jan 2026 13:48:02 +0000
In-Reply-To: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
References: <20260107221913.1334157-1-osose.itua@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 17:16 -0500, Osose Itua wrote:
> Changes in v3:
> - put bindings patch first in the patchset
> - update commit message of the bindings patch and improve the bindings
> =C2=A0 description to better explain why the added property is needed (as
> =C2=A0 suggested by Nuno S=C3=A1 and Andrew Lunn)
> - rework bit clearing to use phy_clear_bits_mmd() instead of
> =C2=A0 phy_write_mmd() since only a single bit needs to be cleared (as no=
ted
> =C2=A0 by Subbaraya Sundeep)
> - remove redundant phy_read_mmd() and error checking (as suggested by
> =C2=A0 Nuno S=C3=A1)
> - remove unnecessary C++ <cerrno> include that was causing build issues
>=20
> Changes in v2:
> - rework phy_read_mmd() error handling
>=20
> Osose Itua (2):
> =C2=A0 dt-bindings: net: adi,adin: document LP Termination property
> =C2=A0 net: phy: adin: enable configuration of the LP Termination Registe=
r
>=20
> =C2=A0.../devicetree/bindings/net/adi,adin.yaml=C2=A0=C2=A0=C2=A0=C2=A0 |=
 14 +++++++++++++
> =C2=A0drivers/net/phy/adin.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 20 +++++++++++++++++++
> =C2=A02 files changed, 34 insertions(+)

LGTM!

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

