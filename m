Return-Path: <netdev+bounces-306226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rr7pEBKfT2rXlAIAu9opvQ
	(envelope-from <netdev+bounces-306226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:16:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E773179E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:16:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=0HUpb3ZZ;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306226-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306226-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF66304BBC0
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F72727E2;
	Thu,  9 Jul 2026 13:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8F1AA780
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:12:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602755; cv=none; b=IudUYEWLcUBvEjvWZ8a88ttR3gQwePDHyyNGnpn7OlW6ff3LmMRHFrSKtOThVN3wgYDFQ0PqJgBsIenDXNO+5unRig4mIDDqBVYs3PihZVD4Eip0ugBU/RXrCk0Q+o1ACvYR7piiOSGPhXlDB9vOau3cvXSX/UMkGVbTdLiNSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602755; c=relaxed/simple;
	bh=iAyyFv/AQxA40DSCOj6cGXn3go3IfDOrY7GY4Sy9UyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPUpT8+2qgOq3dQ/LzGuc0daD9kijNOnXy4uXiTwZWZQ8YFsQp8bnIPcsYqpYOEXKBKYxYZJpT5ZHqOxtG6CB6piYLIRup57oFHkIhD2+HiOxdzSRQifQqNNJ5R9DAp5iHkVZUX6Qtn6dcdphIUbEVvyTCldKw/Ba+1QaYjOLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=0HUpb3ZZ; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1714620f8f.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783602752; x=1784207552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9Bxn/o6bHrATO0mn2uaPiWaqZWNuvOxb6ptBdz4eyg=;
        b=0HUpb3ZZrqe6jNid3T41CKaPgavGJH2XFVDZpU4OlrkemmGqXwgJg3skM+++7PbJoz
         lM/OTM5QiCBi7AkhWrErNjiarEbpLIoOl2TPEoy+r24R7peg4IVt39gNKvrY1i/fUO2s
         zHYhmDod8lllMEPZp7x+E9/yUUr7CqutmJtEW7PzEQejJcDiSDtm/cvnwv2I4B7hSiHw
         Dj1uGvCdOEqlEdcJnMDrHkyPUE1QXT24Ep8GvRUkfBlhVqoqH3EjJYF/b/ZDGK1FBv2U
         WQnUgusisLYMbaAqYvcFqtjMnZNp8v0G8nSsm2p8ZkIApxVhGnDmNg6/ytZN1XQeXVNn
         oUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602752; x=1784207552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9Bxn/o6bHrATO0mn2uaPiWaqZWNuvOxb6ptBdz4eyg=;
        b=MGqSgYfON5+gcuyi3VlQogRVYd2+OcAtewzPr6JnK539sH9RkD6VMJID8HCR9PxqPw
         MBVZGTJLrLfdILuh4WULFn9lgESsO5u4BBNwa6emQvYie0QoafexJGcozfcZYLtfkQW8
         +eU68WbkioTqmzm0FKciAW5VEQm4fRUKvzuhlzoUCjbW1DpFDdeqx5KLMQjGoVzK2u+e
         Bvq9jpIkctnKLB1pBA+KRvYTnW2daiqC1U+7pdH7j4BJ6fTFi8PivwPlX6fx4f6VCX3T
         M52Ia9XuF3OTaeJ1qDYnz9uqST3J01VlZb0Bte2I7GKjVtOxcTjleAmyRZTHStuWFBXX
         ROww==
X-Forwarded-Encrypted: i=1; AHgh+RqSoVaXI1fgD/YVlAPjpP0Csxn83rkQa8ScBZYrhtbIdTTrVNph6DJ7fHSlzQpfPEPsxq50Ew0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3b9RxBdvPo453x8Xuf2L5N/LibEoSzcm7/MRJFvy24quSO+t
	VDO0KjWqpQL5filvNHPycjODZ6WMUltNUhZ70VYGfI5DewH1Idhz8a5ATq6ZwIo2iaQc
X-Gm-Gg: AfdE7cmJNAze6BP3pIST5jBLKTtSHbJnaYnfG3d0KdSyFH6yFZgth6yxFQCTM+MxLrD
	ZY+1/3pccMChrIQwHzxZibBxDmN0d3xnei1jpKi+JAob0xgEH4zAFAe85qDf03L93GSk05qgqoR
	/UycgPClG+VuwJBoeqfs1fZyRy/qjY17OM3GSTXiEkrWU/XtbrsVFx69BNvKhVnwdkt/PUScORe
	FP529//M4zjI7uVYWgI3Gt32dh+sm+bBJRLyPWL3knorIXY0VU406lS00cH/ICRHZMf+/5uij+J
	eFn3+jc5QYkbWT7pMoYxKwviEz+H88NkM880YB+C8Ok1PY5qy5I8jJCJckqk+SwRqORBGMTM8EG
	7Rddu7AZejOTKSU4fcjqT1vBlTpVnRYayv3amlVJwhA6+1PKDrVIuQzy90GwzLLhUM3B2GdYOAp
	qpS6M8jZ160+72xZKr5HzjhUeBO1PdJ8z2TYuB57O4p2sb7EkUbMDpYS5YFvoQD4dvBhdG7BAmy
	cJuNrJQ6GlO5O7o7PUxa3o856s43+9yw2w=
X-Received: by 2002:a05:6000:290b:b0:476:e67a:dfa7 with SMTP id ffacd0b85a97d-47df073b100mr7611503f8f.7.1783602751497;
        Thu, 09 Jul 2026 06:12:31 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6da9sm50439168f8f.12.2026.07.09.06.12.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 06:12:31 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: david@ixit.cz,
	oe-linux-nfc@lists.linux.dev
Cc: horms@kernel.org,
	david.laight.linux@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v2] nfc: llcp: bound the connect_sn TLV walk to the skb
