Return-Path: <netdev+bounces-297276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6MkEHM92KGpcFAMAu9opvQ
	(envelope-from <netdev+bounces-297276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3666412B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:25:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=hq832+iC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297276-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297276-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52E393021EE6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BF3905F4;
	Tue,  9 Jun 2026 20:25:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF68349AE6
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 20:25:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036749; cv=none; b=FNpy6uZZlv3fcTNyroc3hZlITLUejQu6JvyUNjil+x7xqkiVtv9l6yhui9YfKtWwAMP2FqhxIi00y66VpQRB9c9PsUi4xSLcFRBi+xYFyliyF85wLnz7tCn1o4+XCWNmKS3djG3mz3/wne5qiLDnQPM0ST7MMEXy3oJjtknOAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036749; c=relaxed/simple;
	bh=oKkSVxT/Y4XKV2ObqYnE31wJmdQaPrWWo7tQBqtLFbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1f8nR2qHrKEaViUxsB/fyhMpmCimYBNzeubsG8xUTboQ1Gpf/ImAFLNeme2FNr9WuYxrFb4aVt2m667JLav8Hxy3uKmrXlba6u7mwZf0DvTmyelKHQRasns+15T20UrV/oemK5D7vrWdKTVFfXgWiEi4PnYvFyVtArBBxUnSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=hq832+iC; arc=none smtp.client-ip=209.85.221.53
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef4223be7so3261590f8f.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781036746; x=1781641546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQGRPMu1kxL0yXF36zCXENzLxRFFn1aJOYE1MvTj2ac=;
        b=hq832+iCJCELZKBabJzXUSMFh2Vw1B+YSTJQ0mQZ+XR3ekPc8ylB6L9rDEFE/+CipP
         +eLKBe93wo0Du9ub1yanTlZinNfb35i/yaH9Z6kPL3RwnNGRw7T6wSpJW4M9cCf4n5Ch
         QJbPlpGbacUltuw6+INXRq5ut2XBfSPD6E6dQee+o5aXpBg+mGVv1yxOBAWgROCiXckP
         3QcEWI0g0J66MSQKZN5qQvilbzpLhfDS9HSslDibqbcJ88pwLXuvIqxdO6dx28JpZl4p
         3v2fm4/pi9sy2q2CYZ/oa0QJk9qIDXMhiYdJ8cX19K5V/D71YAkhjnSkk8dSRBttfBWR
         zg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036746; x=1781641546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQGRPMu1kxL0yXF36zCXENzLxRFFn1aJOYE1MvTj2ac=;
        b=BBMO86JieLhFuWnS9dT0sKtEzgMYVg8Rs47fSOkpzMhxxaERoR82CP/HZBtwOqzXU2
         HXWUGQvJjyjovWTF4X3hH71ff1cquZp6WZW40fBuhd8eYunhYQJyS4NqVJeKFxgu0gBi
         PQovAWaR/eKNDdR2GavMGy7f7xxr7k6kxfzrobrCBGAC13GYCY0VmEHU1KPDmU0GbGfL
         z3ZpUHUXSHqn8lqcwegjEH1J5wl1BiYm9aC06PRSubGgStleXkQ5zIW2rt8LTnDVTaeR
         8yh7SlKVpPFCprZ6dhO5uMi/78wzKz0PUKq15daUBLk0OVzRxu3u8uHePQphWTX0P1eb
         MZxA==
X-Forwarded-Encrypted: i=1; AFNElJ/tId+zQfdethpNNVYPgIPr0HFC2KKuX0tkqxRs482rQXMKjOKameBH6J0F3reQ+E52imv0miI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRymSyreJrDpBh78sjmLIM3HWLw7BlWKGrWumNX9d1gqyBBFbl
	nsHPsvDPsFz3LVf3VscxkgZIhZLTXHVR/IvDsp81GW9w4N5GTKNp1KJWaozErBh1DbILLXcncY1
	uCL9lgLiJxRM=
X-Gm-Gg: Acq92OE4t7bFsq2bnOAouI2rKx+1t+AI44lCn1TVg+Ie6VKBF5I2NMZ69OpuG7e/zoN
	lu3fR3xSCB+BogiI+puMt/kDBD835UcnKqb9kIM7jD3LO3GFqXmfCCUXft+qlcuFSTqljWiQXvh
	lKmNLhGT2CY67O6KPQJxiZWkPIpLb7LoO8nZsiOSKH81MfnMvwM3/btf6mP6OTvu14RGgxMV/KO
	b2OW6tjR7xg9kbKGYnXuHpc4l4K4m+dnSzF1th0KAt4DlNHd4i11DAPuQqRjhT+hSed80+Oa4Kc
	FLp0XtJTdrAtYKPXmjMx1VPmqgntfhhvZ/xUNTv4O1H1fFGT7HiDEu0+Wvvi0/EclPOuHoGhaYV
	/3PHawDKPwNIU+HOwwex+XFw7/dbS0ZgfGoUVG21XPZX5yIJHx3N3EsTXIn5H78ilBmOC6S+fbx
	7r6J8N3X6Lj6wp9RW6bKGoZqF5HEJNses3Q7xsOgrhZTOwx0AXLvs7tWEtSJ+gjMnINhPXTsN0t
	c7rL6tObs+A4MApRXi7OFZ+vcDusxKWCzCCGRU+QHCrjWqzM5WQAtQ=
X-Received: by 2002:a05:6000:4022:b0:44a:b931:f32a with SMTP id ffacd0b85a97d-460566beef3mr6351288f8f.27.1781036746040;
        Tue, 09 Jun 2026 13:25:46 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm53432272f8f.7.2026.06.09.13.25.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 13:25:45 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Cc: david.laight.linux@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] nfc: llcp: bound SNL TLV parsing to the skb and add length checks
Date: Tue,  9 Jun 2026 22:25:43 +0200
Message-ID: <20260609202543.42282-1-doruk@0sec.ai>
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
	TAGGED_FROM(0.00)[bounces-297276-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FF3666412B

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

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v4:
 - Add Fixes: tag pointing at the commit that introduced the unbounded
   SNL TLV walk and the SDREQ service_name_len underflow (David Heidelberg).

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


