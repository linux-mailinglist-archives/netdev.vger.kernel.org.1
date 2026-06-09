Return-Path: <netdev+bounces-297311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuGSBGyHKGpCFwMAu9opvQ
	(envelope-from <netdev+bounces-297311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:36:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94E664499
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:36:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Fai3fOzZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297311-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297311-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C3D1304E1FB
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C824BC014;
	Tue,  9 Jun 2026 21:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7348B380
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040985; cv=none; b=PmpJ2CtRT0C3oBGImyHfYQ//ukgAD+c1ggaU1LVpbOViLY22bj0ynO3Q8booLmlnDjmLa75CMfmt6xB70pC0qo9SuDClwPORZCcEyERuIAB38DVfvc/uPKwMcHxFYiMrTaBOYDUewAziMPOv6MCGchM6+VMZpQkM+uo3uJuv7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040985; c=relaxed/simple;
	bh=Hf04y06OeGmaIh3UEmwzbtwH8Eo/OwDUxMKTgY4QnRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r41CgtT904zs3E9kidehhkNph9k4LxaCikLbW3PD8uql555tz7yOeuyksSWVBYtH9Ag92SigbJDkAJoScxyodERQNY6n2WTVkPUIsBBpbNmW7WYBbg+pgcSX3suUnFBDn2tPfLyASSNIMVTr/lM6YVH2s7GvF5eK+Nsbit5lMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fai3fOzZ; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040980; x=1812576980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hf04y06OeGmaIh3UEmwzbtwH8Eo/OwDUxMKTgY4QnRQ=;
  b=Fai3fOzZD6okS8lQCW/7dwrYIMC8qSUv5z8aMFh0aISl8MH1jvu+hZCQ
   4ckcgUObV6huLimyW9Q0jQcDu2NprdH+/KHtfBLeKZAlkDA/KVpLcPznq
   Tho4rmLzhjBYEbz5EUXnTjkHzwLRzuX6b3+P+V0BXr8khWniRYoOfxOwr
   tjBWeqM/eAoOBvCaetSIprWuwXlP7r1ZmdfEqqVoZAKeZBNdNXIt/jDL9
   fJDAtOuKOpr3LDn3T042cBa+6XObLkuz/VjqwyGbguqbUr/dZHfmpx8UQ
   pulmMeFck4/N8VU0p0J5/4DPFjeBJkM/mhMb74VL2aPu/Bg6wodk3BPwt
   Q==;
X-CSE-ConnectionGUID: ylvR3l38QOOK5qAS8hUePw==
X-CSE-MsgGUID: d+htnK8PRY62BeymiGMAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568606"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568606"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:10 -0700
X-CSE-ConnectionGUID: 6m/Y1Bw3Q1SskOFfteKwYQ==
X-CSE-MsgGUID: Aqf2Ui8EST+14YzBm5x6mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838607"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Agalakov Daniil <ade@amicon.ru>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	jacob.e.keller@intel.com,
	Iskhakov Daniil <dish@amicon.ru>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 13/15] e1000e: limit endianness conversion to boundary words
Date: Tue,  9 Jun 2026 14:35:54 -0700
Message-ID: <20260609213559.178657-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297311-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:ade@amicon.ru,m:anthony.l.nguyen@intel.com,m:dima.ruinskiy@intel.com,m:jacob.e.keller@intel.com,m:dish@amicon.ru,m:avigailx.dahan@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,amicon.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B94E664499

From: Agalakov Daniil <ade@amicon.ru>

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
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


