Return-Path: <netdev+bounces-77145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808378704ED
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA679B258BD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2BA4D13B;
	Mon,  4 Mar 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bPAJKjnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B164D137
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564967; cv=none; b=FzIKESpYquoKuY1NKprvhyqxHWPmawJYZdxg1xBsEXl/nc7PDhHt6hclmkJByAIFfgumjhXL9InQMf9MeVX27KvwiMfIyey9SK2DDHeBGnsiZA5vZTj/5ORPjO7VeO5gHNHmnlVO6R5SvtBbqotPzUPMEFRqJnVh/tTzGfbQLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564967; c=relaxed/simple;
	bh=oTzaJbguxiBuEIEqqYl6G9rsJGO/S2JNwtj/GnjwIoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2YWMeSPYh9ECuKBcWcuqQPLWcA5quwREVMNM/wObbr+pepSqxTMqHal3Oj1fRVOfFVxqGo8bAT1piiAi9jNHtQQvQ09P537fIZAN8VDyZkVRIOyf8f5zKvsLW0HdcKFMxWUOiBGEYmHeplQFxT7fdzLDX6vpNC7987phFpfp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bPAJKjnq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3566c0309fso587642866b.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564963; x=1710169763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlV6CUN9svmW2N1GR/BXSqgPTqrBtLw0QlxvCRc0LXc=;
        b=bPAJKjnqUltq0uRkyQd958Qh2jRZZoD9qCrilstRB24Um/g/1zjIkGO6CwjhRry2ci
         /XQ9yeWIZkuNNSEPd4nsDVtmHIUiBAZnNb8vS39pFKPnRaWgl/PWQ9jokFsRY+dNh6Lz
         xqylpO9dJIMXgNqoYGJnlJiQefwW7DwbdxhFpjwQ0frYl7pR8hpZzLWcYh7uuUEBY7QA
         c70Ea236aSNZGeChZVf1OwDHgDNEMf2PiT6Lvgd4IPqYHxD4K8xF01+u9OlnGHcld6dG
         3RyK8Vf+0D1Lbas2kaRxK5D3+1XnjQLtVCtkS+rLG/sJxNdlHmQhVDkc/ljoOPccDTai
         vDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564963; x=1710169763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlV6CUN9svmW2N1GR/BXSqgPTqrBtLw0QlxvCRc0LXc=;
        b=Na/osgT73FeoSfU8danROw+wPIANZLrnQv44Hon9hKuF6esV5hY3zay4GG3fzA/te0
         hIPhRjMPsRTpX1oPCOajiHXvzBR+Imp1cZ+fgqWFPrsTRHcmZvBuH6EieyJX4DKOYV7V
         AAo2Ca0ZdarHUduWdsmegR5GaUFTDejjg8Wg/cVv+HiKtuGSYfCCq9JEgxBKXcRaoRDQ
         nQnEABN9rGRpCYRE7CnvW6ygOP0gCs3ArrhzafUXPaiby80xDi3NErJXv17ogw5XWdkK
         v2OYNHxg5YH5ai7IHrihYTrfPb/wxnUi+/xM3iEOZeROszqPOuvP5jzJ5Qt0XJVWWjRh
         H3gg==
X-Gm-Message-State: AOJu0Yyd3UP1TD8pkMVYByabv65gK5o+gNLCKALaRvAUxYmUzemK7sgz
	Kxt0QmkBNqEbUlYvG0kKywYnJak1fL+sqpMq2v69Rm4q1miTufiQLW2cm7VN2yrww/mYrTaI0nh
	u
X-Google-Smtp-Source: AGHT+IFA53NuZF2OmMcRmr1LeXsCNtgdok8xuWgBZvT6reJup+uXWIlpDNAEfIlxjgoo/Ao22bZGrw==
X-Received: by 2002:a17:906:a88d:b0:a44:c573:f56f with SMTP id ha13-20020a170906a88d00b00a44c573f56fmr4672447ejb.9.1709564963414;
        Mon, 04 Mar 2024 07:09:23 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:23 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 19/22] ovpn: implement key add/del/swap via netlink
Date: Mon,  4 Mar 2024 16:09:10 +0100
Message-ID: <20240304150914.11444-20-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces the nelink commands needed to add, delete and
swap keys for a specific peer.

