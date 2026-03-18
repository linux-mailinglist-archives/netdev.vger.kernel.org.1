Return-Path: <netdev+bounces-268995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI6MFa+ZumnaZQIAu9opvQ
	(envelope-from <netdev+bounces-268995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:25:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C72BB6B2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0C43196D87
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DEB3D646D;
	Wed, 18 Mar 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="KarlrZZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3A3D6493;
	Wed, 18 Mar 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836452; cv=none; b=NV3uFhM9yu/uYwmQsSXmf5yOBNvdxlOwaRhfOxdDq+8A64Ii/98SEJp6NyMJpUBPu/OJhrP06lgf3hBgY2lVrzr1glMPB+zn9hj6SzV6DoCyek0edZHteoq/xsgxAHFttH64UBUquF/gqrfTfAgLuo5gvNCpEvSNsHKjodjwWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836452; c=relaxed/simple;
	bh=XZen40Yk+QoMIT6s4hnv4GEbtv6HyjqcTqgr8GMETfI=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=sTaNS5cI7XM+uW5VyUXhphhTTdoNCjDeaRAcT8TFuRfSNd1iyyj34BCaXLGb30qWAPwc2MaN1ycgzxBeC393Tk/zYR19SmMQAfX/HERIfdOjfFUSuWe3lrIvX7v1VYmEiWah24wLU5MGGZYoPYvnYQoapmaA1oeJNzx3fIjD0Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=KarlrZZH; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1773835531; h=from:subject:to:date:message-id;
	bh=XZen40Yk+QoMIT6s4hnv4GEbtv6HyjqcTqgr8GMETfI=;
	b=KarlrZZHrsoqSVRJAFH0BUR8rZgVSwlvrDy97U52GJXk15tmNkczjrtdFai1urFpF38fGgSGoLq
	OAnjIUpfI4Lq4gEK+D2g/C18jZ4LYIsnS7A0cnjUQlzhaSvOy4t3+yMDx/OZHAVwVMMRYVLzmGz0F
	8tLGyj9tcebnFFyc402qWvT8Z0+GFFPQNcNt5yShTF7W3tWBDxOi2U9Im89o2jmGlU3FbiTVAHRmb
	MnXaUzgwadhBUY1Is9YVmQKTmSXWhCqBMH+/d8zCUF8EtKAKXQhIaQBtLcNgnJsnIIA1yWpZMyB1I
	OTK/D+yOr5uT6FYggJyw/tnJUKYjpekPAr1w==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Mar
 2026 15:05:31 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net 3/3] e1000e: fix endianness conversion of uninitialized words
Date: Wed, 18 Mar 2026 15:05:07 +0300
Message-ID: <20260318120512.687149-4-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318120512.687149-1-ade@amicon.ru>
References: <20260318120512.687149-1-ade@amicon.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amicon.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amicon.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-268995-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ade@amicon.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amicon.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amicon.ru:dkim,amicon.ru:email,amicon.ru:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: C62C72BB6B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Why]
In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
words. However, only the boundary words (the first and the last) are
populated from the EEPROM if the write request is not word-aligned.
The words in the middle of the buffer remain uninitialized because they
are intended to be completely overwritten by the new data via memcpy().

The previous implementation had a loop that performed le16_to_cpus()
on the entire buffer. This resulted in endianness conversion being
performed on uninitialized memory for all interior words.

Fix this by converting the endianness only for the boundary words
immediately after they are successfully read from the EEPROM.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index dbed30943ef4..a8b35ae41141 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -583,20 +583,25 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		/* need read/modify/write of first changed EEPROM word */
 		/* only the second byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, first_word, 1, &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
+
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (!ret_val))
+	if ((eeprom->offset + eeprom->len) & 1) {
 		/* need read/modify/write of last changed EEPROM word */
 		/* only the first byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, last_word, 1,
 					 &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 
-	if (ret_val)
-		goto out;
-
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	memcpy(ptr, bytes, eeprom->len);
 
-- 
2.51.0


