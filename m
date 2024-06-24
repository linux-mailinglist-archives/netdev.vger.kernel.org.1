Return-Path: <netdev+bounces-106093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4829148C1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F53B213AA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781F13D2B7;
	Mon, 24 Jun 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GsVbH52M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ABB13D244
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228620; cv=none; b=IxWTvmzk919hRwkQtynOwqOGuqVX98pru8jvS4MilxqzJeKvhEqFByeN8H4uEvFRZ4QOOImvDtoSG6sXunF4vY1IPws3S42hvZBDre2cHif9s+NQ4CBpOQe75/s78yG8ATi+BdRncFO4+Xvgo1U3fAiSmyB9y1mZ3gMaomj540g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228620; c=relaxed/simple;
	bh=SzevxJHY0Vo29UKXzlMcmJ9vn/owAaRrUYPNv6ZabPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afcTUK4EGhO/nswYqUGpjTw9oBPJoGmMrZygUNxcKY+NKThZhImMy97qyc1l5evy/19HqzdTssqr37HTzrhVO9d4kCqr8wLSXHizYZC8jmkpf0VxlYZHK2JQKitij9xAwxHLWRuv50JE6nZruWQdYwuNrF5SJtr1+KPZSWYgqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GsVbH52M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42138eadf64so35604335e9.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228613; x=1719833413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okeqkCwch/8MlgUy1ZY6HowD1xemZua8EyPOduO8S1c=;
        b=GsVbH52M3v2AeiysRGVMD1DIkXKUOJ6qw5H+pKBv+XyzKmsR9W3xw3FLr4OTRVjO/E
         gpW4HKqou3Xbko6MiPUsDFFvi2pneYKCetf68lr8gTz3Yaj8mpRYP+hkyM84WQc4ial4
         5p+Bx8OCN2UewfKh6Jt9bXZzk5ChPq4zRGpNAiL8dnbWivTJ/XP7pGXRTK67ox50wYGJ
         WmDDZz+oFtBvH5bgkB72L4/+hj32emvptayo5HaUR5IWAt6arbxkdhYz7cjsvVZhdcGW
         ki2LLXFwQsrC1XJ+HGwi537C0Z7Kv68pSM5VE1WTqd3sqqVzhJWK9CgwOnkjkrbEL7EZ
         Rerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228613; x=1719833413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okeqkCwch/8MlgUy1ZY6HowD1xemZua8EyPOduO8S1c=;
        b=YNwIv4M6Xy2ueTz8DB3Ps5jQ7WYpxA244Yp6769+CSAW398T8ZT+pszyP+3ciWhIn0
         NGmfkwcVBAydtRFAAw53j5mRU7Cho377DmIv/5CZsWeaTf6Uf7RpCbQbP81kaU/HTaWg
         S2cDEh7SS6rz2y8BIxJ3vhEMrKoIu1IkxnOncsO5R4fYfnFcyaAHCy3QSoDCHBj9cMrw
         S8Yv114Vk+KjZYja+IaEKiYtAYkQS7B0W4JATbzkx6SIsfofx2v3D/zt1qa9cI2boBQx
         BYjq4h3Tkf9JVHY1X3dqWH2Ia5Rhgzia3fWu4LZJdhXZi0wXwBhWOcfRc5JPc0X9A1ub
         MEIg==
X-Gm-Message-State: AOJu0YzlH0lrlO818N0D4c22TWBKIYnDSEYIuHEOXnxso9FTBH+rtikJ
	iXwVQB334wBQcs5WRdoUhB2ROwYxcLk/6S2o5P039uNJfOTZF/Dj5eguhPDRc3hs2sUoTkody2V
	B
X-Google-Smtp-Source: AGHT+IENCiYLluHTH4ef3CWnAGyOkOWA4LWZ1CWYhfbhn+X8HH1y7uxOGJcpsY4xxiBMwMVygXcfVg==
X-Received: by 2002:a05:600c:1d23:b0:424:760d:75cb with SMTP id 5b1f17b1804b1-4248cc18217mr30783555e9.6.1719228612943;
        Mon, 24 Jun 2024 04:30:12 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:12 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 21/25] ovpn: implement key add/del/swap via netlink
Date: Mon, 24 Jun 2024 13:31:18 +0200
Message-ID: <20240624113122.12732-22-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces the netlink commands needed to add, delete and
swap keys for a specific peer.

Userspace is expected to use these commands to create, destroy and
rotate session keys for a specific peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 Documentation/netlink/specs/ovpn.yaml |   2 +-
 drivers/net/ovpn/netlink-gen.c        |   2 +-
 drivers/net/ovpn/netlink.c            | 199 +++++++++++++++++++++++++-
 3 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
