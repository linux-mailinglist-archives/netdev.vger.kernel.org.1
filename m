Return-Path: <netdev+bounces-304698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IrH2EzHnSGqRvAAAu9opvQ
	(envelope-from <netdev+bounces-304698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 12:57:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3667075FD
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 12:57:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tinyisr.com header.s=purelymail3 header.b=cD3JK2v4;
	dkim=pass header.d=purelymail.com header.s=purelymail3 header.b=cDgc2nWG;
	dmarc=pass (policy=reject) header.from=tinyisr.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304698-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304698-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D924300F441
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C23A2E3F;
	Sat,  4 Jul 2026 10:57:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBC359A6B
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 10:57:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783162669; cv=none; b=Z+tiidlCWJ9IiF29s/WwWg26ynkVKitu2NhpVCGREZDEZQ3vqyLVVWIO2ecBjbxjuV5N8GdnNLT8fQcA8VgynIf5kzVn3r8Ct8dQbBKdkaiTNeXO/XN5C/aELIkKOGnTTmYseQUT12DO1odxUwGSDsQQfnEkYT18hLAHXTmx/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783162669; c=relaxed/simple;
	bh=roVdftBqIYhxa7kuVflyNAGcTrgVRdhZgEMn2djRRN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nm4A8sUMV6WA8hVTlblvyDMdjMHb5VLaO01a+PFIutgutjglHXrJUGQJ35adddrArjpaNPY+IiAjmcD+kZsFmSknRIsdKhgrBdjL6m3GHEp10aGDIagG2MeN0ObWZVrnv+EvQafQv0D2jBEAEP7D35CvRzhAFXsRXKndyX45RRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=cD3JK2v4; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cDgc2nWG; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=cD3JK2v4Pg/6wUm8q+yTY4o9p9OKU2BJKARVgkRNcgNjjSb+r3FxZt3yVTcLl62J0Skl2MJfee3KeVFEjjIgsTO8UVnFm1KY60fWASYBZ/kaKg/CKzX6X9G9OwISUUyeTsDTDSxgZcteqNHOjwwiiK1P7H3bft30aDVrJuHYRQt+MiwwIk/slpnX+jqGf0V8aHOfo/u4g5hyKPdTm/jLkYnJ3cQnS6LTVDFyo2R5BNodZ9kR8LvRlBCp39VRKFH+XrNXmNsmY8AZgZyFa9Z/BnuOjRoNYbNMK8Q6ITfScy/c7sZ5Qisg85yoOWHFRQtrcgr96q59lRjuLJUDL4sdnQ==; s=purelymail3; d=tinyisr.com; v=1; bh=roVdftBqIYhxa7kuVflyNAGcTrgVRdhZgEMn2djRRN0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=cDgc2nWGE1e1TKDEe3bnd203JU2rnHN1CEx/mJbwy+8V81fC4U2Z7xj4MuWThoteC4aO0F907P2cqlGE/0iD4i0/EZrr/55v7fDih2PyfjFpVtMvKRPJi7iwKZu/hlcTOKodZxywKplvxM9/uecE0Fd3T50FhNjPkZd3xh5RtpR3NGTicQlJHkZbeZIEmwFVI8lOvi1WQVbCAZgUSZ2lfwwVga3xXZGaCo8EDRAX0+u/d32AVuFDNxZRTPee5MLnPSQqkx80GnNwUzJwIrhnosysjwvNL5Ffws4GZtrkpTpEWwOGqQyvcWKzb/3Yp9JH2lhKaH/VjQBZMaN+RhjOvg==; s=purelymail3; d=purelymail.com; v=1; bh=roVdftBqIYhxa7kuVflyNAGcTrgVRdhZgEMn2djRRN0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1846076314;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 04 Jul 2026 10:57:39 +0000 (UTC)
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
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v6 0/4] net: dsa: mt7628 embedded switch initial support
Date: Sat,  4 Jul 2026 13:56:55 +0300
Message-ID: <20260704105659.140970-1-joey@tinyisr.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304698-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:daniel@makrotopia.org,m:joey@tinyisr.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,arinc9.com,mediatek.com,makrotopia.org,tinyisr.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tinyisr.com:from_mime,tinyisr.com:dkim,tinyisr.com:mid,purelymail.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB3667075FD

This patch series adds initial support for the MediaTek MT7628 Embedded
Switch.

The driver implements the basic functionality required to operate the
switch using DSA. The hardware provides five internal Fast Ethernet user
ports and one Gigabit port connected internally to the CPU MAC.

Bridge offloading is not yet supported.

Tested on an MT7628NN-based board.

Changes since v5:=20
=09- updated tag_mt7628 to kfree_skb() on error in receive path
=09- removed Reviewed-by tags from tag_mt7628
=09- removed mmio base pointer from mt7628_esw since it's only used to
=09  initialize the regmap
=09- rebased on net-next

Changes since v4:
=09mt7628 dsa driver:
=09=09- updated mdiobus allocation to use ds->dev instead of esw->dev,
=09=09  matching other DSA drivers (no functional change)
=09mt7628 phy driver:
=09=09- replaced phy_write() with phy_modify() when setting PHY init
=09=09  bit (no functional change)
=09mt7628 dt binding:
=09=09- moved unevaluatedProperties after required block
=09=09- removed blank line between compatible and reg in example
Link: https://lore.kernel.org/netdev/20260608192948.289745-1-joey@tinyisr.c=
om/t/#u

Changes since v3:
=09- rebased on latest net-next
=09mt7628 dsa driver:
=09=09- simplified vlan_add hardware vlan slot search
=09=09- fixed vlan_del not removing vid from port pvid
=09=09- separated mii_read/mii_write error handling from return
=09=09  value parsing. Updated RD_DONE/WT_DONE bit checking
=09=09  with clearer logic and a comment.
=09=09- moved NET_DSA_MT7628 after NET_DSA_MT7530 in Kconfig
=09=09- added missing reset return value checks in probe
=09=09- fixed mt7628_switch_ops missing const specifier
=09=09- removed mdio node parsing from of, as there is nothing
=09=09  to configure
=09mt7628 dt binding:
=09=09- updated description to be more clear about port count
=09=09- dropped optional mdio subnode. the switch does not
=09=09  expose an external MDIO bus and all integrated PHY
=09=09  access is handled by the driver.
=09=09- removed unused switch0 label in example
Link: https://lore.kernel.org/netdev/20260428185510.261521-1-joey@tinyisr.c=
om/t/#u

Changes since v2:
=09- fix binding issues found in review
=09- fix ignored dsa_tag_8021q_register return value
=09- add switch teardown to clean up tag_8021q
=09- fix ordering issue where mdio probe fail would leak tag_8021q
Link: https://lore.kernel.org/netdev/20260330184017.766200-1-joey@tinyisr.c=
om/t/#u

Changes since v1:
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

 .../bindings/net/dsa/mediatek,mt7628-esw.yaml |  96 +++
 drivers/net/dsa/Kconfig                       |   8 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mt7628.c                      | 649 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  10 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  50 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  93 +++
 11 files changed, 916 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.54.0


