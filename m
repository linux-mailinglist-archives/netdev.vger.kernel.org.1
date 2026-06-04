Return-Path: <netdev+bounces-295252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdu3HwaEIWpKHwEAu9opvQ
	(envelope-from <netdev+bounces-295252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09F5640954
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:56:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ip/bvAmW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295252-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295252-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBA2317F2E1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72E447DD65;
	Thu,  4 Jun 2026 13:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F44014A1
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:40:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580438; cv=none; b=VVAAk29BBhZxYA7A028riWeIZKFiF8GPKWeoioiBCOtyX58YLmNtp0Z6n8TJwMSUQtAzrZ+YZGRUP+Tv7D805whK+t2YP5X7Wjp90qPibNk2rehboOf2m6CpUVRgKCuLS++ApP65/SksDXwB0KniX6VE3v9DV30TP4jbl13TN7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580438; c=relaxed/simple;
	bh=q3/CITPsbHycvhvfXWpLkzbmqitx0cxdIPykix5yts8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKJ8P9HLS70wUlnnN/w0rbkOx1YY6BNeCvYmMr00QrjrmPEIvCwOxO6rDitmrLLjiLD34qD1Ya6StnJxA+TUyQEJoBNt5c0NM6R66hCdaqCi1cJkGzejJfDVICJvSWA+kVeSltDsgsafYlqpOfjEpQzffKVL57/nGqNe12JbgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip/bvAmW; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so5440475ad.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780580435; x=1781185235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0tWOa9UJQqyAGS8HaLwmzolHNh+pFxRRNFPs4YNFwk=;
        b=ip/bvAmW7eI8o5AuK9mZWoEVhnvODuv4Lc/PE+KkxwjpcGQnHAyXfE9lqbCDHmHDhx
         un2Fs8gJ869erUYvQCKzzxsTUnr/SNxhCl0czr9vvJkG2r3w/1vvkCZDchf+JU0o1oa2
         hmoc1dm5hGwxTBPPQvVNsV87lT5E2RVQusPDzNq+PZ+n/qyROR1/mgtz65NntYYawk+X
         JRN7GSvh1RwWZ48JAg2VrP9ZEPFXznLx2BX8dn681wLAEpPBpoIx6oK2E1JRZFI6t6yR
         MWzMYbce6rAy6LG4Vrl9l5O7rEY/4lrRS1H24e954OWIn2XIYhwQqcRHjW8HAIbBxBBY
         TcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580435; x=1781185235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0tWOa9UJQqyAGS8HaLwmzolHNh+pFxRRNFPs4YNFwk=;
        b=pj3e+wn6jGWjxDkJHnin+oGNMfttZ7NZoMa56BRbbMKdxtAWsRQQmSZlH4Q6Q8DE9q
         SLLgDO4nIo+T5RfGCb29QFi9HhbHtoap38UJ8EgfmUYzAxg/z/gdHGEtQIg72T0frAcH
         0moKnYpDOLD5INL+DXDp6NOqbs2/83szPr61US7z4HugF46+JSwoIeon4bNNFN0THp7y
         Q9th/C7pvsRa425metGtu93xBPDyvkyoQCViJrFCpVEQG589ZWECtu9h/vKakb3E6K46
         Q8rBdZhFW4CacXazDDAcn+J3J4rzsPEKGWSGcBDFeHKz3WJCckFzjwXw9VwMK6OSIzxB
         wU9A==
X-Forwarded-Encrypted: i=1; AFNElJ/0lMe4fq9+QWkQWH7jHhsyQs8fC/Zl/mw5Svsgk7g0PNwzyik7LaODPKbczaVsm79fOvGESeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxfQ+PVUKC3YeOGzUOnsdpBjpxLOb6FY51Z/1hKcUACcSw0O7
	2HqcTgIfw6fm35O9A6aihMSk9bsjxi9rtXuRdtwjXI3x8S7gT3ulnlpy
X-Gm-Gg: Acq92OFovDkh2h03Iht6IfndV0OTXKBRYEUQ8X8PJP3UhA7ryxs4PUWEDd034NQWDkb
	mepVlBX/hfA8ARupqcwfzuM0+Rsp5Z67ZAiqjzSlpIkVy9XcGvKQbSbaCm7gcj9ZH2l3FaNb6fY
	QmC5UdoSzz05cgV8LIhq2bHyuZ0W/rXilP/k221QYuSDSqmNqaH++hn6qpX3eVin2F76uqP9wIa
	0IlWcEWOKFTlzJS1LZJ/p5BV0y+bDH7LrRrOmQahl5z+cGqPC41H6dBr+Ubza/OmeFbrhSNibja
	bVs/BweFGRAlu6ZozH65VhammJTN7JUto/UZ1wlCFEVzP1AhFCn9FD2EgC/a3lGrN6PwQRHO2Ot
	+7OPcz5JXXZuGIOzCI4AIOS5UpRi1rBD1iBfStnw4E8x5Hf1u7+wn+9qLFrgQ6Lf13pjHIhygmA
	xOQAy7SNQB/c/DmVxeZpZFim/IPDpNa7pNimc6Hkp5N8Suyt/CzXGvkZLk4JI7mg==
X-Received: by 2002:a17:902:e786:b0:2bf:dd8b:7cd with SMTP id d9443c01a7336-2c163a54bf6mr97328975ad.10.1780580435021;
        Thu, 04 Jun 2026 06:40:35 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm64870065ad.5.2026.06.04.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:40:34 -0700 (PDT)
From: Yiming Qian <yimingqian591@gmail.com>
To: security@kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: keenanat2000@gmail.com,
	yimingqian591@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/tls: preserve sk_msg sg.copy when splitting records
Date: Thu,  4 Jun 2026 13:40:11 +0000
Message-ID: <20260604134019.39161-1-yimingqian591@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,cloudflare.com,queasysnail.net,davemloft.net,google.com,redhat.com];
	FORGED_SENDER(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:security@kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:keenanat2000@gmail.com,m:yimingqian591@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yimingqian591@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D09F5640954

tls_split_open_record() copies scatterlist entries from the current
plaintext sk_msg into a newly allocated plaintext sk_msg when an open
record is split.

The scatterlist entry and the corresponding msg->sg.copy bit are one
ownership record. Splice-backed entries are created by sk_msg_page_add()
with the copy bit set so sk_msg_compute_data_pointers() does not expose
them as writable BPF msg->data.

The split path used memcpy() to copy both partial and whole tail entries
but left the new sk_msg copy bitmap clear. A subsequent SK_MSG verdict on
the split tail could therefore receive a writable data pointer to a page
that was only supposed to be copied, allowing BPF to overwrite externally
owned page cache.

Add a helper for copying one sg.copy bit and use it for the partial tmp
entry and for each copied tail entry.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 include/linux/skmsg.h | 9 +++++++++
 net/tls/tls_sw.c      | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f90..f3988ce2219db 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -283,6 +283,15 @@ static inline void sk_msg_sg_copy(struct sk_msg *msg, u32 i, bool copy_state)
 	} while (1);
 }
 
