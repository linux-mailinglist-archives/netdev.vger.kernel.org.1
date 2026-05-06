Return-Path: <netdev+bounces-284955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO/YCbpy+2m7bAMAu9opvQ
	(envelope-from <netdev+bounces-284955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E64DE713
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DCD33001A43
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23B4A1391;
	Wed,  6 May 2026 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWQYgClJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C3407595
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086568; cv=none; b=iQ2THTo+xAcCqNnX/7xAnWI0Z5w1reKfDhPK/T+Sh3SZJ+hFES/kO4AcSu1WyiTZisP1AE/mjNM19IH82Xxu7rlzWsDR8DtOPG1gvm/uRQ0cJPMkL18VNIVMLW2yiUcT05qk6j/CXhj0VuIIt4x28c9ZuvZPUx0nqGHej09PMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086568; c=relaxed/simple;
	bh=I8c2mqrn+GbPusWKR9GgjeQNF+Oi6stveIzi8mTd7YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgrEBVz55rWv2F5L8s8DGZCyRrrfcYgdW2Q890UQnlSlvIuPWaEMdfd2L+GFQYxg9Jv3votZIvRnQW6NuElR76L+xGto/9sLiL3l8nmfuoeCb65izk1fVndeAzbh2BYAN3x95WxuXiwzhtqm6oiqHkI+94LCJwM/fsgJNc7KVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWQYgClJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ba840146so59324125e9.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086565; x=1778691365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUpWtIZiW0hfUH+jamgfz3Eo7DhnYhBOXFc7dMF9+2g=;
        b=bWQYgClJgDVn04S6TCLe41cL1CEWIDgK7saJsKNU4O7PAnFio/5dEnwedJlqfVdfwi
         c2u/mkGGqtq2vFP2dB0x8OID7z562SbYN+wdvSc5eBIrDkhKUE8b3E3ky3ICS59IVZgn
         PmWHoqocajDtc/kqFjZiLTRzQ6FHMdlojImvInXlPnnXKhtEusVUlRI3+CqasuLvK/Cn
         ayJ6hq/GyxrawBgC4vBdLM5pI5DdAAaNcya7ldNjO4JicCB6SzoOuWZwsrvrYEKSidqY
         B/gawF5CuqBSKH74TuJZAYnrQz0MPdZbZIPymuNgWB3WQBOyJKhOZs7bkg9QUC/9e41J
         jslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086565; x=1778691365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lUpWtIZiW0hfUH+jamgfz3Eo7DhnYhBOXFc7dMF9+2g=;
        b=qald5i1ZWHjxQHN0aA8lXm6qUwpODkk0TXBtQOizNjKuWJhJKwZ+mq4Ai4y2bjENss
         JcaazhfjSfEsCYKeRtxlyLy8m64KAj1j0IQfW/dXAmIDJR7EXjbMS6B0UTsKdax3+Loo
         POnECGNuEqladaYsUEqkcj/DbiwG7Z/QAogVZA7+iBNeIl1HT2JHeQ+Wf3ZaMqkaRICh
         +0dcGgyOv5f4IYOA0eBLysFyAVffdlbZ3ATM3w5rMqdZdLxK6SYrcm2G6A/OQjc3Cji2
         Wsk53U0r8V/o2pS8yPK3ZJ5kVqwbHaOCs/9w5trt0RZ1RlB1NJzJzf6zJVtubiOeb2FH
         9exw==
X-Forwarded-Encrypted: i=1; AFNElJ9FY86t+0/3/Ivd/sSRu2zxpcIvO9qk/MxAKV8fvTi9MpE33V5mgJGiAar5yI+dpWLiR4B/kGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIaKnVjLrLhpfoY5LUQHDWFtUIZEKglsPNYAyMCHXWFDFbllcT
	+9D/hjSphRmacv75+XiZkjrw7EOYSeS26ouel/xjBwWbCvJuFkNNAnSU
X-Gm-Gg: AeBDieulTOXf1KnYFKyjEKEjHpf4lOrwAl8rIh3nDvp8JRRl+dFmn9oOFEEF+kgre+u
	CCrWdnNY67NBMp2DGbcxTXfg8PgXOM/Mh/DWKk/LTC62OeLklLxThCPN9KO+brtIkua1hq+KgPx
	JDc+cDDWuK8Hd1QV5SUYLnkJEVP3kNWQJrF9xoklhyUEKR7+oSlFzMYUUyYro3ig3m7p625rJIv
	gaOx+GFEUzT81q0TxxVkPU6peuPqSEYLishjqQKLIfho9C+H5ia4U06A+sytJu1YrTxKFkQUGY+
	GDQWPAxATkTCRY+Ltppc5jYp0in/hlcwlFvKxF9mh7P/pRh3WLaqwjSW2acLnPPQ8aCKVU+xwNi
	l3UzihAkX80W45SaPZ2CSlq8y4S79ppLMAIdOPmzRvWe8/ZhCXzUpgD5GZf2QAcH3BupwwX/F5Z
	lQFbSGqVZxRh2TyTlstLBHQlWUJDObgM2zVWJxFjdI27UxLjl5JTxG/R+3muUI+1DCfqCcMd88s
	59orwDXdH1US2FdYq/29A==
X-Received: by 2002:a05:600c:3548:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48e51e0a60fmr74441105e9.2.1778086564877;
        Wed, 06 May 2026 09:56:04 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:04 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 1/4] mptcp: sockopt: factor inet_flags propagation into a mask
Date: Wed,  6 May 2026 17:55:53 +0100
Message-ID: <32ed11e8643124839d86e5dbd9f9429ddbed58a4.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778086500.git.devnexen@gmail.com>
References: <cover.1778086500.git.devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 271E64DE713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284955-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Introduce MPTCP_INET_FLAGS_MASK and replace the per-flag
inet_assign_bit() calls in sync_socket_options() with a loop driven
by the mask that calls assign_bit() per set bit, preserving the
per-bit atomicity of the original. Further flags propagated by MPTCP
can be added by extending the mask rather than touching the call
site.

No functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/mptcp/sockopt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1cf608e7357b..20c737b2e704 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -16,6 +16,10 @@
 
 #define MIN_INFO_OPTLEN_SIZE		16
 #define MIN_FULL_INFO_OPTLEN_SIZE	40
+#define MPTCP_INET_FLAGS_MASK \
+	(BIT(INET_FLAGS_TRANSPARENT) | \
+	 BIT(INET_FLAGS_FREEBIND) | \
+	 BIT(INET_FLAGS_BIND_ADDRESS_NO_PORT))
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -1540,6 +1544,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	unsigned long mask = MPTCP_INET_FLAGS_MASK;
+	unsigned long src;
+	int b;
 	bool keep_open;
 
 	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
@@ -1586,9 +1593,11 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 	tcp_sock_set_maxseg(ssk, msk->maxseg);
 
-	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
-	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
-	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
+	src = READ_ONCE(inet_sk(sk)->inet_flags);
+
+	for_each_set_bit(b, &mask, BITS_PER_LONG)
+		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
+
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 }
 
-- 
2.53.0


