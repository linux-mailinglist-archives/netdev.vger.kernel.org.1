Return-Path: <netdev+bounces-105147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7990FDA4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F138B2104B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E6F44C64;
	Thu, 20 Jun 2024 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Rql91ceP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DAD42058
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868314; cv=none; b=ka8vglqIryPpwaMD05RgaE51hkSkDv4BMOCGGvKm9fm0ZnUO1hsNkKsl6R4JaeSiGtPffbOF4aLrivXy56Rk+t4U8M9buxP6CZiEDLkLELepMd73M9zKN02Qe0+Za6aaHqT80k9ppHHDEQh0wqpAmXi4VvHf3K37Exz/CW4uLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868314; c=relaxed/simple;
	bh=jSwahG1fUc4nuo9lDEw9TRn4gAVc7Sv8Lfe1Q7iPXNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJZiHsfTy3EcB7ZMyvXppzRTk5528xEItJvP78iQLO0OzjHTTwgOUWiwMln0uH1rJ4R5uYFov2tQuaytNTmOO2wWgm7OAPkvW5ipyPiClfFgbk6/blFpAFUj8Eq+t6NQTN9/2+ZkRLEe86/OPEWuAmj8MocyORxt/6bcgTZhnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Rql91ceP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1477152e87.0
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718868311; x=1719473111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRH5412s3wX0CB4KIXqQXWuDqJc61xtQQ1UqcTmYbLs=;
        b=Rql91cePriLwtxiq4n/1I2OAgbYmoN3CqoOuEPIEgDiAfvJlW2u2G2uw9Vz2saoT+A
         0gs2VRfIbQJs7bAex9J3TASgHuBSEpoSDpkv/3zWRrogIn8dbSgioD6zQ6Ttf2fyI9DL
         Szq1dftbfmzU4hmFNQ8eM6v3BkD8s4+ceMzPREzMxQUbWFWT7Ic84mtz6gZPFikN0b3y
         vIBNI3neNx9kX+Fv1urTCpvdm9r13BgT3PHqRjwjNLREBzxiOrGuBGVW+7a5hgHFiF/0
         1A3fU8YEuWlKaVNnER8kEtA28f2NJTqfCBYRYLinICkE81L3Klyqzh/J5JE2SGhdj4KQ
         9AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718868311; x=1719473111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRH5412s3wX0CB4KIXqQXWuDqJc61xtQQ1UqcTmYbLs=;
        b=fj8ih43ohhd0i9Plk3FErBY7Q9baBjyrxdkrPCEWnGBNn60ZvxIdvS+7wAyH/9E7CA
         61B/gUF9bKHTUw0ChCN9fLDit8LK+odwk9Ed5ydqk72G8UFZyy7NkSimOyJhbvwWyPIR
         i7pXLQDnscmACuWDgANFUNdmpTxPfEKyPDc74X6weHW1xeEDAhHTxPKa78pJDoFcOE7m
         cX9CYZNNnS60SjX6mH1+yPnBBQd4IKJ7DyeS/6hIgT4KcCeL/hUS5oKqnJG41CeTeSde
         Y/MvDjN3smJvh7Elhd6vgbIN+TRm6EyLK9vaV+vDAMIf/78S7IypNIlIlcakV/79aL75
         /qJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH3RsUvWdcLRhX/JrBHVM/AoyCfyPGi6VIVMYODx8xpN8qEWfS2Um81gQhXgHzlrMqjVbSqWANqBh0I8JM3xfvx6MFCCuQ
X-Gm-Message-State: AOJu0YxAlbi4rVNbLbTdtpuZgXCsiqBxhhcJEEQGYNglvMB3ooaSQhLQ
	9ldAC7XD5UGL4qbipFgcTDSc2C0VzqKVt3qvMPyS3gzNxRDEiwY7i/FZB/MVrjqKOwbHaVnZWGg
	AxBY7KWWLhEnltq4VbnmYFGHjdwhbiXHBf5/P2g==
X-Google-Smtp-Source: AGHT+IEdeM9R3n/NNtQDYZHx3TkVh4Vr7+gb+bkwvyCIBlqBU2TmaHrNNS+3vlKpjGfCJsXmfuuse+wN8rhE8KzDejs=
X-Received: by 2002:a05:6512:ad5:b0:52c:86e0:97b5 with SMTP id
 2adb3069b0e04-52cca1c57b8mr1464365e87.16.1718868310875; Thu, 20 Jun 2024
 00:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619184550.34524-1-brgl@bgdev.pl> <20240619184550.34524-6-brgl@bgdev.pl>
 <44cf011b-ec81-4826-b7c2-1a8d57594fca@lunn.ch>
In-Reply-To: <44cf011b-ec81-4826-b7c2-1a8d57594fca@lunn.ch>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Jun 2024 09:24:59 +0200
Message-ID: <CAMRc=Mc0wN=zkduCnKetXyMsuY2k-BzrZ19ehPDntZRDu_o6fA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] net: phy: aquantia: wait for FW reset before
 checking the vendor ID
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jun 19, 2024 at 08:45:46PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Checking the firmware register before it boots makes no sense, it will
> > report 0 even if FW is loaded. Always wait for FW to boot before
> > continuing.
>
> Please split this patch up. One patch which renames the method to the
> more generic aqr_ since it is used by more than aqr107. Then add the
> new use of it.
>

Will do.

> Is this actually a fix? What happens to the firmware if you try to
> download it while it is still booting? Or do you end up downloading
> firmware when it is not actually needed? Please expand the commit
> message.
>

It says '0' and the driver tries to load it from nvmem, then the
filesystem and bails-out after these two fail. I'll extend the commit
message.

Bart

>     Andrew
>
> ---
> pw-bot: cr

