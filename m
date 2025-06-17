Return-Path: <netdev+bounces-198421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FCADC131
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589EB173DE4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 05:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706323C4EE;
	Tue, 17 Jun 2025 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9HfzlYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698223B63E;
	Tue, 17 Jun 2025 05:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136926; cv=none; b=FA8kgBD5J9SSdfH6i/FLsuunO/1Ckyak/rLHfccTYXQl12jLCHvrCQqJHs/8PiZ/WrGpVVNevHV4eD3wdCtUWhRC9bSEmJjemTyPiXhhV2wAwAoIoW5rRGBX0YVZ7Od5usrDwSzNj9BlwdOqAOxsIVFbfIDvefZVs3XLir+txcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136926; c=relaxed/simple;
	bh=8cWRihSV8hdi/ZTF/kts/Yi3Lmi7Mkj2nrwo2OnssFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1TJjTlCqkcYNGRhfCR89B7i+I/w5m/ddHtQPIp5M2/7VtNA+Hd13KyjeB0GEt9ZnxwnxuoDP2D1vmACSW/FayDr6FZoHX4AiEubJ3NpetukaHDoKyhtfNDvJoZtxgRUk/ELQUH6IVCNK97xdT5sBtigDzyGKRQwD8lkKcFM57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9HfzlYr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-236192f8770so36388845ad.0;
        Mon, 16 Jun 2025 22:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750136924; x=1750741724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8a5FK3kQzpqiKJGUPwyQmhurnkoWDXPmVMG0kYx2X4=;
        b=l9HfzlYroH931lM0wJws+wMsJgWf+4LsmRIcK2bLbXPW87D6jv7W6c8d8sAK++UwNk
         WDA2qjq1f0FkX0bCBLaBChwEN80Ad7+fSghMIgfQDnC4P9ypjvt78AsPezsFQkPNDMJo
         nWiT8CsD3NlWamYoImwYJrlKSWCvvAdaHYe+BHqfW2k7TR58Xc2ML/+gnHtaLFkDLc9V
         q+h14zj7LUAHzbuYAYxUblhJraa7Jr5d3QLGhd5CFm0C1qGAh3ymZTRFPPTO3Ey5d18b
         lKgDF9A41S8uHoUxAaP+NWim0wSZmehIwKqB6pxH8JYiDXcOtRpmCUFPXGxlmyQuVws9
         hrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750136924; x=1750741724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8a5FK3kQzpqiKJGUPwyQmhurnkoWDXPmVMG0kYx2X4=;
        b=EPTNt2PSZoExGlm7piJ3uDcGDf/XZRGS3yvaMvbncmCN/BgnFC7QQocalsbGAX2nA9
         bKe8hNwgVbzQdrJSo/gn2hD0DsG6l91ufB6Fvgnb7sb7eYXOBHPUvFgR+9VcEoe/uLZ3
         PGFTYPp62J+scg4XRGG/tM4JlXYitqP8Ue7tm0J2QI7f0ZEuEw6DpUK3pedDugXmueLm
         WXt7XTbJS2faJ8bVle4dnzdd/c+2TXUacrDI3nkvCNBPifGT47LxedFyWE5XMNoQC6Ic
         C/T4twRKvZfPibtSMIfdkHUU4DOsToAB1oLeSb3EpX/b5C3DYO0C86BsVtGTHEbhYY+y
         0uCg==
X-Forwarded-Encrypted: i=1; AJvYcCURcdPmN++BVChEtOns/2u4gooaT79aDjr1VO2KbL3yXadZyBxqtNG0Jf1G90AVCWBX7OcVQ4Tk14+zWnyp@vger.kernel.org, AJvYcCWlciaLlIIeVno4wzfxPEcz/z/auhkDx3rOdOGJ8ITs/Shht/SeDMvX9GHSee/m7pxes7vJLd0t@vger.kernel.org, AJvYcCXyGQdtWAJSUrvhup0E0Ch4Q9jYbvDQGYyPWh3JntzFhVmSBtFO7NEXNvY6cyDUfa6b0vWlx0bwdJLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9dXyguDag0we3O2K4XEu4URIUnHyPsmKtiEC/bFG43xYXB2r
	dOI2OULKWQZyNQRx8fll18yM5h2hy1vuA9TIKVIoAj04eK76Be6CJ83T
