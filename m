Return-Path: <netdev+bounces-274650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cORtOCe0zmlVpgYAu9opvQ
	(envelope-from <netdev+bounces-274650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:23:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B638D0AA
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB41030B7A3F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF531D366;
	Thu,  2 Apr 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9JBRQB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B622257E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153735; cv=none; b=b15obcw1DW0adhoH6QnbtegU2XYsPIEJD/s4PaD1Md4bHwsJJl/6OlR7CXunv5IHuEIIZJvtqTLGJTOMft6VGP9Ej59CAw+ak/kkkQyJp/zKYO48Y64xlzF1/+8oJuZY1a9DfzUObLgGuTc3AguX0YxSlokISSwsx4PrfTaUICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153735; c=relaxed/simple;
	bh=+p0jlrIpfHQYR6PFWLs9ZQH5CRMURQ+HWe1k2833WHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f+BJdo2ByVI8CwC9TN83EX69LDqItJbKB5DEpxTXyKAVrgOYEGYEMyhgYdNgVyBHDXy1cZ15TMDJheS4m42sghzdLEuTvk8nVzaI2rBo/MUlAMUlB3jQSdv+h8XzCMM4Vi/HJpg3k6JTogknbP9voX8jFPCIEll7imf7L3e84dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9JBRQB9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38bd60d7a2cso10686581fa.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775153731; x=1775758531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVkipoC6GegoWGA0r2SXvtAaRBia3NsZs3/rWxB/gjc=;
        b=h9JBRQB98VQwfEViEC0TMEOwI7U7Ul7t/lh8uhz0k2tnt+yMPiHUvTRTd0fr6E0yiT
         lwxAc3C8uLz7VyLXSkcaj7wdetfcjil7gVVKmphnPOQ7PhGDh6iulFWnFG6KUEW2XIMT
         CevVDBxdekTztPvHPATdXjcTe/96UwKMne+mmf5yXkPgTdyIn6C+D8kV0fTRNJA2gAGL
         PxSMpup6stWA45nn8CjMlYeLqKSIqVs1hMMYq2OIfnvl8qVWfaVxaB8LPyaJ9m2P6Vvl
         2T6Di1xGQCMMoTiywxZvsvExjPQoLv/XtN+qn8uZBDMeWmIWhrhBw3QLwLUktY9JKWSy
         Ft9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153731; x=1775758531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVkipoC6GegoWGA0r2SXvtAaRBia3NsZs3/rWxB/gjc=;
        b=W+MYPGtEyeCq9XFS8MSXDkAoDE5Qlj/awW6Gz4VwUvbMvU4qj3UXnKbEBhPeskBy/4
         peq4moCSII4LyveV+u51zjwzOhAEw62CK3hjUVB66GKVsHvseG3mMkkCseR+tiank6LC
         e7mM6v4LjSD1YHblHcdEBsIXR679hTW6/aH153HzVgM9WP5ytKwRsElgjRYJyjFdwa94
         KBasZaMsBumgsuFzjwPMW2uj6Br+4cB4B9+07SErGUEcLwtRUlD2bqAdxbWQd9mnyDE0
         viqA0DP5C+9ggb3deWKmfawLpmxGaa8h9bS92bsSw9p5+6YJhMA75HwOT8+CzaqP4PdA
         YnLw==
X-Gm-Message-State: AOJu0Yx3fJZT7QAqZxQjhi+vccgi8JdaA1QBU1cu05vn31srCW+7++3d
	6o6JQj2IwkRu03nKWpRLESGLxWqJhIY7XsJN9kdQVFb0W1swEG8hYyjtUkVbgZqG
X-Gm-Gg: AeBDieuW8aj4H4GsDbCgyQNvWoJOpD2wH7E/VlV4YvuRcg2Ih7SazljPl+N8LqMvkJ5
	h4T2RTw2mq1WKfEy/zAsGwak7ob1V68kff1OcLo5VDDrsJmrkgLkvZVZWgL2KdfF2l27RfJAY8o
	CL922ZXTndC0yqYrOd2cIu40TZ86/zynEUIavevmH9Q2b+XaWsylo1jOgeaiXb0JnaH1fgmOJBf
	jsYVtesEW4AluTTFfu7T332HJWyZq/cT4iSCeX13UmoejpqlR0Dm3cyOZFPFiWL3IJLLUR0VM8N
	q7gTp1AqnWG7pMiWGWlEhdGLUoU5Pqv/TDWlYivk0hrAshXGMM7Y7i+ZjsQaWBbinrtEUIl2ehw
	7BI+0lqsZ4YtectzA9340grbg3z4Csz6ow5yyTi8mbVHVsHLtBWPxLbv3r3w9puD0kP3BV6LqXe
	nHXdizZrDK0ZDm667s32M06tImYWGJ9hiEaE/XqveyfbHl3IOL/+m57Kt8p4EVnsBPLHQ+W4tOn
	T/LQzMCFsz50hHRbgURK+OIjw==
X-Received: by 2002:a05:651c:1993:b0:38c:c32e:5b2c with SMTP id 38308e7fff4ca-38cc32e5c1amr32704981fa.19.1775153731133;
        Thu, 02 Apr 2026 11:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:4656:5488:0:30b9:b7de:e563:b0cb])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd212a6a1sm7513181fa.30.2026.04.02.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:15:30 -0700 (PDT)
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	nickgarlis@gmail.com,
	kuniyu@google.com
