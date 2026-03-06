Return-Path: <netdev+bounces-264632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB7wOhJCqmlQOAEAu9opvQ
	(envelope-from <netdev+bounces-264632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:55:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7121AC86
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53B5A300CA35
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F07B366073;
	Fri,  6 Mar 2026 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1ylFnJz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747D30F534
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765709; cv=none; b=LPWCNvrC5SXo2l5ZxAbOxW8sOTE6QKsISkCJF+k6EN82OREMzzu/nSNXXcZkH8+ZfoHUGY1XFEoibw8nEVtqrJ8neGgLBKpjfzS8QWZkoZIIiAv8Iyh8HCS4ntsWn3+qM7wmONOTcBqDHxidZLcCgxxDgfME0l8r4GmJQ1kjd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765709; c=relaxed/simple;
	bh=e7/2qJDCMVAD3T4YsscP9VDk8tfbessIs9nGVfSM88w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViiZWCVBiG6ZIK+7VgwvpaO5AFcVaHN85tFDUCn4rDjBA4xoqsMCmOnr+5SjnpK51nTJHBK66VKjpMDfKK8ca0fi5nZ9OChhTI2hwx9AMSZuYkkIy9aVEq2s2pBC1cj1b57IzHs9kW0y5f2A63n8E179idKGrunelFS3/W+XG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1ylFnJz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so3159827a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 18:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765707; x=1773370507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=us6gMYtdEgLuXYRfbamznenxb3koTy/q5+/r4uR2Foc=;
        b=g1ylFnJzvZt1GVhsiWOeb/p179un2W8xUlKwNIBGKrUDXdRI4zJJe7QhsIA1n3Xvwv
         EckQvvjcL2TsWZgxAKLA1GnKQ38uVuMbZox+wYdKTF8GavJamSTYZiIXCFCDNp4hk6ua
         YChNK9zqe0ZEa2FycZtkvQtc6NmVbtZl3JmHZLEiMNq3dtsNMDpWkuvjI6VLP+rTMIhN
         tKqT4kvY4/klsLHG+L5RNphkjbZ53B8Z6JWuRAjCfkqQ/Y/KFfTTBDEG954PPcnFsPAe
         qQj3rKciC2Xzq9YKicHhyPAz1V1V0Ns4pyHJ96Q+e047cU7qz5aWu/ZVp64UDg3qDRjf
         urag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765707; x=1773370507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us6gMYtdEgLuXYRfbamznenxb3koTy/q5+/r4uR2Foc=;
        b=Wltx98/Ze6OV7ufRkD8vqKlLrNKKmBpGoV/8h1SHtlUJEJvOT7sAZHnY8GApLwoAhK
         2Sl8MNvZu+bQrplF1VRghx3AkezezPWq0aQNkCJTMC6KO5zrozdSfUihyz86SZ+X3y8E
         iyYQvhTMuOpdJGsIrZ+k3n6aWKRuTguLax/M3fBprbH/0U8gAcPMXYWVEmwiG4H1pRsT
         OBOt4CC1dNyK4E+X4faMeKKjsZOPvQsim479cb7vOoF8wjMMZ6liRzFamo6xjRp41UXo
         rB25okF4RCmAHW4fXt9koTWqRf2v08Jq+PEg3Z1YuB05cuqDKYD333LdaVFamClY5gYG
         BV3Q==
X-Gm-Message-State: AOJu0YxR5uD78NAbEEQY85m2OPbNX28LxgyOYEpTowk7Gu4rZhCAwiuy
	9B6L2DCtxTKvCJ1gA0McVxq5gBHN+78jECisCqDFH3R6zj0d3Z9EY9Q27C7CgIE6
X-Gm-Gg: ATEYQzxV0XA92z2Zyo7MRAoRL5tP/c8AEQNUVuGwSgZzOM3kpPab/AWmci2W705Ctdl
	m5DK01UA02bxMs9BAe1b9RNIXkPlU+IM43D9QduQfuZAIqjV9MBqqcpi6X+VN9Ww2KNP8Vo3TIv
	gquOaUShds8BAvrbyQLsDnDqR3SIxn8E7mhip5N+5byeyMCJCDVZd5ZawR+EIVBnD03u7pzjMUS
	CiYFFHcXd/xzbuyM77/Ser4azbSJhLPXjqlSvPP60AqUyr5p38si005eTKhCdSWt9vilWOdfCWX
	sYZ45ZD2HVVrlVB7TAgXPAb3M3OXvIzycRpx3IinskxzZM9OLw0w29/msf5UH7hE5hTwwAoEBrD
	kFmRST+olWYpsRRFJ06RA2BSbK/svHJVN8xM+2HX+7G7DxkU0IYzukd10t2kUL/OuUKK0lKqeXk
	r2UsBT0IDc+6tBiQgPC7M3XwW/SbW/hK6JGpVdIStdh5bygIJs+ThX65RLh4Aw/iUjIw==
X-Received: by 2002:a17:90b:2792:b0:359:7eb:d91d with SMTP id 98e67ed59e1d1-359be3861e3mr482876a91.26.1772765707486;
        Thu, 05 Mar 2026 18:55:07 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c003bd46sm109309a91.4.2026.03.05.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:55:06 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
Date: Thu,  5 Mar 2026 18:54:49 -0800
Message-ID: <20260306025449.12333-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DD7121AC86
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264632-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Combining the allocations simplifies things, especially the free path.

Remove ofdpa_group_tbl_entry_free as a result. kfree is shorter.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 31 +++++-----------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index 50ea5f9ef63a..66a8ae67c3ea 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -104,7 +104,6 @@ struct ofdpa_group_tbl_entry {
 	u32 cmd;
 	u32 group_id; /* key */
 	u16 group_count;
-	u32 *group_ids;
 	union {
 		struct {
 			u8 pop_vlan;
@@ -123,6 +122,8 @@ struct ofdpa_group_tbl_entry {
 			u32 group_id;
 		} l3_unicast;
 	};
+
+	u32 group_ids[] __counted_by(group_count);
 };
 
 struct ofdpa_fdb_tbl_entry {
@@ -1059,19 +1060,6 @@ ofdpa_group_tbl_find(const struct ofdpa *ofdpa,
 	return NULL;
 }
 
-static void ofdpa_group_tbl_entry_free(struct ofdpa_group_tbl_entry *entry)
-{
-	switch (ROCKER_GROUP_TYPE_GET(entry->group_id)) {
-	case ROCKER_OF_DPA_GROUP_TYPE_L2_FLOOD:
-	case ROCKER_OF_DPA_GROUP_TYPE_L2_MCAST:
-		kfree(entry->group_ids);
-		break;
-	default:
-		break;
-	}
-	kfree(entry);
-}
-
 static int ofdpa_group_tbl_add(struct ofdpa_port *ofdpa_port, int flags,
 			       struct ofdpa_group_tbl_entry *match)
 {
@@ -1085,7 +1073,7 @@ static int ofdpa_group_tbl_add(struct ofdpa_port *ofdpa_port, int flags,
 
 	if (found) {
 		hash_del(&found->entry);
-		ofdpa_group_tbl_entry_free(found);
+		kfree(found);
 		found = match;
 		found->cmd = ROCKER_TLV_CMD_TYPE_OF_DPA_GROUP_MOD;
 	} else {
@@ -1122,14 +1110,14 @@ static int ofdpa_group_tbl_del(struct ofdpa_port *ofdpa_port, int flags,
 
 	spin_unlock_irqrestore(&ofdpa->group_tbl_lock, lock_flags);
 
-	ofdpa_group_tbl_entry_free(match);
+	kfree(match);
 
 	if (found) {
 		err = rocker_cmd_exec(ofdpa_port->rocker_port,
 				      ofdpa_flags_nowait(flags),
 				      ofdpa_cmd_group_tbl_del,
 				      found, NULL, NULL);
-		ofdpa_group_tbl_entry_free(found);
+		kfree(found);
 	}
 
 	return err;
@@ -1166,18 +1154,13 @@ static int ofdpa_group_l2_fan_out(struct ofdpa_port *ofdpa_port,
 {
 	struct ofdpa_group_tbl_entry *entry;
 
-	entry = kzalloc_obj(*entry);
+	entry = kzalloc_flex(*entry, group_ids, group_count);
 	if (!entry)
 		return -ENOMEM;
 
-	entry->group_id = group_id;
 	entry->group_count = group_count;
+	entry->group_id = group_id;
 
-	entry->group_ids = kcalloc(group_count, sizeof(u32), GFP_KERNEL);
-	if (!entry->group_ids) {
-		kfree(entry);
-		return -ENOMEM;
-	}
 	memcpy(entry->group_ids, group_ids, group_count * sizeof(u32));
 
 	return ofdpa_group_tbl_do(ofdpa_port, flags, entry);
-- 
2.53.0


