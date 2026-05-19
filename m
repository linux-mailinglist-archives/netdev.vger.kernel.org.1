Return-Path: <netdev+bounces-289235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IoEFC68C2q3LgUAu9opvQ
	(envelope-from <netdev+bounces-289235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA15760A6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC20307543B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7D229B12;
	Tue, 19 May 2026 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjiWy7Gt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04402BCF46
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153786; cv=none; b=sB1+SDVg8+0RJAKourETa14/jlPHT0wAigrcYZkXK9xVn4HRzLx8T3GG8n3fCktSZP++kmpi+G4jkfQgAC0sqtRtmFuXcdPjix2g/Q+8AxrIyMGh1wcuQpl/WE4XaGV55ANGE8NYaDkVLe1hKJwKT9f3vQmUfOvjQMLPyJs3QbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153786; c=relaxed/simple;
	bh=VeXWv1s7VjIj16f62IeF3AHt/aQZkX3KYCOUQT1VU0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLBjzlOxt+plFt01o7MbPhWAC3qNUodckrqQbq0KWu/BypPaNcRygu/YqJ/JYAQvY7mGY520yyCuffgKegr76Aux5eYsnsxVIwxrCCwi8NKRuI37rbZHWLSznuF5qLkNQGK1zoiMJGbRiAAvtg+hTptRneNAMkJYrJyocTHHd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjiWy7Gt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso17871065e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153783; x=1779758583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsZN4KBbcJX1FoY6/tUwgCFPOKTIi4RrtSn6JymXQo4=;
        b=DjiWy7Gt2o13EAY6WreAHqQWHjsPARbZ3CbVns8iFOnfswX4upOkm0Vj1eqVk0TJom
         VzBsOUAcToXs2dIekG088Cc94uQ4DkiBAZwlVSDVfVdJmmpbqHAP9/evg995SToNLvOP
         7ZzePy7P5OJBn0GnaTip+Uf6FSPt5ihuJtrfoEIBJxz6AboQH/we9q5hGirTeCAgGsOn
         Rj5P4OVcGbZ6ed+J8Q2+gs5qmDySAiNjJo8c7XOsSuiepUSwlWXttf8Zb9Z/JfCsSj8S
         7HH7VxFjm9A3VV9XxIH+dDfYCKp2eLB8vptaQVtAxG4OqGaUNdkoZ9CfpmKvh/xHM6cM
         r7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153783; x=1779758583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JsZN4KBbcJX1FoY6/tUwgCFPOKTIi4RrtSn6JymXQo4=;
        b=i9qYWqYph/vGx+sUrTbzVLAyZ2TeGtpZWi9uj4pQ6PyULiIc6NWOJcTHU9v3Ihes4v
         WU85qT6LUYg6EoK6TPqTeWTmIOh/afmqAp36p2W6SApnBUHd2Er/NL08G99jm2GQCpIn
         HkMOOwS0L8SBtcN7SAuwCAfO71fw9W9jxfbJzuSXJS/C/gaF3jlEvSl9AxWyzG9a8oDF
         B46LGVAZmJWbsm0aZeeT4Ol0y6oJ76nfhpat73jhENTok9LnSUb3eEyfTt3VY56HoMeU
         Zr1qZ8w3jOcSPVaxYVAQ4/NEnHLv7a1Np2KlOKR5nHD7EMa3LIH9iIvGAri/H/OzERNo
         Me3A==
X-Gm-Message-State: AOJu0YztJ3LB94/uAC6VQI+D7zPgW/EbFj2s9ROdxciH87RgX7XznHib
	an8z0mLq/gxax+iPxgrqliDtHeCc5phDY1u+WqteBojG1wYjtpaTvKc1cjW0acdbDTc=
X-Gm-Gg: Acq92OG6metP2YF6GDf/6xZVD6uhvbZmplsV93/El1AaDCvmJVVi967Wp0hHVcngeyW
	usV197DNO780VJlEOK9txSooGAKF86fwJYBR+Vadg4VZQ1F61JIV08VNtkY6k5dCnTJtJZMMvlR
	mAJRJC3GEyvctKwYC4korl57klVZlOnjOIBAd6hCzQbgDGUhBTFAInKsVZnBTZw0cT3M1rAMHKZ
	44QTxbjdae2Tuk3OHWhSv7Mb9Wza/UsejsfZ86ed2l+ejrlQBDPEloUwYUi4NBS24doBImbG6Ai
	s2cYDEC90MklI1ga8Ri81ypLph6C8ucMEIQhzF2dpMBTvWnsA8ss/oRfdHLdejCsYvXnbXc64nv
	OmZT2L4yXcYaBdBOKBhykv2V226ZvDjptfkf6L8D6mtWFSpgl/8bxeSI+r1c89Apu2JfLGIwUiR
	gJ4oF6zKWDkPGwpNxDJToOgTyX5794yPlSjIEPBKeozwXnTbqjUFMyEFhHod/3sm0WdNLTvZSZN
	RqB3Ye9wmOz
X-Received: by 2002:a05:600d:10:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48fe60d7882mr221269375e9.13.1779153782352;
        Mon, 18 May 2026 18:23:02 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm44255416f8f.10.2026.05.18.18.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:23:02 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	david+nfc@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net 1/2] nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers
Date: Mon, 18 May 2026 21:19:36 -0400
Message-ID: <20260519011937.12903-2-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519011937.12903-1-meatuni001@gmail.com>
References: <20260519011937.12903-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,ixit.cz,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289235-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,nfc];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B4BA15760A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() contain
three related bugs in their TLV parsing loops:

1. 'offset' is declared u8 but tlv_array_len is u16. When TLV data
   advances offset past 255 it silently wraps to zero, causing
   infinite loops or double-processing of buffer data.

2. Before reading tlv[0] (type) and tlv[1] (length) there is no
   check that offset+2 <= tlv_array_len. A truncated TLV causes
   an OOB read of one byte past the buffer end.

3. After reading the length field, the value bytes are accessed
   without checking offset+2+length <= tlv_array_len. A crafted
   length=0xFF on a short buffer causes up to 255 bytes of OOB
   read past the buffer end.

Both functions are reachable without authentication via
nfc_llcp_set_remote_gb() which feeds remote LLCP general bytes
directly into nfc_llcp_parse_gb_tlv() with no additional
validation.

Fix all three issues by widening offset from u8 to u16 and adding
bounds checks for both the TLV header and value field before each
access.

Fixes: 3df40eb3a2ea ("nfc: constify several pointers to u8, char and sk_buff")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/llcp_commands.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26fac..9162f8161 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,20 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len) {
+			pr_err("Truncated TLV header at offset %u\n", offset);
+			return -EINVAL;
+		}
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len) {
+			pr_err("TLV length %u overflows buffer at offset %u\n",
+			       length, offset);
+			return -EINVAL;
+		}
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +255,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +264,20 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len) {
+			pr_err("Truncated TLV header at offset %u\n", offset);
+			return -EINVAL;
+		}
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len) {
+			pr_err("TLV length %u overflows buffer at offset %u\n",
+			       length, offset);
+			return -EINVAL;
+		}
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
-- 
2.54.0