Subject: [PATCH v5] rtnetlink: add missing netlink_ns_capable() check for peer netns
Date: Thu,  2 Apr 2026 20:14:32 +0200
Message-Id: <20260402181432.4126920-1-nickgarlis@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274650-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nickgarlis@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F1B638D0AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
network namespace when creating paired devices (veth, vxcan,
netkit). This allows an unprivileged user with a user namespace
to create interfaces in arbitrary network namespaces, including
init_net.

Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
namespace before allowing device creation to proceed.

Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon device creation.")
Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
---
v5:
  - Rework rtnl_get_peer_net() to explicitly handle early
    exit for clarity (suggested by Jakub Kicinski)
v4:
  - Use IS_ERR_OR_NULL instead of IS_ERR + null check.
v3:
  - Move netlink_ns_capable() check from rtnl_newlink() into
    rtnl_get_peer_net(), after the last rtnl_link_get_net_ifla(tb)
    call. The tbp path is already covered by rtnl_link_get_net_capable()
    in the caller. (suggested by Kuniyuki)
  - Pass skb to rtnl_get_peer_net() for the capability check.
  - Add IS_ERR() check on rtnl_link_get_net_ifla(tb) return value.
v2:
  - Removed "Reported-by" tag
  - Fixed "Fixes" tag with the help of Kuniyuki Iwashima (thanks !)

 net/core/rtnetlink.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fae8034efbf..69daba3ddaf 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3894,28 +3894,42 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	goto out;
 }
 
-static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
+static struct net *rtnl_get_peer_net(struct sk_buff *skb,
+				     const struct rtnl_link_ops *ops,
 				     struct nlattr *tbp[],
 				     struct nlattr *data[],
 				     struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[IFLA_MAX + 1];
+	struct nlattr *tb[IFLA_MAX + 1], **attrs;
+	struct net *net;
 	int err;
 
-	if (!data || !data[ops->peer_type])
-		return rtnl_link_get_net_ifla(tbp);
-
-	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
-	if (err < 0)
-		return ERR_PTR(err);
-
-	if (ops->validate) {
-		err = ops->validate(tb, NULL, extack);
+	if (!data || !data[ops->peer_type]) {
+		attrs = tbp;
+	} else {
+		err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
 		if (err < 0)
 			return ERR_PTR(err);
+
+		if (ops->validate) {
+			err = ops->validate(tb, NULL, extack);
+			if (err < 0)
+				return ERR_PTR(err);
+		}
+
+		attrs = tb;
 	}
 
-	return rtnl_link_get_net_ifla(tb);
+	net = rtnl_link_get_net_ifla(attrs);
+	if (IS_ERR_OR_NULL(net))
+		return net;
+
+	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
+		put_net(net);
+		return ERR_PTR(-EPERM);
+	}
+
+	return net;
 }
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -4054,7 +4068,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		if (ops->peer_type) {
-			peer_net = rtnl_get_peer_net(ops, tb, data, extack);
+			peer_net = rtnl_get_peer_net(skb, ops, tb, data, extack);
 			if (IS_ERR(peer_net)) {
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
-- 
2.34.1


