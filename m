Return-Path: <netdev+bounces-190694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06777AB84C9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDED9E6967
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB509298241;
	Thu, 15 May 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7aCdyWB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99ECC2C9;
	Thu, 15 May 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308470; cv=none; b=geZfbIe7QmEtGSyRujWPDL+/UZrjY5gZFUWIxJ5Eu/muolNAbWAlPvaWv20PMLe7wLzIiA4vEDEAHOWn91y92/XtvUtVVy60grk3NJCikgSkRjgZFTIzmnRJPO2LhwKbndsDphqdnTYzDmpSpeeYK/VTlUq87p7rn45yLQJjy+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308470; c=relaxed/simple;
	bh=IHEbxTdfFrUtfZog6KNofPyuX8tZOMngVfJeR70MBG4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oCzaIbOwpXHSmA7DxSE04teblsbEbRFtmIRdZH5I/C7JT/vVGfRALxqJm5xTaVtEPpNY2v116WGoObIq2oARhejf8bO7CwaZQrMWKzrZYQ3ii3LFUqIOFDxYprWBX3AxHkmaAcfxvKF9Lmdvf0uDwcKVffbJftP9JKUfUn3ekJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7aCdyWB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso6540895e9.0;
        Thu, 15 May 2025 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308467; x=1747913267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Xm5zeIBlrs+HmAsFhBOQv0MoMNMWkb0X3GIsfScBU=;
        b=j7aCdyWBHq/GPtnXFi54dpjUwM+CM2ZNfW24VcQOMRcdllTafzvXYlrwkAbffJroh9
         J6idLfcBOETBPvafy97+YfErNsynNVT1rXLWsJ2Ba0gIHL5vNuY0k9s8LB+7ZFykyME4
         DPtRV97NcR0pD2bPImORC1m/9yH+yWP+J1LSpR8+sEf4l2HHBmP2f+iVTQy+ZeoG2vgb
         00vkzMqLr5GJZxlf+y5ujTCjSJf+A7wF6eaED1D5U+Anu76fYSvvIilccFzPsLTdWAvp
         w2w5m3Eo1DVLPIt9E7AubGv+/foRooTvk71CYrroBOHcE/lLFwTFJdK2V1IOWxVCbSiw
         kLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308467; x=1747913267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Xm5zeIBlrs+HmAsFhBOQv0MoMNMWkb0X3GIsfScBU=;
        b=doAnaMJ8U2/IdqCU/LnhEOGPRrhDFoADd9/beRyo6bcNuan33aeyTKxFrH4wX7Xk+R
         3u/3XeRXysX8fF3cuCgxovqu43wYGzwU1Q+1pbnWJyh2JgX1TPXwu93Q3ska8ahxEBSD
         vP/ES/rOi5AnnsB1hIxQ1kron8pbtjH40x7WZS1vBzmM97yjS6kzfJN8rf6XPG4/OTyk
         R72fg56xwbaVRN8xrGMBsMFLnKAmZysOFmw4jBbayDLe6ZChrkAedkYCG9ngT1Cnhtwd
         vM6xPHLlgAUNaDD7xHvf16IFPS7pz2tMa1WapXNmMRvgMgBManSXhHA6+eB6tMyEW/2L
         ZmWg==
X-Forwarded-Encrypted: i=1; AJvYcCU8lqXCCm4c1LYfuX52dNurhtpLacyIVWvaJWeqAP1cBeyswp2EhdH2UwWcE3J00FTl9TwlvisX@vger.kernel.org, AJvYcCVm4Ytw/tYUGhjiXml3zm633VfLPCX9QEt83MFQPSNDSkzaQuzDQAy3pQre0i7nGVJlcQpi+gQC/swjG3vQvvo=@vger.kernel.org, AJvYcCWqde1auqfVCL+6eJ19inl6uozte+lQg3H6ItxMZ5D108596KIp2DzuaNSHIy2Mh49W5guN2wuEuepg@vger.kernel.org, AJvYcCXtOwpvWTlNCBOm92AMFfcI3WYE0/Og0qGwCTD/DXCXoTOCeO9B9JqQ5XHpujUBa/MpNd2lefMmB8/D/xwF@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwgVl8g9bfCDmoxUz+TFpWl7jk0JQlX+ctWjKMX+dXiXhTdkG
	GfxE9CUxz+qA8zBwI+NhOuD11IwhUsz+1T3272Jcda91i40GFbCi
X-Gm-Gg: ASbGncuNPHYZppBXNJEFoQBYyLp0vP2dVLqb+VF3jdvvAcJI/SjiF6zRp4tIG4TQIQ8
	V4kJoORYPiDDig/ITlS//KujX8HPmO3hILMXzhcGAc6uPn6f6pSSR26cBoNflJ0wiSA2K5N7MtA
	FiwLrHuUoTSQK6Y08HFtmunsP+A/Ozxs6uPMIZRSS/D01ndPuNT5dn6HJH65SAAfrobZGLYrjl3
	xzvDMlzYQaY4w5rysZB+vUvXidHbXev/peLnJfdhM0mZWMDAJCIbYOGjHe6cQ3Oreywt46FS0dS
	brF0Rwx+63FkNtg1v1Zx7fpnVyKOUBf8s68UbCfQ9AlaxR8Ggpqi3Mp0eDX0aRxZJWGAW6rCtlz
	sq5962SscqytGmC75E3ds2gLxjL7S3QM=
