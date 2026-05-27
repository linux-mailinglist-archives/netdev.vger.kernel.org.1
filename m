Return-Path: <netdev+bounces-292126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBoaMHmYFmq1ngcAu9opvQ
	(envelope-from <netdev+bounces-292126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C29E5E03AD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB7D3300644A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAD03B8D7E;
	Wed, 27 May 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlQQSk7J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829FF3B7B8B
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865714; cv=none; b=cjqtNPeRhX38jJJ79vYNuZWyNjem6n1yeNHOX5dl2OhktUxl48T/d+2FKK4M9B50XekFh0tWlD+GIsfRbU7PlOdBlDCgVHBmAxg3CpbPtHknt1frb12DISnrX0YWkT8BmS/5pt7BaxCrnFNRg+mYBVamqjZaJ/QP1gfUkxRcQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865714; c=relaxed/simple;
	bh=nF3n2ThfGpO8RdPGXZ/I2wq7DrqFcx0MWM75XEXcINc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmLY+JZ/C4YRxpweVoaiAxEDq+K2skDviXmyTZJyCKtlHC5Pv0h74cPmVrjpU20DzeGVo+lDH6/HDY3pbscyhvZTg+/oYTKt22fCiXCwGPKCTuyJyejOAc9dEH+g5igAEraTlGZHFePIYbvyIwwiP9y5F8xNb/fQ9adSdErnZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlQQSk7J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2babfd18435so51185675ad.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779865711; x=1780470511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1HoGkmmVirBZLUAZ5b16k6gJacJNZCaTPEXJ7dkR0Y=;
        b=XlQQSk7JALkddYkKlN7MVRnwQXE4NCbT1CMlyJCm1NBPIApP42EGxn7X+35mpmMVX6
         tuAxtZk3mS4wKielM3t8lAJN5oeBHlCxAaV3pEp0XjfBGZSifybXnSVrVnJ1dscSsElN
         013ko/2rl0G75IYMZ+FNaabA4/wobu4lWTwtsCym6ooUzQFua0BIVc8TNudC4J0LnbhL
         7hc3LDJ7/avXJzd7AlwT4rTJn/Apd/U24LWh4G4YjAxayoGjhHuCFuEC1io5jhiECU4S
         xhGB76I/jIq8iHF5hxFaDuAB+BFKjcy5ZY5nkkGxVlUTQHwizHStRDULK3zcLLUmQQmM
         NLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779865711; x=1780470511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1HoGkmmVirBZLUAZ5b16k6gJacJNZCaTPEXJ7dkR0Y=;
        b=DvBvASCdv1wpWppe8ZVrbM4VRAU3swaYrJ4Y7ijx6nNdj5HRfVFySo0QiZH5ZDlWJE
         K5F2775aPiIMEkGaZgrr3hyluCcxcFZ2cE1YMnSGP7p/xilTwzbl5j+DZoEiSWXj7xAB
         aNvaggloQ9OHz/NMOcnf/ML+CA46JxX6wbVTYB0GBRRXvuQY1+wE/XFWRsr+KdHdvQBk
         jGfGLNpX3c4QzQCsbW5+QKiPxmMH0sVxqKPaq3uFfCyrZGKdxsZ8ObKA+/y18XPGW47c
         +Vs2P9r+c96qZgXdgXZF0UzaJzC3tY5GrvKyRU5rYH2/23UzLlerOJLXmpeyCTQcBpoC
         Bnsg==
X-Forwarded-Encrypted: i=1; AFNElJ9BjzQ20arGv1GDUDlwraUTIQ8ss6JYgr81aCAUdL6rQQ/MSMpFXJpvfA5T1NW/yGTmckcNxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+K+QUZd9+hjpQ0bQPFTUs6diJZ9NZInBQVrOD7DVQ4KOEHoS
	cUiwqWWj9MXilPoTSUxPEjZGIyI5RgB1jUIbIAzaDeyERUAmIifzB7Az
X-Gm-Gg: Acq92OFhjG2pGJYKcTYj49gKe9wDcZtN8dsSUA9fLHWjBuLicL6wgpgV1bs+RFdihkr
	gWfdVaak5u6WlOe6ewuAnOxo2gi4LGgbQ/2agJ3kNUsordMUdh/UCzOqGzadZZaMUjLwpP9ldKM
	QBTBhDZb3qe7xycII52BtngFa6CPl+pEpqbZHgEEKEblMKPc+lf3aGgAi8n+YtGUzupP1q6sK+g
	wasxR9RDZ8k7vG/+SbhAs/vnM/GVhFpMaIEM1+U5UBta+JpV1mpWeEf4ULI/VpazVhWs1zi0reD
	CU6JwWxHyJ6zkoNjQj2JusaYTv4SCmgF/64yVcpHXUd4PI+KNFPa4sFixjZKme3JuG4kQWZ/mY/
	RUdWm9hiDltJU42V7rU9M9nScQVLGD6MoCR6TEi6ExS00g0LfFGwh72B47SrTHx8HRyNDhDHGPc
	J8QyFwOfOkH8Y1qojw7/+zNVBKJmEy7CIa8DZb2JudmC68Px7Q0J5Mh2xv1QQ=
X-Received: by 2002:a17:902:cec8:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2beb05b5668mr238431435ad.20.1779865710850;
        Wed, 27 May 2026 00:08:30 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b386esm149817855ad.44.2026.05.27.00.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:08:30 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] rtnetlink: Require CAP_NET_ADMIN in link netns for changelink.
