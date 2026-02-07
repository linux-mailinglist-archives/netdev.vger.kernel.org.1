Return-Path: <netdev+bounces-257774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN8xHsejh2lSbAQAu9opvQ
	(envelope-from <netdev+bounces-257774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:42:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD921107195
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 21:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D5D301F981
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC734F491;
	Sat,  7 Feb 2026 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui/XC0bb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBF34107F
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770496935; cv=none; b=Po+27QI5ybI/jou5xc2WAaQKnLGoDgsnZ9hFT+08bbknOSkgUzB3DoL9i14AcKPF3h7kCe6iNn+aWSXyRQZilYsU63mqq4mNlnB85budEqT9y+F1gS+8iIcyzHPak3RU/URVIl21Ls10dKD4cyxJZV7auaLpCnttbZ9mZN+Eio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770496935; c=relaxed/simple;
	bh=vw1IGUO2vGp3s9Mvgq7bh5UsvGZOFqBUB8OUYh1p58g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVVCdGeaT1wm+pZGN4/BU08kKo4K8/RgI7GUlH9ToYNi6nuLQjP7T45tIqTZ28vga1M14uJri33ojhDbTTbaarCuKNBtGF2VfDY1AEnkrVk+IA5Z7sFJ8P1IA+7Op2+euDzIfoqPXoPMj0TQdd2wHnrRXrCGzwnOvoW9p4PN0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui/XC0bb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so20459255e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770496933; x=1771101733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lESShh16uoPzY/n1F9to0YQTzmZIgAcIW7vzoW5fD24=;
        b=Ui/XC0bb94GnVMCdHRXYUHc9qBoTu22ysEN8n1IbVei6ztY0eB3QPIUoX10h7Q5hHH
         5ODA1kAm+euEJ7M6CbrLmqifANLUmtXwRCISi3xtyBTgteqVR2+DKHilglA0Uhbz83kk
         w9behJz6/1eTQoNIGQx4VqXF5++ykW1z9u1bZ+Qd7/9mc0SW5cwVeDUiMl9feZagiOeG
         3gzgp0gh/tS+AguAgk6tnu5ezHKbaYaLs8GWv6bAbelZDkF14mDBiGoMDYbrehF+UCeB
         mYsR0lYvQWlq4pcnPFvrnh1+LgL9Ilf5K/pAfKyeMFZZWv+o8NybATzhj1diPKKr/59K
         rSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770496933; x=1771101733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lESShh16uoPzY/n1F9to0YQTzmZIgAcIW7vzoW5fD24=;
        b=pTrYqnWMe+EwobnZgXo0cQ1lwux3OMN0XmhoG1upbUzYdCRZkG7TIL0YZ9qgd35T7l
         iNXQshMY9KFbY2QHAj2nSwAQ05NJaRXc+4A7o8zRdRIPVDX3ieVfgQctPj1fyvjFOH4d
         3kKqSnueRum7Vm6KZVunnLx7j3DbjU0L4trDust6wdS66Pj14Yxfwb5wb0QtUa5KHysj
         UCsfD8l/18nswDW0LGIc49PwUG+L4SmNXx9rOhPa9/hSTEBeXgZM6gtT/O8hcwHu5UFc
         pO9Zs3fY64UuftO+0HXalsYdfkdzzFtuU0+fIZSbDBvQYVy4snywDHFOGR6+T71Cogw6
         LPEQ==
X-Gm-Message-State: AOJu0YzK97Y1x550ouTAlS2s18JmUK8ZI36XW+1lB/07/zhGLXecPg3B
	1WfiPqqk0ipljSuBwrm8EftZuZWJmQB7xh4Va35UDZxlCzbGduQsOosE
X-Gm-Gg: AZuq6aKYFy5uLX1227NyBnhmAX97MaaCcwLA9g9ET16J4cVppHkV+R/756npyUXcA8I
	a51ykyM+nDi/lVwHrNl/93kafSDqrrjOulFDcGpN0PTUcW7hpaCjEhaUv0C9iKXLUkQ4LcX/n4K
	In0fT3P1+qwe3WIBHroITGBmqX+chO5C1Ud3tpHuBeRb5V03stcoaJBWvzmNwzgUB+Z+Zk3sxTb
	1QtZdbTZWo7pt5S+1N68TPWXMp5Gl6SakG5xcKWYd1XCFEu1mWeN9hljd2IInyvWwfvvp+KEI6D
	ykvsc+McjGlvWoZqCVL4pnLswvpoEdjXZ6undwRuaA9+OKR2etEpkAn+/skF4t5omHIVRHA/zBD
	iOd1KiEGnpiq7SwG+LEt/vlN/7gz2M3x5w2pgwKlXZFd3JMX40DgeU+25c28rrZxHXSaHptbFOf
	C2UwrC6LxueydSqQh+ZbdizUIcC7Aj/s2q9uDCZcJACWgzgmBHE3O80oPmBVwX6nR2kPLlYiYFs
	Jrmn1Rzf00nDrUsERQLEcx83QBUsIl0hZuIj0NBuOcOJdoH6KDol/K/W/JiUuC238ZbjCA=
X-Received: by 2002:a05:600c:8b02:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4832022ba07mr104971515e9.35.1770496933399;
        Sat, 07 Feb 2026 12:42:13 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm324540145e9.10.2026.02.07.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 12:42:12 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v4 1/4] arp: discard invalid sha addr (b/mcast ARP poison)
Date: Sat,  7 Feb 2026 21:40:33 +0100
Message-ID: <5b3d76709bfe524a74111b17bd438bde4d202598.1770399836.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770399836.git.marcdevel@gmail.com>
References: <cover.1770399836.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.90 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-257774-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Rspamd-Queue-Id: CD921107195
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
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
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