X-Google-Smtp-Source: AGHT+IGrR4bvumvCK+BkPJcNYl7XLyNLoFZWi1UDL8VOie04vvoCc/DszG+qwTtfSpXLyEjD2+Xdwg==
X-Received: by 2002:a05:600c:3f08:b0:43c:fd27:a216 with SMTP id 5b1f17b1804b1-442f970b20dmr17777375e9.23.1747308466763;
        Thu, 15 May 2025 04:27:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm64497795e9.20.2025.05.15.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:27:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [net-next PATCH v10 0/7] net: phy: Add support for new Aeonsemi PHYs
Date: Thu, 15 May 2025 13:27:05 +0200
Message-ID: <20250515112721.19323-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new Aeonsemi 10G C45 PHYs. These PHYs intergate an IPC
to setup some configuration and require special handling to sync with
the parity bit. The parity bit is a way the IPC use to follow correct
order of command sent.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x7500
before the firmware is loaded.

The big special thing about this PHY is that it does provide
a generic PHY ID in C45 register that change to the correct one
one the firmware is loaded.

In practice:
- MMD 0x7 ID 0x7500 0x9410 -> FW LOAD -> ID 0x7500 0x9422

To handle this, we operate on .match_phy_device where
we check the PHY ID, if the ID match the generic one,
we load the firmware and we return 0 (PHY driver doesn't
match). Then PHY core will try the next PHY driver in the list
and this time the PHY is correctly filled in and we register
for it.

To help in the matching and not modify part of the PHY device
struct, .match_phy_device is extended to provide also the
current phy_driver is trying to match for. This add the
extra benefits that some other PHY can simplify their
.match_phy_device OP.

Changes v10:
- Add rust patch
Changes v9:
- Reorder AS21XXX_PHY kconfig before Airoha
- Add Reviewed-by tag from Andrew
Changes v8:
- Move IPC ready condition to dedicated function for poll
  timeout
- Fix typo aeon_ipcs_wait_cmd -> aeon_ipc_wait_cmd
- Merge aeon_ipc_send_msg and aeon_ipc_rcv_msg to
  correctly handle locking
- Fix AEON_MAX_LDES typo
Changes v7:
- Make sure fw_version is NULL terminated
- Better describe logic for .match_phy_device
Changes v6:
- Out of RFC
- Add Reviewed-by tag from Russell
Changes v5:
- Add Reviewed-by tag from Rob
- Fix subject in DT patch
- Fix wrong Suggested-by tag in patch 1
- Rework nxp patch to 80 column
Changes v4:
- Add Reviewed-by tag
- Better handle PHY ID scan in as21xxx
- Also simplify nxp driver and fix .match_phy_device
Changes v3:
- Correct typo intergate->integrate
- Try to reduce to 80 column (where possible... define become
  unreasable if split)
- Rework to new .match_phy_device implementation
- Init active_low_led and fix other minor smatch war
- Drop inline tag (kbot doesn't like it but not reported by checkpatch???)
Changes v2:
- Move to RFC as net-next closed :(
- Add lock for IPC command
- Better check size values from IPC
- Add PHY ID for all supported PHYs
- Drop .get_feature (correct values are exported by standard
  regs)
- Rework LED event to enum
- Update .yaml with changes requested (firmware-name required
  for generic PHY ID)
- Better document C22 in C45
- Document PHY name logic
- Introduce patch to load PHY 2 times

Christian Marangi (7):
  net: phy: pass PHY driver to .match_phy_device OP
  net: phy: bcm87xx: simplify .match_phy_device OP
  net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
  net: phy: introduce genphy_match_phy_device()
  net: phy: Add support for Aeonsemi AS21xxx PHYs
  dt-bindings: net: Document support for Aeonsemi PHYs
  rust: net::phy sync with match_phy_device C changes

 .../bindings/net/aeonsemi,as21xxx.yaml        |  122 ++
 MAINTAINERS                                   |    7 +
 drivers/net/phy/Kconfig                       |   12 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/as21xxx.c                     | 1087 +++++++++++++++++
 drivers/net/phy/bcm87xx.c                     |   14 +-
 drivers/net/phy/icplus.c                      |    6 +-
 drivers/net/phy/marvell10g.c                  |   12 +-
 drivers/net/phy/micrel.c                      |    6 +-
 drivers/net/phy/nxp-c45-tja11xx.c             |   41 +-
 drivers/net/phy/nxp-tja11xx.c                 |    6 +-
 drivers/net/phy/phy_device.c                  |   52 +-
 drivers/net/phy/realtek/realtek_main.c        |   27 +-
 drivers/net/phy/teranetics.c                  |    3 +-
 include/linux/phy.h                           |    6 +-
 rust/kernel/net/phy.rs                        |   26 +-
 16 files changed, 1359 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


