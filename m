Return-Path: <netdev+bounces-294762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eF1FHIM0IGpSygAAu9opvQ
	(envelope-from <netdev+bounces-294762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:04:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A863860D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 16:04:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=Cvj9VYEm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294762-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294762-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C1A63006B4B
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA6358388;
	Wed,  3 Jun 2026 13:59:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0E39769B
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 13:59:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495185; cv=none; b=P/GcbGOjBgENfg+HzB+aA5XoZI2PLo2WqVpu4c5T+f78d49LJWbEkPkHDSKyVmWC0yO7HjOYTabLa0OHIMmxt9cGKMx0Zr8bBmFTKdb5/6zonJcu100xH161VlCVXiKmc/A0vAeDhfvR5siwrqBi8XGc81jzjPLd6T8eTs9Jn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495185; c=relaxed/simple;
	bh=yUcITEvuG4jog3LZnNkxt0FkhnQ5MYylhkYJGr0OQPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmdBQkw5l2vodfetO1gwrWOYKz96t8w27hguDewK2Glq/aRQfUaxwylwa7SDuiGm71Xp9I3VAznCsOTgFLGtYuSdqPluGfDoIFaT3kZvhXsYrDUxmyFio9w5FDv61xRJIND0Qv4XBkZgevGiELJdVTwqDdXlkgaQa2YwMzzU0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Cvj9VYEm; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso5147425e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 06:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780495178; x=1781099978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1p4OnpYDXMpkwZDQAdqQJhqxfh5Hb6QqekAS/cW1P68=;
        b=Cvj9VYEmOJklKHEkioLtqTMoNp6U/WLregPyGcObvHl9/EtS5xXKf9bb0/Udj9Uy/L
         WZiNk/Jh+Tk5PEiTiQmcsG4Xt0wabo4+HHcTBTiMNuAkiMHUvTg8h5J3b2pWu4xdLzrX
         aA2wp/gQviyMWm8lnNVkKokp6UpA25Pn1ViKP8rksLsfgT7YybrTRdFC/pIr+c999HsD
         gQXUwgiLYrcqxn28V9xbue8VU2K2zoJlV8m8lS2jA5fDcY8kgg8f+KJOYSCigfitBp4g
         k6vJVVtI+qYSfeVl/y2JdKUC4Jep+0kFHpAannyJL0l22ar+ScthTWfsbIChrVJN3SEq
         pJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495178; x=1781099978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p4OnpYDXMpkwZDQAdqQJhqxfh5Hb6QqekAS/cW1P68=;
        b=pUx/EoA7j2tUGWfYLOrrjUiGdHYaRW++Htt2pNWOg6UvQ+NRCjGDWJRTBn1aXUYfpl
         Fuir9gnvj4OAG5JgArvbziFFeBFNujgigWaJceZeP3mLsVmmhydBEG2Qigr5kPQnFzCM
         ZhdWJSVfWZ0vyNgUvLVf8oZ8HEwhL8Y2M9WEfHQGrBuUV3nGsNu/Bp/qGMvGJsLEJki8
         VUrjmF/1Y5iMaMDvN9RD+MHmdnH+bTVrb5csnMwI9GRSOqMs3t2eW8S8DBj2mKrYUO5A
         GXQ+TT8GnFwbSo/WXPSPGwv3Wy029lws11PZ/9F4ZyC+iKFS07LAONCDmQ4fZhBIl7Ad
         QfZw==
X-Forwarded-Encrypted: i=1; AFNElJ9B4qgzOPcUblEm2e3NMKIQ0s1shIgfvGEYMBVKvcsvlH1XzgIyTFFsTyFAm+lnrboAfNxCU1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJELXBTTi4KN4s14ysPsVYULWjCHJae3B6ZM7ZAZNhthQXXdtV
	f+pYKDhDkB9rlmqMEbl7RST5vJ0/xGrbm8ZPVIMiE2fJmPqUKH+HkyuamuqoPE5PT16W
X-Gm-Gg: Acq92OE4j/5nxybpsoiS9REqop2lZuoyd95+fwqwiO+1LQAN6TOtwAT0B4IgVp7vn3N
	4g/BQaANO4O6gPgs6IIcwcKfqD1A5JtD0BfbGymZOstx1YBv2w2QazgS4R5aN4EUg/vcfhpdS0q
	txmpuDttz17yKCOK4M0XAqETGyg4hawQQvlnxxZmpmeYaE/n7I0gQhFfAEWeiQq7bXnSLziH8lJ
	w4xmoDUL3xEGqTdZ/oua/ic5jZiXocWK1V6Ak734mnoC9It+aklXMlq1+iLloqR93wGaLWpl60u
	R9k+3wDynlDRnx4IFSPyKq1XpLFDuKG+xRn9Jnn1gUzIjIxAdaxHwmfFDsuU4floGIfIWaKhcS4
	Ot3Kuz2yzlgI4kO697wgl/Mva+o7HNdfjCnJEl+Ztbek8pEJOLKg00fEgg7M5ac4fQ+5NrDIZWO
	bNa3VPfEKL/lHf+/hRit70exLaJb/fA9ObOFHHG7wmMx7CPNSDMJH7OusjZGLAu/1wSnlESyn9f
	TiYjRy0s/0aBT32DJuninp4zC562b1k3KRCqYWlb7AzAJda+OyKV3MmQG8wK8PaCg==
X-Received: by 2002:a05:600c:3e19:b0:490:8b0b:d3b1 with SMTP id 5b1f17b1804b1-490b614c9demr55616715e9.12.1780495177808;
        Wed, 03 Jun 2026 06:59:37 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a7cb85sm59455345e9.1.2026.06.03.06.59.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 06:59:37 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev
Cc: David Laight <david.laight.linux@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] nfc: llcp: bound SNL TLV parsing to the skb and add length checks
Date: Wed,  3 Jun 2026 15:59:35 +0200
Message-ID: <20260603135935.62647-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294762-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:david.laight.linux@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 192A863860D