X-Gm-Gg: ASbGncuHJQtVBrXUyiDBQqsWPNZDFT5jUeQ3bgl8m0rSQXs0hpXltR107SYKl6pW3W6
	MtrhCeNZr1vF6uDQvFNjLzO5zesTyK1GNmyo+ds43c6gcqr46SIsF6dYdnHtCDqTp+sewDCZ+Ld
	SlAYXQtN2F5OuV3SjZ1L8YVsh+Wlym/WDm3WFMBmJR9L3NLbfplqoRq/Exga9AtimxheEkj52VW
	RnJ+NHJS9XJqXofIDNEAeL0lmn6zfYKzLPetpKyAvtmvpYjcChS8n8IqNIsCNlM5zO1RPg6CzZG
	31k0i9M+FnWMJCDpfOnVJx1CiIkU3h5Qj0bGkWpK8AipmFIlQITJ4XLqyA+wTQ==
X-Google-Smtp-Source: AGHT+IEssrqaSfoOP/FGQlXeEDhOtAtWAeKGb5++EjqTQbQnP1cJDjcvN7caFzDjVdHbkmrf/+DupA==
X-Received: by 2002:a17:902:cec4:b0:231:9817:6ec1 with SMTP id d9443c01a7336-2366ae551a4mr176657755ad.17.1750136924089;
        Mon, 16 Jun 2025 22:08:44 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365d8a4d6csm70981135ad.88.2025.06.16.22.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 22:08:43 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH 00/11] riscv: sophgo: sg2044: add DTS support for all available devices
Date: Tue, 17 Jun 2025 13:07:21 +0800
Message-ID: <175013680588.1018298.5174289579188996071.b4-ty@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608232836.784737-1-inochiama@gmail.com>
References: <20250608232836.784737-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 09 Jun 2025 07:28:24 +0800, Inochi Amaoto wrote:
> As the clock driver for SG2044 got merged, it is possible to add
> dts node for all support devices of SG2044.
> 
> Inochi Amaoto (9):
>   riscv: dts: sophgo: sg2044: Add system controller device
>   riscv: dts: sophgo: sg2044: Add clock controller device
>   riscv: dts: sophgo: sg2044: Add GPIO device
>   riscv: dts: sophgo: sg2044: Add I2C device
>   riscv: dts: sophgo: sg2044: add DMA controller device
>   riscv: dts: sophgo: sg2044: Add MMC controller device
>   riscv: dts: sophgo: sophgo-srd3-10: add HWMON MCU device
>   riscv: dts: sophgo: sg2044: Add ethernet control device
>   riscv: dts: sophgo: sg2044: Add pinctrl device
> 
> [...]

Applied to for-next, thanks!

[01/11] riscv: dts: sophgo: sg2044: Add system controller device
        https://github.com/sophgo/linux/commit/50fa2633c143d857a68128da387e0bb09c6cd362
[02/11] riscv: dts: sophgo: sg2044: Add clock controller device
        https://github.com/sophgo/linux/commit/acd836a65b8cdebb007df0c3e08ac5710f0994e7
[03/11] riscv: dts: sophgo: sg2044: Add GPIO device
        https://github.com/sophgo/linux/commit/8fc13510b3540481d291e28172b41b571ea078c2
[04/11] riscv: dts: sophgo: sg2044: Add I2C device
        https://github.com/sophgo/linux/commit/b0d0b60bc906160aa3a1654de82c24bd55a801b3
[05/11] riscv: dts: sophgo: sg2044: add DMA controller device
        https://github.com/sophgo/linux/commit/e40105024f078269a9729f7488945c11f4f3422e
[06/11] riscv: dts: sophgo: sg2044: Add MMC controller device
        https://github.com/sophgo/linux/commit/4a678cc75d580a6478bcfae60907fa732d485368
[07/11] riscv: dts: sophgo: sophgo-srd3-10: add HWMON MCU device
        https://github.com/sophgo/linux/commit/62d6db9792ff7ddec27a61df8223395b22860c0d
[08/11] riscv: dts: sophgo: sg2044: Add ethernet control device
        https://github.com/sophgo/linux/commit/67970c99f040c3e26677178f323993ddf11cab1c
[09/11] riscv: dts: sophgo: sg2044: Add pinctrl device
        https://github.com/sophgo/linux/commit/d32d3c657f4f8b45ace6dbdb48ad602fc9a44be8
[10/11] riscv: dts: sophgo: add SG2044 SPI NOR controller driver
        https://github.com/sophgo/linux/commit/502ade8b6fd981ba3694000e684686954d73c3bb
[11/11] riscv: dts: sophgo: add pwm controller for SG2044
        https://github.com/sophgo/linux/commit/ea389214c01b2767ed2bbd4e9a03573394b33fd3

Thanks,
Inochi


