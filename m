Return-Path: <netdev+bounces-205657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86EEAFF830
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 06:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE1A176E2E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAFC22331C;
	Thu, 10 Jul 2025 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtbg01S+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FD219A6B;
	Thu, 10 Jul 2025 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123018; cv=none; b=cB/0cnyrQuWGmCnopPnFLsnig487QR1UkGUWu874M+SNgX/+QoXG8sS0X8qpprm/2qblIU3uSORbgh7Z7l6uJBUaN1f4niwAzO85luP038VLrP1apFtKqI4kWMs39Skc0j/0w4oMvfojayU+NagKndU68BPMc63Qi0k1GvGgDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123018; c=relaxed/simple;
	bh=OEspdNkpeaGb6UthJe0zFS9Qljw+kdaXflFHboC9c60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQJukdn9SqYfzUhlInag3B0iAjsLQwC688PMl+DalBbDk172nqyFgPlTmj4i77K9cNntDhXOzA7cXFvDXiWqOAbAx0ZsD8zqtIkBeOZXaQp0WSl1GIULFvCzyeFblRnUdBMXns0/mJFSh06KVFbdW19bNXJZeM/b93qyGx1Fj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtbg01S+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so586507b3a.0;
        Wed, 09 Jul 2025 21:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752123016; x=1752727816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43W4i1GCTgED74WiEGNoHpiF4mzL+pQO2g8gssUc4vE=;
        b=dtbg01S+pZ48VCqevTYo9vxdmCOsC++nn57PSavyRJ2z6X9UlDwBjREcT9hWuS/2LN
         +KCG9djnDRjUY5wsI938X7BGx8vSwHJznbyV6EbJpcsA4t7SB9Ydmic38LTEQJaOrGxz
         /P6VOhn/z7HUiyPxvAAKFA6DM/iMsyrgujCQfVv2Z05rTGrCYb6f78M7CjNVFNcYOG+8
         2oUanx6lvPV18XwI0dLqdVJw2GlHlCeuV/MGx4aH7B/iiinYSMoa0rNCMDjw3DO+cAJo
         FR1ln4EMW+Rdn4VuC2DsIXuehi2dwiGARdMfp11WzLbHfVeSvuOqM8p2cYUr3rVSBXc2
         wOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752123016; x=1752727816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43W4i1GCTgED74WiEGNoHpiF4mzL+pQO2g8gssUc4vE=;
        b=eLUqj8QHJ82IU+Da7WLKeq8NT83zsk7fI9wh7/8xon/Bz1L9mF7JEqG7FwSVExznS/
         lJ37bRmnxGHxkH5u/tIAFHeFG4vi1KTX5Ux3mzOkG/9zQhH93enUOeshwan1CFYYl72W
         5xgqjIqMb8zAk96jFryNInAdtgmpjpFDXBYDsdzClKA1duFmgKHBSw4GzqpfwW06W+Pt
         pQ0NP9AKGrqMDnMplEuhF9k24GypaQQO8XIu1KPK6ZVejjeWhny54YdZ5o2FddafuAgt
         b8p6cs4Cn1HX2wikuFuCJswGGnIfvMugD+yVqKiPnBw7qbo46gFuvbEIoiUuMbdMHKNu
         3GCg==
X-Forwarded-Encrypted: i=1; AJvYcCW7GMKku/ZiOsiz4otE9EzuitxUFR0Qlpv/4buiV2CZx4DofNFKiw28Zr1tHKiltAKyMmB7lDYQ@vger.kernel.org, AJvYcCXm6eVR7pVO+21NguA16WNCn0inlaFOcJ/6x0BgdL/wX2NytixMNpDLTjTt5kuImIwqpSLRPp/rZwTSBVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBNWJMB+k5SEXr4bE+0dh1ZLjvgHX9Rlphne4pL03EpkVa/QB
	gFKI/ItvAHVWZlcjvYKRKm10QPGUldYiNQTxdi5XkWuwx3xQiCGeVyrB
X-Gm-Gg: ASbGncs7dNUJBYPnYmRfC7qx61xWJmLCUMhRWhxD09Zq9i3zIicX+3jYZPnbGr5ARqf
	g2gth7IAsB7StVl9ObWpHW+MW4tmXEq60FoP052zVILuvpefevwTznMk2v0csl1KQ1ZbDH1kI+v
	kmgSmCUSFFi4s3E5rGZnxhBCMnYPYuXfAgz4o9pNScURS5ln+aDzbCWR1Iai2yYHJ+R5hmF/UUt
	u63UUzIPPAa3XdUMfLvPSDoKpM6C9l+ff4JIl+qIdsSLQ2nq9gkp8Ts8LmPm/DN7bDvrYOVf3YC
	u7pYXARXolLHnM0IBVGqhos9VjzrLmZSYXIZrx8BOHgD9SFba31gAyRqtxSlaQ==
X-Google-Smtp-Source: AGHT+IGZnsUpzh+ZmsBVRBPZSQgS+0QwmCGnqZeIQPjP/On8etzioYUBd10sRVdO4/dKBZSQ/6l1KQ==
X-Received: by 2002:a05:6a00:994:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-74ea6709f51mr8662943b3a.24.1752123016476;
        Wed, 09 Jul 2025 21:50:16 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f4bc51sm808024b3a.116.2025.07.09.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 21:50:16 -0700 (PDT)
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
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/3] riscv: dts: sophgo: Add ethernet support for cv18xx
Date: Thu, 10 Jul 2025 12:49:44 +0800
Message-ID: <175212292374.416883.3089328739735203878.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250703021600.125550-1-inochiama@gmail.com>
References: <20250703021600.125550-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 10:15:55 +0800, Inochi Amaoto wrote:
> Add device binding and dts for CV18XX series SoC.
> 
> Change from RFC v4:
> - https://lore.kernel.org/all/20250701011730.136002-1-inochiama@gmail.com
> 1. split the binding patch as a standalone series.
> 
> Change from RFC v3:
> - https://lore.kernel.org/all/20250626080056.325496-1-inochiama@gmail.com
> 1. patch 3: change internal phy id from 0 to 1
> 
> [...]

Applied to for-next, thanks!

[1/3] riscv: dts: sophgo: Add ethernet device for cv18xx
      https://github.com/sophgo/linux/commit/0100910f6ae2659c1178b3ece064c2f2e7eefbae
[2/3] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
      https://github.com/sophgo/linux/commit/a4fb40b240fecc3cf84e12277e5b66818a80e3ad
[3/3] riscv: dts: sophgo: Enable ethernet device for Huashan Pi
      https://github.com/sophgo/linux/commit/8f8de50d4bddf155b5e5c70072c3048829a90a98

Thanks,
Inochi


