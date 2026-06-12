Return-Path: <netdev+bounces-298758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fuSgJ+hGLGrtOgQAu9opvQ
	(envelope-from <netdev+bounces-298758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEBC67B71D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:50:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="nr2ZHuY/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298758-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEC9D3004608
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C72636AB44;
	Fri, 12 Jun 2026 17:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4D367B99;
	Fri, 12 Jun 2026 17:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286626; cv=none; b=sUllLBh8WN4WSQC+VBJi5+rC1Use1QL9E/O5UWDTrQzoeWmtflxV+vRW12ZpQY9Ht2vYaohaONrOQzICyp55HbxKHBxRExg0iWChA7lmiPZX6lS81rn3nBgniNQ6OqrfdXXJdfXYNIykdtyNxghQmyCfZzyRluMV9yDuH2pWYvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286626; c=relaxed/simple;
	bh=GftbwVGxN5+3396T6O7JKnU2Qpkol1nyIS4+zmauKdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WNYQmGDMVeOiU+MkNyTzV2k49VQCv24Kjj6QDK0vrJLIDhQ85/GKqOdI3lyTOOg6sOVyAvX+L1SR6QW5Cd3fV/aQqF4/dNle33UzZ+RltUpV1savqSVDHKGaNeJUqkS1LulwccHVhTl80X5hfk1ll1+l4/X3u+NmyIU8cUdMWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr2ZHuY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6638C2BCB4;
	Fri, 12 Jun 2026 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781286625;
	bh=GftbwVGxN5+3396T6O7JKnU2Qpkol1nyIS4+zmauKdY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nr2ZHuY/jnnZ460Vlle1PjjEnlezr9QwQItXfhs6g2EHcUPivlpZsArAgSyD/UmlW
	 ScxXIGPA2ENscg6GgNDL94+Xdfeq2lTbuabHdF4Tw7cHrknz5KRs6RoU4RGTsheaGI
	 E1OqRL1OCUS2ZqSrt9JqsHmVS+xnBVUC9ra5NuNFitXLDewggJVyCl0kdaRGxdDapE
	 37cPmnS+eJGe86gcW95aa7hZXIMUkBD4o4As5PYayZ8G0vG6oe7m+J7iDX+zt7ZJWN
	 MyoXu3AVHLWyhURrpgf12zcj6drni/8OSYVjlJ2hcbZ0eb5rBNcunU8Ypw01SSK2C7
	 rlqXgBtYmUCsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DACD98CF;
	Fri, 12 Jun 2026 17:50:25 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 12 Jun 2026 12:50:25 -0500
Subject: [PATCH v3] nfc: nci: add data_len bound checks to activation
 parameter extractors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-b4-disp-6d52d8b0-v3-1-e26221f8826d@proton.me>
X-B4-Tracking: v=1; b=H4sIAOBGLGoC/x3MMQqAMAxA0auUzAbaqEW8iji0JmoWLS2IIN7d4
 viG/x8oklUKjOaBLJcWPY+KtjGw7OHYBJWrgSx56x1h7JC1JPTcEw/RYhC3kluYhxChZinLqve
 /nOb3/QAIYJgCYgAAAA==
To: David Heidelberg <david@ixit.cz>
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781286625; l=5384;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=BcPYukihDqR5SWpAuWPZtnkwUMfhZZ+Ci4OmUYp2RgA=;
 b=+4IkML7bYD0JoljnnfBm+g3tLOVsiqR6FAHmkAHGeKfMdG6+r2tj7NHIPRfAfn3+su2jrcGp1
 9tVou56eCqECJ0cziuxps8epVu+qVU0ti+yRCxnBfcSjXdBP7j32gMJ
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298758-lists,netdev=lfdr.de,hexlabsecurity.proton.me];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:replyto,proton.me:email,proton.me:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FEBC67B71D

From: Bryam Vargas <hexlabsecurity@proton.me>

nci_extract_activation_params_iso_dep() and
nci_extract_activation_params_nfc_dep() read an inner length byte from
the NCI RF_INTF_ACTIVATED_NTF payload and use it to memcpy() into fixed
kernel buffers, but neither function receives the caller-validated
activation_params_len.  A crafted NCI notification with
activation_params_len=1 and an inner length byte of up to 20 (NFC-A) or
50 (NFC-B) causes memcpy() to read that many bytes past the one valid
byte in the activation params region -- a slab out-of-bounds read of
kernel memory adjacent to the NCI skb.

The sibling nci_extract_rf_params_*() family was given equivalent
protection by commit 571dcbeb8e63 ("net: nfc: nci: Fix parameter
validation for packet data"), but the two activation parameter
extractors were not updated at that time.

Add a data_len parameter to both functions, guard against an empty
region before consuming the inner length byte, decrement the remaining
count after consuming it, and clamp the copy length to what is actually
available.  Update both call sites to pass ntf.activation_params_len,
which is already validated against the skb at ntf.c:801.

Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 net/nfc/nci/ntf.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..8bc3adbc5b6b 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_nfca_poll_iso_dep *nfca_poll;
 	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
 
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
 		nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
+		data_len--;
+		nfca_poll->rats_res_len = min_t(__u8, nfca_poll->rats_res_len, data_len);
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
 			memcpy(nfca_poll->rats_res,
@@ -542,8 +546,12 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 		break;
 
 	case NCI_NFC_B_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfcb_poll = &ntf->activation_params.nfcb_poll_iso_dep;
 		nfcb_poll->attrib_res_len = min_t(__u8, *data++, 50);
+		data_len--;
+		nfcb_poll->attrib_res_len = min_t(__u8, nfcb_poll->attrib_res_len, data_len);
 		pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 		if (nfcb_poll->attrib_res_len > 0) {
 			memcpy(nfcb_poll->attrib_res,
@@ -562,7 +570,7 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -570,9 +578,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		poll = &ntf->activation_params.poll_nfc_dep;
 		poll->atr_res_len = min_t(__u8, *data++,
 					  NFC_ATR_RES_MAXSIZE - 2);
+		data_len--;
+		poll->atr_res_len = min_t(__u8, poll->atr_res_len, data_len);
 		pr_debug("atr_res_len %d\n", poll->atr_res_len);
 		if (poll->atr_res_len > 0)
 			memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -580,9 +592,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		listen = &ntf->activation_params.listen_nfc_dep;
 		listen->atr_req_len = min_t(__u8, *data++,
 					    NFC_ATR_REQ_MAXSIZE - 2);
+		data_len--;
+		listen->atr_req_len = min_t(__u8, listen->atr_req_len, data_len);
 		pr_debug("atr_req_len %d\n", listen->atr_req_len);
 		if (listen->atr_req_len > 0)
 			memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -806,12 +822,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
 			err = nci_extract_activation_params_iso_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_NFC_DEP:
 			err = nci_extract_activation_params_nfc_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_FRAME:

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260612-b4-disp-6d52d8b0-ae1f21cdd8ab

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



