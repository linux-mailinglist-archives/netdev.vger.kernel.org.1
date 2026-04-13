Return-Path: <netdev+bounces-278005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qErKGhux3GmbVQkAu9opvQ
	(envelope-from <netdev+bounces-278005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:02:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 089523E97C5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73A1F30054C7
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 09:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74853A6EF4;
	Mon, 13 Apr 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr6C7//b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBD35957
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070935; cv=none; b=JjRookxJ5+G2TJ+/14RUELwwTtADqKBgLNOZUEWRvgafYdWBL9pu/y9Z8hIiHl9ZZ9OqpNTllykI1AgaWHVGgJ92TCi0GbsZ/AmzOoDq2ZPlyLSfXL4hZ9Du8ZAnOLAbEP16eIWnGlKdqDVhQ3sS/i6VzBB3eCf3VnVhKyG7eXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070935; c=relaxed/simple;
	bh=HPswQnu4UNQvfw10+Mv2SgFnHJmrzuRgHNkwcK3ZDYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JsCIePVpcrE+JPwQovPtxIbFKN0WKx0O8EGSW/G0tp/yyYU3ohIltqo0sFJP/R5FQEtoslqwVjKW/dbyjIfZh0PfV7hkvJzthWD0RDhwkS700TEzQXNIJMnxxrdzgoM72mqk7e57sX1JVg6eQ7iviupaJADiBQLCLSLLru2CAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr6C7//b; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1506885a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776070934; x=1776675734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2aDHCgi8Fr4HQhME9YWUIrpTtTq4Whrfwv1NSz+VoY=;
        b=Wr6C7//bjyhDt/PkNEhhADSW6lPhjmqWMUDSzXg2yC4BXllO7RatzonF0lc7OV2UxK
         UQBV2xNy5nzbK8I9efYVlDkEQCeyKpgfhTH+4Vk0qxRlGoF9l94zl7TVhuE9zH6HKs9z
         ZggFqo/ykUVUZa/HefAus899KPZYN9bjM4SpMqpTigFL5GVWVZijxXARGbSdNw24NbhG
         odT6yWBlT0dzAThlKA6ur4H/pGFvqtDCtjAiLu7y7aMFgr6Rdw/xe1Pr2/Yb29krLPXl
         3kF9oPwW+HklVXqsYqapItBSDJSp95lidEp7w0o8I8kT87qmOe04ftWmBQbeXOuCgESx
         aFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070934; x=1776675734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2aDHCgi8Fr4HQhME9YWUIrpTtTq4Whrfwv1NSz+VoY=;
        b=cAcjLArddaZYINXBCmQX9xmfcvoO54gNkO+b5Y/IGO1ibtXtQ1wladMW+ZbK0LpDNJ
         C/8XkgjWpTXUoET+CGHUYlraxi4b3fP9D+ubd33HWOxV+okBUNMQ2n40us+dUXKts1VA
         QfAVBsQdVyddUv4y76FO2tXWG/dt6Vf7KOt+Wk8gQg18x6+aTaqfHf+8ujFRK4sCOwAy
         BNBqz5UaXCre9bIcwe6KJxlAflYs8au8DEbFE5+1jAX8RdE/BSp1G1fX2D0oKQQamEXE
         +QL7QHF+u2fJIjeXgpOuc9HobxRvwTU42hz2uuTcQ9KMu6BQopK/0j+AEcmOIciH8ii1
         g6Jg==
X-Gm-Message-State: AOJu0YxzguWT2wKeAoCsdSADUcFp+LNsxG4c9+2Eb0IrPQWFIg/+fT4n
	TrDdoFj6FAH2Py5H87kA1YNqthca1Gt3VewTUleNMmXuisz6IJJD47eVFyAIFw==
X-Gm-Gg: AeBDietkCqO4VVCEgfAwTJNzCJcZFNXqkt2E32AnDGvLxfxjfMWZXZkNPrdAOwMgu/k
	ENbrJ//YF0gLZAOHPhSjxukTuRzP5a8r+1BZf59mooGMXRXyKp9aJ30W14ztrMPgqbfUzAanGig
	1C6HbHZ8J7eoEbjAtRds0mUDVlm3HeDIeD2SmPb9W0IkzYztfIuJRApPPjs5X5dLpQU8qbk+VRy
	aDyOZjBkqAwupAqgPRWDLRx7zBww8dRPAuvNkVsui/lzaUjM3h5jtki/ZS6Q06q5/zzRt4043hT
	IiSZFSOD7ldIMQ0UoCqYTxeHw8Ns1JuKf7VWCWfE83U0cioU93sWOYeNKsR4a+3zojKXqHUsfTt
	WqfzKX/2DO2Ram5L88ty6BdApzDcgx5Fa8H7MohDazW+a0Dho2BvSC04zKAgGtyqbafNCy7w/CN
	0lkLB5Wge5ck709uv3G+Psmkho4YRMsnjuHea76sfV3yPCIT1ziw1fJL1FxvOs8OeN
X-Received: by 2002:a17:903:3dcc:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2b2d57d7dadmr83790285ad.0.1776070933500;
        Mon, 13 Apr 2026 02:02:13 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3afebsm108369605ad.72.2026.04.13.02.02.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 02:02:12 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] nfc: llcp: Fix TLV parsing off-by-one in LLCP connect and SNL
Date: Mon, 13 Apr 2026 17:02:08 +0800
Message-Id: <20260413090208.78649-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 089523E97C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TLV parsing loops in nfc_llcp_connect_sn() and
nfc_llcp_recv_snl() check `offset < tlv_array_len` before accessing
both tlv[0] (type) and tlv[1] (length). When exactly one byte remains
(offset == tlv_array_len - 1), the access to tlv[1] reads one byte
beyond the skb data buffer.

Fix both sites by changing the loop condition to
`offset + 1 < tlv_array_len`, ensuring at least 2 bytes are available
before reading the type and length fields.

Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/nfc/llcp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 366d7566308c..d1a75b9445e1 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -852,7 +852,7 @@ static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 	const u8 *tlv = &skb->data[2];
 	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
 
-	while (offset < tlv_array_len) {
+	while (offset + 1 < tlv_array_len) {
 		type = tlv[0];
 		length = tlv[1];
 
@@ -1297,7 +1297,7 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	offset = 0;
 	sdres_tlvs_len = 0;
 
-	while (offset < tlv_len) {
+	while (offset + 1 < tlv_len) {
 		type = tlv[0];
 		length = tlv[1];
 
-- 
2.39.3 (Apple Git-145)