Userspace is expected to use these commands to create, destroy and
rotate session keys for a specific peer.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 194 +++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 99ee9889241d..dbe1dfddba4c 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -611,6 +611,185 @@ static int ovpn_nl_del_peer(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+static int ovpn_nl_get_key_dir(struct genl_info *info, struct nlattr *key,
+				    enum ovpn_cipher_alg cipher,
+				    struct ovpn_key_direction *dir)
+{
+	struct nlattr *attr, *attrs[NUM_OVPN_A_KEYDIR];
+	int ret;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_KEYDIR - 1, key, NULL, info->extack);
+	if (ret)
+		return ret;
+
+	switch (cipher) {
+	case OVPN_CIPHER_ALG_AES_GCM:
+	case OVPN_CIPHER_ALG_CHACHA20_POLY1305:
+		attr = attrs[OVPN_A_KEYDIR_CIPHER_KEY];
+		if (!attr)
+			return -EINVAL;
+
+		dir->cipher_key = nla_data(attr);
+		dir->cipher_key_size = nla_len(attr);
+
+		attr = attrs[OVPN_A_KEYDIR_NONCE_TAIL];
+		/* These algorithms require a 96bit nonce,
+		 * Construct it by combining 4-bytes packet id and
+		 * 8-bytes nonce-tail from userspace
+		 */
+		if (!attr)
+			return -EINVAL;
+
+		dir->nonce_tail = nla_data(attr);
+		dir->nonce_tail_size = nla_len(attr);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ovpn_nl_set_key(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *p_attrs[NUM_OVPN_A_PEER];
+	struct nlattr *attrs[NUM_OVPN_A_KEYCONF];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer_key_reset pkr;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (!info->attrs[OVPN_A_PEER])
+		return -EINVAL;
+
+	ret = nla_parse_nested(p_attrs, NUM_OVPN_A_PEER - 1, info->attrs[OVPN_A_PEER],
+			       NULL, info->extack);
+	if (ret)
+		return ret;
+
+	if (!p_attrs[OVPN_A_PEER_ID] || !p_attrs[OVPN_A_PEER_KEYCONF])
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_KEYCONF - 1, p_attrs[OVPN_A_PEER_KEYCONF],
+			       NULL, info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[OVPN_A_KEYCONF_SLOT] ||
+	    !attrs[OVPN_A_KEYCONF_KEY_ID] ||
+	    !attrs[OVPN_A_KEYCONF_CIPHER_ALG] ||
+	    !attrs[OVPN_A_KEYCONF_ENCRYPT_DIR] ||
+	    !attrs[OVPN_A_KEYCONF_DECRYPT_DIR])
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
+	peer = ovpn_peer_lookup_id(ovpn, peer_id);
+	if (!peer) {
+		netdev_dbg(ovpn->dev, "%s: no peer with id %u to set key for\n", __func__, peer_id);
+		return -ENOENT;
+	}
+
+	mutex_lock(&peer->crypto.mutex);
+	ret = ovpn_crypto_state_reset(&peer->crypto, &pkr);
+	if (ret < 0) {
+		netdev_dbg(ovpn->dev, "%s: cannot install new key for peer %u\n", __func__,
+			   peer_id);
+		goto unlock;
+	}
+
+	netdev_dbg(ovpn->dev, "%s: new key installed (id=%u) for peer %u\n", __func__,
+		   pkr.key.key_id, peer_id);
+unlock:
+	mutex_unlock(&peer->crypto.mutex);
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+static int ovpn_nl_del_key(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *p_attrs[NUM_OVPN_A_PEER];
+	struct nlattr *attrs[NUM_OVPN_A_KEYCONF];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	enum ovpn_key_slot slot;
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (!info->attrs[OVPN_A_PEER])
+		return -EINVAL;
+
+	ret = nla_parse_nested(p_attrs, NUM_OVPN_A_PEER - 1, info->attrs[OVPN_A_PEER],
+			       NULL, info->extack);
+
+	if (!p_attrs[OVPN_A_PEER_ID] || !p_attrs[OVPN_A_PEER_KEYCONF])
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_KEYCONF - 1, p_attrs[OVPN_A_PEER_KEYCONF],
+			       NULL, info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[OVPN_A_KEYCONF_SLOT])
+		return -EINVAL;
+
+	peer_id = nla_get_u32(p_attrs[OVPN_A_PEER_ID]);
+	slot = nla_get_u8(attrs[OVPN_A_KEYCONF_SLOT]);
+
+	peer = ovpn_peer_lookup_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	ovpn_crypto_key_slot_delete(&peer->crypto, slot);
+	ovpn_peer_put(peer);
+
+	return 0;
+}
+
+static int ovpn_nl_swap_keys(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *attrs[NUM_OVPN_A_PEER];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (!info->attrs[OVPN_A_PEER])
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_PEER - 1, info->attrs[OVPN_A_PEER],
+			       NULL, info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[OVPN_A_PEER_ID])
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
+	peer = ovpn_peer_lookup_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	ovpn_crypto_key_slots_swap(&peer->crypto);
+	ovpn_peer_put(peer);
+
+	return 0;
+}
 
 static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
 {
@@ -679,6 +858,21 @@ static const struct genl_small_ops ovpn_nl_ops[] = {
 		.doit = ovpn_nl_get_peer,
 		.dumpit = ovpn_nl_dump_peers,
 	},
+	{
+		.cmd = OVPN_CMD_SET_KEY,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_set_key,
+	},
+	{
+		.cmd = OVPN_CMD_DEL_KEY,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_del_key,
+	},
+	{
+		.cmd = OVPN_CMD_SWAP_KEYS,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_swap_keys,
+	},
 };
 
 static struct genl_family ovpn_nl_family __ro_after_init = {
-- 
2.43.0