index 68ed88d03732..21c89f0bdcbb 100644
--- a/Documentation/netlink/specs/ovpn.yaml
+++ b/Documentation/netlink/specs/ovpn.yaml
@@ -153,7 +153,7 @@ attribute-sets:
           decryption
         type: u32
         checks:
-          max: 2
+          max: 7
       -
         name: cipher-alg
         type: u32
diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c
index 594eb2c50eb5..f7c4c448b263 100644
--- a/drivers/net/ovpn/netlink-gen.c
+++ b/drivers/net/ovpn/netlink-gen.c
@@ -23,7 +23,7 @@ static const struct netlink_range_validation ovpn_a_peer_local_port_range = {
 /* Common nested types */
 const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] = {
 	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
-	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 2),
+	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 7),
 	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
 	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
 	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 8e2b303ac7ac..2e238197d7bc 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -638,19 +638,212 @@ int ovpn_nl_del_peer_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
+			       enum ovpn_cipher_alg cipher,
+			       struct ovpn_key_direction *dir)
+{
+	struct nlattr *attrs[OVPN_A_KEYDIR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYDIR_MAX, key,
+			       ovpn_keydir_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	switch (cipher) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		if (NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_KEYDIR_CIPHER_KEY) ||
+		    NL_REQ_ATTR_CHECK(info->extack, key, attrs,
+				      OVPN_A_KEYDIR_NONCE_TAIL))
+			return -EINVAL;
+
+		dir->cipher_key = nla_data(attrs[OVPN_A_KEYDIR_CIPHER_KEY]);
+		dir->cipher_key_size = nla_len(attrs[OVPN_A_KEYDIR_CIPHER_KEY]);
+
+		/* These algorithms require a 96bit nonce,
+		 * Construct it by combining 4-bytes packet id and
+		 * 8-bytes nonce-tail from userspace
+		 */
+		dir->nonce_tail = nla_data(attrs[OVPN_A_KEYDIR_NONCE_TAIL]);
+		dir->nonce_tail_size = nla_len(attrs[OVPN_A_KEYDIR_NONCE_TAIL]);
+		break;
+	default:
+		NL_SET_ERR_MSG_MOD(info->extack, "unsupported cipher");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int ovpn_nl_set_key_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *p_attrs[OVPN_A_PEER_MAX + 1];
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer_key_reset pkr;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(p_attrs, OVPN_A_PEER_MAX,
+			       info->attrs[OVPN_A_PEER], ovpn_peer_nl_policy,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       p_attrs[OVPN_A_PEER_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_KEY_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_CIPHER_ALG) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_ENCRYPT_DIR) ||
+	    NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_DECRYPT_DIR))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(p_attrs[OVPN_A_PEER_ID]);
+	pkr.slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
+	pkr.key.key_id = nla_get_u16(attrs[OVPN_A_KEYCONF_KEY_ID]);
+	pkr.key.cipher_alg = nla_get_u16(attrs[OVPN_A_KEYCONF_CIPHER_ALG]);
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_ENCRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.encrypt);
+	if (ret < 0)
+		return ret;
+
+	ret = ovpn_nl_get_key_dir(info, attrs[OVPN_A_KEYCONF_DECRYPT_DIR],
+				  pkr.key.cipher_alg, &pkr.key.decrypt);
+	if (ret < 0)
+		return ret;
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to set key for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ret = ovpn_crypto_state_reset(&peer->crypto, &pkr);
+	if (ret < 0) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot install new key for peer %u",
+				       peer_id);
+		goto out;
+	}
+
+	netdev_dbg(ovpn->dev, "%s: new key installed (id=%u) for peer %u\n",
+		   __func__, pkr.key.key_id, peer_id);
+out:
+	ovpn_peer_put(peer);
+	return ret;
 }
 
 int ovpn_nl_swap_keys_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to swap keys for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ovpn_crypto_key_slots_swap(&peer->crypto);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *p_attrs[OVPN_A_PEER_MAX + 1];
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(p_attrs, OVPN_A_PEER_MAX,
+			       info->attrs[OVPN_A_PEER], ovpn_peer_nl_policy,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_ID) ||
+	    NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], p_attrs,
+			      OVPN_A_PEER_KEYCONF))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_KEYCONF_MAX,
+			       p_attrs[OVPN_A_PEER_KEYCONF],
+			       ovpn_keyconf_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, p_attrs[OVPN_A_PEER_KEYCONF], attrs,
+			      OVPN_A_KEYCONF_SLOT))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(p_attrs[OVPN_A_PEER_ID]);
+	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "no peer with id %u to delete key for",
+				       peer_id);
+		return -ENOENT;
+	}
+
+	ovpn_crypto_key_slot_delete(&peer->crypto, slot);
+	ovpn_peer_put(peer);
+
+	return 0;
 }
 
 /**
-- 
2.44.2


