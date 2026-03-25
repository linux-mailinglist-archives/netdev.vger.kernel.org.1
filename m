Return-Path: <netdev+bounces-271628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGqWAhYBxGmlvQQAu9opvQ
	(envelope-from <netdev+bounces-271628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36132825D
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9552F3006215
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3343ED5BF;
	Wed, 25 Mar 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="A5C0Y/LV"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEB3EC2FC;
	Wed, 25 Mar 2026 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451807; cv=none; b=Ttzpu2yFsXGBk1rnnNP1OQRkJsnVtEQQMyIuaob6mksaqdE0UqgBh/sJOlSukRn7MFbgLdvgAmMi/6TjBUZZ8XDy6ob82puBXrEywGNDsFAqysfZKZwRqQMewVkg4dOFenITA7soigiSYiIU/q7MzEEaY66dWc96dYBRo5js63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451807; c=relaxed/simple;
	bh=CCk76vE/xjR+yNkkzEFs2kbv/+OqHzHF8wQdMwc3Q+c=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=chaqpl6igRa63lGAvqJgxwLglpTU9ThM/gB+WKRuhu7RnX9aSdyaKHoAWw2Vwd6XexcdG5YVLiYQHJm1uZ4LpMzDLx+AMrOSHmNuvJCsfd3bG3v423H9PgQ0cta4KNSW/vJPMaNNXYArcxpdRhoL4vI1ACMj08Dway1+NbK8IWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=A5C0Y/LV; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1774451801; h=from:subject:to:date:message-id;
	bh=CCk76vE/xjR+yNkkzEFs2kbv/+OqHzHF8wQdMwc3Q+c=;
	b=A5C0Y/LVSQQHJPx1q2vu01IU5HhZXytE2wVXMcKZ5SboKny2Zh5XMXxtNd4VeJY+PcGWZ+/HCyw
	LyqXCQyorG5fKzj3ZeH0SZaGqC4DLNQ1fz1FexS0ybo5G5ngCgVi2PY6IIsxtafI0BNs+8Ris+QhW
	d4ngJs3tCGvD8KufBFpqyt/MNgaGvrRHdCzrmdxQDlcZVWDYjDoNd4QUJigt/Ddq+UqL3di1GMOGa
	aex9kbDq6Pv5LRy9yYI7fo6h6x2IEfZzMSDoOJTmFv3TxT+NmeY9KkXjB0ZwoAOuw5J6/TiOuOYaC
	fW1DocDPYclpEIU0273DX8lLLJiDwTZ3ftUQ==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 25 Mar
 2026 18:16:40 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net-next v2 2/2] e1000e: limit endianness conversion to boundary words
Date: Wed, 25 Mar 2026 18:16:04 +0300
Message-ID: <20260325151615.1407182-3-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325151615.1407182-1-ade@amicon.ru>
References: <a70a49a0-43f8-4908-993a-50999bf0dfa8@intel.com>
 <20260325151615.1407182-1-ade@amicon.ru>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-271628-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amicon.ru:dkim,amicon.ru:email,amicon.ru:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: 1A36132825D
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

Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
---
v2:
 - Split from the original bugfix series and targeted at 'net-text'.
 - Removed the Fixes: tag; limiting the conversion scope is an
   improvement to avoid unnecessary processing of uninitialized memory.
 - Improved commit description for clarity.
 - Note on e1000e: this driver already contains the necessary return
   value checks for EEPROM reads, so only the endianness conversion
   cleanup is included for e1000e.

 drivers/net/ethernet/intel/e1000e/ethtool.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index dbed30943ef4..785d89477c43 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -583,13 +583,21 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		/* need read/modify/write of first changed EEPROM word */
 		/* only the second byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, first_word, 1, &eeprom_buff[0]);
+
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (!ret_val))
+	if (((eeprom->offset + eeprom->len) & 1) && (!ret_val)) {
 		/* need read/modify/write of last changed EEPROM word */
 		/* only the first byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, last_word, 1,
 					 &eeprom_buff[last_word - first_word]);
+	
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	if (ret_val)
 		goto out;
-- 
2.51.0


