Return-Path: <netdev+bounces-283762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHqwGSdk+GlJtgIAu9opvQ
	(envelope-from <netdev+bounces-283762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:17:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2BF4BAD26
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B609D3019F05
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAA376BCD;
	Mon,  4 May 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q57bTu6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A437646A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886239; cv=none; b=Y5OJ0001r+jOTs9MJj+imoRGLNWTKFhAmTiuTyPSHPJmTFvmhOHgdF36yOAfYf0eoFDeI71Xog0z+/LR9ItXBjCgkS+xaycl09iTUH2t/Mvj7EHrikucdhtRq8Q43AQCrjZBO9+fkErP5egLqxdguLc6HvByoCsFKkFZZWM/I3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886239; c=relaxed/simple;
	bh=tPJwSubo7swPdL1tDy2pu7P+QRqOoQO0CNehoGjX6yc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=urBp4JJBZ5og+9iIWmm8r0/LhaQoynhhuR4aB7MIpkqb/af4QNFmsSG1ejJh0rqZLFC5PwQTk2+aNIcs15kKMKXFPzP4yCEzwy5MInHssOENnHdHKgUF6AtQ45Y5G/3LO9fAT5zIOApkvGCHS7yiAX3/wY6WEC+x8B28LHGpt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q57bTu6g; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so30644135e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777886237; x=1778491037; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mIVbu4zBUMdiyUWRLQfWQg/Ct4AM38Hnd9zW9DC/RU4=;
        b=q57bTu6g3tzyhCBKqLO8wKf5UTyqWpFnAJO0oRbCmAIX4H+cnTg/CDi6Ou1XPg8BL4
         02Uff1hgogTVo03spQI07FEr91Obkb+qiJ0Z2spnotgEx+WxG/xEQ3Gm4gQfpXmSF9eC
         lN/2hcRzCv9fiFlMogXG0zR0kenDkQVWzoIRzj+/nVVo300QNElvxrQG6327jh6M3EGG
         bcqxU2uH++zRJ7fB/VRglbJKy2nlOJ41nHwMRsprqqb0dtLDnAt+P+F5AQiy9zUJbVVJ
         GfMoCMCSuz2S08/wAEw/bKt+MCDa1wPQpXu+R89l+Lfwh/Jo/gjI9MNhU3ZFv4tbovb2
         LAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886237; x=1778491037;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIVbu4zBUMdiyUWRLQfWQg/Ct4AM38Hnd9zW9DC/RU4=;
        b=cB/tRvfBQTj2ii2Z2ZpaCHU+pZgcDj1vQri0l2X3u92nppYi9xLZ3/Hm7NXxQW9XzS
         5ZDE/y3GSYX9JTDHfLwyB+FS4nd/a6bwB2nfB88w9OfDgOBCuJCWOxJma39jafwLAT19
         7mD+bym0qFH3Gy3FV9mP3ElyV10ymENJ5uxIwuEmTLB4GSvrU4wLvq5mf4MYmsUupD5o
         W9hsiQpU0qdCWebfDz2bO1EP8fAkUDE1QSqfbggfFu9lV+lMqIN9d7diK0e+s/HqpOXh
         /qV5MGzdcl0cfR9eryAvG/AQhxtmMpgVvt8o5VR5s8A9H4BQ8vIMCaZxmh6FqhTPwbLq
         urJw==
X-Gm-Message-State: AOJu0YzpdzmNUQD4jmPa3WOzmpT6KKCDPF+Gn1Nb1ad+rijjouxATaPj
	h66HzhcnxFP0+Yyw/mx5SzlU77b4PO1N71yKvuJInli4hHlROvjkvJ+krFPEcjJUJeUiyuScXq3
	0Qh6RwxDRTsxHV1qj9A==
X-Received: from wmbjn2.prod.google.com ([2002:a05:600c:6b02:b0:485:3a2f:2f7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a290:b0:48a:568f:ae82 with SMTP id 5b1f17b1804b1-48d0562f139mr44332075e9.10.1777886236636;
 Mon, 04 May 2026 02:17:16 -0700 (PDT)
Date: Mon, 04 May 2026 09:17:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABRk+GkC/x3MQQqAIBBA0avIrBNUzKCrRAvJyQbKYqwIpLsnL
 d/i/wIZmTBDLwow3pRpTxW6ETAtPkWUFKrBKONUq6yMmNYtR8l4XpykxjY439lgrYIaHYwzPf9 wGN/3A/of6q1gAAAA
X-Change-Id: 20260504-genlmsg-return-1e5d6a74d440
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=tPJwSubo7swPdL1tDy2pu7P+QRqOoQO0CNehoGjX6yc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+GQXTiHJ3lFBiGx4rlwWKqMXAYPezSJ7zrKBw
 jztIO1S+BSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafhkFwAKCRAEWL7uWMY5
 RvVbEACWIpEKA9SpIsMESYtO92MddRkzibjthYQHhobHw/WQXnNOnfZ1C5SEK18rwwjWgl6wquT
 a44mrj10phEPMm3SUUJsJb7W1H3wvlF2zUMQySKzVG4R6iSyujE+9Bl7bSu3+QMLPx5L70gtEK8
 gJv3ldwnbhc57oXpqP2vgDn1jazjJFVqHktEResX4IM+q8F7Efy5OegIEmR17ElZMr4kHG0I259
 UOPYNzBLyao35og+xMv5AQKjFCLWYkJXnJYJFdl1OAiQB+U6t37CNBLO0JTMFw/HEM/askzF7gB
 NkrUs3EV2nmyV2fgDIWsD6B1xGZw+ETOu37wDfTKAvXyjkyit6SDLp9dLwrMVMfFXGtcKP3EmXK
 pUVKTPxmVjewPz0BqcjH86sJbC2ReGy/WgYA5AgVUeMPAtFet8ISA93zyWRF3+/cNWO0j0q4UpJ
 JxaFYMXZ17PWsPihs3woS0NrCjAxGj1lJGae4AXgwFaOK94yAJKJ+yyycyVVsNwwQc47bilZ2mY
 oK+dkAFWiAD0Ms3nZalKWiGi3aLrnXwT6d4so+1vbrbNe6RQLDRXH2d+BcHqKGKoEtCm+HlJyzW
 c3oPoOP6bWB9KExvk6gk5nRNDYZ2QdkqOTTKPUtRUR5BibyXT7qK6NLTA1KuE6FKlRZic7fbvSz Nh7OMw/a9Z2vLrw==
X-Mailer: b4 0.14.3
Message-ID: <20260504-genlmsg-return-v1-1-093f3ba970af@google.com>
Subject: [PATCH] genetlink: free the skb on 'group >= family->n_mcgrps'
From: Alice Ryhl <aliceryhl@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Matthew Maurer <mmaurer@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: CA2BF4BAD26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]

These methods generally consume ownership of the provided skb, so even
if an error path is encountered, the skb is freed. This is because the
very first thing they do after some initial setup is to unconditionally
consume the skb via consume_skb(skb). Any subsequent errors lead to the
core netlink layer freeing the skb.

However, there is one check that occurs before ownership is passed,
which is the check for the group index. So if this error condition is
encountered, then the skb is leaked. This error condition is generally
considered a violation of the netlink API, so it's not expected to occur
under normal circumstances. For the same reason, no callers check for
this error condition, and no callers need to be adjusted. However, we
should still follow the same ownership semantics of the rest of the
function. Thus, free the skb in this codepath.

Assisted-by: Antigravity:gemini
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: Matthew Maurer <mmaurer@google.com>
Link: https://lore.kernel.org/r/845b36ba-7b3a-41f2-acb2-b284f253e2ca@lunn.ch
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/net/genetlink.h | 4 +++-
 net/netlink/genetlink.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 7b84f2cef8b1..d70510ac31ab 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -489,8 +489,10 @@ genlmsg_multicast_netns_filtered(const struct genl_family *family,
 				 netlink_filter_fn filter,
 				 void *filter_data)
 {
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+	if (WARN_ON_ONCE(group >= family->n_mcgrps)) {
+		nlmsg_free(skb);
 		return -EINVAL;
+	}
 	group = family->mcgrp_offset + group;
 	return nlmsg_multicast_filtered(net->genl_sock, skb, portid, group,
 					flags, filter, filter_data);
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index d251d894afd4..0da39eaed255 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1972,8 +1972,10 @@ int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
 			    unsigned int group)
 {
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+	if (WARN_ON_ONCE(group >= family->n_mcgrps)) {
+		kfree_skb(skb);
 		return -EINVAL;
+	}
 
 	group = family->mcgrp_offset + group;
 	return genlmsg_mcast(skb, portid, group);
@@ -1986,8 +1988,10 @@ void genl_notify(const struct genl_family *family, struct sk_buff *skb,
 	struct net *net = genl_info_net(info);
 	struct sock *sk = net->genl_sock;
 
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+	if (WARN_ON_ONCE(group >= family->n_mcgrps)) {
+		kfree_skb(skb);
 		return;
+	}
 
 	group = family->mcgrp_offset + group;
 	nlmsg_notify(sk, skb, info->snd_portid, group,

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260504-genlmsg-return-1e5d6a74d440

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


