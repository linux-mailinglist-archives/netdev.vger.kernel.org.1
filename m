Return-Path: <netdev+bounces-189565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604DAB2A58
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F3172A89
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236AE25F7BD;
	Sun, 11 May 2025 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k273QYcX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F421AB52D;
	Sun, 11 May 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988823; cv=none; b=QsBDPfA4MaqgcsWSxJov4K+nUviyIcosKwfJfs+HDZ40mwNEzy+9MRByhpyuMaevMfeCtk8yR4MtJc0TcX6/gl+TMHVrfGfOYLEEa0zGhc5ChnRPwIlBTVWAjLvKoJTwdznDvAko4z/vHZpA9Sglzj5/VTSKdnBY1r9LSuLtFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988823; c=relaxed/simple;
	bh=brrbRgbFiOAnyfmFKlIucRtRi5mV7FlRemli21eA7H8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E840FuED/swH/cFjT+/KjRAJszs2MftSq0t6KoKB2d3IfLq+InRb/6HX7sRYBAudi4O5tlBJrafEb3DfhuzHon0XdYvPvrLOR0wvT0k/ZDgC/8ite9ZnFiyxv5SwE/+iHZkWKdQrFSClV781h5aDSPPhmlEtBpT6uWCc2klc654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k273QYcX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edb40f357so24692595e9.0;
        Sun, 11 May 2025 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988818; x=1747593618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfw0zUc39u8dIwc3KIZwh9/S7RuB4DXSNrY8iwqETTs=;
        b=k273QYcXswXBVVlUR8h67vo5sn3rmnbgMc0cVlcZ3QLnnyDykcnvPLYbvbrIFxLplE
         NWG/0P5i1xuVNfMvxhrGGPZWVqufkb0ZA1gOwvBl1d0SGEckJb36nWTNuqIctpnoq0c5
         bwTIIYJmcd2kn4kkGryhcALWcywiiaCIjOVbQ/1UfB1zT7vL+wnL3sxXh74YInHhFxLt
         oEDTrLEi7Qb5kU0UZmstMj9yymKHTdVjhldPEr21k8AnzACPpKf6dKAQBdjYhIFXbqLv
         sdhdPhIfyQtqKrRA9yDXZ7pVZVNr+knnz40Kt3MT1VjYm+Wr0vcizRNJh6YdotC+N2b8
         p+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988818; x=1747593618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfw0zUc39u8dIwc3KIZwh9/S7RuB4DXSNrY8iwqETTs=;
        b=Prw1WB1X4ctTWY+1QQDezl51QQmqYSSrcauopoctKV3lUHlgXH+oISu38is8OiN/Co
         0xLYVq5aafy8cFQZogWMwsdgXhvu0TQyyxh6aus1tgB9j+G4jHzT3S5cM30jVEMFizih
         FsQbsGSdykSRURF7vceKYtk7JolzUIXWr3vOWDr5CBg41usMM/W8t1thC/pA4Ti/2MJ3
         qYj2gb2NVuA7vbmoR7AEhRpczrVxjNAJcs+ClmEcUET5HAU2ZvQcGjz7jWIj8D2aWAi8
         ra+Cjm7JacfmrdHk8TYanj6t+D2BxTHdGyKA7sBSKmwPRt0Fl5wg/5nT6ZAT18woDhFz
         O1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqs7d5LxitiY0YNIkIih6J9Pn+xKd1A6HgzkIqSoV8YG04u+5t5qiCr2nN0UN/8HfzqwUhZ7cu2jqF@vger.kernel.org, AJvYcCX+TqTJyf2hYRF9HlIHHO/awZMmllXWkx0jqZTJC/Na8nVb5FT03LYgiFMMiMCqzbnAh967JQ0c@vger.kernel.org, AJvYcCXtzWq0irOdkevf3OL8Z0UoxEoqIiqKh2B+MBu2aynDuCJlIO8QtRBMhbzcTU6/zVgyZrzyCd4vP5Lpfjsu@vger.kernel.org
X-Gm-Message-State: AOJu0YxOW2MNiDGjUHU9F+SrUQ5u6Tufft5FHWzt2ISi0RydKeOAoEq6
	H+LA8kf/40JRrsTVmUZorz8L7ukGMH/Cupp++4E7Hjv8wZUS4jCFBW+21A==
X-Gm-Gg: ASbGncuBrujeK5UXKklK3gSCYEN2+lFGIeKwgA/hwVkhb/eJUtjlvlnBFraH/oqwvwH
	lHsCssXiqzUDrl7snhNqHtsWZ7/mMpsErjaW6IQJkMQqZwfGcptf9xNv2HoKNv4WKk7Epd1J6GN
	IeUc/VcbUsP92cZlG1H22xI7d9oAGQdwbg5vgq4fxAaraHM4g059DgTDA7mWyjAPMv5Fh9gvkLb
	pPfgvugjElbG20lcFPmJ02RsQQZrGD69aCZKwrWcKpmS4Vbr2ZOM3Q8Q7Doz7wkB3j0+gd4ZDUq
	UU66OyQEy+rAi83BUfJh5uYIFf89yeiVCzgKOXON35twusM4/tvwXDz33rQx5GM1ivkHgnPPKG6
	xK0m3mrsjkQKB9/PhcnX7
X-Google-Smtp-Source: AGHT+IFs8p5pZ+RcCzfsGuBs2kv+sj6JGTU16YIny73z1E0UcS2IWDqATGUPgcYNvI5szhbZcI1FtQ==
X-Received: by 2002:a05:600c:a00a:b0:43d:fa58:700d with SMTP id 5b1f17b1804b1-442d6ddd1f0mr78780675e9.32.1746988817944;
        Sun, 11 May 2025 11:40:17 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d76b7fd6sm61020615e9.0.2025.05.11.11.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 11:40:17 -0700 (PDT)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v9 0/6] net: phy: Add support for new Aeonsemi PHYs
Date: Sun, 11 May 2025 20:39:24 +0200
Message-ID: <20250511183933.3749017-1-ansuelsmth@gmail.com>
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
 15 files changed, 1336 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


