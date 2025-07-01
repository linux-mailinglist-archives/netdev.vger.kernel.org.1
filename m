Return-Path: <netdev+bounces-202713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693D7AEEBF9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E13A78B6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D52B9A9;
	Tue,  1 Jul 2025 01:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmKIPdZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBAB660;
	Tue,  1 Jul 2025 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332671; cv=none; b=entENkWs3xBX0v1KqVhgkxlxuEC1RTVqv25+kJm8L3x+fZ+TqDm8W5XQCFWj6rT8EJBLo6Rlmz2qmaM2qdLkZyAsAE8KbAWgLSkzSurYYKcnJRIhMCz1vdUHhW1dfBJJXlyL6t6g5mpEqBVrWizRjw6hoX7rmdP3f4h0J3s975o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332671; c=relaxed/simple;
	bh=TGlE1ClG5lRsETj4AoTpjuZ+SJ6lqQwK3MaW0+seb5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TH5fNWhvTj1y+WhJC7MZIlhqUDhqSXcTYsWyKowG6xg2kM21hkuNOM9/tGkJR9ta59bQsm8Qvk35ahIu+wfjem5onhg2gwa9iqadZ8jk8y5PkJ1RY+BgPKPJeb48YjzV2o5gen+ylMjfvzdjykiIdBdSZjY3JQn5OPP+RW+clRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmKIPdZG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747fc7506d4so2419036b3a.0;
        Mon, 30 Jun 2025 18:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332670; x=1751937470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ5PSiL5QPW5hfxzuODNHVt+lrCUk5bVb4SwiUVsQ4U=;
        b=jmKIPdZGOWDMW7T4SFvcFqLI88pWDXbmrr7nD5B1frVySYhbF46agB1JyNc5Y0nmSA
         4oKVDCOJAnXClqkeaH8xZf1/911+2m4tcMOlp2C2gGsf/9OAg8hIOupZxet6zCnLVLYm
         vuaFSmefvqHFzDTQ5g3xntIi9l5tWgjSbt1U/BnXSjTnHmrZOEFmJ3Fuk/BvtNwmjxZo
         thoZww93YfLigvTTSYtt0o3DDvg2OmOQ/v4ezHv/Y6aDfeiQRPCBPWvXYnUTXtvaAkON
         dU/GvMhdSa/ywl8lpcRaWy56FxPwYec/R5Qdo6UHBxeAsaCRpdt+YCkYOPsgJZQjSiXD
         AyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332670; x=1751937470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQ5PSiL5QPW5hfxzuODNHVt+lrCUk5bVb4SwiUVsQ4U=;
        b=BlupS2EP/90CPhfDmg+I3WMJN5dtGvXXZ+Z13EGeMvVVmrFGkunnU3yW2kHImGlJlV
         yLwO0Rdl3fd3dGYGU8zgVGSQcB8nXMIdNhATwgHSSdlLPlQf2uZ/eSoNPE+G1/4N27R+
         HkuSK40DDODVtv1D3Kq/8fcHplh6FA+xm1xkQQUJ17qKd+ZMSPsG5IDa40OJMxVZorAj
         fcxepVXmYw4MdrvBpaPwBG2IxL5vLCwKycCxROObHGJ7+MXbC2rTo4YE8y1tCLyAUB5s
         WWyQE8mbRGKHs8PaMYVbnRa2yw60yKm9aIJhulvD6AbZa4J95SjUiQizNytGevd2RPkR
         RSdA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Axy+7oMrdvop1L0jO1iSZyNYGI+NiiwsG0A9cYhrJkMn3esn75hnAfj6YFwGnOK6QTn+TKZhIaIZ@vger.kernel.org, AJvYcCV1pxf3aY0pA5oKgqCG5DXPGzbfEHiSiTEPGBNHKp2/CjRVwxGY1u7tEJddtybVbSh3Wv3NfcM4RW78T0l2@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjohrzF1UuLkkoAPV52aF0cJngqt7M0VHgMUbMol+zPW3OGWj
	Jvb1QUOpHUJNTdP6Yh992js+mG5FPdX71xLHlWM7hdZuxFs1XZhmKkzJ
X-Gm-Gg: ASbGnctQNWQgbFTKevXFB6xSuRNn9JErjZTQHSEWDiMrhtqdMKSVl16+FKACHAqWD48
	smLntTMa5IwPREN7XbjmKScHg1iKgtSOys9ZVjv6tDzKUtHvqv0UTXge7KVB098uBA8oW4yYYe7
	Th5nPJW/B+PJaerJZ++0r2tqlTL0TS/M2Yjtfh/i83C+xINtHa3eLEj9hrQhQCmkQcfoK5qZe1S
	ImCpCQ7dQ0WNEPl7r4xfYOOP2zdnG+wm+gKYEbMkM7LLfsREgbwAkhpZce/cXDDuvaVLx8rFJxX
	guQB1KOLGLY+uTMa80VkU9HFsYI6EgfhMMZFIer1EwKrBc1HU5nQhAr/EmS0lQ==
X-Google-Smtp-Source: AGHT+IElz440y4qt2E6KOe7YdVb1HqXdStD0Ju2Kyn/eXs9IIdlP1Xrn5joO/n/a2gIxs2JVHnRjPg==
X-Received: by 2002:a17:903:2f0d:b0:237:ec18:eae5 with SMTP id d9443c01a7336-23ac4633e8cmr229326945ad.27.1751332669591;
        Mon, 30 Jun 2025 18:17:49 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e301cd38sm9250116a12.17.2025.06.30.18.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:17:49 -0700 (PDT)
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
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v4 0/4] riscv: dts: sophgo: Add ethernet support for cv18xx
Date: Tue,  1 Jul 2025 09:17:25 +0800
Message-ID: <20250701011730.136002-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device binding and dts for CV18XX series SoC, this dts change series
required the reset patch [1] for the dts, which is already taken.

[1] https://lore.kernel.org/all/20250617070144.1149926-1-inochiama@gmail.com

The patch is marked as RFC as it require reset dts.

Change from RFC v3:
- https://lore.kernel.org/all/20250626080056.325496-1-inochiama@gmail.com
1. patch 3: change internal phy id from 0 to 1

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


