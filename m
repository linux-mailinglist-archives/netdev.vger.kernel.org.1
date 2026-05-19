Return-Path: <netdev+bounces-289236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBEGOWK8C2q3LgUAu9opvQ
	(envelope-from <netdev+bounces-289236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:26:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A25C5760D5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21BA308DC57
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F22D5932;
	Tue, 19 May 2026 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9ckhRst"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12382D7DF8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153789; cv=none; b=q9p69VXyUXOO9p6HSNR29tz1IkQGyWlt9PNLCTp7dg27hRZAgwjrUI4ugRtvDGp5NaZaTwixgf8tnlEmHgQczKByuI+742fvCoSp1/q3vTfSqTqhxMNGx6SWI8QfaggyyUekFNsH8lw/gG7h2h4YbUrGnfHPT90+Uit/GXdrlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153789; c=relaxed/simple;
	bh=4vi/+e3xOXjw7xLTlUAikVPvzws2OAFyV8H8dZm6ePs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHXW4rDCltIO2gc916rrzFjsu1KgL69+J89ULlaqRzr7DwNyvvO3C1cy3xtFFIBolg1nAVRRaGVOHPhf73CpU2U5NFVM+dDItnYYU2p18Uq/TUP9/l7qiiStOtpUnUCeAF/3oNrmVMJif/i+zAS1Y/KsoouV8XPisf2IXK6NtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9ckhRst; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso33157885e9.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153786; x=1779758586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T0H92Yt0pUbOJ2kFSqG2xMZBSz8hScaz9YpU8JwLL0=;
        b=p9ckhRst6+1XMFm9y23i0fqGCcPZa2CBPI+F3LOwSj3X39O4YF9hfCOVpYuc6toS9R
         HzrPtQBiVc6siUEPv+mPIJkCLO1vtMfjHvqjTW3OlO1X8k+uDfgpnq6doXqMn9zOdjQw
         hpxY+mSQT4q9T5Jc2/Fm7A+TwVBH3h2gavynDLcCbOCjMdnUt+SOR5H5o9mlPrzqR5bn
         efYvrothcrHbHhs8FdzuAs8wLka/4VaeLr5iMUPLP1eRiG2DbdvX7ii63y8HA/dJseRY
         I1IFIIQf7g9roaOD5z17tUhhQz5TnZcAtFxXLuO7ptm9bZt+OARyqbiDncqlbPmLgTNm
         Xgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153786; x=1779758586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+T0H92Yt0pUbOJ2kFSqG2xMZBSz8hScaz9YpU8JwLL0=;
        b=WZGQ/NeBskDM7Xq/+eIaCGLkQbmWqDkb7+IE/R7jdsezXEtBfB1PGglDwka9McHf47
         IN56rUn0RQZZGGeqOuRLTJgz2Ujsodv7MUueLnr1rSfggAEo9ciQupOJpfUvyBmmmn5c
         RipkWD2ZiCFdMA8w5n8UPxk+pc97deUYQqIPSGDWmfKYQiqIt3Hc/r/2ON4kJiDZBbhB
         KL2xMYmI5RIQk+S6PuBo8ak5zvo/cTXqKIjquYooKGI4FKB74icFuNYhoCukX6YqFM3h
         DML468PslGxAcQ+gA2qwqVU/v2zgXpULsaZZRv3Ss0rvEiI/tJ6klWX6s7exKygrGfPU
         USpA==
X-Gm-Message-State: AOJu0Yx8NY4E2E9QfU8Iz50/YQ6qHTY8kWeIueBMfptYhWIrE/r0E0Ja
	L08AyAA2ALh218+SqUixGS3WkAMgfU0jVeaCZHPX/DQhEDQzfnFU91MVB/8xISZZ3Qo=
X-Gm-Gg: Acq92OHyBZwn1RR+UisQqRnanUqiXU1VuTjNUYAKJOrpycG/8y4H/OkSBGQpCgW08hV
	D/eJpruXH4jxXBn+dlImbRz6zK9fsUv36H82A2qPajR3YZYOBT/9gIs4xah1lRmEppqtHKREfx2
	LFxEcmtVM7EGqecn7DbEICK40dpL46NIt5kcvZe6eZudI+p2qM6t+5PkgiUp++7twVC48S4o6O2
	sC3nv+RDI49G4MClqj3fEUob7GsI3P5aa21QVpPudnAKNRXgiKX8I3BaLjcXlZUVIY65ZsqbsLB
	Nfx2Cu8wCdclSrzCn3oI7SnGHl8vVY8ZugjSSF81brpxDDpiX3TinzvBTR5JpzoTx0en66xT9dV
	PpP8lb3gTooypKHmEbSUPDL1L/ImpvnjWvwkEpeqtFc1CUx89ZHG17J8xJX08sue4zlSk3FiT4R
	rVrF5IWP8qOwhWIkLGwFZsrkQoUNuJ+xKTsLV08hd4+MzskP7pnPAjs2mhSu+x5EcuZR/zo6ZL3
	w==
X-Received: by 2002:a05:600d:10:b0:48f:e230:2a1b with SMTP id 5b1f17b1804b1-48fe6630137mr219596215e9.30.1779153785784;
        Mon, 18 May 2026 18:23:05 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm44255416f8f.10.2026.05.18.18.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:23:05 -0700 (PDT)
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
Subject: [PATCH net 2/2] nfc: llcp: add missing bounds checks in nfc_llcp_recv_snl()
Date: Mon, 18 May 2026 21:19:37 -0400
Message-ID: <20260519011937.12903-3-meatuni001@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-289236-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 8A25C5760D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_recv_snl() processes remotely supplied SNL frames without
validating TLV buffer boundaries before accessing header and value
bytes, leading to three issues:

1. No bounds check before reading tlv[0] (type) and tlv[1] (length).
   When tlv_len - offset == 1, reading tlv[1] accesses one byte past
   the end of the skb data.

2. For LLCP_TLV_SDREQ entries, tlv[2] (tid) and tlv[3+]
   (service_name) are read without checking offset+2+length <= tlv_len,
   allowing out-of-bounds reads beyond the skb data boundary.

3. service_name_len = length - 1 with length as u8 and service_name_len
   as size_t. When length == 0, the subtraction yields SIZE_MAX on
   64-bit kernels due to integer promotion. The computed SIZE_MAX value
   is propagated into nfc_llcp_sock_from_sn() as sn_len, bypassing the
   sn_len == 0 guard and reaching subsequent comparison logic with an
   excessively large length argument.

Fix all three issues by:
  - Adding a header bounds check before reading tlv[0]/tlv[1].
  - Adding a value bounds check after reading length.
  - Rejecting SDREQ TLVs with length < 1 to prevent the SIZE_MAX
    underflow, while preserving length == 1 as a valid case.
  - Rejecting SDRES TLVs with length < 2 since both tlv[2] and
    tlv[3] are required.

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/llcp_core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a87..da7c6377d 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1300,12 +1300,28 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	sdres_tlvs_len = 0;
 
 	while (offset < tlv_len) {
-		type = tlv[0];
+		if (offset + 2 > tlv_len) {
+			pr_err("Truncated TLV header at offset %u\n", offset);
+			goto exit;
+		}
+
+		type   = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_len) {
+			pr_err("TLV length %u overflows buffer at offset %u\n",
+			       length, offset);
+			goto exit;
+		}
+
 		switch (type) {
 		case LLCP_TLV_SDREQ:
-			tid = tlv[2];
+			if (length < 1) {
+				pr_err("SDREQ TLV length %u too short\n", length);
+				goto exit;
+			}
+
+			tid          = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;
 
@@ -1369,6 +1385,9 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 
 		case LLCP_TLV_SDRES:
+			if (length < 2)
+				break;
+
 			mutex_lock(&local->sdreq_lock);
 
 			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
-- 
2.54.0


