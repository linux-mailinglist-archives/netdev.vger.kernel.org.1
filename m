Return-Path: <netdev+bounces-191174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5ECABA50B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C9D1B6775D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF07280029;
	Fri, 16 May 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMPSzhVc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A726B0B3;
	Fri, 16 May 2025 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430666; cv=none; b=MCbxa/z3Wu+xVTqrusr8ALU6rcfiwpAc8oqivT5Fd4SV/erme8IHioGTJhEfLgHUmN3yqHLkiBLBhCoTSvnzNRMsT1TSg2gZQQ8b0mmZ4FSqwtcLwMvvp2t2BSI+T5JyfcA7lya6HyDuz86vrYJIB00uGlsndZsPVt9hH60YDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430666; c=relaxed/simple;
	bh=6JWtqOHadcjsUf5CIy4bEylZn9nAVubWr6zqmBXJYRw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BGT28E/x0ZVsHGt1uckoHHf7UthSFRwuNZUInpEdV4gTeI+sMtIWx0SYDB22C2SNnhvY8KEiSCzszuoFQLrUPlGvF4OX9a2gFT4svK2Ozx7LmvCYqCj86iAg5ZCIrB3+FkKt+KluZWrdoXKGhhgVgbLeDK0QMUHElojThSHQXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMPSzhVc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-442eb5d143eso23417445e9.0;
        Fri, 16 May 2025 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747430663; x=1748035463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Hta4W1dPFUTar/rJllAxygYiLl+WXDAdv6ahBc1HM=;
        b=DMPSzhVceuuerH/+YBrHMae9vv8uE9S/D0mj8/TFLF/6KzW214RYw4saf74VxuhIWy
         EN+Ph4GbfNA7FLnUfAc+C6RovC5KXDltX857kWrZHsX77PYl2hNXuVa98CsEGYWBWe3s
         CFUPKRR/qkhGXmfz4E1ZJCtrJlViuooM6k8qQTmu8Z29113kd+sdVZ8qaSS2Yjrogolb
         0x0u8I7uOVWykWXh/9xclWXy5mGRsYTuqQoqqRpTs8adCgM+as0e4O9msIvXqL9l2q5a
         jAFrCHcWeGthY0cK1N1TC+aN0t+kAK+28RFXp3IHh+F9VPwU+ziLdvQauQSn2f4rXAyr
         +meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747430663; x=1748035463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Hta4W1dPFUTar/rJllAxygYiLl+WXDAdv6ahBc1HM=;
        b=kfTfiELJg/4+cjenwA6GgeESSHHO/opYDzAFJ/q+KUm22YLAqoE8gu55hd19Qsx72O
         vRVLAVa2Sjcf9h0yZXENZLOUy7G1GsKsbgRwJAaJnUTuKCEgTR49zVkla2VPwN9ZzSNF
         mZOPPEU9dJKXIhaUgwzFfUi5NDuLWVp6S+Uvj9wnJCCfjkNdfXPhsMN4hK8oM0VgehNS
         5UjGGzV/640iBRRAz85JWSYsucImLt55GUdE+RhH2L2fAeBigJ0GwXU40EjUUCPP1DeM
         aRSoyeJPpyUHhxv+ImOKjuSYjR8H3pcuRbBbtlYKiOltrO8Z4CoMDMS/s3SLKehLMGsV
         +IaA==
X-Forwarded-Encrypted: i=1; AJvYcCUGR7ncu2aGEh6X3wUyUvjRxPMuNcR0zCpG4pWYf4CHj5A40TBMTc3S/qJSwljdtF2iuzhsn4lSGU15hfrl@vger.kernel.org, AJvYcCUOx4suIc59hbbb9NtxleVk/u+8MNxTSzZxN/gKGSvtG4oqpq8z1umaOAXPBaNk4oM8xGaJI+Yd@vger.kernel.org, AJvYcCVTEUheFYdbL5z13/PUyMyo/L16jlBPzAWn97sVHyTYDkDB2H5Mrkd7UDrtc/O9QdaSBRrFvqz42j1KwUS4AYM=@vger.kernel.org, AJvYcCXEIx7G7sHDPDob269h5HtpazlIyiz2YNbc3ZmZpqncjlpLCe/syfIxS4VbynPj6sWXTGe/lsF6i6JC@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvelwp2L5rmDU9J14ELECL6zNk+ABTtQBCMq9n9BkuztY8Wrl
	X3OD0dJ8dkfkCcctqI8TrOBXhKds65TflIyQg85ndywkiVdKp9Pd/D+G
X-Gm-Gg: ASbGncunTIQ+XvcxORD3lR4LYEmE4Z/iFY1jr1OCdsN0Tf3/wkJfb8ATXH12uFIkbBU
	3Oj4sN/32Fb5OZElTWKMYjEU0zJN5goct8vh4s/1laeyaN6BhrBPp430K7runGPbJe41pELcACz
	IbtxNSF0jTNAQ7PlHoN4Z2mVabeUxkxAAvfpMODaIxJXc9wLv08OoKjvwJF0jFN5wh8lJUKahRH
	xrnpImDOekYchAzSJh+vKkp7M/KAFf7mOfuAn3S27cYeYSPgTtqbNljKAu8E63BzGIGHIS1PgMn
	S+37yA3Ff0TMryw+/My0Fy+clDaXUajlbEr472obL/2GhSwbO9pwMbNeWsCcEytCHzBz2bnncQs
	o8zQIGT6zEhLAx/EdEkGR
X-Google-Smtp-Source: AGHT+IEo0u5x2s8Yof4YAfr0AOlCc9AbwKoIkjnv3htsZOGqLDBbTKC7E7kYNwS4cOoUxYSIeGylDw==
X-Received: by 2002:a05:600c:4592:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-442fd6649d0mr43553545e9.22.1747430662720;
        Fri, 16 May 2025 14:24:22 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm126293555e9.32.2025.05.16.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:24:22 -0700 (PDT)
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
Subject: [net-next PATCH v11 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Fri, 16 May 2025 23:23:25 +0200
Message-ID: <20250516212354.32313-1-ansuelsmth@gmail.com>
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

Changes v11:
- Move rust changes to patch 1 (improve bisectability)
- Improve rust binding with suggested format
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

Christian Marangi (6):
  net: phy: pass PHY driver to .match_phy_device OP
  net: phy: bcm87xx: simplify .match_phy_device OP
  net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
  net: phy: introduce genphy_match_phy_device()
  net: phy: Add support for Aeonsemi AS21xxx PHYs
  dt-bindings: net: Document support for Aeonsemi PHYs

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
 rust/kernel/net/phy.rs                        |   22 +-
 16 files changed, 1355 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


