Return-Path: <netdev+bounces-295303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1LNZGhiaIWrdJgEAu9opvQ
	(envelope-from <netdev+bounces-295303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B3641712
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=qB7T3zH3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295303-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295303-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4043300C000
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD2632E6B4;
	Thu,  4 Jun 2026 15:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017130AD0B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 15:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586566; cv=none; b=AGHdZD6j/hUCbjcvuPglqwEAuERHES82q4FoWPcZM0jP5UpR9zQBmYLk50kRvfTIeoLZSyu9JT4+6F1VJrUHQAVBq9SZICzCLV9z1CMj923y8afPeD1hrh5Ms+qRahrsnEKeiSlLj6XSoqRyIbbimkyLVaD7w2VjxLg+x78DY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586566; c=relaxed/simple;
	bh=1N2/YBPS0yKsXsmbDL1qepre7J2Bz11f1c9p72hi8do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGxF2UFHtmgXFpiArvu0IjEKPeLa4q/s3Eh9vVhGx4ef3/Ic877rFuRv0KAqh01WFUC0momhHgq+5fShiPRJKyxfZAqXMO0C4WsPoSZUsHggaz83/FL4tHpapZeEOX3hAksGpKaZlzC1pKLRvbU8p6HCiV9ggLZzc++2MqLEw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=qB7T3zH3; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso4757655e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1780586563; x=1781191363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d57863DyLZ15Xl19eK7AJO9RSKTq1a/9ZBFF5sPg3ZM=;
        b=qB7T3zH3RgO2fD6+qEcOdqINMzJOrpIK/NYinsXlgtz82tKyu+uPVnOsVLTWCv3enE
         VHy1m+r2RV6g9MLZpcjlIXfkE18LlFuPo4q132DT+CO2btoT6muCemBzM5K90JGKiKtC
         mFtjOKbmaSZhvWRNUrKKC91x9tMVn4gaw4NzbiqPFRszgctdOAWg0OL1GfdlxKIhn1p/
         3eLcIHvTtjpM4jVDY634muZkhRzS0BGho991Vs6MetuFvNjcxawoGNQ92GTTBwadxqwv
         BBCYzg4KRdl5KG7hwExSakl5R3+0WcgSDA+k64QFAv2yV2dIdeKmm+vl+S0m5kZ3la/h
         6AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586563; x=1781191363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d57863DyLZ15Xl19eK7AJO9RSKTq1a/9ZBFF5sPg3ZM=;
        b=AM9k7ejqiLpvaln5s3a2yBWECxOk4VYYlgqK3WnF+S2SXl1tDuwklhDKeQJd7ID1Vv
         y6CajSmSFO53hTwJMw8wb2iy+bd6Hq9+lfZYbJR93mQE9cg5oCLWl6LRPenn1fsW15Uc
         Gmdt8cH9ZrFQR9gzqpBqfz/3uJOcF58VMxh4QiwXa4lcEwxMcGJGIWH+XO0hPz4Wykvl
         dJRB+xSzFHYn4AIrQemx6Q+5JkW3q0NIPQGqmJ8vuWHUiB099KhkHz1FxrtPdnEV1AoJ
         32RyjJyHUpSgDz3VHUhHTJKxuw4POrcN8CCIYp8ngREonNvUlGNRCjEQzuZUB1BsREig
         Eqkg==
X-Forwarded-Encrypted: i=1; AFNElJ+eNiq3uFdOyjnWr5Ga1V7uSYcRCU8clBsNgu38fFAlshBHmqokpuN/+w2IVbI50Gn+DSoyRkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xiGA5QI6XGQ9HFkGT1Kb5NLMaiVEfq5q6k9TBlFk1Bmoe6Bf
	4wDE1Q7ejzycQbX1vEjYliNYW28b+eJrdR8TR+J9W1wQuxfR5rUYi4sORn11rERXS/v8
X-Gm-Gg: Acq92OFN9Kn3vdXz9ep9LMf6w/4TBkXyVQXeegvONkhbY/WuFMEGlO/IQX71p1UcGzb
	tFvVOwT7o0lhq/ET9o2pgG6W/wCzxD7TW1JwvHwkix05XW8pFczgdddIDPGEMHZEOZ5qYaW9pKq
	KQmmvkbNgSM3U+nYKdjCg7q5J9AJJqHdXANjnMcqvVP3YoS00xVsrPvW78N4ZJkqYc3FWOTyHOY
	CgRLvSkX89OCrJoOQF0lTWEY3PItad10HgkgTexp609NUD0ffAnBCKQ/7I8paZYcCW+Tm02gJpM
	kJgKsgqBevzutYLtMbhuZPk/Pho7662gkodZWI/HExS06KBwg35ADIGTxaDkqiqnAUtXM5vzJv5
	IiTpjO9a8I8bOuF95hJXRaTQKLwOexNAsLwNfTfzxtNOOTcPiJ25vrwe0Swp2PmMMhGJNafG2oa
	G0a0+i3Wt7Owq8GcoKXIilt0aC3ANESulAOY5H1UzFAFGQTyqzj/qJJDjNplYhtE1SrjPJvdhWm
	xxvS15mxvBKRxLp2L6umb9soUtySr3iNxJ3HsPWhJBg1poT0P/2Znk=
X-Received: by 2002:a05:600c:8505:b0:490:3cf0:8d81 with SMTP id 5b1f17b1804b1-490bc4ff20bmr71110015e9.13.1780586562894;
        Thu, 04 Jun 2026 08:22:42 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm95418975e9.9.2026.06.04.08.22.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 08:22:42 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Cc: david.laight.linux@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] nfc: llcp: bound SNL TLV parsing to the skb and add length checks
