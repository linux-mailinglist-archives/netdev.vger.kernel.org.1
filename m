Return-Path: <netdev+bounces-253625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIQrBaT+d2lqnAEAu9opvQ
	(envelope-from <netdev+bounces-253625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:54:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1908E564
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C5F3022951
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B231196F;
	Mon, 26 Jan 2026 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmXlgaur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112E309EF5
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471635; cv=none; b=UzY53qFsXIpA73wg4Jz0+vqp5XWYxgpxrqmq8ixIUI7zEH5WkyXQaPCuq0rciokydeodqB3Qm4rjAx3rNGTi3dtv5P4Gi/CcST62izuGY8zg7aWQH8MhpQvhWqdzkWJ6aFkUao5M2hPABPse6nFh3zZVE+91mM3C4/xgZ8iIO48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471635; c=relaxed/simple;
	bh=Qik1ozjqSZ/s/skBi6PKBAxE22b0dCz+aDh6JJNlO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/QEwjEzC4Usdc/9bv/bUaytAC5uR2K8yisf0y+Djn56Z3pfWCJSApavBniUNbbhufT/TXVpwkUae6R/T7aWrLhh9EOC55ReUKLbUXobBsowzngT9jAYrk93ec0boSQbVwOqsC32et6lA8kFKJ4Uu1iHcTjROZ3ywURIh903iy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmXlgaur; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so28859185e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769471632; x=1770076432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk9Fb92hOdGZyZJu9bD0s2WE9JX2jwnrDPcvrJsJU0E=;
        b=jmXlgaurfI9Tc6j6217Y4PtYItGsOkYd2fzGy9ndTbZ1LiQdo+MMpC+NMDz6zwOb0R
         CgvArj0zyshPaQOtARJJl8ATHQFw5MuQEE0eYxyAwZJHCsrsSuBQy/oBSzZO+eBcL01s
         UrFht3H35ZMv97KvDRCpdAaANCJtkNmj8AdHU39PCxjtnpYoR0z2lVW9UmAN8c2BqVDp
         d/cgOMVg27PLizoTL24vZ0qmlP5KTOptKza8oqn21+RQdj7XHL4Odcbt79SDSPbh/AQb
         HrAnf2CxDNX2SkDqs5QLrpWtQ+TWcRbrtZWu/Nx+p4CLqgs/wbDPVSYLzOA8TtV0pVsR
         E9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471632; x=1770076432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pk9Fb92hOdGZyZJu9bD0s2WE9JX2jwnrDPcvrJsJU0E=;
        b=EDHvPB7W3JrUMNII1IuWti1oxprFnXPxUB6A+kC9PQ4/TQl1H9s+3ttWroxGi+gMSh
         Tls/5DJQt9UuLn4F1KtG6jtkke1E4dhHBk4bggmPkgbfXM/hAHKGU047zKJ3YswScjfs
         ajBvWG2d18ak6H0oBlo5qeSqJqpWH4qohQjdsBzYDD5dMNI2gWBbMk7PxLSzj+iIoI+c
         eWi2G8DreAIbfCAUVC/NkBRUFUpLBrvgVRx8ix8aNm/nwIxgYgHeCJZ6hh8Mf0BwSKUx
         olydszle6VJVLTHn61ujgQQ9uYzfmZeDnFDknQf0o+Z4qoMFcK2r/jKNXdm+OwAFM3qH
         9/qA==
X-Gm-Message-State: AOJu0Yx4K+vQGRJXGbSFe8ojoUFa9RLo4cTPM1BbPhU3ioOorUz4yNo1
	VsoEdCvkzlB0ei4fLKqToJ1TXyxIWtokSzCPDBmLMt/KshQYWg4DJU5F
X-Gm-Gg: AZuq6aL/O7V71zHcfDDR4pKx1CBjQhF54MkWQFTSnJT+PdT7dnR2fIADb6Wk4KONK8R
	yhIu1yQxAqxdNmgXZ/ue0JKnLmq1B5wMpdP2mDK4mXYNi7GI1e1T0q+j0jjB0AJSaCOmCJ0STM+
	c0WIoRhYhofBdkN1K2MqAR3sKxN40YsYb+fKKX4J/wL3q9SHV8VHLOeOiedS7fvr83UORZf2oFS
	ejd8oODHgYDKcqxpYg4FMwbIs6QVC7N9yuTLZUEYGHR3fc2qeLOX8LlYCzswRYtiBtwaW3zfCj1
	ilcf5Vhyr26XSRGNjBcf3lU9iIWDT43XmgrkBACcu3WZctMKYsTprSUNeFhjD7Ex0MXVtflwT4H
	bC3Fibt/eI+AqqjmawELHt//B2dHXgOou/4BS8oxxlcRAJ2cOvYmjzKQ5+NUg7w3WtmQtgkrRCu
	vdqv5r+Fo3Ku1cn4ZtWiI5rY3mVxGQX7FHnJf5GYeSlrE1MkOcdMHZjbbTRHMcs6E4LHSEk7SCG
	JNER2SCxj1sLNdEIZqBaYCXXsbkI5E2ryFtOfLREEDc7wKg/FYT6d3whUUv
X-Received: by 2002:a05:600c:468f:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-4805cd407d7mr92703915e9.3.1769471632060;
        Mon, 26 Jan 2026 15:53:52 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066be7404sm22658615e9.1.2026.01.26.15.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:53:51 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net v2 1/4] arp: discard invalid sha addr (b/mcast ARP poison)
