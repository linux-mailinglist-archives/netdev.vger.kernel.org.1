Return-Path: <netdev+bounces-164304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE07A2D56D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 11:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C9F188D10B
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484D1A8F71;
	Sat,  8 Feb 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nua8zQ/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763D23C8D0;
	Sat,  8 Feb 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739009664; cv=none; b=VFbxK0b0492W2E0H2XIFw/vcGK93LlRhGAInrXe9eP3+Jv+bIh2X+1iW9thdbYv14Cypa03IfhKbyB1lQmB3KsCwMQKbRt0MuKmgvUdU4t6lqFb7MpHLpkR4PvHMfmUyFgxzUkXLThACbtSIoHgh927xGUoe6NZlPYBvLW9hYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739009664; c=relaxed/simple;
	bh=lHlCTa++JQNY5yLxRtdf8QoMcBzRNGTE2Vwy5/XMOCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYax7Ji0hqzVlcwdJW828f3QezAyxrMEstWcxpEw4QSUGfokUPbvAd3XVMnXH5jr8kkS7hrunbUatgYg4E6Q3p+kYON8/nbmBfsiQW+w7drb7jd+7/VQtgMjzvPFdylV9ssOEs//H4VySowPu8wNdM99g8X4luMMd8n1ju3SV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nua8zQ/H; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e589c258663so3052008276.1;
        Sat, 08 Feb 2025 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739009661; x=1739614461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHlCTa++JQNY5yLxRtdf8QoMcBzRNGTE2Vwy5/XMOCY=;
        b=Nua8zQ/Hk/iY/8xGSK/LdwNjpfvB2aGuNiXjmk0XiFVjL7I9fgmOvpfCTeU/DlC+2Q
         zWkCI1kqTYO97/Yz/gn58GjY95gw7/go1HmZgl5sb6Gq6VkRmJDGPpDL84xWgZYzETwf
         9ARvvdSkXn973God6X+hXs7p3UhtTmc/9Fdyf1IoNpokemiRN5ssROG2xoR6rKx2Z3k0
         7UmojrvmeQw5PoZO3DWAOLCTvXaxxCh9LvZukts4tUx3Iy8pe7FIIou1LPRtL7bKc55+
         AJh4Uj1hmwYjVjMzQfculzmL+AQwkCsDkOigG0me2dpMvYtka2SaGqY+llsFCYnl7BuY
         KbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739009661; x=1739614461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHlCTa++JQNY5yLxRtdf8QoMcBzRNGTE2Vwy5/XMOCY=;
        b=Qamu11O8NAm6d91L0tn19LC8rdmgh0z4Dof3DGSXr6wp+o7de/QfMjAE/th8FL2pv6
         X1D5FaRA4JWHySAwLubXz8EsgegPKiCmDOUDVSwIp1GD8YANy0AeHxECmsPMwcTt2l+5
         j2viSDMd1kTY1V/rrEEGaKWCl97tKo4l6umoPP7ZwYQoamhToX0ixsxnZM5zHVTdmJX+
         6kR+K+rrPrT9Qx44KbE7Vl7F1GLskYIMDVnOYt4STfi5xA3BrgkBgF7x0TSPiN4oYYCH
         crDUb7iJ9GoqY39QF1Mved4TsoWXb4B3UNeapaBptPxiXRVxe49byX0AShTOkEoELk1d
         ooLw==
X-Forwarded-Encrypted: i=1; AJvYcCWUO+WI83LciLSLMublSBepOWj6t+zCFork2r/EmvZffwbvxKk3VyKBj4grLgba4f0oAKisDzOyEldeHBg=@vger.kernel.org, AJvYcCXnP52LvVzr+mUqmzaepIwAuy3rs8tHdtkRNMyI+ZYhws/2NQksGZLa/Ku50/yd/rUvM3IzY+2u@vger.kernel.org
X-Gm-Message-State: AOJu0YzmL7j+RwKKl1PIOlHY1BMmA3dpiDfAClKxOoLi79U2nasoikdZ
	HrYsMOI2GLpgSUE0daC5XZAeEXTfgh8NQuoPf+gE0x/53jyc4eFlq209uuaaVIkvsTBjsH2WKlA
	PI4Qjy5pq9wTW8TmNcAW0aXSx76A=
X-Gm-Gg: ASbGnctaB8daKmujxOq0Eq7M39a3gCrYvZ7emij2CGAcsCe6HY6o4MuL6LOn6HuhxtL
	W+BmdZEQOtzFCTC4PoB+C1vaeGHwB7vJKtnJ9/Qjil8eTMSkY3VVQL9DWxS74bjcAHNozpSA=
X-Google-Smtp-Source: AGHT+IGJTnv0Jv1zGgHunoHT2gol4/G0RMD4RSz3LklZiU8Fl/L4w4+Hl+f6eU1srrJYqwe1I2fUwS7Kk/Ykj0OnFyM=
X-Received: by 2002:a05:6902:188d:b0:e5b:1858:9f34 with SMTP id
 3f1490d57ef6-e5b4619f369mr5462498276.16.1739009661634; Sat, 08 Feb 2025
 02:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208092732.3136629-1-dqfext@gmail.com> <Z6ckCZpOo1_rvmh6@shell.armlinux.org.uk>
 <CALW65jYG3vv9aCY_HDU4Wyij1kqfiOVOsZ3YnvioUf4AgSbnaw@mail.gmail.com> <Z6cp-TCckCNReUPd@shell.armlinux.org.uk>
In-Reply-To: <Z6cp-TCckCNReUPd@shell.armlinux.org.uk>
From: Qingfang Deng <dqfext@gmail.com>
Date: Sat, 8 Feb 2025 18:14:07 +0800
X-Gm-Features: AWEUYZmoA4XiGxbkn50VzS3TXo8SJfjOy3CnNZmFpsB8QTfYUzOVzyDXS0kfqNU
Message-ID: <CALW65jY1kzcJT6sxvko5GMC3P4odon=ZvKn+ZfufAZR9jqb1Hg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: mediatek: add ethtool EEE callbacks
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 5:55=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> Doesn't it need a bit more code to configure the MAC?

I think you're right. The MT7622 reference manual does not mention the
EEE configuration register so I assumed it would be automatically
enabled.
I just checked the mtk_eth_soc.h and found two unused defs
"MAC_MSR_EEE1G" and "MAC_MSR_EEE100M". I will use those to enable EEE.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

