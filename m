Return-Path: <netdev+bounces-246484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E46CED06D
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 14:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D769300F584
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE5221F2F;
	Thu,  1 Jan 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b="kU4ZH4Hg"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385D19E992;
	Thu,  1 Jan 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272398; cv=none; b=cWZuFaCKpTwD7gjfpW8pt/I9uZdDImzbbARcFr/ogG0kHP2xdxDAbgdDtc4kiSKKON77NnXYdFpKeqvB4Ct4e1Aj9c21FAHOGh4KSx8dNvtL/NWCh8GEMeAYY1Ow++8YtdMOy10IRab9X4t13KBEJGsZTPGVFWkZaeIHygCX1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272398; c=relaxed/simple;
	bh=p34Cw7DqI/kE0pvho9/OjwaVKeY6olRBNr1qh70/2lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXrBFnedzh+jPofR0erg4NjjJAdbooUAeogbzwCpHwdvvyK1SyEkOvGjNUSnxitN8EzsqObJ4N6KSq6RKkpS+B78nTD+0XK4cY8NgLmiidP8JiAdSu2M+xbmCmHkd5pCdYQ7o0t4BPFhT2MU3L5HvzpAzpzisayUOEHQrgnmfSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx; spf=pass smtp.mailfrom=cve.cx; dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b=kU4ZH4Hg; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cve.cx
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id AE6EB1BD3;
	Thu,  1 Jan 2026 13:51:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767271905;
	s=20250923-2z95; d=cve.cx; i=cve@cve.cx;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=UoWT89VRnZn9G0HfoZk/cVPF8yTHcYWVbhNlbQ/LmoM=;
	b=kU4ZH4Hgj4Oz8ir5FBtZdpHFjI7Zxm3cq7pwPl1IoqieX0Pe7bI/L7HkZyWW7C0f
	QArZ/1BoThhPO0cRoZHbF0FXZ8u/uq7LVCLUS3UXw3brPRrDJOPZ6uE3Fs7i1ILz/Fl
	jTHMwhnIyB1aDrYQuCn0URM/yBFj4oZR1Sj6H7nk=
Received: by smtp.mailfence.com with ESMTPSA ; Thu, 1 Jan 2026 13:51:42 +0100 (CET)
From: Clara Engler <cve@cve.cx>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	cve@cve.cx
Subject: [PATCH] ipv4: Improve martian logs
Date: Thu,  1 Jan 2026 13:51:14 +0100
Message-ID: <20260101125114.2608-1-cve@cve.cx>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:620022785

At the current moment, the logs for martian packets are as follows:
```
martian source {DST} from {SRC}, on dev {DEV}
martian destination {DST} from {SRC}, dev {DEV}
```

These messages feel rather hard to understand in production, especially
the "martian source" one, mostly because it is grammatically ambitious
to parse which part is now the source address and which part is the
destination address.  For example, "{DST}" may there be interpreted as
the actual source address due to following the word "source", thereby
implying the actual source address to be the destination one.

Personally, I discovered this bug while toying around with TUN
interfaces and using them as a tunnel (receiving packets via a TUN
interface and sending them over a TCP stream; receiving packets from a
TCP stream and writing them to a TUN).[^1]

When these IP addresses contained local IPs (i.e. 10.0.0.0/8 in source
and destination), everything worked fine.  However, sending them to a
real routable IP address on the internet led to them being treated as a
martian packet, obviously.  Using a few sysctl(8) and iptables(8)
settings[^2] fixed it, but while debugging I found the log message
starting with "martian source" rather confusing, as I was unsure on
whether the packet that gets dropped was the packet originating from me
or the response from the endpoint, as "martian source <ROUTABLE IP>"
could also be falsely interpreted as the response packet being martian,
due to the word "source" followed by the routable IP address, implying
the source address of that packet is set to this IP, as explained above.
In the end, I had to look into the source code of the kernel on where
this error message gets generated, which is usually an indicator of
there being room for improvement with regard to this error message.

In terms of improvement, this commit changes the error messages for
martian source and martian destination packets as follows:
```
martian source (src={SRC}, dst={DST}, dev={DEV})
martian destination (src={SRC}, dst={DST}, dev={DEV})
```

These new wordings leave pretty much no room for ambiguity as all
parameters are prefixed with a respective key explaining their semantic
meaning.

See also the following thread on LKML.[^3]

[^1]: <https://backreference.org/2010/03/26/tuntap-interface-tutorial>
[^2]: sysctl net.ipv4.ip_forward=1 && \
      iptables -A INPUT -i tun0 -j ACCEPT && \
      iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
[^3]: <https://lore.kernel.org/all/aSd4Xj8rHrh-krjy@4944566b5c925f79/>

Signed-off-by: Clara Engler <cve@cve.cx>
---
 net/ipv4/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b549d6a57307..05f8c550a915 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1795,8 +1795,8 @@ static void ip_handle_martian_source(struct net_device *dev,
 		 *	RFC1812 recommendation, if source is martian,
 		 *	the only hint is MAC header.
 		 */
-		pr_warn("martian source %pI4 from %pI4, on dev %s\n",
-			&daddr, &saddr, dev->name);
+		pr_warn("martian source (src=%pI4, dst=%pI4, dev=%s)\n",
+			&saddr, &daddr, dev->name);
 		if (dev->hard_header_len && skb_mac_header_was_set(skb)) {
 			print_hex_dump(KERN_WARNING, "ll header: ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
@@ -2475,8 +2475,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	RT_CACHE_STAT_INC(in_martian_dst);
 #ifdef CONFIG_IP_ROUTE_VERBOSE
 	if (IN_DEV_LOG_MARTIANS(in_dev))
-		net_warn_ratelimited("martian destination %pI4 from %pI4, dev %s\n",
-				     &daddr, &saddr, dev->name);
+		net_warn_ratelimited("martian destination (src=%pI4, dst=%pI4, dev=%s)\n",
+				     &saddr, &daddr, dev->name);
 #endif
 	goto out;
 
-- 
2.52.0


