Return-Path: <netdev+bounces-306640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5xFjJDAyUWqMAgMAu9opvQ
	(envelope-from <netdev+bounces-306640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:56:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83873D228
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:55:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hpOp5hP6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306640-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306640-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3A930086DE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12C37756C;
	Fri, 10 Jul 2026 17:55:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D23749E5
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:55:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706115; cv=none; b=juTiqVYVjkiO7z+wTGIMUTvS7pJMOI9qK7D1z20vUQ6y5pjQYCFg+IgssEbUA+q0doCNnwEbV3cFzGI2wXk3di9KDhrsHoFZMb2MJdtpbqKrSTYsSvNIL4O1EH2TbYLfFcjijrGjAlpFsISP5QXiy72PgOfPXZPmD/J+QBrHnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706115; c=relaxed/simple;
	bh=q2Pq9v5SXGlcc93M8LKL/aV+CQ++fQMQq3HsJTaHEFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMEz0cjctcQ45v7eHvPhX/QVbShMT7MaMbg6mSHAJNVyGfXnt4xjlrBvpLMJq+8NmhaYThGUIyHJiHYCMir5Rm0tm5iaou0RVvlXwZKjXndRrjxOExLIMLLFZoYmuuRImpOY2N96+BDLF+JwZZSDh0mebTZ6j3g37t+yL8SWC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpOp5hP6; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so1757665a91.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706113; x=1784310913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/g6IlAQtSI8doB/Bb8hhgXDYZeL8IDA7KJYnBAyAHU=;
        b=hpOp5hP6cRBd/LrQW2ksjdFVGQIfhOjdMt+y6NmfUg0B/EBx5pwnC2uoyBKs53pQbz
         +amXLV3QniFfNgIhrkeSg31DxJThsJil8et3b6DXhauIfQk+lTZ241ksfblHrW7UZoQV
         MCB2wuVyhYFANZxphVifp1GSgnYo8dQ6M6TizkX2sv6/datbAaUXmuw+imE0B7NZURiW
         9SD22DklogXVZhN2gXoMldlX0Au+IOUXzk9nitBCJSDL8b6fS8fF/667o3DtFJWGjEwh
         seXjczxvU09ecYAx4n1E+hUOAJfidO2OMPphrGxvj81gsbM4jGixs0UpwcZnknxl3Zda
         NAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706113; x=1784310913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/g6IlAQtSI8doB/Bb8hhgXDYZeL8IDA7KJYnBAyAHU=;
        b=OYQWY4WVRefs5mF0pzYBhYdtQdRsRImbi3Pl7FDFVrTYbouBmrRm8QhvD12eq6ggqP
         20xUCvjND7a3RnDl5mTm/GmjXaUxLcbduc3ozE7EwAuwjNi5dUYXbrPjKhGbogniapDP
         owXS39hNmwyx65wR2wdWYky84Z5cR3kbUEXOsTn9qbXTZq1EjBNieH/mJ2itsv/TLTFd
         6INdtMheYwrzPgT/pqRRcyGx7uiICqHQqSra+xj3qX7LkzrvUeYJ1amfa3wooNB6W/GK
         dzh6+e2mj4wKlnA88vnrh0JSZqh9ujQvoliU7bekqS0z5sWFZWprdJHCk7oYhplEQOGx
         BHlA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+KcbsuZjAVYhyglV+mDNpJo2jZT2I4z7zWRe2pT8JxR0fy6fBAMf2mu8MHOehtdn9NCiyx90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNRl1NtwGEQ+xmv6dU3feJ2qORCy9RW42rkB4P9MmYjziI3SN
	4slddFCwu8cYGfTb7iNVmTZ5gRGMG6Y88NjsdKVJCFebIIN9IxvbuYCo
X-Gm-Gg: AfdE7ck2zDPFdf4S1gQdvEry5vsTFEb0m3nm478+KCsgw+sjYa04uTJeaehVc7YVY0w
	BRzpKQVycNdWrw3Yt7pdZmsURZvaWP32P1e60oOjOH3xY2G8gaWZe8dkrjziSSQUnXhJUGciNRy
	JSs8FFG64IhSoTFy2723fA3szcrWGVlgXnAPjXnNIPF5+mGXyAJUE0rF+C0Grh0D8e9iZ18YuUI
	ul9TyLK0gZLkU68YzX9eBlCno2U4ZCxAPPVuksw3WtCgc1VKgXoaGC+ouI/A1253wYpf77IsYlP
	i/GfkzZnBPjL87mzm0ZpCoWXv09B8w9+UpVM+uqku3vZuOi632rQH+zGTIer6J1XoC7TuYnIfyb
	wWKURh8aGpIXW96jZuDFPzQDJRVb2bouBpnnVmcvBaiTqnBYerG3jFGgazOl0Av9DN3yD1Nk3AZ
	pqiyXOx+P+vMbN/Tt1jXt0LuZJIZnW+VkTYyBSVLhYswYZ8GpaKrIR1z1/RQXyqqXQoStH
X-Received: by 2002:a17:90b:2401:b0:38d:9eda:fa04 with SMTP id 98e67ed59e1d1-38d9edafc8emr2029326a91.2.1783706113230;
        Fri, 10 Jul 2026 10:55:13 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm43051871eec.2.2026.07.10.10.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:55:12 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] nfc: llcp: validate TLV length before parsing to fix OOB read
