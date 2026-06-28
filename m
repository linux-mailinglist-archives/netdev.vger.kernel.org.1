Return-Path: <netdev+bounces-302420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jWc6HwaWQWqKsQkAu9opvQ
	(envelope-from <netdev+bounces-302420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:45:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C914A6D5064
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:45:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XKqsUip1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302420-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2ACD300F506
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423CB3B8D4A;
	Sun, 28 Jun 2026 21:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02783587A1
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 21:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683134; cv=none; b=kypexy6xANcpUSbL+VQEX0gs1GL1dPYviLLobvLv0M94qa0wu2g/S3nPlw2mz4TE9FKi9laRz62iHU2ymNUE2xRtVB87dS1D6BSCDg+wXyQQbhvX5KrxzhrXeEifNA4151zeWouvatNio2sKSzk/3EEml+O8qhDjF7mD/+wzLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683134; c=relaxed/simple;
	bh=4qFHrJ8TjRhzwg9eX6E4uCk78ScEs4rJofH5o2OZmu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+A5OL6hfg9dWHgDQ/x2+zXTTC8qVzHWAM1u5UDev4SKeYO2l9Bbm08Gzl31elj1p3quywDogdHhOYaNHRKZ7OgP9mgFOoGMoUOjtsFI30y9phH2bWMGFAEg+U5/knKxX6rZAsGAh+V473m37oe5X8gAyxojpXgvZ5Qh9FH3E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKqsUip1; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c7cfa17fedso22967055ad.3
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782683132; x=1783287932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=XKqsUip1DJ3JQySetJNaxJ4jizXOX99VIMVrzuKdBMyJTRmG+Mjc73hlI1VT52wyaF
         GhW2sSvP7DkdOfyMo4sCpHgZeCJt1PL3y3/uK/ICDk1/s8cAJ/wARjVu6yzQAhLAylmz
         3FLkQM/2mr9s6agkOUPCohyayxunWKm+itDMFJUa4f5MVTJpY62wXPaxbEOnDa0E+rk3
         oJRpLeYmsBNupvzw0lSIcoD2ThLxm3lDzam/lyDpYERZWxwH87U2Tuurjq3nbRADauoQ
         g0yF9j+0k7KlAWGNMDr41on9qEU4YOmdMCeHsboqjfy8cSC/9HZDE67CbPPYd+Tkgtu7
         MAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683132; x=1783287932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xJeWro39OB82LbHgE7JTjiXJkNJO0xjWGuLEsvgMVw=;
        b=kDAy97v2uSY+LFnQNz+tbYjAXkxhaIGtZV6qHM6oIXnwi545DkDjMF3fAt8xY1xf3k
         lixbMEiB3DA9JHEapdW8Rx9sOC4zSka+zwm4cRNQ/YOvQHCioLqq0bQlEV9uuyC/wUvR
         zjlWEzAlN8C9rq2MUgdnsx3uKUUG1a1vptKzYU+o7qZO/9081/IlxYX6/GVzjrH413KR
         K9fUMj2TJjfww3/ACUCFj5R6krlXC3DuX5JThQP3dNRlhCpAPVScsjMU3ZWe3L3Y3P7m
         Cn748h0GWatx3LAa8QoydeHH4AwaaTWIbIBqLITQHS9NRCt1Awwpv7/aMSxwvOXzxDAN
         7Z0w==
X-Gm-Message-State: AOJu0Yyssu3B5watzumVv8T65LGxyDxMd6/19Cd7d+wR8thmC3dgva6Z
	j3UxohJ/2XZ575jPUATR5/RBWnZaCwQ6LfuUxviIli7HHF3czKdst0cG
X-Gm-Gg: AfdE7ck3mIoIAMuP5R4KCKDnA61LZgFwi7BQAvEsAdPEcjYWdxXc0Gd5T5wYt9NHtix
	UROcL+vgA3ycoxeh2TXeaowlqOocYzT3Tr6C+6wdW8oQuW4xFqdswnqLEdCQmseHE1oIZl/t1ni
	gjb9VQkwbVfm8pWWbUR3SSwo4ADcadvuaE9j9R0CtSGNRnLaIOMXnrTSbGKEhJrL6/aqHJc6ZjG
	XNv//gnQVv862sm+J6Qo/tfnSa8+9cXJuvqfwd50TVlRYKIyVFKBXpAeOvyDtod5aQE+Npj6FUT
	/FMl2iUXD318vRjCnxYOqyFO3fIkk5sf55PnN5oGQ5vPHQJb9DToSURZdlA2FtD4WPPWC4iK7Pe
	+/bD6lmNFJ89+80q1Q/98ZoYkKHyaVQyp4PdSDY/fftWEGPMy3ARC053PB1TS8ZIIwHD2Q5FQA8
	14BzdIbw1ZhuLKv55+IqAX8jdI4TAMLpAoh7gh4Ey27zUArkzDkLexIIzJwk3T
X-Received: by 2002:a05:6a21:6f8b:b0:3b4:b276:3650 with SMTP id adf61e73a8af0-3bd4b15313bmr13996540637.26.1782683132169;
        Sun, 28 Jun 2026 14:45:32 -0700 (PDT)
Received: from node ([149.40.62.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bcc91f6dsm6572185a12.27.2026.06.28.14.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:45:31 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net v2] nfc: nci: fix use of uninitialized memory in NFC-DEP general bytes
Date: Mon, 29 Jun 2026 02:45:13 +0500
Message-ID: <20260628214513.134855-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628211627.131617-1-meatuni001@gmail.com>
References: <20260628211627.131617-1-meatuni001@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302420-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:meatuni001@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C914A6D5064

nci_store_general_bytes_nfc_dep() derives the length of the NFC-DEP
general bytes by subtracting the fixed general-bytes offset from the ATR
length:

  atr_res_len - NFC_ATR_RES_GT_OFFSET   (poll, offset 15)
  atr_req_len - NFC_ATR_REQ_GT_OFFSET   (listen, offset 14)

It never checks that the ATR is at least that long.  When a
RF_INTF_ACTIVATED_NTF reports an ATR shorter than the offset the
subtraction is negative; because min_t() casts its arguments to __u8 the
negative value becomes large and is then capped at
NFC_ATR_RES_GB_MAXSIZE / NFC_ATR_REQ_GB_MAXSIZE.  remote_gb_len is thus
set to up to 47/48 even though only atr_res_len/atr_req_len bytes of the
on-stack atr_res/atr_req buffer were copied from the packet, and the
following memcpy() reads the uninitialized remainder into
ndev->remote_gb.

Zero remote_gb_len and skip storing the general bytes when the ATR is
shorter than the general-bytes offset, so that a stale remote_gb_len
from a previous activation does not survive into the new session.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/nfc/nci/ntf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 802928ca4d51e..b72545daa2051 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -654,8 +654,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
 		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
-		    NFC_ATR_RES_GT_OFFSET)
+		    NFC_ATR_RES_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -669,8 +671,10 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
-		    NFC_ATR_REQ_GT_OFFSET)
+		    NFC_ATR_REQ_GT_OFFSET) {
+			ndev->remote_gb_len = 0;
 			break;
+		}
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.54.0


