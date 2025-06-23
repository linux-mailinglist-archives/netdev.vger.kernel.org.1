Return-Path: <netdev+bounces-200101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5DDAE331A
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1B7A61E8
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C5179A7;
	Mon, 23 Jun 2025 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE/1vhj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCC10A1E;
	Mon, 23 Jun 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750638660; cv=none; b=di+dnIpfLRiHCtE6/2YKKerd7xkOpG+giCVazNjP/K42ED7NZwIWHE39WowlQkCfcWoGJSyU4sg0uEW065/K4PVcPZk4s7shvTNJz7wWHsp5TQblFZ4lkjUkt4Fd0iBlH6qhpP1B8icCum4QATSiCt2nGRxEXXSsxy5rg3etsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750638660; c=relaxed/simple;
	bh=3J9d4REFKBDwJnziIZAxTparxDIgPbaqYezCh3xpY6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1/HnIUZ/ZVXeyaGnlgVJg36EU+hw6etnxjrI0k3Tv6WvJoqbm3pqfTpSdK/k42Kg39bYE4vy7Z3C6twOY2Sj0DqJDIKr3vKTCQP92QLYE0uSrH2kIDpaPES4zzS4qSatQQn15W5i39NGAxi2nw4NTFc5pWH4ENKlEGa/YgSVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE/1vhj8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7481600130eso4408874b3a.3;
        Sun, 22 Jun 2025 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750638658; x=1751243458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iljGygD1Q6d7ScReIDOoZWXtLgtOIhYkJ6hRy1R+TEY=;
        b=QE/1vhj8C93Q/kfgaY6pDSWMSpaghfvaiPjakhFnTlW8xrCCW50cW6icB5G9f4hGU9
         AevqEnJMccPQafb4EqqCbmY8ldJf6/V1nGJ7FfVqiQI9ly4nZ7k7AWyaQoHvKbjLQNrq
         obixMwUr3hvTjXee/ukVk9aAZ/91kFwIHT9g90JKxCx2tWmjsmeVBGDA+cLWf2Se3EjY
         ud6yFinsBUUX6sblJDCKD2xm7v6DA3dmsiS5ElxF6yAppf7QWURmn8WA3fVnYBqwUp4P
         Gh9UHQTBw497vTXr1Sa9eJWlh4frSn/IEf8+NVWnZxzeQIdDi42dzHXh7zfFLklS+HqN
         Pdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750638658; x=1751243458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iljGygD1Q6d7ScReIDOoZWXtLgtOIhYkJ6hRy1R+TEY=;
        b=oXz2KDVXNcndvv1QarSjPRxMcH0TwDTN4JvPXOIDgy8Zk81d0ntwyp9AiJmnXNis2p
         oVQxC03vRRP3P+qJqyMK72GYFGLIIKWnkLiCfhcSLtJOXd1qgRAnO6UG2soW5tIzB8ws
         4Lm4zp74xONjySAy0OfVDy2gt+kwu10dy9MxZJvA3yEa4KTmYBbBNB3aAK8yIFlovkj3
         t1G0ETZWpw8HUnQffPVC61eo7ukrNTJiuuSlIr5PL6DawXW2oBl6fbPS12kvJo9jLJCo
         3aVe2m36Bxx7mQ54LZ578ong5IuupRVA/5dlGoJmpfIs7yh3Pg3LONHkH9ynqNoXd1mf
         UYow==
X-Forwarded-Encrypted: i=1; AJvYcCU2zoE4IJtB1sbHn9YT7j0kUxrCHXP1exHFmnwKpxI5qPWBW2y8NyINM4xKA7cBfhUpTkNdODNNCb3v@vger.kernel.org, AJvYcCXGjfXAeNjpmHIfJqc8JDYi84V3l651PcCR+VdbQSSqQ8pzacgn+8o1OKmlZb8Q5otNjhVArC0H++VtTFuK@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYzenvQPQTjotexHE708nLXLI9ApvXmgFmblbbeOGoMRag+rz
	FsYuQkuH1bTDJMTSRJ80zZCTh3/T3kH01zDULqXplMxHrH0+hyN+yE9Z
X-Gm-Gg: ASbGncssjYOFStszoGTh1u2K86GXY4mcFGY0GIchhHg1Q0UDmf4nAYg+hIy48eMulKA
	PqTe1gaXkkNGPvRXcf2CCbwcvXYzFnY0asTXNz+VrEdrkzgDAukf3umPu6fOW5Svok0IqURWhtV
	2dQ2J3TgG5S+8lW7+T3nKjU4+mgn4GF9BJZxsLIEaXXs5QbxBwv9Z5QIeCt+Yqsjtaz6ODf0n5f
	sJm2j64YNjTOt9Z2AxtW7hnSKz0OfPTJEI3QpACNN/a9Oe+R8GNeMLrI1TZNUnc7U5HOCbACSvR
	pj5A6BbjiSSph/GTC2ESk7TgdHCbnjpMSA5MZpXiI6S4BjBVW9ouPzeYFSuTtJgJ3O32TA5w
X-Google-Smtp-Source: AGHT+IFxKKprEgj0UFVm9wh0Cpkbq08sPxFBqdL/D1NtTk0oMZTwt0KwJTTh07EjdB+QJCVwDh4pZQ==
X-Received: by 2002:a05:6a00:170b:b0:748:eb38:8830 with SMTP id d2e1a72fcca58-7490d75a080mr14587231b3a.13.1750638658187;
        Sun, 22 Jun 2025 17:30:58 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a628108sm6888755b3a.102.2025.06.22.17.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:30:57 -0700 (PDT)
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
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v2 0/4] riscv: dts: sophgo: Add ethernet support for cv18xx
Date: Mon, 23 Jun 2025 08:30:42 +0800
Message-ID: <20250623003049.574821-1-inochiama@gmail.com>
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

Change from RFC v1:
- https://lore.kernel.org/all/20250611080709.1182183-1-inochiama@gmail.com
1. patch 3: switch to mdio-mux-mmioreg
2. patch 4: add configuration for Huashan Pi

Inochi Amaoto (4):
  dt-bindings: net: Add support for Sophgo CV1800 dwmac
  riscv: dts: sophgo: Add ethernet device for cv18xx
  riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
  riscv: dts: sophgo: Add ethernet configuration for Huashan Pi

 .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  71 +++++++++++
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |  10 ++
 3 files changed, 194 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
prerequisite-patch-id: c9564e611005b80c0981ad174d42df14fb918c18
prerequisite-patch-id: 9e1992d2ec3c81fbcc463ff7397168fc2acbbf1b
prerequisite-patch-id: ab3ca8c9cda888f429945fb0283145122975b734
prerequisite-patch-id: bd94f8bd3d4ce4f3b153cbb36a3896c5dc143c17
--
2.50.0


