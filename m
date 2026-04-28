Return-Path: <netdev+bounces-282052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMVLOeAC8WmgbwEAu9opvQ
	(envelope-from <netdev+bounces-282052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:56:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664748AEAA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51E29305191F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1D478859;
	Tue, 28 Apr 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="YLsg/HuY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XwhUWIAM"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF122777F3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402536; cv=none; b=FMsJPUSIPFrFXvyUs7R7GPO0g1bK5AVEiw4+NgLOcfGC5IqMLeB4X0a4nqFLZR11BtW+Q8IYvTCBkajqdiptlleXeHRxCZjFGkDztpaUcku4XmEea6BJwiWM2SYSqHi2W7bX1vv8yvIqC3xHfTY6pG3L6QHp4Q96P9pmVur3IHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402536; c=relaxed/simple;
	bh=y9Lv1j8PxtUPgOx5NzCck2PsSl1KX1csMBtx0t7RNAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IOdCvOmc0TDGq4q+GlmhRoTGiCeHDnDd8hsRLFxBU85ic6u1ToSfXNQ//LoP0BAtOWZJVOGBx388cpMaS+ss3xs0f2c31swxmzO9D7rNdlp3f1T4zg6y64EFYZsWBtWCKl/o1aT0IsObJdgA3auvZNfwBikenyDiyNDFXhj/zVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=YLsg/HuY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XwhUWIAM; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=YLsg/HuY9EudrfULK09MxeI5d583BT/7oibO71E1gNQ/5ESn8oNDlxYllLbjfDpOsu0inFIf39L99x1hO2FHGvqPduh/AVmhx3kWidSV4gDm6lFIeU9V1T+C0y/Eq3ji6f5BL7bYBpzAHymucJTlXNABVV08UVb2fqeiF7L3eTTx6CRbD7xaeHpzWN4CPLv5W1kEiLdsgumUvCcvVw7/PDGBHJN84ZvLUzm1aurqa0V10RXZe/K0KruZYhzttL8Sx8pQVvqPGStV8F6zdXI6CAvHyfQ6eNvSXrATtOnPf5wJKZohAzIMBcQr9QoRKl0g37YDy2besGxI3+O8yQl+3w==; s=purelymail2; d=tinyisr.com; v=1; bh=y9Lv1j8PxtUPgOx5NzCck2PsSl1KX1csMBtx0t7RNAs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=XwhUWIAMn90ojy5ELvTmTsXgfIZDqSv02vUhBOXYE47mv8k/zQdEjtrBYgVN6IhwvMI+lKblfRulY57r0lcg6teS70TIBJSL4ScHo9FQGaRNRzPY0s5/YIMK0Xw584+YfSzQ9E2aJtIRyiTrwjwYT+xu006Hp0GthUxgjk82/lQAMrA3DFweYjwoBm2mtftr8RxE3AnB+AdD3ZyRR2gSc92ep05vIu6jBzDP4MiChl0zVOfX+ZxnCeH5hKxInzCOScm7iqSWpLc9JMvBfIc765mni/5F37JbYHmILSBitJnvtfGyRdSCwkYhQVFmch/Z0zmayPbMJ4q7P22pUIQCng==; s=purelymail2; d=purelymail.com; v=1; bh=y9Lv1j8PxtUPgOx5NzCck2PsSl1KX1csMBtx0t7RNAs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -825627856;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Apr 2026 18:55:30 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v3 0/4] net: dsa: mt7628 embedded switch initial support
Date: Tue, 28 Apr 2026 21:55:06 +0300
Message-ID: <20260428185510.261521-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 5664748AEAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282052-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purelymail.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tinyisr.com:dkim,tinyisr.com:mid]

Hello,

This patch series adds initial support for the MediaTek MT7628 Embedded
Switch.

The driver implements the basic functionality required to operate the
switch using DSA. The hardware provides five internal Fast Ethernet user
ports and one Gigabit port connected internally to the CPU MAC.

Bridge offloading is not yet supported.

Tested on an MT7628NN-based board.

changes since v2:
=09- fix binding issues found in review
=09- fix ignored dsa_tag_8021q_register return value
=09- add switch teardown to clean up tag_8021q
=09- fix ordering issue where mdio probe fail would leak tag_8021q
Link: https://lore.kernel.org/netdev/20260330184017.766200-1-joey@tinyisr.c=
om/t/#u

changes since v1:
=09- changed port 6 phy-mode to internal
=09- cleaned up tag_mt7628 rcv function and mask defines
=09- fixed sorting error in drivers/net/dsa/ Kconfig and Makefile
=09- fixed sorting error in net/dsa/ Kconfig and Makefile
=09- fixed mt7628_mii_read/write return values on error
Link: https://lore.kernel.org/netdev/20260326204413.3317584-1-joey@tinyisr.=
com/t/#u

Thanks,
Joris

Joris Vaisvila (4):
  dt-bindings: net: dsa: add MT7628 ESW
  net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet
    PHYs
  net: dsa: initial MT7628 tagging driver
  net: dsa: initial support for MT7628 embedded switch

 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 101 +++
 drivers/net/dsa/Kconfig                       |   8 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mt7628.c                      | 639 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  10 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  50 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  89 +++
 11 files changed, 907 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.54.0