Date: Fri, 10 Jul 2026 10:55:01 -0700
Message-ID: <20260710175500.2068564-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306640-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB83873D228

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() iterate over
a TLV array supplied by the remote peer. Each iteration reads the type
and length from tlv[0]/tlv[1] and then advances by length + 2, but the
loop only tests offset < tlv_array_len and never checks that the 2-byte
header fits in the remaining space. A truncated trailing entry is enough
to read past the buffer on the tlv[1] access.

The length byte then makes it worse. offset is a u8, so length + 2 wraps
at 256: length == 0xff advances by 0x101 and leaves offset unchanged, so
the loop stays live while tlv keeps moving forward. The parse walks well
past the buffer, and the next iteration's tlv[0]/tlv[1] read lands out of
bounds rather than the walk stopping one entry over.

nfc_llcp_parse_gb_tlv() runs on the general bytes of an activated
NFC-DEP link. An RF_INTF_ACTIVATED_NTF in listen mode reaches it via
nci_ntf_packet() -> nfc_tm_activated() -> nfc_llcp_set_remote_gb(), which
copies the peer's general bytes into the 48-byte remote_gb[] field of the
heap-allocated struct nfc_llcp_local; the wrapped walk runs off the end
of that allocation. nfc_llcp_parse_connection_tlv() is reached the same
way from CONNECT/CC PDUs, over tlv data taken from the received skb.

Bound each iteration to tlv_array_len before touching the header, and
widen offset to u16 so the advance can no longer wrap. Well-formed TLVs
are parsed as before; a malformed trailing entry ends the loop.

 BUG: KASAN: slab-out-of-bounds in nfc_llcp_parse_gb_tlv (net/nfc/llcp_commands.c:204)
 Read of size 1 by task kworker/u8:3
  nfc_llcp_parse_gb_tlv (net/nfc/llcp_commands.c:204)
  nfc_llcp_set_remote_gb (net/nfc/llcp_core.c:681)
  nfc_tm_activated (net/nfc/core.c:643 net/nfc/core.c:677)
  nci_ntf_packet (net/nfc/nci/ntf.c:883 net/nfc/nci/ntf.c:1015)
  nci_rx_work (net/nfc/nci/core.c:1564)

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/nfc/llcp_commands.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3..3f0f8eef9890 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,17 +193,21 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
 	if (local == NULL)
 		return -ENODEV;
 
-	while (offset < tlv_array_len) {
+	while (offset + 2 <= tlv_array_len) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,17 +247,21 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
 	if (sock == NULL)
 		return -ENOTCONN;
 
-	while (offset < tlv_array_len) {
+	while (offset + 2 <= tlv_array_len) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
-- 
2.43.0