+static inline void sk_msg_sg_copy_one(struct sk_msg *dst, u32 dst_i,
+				      const struct sk_msg *src, u32 src_i)
+{
+	if (test_bit(src_i, src->sg.copy))
+		__set_bit(dst_i, dst->sg.copy);
+	else
+		__clear_bit(dst_i, dst->sg.copy);
+}
+
 static inline void sk_msg_sg_copy_set(struct sk_msg *msg, u32 start)
 {
 	sk_msg_sg_copy(msg, start, true);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268ee46..434753de8aadd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -623,6 +623,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	struct scatterlist *sge, *osge, *nsge;
 	u32 orig_size = msg_opl->sg.size;
 	struct scatterlist tmp = { };
+	u32 tmp_i = NR_MSG_FRAG_IDS;
 	struct sk_msg *msg_npl;
 	struct tls_rec *new;
 	int ret;
@@ -644,6 +645,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 		if (sge->length > apply) {
 			u32 len = sge->length - apply;
 
+			tmp_i = i;
 			get_page(sg_page(sge));
 			sg_set_page(&tmp, sg_page(sge), len,
 				    sge->offset + apply);
@@ -675,6 +677,10 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	nsge = sk_msg_elem(msg_npl, j);
 	if (tmp.length) {
 		memcpy(nsge, &tmp, sizeof(*nsge));
+		if (WARN_ON_ONCE(tmp_i == NR_MSG_FRAG_IDS))
+			__clear_bit(j, msg_npl->sg.copy);
+		else
+			sk_msg_sg_copy_one(msg_npl, j, msg_opl, tmp_i);
 		sk_msg_iter_var_next(j);
 		nsge = sk_msg_elem(msg_npl, j);
 	}
@@ -682,6 +688,7 @@ static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
 	osge = sk_msg_elem(msg_opl, i);
 	while (osge->length) {
 		memcpy(nsge, osge, sizeof(*nsge));
+		sk_msg_sg_copy_one(msg_npl, j, msg_opl, i);
 		sg_unmark_end(nsge);
 		sk_msg_iter_var_next(i);
 		sk_msg_iter_var_next(j);

