Return-Path: <netdev+bounces-164386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB6A2DA32
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 02:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660A91886B0F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AFB3FD4;
	Sun,  9 Feb 2025 01:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEWFoDdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D7653;
	Sun,  9 Feb 2025 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064664; cv=none; b=lZ1xKoWbAq9OTdcj+R9tsxduU5C4DE8jLlQpzti979+rPtT/rKkdu33aqdOxNTaF0rxFSvZcJvowgxUVS+XDimTx32FRWrfinjOeSGm4Q47p0Xcd8UjFuebanT0398jv3ldckqgWh4kO81PDMM8OiRnvU1vOXN7rzfAlMmnBNR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064664; c=relaxed/simple;
	bh=MLVsc2+zgPEDXOT+DdwweQVNzbXN9yOCujghrU+hkzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bG2tmQaKzbdK6Hr0FIRTwwE7cYbHy7L77Jk/mJ2HgY+PzcijmtQJCOgm/ZAkFdKf3MN8QE9DFNaLr50Lr+CAjPRtSc0w7ZZqjxhWRfeJE9YnTjLWIK9Az4qbAyfHD/fKunY0a1UPI7CwYavo8PU9Ik8i8HTSWbtltCWvmlvcRZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEWFoDdB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be3f230436so317503185a.3;
        Sat, 08 Feb 2025 17:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739064662; x=1739669462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpE4zKyAH8svDQr1EVUQPc0P7SOzCqW4Zan7hwoFlao=;
        b=cEWFoDdB8te9qxwPK/njctLFMstVrk4PFuaCUA5Gz874qcttTaMve/RkG9RAWDdNa1
         d3jwJ+V1qea7zJeCi8vSVB0ejDLH6Wq2/NBs3TwrqITKf287f7SvVg46F3S4CL/CE6BE
         R6WIu4Is0TQzGMgUg02ajo7pHa+yi2Q6HnqqNUjgTGgck7wdgaDSW1YL0/92LfybrLIc
         miZKLlFiiSXdOuFeIh46jUnkcfu3FGKi7N//JEQ8xwWAG5P6Bx2ou3n/3mWe7SWtkutb
         vwbQFrmGqDT5lReRh8FaVQCTCoGZpdOe7IvkrQnHpAcTCteGKeE/1NIpRPMpeQ7jdI8J
         PFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739064662; x=1739669462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpE4zKyAH8svDQr1EVUQPc0P7SOzCqW4Zan7hwoFlao=;
        b=ASA6LJAVPZRKm6b3++FXFDo+onY6nHDHTV2v4JKzGMVYzNyEoh0EQdGw95reAqc0Ow
         KmloeqUSs04NcpX0zWrOlI5YWLDLBaSsS343mkedc1HvQBQjeYuFMJ9xtpxNrpdHNxHu
         2c4e3AIQccr+ydddS1nCpeeCqKx0rU+cc5asEycecCwpHeTmNZ1NNzCyQinr21RlChZE
         MvE3boAbrC3f8R8DucPJfvB/2tX4wH/fvy8S/G0GHnSKKAFNxmA4U8Z9HK6yKsV6R08B
         vpin6sng+4bga+coCqkxc1rwld0Ub/Rq9LUA/clNCAWH8y+QX681sgd1EjjOyCkoVTwn
         p1wg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ksyjUQcKt9sc7A4qiGGrxhqayl3ia/OrPmpQraZoI9KWcHlnXM3xjr+upawZ/Fs9GB8YVVAe+2oN6xeQ@vger.kernel.org, AJvYcCV6tzWmqgSkhZCbUzRWBJkGivWOIaVMHIZhoeVy+mhMiZSeSJHcfB4AcphlMvWCDgJNduq1pzMJKBvM@vger.kernel.org, AJvYcCXqPIcnkE4sZnL6FTAqQJlMTAWLJTv0haGheSD7s2LCSWhVXtzYv0A0Jq9EhcC2xD22mpH7N4uH@vger.kernel.org
X-Gm-Message-State: AOJu0YzriybIj5nmLXE3tJ2OkyCeNWV4cREzX5Q0ru6p+8/IvGgrUoGV
	jVflm01tUYOcziD4uRRyb7KPSa26vIy9NhLa7Byc3cx2eDYltrB3
X-Gm-Gg: ASbGnctvXtbhQkxwiIKrPlxtmrVQ25Kx85dbb2hnd1u/E83w5/pePUaU4TKmf8/yDJu
	9iL6vtrGN+gZlJ9mCqR7gADxDKBpX2vXJ67cLpkT1oJ4bpA0As9cKROms4lc4pa2Wcz5zUikS+G
	wyk1THaaCjz9S96x89AegIzIYle3lxv1ViYkMnN71wWc2+SsiJBZ1wrCBRberinjDbB+D5qDiyx
	jU8vIcSaqIO7q8TZ0V4FOeXHKzurtNyX1Wje16aPPbcXtR6PSL0kVwGT6oR1izKK+4=
X-Google-Smtp-Source: AGHT+IErNG966adydDNeNbSis7LGgBN1C8RNiREv5yWv/KkleMlno0XmKLtdyzMfyEP6jLn7m+bHdQ==
X-Received: by 2002:ac8:7dc2:0:b0:467:4f9a:6511 with SMTP id d75a77b69052e-47167a348c6mr149530651cf.30.1739064661848;
        Sat, 08 Feb 2025 17:31:01 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4714928d886sm31368431cf.18.2025.02.08.17.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:31:00 -0800 (PST)
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
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v4 0/3] riscv: sophgo: Add ethernet support for SG2044
Date: Sun,  9 Feb 2025 09:30:49 +0800
Message-ID: <20250209013054.816580-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2044 is Synopsys DesignWare IP with
custom clock. Add glue layer for it.

Changed from v3:
- https://lore.kernel.org/netdev/20241223005843.483805-1-inochiama@gmail.com/
1. rebase for 6.14.rc1
2. remove the dependency requirement as it was already merged
   into master.

Changed from RFC:
- https://lore.kernel.org/netdev/20241101014327.513732-1-inochiama@gmail.com/
1. patch 1: apply Krzysztof' tag

Changed from v2:
- https://lore.kernel.org/netdev/20241025011000.244350-1-inochiama@gmail.com/
1. patch 1: merge the first and the second bindings patch to show the all
            compatible change.
2. patch 2: use of_device_compatible_match helper function to perform check.
2. patch 3: remove unused include and sort the left.
3. patch 3: fix wrong variable usage in sophgo_dwmac_fix_mac_speed
4. patch 3: drop unused variable in the patch.

Changed from v1:
- https://lore.kernel.org/netdev/20241021103617.653386-1-inochiama@gmail.com/
1. patch 2: remove sophgo,syscon as this mac delay is resolved.
2. patch 2: apply all the properties unconditionally.
3. patch 4: remove sophgo,syscon code as this mac delay is resolved.
4. patch 4: use the helper function to compute rgmii clock.
5. patch 4: use remove instead of remove_new for the platform driver.

Inochi Amaoto (3):
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 105 +++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  17 ++-
 6 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.48.1


