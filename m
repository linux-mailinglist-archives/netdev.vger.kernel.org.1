Return-Path: <netdev+bounces-275839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEi8Fsxr1GletwcAu9opvQ
	(envelope-from <netdev+bounces-275839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:28:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64533A9079
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 351463040183
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C3351C04;
	Tue,  7 Apr 2026 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="mlw6llIe"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.baidu.com (jpmx.baidu.com [119.63.196.201])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3E0E7238178;
	Tue,  7 Apr 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.63.196.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528876; cv=none; b=ZSF5MS+LgkaHugRtlBOlPXaCJ8cvnNJQIDoua8lxh3zZRPhVkeO9m1bRWx4n24bnqtBK3ICd8LUB77oB9jI8gFoCAInsKnIGDZ9K4ZwzRg3AiDBmy/k/lrFdk+ijolDLIqXgej3JfJaObDiSwd/KjkZh5BDzwPJngwA+yqKUaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528876; c=relaxed/simple;
	bh=W/xxQQVyTbtVD25wXMT+RCdTuEaBRAJrbFb2CKhUJQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUhnPKCBNa144EoSVO8H+mLKIo7y9SN8iutDqoPqMgnKeJV0Mp3vBoN5gedYTykdfGq/KhOTkeZIMzamQqw73m88Y82AT2rwjwdTXNJmvkndV1dw2tGF3e613uD5OWcf5uXS1EOvVM2d3N8Z6YNYb7Mi3npQFNKotalYGQyj5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=mlw6llIe; arc=none smtp.client-ip=119.63.196.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mateusz
 Polchlopek <mateusz.polchlopek@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] devlink: Fix incorrect skb socket family dumping
Date: Mon, 6 Apr 2026 22:27:30 -0400
Message-ID: <20260407022730.2393-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1775528861;
	bh=rMxAsSE1T2ENZfR5RXIKLUTCSrJJ56L2NjvuWxizi08=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=mlw6llIekOJTsGnqPBdavbTKtLp8BZIzuRiiwho+ELKucp3wFQryBTiZxQmTfxH41
	 z+qlnXLD3BrZZvBmeLoVnPaTx3JVNF+mEE82Rn8n6HuxfBjbyaQIF3JHchXXljwll9
	 i6VtEas+EQQquMRwooJF512XlFBLBXpWc3jjhEZoXsf1jc+gsT+EbK73q9hWA78wTf
	 BuK+ejC2EwyJemfiD4QvvezN2Rn3ntIwQ14bj6i7jb9yOFaSgG06k8MQ3q5raTCp9d
	 kgke95emH1our0obrJWtRWXv7lXDY/ZFnmyenEZ9rELaR+kweW0G8DvGQJCXM3RVxD
	 QzHq6Y2SiEycQ==
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[baidu.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baidu.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baidu.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A64533A9079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

The devlink_fmsg_dump_skb function was incorrectly using the socket
type (sk->sk_type) instead of the socket family (sk->sk_family)
when filling the "family" field in the fast message dump.

This patch fixes this to properly display the socket family.

Fixes: 3dbfde7f6bc7b8 ("devlink: add devlink_fmsg_dump_skb() function")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 449c761..ea7a334 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1327,7 +1327,7 @@ void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb)
 	if (sk) {
 		devlink_fmsg_pair_nest_start(fmsg, "sk");
 		devlink_fmsg_obj_nest_start(fmsg);
-		devlink_fmsg_put(fmsg, "family", sk->sk_type);
+		devlink_fmsg_put(fmsg, "family", sk->sk_family);
 		devlink_fmsg_put(fmsg, "type", sk->sk_type);
 		devlink_fmsg_put(fmsg, "proto", sk->sk_protocol);
 		devlink_fmsg_obj_nest_end(fmsg);
-- 
2.9.4


