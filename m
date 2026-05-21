Return-Path: <netdev+bounces-290241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFNIM2SiDmpxAwYAu9opvQ
	(envelope-from <netdev+bounces-290241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:12:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7868759F526
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 08:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8345300CB28
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAB386552;
	Thu, 21 May 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rOxa3tti"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788C370AC3
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343970; cv=none; b=JY7Mk1fBFrak+BcE/JU7EZKuHeBLGft4f2g3WAaN8TAOjXffv2V2mImdzVM9VtLHdZrUExmdgYwGRERkhk7Il2dvRiBWZs6JlVlZ1Aotxoc5GvsKWAW+YnuN+XJfUlsmcddrmnwzL/+vbZY9/TGloRmjr3k2vLJOb+h0aN0qxPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343970; c=relaxed/simple;
	bh=SDV5x95GTjzDs7IKaEpHKcRT49R8z2yw2Iu2h1Vvl7M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gbAzkg0dOXsvVNzrCoT9BAVaV0wvF5J0hF2UaoOoiJABfryVIi5+xCM2WwRoluSo2hkYVNbn77N2xlNIt2usZ9HgOw6P2lqIhzG2OmGJZLF785dw4xMw7SQu4UtHR/dL2KWTUSHcTtPnG5BIrgQxr+qSbgJc9K7RV3pE+F+HGD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rOxa3tti; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 96738C2C64D;
	Thu, 21 May 2026 06:13:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6902960718;
	Thu, 21 May 2026 06:12:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EF2B107EA39F;
	Thu, 21 May 2026 08:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779343963; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ac2mGgwMYNiRYxAFedqYIliY6owrL/OOtiKz2ZAlV6c=;
	b=rOxa3ttiF/atkKa5Qj4phqaWbbqTpYK5H/yXFbUsHCkhhwS3IlUlZGlDzXxQxPcQw5omXu
	LjBv/Q6w0In1XU3R09fqxQkdi5KBRMguTw2Jw9O0acEi0sfkYKZKXI6fdclkjVNewV6hVO
	DKPZelCQI+hWQymxWZG6Dmfew4hYpgDjxkoQBvCwMLZVpkvo0JWdGsyDn+JmJ/c8tqBZwZ
	k5B0+QY2e7ueWiz7SH47b9IK0ELSonS+jS7FUW7J41JFZfslPWZJYSPjJEyWvDRNnJ/AAM
	aBnSxHvuSGItvkSs6/vNCDgP1/XakBh5UiPochaIbpJOlW8M8urGUX7l/Mydgg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v3 0/8] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
Date: Thu, 21 May 2026 08:12:35 +0200
Message-Id: <20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOiDmoC/3WOQQ7CIBBFr9KwdgyF0FpX3sO4oHSwxAoK2FSb3
 l1sXWiiyz8//70ZSUBvMJBtNhKPvQnG2RT4KiOqlfaIYJqUCaOsoCLPQXUoLZzCA5htYFkDr0s
 hUFWV0pSk6cWjNsOM3ROLESwOkRyWxuP1ljxxqV/H1oTo/H1+os/n0dvHfvv6HCgoSnWhkPJSy
 13tXOyMXSt3nj09+8SIPxiWMFzIqtjIkle6+MZM0/QEB2nPiiABAAA=
X-Change-ID: 20260511-clean-ksz-2nd-series-3b755ec99cf0
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290241-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 7868759F526
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

This series continues the rework of the KSZ driver initiated by a previous
series (see [1]), following the discussion we had here [2].

The KSZ driver got way too convoluted over time because it uses a common
framework to handle more than 20 switches split in 5 families (see below
table)

+----------+---------+---------+---------+---------+---------+
| Family   | KSZ8463 | KSZ87xx | KSZ88xx | KSZ9477 | LAN937X |
+----------+---------+---------+---------+---------+---------+
| Switches | KSZ8463 | KSZ8795 | KSZ88X3 | KSZ8563 | LAN9370 |
|          |         | KSZ8794 | KSZ8864 | KSZ9477 | LAN9371 |
|          |         | KSZ8765 | KSZ8895 | KSZ9896 | LAN9372 |
|          |         |         |         | KSZ9897 | LAN9373 |
|          |         |         |         | KSZ9893 | LAN9374 |
|          |         |         |         | KSZ9563 |         |
|          |         |         |         | KSZ8567 |         |
|          |         |         |         | KSZ9567 |         |
|          |         |         |         | LAN9646 |         |
+----------+---------+---------+---------+---------+---------+

The previous series ([1]) replaced the unique dsa_swicth_ops struct used
by all the KSZ families with one dsa_switch_ops struct for each family.

These dsa_switch_ops structs still rely on common functions that redirect
the calls to ksz_dev_ops operations which are custom to each switch
family. Many of hese ksz_dev_ops callbacks have a direct equivalent in the
struct dsa_switch_ops. This series directly connects the implementations of
these ksz_dev_ops operations to the relevant dsa_switch_ops attribute
to get rid of one unnecessary level of indirection.

On top of this on-going rework I added PTP and periodic output support for
the KSZ8463 (which was my first goal). There are more than 60 patches for
all this so this series will be followed by several others and if you
want to see the full picture we can check my github ([3]).

I haven't finished yet to group all the patches into meaningful series
but here is more or less what I plan to do next:

- A series will split again some operations to get rid of the
  if (is_kszXYZ) branches.
- Maybe another series will be needed to completely move out of
  ksz_common.c everything that isn't truly common to all the switches
- A series will add PTP support for the KSZ8463
- A final series will add periodic output support for the KSZ8463

FYI, I only have a KSZ8463 so, unfortunately, I can't test other switches.

[1]: https://lore.kernel.org/r/20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com
[2]: https://lore.kernel.org/r/20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com)
[3]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- PATCH 1: Update kdoc of ksz_wol_pre_shutdown()
- Link to v2: https://lore.kernel.org/r/20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com

Changes in v2:
- Remove patches 1 to 7 since they were applied on net-next
- PATCH 6 (previously 13): Create a LAN937x-specific port_setup()
  instead of using the KSZ9477 one
- Link to v1: https://lore.kernel.org/r/20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com

---
Bastien Curutchet (Schneider Electric) (3):
      net: dsa: microchip: bypass dev_ops for port_setup()
      net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
      net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()

Vladimir Oltean (5):
      net: dsa: microchip: don't reset on shutdown or driver removal
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
      net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
      net: dsa: microchip: remove dev_ops->setup() and teardown()

 drivers/net/dsa/microchip/ksz8.c         | 235 +++++++++++++++++++++++------
 drivers/net/dsa/microchip/ksz9477.c      | 184 ++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_common.c   | 247 +++----------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  22 +--
 drivers/net/dsa/microchip/lan937x_main.c | 169 +++++++++++++++++----
 5 files changed, 521 insertions(+), 336 deletions(-)
---
base-commit: 822d4a8e390a08ccfaf2abb347ae670b230b196f
change-id: 20260511-clean-ksz-2nd-series-3b755ec99cf0

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


