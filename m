Return-Path: <netdev+bounces-263311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FBEBJ4Np2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:34:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F1F1F3E30
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE69C30BB711
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8684E379B;
	Tue,  3 Mar 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6nivYvP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0754E378F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555036; cv=none; b=meip2quVdtvzxgvdMdikHbTffo0qUsJmoDxbxICECR9zbfzOWY7NVBYFSVjdA6NVKYE4gFochNnDVaTgTNiT0mujqpi47C4g6mJOX5Zep97Quqag+ZMHhOCpAz6MCkdQODFWtIFH/N3QpvGjDKjQM69xz2r0UxhLvQXlnXSMl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555036; c=relaxed/simple;
	bh=JUqEZ7X7BpbWXCQVNijkh8zldU565fRMhL/0n8wvdFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/vjh6R9btu1Mabh723d6/FDLuSJdUppvqMoECB35/fOETss/ClO8rWPc0tN1ANTbTqOjazSXF48+sVyA8KYuF5lESMiD/2wnm7CoohnNqRfmraf3tXK/OBXw7BsK0avY19pAvejIVAt1Q3wFHCJRGEFG1zYRBXb3bwMm7ykrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6nivYvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C88AC2BCB1;
	Tue,  3 Mar 2026 16:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772555035;
	bh=JUqEZ7X7BpbWXCQVNijkh8zldU565fRMhL/0n8wvdFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6nivYvPTuoqvQRTLxH38h8Hc2HgJSOwM0xzLlRMppl/ePE6n+v4PlwVrUHnO+5hI
	 JXkH3ZnDnzKcOSKks6k80rg2qXNpBaGMCUsK+pk7Nibm/VQIJju/U6teoaijErWcyI
	 RCjyYBtgsqfm3ki41qaCFUuCqR2Mv+3Vap13A3x5Nh1UG/Fm8KjKK1NPJXbKKSL5NT
	 n4Moa4jaetRUyGLepyNbqAwXqLCUgZA1mHIwUFR7aG7ZLF2TEDXuWSULj1NmAZHpao
	 IasKGTSAelwjGErrhB31oMeG8cZ5EoUg9qldDP5ZI/m7VJUX4xPJztqKN/uqDvMneH
	 mg0s0qi4jnvxw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/5] nfc: digital: free skb on digital_in_send error paths
Date: Tue,  3 Mar 2026 08:23:42 -0800
Message-ID: <20260303162346.2071888-3-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303162346.2071888-1-kuba@kernel.org>
References: <20260303162346.2071888-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80F1F1F3E30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263311-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

digital_in_send() takes ownership of the skb passed by the caller
(nfc_data_exchange), make sure it's freed on all error paths.

Found looking around the real driver for similar bugs to the one
just fixed in nci.

Fixes: 7d0911c02fa2 ("NFC: digital: Add NFC-DEP Initiator-side send/receive support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/nfc/digital_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index 3670bb33732e..7cb1e6aaae90 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -707,8 +707,10 @@ static int digital_in_send(struct nfc_dev *nfc_dev, struct nfc_target *target,
 	int rc;
 
 	data_exch = kzalloc_obj(*data_exch);
-	if (!data_exch)
+	if (!data_exch) {
+		kfree_skb(skb);
 		return -ENOMEM;
+	}
 
 	data_exch->cb = cb;
 	data_exch->cb_context = cb_context;
@@ -731,8 +733,10 @@ static int digital_in_send(struct nfc_dev *nfc_dev, struct nfc_target *target,
 				 data_exch);
 
 exit:
-	if (rc)
+	if (rc) {
+		kfree_skb(skb);
 		kfree(data_exch);
+	}
 
 	return rc;
 }
-- 
2.53.0


