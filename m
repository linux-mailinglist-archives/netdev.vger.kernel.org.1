Return-Path: <netdev+bounces-201434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1DAE975A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F0617C81D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D3D255E23;
	Thu, 26 Jun 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcQYMpKt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43881DC998;
	Thu, 26 Jun 2025 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924871; cv=none; b=DpGID9/r1NX+ChO+Xs/j+69vvJh2m8/EWB/ztgJdxLsAuHUTufqPd8nNT+Je+WN2zviFo4l/uh1VOGzdCImWr4e+3oz94yxiDK1FmFoDPV991JWljGQPm4XuTwld7XKR11O2qadRm8qUZv846hH8OFtoKKnhMxYxEEdq1tyDdj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924871; c=relaxed/simple;
	bh=ZSFdLmJABSxbFmRELSJUwLft1Dgap42cZsZ6vAmJvr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxDh/iObzhHx3sBNd7tAwVWuJZuX+d3nRI3LZwCyuqZ6k7Uwypb4UA4HP2s3MDuRrysEd8jRyulyZ7vgsaYBH1xzeHkCnxtyWQqAxpqWQfprSbeju/ZU1ypCtl6ea3xkfPKFf7522YJDpWKrul+uBlV9GhpoebeHGrN30A4uKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcQYMpKt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so719154a91.1;
        Thu, 26 Jun 2025 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750924869; x=1751529669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MutTzljpNoSQQ8KY/Naa1K0a5hKmtznD/W4HGzANsVs=;
        b=TcQYMpKttCDmeHujTAXDhLBoakHSrM4bcT9TXpubSFl2aWHO2ltBDvUIdh3T8s/peN
         /CLpack+MNrDZJlD8g7KUbxy4NFxP3AWAE2ZsLcxY2IrtaqUCR4MIcGZZy3sJJpNzseF
         U37xnjKV1fpTvyelxe1/7aWGhw7hTq6vc8FKuCqICN/oyj+y/0Kw6if+pSOfPmwM1OlN
         0BvA0+5UXno5ypBIibDodQiZsBFPgHgvdzp8cWqB34COXKOhQDpDsyXffV7TkLUHGHaA
         mMOwz1zeUGTnEQxahS0MJRUlAa8i9AhRfO0FTFx6AEYitW6egbDlPey12sJfPaqhxh0Z
         NMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750924869; x=1751529669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MutTzljpNoSQQ8KY/Naa1K0a5hKmtznD/W4HGzANsVs=;
        b=KZuCQHDTuIhNHlGkp+0V8kgSDdqr+juYueg5zZ77U/aBBFs+YvZa/ELizx79+aBElt
         3dk74HrMA/055PqKTS9Fjg3AeYKE+B317lCoFPvJfM5y2WHHSXOPYDIDWwbbXCZHHn6P
         AWifBTG9AHtYbtkpRNOtk/oVoTXrKnTfVhVNaUBQ2SRR38WKSoJwUzqA6B8UPtyOUvfh
         yEXT+inu9G3/nDU/FHXl9FbDWcTqlImbhgtxbixSjd6dgAS1nDQJPs/m0tLJd/OB5IBe
         OUoDY74PMa2YmnhXQOl4H97DPcw461EfM6tiJVOoPGGy8xinG0hw2t/htCJPvSkH+hDm
         Xpcw==
X-Forwarded-Encrypted: i=1; AJvYcCUToia4AkE5h+Zan54Gkk64RA3r6tGXSzATQ3Ejzo/nPvj9hytsoxrZuC0V7IuC/H3HbyGTtMWx+KHWiNfp@vger.kernel.org, AJvYcCWXB+oCArr7OPgRTe+Fso1ov2jM1kx1BAAiXPYAyrEAueNrqj+/ghK/Yo1lET3chuiPjueYdznLl4YW@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1ZR727fNSIznsDCrwuzg9lgUAgvzkTnwL29T/yZIPXGUYOD3
	QfFZ/hM6hAvPiGvGC1fMS//6/mh+CMmOiY95dyr28sJBI67ixkWo632L
X-Gm-Gg: ASbGncvxcERP54cI6IjmjE7bLY3GDjdeyLl4c6TH+EjNBVxr2qG5dPOS6uyedP/THSp
	7tLdbWH0G8dKFehvKuQ+55UZDKD+Dh+61HBpxEsYRcNVlAafvToU/9JEy9TxY2M36zTd2gTZQW+
	CQds8t+Kbi+GreF2BUP1fjce7PFG4MwZsVIWDNnBFMIa7gT3/+l3IAOQtOcYYh6SqqHMT5SOKj7
	9jxlTdDaUM8X7vrjUS2XcEBG5pZ4GPyUjvihZulvr2OsECLd0xp/Ut6o0yOqvT7X1ufPrRc9q+r
	0tr0gxO5uCTD0v7IdYFqZOrHxJMHdrIbTOJinFzi1CMZFLvPEnuU46weDBo+OQ==
X-Google-Smtp-Source: AGHT+IEvFHP6OohPGoe/i9ODcPd4CzHYZYohuqPcN6oUCsWyV/2LcB0WXZlgW3DjTlwzc5TunaJepw==
X-Received: by 2002:a17:90b:350e:b0:312:f54e:ba28 with SMTP id 98e67ed59e1d1-315f2689fa0mr8936538a91.24.1750924869022;
        Thu, 26 Jun 2025 01:01:09 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f53f3a64sm3785918a91.48.2025.06.26.01.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:01:08 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v3 0/4] riscv: dts: sophgo: Add ethernet support for cv18xx
Date: Thu, 26 Jun 2025 16:00:50 +0800
Message-ID: <20250626080056.325496-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device binding and dts for CV18XX series SoC, this dts change series
required the reset patch [1] for the dts.

[1] https://lore.kernel.org/all/20250617070144.1149926-1-inochiama@gmail.com

Change from RFC v2:
- https://lore.kernel.org/all/20250623003049.574821-1-inochiama@gmail.com
1. patch 1: fix wrong binding title
2. patch 3: fix unmatched mdio bus number
3. patch 4: remove setting phy-mode and phy-handle in board dts and move
	    them into patch 3.

Change from RFC v1:
- https://lore.kernel.org/all/20250611080709.1182183-1-inochiama@gmail.com
1. patch 3: switch to mdio-mux-mmioreg
2. patch 4: add configuration for Huashan Pi

Inochi Amaoto (4):
  dt-bindings: net: Add support for Sophgo CV1800 dwmac
  riscv: dts: sophgo: Add ethernet device for cv18xx
  riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
  riscv: dts: sophgo: Enable ethernet device for Huashan Pi

 .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  73 +++++++++++
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |   8 ++
 3 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml

--
2.50.0


