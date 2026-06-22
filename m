Return-Path: <netdev+bounces-301124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCPUKhg2OWprogcAu9opvQ
	(envelope-from <netdev+bounces-301124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:18:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 220AD6AFBCA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 15:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T29KCQpC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301124-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301124-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 249FB30080BD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEAA3B27F6;
	Mon, 22 Jun 2026 13:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2F35028D
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134292; cv=none; b=nV7FdW13iq1sdkbIMsmtwsU5i7TD1uFqHyhux2aF+I2M3aQOZDdxpFsfeGdbAdYkLJsVHeFQwok6gV7K0NQH4RJutupBF5CqMC5UJYrOA2Xo1e685RcxvxmY+G/5GDJ7AEEMREf/L30qqSIbB61eiqIkWf7ZM9d2hjH3FPWtCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134292; c=relaxed/simple;
	bh=yyw0nMtUQFYySF+Vo3tr4O3uzZRBP38LtrsViqoS/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=becMBH6Sozlb5MnBTo2fsiXyKaB9q2b/RKu0EsssRSKIVsEhprDHDMH0v3EDhxVClKzCwGClyIq0L/W5R26BknK2NX/Ym8KIroZx5YxMQpKewDFryeV0HLTsU/ZMFtzKahkD86oo74/+e2zRXfpQLKFCaSXjLteCOZSIRybx13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T29KCQpC; arc=none smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so6035232a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782134290; x=1782739090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64GS0cV1F3q6Azsz5ClQ2jQ7hHXoaFyqY/ADvWBZ5O8=;
        b=T29KCQpC83FMWIUMXtVjT7ip3KbjcDOwIVyOIrMEOwMoPZt2iD38tI9zYhfnNFrKcN
         els/EjHrO9ufU+9dzWhXbvNB/CeuNmmjVzqeL8mWc5rC7cMoL1zQB+tYZmJhzkcQgxGn
         jdH8hO/8OQO7/FzJV4rV2ySzHhDXUGQ8TQJz5LHgY85yNUNq8UjJsEUnEi5WUMMf3WZs
         WZXFFjzW9fZaKi3Nu4OfejxoV/d0aO4dHwvRskXEx5Z3Ca+lIhLIF9AQtDhXedSk3h2k
         9DJVJPbnUxdwUUxjPlgR62k04mHHegXtLpIwqlu7srNmfVudDCzj+SPXzH8bec3NrDUP
         g/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134290; x=1782739090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64GS0cV1F3q6Azsz5ClQ2jQ7hHXoaFyqY/ADvWBZ5O8=;
        b=pouOIbscyVCNyUyVVQGjsvKen2Ck/F6NgpBqveVyN3q0iqkMTySdbectMKMNvrSjUb
         g7gtG5lrKKy9nuTZKykkrUWoB+cjbp5ANbqrNxo2fvS0KtkhI1xCqTBOdgrR4V0zaP8E
         LqaeXs2C7v29ho8xHUfccOq6I5aHf6IYL67TH7SqrM5hGWrAkPsa0gk2wGsLSQ2yfvGf
         5iq8NoDleeF+BJMOYSKQOIjOiL3bDFB1dwTvyaWJxwjRuWuMmPhWWdBvrKMioBluS9FW
         V/r3F/mQBwwnGspghdKKQlZ1p8uE/czmMej8NfrR1mbOa2rKK53X7DJ/3S3VF8MAv3f4
         XxYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cpJJAvkql7+gkeaPQIECWv5VcLY3XOY1wriFxCanHf4INgVArd5yr2m3wAtA/JMPvgHhZL74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKtJXnoWnXBrAm1mRUwgQ/zad6ufksnXdgJgyUUfFCr1sJxi9
	N2oUXnZQBwoRE1YBXjUQGgR4nOse6OtCoYcSDGCtgo9QXZqZnu88PSvG
X-Gm-Gg: AfdE7cnn3BW5kBKCzSmTAHNsuHgVKBhlR8kL52Lz+S71p3op60XBZPcQCOREiqTN3jS
	+80EGF7qq5omMSlYpRNXrwKwtnixwoRjOGVtvZddyum1IOf2eQRfHUs+N2acsXvfgxR64wyGKqs
	Sc+9b7EC65bROXPEt9iny72Ze62gMioVr065tK0Be8joQjwI9+ZWPKsYcgfHXMBaa0N8Xcj/H/c
	UZ3CBtvXNp8ceDqcg51fg7FIra1h6Pl6KJ507szPTNnmVhuAtv8GS7KiSNo41IoNfiU6cLCXpL+
	No/Tqg1n4E4iEi10bH5OzVXy1oHS3eOc2r8yXod1o5N3to8TrNi1AHoj9lW6VWUwOnkcuJd9rNd
	+jz0XmOaxtZIOivuUntQQh+sgqXWMYQ2s2Gf9j5EHgh/AKOowKOuSGiAcQwlrmX65b3yDWT7K0O
	738bweoXQ1s/2P94luomJ0wJwosErAypkxhs1uisePvO2djCidqlv232Gwa3c=
X-Received: by 2002:a17:907:3e9a:b0:c0f:cbe8:7830 with SMTP id a640c23a62f3a-c0fcbe8976dmr71683266b.38.1782134288453;
        Mon, 22 Jun 2026 06:18:08 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99b968sm356605966b.24.2026.06.22.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:18:07 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	krzk@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] nfc: llcp: fix OOB read and u8 offset wrap in TLV parsers
Date: Mon, 22 Jun 2026 18:18:02 +0500
Message-ID: <20260622131802.239035-1-meatuni001@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-301124-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:krzk@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:meatuni001@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 220AD6AFBCA

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() contain
three related bugs in their TLV parsing loops:

1. 'offset' is declared u8 but tlv_array_len is u16. When TLV data
   advances offset past 255 it silently wraps to zero, causing
   infinite loops or double-processing of buffer data.

2. Before reading tlv[0] (type) and tlv[1] (length) there is no
   check that offset+2 <= tlv_array_len. A truncated TLV causes
   an OOB read of one byte past the buffer end.

3. After reading the length field, the value bytes are accessed
   without checking offset+2+length <= tlv_array_len. A crafted
   length=0xFF on a short buffer causes up to 255 bytes of OOB
   read past the buffer end.

Both functions are reachable without authentication via
nfc_llcp_set_remote_gb() which feeds remote LLCP general bytes
directly into nfc_llcp_parse_gb_tlv() with no additional
validation.

Fix all three issues by widening offset from u8 to u16 and adding
bounds checks for both the TLV header and value field before each
access.

Fixes: 3df40eb3a2ea ("nfc: constify several pointers to u8, char and sk_buff")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---

Notes:
    v2:
     - Rebased onto current nfc/for-next.
     - Dropped the previous nfc_llcp_recv_snl() fix since equivalent checks
       were merged by commit ed85d4cbbfaa ("nfc: llcp: bound SNL TLV parsing
       to the skb and add length checks").
     - Retain only the fixes for u8 offset wraparound and missing TLV bounds
       checks in nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv().
     - Reject invalid TLVs silently with -EINVAL; dropped the v1 pr_err()
       logging, which was reachable from a remote peer.
    
    Link: https://lore.kernel.org/netdev/20260519011937.12903-1-meatuni001@gmail.com/

 net/nfc/llcp_commands.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3a..ca89fe967d6a2 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,15 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +250,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +259,15 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {

base-commit: ed85d4cbbfaa4e630c5aa0d607348b42620d976b
-- 
2.54.0