Date: Tue, 27 Jan 2026 00:53:02 +0100
Message-ID: <64dc9e3a6a815929bfdf3ccf591a1418a0a5959d.1769464405.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1769464405.git.marcdevel@gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.93 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-253625-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C1908E564
X-Rspamd-Action: no action

Prior to this commit, the ARP implementation accepted ARP req/replies
with multicast (including broadcast) and null MAC addresses as Sender
HW Address (SHA), and updated the ARP cache for that neighbour.
Broadcast, multicast and null MAC addresses shall never be associated
with a unicast or a multicast IPv4 address (see RFC1812, section 3.3.2).

ARP poisioning with a broadcast MAC address and certain multicast
addresses, especially when poisoning a Gateway IP, have some undesired
implications compared to an ARP poisioning with a regular MAC (see
Note1).

Worth mentioning that if an attacker is able to ARP poison in
a L2 segment, that in itself is probably a bigger security threat
(Man-in-middle etc., see Note2).

However, since these MACs should never be announced as SHA,
discard/drop ARPs with SHA={b/mcast, null}, which prevents the
broadcast/multicast ARP poisoning vector.

Note1:

After a successful broadcast/multicast ARP poisioning attack:

1. Unicast packets and refresh ("targeted") ARPs sent to or via
   the poisioned IP (e.g. the default GW) are flooded by
   bridges/switches. That is in absence of other security controls.

   Hardware swiches generally have rate-limits to prevent/mitigate
   broadcast storms, since ARPs are usually answered by the CPU.
   Legit unicast packets could be dropped (perf. degradation).

   Most modern NICs implement some form of L2 MAC filtering to early
   discard irrelevant packets. In contrast to an ARP poisoning
   attack with any other MAC, both unicast and ARP ("targeted")
   refresh packets are passed up to the Kernel networking stack
   (for all hosts in the L2 segment).

2. A single forged ARP packet (e.g. for the Gateway IP) can produce
   up to N "targeted" (to broadcast) ARPs, where N is the number of
   hosts in the L2 segment that have an ARP entry for that IP
   (e.g. GW), and some more traffic, since the real host will answer
   to targeted refresh ARPs with their (real) reply.

   This is a relatively low amount of traffic compared to 1).

3. An attacker could use this form of ARP poisoning to discover
   all hosts in a L2 segment in a very short period of time with
   one or few packets.

   By poisoning e.g. the default GW (likely multiple times, to
   avoid races with real gARPs from the GW), all hosts will eventually
   issue refresh "targeted" ARPs for the GW IP with the broadcast MAC
   address as destination. These packets will be flooded in the L2
   segment, revealing the presence of hosts to the attacker.

   For comparison:
     * Passive ARP monitoring: also stealthy, but can take a long
       time or not be possible at all in switches, as most refresh
       ARPs are targeted.
     * ARP req flooding: requires swiping the entire subnet. Noisy
       and easy to detect.
     * ICMP/L4 port scans: similar to the above.

4. In the unlikely case that hosts were to run with
   `/proc/sys/net/ipv4/conf/*/arp_accept=1` (unsafe, and disabled
   by default), poisoning with the broadcast MAC could be used to
   create significantly more broadcast traffic (low-volume
   amplification attack).

   An attacker could send M fake gARP with a number of IP addresses,
   where M is `/proc/sys/net/ipv4/neigh/*/gc_thresh3` (1024 by
   default). This would result in M x R ARPs, where R is the number
   of hosts in L2 segment with `arp_accept=1`, and likely other
   (real) ARP replies coming from the attacked host. This starts to
   get really relevant when R > 512, which is possible in large LANs
   but not very common.

Note2:

However, broadcast ARP poisoning might be subtle and difficult to
spot. These ARP packets appear on the surface as regular broadcast
ARP requests (unless ARP hdr is inspected), traffic continues to
flow uninterrupted (unless broadcast rate-limit in switches kick-in)
and, the next refresh ARP reply (from the GW) or any (valid) gARP
from the GW, will restore the original MAC in the ARP table, making
the traffic flow normally again.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 net/ipv4/arp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index c8c3e1713c0e..7dbb3fd5cc8a 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -800,6 +800,14 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto out_free_skb;
 
 /*
+ *	For Ethernet devices, Multicast/Broadcast and zero MAC addresses should
+ *	never be announced and accepted as sender HW address (RFC1812, 3.3.2).
+ *	Prevents Broadcast/Mcast ARP poisoning attack.
+ */
+	if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(sha))
+		goto out_free_skb;
+
+ /*
  *     Special case: We must set Frame Relay source Q.922 address
  */
 	if (dev_type == ARPHRD_DLCI)
-- 
2.47.3


