Return-Path: <netdev+bounces-273292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHXLGM7DymmL/wUAu9opvQ
	(envelope-from <netdev+bounces-273292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:41:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055535FD65
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C03F5300B44F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594713A63F3;
	Mon, 30 Mar 2026 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="OPJXidsC";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="J1Ar6CaS"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6B391E4C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896037; cv=none; b=RarbKKpBx9zY5ErJUT4X27DEnZHvakVISFYN9qpuvZZe01+s20KyslQHMGZ5jigDwj998KU104pAaQ4xpAooYo8JS9sIq2BImz2mTp2Ow+FB6b7GOW8GcA0+IwXDEMGUDoLfpsP3KdKGDNlk0UsUxBKF0CbY1L/l/AEfujfRvHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896037; c=relaxed/simple;
	bh=VfPt3xhhzdrq5VxZos7L6q1JozaMr9Lg4i8+biuaQNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=seKgZOi5DxW0CIsc3PaGEXWnjml71oNGNqz5REyIaueuJLMYx3oCLaq7m0+wEDmoOzXwwQIkLmJR9KiGK+z5uC7xIUcleUGYnZagSo6OkxO1iOEACR1tVceJvFJVlW2qRVoiSoH+O3XRvPKDYDST3aaJH2qY2ChHXoS7pGv+w4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=OPJXidsC; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=J1Ar6CaS; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=OPJXidsCipBUE+tCOqqJcUiHuriAdCoe3MvRwbQlbKu+QtvnKx82UyxlxmTOPsZfhj5aX+znjD08P5txR8Nrv0YqT2bzkajHGgg2fci104fWCpV9EiMvt/1rAQNC7TyWFt/Bg2L2eu5wBNA8hyaTrt56CjsFvtxYsISmylgA0n2LAYLKeYJtB7WZg328dFmwZK2EtQc58Ug4ULdaR0D1wtqwMCWinImSSoXEkAWpV0wDlAuX1Cv2lRb3HYfNyYyVEryxy3SeVIiyVmJ0Kjy7j4G6M13bpwNKQF4BexglkD+ajGbkafD3HDO0JQHBxs5fCXLPmZ+Fj85ghcFEgjLAtw==; s=purelymail1; d=tinyisr.com; v=1; bh=VfPt3xhhzdrq5VxZos7L6q1JozaMr9Lg4i8+biuaQNg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=J1Ar6CaSC9ZOjuUIdmakLEaTIE8ce3YEiA4ZIcjySOTJ9CbfACu549XkFx8BDvmHfPh3ruc49WL13qsdcZrHC8Iob/wMkVDHZJOyaAJvUBUkQXkBW+Tbzj+cDRznUZ8U5ilm5XbgysWbYaatJ/Uowf0/OfYi1Xn5qm56GAi3oAvT/RGFj5KN7ECOsmxZDfwbXVLZ0eIVQkoBVw6HTQymzNkbcQTT9KYc228EwmeaMDbhnmp78p4SKvrSo1/S+vOozCTp3iNt53sbAsbbV0Es1nEMvIs+jLPVb3D97a54+a300ccWyHI1AJZbQlvxhgpervSmN8iE64/jzMjRu+VNcQ==; s=purelymail1; d=purelymail.com; v=1; bh=VfPt3xhhzdrq5VxZos7L6q1JozaMr9Lg4i8+biuaQNg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1431054842;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 30 Mar 2026 18:40:32 +0000 (UTC)
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
Subject: [PATCH net-next v2 0/4] net: dsa: mt7628 embedded switch initial support
Date: Mon, 30 Mar 2026 21:40:13 +0300
Message-ID: <20260330184017.766200-1-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail1,purelymail.com:s=purelymail1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5055535FD65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This patch series adds initial support for the MediaTek MT7628 Embedded
Switch.

The driver implements the basic functionality required to operate the
switch using DSA. The hardware provides five internal Fast Ethernet user
ports and one Gigabit port connected internally to the CPU MAC.

Bridge offloading is not yet supported.

Tested on an MT7628NN-based board.

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
 drivers/net/dsa/mt7628.c                      | 627 ++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig              |  10 +-
 drivers/net/phy/mediatek/Makefile             |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c         |  50 ++
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   6 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mt7628.c                          |  89 +++
 11 files changed, 895 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.53.0


