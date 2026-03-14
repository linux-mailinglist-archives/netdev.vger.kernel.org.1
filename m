Return-Path: <netdev+bounces-267743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCHpFR96tWn80wAAu9opvQ
	(envelope-from <netdev+bounces-267743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:09:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187528D9DA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B609300E298
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F225A640;
	Sat, 14 Mar 2026 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="Z0rJerWu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YRn7nVQx"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A4241C8C
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500955; cv=none; b=nZnzpbYV5dPTF2FGcKR510D0e3GdcQjpF5BDIwWek//uY0xaBZd7iUfNbFT0tqqkU5UxKFjGHF5yNXndWfDvsRFZ475sPbM6bEVIklSaXynDBFGPYdkpX5JiEw7JUNzjPoH4JMx4dchL0t2av2eNd0O0BUsvryH3XkA8Qdsc9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500955; c=relaxed/simple;
	bh=YZosoJnTTHXV8/gp39jDPKnkzvWE1Gwhobg55Tp1Bic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WtnAkqV588HuC7rT5HaliIhggj1kraPRlP6zDBEzd3FS625ICYb27tdJFGXRp9adwALTV8s13bE77Lab8zrgGJok9SQSHanrhpwSY4HqOdWuQTAqdX60R7joPatu8xV+IMgkt3Q4nmOLCVfQ21UboDqBWufEeiJFkYYsn3GQtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=Z0rJerWu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YRn7nVQx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Z0rJerWupRDP5BYJkegS1+NCUmnQzCbvm6ehitf5JLll6iL+oHk7611YO5dN5h4IFlJVjoo+V8AOclWnjmWWgBckzUil97Srv/khAttIdF6YEaN3UP1G/0wb3z5QVSMLrJN9Y3KVKb+HyDouSeP7tkDO/2YKs10AuagpmQdJcv8KjFk+jhoLkIplaKG9Hoc41iiype3R8P9l5ptK0qZjBebPjNDTRsq103ZzjGOpkye7FoZVgNxst6HlZgADfsogjPl+WfdRGBWtdL31rXmkBWnfCO9/9PPGvWSdd6bh/2TQ7lZwktlhf2fsGfqIMNJQFOUdK//QYDvhoiz/HZhT1A==; s=purelymail2; d=tinyisr.com; v=1; bh=YZosoJnTTHXV8/gp39jDPKnkzvWE1Gwhobg55Tp1Bic=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YRn7nVQxgVljdZRH1C1tflMtwcQJcX2tZS1e/D/HdhkDZa5BjQtE17nV+qRfKnRNTaMXc+9LWuoNI74Nssm64j24hgITVju8AbQMOYAAbg/hXJeXE1xEH1ak1CyUGHOYw62Lw3JV0fXH3xqyUOkgIJLYKqf8zD0LZxSsWTETEYZIpv+EQuprnxo/2JmfEsda9WWUU4Epkjd9PUNxBATY+3QqdMy1aKzX9WYfm0UY7Dq8AEj6jdveUot3hPVVs+ms9fnr2AH0ZLirw4Wi0uA7hAe9D4DLRj2QjYSv0NunL/HLAPXoAvQDZ32/2kI1zlcGxYYWOhODII4DnVyDpMdaCw==; s=purelymail2; d=purelymail.com; v=1; bh=YZosoJnTTHXV8/gp39jDPKnkzvWE1Gwhobg55Tp1Bic=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2038631184;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 14 Mar 2026 15:09:11 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC v2 0/3] net: dsa: MT7628 embedded switch initial support
Date: Sat, 14 Mar 2026 17:08:42 +0200
Message-ID: <20260314150845.653866-1-joey@tinyisr.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-267743-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tinyisr.com:dkim,tinyisr.com:mid,purelymail.com:dkim]
X-Rspamd-Queue-Id: 0187528D9DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This RFC series adds initial support for the MT7628 Embedded Switch.

The implementation provides basic functionality required to operate the
switch using DSA. The hardware exposes 5 internal Fast Ethernet ports
and two gigabit ports, one of which is internally connected to the CPU
MAC.

Tested on MT7628NN (mistyped as mt7628AN in v1) with 5x Fast Ethernet
ports in a software bridge. All ports were verified for correct
communication while using VLAN-tagged and untagged traffic between two
hosts.

---

v2:
=09- Update commit messages with more relevant information
=09- Change all references of "special" tag to "MT7628" tag
=09- Fix coding style errors
=09- Use dsa_xmit_port_mask instead of BIT(dp->index)
=09- Replace phy_read/phy_write with an MDIO bus definition
=09- Remove PHY init from switch driver
=09- Fix undocumented writes to SGC2 and FCT0
=09- Fix missing double-tag enable required for VLAN unaware
=09  functionality
=09- Fix VLAN remove logic
=09- Update VLAN add logic to use the first unused slot
=09- Add a dedicated phy driver for MT7628 FE PHYs

v1: https://lore.kernel.org/netdev/20260228185242.800836-1-joey@tinyisr.com


Joris Vaisvila (3):
  net: phy: mediatek: add phy driver for MT7628 built-in Fast Ethernet
    PHYs
  net: dsa: initial MT7628 tagging driver
  net: dsa: initial support for MT7628 embedded switch

 drivers/net/dsa/Kconfig               |   7 +
 drivers/net/dsa/Makefile              |   1 +
 drivers/net/dsa/mt7628.c              | 596 ++++++++++++++++++++++++++
 drivers/net/phy/mediatek/Kconfig      |   6 +
 drivers/net/phy/mediatek/Makefile     |   1 +
 drivers/net/phy/mediatek/mtk-fe-soc.c |  55 +++
 include/net/dsa.h                     |   2 +
 net/dsa/Kconfig                       |   6 +
 net/dsa/Makefile                      |   1 +
 net/dsa/tag_mt7628.c                  |  93 ++++
 10 files changed, 768 insertions(+)
 create mode 100644 drivers/net/dsa/mt7628.c
 create mode 100644 drivers/net/phy/mediatek/mtk-fe-soc.c
 create mode 100644 net/dsa/tag_mt7628.c

--=20
2.53.0


