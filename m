Return-Path: <netdev+bounces-253407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPkCM7Q7d2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:02:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D30865E5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCD3F3021719
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282A032E692;
	Mon, 26 Jan 2026 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dgpwF2po"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11432AAD0;
	Mon, 26 Jan 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421640; cv=none; b=RKqG7Hda1kj2vrhtnZNYpgU6EOIscb0V/UQ9z7kAo6M/mdOxWEorztPZl4smjPlKXQ6Tgu+gQeCXNaEq0Ivo1HP+jREhtWtevYGDotmt3KAzC/x/Cdx2MrDWe603s8gjRLZKniuJE/gyVbhTmxkAjLOWsGblnITJ8hr8G8m4ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421640; c=relaxed/simple;
	bh=Wt1rwo/nec9IpGLwGdaQ+T7BDTQMUQSo633PVUPIh1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+jNXRcRGocypPGjeeaxVdXw1Gyqn7wvG7hM+oYuVHk81zuZHidutLKM43vlbS4ZnQ7RTrItlZBSH0EdN6XIHi/Brv6wQ8gRjYwc2U6U5E+Lz3uz63PCdg08Zh/y2OYdjU+S34H0bK9W9WdBvfzua9wZrM+n5sNJYYb26QkzL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dgpwF2po; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=FfRxM4H11A6s0iRMiMwGmk8muiPnvWkFmoTAesES2BU=; b=dgpwF2poLLIicVlsvLlGXPfITg
	Eg7hvxjBWQvQD4zZmmh8mCWkkoGmdp2FIcQhroXv2qKCTtkCsTtDNxdfpfWYF35F1trbiVgnUA7hn
	97aSIFDwAOmXqMkMOxV2A0Mo8Ghe5dRGEmeuQWiqwNjPgh6zR+bpmj59yYAuT/+L26r9wH+8Slg97
	JxA1CVAd6Hw7gOnPyz9qMIAL0jNb5LRRaie/E+12/QxMzA6Z/oFi2uEz7KI1ggVVYorsScZWpOJXL
	UzOtb2/fypGwsSGsGhVdWrL/K8GPGyjOZ8FbJjcLM4pPkYH+dbjurgs8livvbWSC5R78SNiDWR5uB
	4YPSkU7Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkJOU-00G5vB-I1; Mon, 26 Jan 2026 10:00:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 02:00:15 -0800
Subject: [PATCH net-next] ethtool: remove ETHTOOL_GRXRINGS fallback through
 get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-grxring_final-v1-1-0981cb24512e@debian.org>
X-B4-Tracking: v=1; b=H4sIAC87d2kC/yXM0QqCMBQG4FcZ/7WDOclirxIhOo/rRJzibMVAf
 PfQrj/4VmRSpoxgVih9OfNLEEzbGMT7KIkszwgG3vnetb63SauypGFhGZ+WvOumyzmeZtehMXg
 rLVyP7wqhYoVqwe0v+TM9KJa9w7b9ALfh8sZ7AAAA
X-Change-ID: 20260126-grxring_final-e203b87c5d03
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=leitao@debian.org;
 h=from:subject:message-id; bh=Wt1rwo/nec9IpGLwGdaQ+T7BDTQMUQSo633PVUPIh1w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpdzs2HcyWZqYREQZNdJ2gniMveBQ4pbtbwDhh/
 h858GnFrz6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXc7NgAKCRA1o5Of/Hh3
 bdaJEACTbf0zbV5+IalAOX025wwpoVvr4QvjPK7mc1o3y6DMNmQHo70acMli4grK/B1XF5lM8P7
 l4cQu/ATjq0rn3ggKhPSyE09b8R//5qxc6Knj/FNyt2lOROz70uniTPqHhOPRqO+HYSgcxM3a0V
 rnDM7bOXPxc9hLoFXjTBAQwhBngn/RnRu1iX4Iwrn16ByP6dVWfmvL+XqFXPyHUXf/V6tXWWTk/
 XYIsaTDA+31egEUxzbqpRmpyQJ8T9fvm2ZNINkzK3k4Nm8qYMz32GcILehYftBGn7bHRBB/DKLU
 otiVPTj6BmxSgrIaCC79wYtIYOw8sYIfuACW+BT9P2UR8HzRTv2dlJ/QRsPk7YWN3TDzHEdlnx5
 4szWCoC98+b6EYO+vr3rmHdZHB1wjt5NLYujKiGihzPT1/jFyr4933W9QzuyCfQbiAHX+w3yHA/
 kC0c9OfKwsawsfWtVOUUq54u5warFFFmGYgK8Q0dE1iJY6YemyQKbTbrO5V3JmwSxeJUqeeWLOZ
 i0TPA39/2Zbv8p2O/SwTv+SrRZPQyNZqxK0RGmhbxVxdQgGS4DQcDw9XZ53AOalMWfJC54RkE2v
 z1F+Kuzd++EoDmwKKm6lacJbpHJCjY3j9wJkifOc2Vj0LPqP8PBcmokqi7IgR2H8IHhMaLkK/FT
 AiB6tsf3Eg9ygVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253407-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37D30865E5
X-Rspamd-Action: no action

All drivers that need to report the RX ring count now implement the
get_rx_ring_count callback directly. Remove the legacy fallback path
that obtained this information by calling get_rxnfc with ETHTOOL_GRXRINGS.

This simplifies the code and makes get_rx_ring_count the only way
to retrieve the RX ring count.

Note: ethtool_get_rx_ring_count() returns int to allow returning
-EOPNOTSUPP, while the callback returns u32. The implicit conversion
is safe since RX ring counts will not exceed INT_MAX while we are still
alive.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/common.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4036561b078b5..c5ed88bccbb41 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -637,21 +637,11 @@ int __ethtool_get_link(struct net_device *dev)
 int ethtool_get_rx_ring_count(struct net_device *dev)
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
-	struct ethtool_rxnfc rx_rings = {};
-	int ret;
-
-	if (ops->get_rx_ring_count)
-		return ops->get_rx_ring_count(dev);
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret < 0)
-		return ret;
-
-	return rx_rings.data;
+	return ops->get_rx_ring_count(dev);
 }
 
 static int ethtool_get_rxnfc_rule_count(struct net_device *dev)

---
base-commit: bf2e36c9dab95e41516fbcf7b1cc804539b2d021
change-id: 20260126-grxring_final-e203b87c5d03

Best regards,
--  
Breno Leitao <leitao@debian.org>


