Return-Path: <netdev+bounces-278322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Lb8IdXw3WmMlQkAu9opvQ
	(envelope-from <netdev+bounces-278322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:46:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 098173F6B7A
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED983021E73
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6F38228C;
	Tue, 14 Apr 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cztyEdwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B637E2F4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776152765; cv=none; b=QhxuW88Kd8RlkI41t4OzZlG2xV6v6/Qme2ecPraB6VNwS78MdsgGHm9XmjCiUcczn+DPUOvs90kc5/AtI69Fkpx3kZuEBX5/rMchOFKVwmtb515zdwQ8NoXx4KP6wOA1tzFbjiCd6u42KoMzogCnaK0/ZZFU1irI7xbG18WZiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776152765; c=relaxed/simple;
	bh=DfB0mirF1DEkQjuoNptFwzK6i/M1Tn12oXTw9xXN1to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTtYNttMMGjH/XA1i+JwM9zkls0YZvbSbJcMTWeFXcv+99qaV9MnJauNbh2RcvXu4yi3mdEp+I9fopQXOxC1EM0cFRnl53IG82MH3TM48RC8l/foH3hU2i3BH7/tDQHaRYXdrn9Q0L/tOvc7Kc99LT9Ztm/GwWiJA4jCShKqRpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cztyEdwS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b458ca2296so14695445ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776152764; x=1776757564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBkAfCIQelOdIl4mYrxfodBgX+TU3tBvysXFS7GqOZs=;
        b=cztyEdwSWAMqhLeokF4PROuM52kLFXgeJfdy/Uyjp8HZETZ/v6yEhOXywatbVHod3N
         OGednMgtSNqxl5lmQNpadxh4THgQQoTcD1sw8jQxbk3dyAt0xRXpId9/1otcsRPzMhVB
         NBhn1hle5XZtN9bbIVtRGd0g9TYdvOqAhzN7mBTRYaIpxiBeva7YgUnW4ZQO7WF+tdQO
         3ztyGuTAa0TobtJLZ6/O07UNLDXGo3TCoqdAf1Fpeza8jb/JSUX/MN21NjPf7ELOQylX
         DSj2DH6oW4uqbqcwqeCS2eERRItUzWE1brPzsP/zF8tKvm2njXRN8lRQKzmuoeOe6Ryi
         EhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776152764; x=1776757564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBkAfCIQelOdIl4mYrxfodBgX+TU3tBvysXFS7GqOZs=;
        b=gtcHbdZ8BpRw7BEHv6K+1WEF/v1WFxySLsbSIzAwIxSJ7pioGiR62AEl06t3VOhX/R
         tXPHaw/w0l4t+Eit4hVw5e7b95/XBFI7JYfugslaOvNnMKb4XA9kygmY4PWVzDfX+0th
         ZuS5Zhiibx4WD5frsTjdFsoTPTXz01F2DgX8VNuZj4bsf9K2lxUGXCuZ8lQx1ltSXc1s
         JXGIbsPy6bMnHTBjIkXBmp4jszLjyBphjH/uja6JJIgv0H+EIUbPhsYqlUtoFJWrAcJD
         OeNbCvAti4LfWy+QI9tCdxtYHThXLUTFD61sQKz6s46tBMUPJ+Oc3LlqfEITj4XQ+/gW
         O3PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xpcn+0Wr47rOwRKUM3zTTNZJz++Ux+Ujlp1H7p0A+UPxQ7dbILRURjik0qNmhdqUSsdViMIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLfO0xuyyBKxnDnFd+LJ/wV14os0LYSZxf40tUGH76OcHX8PzX
	PmDCg2+KTgWoF12DjhnauuFqzW3Ci41osrXtXLXhDju6t+t1Py6iMeKQ4UMmFBThWXjaVw==
X-Gm-Gg: AeBDieveep1+p8P6WuDKC6nr2o88xmf5eti/OE70d8FpWL6Wx8/LKyhPNTDzFZ8kKhw
	n80OFRIfSlGlXRjn3VhMS33zmHw3VwNvkLe1XE58+KVaN+nRv5BMtafY54+mZgz4aL9pkJBTKB1
	7bhuWRDrCKjxQq1jjTYUVMyA+JfMQ0twHdzeCFD3ZHYIncdR2hgwWp+E3pVfXloScKWgQ6hZVW1
	+vg1F6n6YYrRI1kQPseOSCjLugmVKhrQyGjCLTqLyj8ITnx/2a27H1k9yZpKSAjgFo472AUQ97r
	DsM+LZtIOz4AxTa2ZCY1DA4w64UsxDrohDVUMudJ71wzkvCQLy/x2WIqRNa6sxOKq/1D0choqPY
	bwZzHW9SgogbyDTeQ413v3A+pwHf4P8YexsS5N1oAFV039hxAA2YgIkLIZVDkq2q9RFWM7nVozz
	ojuLvUF/tD6xT+DL5NRtrzLb8e38BNbHUx
X-Received: by 2002:a17:903:3d07:b0:2b0:ac1e:9737 with SMTP id d9443c01a7336-2b2d597d19fmr168198035ad.12.1776152763875;
        Tue, 14 Apr 2026 00:46:03 -0700 (PDT)
Received: from localhost.localdomain ([180.167.178.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2eae817fcsm97892455ad.44.2026.04.14.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 00:46:03 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: pablo@netfilter.org
Cc: "Kito Xu (veritas501)" <hxzene@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: nfnetlink_osf: fix null-ptr-deref in nf_osf_ttl
Date: Tue, 14 Apr 2026 15:45:56 +0800
Message-ID: <20260414074556.2512750-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,riseup.net,vger.kernel.org,netfilter.org];
	TAGGED_FROM(0.00)[bounces-278322-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hxzene@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 098173F6B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nf_osf_ttl() calls __in_dev_get_rcu(skb->dev) and passes the result
to in_dev_for_each_ifa_rcu() without checking for NULL. When the
receiving device has no IPv4 configuration (ip_ptr is NULL),
__in_dev_get_rcu() returns NULL and in_dev_for_each_ifa_rcu()
dereferences it unconditionally, causing a kernel crash.

This can happen when a packet arrives on a device that has had its
IPv4 configuration removed (e.g., MTU set below IPV4_MIN_MTU causing
inetdev_destroy) or on a device that was never assigned an IPv4
address, while an xt_osf or nft_osf rule with TTL_LESS mode is
active and the packet TTL exceeds the fingerprint TTL.

Add a NULL check for in_dev before the iteration. When in_dev is
NULL, return 0 (no match) since source-address locality cannot be
determined without IPv4 addresses on the device.

KASAN: null-ptr-deref in range
 [0x0000000000000010-0x0000000000000017]
RIP: 0010:nf_osf_match_one+0x204/0xa70
Call Trace:
 <IRQ>
 nf_osf_match+0x2f8/0x780
 xt_osf_match_packet+0x11c/0x1f0
 ipt_do_table+0x7fe/0x12b0
 nf_hook_slow+0xac/0x1e0
 ip_rcv+0x123/0x370
 __netif_receive_skb_one_core+0x166/0x1b0
 process_backlog+0x197/0x590
 __napi_poll+0xa1/0x540
 net_rx_action+0x401/0xd80
 handle_softirqs+0x19f/0x610
 </IRQ>

Fixes: a218dc82f0b5 ("netfilter: nft_osf: Add ttl option support")
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/netfilter/nfnetlink_osf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index d64ce21c7b55..85dbd47dbbd4 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -43,6 +43,9 @@ static inline int nf_osf_ttl(const struct sk_buff *skb,
 	else if (ip->ttl <= f_ttl)
 		return 1;
 
+	if (!in_dev)
+		return 0;
+
 	in_dev_for_each_ifa_rcu(ifa, in_dev) {
 		if (inet_ifa_match(ip->saddr, ifa)) {
 			ret = (ip->ttl == f_ttl);
-- 
2.43.0


