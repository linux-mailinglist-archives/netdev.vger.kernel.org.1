Return-Path: <netdev+bounces-306752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sw05OQbtUWoyKgMAu9opvQ
	(envelope-from <netdev+bounces-306752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:13:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9AB740B24
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:13:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=TXgXK4St;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306752-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306752-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E778E3019522
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 07:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1037475C;
	Sat, 11 Jul 2026 07:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56F2D0603
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 07:13:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783753988; cv=none; b=r7AIypMvMbPuQlubsYvahFuC5kIIiOjbZg7YHpM22hFdRoeJaZXSoJjVt1ehkjY5OtkzitR7SxV9+Of9XW5iyHmzcq9EYgNajlRlQe0mgNJWnnRnFa+uYAAPl3y5nhHRm7tTmxAgoX+unGs6oFAtRVYAkdIL+dVgNoLPOplbu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783753988; c=relaxed/simple;
	bh=tteEXFBN4+2wOzmiU/i/Ti+DuESNyUk6Z2sZdVGq9Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+WSMgFwxVJzuGX/ZrH5yyP4cqXkfEIX43tHwwVS8AboyfXBsjUPg0sUskK9DRUQcJ3MR/aIdZs0iFxHYWPW2TvW4iE2fo6oS4q1fxuuo7Lnn8rUkrK0k0nqRsyeEqa0ciKshOE38ziXfWQJdUDlB58HtfB3uNk/VzcgB43lxJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TXgXK4St; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c7902f47so14572525e9.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783753985; x=1784358785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQOzeXV8phwSUt0xHK7ZAorIIAoHjVqQrsau28MhLzE=;
        b=TXgXK4StoK/5ZxxboEGyrVKWH8OZoZ32y9ZnT+G8Ga+dQGcEI6OHqCK1sn3ZC4c0f/
         GRsS24NcO+qG3vNu0D0X2UxqCpKddKiMMy5UJ6M/nW6RIHs7CvA+X6qI4gQQF5tnuUfi
         PSkuYUA1S7TnNbO7S/21ydAWi1rBnBNPLoj+jUg2wBkCLz5ryIEuG75JNNLHd62VRtVL
         FqpViNbc/O37ZUD6zyCMFLykqDAqeVyKXKJjSxSAU3YzSZiqNhdXt21Ar1SmL8g/FXVV
         x/NCDvj0IozNX7d8hpkMkseZC4mQJuQ620pIP6u0mzWcfBlo84pSEby3/LdWVtlP6mZu
         Gwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783753985; x=1784358785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQOzeXV8phwSUt0xHK7ZAorIIAoHjVqQrsau28MhLzE=;
        b=V00vC71SEpAJWcDtF6Vo5+zgs05WO28GlnMTVWKtlt6WATsct7DBxryc2cf2giTKVz
         joqVoeLRHKyUJ3LsaRPiDjUJrkhUes24XEzaFRA/5RmWucbKM6Ba5p2IcdeMSQ/+AjDd
         UzojDguDr97C37KIool2PIOb1CHStK5P9GW0fgT1U1qhSCsdnVxOC7n29Jcp1sdv3xaj
         gAH5LJuWV2mzbn5umlGv81mTWn09LXD8ZRVqjW1kRF77zrG72iuFw1Kskln7GOaL5Ud9
         BDoVHzJoT3Ji5VPpP5dGqMwg5qvbJ5Vst11UcGkT+mtcOGTXOqyG/pfrIZdc6DUI8FQj
         ciqw==
X-Forwarded-Encrypted: i=1; AHgh+RoGwgQVpe4q+JKjXZxDOZzJOxCbKW7FByzEBToa8LoVn0yLsfADXi+KEi9JjbmxE0yWRVt2+YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJscOdtj9hBGvnOQMcVrkcHh9ACOHWhL4tBg037MA0hHYNoFfz
	oaN7Yy9+pKbwK+Ghjy6/v0wX6NcdIFNQj28Ls3dSM/xkoFCaQXJxIRm0DSm7NMD+y+1TcmxhplI
	FASwr4VWX
X-Gm-Gg: AfdE7cmGeGHGalIQ/91Hi5CMR3Xs010JLNew7eQ/Wo9ub+VYNOg2CTyjWZ+mJELFH7i
	f67rVNrgT7WYDe6ZncgeChjkZonuTXr8089Mz7FV7XoejI4b57zimF3gkbbAMzsDVWjjx7g3jRp
	I35nnIAncx0OEtZKhUAD8STqC1deicRmuLkAns2uonCok7ltcEzgi6anDfDdGNWD551oxrgh3k2
	jjcCiHxDKzxEQHz6AXLbnRDTtikO0NqSxy9Z2E7k593o2yQq41988WSsIZt+zrofn2/XS6rpzXT
	zRwiym2fhtp5Tb/9zhn4JFVRJ+8bM8ORHKog2QGHg1QStpiodxT4BkuLZi1XcIRxyDRGu9NpqQi
	IARZ/039J88w1N6bUst0ZYfCWKAGAicRSh9LY4fl/WZjazYiwo6e9fv/+UyQejjTQgFQ9yiMeuF
	A6Jmyc0veK7P5ydvyOGKa0dUdp7EaVUbOwiY1LBHW/m/GjnzYqeqe7Bun6nbPQDJ3BSOVhj5jBX
	yWONFIGbtQ3ySyJTfQNesZpFKNcG80pGtU=
X-Received: by 2002:a05:600c:4f8a:b0:492:43d2:9e6e with SMTP id 5b1f17b1804b1-493f87e9bd4mr15077835e9.9.1783753985154;
        Sat, 11 Jul 2026 00:13:05 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm87910115e9.2.2026.07.11.00.13.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:13:04 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: David Heidelberg <david@ixit.cz>
Cc: oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] nfc: st21nfca: validate ATR_REQ length against the received frame
Date: Sat, 11 Jul 2026 09:13:01 +0200
Message-ID: <20260711071301.58071-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306752-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A9AB740B24

st21nfca_tm_recv_atr_req() checks that the received ATR_REQ frame is at
least ST21NFCA_ATR_REQ_MIN_SIZE and that the self-declared atr_req->length
is at least sizeof(struct st21nfca_atr_req), but never checks that
atr_req->length does not exceed the actual received length (skb->len).

st21nfca_tm_send_atr_res() then trusts the declared length:

	gb_len = atr_req->length - sizeof(struct st21nfca_atr_req);
	...
	memcpy(atr_res->gbi, atr_req->gbi, gb_len);

so an RF peer that sends a short frame but sets atr_req->length larger
than the frame makes gb_len exceed the general bytes actually present,
and the memcpy reads out of bounds past the received skb. Those bytes are
placed in the ATR_RES and sent back to the peer (kernel-memory disclosure
to a proximity attacker); a larger declared length is an out-of-bounds
read (DoS).

Reject frames whose declared length exceeds the received length. The
adjacent nfc_tm_activated() path in the same function already derives its
general-bytes length from skb->len rather than the declared field.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: 1892bf844ea0 ("NFC: st21nfca: Adding P2P support to st21nfca in Initiator & Target mode")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/nfc/st21nfca/dep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 3425b68f0ddc..a5fab4fd5129 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -205,6 +205,9 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 	if (atr_req->length < sizeof(struct st21nfca_atr_req))
 		return -EPROTO;
 
+	if (atr_req->length > skb->len)
+		return -EPROTO;
+
 	r = st21nfca_tm_send_atr_res(hdev, atr_req);
 	if (r)
 		return r;
-- 
2.43.0


