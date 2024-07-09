Return-Path: <netdev+bounces-110154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33792B1FF
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40521C21EE4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D2C152E04;
	Tue,  9 Jul 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi44dWiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CE152790;
	Tue,  9 Jul 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513350; cv=none; b=aEzbZep6AI3og2ZaFt/8pomxu0IJiTCKFgeFiQBZ+77VNtR2JlZ08QCRxYxih/0RA/DBob4R5m8KhmJ/92Is3A0Q3vT+fqHppoPTjEp1IBE8WMFkwR7YRjgv0SnBibYc26bSH2OGUvAVH7XTbKVIZLAwdmk0EUTNAYtbydgkU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513350; c=relaxed/simple;
	bh=Wzu/DaEWdpVdgeT+yN7K17zx9JZwRH+Ao0L+fCXoQrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlcGmsnBFtoYA1WtHXAs2TA68LOoHivAfbvAQQAc0TBs8oucIO16kT/kYY8oKh8nXCcJcQxeMyZgkweTUin4U9Qcvr/9ZysBQQT7Vj3zTXiav0pgt/fr7HiGpDKsIJadobsJDRxerZOaw2pLftIY5OJwoV7UaZ6OCrA1s3TY4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi44dWiQ; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c1d2f7ab69so2512831eaf.3;
        Tue, 09 Jul 2024 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720513348; x=1721118148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XDcGnxl+L+Up+OM7xPAJaHLrc0hSR9f/AUvnRoMTks=;
        b=Gi44dWiQl41S1NwNnIilOSN4iTWZr2LDIajYoJSOGwoavBp02VTrIk2AFF7Z4cFuQq
         oxhjitll4yAkswF8qPHdoGZz5wktDu+F8jVUR5blzUIHOEYW3OvK5MSRnI0dAZrXfohj
         6v0WMu+TSnsG8XFXdImbfuT1zhnRNQHePFIexnTnP6QfNqUJ0/EZy5GrDCzGdm45fDmw
         xBIiO7BeY+Ow5Ucmndap7VxwKmaX8x4bR3BtvfV9C6FofYL0ZQQLhGwJJy3iEIjqjNVn
         MJMdbCYS4+2jqlwy5Jzw8bmjEMmOD6qEmpppqt2+KP7rAT5baeVjaf8sfbtEVrjIeTMC
         2mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720513348; x=1721118148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XDcGnxl+L+Up+OM7xPAJaHLrc0hSR9f/AUvnRoMTks=;
        b=mUPnT4Qp5ZtgyAFMYwKisHJptCveBoBkc0Whjq1mMmvIH7Xkvr9sxrAUvsTuXhapfp
         IKnaPChYntQ9dDJKC0zoyf89BA3MffJhSgA9BSn+6811FkW8GYK6dTT7/UjYy/z/jp89
         4Gt3Zcc30oTPd7teA7s2PxSjDzFbHjSw3LORfiKGRD1ATcqwCDjF73XQ45qlKPlZwlyw
         B96XzId3s6pQzw/Lj6Z4Fo94KFpgdUuhk41n4khrC+Yp5k9ij1/MsgVVHOLYbh5cZRpP
         AO1eFhftTHKRDiqXbBhm3f6u/B344aiKzPWApO+HtJTMhOeIaqJH8qWCpL7ZZ14BsC4x
         V1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWNRnGd+qezcxcrgLz4iFCgUyx5legTlHy7uWLYEgVtPAGqsQt7KWCYYjDH6aKt2SgUwfTBSpnJ0Tq77v3drRSTMMGeyef6psDD+g7i
X-Gm-Message-State: AOJu0YzGKNYBQTQO3b03GdhqdnO1iWJfKic/10izOi5ID5DHKr5OxhcO
	B7gC18waBHEhg2Yz4jTyq4OaTh8LLhMaEvuYisCT4hQzgzRmy5si
X-Google-Smtp-Source: AGHT+IFPsJC/yKbPpj0KK2U8xPVQYC1rgQUbrnuG7dcUGRNNy6Kjbw0VGZ2c7DelhGUEXHPww0fMHA==
X-Received: by 2002:a05:6358:c3a2:b0:1aa:a177:359b with SMTP id e5c5f4694b2df-1aade0810ddmr150867855d.15.1720513347606;
        Tue, 09 Jul 2024 01:22:27 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a430sm9588929a91.4.2024.07.09.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 01:22:27 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 0/7] net: stmmac: refactor FPE for gmac4 and xgmac
Date: Tue,  9 Jul 2024 16:21:18 +0800
Message-Id: <cover.1720512888.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor FPE implementation by moving common code for DWMAC4 and
DWXGMAC into a separate FPE module.

FPE implementation for DWMAC4 and DWXGMAC differs only for:
1) Offset address of MAC_FPE_CTRL_STS
2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1

Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a

Furong Xu (7):
  net: stmmac: xgmac: drop incomplete FPE implementation
  net: stmmac: gmac4: drop FPE implementation for refactoring
  net: stmmac: refactor Frame Preemption(FPE) implementation
  net: stmmac: gmac4: complete FPE support
  net: stmmac: xgmac: rename XGMAC_RQ to XGMAC_FPRQ
  net: stmmac: xgmac: complete FPE support
  net: stmmac: xgmac: enable Frame Preemption Interrupt by default

 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   6 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  66 ---------
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  16 ---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   9 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  27 ----
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |   7 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  30 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 131 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  16 +++
 11 files changed, 177 insertions(+), 134 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h

-- 
2.34.1


