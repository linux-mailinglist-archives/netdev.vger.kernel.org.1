Return-Path: <netdev+bounces-191312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E8ABAC43
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8748917B2AF
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D0214A61;
	Sat, 17 May 2025 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfRSBI1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D641D514F;
	Sat, 17 May 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747512869; cv=none; b=j5PbEI1Qsm5bVKro6SvatLfIF8G+lA1hjtmCz1j6D1V5MvuIT2u1805V+sM4XDQEY+Ajdg9P3tesbJbCjZcgdxdNcttWYFmnbaf2EnqMrYVJN7zNcRCCSLKNWHdIF8LO+lLRI1D/Fs/MMpqxPANKFSuRQyvXZ1YxFOvXr4Rb3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747512869; c=relaxed/simple;
	bh=HXbn1+RrY3iLubxyMHw46NyN3y3son37AiJ3/DCs1mE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hLo0hqdrVY1qF0RG1CTpELdu7OIpa7BUh0soJPwc1S/DzMqzYpWmg/FJuo7ufk8heffxZM27OAGze7wyDveEuzrjxC1jrgNV7QsX2g7jLjLezG0QNjfT/qZQpP5QX9VpH0VOOX+mPoKnqE1HTm3xeNZ3yV1kGNY+SDUAkbehUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfRSBI1L; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso23412425e9.3;
        Sat, 17 May 2025 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747512866; x=1748117666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCvHIqlGzRcKnI1FKq9XzdqttRgsB4lx9xtiQq6eDzw=;
        b=PfRSBI1LA7c5uwF7LRBe0YOM+xRhkYCQPcwG2cUK7trXyIAdyNayeP+4+SCNri+aEO
         xH957K/FtEOI0R9AU/ogg+NsALa8y4A4ZaLvALk6Lf/57FBJaVqkM1PmVGpwTg/RwVhT
         INakXaLPV4ixojw4MBI0BDPBzwVjANL12U5ejPQC+xZlkJs2ZnvvteKgH/DhQ4W7BEsk
         A3JdYyYO3g2qLmQMJQujO5myE6tcATh7xzzn2139fLpLeiP/3jEVsfZZ0CUSn36A0omT
         JdjuG3b+pH0QgIF6Cgc8obGS73TWIX4OOJS0P51h5g3+9OjMuh+t/GV4fpvzDUfSQ+s4
         /vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747512866; x=1748117666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCvHIqlGzRcKnI1FKq9XzdqttRgsB4lx9xtiQq6eDzw=;
        b=Nwg8PGcEAqjU/j1XPThrShjsHJ9Tm4Xvleev2PxqbCUbPGaExW4byS0Pn7um41anmg
         nyXvIv1d0J/mleDYjBOeqg9/aY6SoaPO0d0CqOJoDeJEHsngQFEnviERrutTFOzJvNyF
         R62EbPdrXtZMrBKlStmzcY/hQx/DfgcvZ+Wobiq1YYawo4jO34pdHZUstEWLy6D4L5ZW
         iz0X+ySIMaPuTU6efGwRzPDT+JfF4/pe/TgkQ8Ns8vkVyuHXSDnTUnyRFPnjwx2CGiNf
         eAB+Pj4EbT9/QY6I30Ij44Su3eQmuZLpClhl88+sNhO+D6otod46BPfxcT05dlJOCic/
         a35A==
X-Forwarded-Encrypted: i=1; AJvYcCU+I0AlZv4fapI14EMIO5E6KXKwNyzGr46YRZEKwWx6qzfDc/IQRsU4DFKxpKV6yDIBjdylMdMf7HKa@vger.kernel.org, AJvYcCV/oC8QjA7O/fLvQQFdcL4locZWxPCIF25hDquPFhbLzNhjZipKB3JfysrVY3/CwumkbYUUdRdY3jcEYJDQaDs=@vger.kernel.org, AJvYcCVyX2oVOoTh0i11GXMKNey8UeIOq8LS0HsO9zY96Jr7lgOyMdunG0LTiOMxjIYFGcN4UEeo9ZnE@vger.kernel.org, AJvYcCWb995lEdfqPaHJD/niJiDbkm58shyKcEksLpFaorAVod0g0YD7DG8CBNqD3skKE4au7uwK4AOFuyRAFxl1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywor12Ts8p9peVnx6gD7V7NBjAxJ8g3oFAdnjcXusHJO8GyCGWT
	NMg6tfdLCFQshfUrN203/vtouwQRLUCIHsHzCpk0lfbSfyazzBPtAmad
X-Gm-Gg: ASbGncvE+NHDN4BdIa4e++W1U6lD4gj8sjmAMUyj767wztjXCFbOMb+zY6O+SkOIDzh
	At/JGp9+TrqXHlrxCJ4dUWR0vZrst/VoScMsQ3myQb4wnvzJbtz/PdN4DBhezOi8Y4ovS0SZVj6
	OpEPeRiWOfJbUejAvbgWNwy9riKRp1Tpnm6m6U3TSzqBSNvyu6gkrYNS8FkAD/MQz4sQU66YlGz
	JMDXUTrkeNB7ug08X58pY2gB8Qdh1FlkBukVrxyfny7rWXPVpBLNb9SoxQECkhm8qTpmJvGl2BR
	v3a5YkJ17MVjfi8R/suSHIc+l+7gaU4dYHzie2w/pfPNXOYkvFAPr4TX3W8MwTw3KLsKJzacs7z
	iPyq0pXVsqfSrn2wPo8ew8RS9qvsjeOQ=
X-Google-Smtp-Source: AGHT+IFZoJ8Yjxduf+vGspnXxJQXpbyL9Y29qr+tG2Ws5wF8lpM5OGwu7P+z945AxiGwVbzSYEDuGw==
X-Received: by 2002:a05:600c:1da4:b0:442:f904:1f31 with SMTP id 5b1f17b1804b1-442fefffbb5mr77413065e9.17.1747512865510;
        Sat, 17 May 2025 13:14:25 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4fdcccsm85345445e9.6.2025.05.17.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 13:14:24 -0700 (PDT)
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
Subject: [net-next PATCH v12 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Sat, 17 May 2025 22:13:44 +0200
Message-ID: <20250517201353.5137-1-ansuelsmth@gmail.com>
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

Changes v12:
- Reduce Rust changes to minimum compile (a real implementation
  will come later by Rust team)
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
 rust/kernel/net/phy.rs                        |    1 +
 16 files changed, 1337 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


