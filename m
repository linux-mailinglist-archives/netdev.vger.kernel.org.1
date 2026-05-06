Return-Path: <netdev+bounces-285019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLd7GEGg+2kZegMAu9opvQ
	(envelope-from <netdev+bounces-285019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:10:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A81FD4E012F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB41A3015E04
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12734D3BE;
	Wed,  6 May 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRxp04JE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479E34C806
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098229; cv=none; b=Us3VKFkphYFV19OdN/tr6GKE5vpOnjFP4jVS/o38s1H9qUTlIVklaAlDEeF1gxgIioGzy2nPwhA6W++hbQRr78KR3lqGKnC2SQlcZguSsX6jIbJjo3NL/4O2R0tNCCISheaRvGcvzW0EmafA29vUilUZj0X0RwMb7D+ZNXJ1SEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098229; c=relaxed/simple;
	bh=mmSwOQQ6SqZYEo7Sk0LLvpcBOoytWp/guPbzbPLSzxo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GkfvIf4S4bn1IbEmL+XJAORIIkjJxVsBGEREZQY7PENvFS49xvOYK2HPcmYMktGrR9IDDgCdmO6ckjdTpK5kVbmIK0UI0j7PjSThP5C2ldbXDwy+RUZSRYorvFP+9xvPLI4p8SRc2+NeIy5BVlrwr9Jrp37XnM12aOD6kF5NaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRxp04JE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so89085e9.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778098227; x=1778703027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p4R1eFRF2JvRGstmak2opJLn+9gi5L9zotpahfAPurE=;
        b=ZRxp04JEGnGqzJKTNAIypi6335V1t89ZThpxYiiFI8epXLThKQoFgPswgFnldkuDiP
         6xwRVdi78tTihkWCXBsgWGhXEbomtiZJ5HMQYrJ43SfQ8dzqOFVeRT7vLCsbCyF/S2YZ
         5RnYkR5SUuLe5HlVD5Ue87o1fndCtrxUS0+xLX8JRGfWC9AyI64PUk+YZM9jpl3i7RdF
         HYWp+xpRdGUgUo3shmjyEVpc4bxMNPLMSO0EensjTCLpyt2s3JyDjwXLMlDiULytG0FO
         lFS3RRq7/xumujtx10NsJijZsPWtD2D8wQe3NAG+btzhtJKUMM/gW/tIb2fqvjhcAzdC
         W0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778098227; x=1778703027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4R1eFRF2JvRGstmak2opJLn+9gi5L9zotpahfAPurE=;
        b=ECgw8Uw+Vhkh5X7ufPGB9xdEB9Sfk9QD3/rJwii9lffhl16XzDa9VC1bLuIV8+QwPp
         zC3dHhGsOcZsIBlDq100PK5kPwIo+lOffpamMcEnf+Uh98+Vp7s4oJERNEqlHr9ucjQF
         W2AuJvMy5zyuW/PC/wW6NuBN0zSApDQO42xdO/rcsxYhV2nMOTqY+K8dBAfYNB6MJ30U
         94betjdgZ0aC4OW9BzJcaKXE9U9VfVDg/wQwoNFbRCaO6/nTJiyOAGPuniragBG7IdVP
         oQsBVYfvyuFmQGfauYoZkO2kqT6yah3vyzwhVYWumHMD6LNlv88aQd6W346ZV0vui6N/
         q/Eg==
X-Gm-Message-State: AOJu0Yx30yNjmotAbGoLPf8yv59fCvqj2hwQVkQzwIgdmavrawJLvs7l
	A0hN8mhaK/wftBQ6v9cKidhuCz9qurSB5YSd0UhqFH97ZA9xOuv/JdRgJ+GZl7lq80o5mGObU73
	nSPEvH+5m3AiDoFNyAA==
X-Received: from wmng10.prod.google.com ([2002:a05:600c:308a:b0:485:3a2f:2f7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d18:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48e51f46dcfmr78527745e9.28.1778098226619;
 Wed, 06 May 2026 13:10:26 -0700 (PDT)
Date: Wed, 06 May 2026 20:07:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIWf+2kC/3XMQQ6DIBCF4auYWZcGEDV21Xs0LqgMSKJgBmvaG
 O5e6r7L/yXvOyAheUxwqw4g3H3yMZSQlwrGSQeHzJvSILlsecMVcxjmJTlGuL0oMIGNaXWnjFI cymkltP59go+h9OTTFulz+rv4rX+pXTDBeF/b+qn7jmt7dzG6Ga9jXGDIOX8BbtX5za0AAAA=
X-Change-Id: 20260504-genlmsg-return-1e5d6a74d440
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3249; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=mmSwOQQ6SqZYEo7Sk0LLvpcBOoytWp/guPbzbPLSzxo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+6AsnzGehC8YXvYAW+I7udAe01e55U0yn1tsq
 UGTRLOIYYGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafugLAAKCRAEWL7uWMY5
 RqkpD/48sXj7f7tTHJ5H4aoeNaLQqiVUZVKlrJuR75rK0/HxjJdY7eDzvaGxL2gor+gvgJ2P57C
 +DwbEn2lP+s9J/4dWYrEz81bpZXQOnnnmk3nvmJ4wM3Hdp67UNLtcBL4LNHetSerf/9gFrSZOV7
 tt2nlVaNbvRLDcrkf7ciQuy4lHsq+ZrgNQ85iLUZP7lq2Kd1clHhB4We3nRIn49HudEJqY09ios
 poPFguc9vwVneedcFenqL4HIXX0f4T1+SV7GZRd5v1VK/ArH/yaHYOfCGjwNICfkHQNyMBv0Jdh
 p2YRIbpgasdXrQWAOqmwK4dXjBpVKVll4P48CR2/5aFIhLXUlDk8BxojJe4aDvORwrK4dBsT0eP
 690OOEbeymywMENqveK4xyNMvzu42+6cNI7DwBgPDCKZfzYaXHZpKcZ3873czDKojiyoiOMICod
 UE7DGT3Xfw1VMZOX8DxYOc1RrwrhcrOi82AF6//jUxkRMaSIYT6h5XXHDqRFmiDf+HixhOXX/MH
 wePfLXbXPbFbYNBN7fVJ3Ah90tnyBxsZ0LGLOL35tsTOcB/T+hpJysflYnFAWN9qQww37uyazJq
 JmxH8z0AcCSvLZmksBlOIlx2+XlVqpiUKZxjOiO4owJfkO6vl+T8VOONHOzHh2a2fSTwk2vgzBO PdxXImi6OZJfX5g==
X-Mailer: b4 0.14.3
Message-ID: <20260506-genlmsg-return-v2-1-a63ee2a055d6@google.com>
Subject: [PATCH net v2] genetlink: free the skb on 'group >= family->n_mcgrps'
From: Alice Ryhl <aliceryhl@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Matthew Maurer <mmaurer@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: A81FD4E012F
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
	TAGGED_FROM(0.00)[bounces-285019-lists,netdev=lfdr.de];
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
Fixes: 2a94fe48f32c ("genetlink: make multicast groups const, prevent abuse")
Link: https://lore.kernel.org/r/845b36ba-7b3a-41f2-acb2-b284f253e2ca@lunn.ch
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Add Fixes: tag.
- Specify target branch.
- Link to v1: https://lore.kernel.org/r/20260504-genlmsg-return-v1-1-093f3ba970af@google.com
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


