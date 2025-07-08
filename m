Return-Path: <netdev+bounces-204819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE97AFC2E9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253003AD6F5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2612222AC;
	Tue,  8 Jul 2025 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEmKT7FT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443E221F15;
	Tue,  8 Jul 2025 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956865; cv=none; b=W6mG/p7XSRf7HsXHnRqCitP8NxBaHtlysUjEh0m0qJmn9yuxiwhcrEVFL+1islKRBwppAwF3eXYYGdgN0zP61xrJJUAOUMxe1vSCciQjTVfzoY8E05rJxmx6gcYDAy0S+M6vro0Sp+BukXOmo97wYbhdpFbcRpxgCJh/nmTDgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956865; c=relaxed/simple;
	bh=IMJpd0GjuVn2WZZRRSA1sr85+Wk8S8n20D6MuGdpS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3hzRG71viy+yikKmZ4MnQJls4quSfAe0tmo4bWQIzs7KZMzj1wEDu42WqNjUVDMcOouHKRiSRvv7VF5VD2wscslo6qkLX9NEQsk5fJggPZm5wTP2fy9e2+Qhp3iz4yZSbyqm+/7G8+hWEMD8JkWkJSxCJAn6+JODIbELoKWbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEmKT7FT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23508d30142so48358195ad.0;
        Mon, 07 Jul 2025 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956863; x=1752561663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NYG4DorpfLLHRrZb8LcTYUGaXr911+Bv8Mdy1JA60DE=;
        b=AEmKT7FTrfjrI52TgAZ8yzmTZefI/M4lLa66BW3Cqe32MHeTqUAnfUFMA0asjCdMNb
         5ezyznevZTsCgFjPk2hLuqWITI07/n96sXJAzNAran9oas1H3K6ZNMnbpW73uILJ/Dh0
         6HyoD1QmcPh+e2vk8DMXG/ZQgwkJJxt6eXOBiTnxask6fa1rGyj1UuHRFjTjkd7cn2Ba
         SrcjB+LUegIK4DUKz7omjEUYwdX8zYOjaGFGmvsTN4xAmO/fPc+KLDhq87F1jT6llpJe
         IEwjVLTwfHwv0jywbEog8dMHLvKpqzKlpXBM6bVO1ssYreVQ0R65dAXmBt81eqM9VYoS
         0Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956863; x=1752561663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYG4DorpfLLHRrZb8LcTYUGaXr911+Bv8Mdy1JA60DE=;
        b=l5sUeU2zD/wlZxE17XwxvZXdj3RB/VOEWGCs2lfrXDLIf8xpGjsdNTxDImr//NUh1D
         3VJfkzGGnp2d97jeQ3O0T1or2kRujMpnZxLxCkWKJ9v6c/ZgRgl2EM+ig+vKVrLoN4tK
         dX0aLg8tSrWKtzW84eFsU92Hjjc7cdI5nociF3QepgBDrAFWFcs5lE5aT4sx/OknukUc
         Ii3r4gOPEYW2z3kG6BM9Q+pVAHRFfmzKeXsrWbFlDzW3LvlgEFvh8KP2VfxWEOb81A1k
         SXLT+frQCnH/VecaSyUDiUe8bxQC/zU7/rglbfzPwHVt3An4vflwD6AqAZGh00Yl3Xhb
         f5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU28RYyQMXhuP8uFkMpZbE/68AzAIs9EuSFqNnRty/8FEcgQKwe3Pd7/G0RUJ3aEp9ddpyehLYvTOfZ@vger.kernel.org, AJvYcCWxXYB7xslJmEvTejZrxQLpqFvuIY7sB+1ilyTs2I/+CGQ0+2Plcis34M2xa0HTxsbIulsJUrRoKY3aquOd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rgW0eBCB8vPayVCygVf/yjJYXQGIGGeSEas50OAMj8/jRf/s
	fkE8n7raLrXcxcgDH57Drg1NJ/aMHBXAgG85xvlKuITFSyWtFFSRfe+p
X-Gm-Gg: ASbGncvyKwMNfZomf0lAWhHa0u2xRf8SDQlpY6riwQD6X+trLqaZIz6lu1HqWqbz9BP
	2eLo4XbayZ3dOPvokuj7QB8tfhJiySISUsjb/M1oPsuvB4eJeam6++FT7aqXfEIbSRTAROn6QHC
	1Nlyrjp4vkmbeP/QPl0aQ++0aOB1TxNvJ7x79KVxuoBSqsDYPMLcj9kKq+p/VFtpgk8AGnqhD8a
	MJP/UpN4olt2zROaCu7l+h0FARtXBHAVS9CKf/FSDu+nEcNtKzdGBr6c/Rub/4CVKNhuXahefMe
	uDadwZGJ9NKcolinZItME6+zwvPqW/ip3xZUs+O2v28xtBJ4kbzhHP4wuG31Lg==
X-Google-Smtp-Source: AGHT+IE8dNh/94h7PP9qu+pz6QETQuEDR3G8DOsyx27YTdMrR6Zstgx9PwNjmLqJHYn8N5lM6qUYiw==
X-Received: by 2002:a17:903:286:b0:235:ecf2:397 with SMTP id d9443c01a7336-23c85e7671emr225145495ad.33.1751956863291;
        Mon, 07 Jul 2025 23:41:03 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c84597371sm108407375ad.207.2025.07.07.23.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:41:02 -0700 (PDT)
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v2 0/3] riscv: sophgo: Add ethernet support for SG2042
Date: Tue,  8 Jul 2025 14:40:48 +0800
Message-ID: <20250708064052.507094-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2042 is Synopsys DesignWare IP with
tx clock. Add device id for it.

This patch can only be tested on a SG2042 evb board, as pioneer
does not expose this device.

The user dts patch link:
https://lore.kernel.org/linux-riscv/cover.1751700954.git.rabenda.cn@gmail.com

Change form v1:
1. add user link at cover
2. separate the devicetree patch as a standalone series
3. patch 1: Apply Conor's tag

Inochi Amaoto (3):
  dt-bindings: net: sophgo,sg2044-dwmac: Add support for Sophgo SG2042
    dwmac
  net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC
  net: stmmac: platform: Add snps,dwmac-5.00a IP compatible string

 Documentation/devicetree/bindings/net/snps,dwmac.yaml |  4 ++++
 .../devicetree/bindings/net/sophgo,sg2044-dwmac.yaml  | 11 ++++++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c    |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

--
2.50.0


