Return-Path: <netdev+bounces-288653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFDEHdCeCGq7yQMAu9opvQ
	(envelope-from <netdev+bounces-288653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 18:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3EB55CABB
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 18:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96177300B62B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A343E832C;
	Sat, 16 May 2026 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/Rk49AL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C43E7BDC
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778949824; cv=none; b=HsYpaCeImKkHaFEeUal0OQrPO+5CmOW5tMxVPzUGhT463qA2/CY2gkdhLuFOYy3o6LKRBSGWuVqnKTtVGa8x8GDYbAPZw2+/yABvIX8CV0snpaa8qC8ySKAbmvbH043KTsQUYPmmtiLrl8JGZJRE+eabFTwUndgKI7zTNr5A8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778949824; c=relaxed/simple;
	bh=VK6oQzrtgf6YYfW3WkqQQxt0wecu5lgEtccn/P7djnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rxqi3YzveexW5BEIUPJBIwcdxLB1WCmT/nmZHFt4EfE9ESDW+j8D9/lXtjPm5IArX82E/fBLvaigfv8mo2Tarmf2v3OnvCr1+JrZ29XF3Jfn7Oak5dyc1B3E+uKhpHfFosmH3c8YVbrDt8zHADpUdZKCnIZ6uv7sWK2zkZmEy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/Rk49AL; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-83659d38e38so365184b3a.1
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778949822; x=1779554622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aA9KTdiB1VlZvIllZFRx7+iTC5UX5yzMKOX1jBgCP78=;
        b=m/Rk49ALLW1g2ZK1g4YOD614AUKx7qFC/F/ELNakxInhVQjipE4NUeIL33OqJFxTs6
         OBt9+cR/wQJeP1kTBcZrFqIfdodO3GKCaS6PHEhAPCDsUSR+4sugCj8NmndjrtewEPB4
         2serkR9BsAbORsFryIeYsN2zxW1jJpRhXmGlgmwwSyKGoR19GajOwpKNVNBtqlEtT+j7
         bcgiK2Ymb3e2gsi12y6DCgJskfmxQdRzWDE6uYK4Vev6QQ8bibPkeZ/k9DDlQaq9+06U
         e44OucPPHgfE8j5B3tyOFBlOZNmhm6Yw6Qu3C6D0UC19/5mumyBmIRQeTYlqyMwHPAUW
         PdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778949822; x=1779554622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA9KTdiB1VlZvIllZFRx7+iTC5UX5yzMKOX1jBgCP78=;
        b=T4t0nrZ3mn7YKOtq8Mca7puYq9E8hAD4rOyVCYLrA0XWlHU1qro3lLrRCqI71mw8t1
         adPaJ6pSN/VIBUiOQ8yXTjKnyTdw7tHYnIO7kTx3NFlpaA16x6CydpTek4DNsTtxS9eM
         8BY3kjJMaYWrl6Y8+Z8W0zj/p7BQ6b51BmpaoaqJn+8ehCC8jZf8at/FpsQxCdh+hVvq
         bcgGjs7ZPpBdP/KwBOjJLQSvZLRVW/1rS7LrygrJltVu0FOc95zBk9PEB32Ur2HvMCyp
         xsYqLDntBCI8iap1ZQlNg4IILBiuXtdzyTX1U6v3AvWbedMVRsDKrNTwOxTHK9NS1tbu
         9y3A==
X-Forwarded-Encrypted: i=1; AFNElJ9sSthGW20JMhkjMgTfNsO04CdFADzh9yLR21+GLOnBORqT4bt1+mReh/RbB3O4EZLRHpv80i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxM5A75ehyqeeytYBX6fEuXRYYQGKqXlHbnYE10rN7gtnRwQQ1
	nd2Z+vo7S++2KSZoI/sVpr5jAny+3qD96N5JXjDKKW3XYzIEv+NvHZVs
X-Gm-Gg: Acq92OF9VZogy7LrHpAyy4USWtaSaUhjZgG+yJJvd4+c66qFxHvb00s+BKmY9qfmQh7
	oolVgdp7Jlp8RfPbjwE8XEmg1gJf+1hUrTNEaFOh5UGMgdEj+DTCKEQMZQ+AWOxS+BMg5G8FadV
	uorVGWIpohYcn/YDingKoOSqHLUbHd6Yr4cpWWftjdkkFyjBEznn1cELi0siKcrxpLSI3QZZB6z
	1EPOFjVz/7FwYrlbmns9TCqJn1uqcNbkL5sRXlsLUE039w1a3m6Fe43m1NGL4lpFuVCs6lqCADs
	CYu4csrF3iFCKRn/phpZWehHHdpqaAa2tIYbWB1VdTiQnkyiVE84bqZPfKXnqWnBbQDSxPSfMuz
	B+PicyGOVzpOmihtkGlOVbmitf1CG4ZhWKBPXmeVxV/fbJkKlixn6iW9B2AsWl+tO7gk+qJiNDt
	INph7+GJPhMSJXtoYVwLynO3nhcAjOja/VId/xyj5iWw==
X-Received: by 2002:a05:6a00:1251:b0:838:6d43:9488 with SMTP id d2e1a72fcca58-83f33c61c17mr8989803b3a.32.1778949821723;
        Sat, 16 May 2026 09:43:41 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7ccc7sm11281641b3a.58.2026.05.16.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 09:43:41 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bpf, sockmap: keep sk_msg copy state in sync
Date: Sun, 17 May 2026 00:43:19 +0800
Message-Id: <20260516164319.1519418-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE3EB55CABB
X-Rspamd-Server: lfdr
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288653-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

SK_MSG helpers use msg->sg.copy as provenance for scatterlist entries that
still refer to external or shared pages and must not be exposed through
data/data_end.

bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite the
scatterlist ring by compacting, splitting and shifting entries. Those
updates move msg->sg.data[] slots around, but leave the parallel copy
bitmap behind.
A later helper sequence can then move an external entry back to
msg->sg.start with its copy bit cleared and make
sk_msg_compute_data_pointers() treat it as directly writable packet data.

Keep msg->sg.copy synchronized with every scatterlist move, preserve
the bit for split tail entries, and clear it whenever a helper replaces
an entry with a freshly allocated private page.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Cc: stable@vger.kernel.org
Co-developed-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
While researching recent page cache bugs, we discovered this bug. We confirmed it allows overwriting the page cache of read-only files via splice(). We haven't attempted to write an exploit, but the corruption primitive is verified. PoC available upon request. Recommend fixing ASAP.
---
 net/core/filter.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714f..352233da29429 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2654,6 +2654,19 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
 	}
 }
 