Date: Wed, 27 May 2026 15:08:24 +0800
Message-Id: <20260527070824.2677331-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292126-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: 6C29E5E03AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in
vti6_changelink().") made vti6_changelink() and vti6_update()
mutate the vti6 hash of the device's creation netns. The
rtnetlink path into changelink never checks CAP_NET_ADMIN
against that netns. The only capability check on the link netns,
netlink_ns_capable() against link_net->user_ns, runs solely when
the RTM_NEWLINK message carries IFLA_LINK_NETNSID. A plain
"ip link set <name> type vti6 ..." does not carry it.

So an unprivileged user holding a migrated vti6 device can
rewrite an entry in the creation netns vti6 hash. They pick the
endpoint addresses. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") already closed the
SIOCCHGTUNNEL path. This patch closes the RTM_NEWLINK path.

Other link_types are affected too. Any type that publishes
get_link_net and whose changelink touches t->net has the same
gap: ipip, gre, sit, ip_vti, ip6_tnl, ip6_gre, xfrm_interface.

Check netlink_ns_capable(CAP_NET_ADMIN) against the device's
link netns before dispatching to rtnl_changelink(). Types
without get_link_net are unaffected. The newlink path has long
checked capability in the link netns. The changelink path never
did.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 06615bed60c1 ("net: Verify permission to link_net in newlink")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/core/rtnetlink.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index df042da422ef..ac7a3bf438d5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3969,8 +3969,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
-	if (dev)
+	if (dev) {
+		/* changelink may mutate the link's creation netns.
+		 * rtnl_link_get_net_capable() above only checked
+		 * tgt_net. When the creation netns differs, also
+		 * require CAP_NET_ADMIN there. Otherwise a migrated
+		 * device lets a caller with caps only in its current
+		 * netns mutate the creation netns.
+		 */
+		if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_net) {
+			struct net *dev_link_net;
+
+			dev_link_net = dev->rtnl_link_ops->get_link_net(dev);
+			if (!net_eq(dev_link_net, tgt_net) &&
+			    !netlink_ns_capable(skb, dev_link_net->user_ns,
+						CAP_NET_ADMIN))
+				return -EPERM;
+		}
+
 		return rtnl_changelink(skb, nlh, ops, dev, tgt_net, tbs, data, extack);
+	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
 		/* No dev found and NLM_F_CREATE not set. Requested dev does not exist,
-- 
2.34.1


