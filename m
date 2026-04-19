Return-Path: <netdev+bounces-279603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6XqLGzQN5WnrdwEAu9opvQ
	(envelope-from <netdev+bounces-279603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 19:13:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CE6424D6D
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 19:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0F1300B60F
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA7286409;
	Sun, 19 Apr 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNmRi1eH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ACA222590
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618262; cv=none; b=TtZwPAQu7h7d6ZynRAUkaZoH+rgacJLxg7e3KRJtxNycnOQSjK5n16ffwRLibBe3grND9Kk4FFzQtkDOzvUzrNL5Xe/JBdHrqZHMPgpsrHSKChraySv+5AdDfUdd+JCqOwBNWvFNvXwf/33fsjxo30eRegMbd9F0Me8ZomqVbww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618262; c=relaxed/simple;
	bh=d5uXQdHDSM5WNibQe7sItqY/lEY5kkJ+ZBgbfvz3YiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MM+e0LOhZeuEetpaJzVrycn/PinpR7yCAl3I6mvK7UClY4YV2AjB5Hb3F8qgkeoAphtMd6wqnJmHn9fpaOWmaQbAb5KU+08v1bSlrqwbWl7R+oCknHJh7WwanqiIXy/Mnj2fc5v8anqG+J7VUspaxv1ER+ZLBZGUYTgMLINniS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNmRi1eH; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2776846eec.0
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776618260; x=1777223060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mUhl+edUoBWXUMxF/sQgsZhHZE1YE75i6Jn1QoeaBM8=;
        b=NNmRi1eHgEdiANQIzI+XZ5ampofS1nwBD0hd+HsHac0R7v2CoxnZ2bi5cxeYBfJ9Xb
         x2dYCXaB7WxNXYz7yxzxmRLNTvbjSANF/ZcBpDmYhu/lVfvG0S2YtEhsaP34JBDDbZ5V
         0WuK4mm6hXwHkaOJYByxB9ZWwi2+2lSetlXdDvep6IJIKnKLoKjUKFnKbcGMFqjC+RnS
         6izh//x45TDTf3P0m5MACYIYk3HvdDp4Bz+kYRJt6j83LZdmWYDZRh1CLZvXMAnAbjIL
         i+0aVeTexydCDulgdcElqbj3VofTvOVLqj4Wf4zjeukcNEvIY6cePNkAoyp6wxE4WGny
         A7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776618260; x=1777223060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUhl+edUoBWXUMxF/sQgsZhHZE1YE75i6Jn1QoeaBM8=;
        b=dGiEXChR4iqYq8VRO5C0B8881Zgp+eVRIjGeTGKHk2IkE5etGobM8I0lp1ZoSMXHyT
         un70N+AnLfJojcD+w8jKH8vzyPf7db0LgQwYi+N4T5hf7ri5t3wD1wHW1hhUO3qIY7x5
         FKG2zmKWm96kF/eHpVN+GZV8Gz2+tPWj8QuakcNN+7k7k4iWT5YWAHb7lKS+IC1VFtAI
         JY6kS9fAtmQm+oQJ0iMyYjXiglEDzybAErwYU83qdOMqtjTpMil8NZpgvP2xCFw3s6hR
         zFIVPuvBw1h0JU8rEEWvZY9erGe6IwJCDUdGWW6KEyV8uvc3hmwHm6++Vv6BT+RqaoCn
         qVww==
X-Forwarded-Encrypted: i=1; AFNElJ/5Q1wy6GFf0GbssgA6mizMt/XkQW7PZcwy78Lz97z4T5MjEuDXtm9YwYwurMzOl2z7Xh8iqTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ya3Lb3dCK2FhhByu0g6FQGwabVhBvBoS8A1Fi3SbWWKnxqMM
	/b4Nf6IJqx7qNPUshfcsAUKtug35G4lf398v83z1M86IRhZbkwU2FHEY
X-Gm-Gg: AeBDievfNUM1sWz62gO4G6T4j2ItNcrfm+Ad7oW1ONeDFOn0XJaoc6g1FF9wBMZTLMv
	5xxW7XK7qNUiqKLT7kYmGewG3PXeB48G0lwzQN45tTblc8+Kr10uWoAg7SpQ80bHXDC/NHb7lwZ
	rDTd+uG439sgBVQ1vwP7MPERPaNv1//X1+BserJwC3KUoa2UZuZpwEcYuONbjf4WopUPmAOAUW/
	l1oe4t7uwAsr48JkT+nPU/k3771Am21LlsYv4AiV3XNd7Eg9CQ8LXf7yPuB6BXegXc+x3zhL484
	8Y1/NJcmg5/VU5Ixb6D2GHXJziDcF62nkYQ0x7MR2JhjO7klGHXP2gUqlVsLBNlM9RYKG3/ccmj
	pZbHk+5KDin/CU3SFxyHLDbhUrg0s9E0sYiLr8CTk3BPfpCs4Yj7u6yTX47uwTCaUR4QWTOqonH
	IrnRI/BYYseGYC9JUO210jPTrHL1MHKsPLOxTfMpR70JMh/IO11ipS7+xIWcvOIKt5LRs4T/Hvd
	kkk7/SogO9jyO0+Ny0l
X-Received: by 2002:a05:7300:6413:b0:2da:a813:a60c with SMTP id 5a478bee46e88-2e4786462fdmr5212056eec.20.1776618260270;
        Sun, 19 Apr 2026 10:04:20 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d4bdaf7sm10129672eec.25.2026.04.19.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 10:04:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf] bpf: Fix NULL pointer dereference in bpf_skb_fib_lookup()
Date: Sun, 19 Apr 2026 10:01:32 -0700
Message-ID: <20260419170131.3899757-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org,asu.edu];
	TAGGED_FROM(0.00)[bounces-279603-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.960];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 03CE6424D6D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

When tot_len is not provided by the user, bpf_skb_fib_lookup()
resolves the FIB result's output device via dev_get_by_index_rcu()
to check skb forwardability and fill in mtu_result. The returned
pointer is dereferenced without a NULL check. If the device is
concurrently unregistered, dev_get_by_index_rcu() returns NULL and
is_skb_forwardable() crashes at dev->flags:

 KASAN: null-ptr-deref in range
  [0x00000000000000b0-0x00000000000000b7]
 Call Trace:
  is_skb_forwardable (include/linux/netdevice.h:4365)
  bpf_skb_fib_lookup (net/core/filter.c:6446)
  bpf_prog_test_run_skb (net/bpf/test_run.c)
  __sys_bpf (kernel/bpf/syscall.c)

Add the missing NULL check, returning -ENODEV to be consistent
with how bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() handle
the same condition.

Fixes: e1850ea9bd9e ("bpf: bpf_fib_lookup return MTU value as output when looked up")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb0..3e56b567bd18 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6450,6 +6450,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 		 * against MTU of FIB lookup resulting net_device
 		 */
 		dev = dev_get_by_index_rcu(net, params->ifindex);
+		if (!dev)
+			return -ENODEV;
 		if (!is_skb_forwardable(dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 
-- 
2.43.0