+static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
+{
+	return test_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i, bool copy)
+{
+	if (copy)
+		__set_bit(i, msg->sg.copy);
+	else
+		__clear_bit(i, msg->sg.copy);
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2738,6 +2751,8 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	} while (i != last_sge);
 
 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
+	sk_msg_set_elem_copy(msg, first_sge, false);
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 
 	/* To repair sg ring we need to shift entries. If we only
 	 * had a single entry though we can just replace it and
@@ -2754,6 +2769,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	sk_msg_iter_var_next(i);
 	do {
 		u32 move_from;
+		bool move_copy;
 
 		if (i + shift >= NR_MSG_FRAG_IDS)
 			move_from = i + shift - NR_MSG_FRAG_IDS;
@@ -2762,10 +2778,13 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		if (move_from == msg->sg.end)
 			break;
 
+		move_copy = sk_msg_elem_is_copy(msg, move_from);
 		msg->sg.data[i] = msg->sg.data[move_from];
+		sk_msg_set_elem_copy(msg, i, move_copy);
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		sk_msg_set_elem_copy(msg, move_from, false);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
@@ -2794,6 +2813,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
+	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
+	bool rsge_copy = false;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2866,6 +2887,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = sk_msg_elem_is_copy(msg, i);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2891,23 +2913,31 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Shift one or two slots as needed */
 	sge = sk_msg_elem_cpy(msg, new);
 	sg_unmark_end(&sge);
+	sge_copy = sk_msg_elem_is_copy(msg, new);
 
 	nsge = sk_msg_elem_cpy(msg, i);
+	nsge_copy = sk_msg_elem_is_copy(msg, i);
 	if (rsge.length) {
 		sk_msg_iter_var_next(i);
 		nnsge = sk_msg_elem_cpy(msg, i);
+		nnsge_copy = sk_msg_elem_is_copy(msg, i);
 		sk_msg_iter_next(msg, end);
 	}
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		sk_msg_set_elem_copy(msg, i, sge_copy);
 		sge = nsge;
+		sge_copy = nsge_copy;
 		sk_msg_iter_var_next(i);
 		if (rsge.length) {
 			nsge = nnsge;
+			nsge_copy = nnsge_copy;
 			nnsge = sk_msg_elem_cpy(msg, i);
+			nnsge_copy = sk_msg_elem_is_copy(msg, i);
 		} else {
 			nsge = sk_msg_elem_cpy(msg, i);
+			nsge_copy = sk_msg_elem_is_copy(msg, i);
 		}
 	}
 
@@ -2915,13 +2945,15 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-	__clear_bit(new, msg->sg.copy);
+	sk_msg_set_elem_copy(msg, new, false);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		sk_msg_set_elem_copy(msg, new, rsge_copy);
 	}
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 
 	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
@@ -2945,29 +2977,41 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
 
 	put_page(sg_page(sge));
 	do {
+		bool copy;
+
 		prev = i;
 		sk_msg_iter_var_next(i);
+		copy = sk_msg_elem_is_copy(msg, i);
 		msg->sg.data[prev] = msg->sg.data[i];
+		sk_msg_set_elem_copy(msg, prev, copy);
 	} while (i != msg->sg.end);
 
 	sk_msg_iter_prev(msg, end);
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 }
 
 static void sk_msg_shift_right(struct sk_msg *msg, int i)
 {
 	struct scatterlist tmp, sge;
+	bool tmp_copy, sge_copy;
 
 	sk_msg_iter_next(msg, end);
 	sge = sk_msg_elem_cpy(msg, i);
+	sge_copy = sk_msg_elem_is_copy(msg, i);
 	sk_msg_iter_var_next(i);
 	tmp = sk_msg_elem_cpy(msg, i);
+	tmp_copy = sk_msg_elem_is_copy(msg, i);
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		sk_msg_set_elem_copy(msg, i, sge_copy);
 		sk_msg_iter_var_next(i);
 		sge = tmp;
+		sge_copy = tmp_copy;
 		tmp = sk_msg_elem_cpy(msg, i);
+		tmp_copy = sk_msg_elem_is_copy(msg, i);
 	}
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 }
 
 BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
@@ -3024,8 +3068,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
+		u32 sge_idx = i;
 		int a = start - offset;
 		int b = sge->length - pop - a;
+		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);
 
 		sk_msg_iter_var_next(i);
 
@@ -3038,6 +3084,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				sk_msg_set_elem_copy(msg, i, sge_copy);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3054,6 +3101,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				sk_msg_set_elem_copy(msg, sge_idx, false);
 				put_page(orig);
 			}
 			pop = 0;
-- 
2.43.0