nfc_llcp_recv_snl() walked the SNL TLV list using a u16 offset/length
pair derived from skb->len, without bounding reads to the actual skb
data. Three problems followed:

  - For a short frame (skb->len < LLCP_HEADER_SIZE), tlv_len underflowed.
  - The per-TLV header (type, length) was read without checking that two
    bytes remained.
  - A declared TLV length could run past the end of the buffer, and an
    SDREQ with length == 0 made "service_name_len = length - 1" underflow
    to SIZE_MAX, driving an out-of-bounds read in the following strncmp()
    / nfc_llcp_sock_from_sn(). The SDRES case likewise read tlv[2]/tlv[3]
    without a length check.

A nearby NFC device can reach this without authentication; LLCP link
activation happens automatically after NFC-DEP.

Walk the TLV list by pointer, bounded by skb_tail_pointer(), and validate
each TLV declared length before use. Add explicit length checks for
SDREQ (>= 1) and SDRES (>= 2).

Found by 0sec automated security-research tooling (https://0sec.ai).

Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2:
 - Walk by pointer bounded on skb_tail_pointer(); drop the 16-bit
   offset/tlv_len math and fix the short-frame underflow (David Laight).
 - Add an SDRES length >= 2 check alongside SDREQ length >= 1 (David Laight).
 - Bound the SDREQ service-name pr_debug to the field length (no over-read).
 - Rebased onto linux-nfc for-next (David Heidelberg).
 net/nfc/llcp_core.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f..d23ca815a 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1286,8 +1286,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 {
 	struct nfc_llcp_sock *llcp_sock;
 	u8 dsap, ssap, type, length, tid, sap;
-	const u8 *tlv;
-	u16 tlv_len, offset;
+	const u8 *tlv, *tlv_end;
 	const char *service_name;
 	size_t service_name_len;
 	struct nfc_llcp_sdp_tlv *sdp;
@@ -1306,21 +1305,28 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	}
 
 	tlv = &skb->data[LLCP_HEADER_SIZE];
-	tlv_len = skb->len - LLCP_HEADER_SIZE;
-	offset = 0;
+	tlv_end = skb_tail_pointer(skb);
 	sdres_tlvs_len = 0;
 
-	while (offset < tlv_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		switch (type) {
 		case LLCP_TLV_SDREQ:
+			if (length < 1)
+				break;
+
 			tid = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;
 
-			pr_debug("Looking for %.16s\n", service_name);
+			pr_debug("Looking for %.*s\n",
+				 (int)min_t(size_t, service_name_len, 16),
+				 service_name);
 
 			if (service_name_len == strlen("urn:nfc:sn:sdp") &&
 			    !strncmp(service_name, "urn:nfc:sn:sdp",
@@ -1380,6 +1386,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 
 		case LLCP_TLV_SDRES:
+			if (length < 2)
+				break;
+
 			mutex_lock(&local->sdreq_lock);
 
 			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
@@ -1408,7 +1417,6 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
-- 
2.53.0


