Return-Path: <netdev+bounces-307292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DH6nAjtgVWp+ngAAu9opvQ
	(envelope-from <netdev+bounces-307292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:01:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A8074F66F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 00:01:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=d4Ba279q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307292-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307292-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188B630134B1
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5F36F411;
	Mon, 13 Jul 2026 21:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233836AB54
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979983; cv=none; b=MJCuBOt6uNSnso1ukAmIgydkv0fg4TTxtgmyFPXTQo+3cjhO8u5UzWgaMKeC8C4CrLFRA4/SwySzcbtp5DUCX/JZNhtEunkyREhrXzxXbTuzmxuCWWgJEDT1nQmVNQs/DqmTb1cB/+Yd//vFaT/MUat9hKA5QWCoHgNNWO5sn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979983; c=relaxed/simple;
	bh=CHryohLe/fnBYpOI8e4BvVaoKUdQxQ7HJ+W2ldsPKKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nl+9EvZ+F5msR+7S/4rKkhNJGcEBPrYKSOUv3QmEzLtfRxtCPD0m0CtEcEa9xiIGkjk8aJ2tdHLpXvt1XQA9JAyDqJtj3DIsV00dGmBE92fDZJI4Ioan1rarckKs0/82Heq1IIaSWpaURmcw522/OSfx6QmFvID4V1/2QcJlANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=d4Ba279q; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493f25d47dcso2335665e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783979980; x=1784584780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=37p3VfmrrNMS4akxO403NRH36eKSLE6Wn3AfUCl+4gA=;
        b=d4Ba279qNkP/UzpnjQeR3R07VNfGiC7musfQDHgXQlPqo/ZZtjEKD23esT9dGQ91Tn
         V4qnX13+i8lyy4l1VYJDvtctc9g7MdmxVeMT1i37ee2iw10bnVJoG/DKd/qJy6eGTLaD
         VNcZCeKLzKS0rVxAd6q2nXeB7VvAWJ2TLSQyS/fbLTZ/ic9dP286KML7L8TXikk0u36k
         wJQrOHY+9D4yfNz2hCypcXChHxyzaNEdPT3/ftsiiqEEyoujBeWrRn2wkPmciZ/21VqJ
         3A3Mfc/A1RHvUz1lOoAUr3HG4Bcrr1zmpVVgctWaPFYuYwqr708BM/whR6LQ4qR6qdJp
         2GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979980; x=1784584780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37p3VfmrrNMS4akxO403NRH36eKSLE6Wn3AfUCl+4gA=;
        b=Byuj77Kll9Szer7gZ0Z4pOWxV0aha5s/cUeH+0/cF1EIrcodUDhDOyEZcqfzrIXjc4
         eKBnuwIGjiyBccF5IVqmK+gy7oqPuyVJt2qjOu3iiutOiSAu4ZZjgy4pQ6qyX7TpxHzJ
         MlthIztGCfGXA1sgSn+iwBX1sNYJcbL09LD0ililgWuQqeNUOrKiGE/pK8smzwZXqdCv
         AEzdP6OrhAp5OLwZ3gtSiAnf/fYTmJsemeQ/K0uYlMFHMNaaqh2Du3L1R8vfuWpq0Srp
         CL19QLZynuhCs18sp0JjgYY9aGGyZy0RSW/6ljGYwxURVkgUfx9BcwJjxmwTBDJUleS9
         4lKQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZgTDJJR42kuYK/s6BK2wqmL0f2SIygrp/l1ifd3tHazD2h+bGU9M8S1wxJp1S0YeXnlM2mrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOHe0Cxw4f4Y9iRs4sO0FyYHUJn7Otbu066zfBrze5RqiLeUl
	PUa0ZFlQLt0+IpsrGckxLylY9tMKEvvvzKIthOj2Jc0rgCrHRhfr8Stn3OUyDsWxZvIX
X-Gm-Gg: AfdE7cnrGHQ7AtVOaGEKPgkWECIh0AmmaNmIg6Pgo2TkfFj2UXkEpz0GyKZDwi4SVoN
	lkrl0fJ2Yrj39B+8m+o7u6PiAhFhLTCFt2qfPZka1Po7oQdTisQ22afPAyc0ltBiDV2CyMpADX3
	m9NTMzVEQXVv4DRwM6WtXfW921g9Zu6dlPfJORDX0ig+z0KhOuXBw18jy+Ata1Ilr9mAREgBAJ1
	7AkfNhkfA/tcxD8vOhVuFQg4YQBXoRqoLEtLPFi5J/MEPr34sthAvu9JYRCp/YFKkhdNN2znvSk
	SZeolgVXlMfL69XS+fgrXnTWyGsAwNbGD6bYTjd4NLdrbGC+cBPAvhG5dLZc4Cah8Catr7W4YLh
	wwU7HvA/VN2qayr/Njzew4FV2H54/vdQPkWAZWLdtol4g+EwZor5PP5Saz33ZlLe7hqfAUiZsk+
	dCZMAEP2whZaFf2oO2vfeypBOBBDk0eCcu2rDOdl3CoQznGUTJoKAT6dy7d5CfMPjaKiGHBBgh2
	wFV9wIuHGI4Ob2Dpoo+q52S0AodtCDoUqo=
X-Received: by 2002:a05:600c:b90:b0:493:b967:178d with SMTP id 5b1f17b1804b1-493f881d05emr112865375e9.19.1783979980087;
        Mon, 13 Jul 2026 14:59:40 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f9402sm28390785e9.13.2026.07.13.14.59.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:59:39 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: microread: validate CARD_FOUND event length before parsing targets
Date: Mon, 13 Jul 2026 23:59:36 +0200
Message-ID: <20260713215936.23137-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307292-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43A8074F66F

microread_target_discovered() parses a device-supplied MREAD_CARD_FOUND
event into a struct nfc_target, reading fixed offsets and -- for the
ISO-A and ISO-A-3 gates -- a variable-length NFCID1 straight out of the
event skb. The only length check is nfcid1_len vs sizeof(targets->nfcid1);
skb->len itself is never validated, so a short event makes every gate
case read out of bounds past the skb:

  - ISO-A / ISO-A-3: fixed ATQA/SAK/LEN reads plus a memcpy of an
    attacker-controlled nfcid1_len bytes from the NFCID1 offset;
  - ISO-B / NFC-T1 / NFC-T3: a fixed 4- or 8-byte NFCID1 memcpy from a
    fixed offset.

The copied nfcid1 is exported to user space via nfc_targets_found(), so
the over-read is an information leak (and a possible oops on an unmapped
page).

Reject events too short for the fields each gate case reads.

Found by 0sec (https://0sec.ai).

Fixes: cfad1ba87150 ("NFC: Initial support for Inside Secure microread")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/microread/microread.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 4149c5d735bd..9a7a4fd6796b 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -483,13 +483,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 
 	switch (gate) {
 	case MICROREAD_GATE_ID_MREAD_ISO_A:
+		if (skb->len < MICROREAD_EMCF_A_UID) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    skb->len - MICROREAD_EMCF_A_UID < targets->nfcid1_len) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -497,13 +503,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_A_3:
+		if (skb->len < MICROREAD_EMCF_A3_UID) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A3_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A3_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A3_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A3_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    skb->len - MICROREAD_EMCF_A3_UID < targets->nfcid1_len) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -511,11 +523,21 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_B:
+		if (skb->len < MICROREAD_EMCF_B_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_ISO14443_B_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_B_UID], 4);
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T1:
+		if (skb->len < MICROREAD_EMCF_T1_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_JEWEL_MASK;
 		targets->sens_res =
 			le16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_T1_ATQA]);
@@ -523,6 +545,11 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T3:
+		if (skb->len < MICROREAD_EMCF_T3_UID + 8) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_FELICA_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_T3_UID], 8);
 		targets->nfcid1_len = 8;
-- 
2.43.0


