Return-Path: <netdev+bounces-302417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q9AzGHiLQWoKsAkAu9opvQ
	(envelope-from <netdev+bounces-302417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:00:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED56D4EED
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:00:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IeJxOIi4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302417-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3534300D15B
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71789364045;
	Sun, 28 Jun 2026 21:00:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D4194C95
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 21:00:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782680437; cv=none; b=qjROhfEM/9NtX8dEIFYvhJEtG0tg1mOavOI3f1Eu7u7sbXG1nBxlazFzVSBNY71dEBjDM9QZIe5hW4PRkypBt8EZ7WspOioZhlv817v3jxpdWRjMuHp8VBHyyJ4DRAmnSKRM57WgTj+TN9gEzk2Tsk2ffiT03anZJ2EEzBGMCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782680437; c=relaxed/simple;
	bh=qsF2zEMe9MrdDEhAgXCZ9mk3Y52f0O8tyH/reTQnQAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZnkA7p/hH5UQCfUHCbxJf1GYB8vNJtjDo2angYauOGrtQTM4FIznmIycDcaUSjreIn9lD4TJUy4cQ3Fb0WSFf6iMgeQeLrbWtsH+KkOwgq/DTMLi6vs4TpcJ/NT74u26FGxQxdU8Ab9LLfA8jlmPR0c2PEnLGD3v0M46Gs/Lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeJxOIi4; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fa53bc22dso1590574a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782680435; x=1783285235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntRF8aySUXd8W8x0gTrlgVfKPreN/+S0UpqzJ9bROBk=;
        b=IeJxOIi4S4HW7YnohOM0SPZK4r97SkQNLRMicJXbYe4wG+yMeuvTUifQhuapwmlIU8
         z8GuEttFafgc1M9fi01xGBLSKPv43JlHYUYYzwLAfjLPf5rgFdvPe7ZV7Y2sYT7AVeX0
         bqRxjGJiy5m5MVmP/572Lt963mwWw8N48rRWH5O72Ar7erf06R/ldIMchVpaUyPPuye9
         h27LByN48BTW+PGLtl9kzDPIqIFA+AAEfhi22Wndzl1y5nTvgdR1AeaUyniSSW9zbsQk
         anksrX99V8kAQeNrlSi0a6DILZgdxREDH+BFlKarTYqHhPR+ytKPuv4or6YWqk+p/RGm
         jHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782680435; x=1783285235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntRF8aySUXd8W8x0gTrlgVfKPreN/+S0UpqzJ9bROBk=;
        b=NZIi7PZA2i5kTdwq5tmMH+UwD7ehsyBvSWHoscn7C5LjQKrUhHs/Sra4yodSPnq/Pc
         9c+HLz2/6qwI3fHMHLeY8i/9zrMCxsl/olBp5emsoolDk8IHvAmgjd/JGtxY8Puur3+S
         AF5GI+kzd/j/fZF7OS8sFKa1EKFYPOWMGvDp/bhbkXY1UK5cC6RmISEc0QhH7o7cG4Vh
         pl1GJOxO8jZzUFDcBZ/VLkqQpilUxTEQFsxwh0Ekezs/t8LVQy87WxTVvdmMP2c31gf1
         GCsRLsQvFWdPEjuLn0M3KkP9qEPw/BIJGvoqnqutbz2vqGiDP+e5sA2MC5z7WsmJ9c48
         vLWg==
X-Forwarded-Encrypted: i=1; AHgh+Rp5kcUmDklwUVyYd4/Av/hmORUD/26LgJL73dDxAsvPuA3nNsSp6lPjslN7sM893eK3/m0jFAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSg/R2O/+mp+X+Vnd2eDSSbNqQZxMANjXrvHhDF/ZP6PeaORS
	k0u6AwWcOMYmPIY3fKTvenS+dy8Mtl6OE5tMKyHCF93x57ebop9wLdT/
X-Gm-Gg: AfdE7ck8887ZW8/sVDHq1X8ZHqIV7QIiltkOu6IFmodTVWXFPik5xgHe0t63zWM+37a
	8fqp66C4yd1rIM6xT52EANgyihOPjFfPNPQTe1ClsvTgsi6GdILq+S4ibroBt6o8JoOow1cu4Sh
	KkIK7CCQa4UswJRwAJGo5Ei7mXP4tTn9428dCjrsRtjpcpaRPI+uTitTJH2OkbxIRihLDyhs+QO
	tWyHFrGgQAPLcC84+Hss+n2hOfnM/+Sl+Ncqi0+TCvbeOak8U/lIcEEwjN1JVIZxXGmcDHTEaFc
	9cXJ3Nfw4P8qwm/+KJeg1N8sV5GpLpUopxp3L/6oZehSMJmHOp7vrjIt4vrtnELWkASVGTWnjrQ
	S69XntneRR1g9gco2X5pjtCHvmgHnTTBtlge25t0QrSdYdO+ndqZDKgVyyHZtQfe0gaAN5jTRU5
	BSoKgUlV6TYOE06kQw2ylYqNgQrIGK/6Qveqco4yEioAZH6EUzYQJMfLq7YJgedSr4WP1XcQo=
X-Received: by 2002:a17:90b:498c:b0:37f:b966:5f1b with SMTP id 98e67ed59e1d1-37fb9665fdamr5959083a91.4.1782680435345;
        Sun, 28 Jun 2026 14:00:35 -0700 (PDT)
Received: from node ([149.40.62.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fd2bd0e49sm2390690a91.0.2026.06.28.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:00:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] nfc: nci: fix out-of-bounds read in activation parameter parsing
Date: Mon, 29 Jun 2026 02:00:26 +0500
Message-ID: <20260628210026.129941-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302417-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FED56D4EED

nci_extract_activation_params_iso_dep() and
nci_extract_activation_params_nfc_dep() receive a pointer into the
RF_INTF_ACTIVATED_NTF notification but are not told how many bytes
remain.  Each reads a one-byte length field (rats_res_len,
attrib_res_len, atr_res_len or atr_req_len) and then memcpy()s that many
bytes from the packet.  The length is clamped to the destination size,
but it is never checked against the remaining activation-parameter data,
so a notification whose length field is larger than the data present
reads past the end of the buffer.

The sibling nci_extract_rf_params_*() helpers were recently given a
data_len argument and matching remaining-length checks, but the
activation-parameter helpers were not updated.

Pass the remaining length down and validate each field against it before
copying, as the rf_params helpers do.

Fixes: ac2068384034 ("NFC: Parse NCI NFC-DEP activation params")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/nci/ntf.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb86531..63aa0a78472b1 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -525,7 +525,7 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, ssize_t data_len)
 {
 	struct activation_params_nfca_poll_iso_dep *nfca_poll;
 	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
@@ -533,9 +533,14 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
+		data_len--;
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
+			if (data_len < nfca_poll->rats_res_len)
+				return NCI_STATUS_RF_PROTOCOL_ERROR;
 			memcpy(nfca_poll->rats_res,
 			       data, nfca_poll->rats_res_len);
 		}
@@ -543,9 +548,14 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_B_PASSIVE_POLL_MODE:
 		nfcb_poll = &ntf->activation_params.nfcb_poll_iso_dep;
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfcb_poll->attrib_res_len = min_t(__u8, *data++, 50);
+		data_len--;
 		pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 		if (nfcb_poll->attrib_res_len > 0) {
+			if (data_len < nfcb_poll->attrib_res_len)
+				return NCI_STATUS_RF_PROTOCOL_ERROR;
 			memcpy(nfcb_poll->attrib_res,
 			       data, nfcb_poll->attrib_res_len);
 		}
@@ -562,7 +572,7 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, ssize_t data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -571,21 +581,33 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
 		poll = &ntf->activation_params.poll_nfc_dep;
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		poll->atr_res_len = min_t(__u8, *data++,
 					  NFC_ATR_RES_MAXSIZE - 2);
+		data_len--;
 		pr_debug("atr_res_len %d\n", poll->atr_res_len);
-		if (poll->atr_res_len > 0)
+		if (poll->atr_res_len > 0) {
+			if (data_len < poll->atr_res_len)
+				return NCI_STATUS_RF_PROTOCOL_ERROR;
 			memcpy(poll->atr_res, data, poll->atr_res_len);
+		}
 		break;
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 		listen = &ntf->activation_params.listen_nfc_dep;
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		listen->atr_req_len = min_t(__u8, *data++,
 					    NFC_ATR_REQ_MAXSIZE - 2);
+		data_len--;
 		pr_debug("atr_req_len %d\n", listen->atr_req_len);
-		if (listen->atr_req_len > 0)
+		if (listen->atr_req_len > 0) {
+			if (data_len < listen->atr_req_len)
+				return NCI_STATUS_RF_PROTOCOL_ERROR;
 			memcpy(listen->atr_req, data, listen->atr_req_len);
+		}
 		break;
 
 	default:
@@ -806,12 +828,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
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
-- 
2.54.0


