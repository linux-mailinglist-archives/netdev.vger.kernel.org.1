Return-Path: <netdev+bounces-306789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SdnKFXYLUmoLLgMAu9opvQ
	(envelope-from <netdev+bounces-306789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A3741083
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=W2dtQqRj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306789-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306789-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F182A301B4CF
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9138655A;
	Sat, 11 Jul 2026 09:22:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6446388E5B
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:22:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761771; cv=none; b=llLzgoihzQRBp8BIXna4PmLXwXXeixJR0xpeSj97UC76Kd/HA2XJZYU+1P84UL9cPOxcjvwhqWjhXNwzslRbRVfL9KujmlTbSsOI7XgMk35bti+2DQBsOswEiRPBXauErwY5itKn8rQRATEQhbJ2VJPlWQmzXFDxGwQl7EtbN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761771; c=relaxed/simple;
	bh=1ZDKUtGQ/a8BS68raZRoNcVAxiVUqlOQWmMvMBshBKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgGXHpE8wa/FbyBt0CRrvU2m7jfl5JM6U7jlqGeZ3CgcTFASbxPu+/LSZF2kWl/nU1JDtfxTIhnMC4Bc7aNh3Z8I/W0Ynqkecmem1b+/5LwsST67d5ryTkuuPDDP+f6G/nxrS14qVSZivY8r35DcaYAtcwLeCuAXoU6GaogBgM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2dtQqRj; arc=none smtp.client-ip=209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso209095766b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761768; x=1784366568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T98o7Pl7lA+wpHQm5Sj3XRNCCZO6SwAqa5AzQEn9zdo=;
        b=W2dtQqRjx3L/A/DKWmnWU6w0kVY0VaBD5LxLlcWpuWbVBHWLeW82RDzbWgv1jb+wse
         vjHvG9avFZcOTS41oezsFO4Iaa8icQ1tsurGuN8jU4C4Z9aov0GHVGHL6XadoeQuJrW0
         xfhfoAqkrL4CK6V3wEIOz+78wx+wYJCPLkEQBLM5WoSv0hp/1bPViS3Cq+3eVUhdNUnP
         kayOU3sonxU8jR32xSqL1jmzyQjT1B8ITGPawg4WwBo9zYNOewxpF/tMdH5LGkFpSXBP
         b5DnL0x5SJjXrsLeocyAwOMwDYoPywM1PqzD/2xDeS2SVT2tEJl7pg2QLkfkFfo6ygne
         7G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761768; x=1784366568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T98o7Pl7lA+wpHQm5Sj3XRNCCZO6SwAqa5AzQEn9zdo=;
        b=e2xivMKhJv5fPrecQK44j7DsW4f4LecuDQksjTArzaI1b/VEEo1idtQ4aiw8eytg41
         TPIFSDxrFlKllGJYvPzfJm5Hrm1ntosPdh29JSMWSzxAY0+iv1l3N+ujttrVQj3TGpzL
         +9vKZ3hx4Ms/+ANz9wOIMLPOTnZj1FjOwVHaQ/xFa528mEQF0WErd+CpNXjozmhjJkJ9
         e1CEnC2riaydGzudfjV6bh0n/7mWjil2MhzVnHaHlpewl5LXu/M4WXL/KOcQLQNFurSq
         4JRU7+45fQ8ou3uVjh2Ys8wX0k/bm41RkhKue1g9kwhMcxxr+2F1JhI2ebJArtIGxZOA
         L8YQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQIIDIg5s12jLN3De24urjbnpsiUEnWmWK45jAisiiiOI3pZJJ/tieEAFrhA3FtkA03jnPLnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3M/7Rcjty0GJVSCjfhS1WlpoFPiWTrfZHUn4fEXeWlcEv0v3
	xQ5qKBuOxCBEbMlN5czwdeu1Ihr8oJ4gF06A6Kj5CX7QHxDtW/9isi79
X-Gm-Gg: AfdE7cnEm8JeTZ8u7DfG2bgZXjGRSzdwDjZpu6QVCZDy83Te6BEw2BQDSqkOT5JJg59
	L/f7pDIz5F3Dqma2KZ2MmeH5iInVRZ1HvPlfeIJ3qWBYHojfZ9ldVN91qf2K+gzpyEzZt9auFr3
	Rv1zxyYKyx0h3qZfKat+1F7M1LSRI8QGO/Iy42xao16VAYQZNDwG7QUGPUTtV2gGHQFhr9RhPcD
	FkXDmDoVyKxn81S7GJgRRljUWoZR0yifacXEKkI6d69kn0BRMyvqhhRA4lEPD/bRrpODTClPdN3
	wKPCC+Q6DCIDQSXZp7JEVR7PuAucY4nlWB5Tb38RrlybsH+DGdtOxEcgK0KguxrOZDndu6Sm6AR
	FB4Z+rbNRabuIeIuxxrRuEFdmBmrq1EWzLR9QHHVzGUtmi3Ko3m/Pc446g8Te/lCU8jHKh1qSb4
	axDthKXXGrsi8Of2D35VQXoxHCM5yw7tWU3mbD+T7dFKmJxUeD40BST47gC8zGHz7PLYNF6JInI
	DExSwEm77dWlR6mnQy2ulu5bw3C+dYDTlkwLlw4bYUA5UE=
X-Received: by 2002:a17:906:c10d:b0:c15:e9aa:f711 with SMTP id a640c23a62f3a-c161e8b2300mr76157666b.14.1783761768105;
        Sat, 11 Jul 2026 02:22:48 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:22:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 3/9] io_uring/zcrx: don't save/restore count for frag skbs
Date: Sat, 11 Jul 2026 10:22:13 +0100
Message-ID: <1279bf7c6c379945e57dce4d7366c1764a3fb938.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783619193.git.asml.silence@gmail.com>
References: <cover.1783619193.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306789-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF4A3741083

We save and restore desc->count before recursing for frag skb
processing. Extract the handling into a separate function instead and
pass a flag.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 0aa6455971d6..816a169b848e 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1827,9 +1827,8 @@ static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 	return len;
 }
 
-static int
-io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
-		 unsigned int offset, size_t len)
+static int __zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
+			   unsigned int offset, size_t len)
 {
 	struct io_zcrx_args *args = desc->arg.data;
 	struct io_zcrx_ifq *ifq = args->ifq;
@@ -1907,11 +1906,8 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 		if (offset < frag_end) {
 			unsigned copy = min(frag_end - offset, len);
 			unsigned frag_off = offset - start;
-			size_t count;
 
-			count = desc->count;
-			ret = io_zcrx_recv_skb(desc, frag_iter, frag_off, copy);
-			desc->count = count;
+			ret = __zcrx_recv_skb(desc, frag_iter, frag_off, copy);
 			if (ret < 0)
 				goto out;
 
@@ -1926,10 +1922,20 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 out:
 	if (offset == start_off)
 		return ret;
-	desc->count -= (offset - start_off);
 	return offset - start_off;
 }
 
+static
+int io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
+			unsigned int offset, size_t len)
+{
+	int ret;
+
+	ret = __zcrx_recv_skb(desc, skb, offset, len);
+	desc->count -= max(0, ret);
+	return ret;
+}
+
 static int io_zcrx_tcp_recvmsg(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 				struct sock *sk, int flags,
 				unsigned issue_flags, unsigned int *outlen)
-- 
2.54.0