Date: Thu,  4 Jun 2026 17:22:40 +0200
Message-ID: <20260604152240.14162-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:david.laight.linux@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295303-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F39B3641712

nfc_llcp_recv_snl() walked the SNL TLV list using a u16 offset/length
pair derived from skb->len, without bounding reads to the actual skb
data. Three problems followed:

  - For a short frame (skb->len < LLCP_HEADER_SIZE), tlv_len underflowed.
  - The per-TLV header (type, length) was read without checking that two
    bytes remained.
  - A declared TLV length could run past the end of the buffer, and an
    SDREQ with length == 0 made "service_name_len = length - 1" underflow
    (size_t), driving an out-of-bounds read in the following strncmp() /
    nfc_llcp_sock_from_sn(). The SDRES case likewise read tlv[2]/tlv[3]
    without a length check.

A nearby NFC device can reach this without authentication; LLCP link
activation happens automatically after NFC-DEP.

Walk the TLV list by pointer, bounded by skb_tail_pointer() over the
linear skb data, and validate each TLV declared length before use. Add
explicit length checks for SDREQ (>= 1) and SDRES (exactly 2).

Found by 0sec automated security-research tooling (https://0sec.ai).

Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3 (review cleanups, no functional change to the fix):
 - Comment that only the linear part of the skb is parsed (David Laight).
 - Use int for service_name_len and print the bounded service name
   directly with %.*s; drop the min_t()/cast (David Laight).
 - Require SDRES length to be exactly 2, not just >= 2 (David Laight).

v2: https://lore.kernel.org/netdev/20260603135935.62647-1-doruk@0sec.ai/
 - Walk by pointer bounded on skb_tail_pointer(); drop the 16-bit
   offset/tlv_len math and fix the short-frame underflow (David Laight).
 - Add an SDRES length check alongside SDREQ length >= 1 (David Laight).
 - Bound the SDREQ service-name pr_debug to the field length.
 - Rebased onto linux-nfc for-next (David Heidelberg).

 net/nfc/llcp_core.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f..aed5fe1af 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1286,10 +1286,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 {
 	struct nfc_llcp_sock *llcp_sock;
 	u8 dsap, ssap, type, length, tid, sap;
-	const u8 *tlv;
-	u16 tlv_len, offset;
+	const u8 *tlv, *tlv_end;
 	const char *service_name;
-	size_t service_name_len;
+	int service_name_len;
 	struct nfc_llcp_sdp_tlv *sdp;
 	HLIST_HEAD(llc_sdres_list);
 	size_t sdres_tlvs_len;
@@ -1305,22 +1304,34 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 		return;
 	}
 
+	/*
+	 * Walk the SNL TLV list in the linear part of the skb only,
+	 * bounded by skb_tail_pointer(). Each TLV needs a two-byte
+	 * header (type, length) and its declared length must fit before
+	 * the end; this also keeps the walk safe for very short frames.
+	 */
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
+			pr_debug("Looking for %.*s\n", service_name_len,
+				 service_name);
 
 			if (service_name_len == strlen("urn:nfc:sn:sdp") &&
 			    !strncmp(service_name, "urn:nfc:sn:sdp",
@@ -1380,6 +1391,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 
 		case LLCP_TLV_SDRES:
+			if (length != 2)
+				break;
+
 			mutex_lock(&local->sdreq_lock);
 
 			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
@@ -1408,7 +1422,6 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
-- 
2.53.0


