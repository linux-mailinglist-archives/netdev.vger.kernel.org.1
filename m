Return-Path: <netdev+bounces-199816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EDAE1EB5
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C19B4C2790
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC92E8E07;
	Fri, 20 Jun 2025 15:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765D2D662C;
	Fri, 20 Jun 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433318; cv=none; b=B1vqydtuosWiEdHnxfqkwQc0dkVdRfU4KWm993HOEgRRx8XEaIhOznXvS8B5s/SUPDYqtQEabccXaPLLYW8ii0KQxGbVpAPQzdluvqRN5y4FtG6ijWGBsCjwryTqtFUML2qkPJWna2AkzMK/hFLqYLzS8Iuvg1BQ3WObNAFNrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433318; c=relaxed/simple;
	bh=/OSx8K3K9f23Ji1lCrXseDYUHiUlLiZTgManhWt2jPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G0Zk+7sbSq5HsO3wFnAIXx0c61yxFMLImqSCr7pnZof8K/w20cA8EUe2ZoPFUHfXFOLR7rixetxlFaTsgVLaBQb8YCL5tuxN5tD1MLREoFEChhlaFlsmmcm72o/cB0ozLgKUu0zspbUf5gQBkdyiwq/8oFg3BtnqL96PtmNTY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A3C9744EF1;
	Fri, 20 Jun 2025 17:28:26 +0200 (CEST)
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ipv6: enable per-interface forwarding
Date: Fri, 20 Jun 2025 17:28:13 +0200
Message-Id: <20250620152813.1617783-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is currently impossible to enable ipv6 forwarding on a per-interface
basis like in ipv4. To enable forwarding on an ipv6 interface we need to
enable it on all interfaces and disable it on the other interfaces using
a netfilter rule. This is especially cumbersome if you have lots of
interface and only want to enable forwarding on a few. According to the
sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
for all interfaces, while the interface-specific
`net.ipv6.conf.<interface>.forwarding` configures the interface
Host/Router configuration.

This patch modifies the forwarding logic to check both the global
forwarding flag AND the per-interface forwarding flag. Packets are
forwarded if either the global setting (conf.all.forwarding) OR the
interface-specific setting (conf.<interface>.forwarding) is enabled.
This allows enabling forwarding on individual interfaces without
setting the global option.

This change won't allow a `Router`-state interface without forwarding
capabilities anymore, but (with my limited knowledge) I don't think that
should be a problem?

This is quite an impacting change, so I don't really expect this to get
merged. I'm more interested in hearing your feedback and if something
like this would even be considered?

[0]: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 net/ipv6/ip6_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db..a7e33ab0946c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -509,7 +509,8 @@ int ip6_forward(struct sk_buff *skb)
 	u32 mtu;
 
 	idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
-	if (READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
+	if ((idev && READ_ONCE(idev->cnf.forwarding) == 0) &&
+	    READ_ONCE(net->ipv6.devconf_all->forwarding) == 0)
 		goto error;
 
 	if (skb->pkt_type != PACKET_HOST)
-- 
2.39.5