Date: Thu,  9 Jul 2026 15:12:29 +0200
Message-ID: <20260709131229.44477-1-doruk@0sec.ai>
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
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306226-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:horms@kernel.org,m:david.laight.linux@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:doruk@0sec.ai,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:dkim,0sec.ai:mid,0sec.ai:from_mime,0sec.ai:url,0sec.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F7E773179E

Commit 27256cdb290e ("nfc: llcp: bound SNL TLV parsing to the skb and
add length checks") fixed the unbounded TLV walk in nfc_llcp_recv_snl(),
and commit d8bd2dedbde5 ("nfc: llcp: fix OOB read and u8 offset wrap in
TLV parsers") subsequently bounded nfc_llcp_parse_gb_tlv() and
nfc_llcp_parse_connection_tlv(). One sibling parser sharing the same
pattern remains unbounded: nfc_llcp_connect_sn().

nfc_llcp_connect_sn() walks a TLV list, reading a two-byte header
(type, length) followed by length bytes of value, without checking that
the two header bytes or the declared length stay within the buffer. It
returns a pointer to a service name of up to 255 bytes that may point
past the end of the skb; it is subsequently consumed by memcmp() in
nfc_llcp_sock_from_sn(). In addition tlv_array_len was computed as
"skb->len - LLCP_HEADER_SIZE" in size_t, so a CONNECT/CC frame shorter
than the LLCP header underflows to a huge length and the walk runs far
past the buffer.

nfc_llcp_connect_sn() is reachable from nfc_llcp_recv_connect() and
nfc_llcp_recv_cc(), i.e. from received CONNECT and CC PDUs. A nearby
NFC device can reach this without authentication; LLCP link activation
happens automatically after NFC-DEP, and the nfc_llcp_rx_skb()
dispatcher applies no minimum-length guard.

Walk the TLV list by pointer, bounded by skb_tail_pointer(skb), and
validate each declared length before use, matching the approach already
used for nfc_llcp_recv_snl(). Starting the walk at
&skb->data[LLCP_HEADER_SIZE] against the tail pointer also removes the
size_t underflow for short frames.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v2: drop the nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv()
    hunks - fixed independently by d8bd2dedbde5. This resend covers only
    the still-unbounded nfc_llcp_connect_sn().
v1: https://lore.kernel.org/netdev/20260705113505 net/nfc/llcp_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index aed5fe1afef0..0de20279e046 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -849,13 +849,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
+	const u8 *tlv_end = skb_tail_pointer(skb);
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		if (type == LLCP_TLV_SN) {
@@ -863,7 +866,6 @@ static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 			return &tlv[2];
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
-- 
2.43.0


