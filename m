Return-Path: <netdev+bounces-306960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A6zTBVLKU2o+fAMAu9opvQ
	(envelope-from <netdev+bounces-306960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:09:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E874577D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 19:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nH05EOQP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306960-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306960-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8AD03018AF7
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 17:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8283655FF;
	Sun, 12 Jul 2026 17:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570FCA52
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 17:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783876000; cv=none; b=NyPWp+cxSCj9wq142PZvS3XqVMp9zbzbio35TgxXr52uznhfVwgohjLsSc51sC+8EptBJJOFFxO6+3vEhd6zGv6CEl/z3yYiucjEEeQotHKaLJgfe9BiCmh1n2uKRLd4XgibzbiQweYBzxoxJNxMPSdVkFX5a8M5ZtMvU+l7I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783876000; c=relaxed/simple;
	bh=tQc3GsHvQ2l0tz/sTfSyc6jajgFFUOoFLxxSIunWJ5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpdcHUW4GPhisXMJvBcYX6Ft8kBgawM6Epi5Siu1I4d7hfc+mbQ1D3bIMtAraSWfQIxvA2tFDJYjk+G+skaFK5p2+itajslLfrLRNJ0QdYRc1SIHmrwxjbR/n8D/3GKvujySYDJaALkVVLLhMbkiczVLqwHJfuaauCBn9RT5VA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH05EOQP; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4759b4f0897so1238466f8f.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783875996; x=1784480796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0QQfzxK9tzF0roqEsRb+w+5ov6uEaOi+zluBo1NJdho=;
        b=nH05EOQPWOOB4Vj4QTzKjDjLt8T5TNI5gnIqltu5L6d6SXViePn2Cx5vFkEFe96yaq
         mVpUvKc+tsjArH5NwUcyOLPsZl0zo/xdv46xxGq9oPvJfHrZwBNljPu8tg22UV8/aeS2
         sKSY7z7DQzqSPGKz5s7RoeR4rf/eEw9b98/Ac5Dhsd+jGTgHZ1siLQUNAsnUbbzlLbly
         2F0UB4s9cipEMOjfSsDb+na5PhEMMzM+0N5fsoYq2xKoYrDkiekk+iyJ1QhoMSnhl6ZR
         l+YDEqML2jgWMsQWUBqJBW/4yy0RRhlpwajzUnXojBXbqm2AJo6tqkYmjqzZETmC9NMZ
         2pNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783875996; x=1784480796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0QQfzxK9tzF0roqEsRb+w+5ov6uEaOi+zluBo1NJdho=;
        b=B5xxxd8OdtWHyhot+eBPRYsYfyq0N9VHOCqqugDOzHOOyItn/JNh+iiLHtf4TGf9VG
         B7ygAnO2vtXiSRBsnA1vlQTVTl9956xE61TkagRN2LCTA5hwesSjB/tL2hCoXtDjd3Fq
         A+LnW5OPy2plqXpr0VXJ8NcyEoM8PoVchGFcuMY5aD9GRhWSj8bdiuipFgzOjzW2iaw/
         WSuIDnqOgx9v5ijpb/B8zhfLJJYkmRKHdxC+TFlVTrfMBqayhT4zg9zm8/lFwqL3W17D
         YX6zx0qErTLnTElvmrO8Te4VFsbeWhBFvaIjPTj10tTTvFuwLC5ma2AEZ8X8G2C+oZwz
         oZVA==
X-Gm-Message-State: AOJu0YzZgtKXRnKmdUUevShRgALl8iq+oz5kPIbkOUN8oVxftO63IdIt
	iGFImKaFjuilQzeZc5Xtyqp1QAWMGu/RHQW53Zrbus+mL3p0pHLM/wig
X-Gm-Gg: AfdE7cnTpT53Dted5smJf3qLM8rfeBcJ2r4LKe+Ydx1eXbBRGQlSteNNQWqE0wCRqdQ
	VBfH2u1OTQPwiA9uHLSWBXT791mRI7DzWtnGkOXSKdfB99bWjaeG2sipw55xCg3hU7aFwb6DXSs
	SEFeVIUmYs5hHtO//omhFSyYWEgTiTfirYm4aPFpEzYZA1SsUnf6b4YT1PgenWlroHhT9B+lqyq
	svdDdt52VqVo6pkxYy9YVzBgmDQy56nqDcM9caPxoKN8UuH2JMu0bPO+eSIiGwfXWkR/nVNMFwH
	/6Z7LGD1q+biFKBN2rgkwlbZKx7kes4BoPEc2xz+IspR/8qK0NqUljK3Qw2Od8beLoieEr0NPmz
	5OJpbKAkA4XNn9VxpovzgSYv5RJ46ooD7CLI1/6sK1xm+P/J5rEUx4m1Wqblthon9ACuSX/HVfy
	Y0ybPhtJv7pI+Salw/dg==
X-Received: by 2002:a05:6000:4283:b0:47d:dfea:f733 with SMTP id ffacd0b85a97d-47f2dc8d7ffmr6928404f8f.3.1783875995378;
        Sun, 12 Jul 2026 10:06:35 -0700 (PDT)
Received: from maher.. ([105.154.180.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm78640357f8f.15.2026.07.12.10.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 10:06:34 -0700 (PDT)
From: Maher Azzouzi <maherazz04@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH net] esp: do not unref managed frag pages in esp_ssg_unref()
Date: Sun, 12 Jul 2026 18:05:30 +0100
Message-Id: <20260712170530.9807-1-maherazz04@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,redhat.com,1wt.eu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306960-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:w@1wt.eu,m:linux-kernel@vger.kernel.org,m:maherazz04@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maherazz04@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maherazz04@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E8E874577D

esp_ssg_unref() releases the page references held on the source
scatterlist after the AEAD operation completes.  It calls
skb_page_unref() on every frag page for an out-of-place transform
(req->src != req->dst), and in the error path of esp_output_tail()
(already_unref == true) on the request's own scatterlist.

This is wrong when the skb carries managed frags
(SKBFL_MANAGED_FRAG_REFS).  Managed frags are owned by a zerocopy ubuf
and the skb does not hold a per-frag page reference; io_uring SEND_ZC
with a registered buffer attaches the bvec pages this way via
io_sg_from_iter().  The rest of the stack honours this invariant:
skb_release_data() skips the per-frag unref when SKBFL_MANAGED_FRAG_REFS
is set, and skb_zcopy_managed() is the guard used at the other unref
sites.

esp_ssg_unref() is missing that guard, so for a managed-frag skb it
drops a page reference the skb never acquired.  This can underflow the
page reference count and free a page that is still in use.

Guard the function with skb_zcopy_managed() so both unref paths are
skipped for managed-frag skbs, matching skb_release_data().

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
---
 net/ipv4/esp4.c | 7 +++++++
 net/ipv6/esp6.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index dfc81ee..fa1710e 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -104,6 +104,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	struct aead_request *req;
 	struct scatterlist *sg;
 
+	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
+	 * per-frag page reference, so we must not drop one here.  Mirrors
+	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
+	 */
+	if (skb_zcopy_managed(skb))
+		return;
+
 	if (x->props.flags & XFRM_STATE_ESN)
 		extralen += sizeof(struct esp_output_extra);
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 296b579..7d216b9 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -121,6 +121,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
 	struct aead_request *req;
 	struct scatterlist *sg;
 
+	/* Managed frags are owned by the zerocopy ubuf; the skb holds no
+	 * per-frag page reference, so we must not drop one here.  Mirrors
+	 * the SKBFL_MANAGED_FRAG_REFS handling in skb_release_data().
+	 */
+	if (skb_zcopy_managed(skb))
+		return;
+
 	if (x->props.flags & XFRM_STATE_ESN)
 		extralen += sizeof(struct esp_output_extra);
 
-- 
2.34.1


