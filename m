Return-Path: <netdev+bounces-274079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMKQABwTzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:44:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF2537AA53
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABEE731C176B
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC7402444;
	Wed,  1 Apr 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="F4Ar2ddm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9D3FCB10;
	Wed,  1 Apr 2026 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045393; cv=none; b=dNPddUTDotFd70bnqQrGsO6mZDYaY9JZ+3JLoqelmDYe6m+XsAKAo5AdaojlL/b9mGr/wsVfeLsfIuNQm2S0oS/mSYAEC5WZ4pu5VfJXAr1Ucdnr24pU+FRTPAsgqQ1mACXGEbe4M6RXi6R4FWEimjxwSN3PlR5aZjlpJSr48ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045393; c=relaxed/simple;
	bh=HE4n1sAvPUoflg+jZgW88p4JQucSMSdvmERWpA9XOM0=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=tB8TzlNkO6FjQWT0qX54lBtHR860dWrJrYVbZZgGrcHWsSXG5m6cZyAryTfAH9jiODMO4H0XPfi2mfcQwBuP2kvu/oy9H8Fa58XievaIHVUMWbDPjvNeCqzlXNyqvBSjiofhJEhc/cVkacx1OCmO+GDiSOCb3vDmTwuJIQ3F2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=F4Ar2ddm; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1775045378; h=from:subject:to:date:message-id;
	bh=HE4n1sAvPUoflg+jZgW88p4JQucSMSdvmERWpA9XOM0=;
	b=F4Ar2ddmu/V0RE31MzZB4vvAvI6SUAbdOdr/ny05IXiXQSOEgR752n0SRkKrE/E9eL/gy2jhi7f
	Ju8OiYOYr1eAcf1QkzP+q+Ig+fNwCRUpjtknQMA4lJ/zuiHjDEQg/TxhgIs4fwibVWA6BH9aYyiod
	X690AtZeDrLy+9eGIzs7hK9JFmLR3FogT0WAIdWn/oVIcImHhihnay4UtE00LQpXO3EgSWZq68/CK
	itGRZP41wpu6A/SC9OhUB4msBV7hhOLcBkT5PPfkU3152nqEEM/0hW9IwxclVy86U8iatntVDLa2v
	qOPLc0TC+o2xy2ktXcaPVrFfHwG+m1uJWSvg==
Received: from example.com (172.16.2.46) by mail.amicon.lan (192.168.0.59)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 1 Apr
 2026 15:09:37 +0300
From: Agalakov Daniil <ade@amicon.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: Agalakov Daniil <ade@amicon.ru>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Daniil
 Iskhakov" <dish@amicon.ru>, Roman Razov <rrv@amicon.ru>
Subject: [PATCH net-next v3 1/2] e1000: limit endianness conversion to boundary words
Date: Wed, 1 Apr 2026 15:08:23 +0300
Message-ID: <20260401120919.282668-2-ade@amicon.ru>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401120919.282668-1-ade@amicon.ru>
References: <20260325151615.1407182-1-ade@amicon.ru>
 <20260401120919.282668-1-ade@amicon.ru>
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
	TAGGED_FROM(0.00)[bounces-274079-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amicon.ru:dkim,amicon.ru:email,amicon.ru:mid,linuxtesting.org:url]
X-Rspamd-Queue-Id: 5BF2537AA53
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
 - Split from the original bugfix series and targeted at 'net-next'.
 - Removed the Fixes: tag; limiting the conversion scope is an
   improvement to avoid unnecessary processing of uninitialized memory.
 - Improved commit description for clarity.

 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index ab232b3fbbd0..38b1f91823ef 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -496,6 +496,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, first_word, 1,
 					    &eeprom_buff[0]);
+
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
 	if (((eeprom->offset + eeprom->len) & 1) && (ret_val == 0)) {
@@ -504,11 +508,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		 */
 		ret_val = e1000_read_eeprom(hw, last_word, 1,
 					    &eeprom_buff[last_word - first_word]);
-	}
 
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	memcpy(ptr, bytes, eeprom->len);
 
-- 
2.51.0


