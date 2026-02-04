Return-Path: <netdev+bounces-256835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOdeFHDEg2ncuAMAu9opvQ
	(envelope-from <netdev+bounces-256835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:13:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A35EDECF18
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0EB30210FB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE77369206;
	Wed,  4 Feb 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZDdS0OY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A5361DB0
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243141; cv=none; b=Etn1flxq0pWBL3wzV/lSte6F4aYXvR60igaNbuya2CUiFC75IVRWoXUwVd+zE2Bjm2f7mzMbAfxM99M7d/Kyxuax869Y3wWll7sFNsAFIxEH4F61w4G6vI3sZGmAGlmerBKqD4RGPXUVLyT1eFYUNkoS7datmtlJSkzKKhHbneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243141; c=relaxed/simple;
	bh=Qik1ozjqSZ/s/skBi6PKBAxE22b0dCz+aDh6JJNlO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWcNmrz/UqZD0J05/iAghH0rc8eGOKwvaPi/NWyXNSGDzYANld6eiFwJLpEPUp8om51aHa2CxheRuxYpS3kDe2yrRz8rc1j2e6z3hb3cC5HNDgop2OGtaaj0bYaHj3GI5dDH+BKDjXknpkDag0BpTejCVTm97J/Nt0oO6ZeH9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZDdS0OY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-481188b7760so2279545e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770243140; x=1770847940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk9Fb92hOdGZyZJu9bD0s2WE9JX2jwnrDPcvrJsJU0E=;
        b=jZDdS0OYtZHr2h39ZzHDnRPP/X2Q98uctTRHoGYU+E8MbXfngl4MKJkA5BsH8cpGR3
         5t/MtPfOCy9xGz6jo8/Y9znwkC10LCYL8A6iyLsp/iZrILA1tHXm8qLmYxXfBlVCNah0
         STA3zjW7kKS4BnTau8LDwKiF8v11YeMWGWJKDYqDQuZ++kWFmQjUm/CZUQ9PjpkhhpIo
         LnT7ys3I1cjwBdTRhFR+O7oObQ3kMwXbmwk0bGymHwhb+a49P1u1uGM+M/PQ3SEBkprF
         f6xzxIOq5mYai0mMdNlDSyUYRCQLEiVMLbN7yHHPu+dNLiCFajHWoGcCY9TXudTv0m+5
         gv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770243140; x=1770847940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pk9Fb92hOdGZyZJu9bD0s2WE9JX2jwnrDPcvrJsJU0E=;
        b=APogWbTnDRlOl6qtWx+0QU1Q5R4WmXIWq1pTUZZn2vSUwhiAmTUDYg4w0N9Tlzrqa4
         dtv/AowRiRYhLd0tOVwzNZj3+UAf72l5J/MQ0kCCHh3QZsn/UgWbh5cvx7M1yskfEbcm
         6hWh1kwm4+g0SOxGwvhd/gWpi2rvGcg5dBYPP/h9oot2aUumnNZvkdvMIwaFHWyslTYg
         ctZqAf2HYS/7/BoEWzWwzz+XERhzXYj82RXV4m2rXn27dxht8sNnFNpm2muVPNps1TAe
         sXcS0s1+SWP5B0QmAMuSZgGozxXH+KcIIA450KqwgvR3fz47iSIjsmWVw3AeM7NJ6cYc
         XyTA==
X-Gm-Message-State: AOJu0YxdR7UIS32j1ZyT1u7KfA0O9xc6CZJep8T6+n1xrOM3SL/mwGqA
	V4kev4zeUEp8aMYTsRJwmtkao/u4MSFovoQUKhiCs8/U0bGazqhDAe/x
X-Gm-Gg: AZuq6aLRffgri0nCCthONfFZKCMnnBLyEImSUTZS21UHoGKPfFPfORww/MYKUbncxO0
	YtvXUkcfE9EHe5E+wOvtNVb97nPCEOEDGUKK8X+kkyUaOJnyR72BAdliWf9pybLc7q+8L6LE8Ci
	1GbdqTg4QrUBHooSlZeSnBtOmetLhUG5wbrfeImGOo6crXu0R2UeSBYl9+BI0RD2fNHY7ZnQFyX
	9brRzr1FHhi64z1zpa04Jvmf6kt7nU3t77ADU+LlOlsCKKzVcDgY3x545vg932gfFmj1+UKIPLl
	SciwfszEoCwFRz2FIb2LWMQXXqUJWZlHXruBNEu8pugGMXedcrDfbXC9eNhFiuypiU8QAa/SJhf
	dEHwZREU86p3blIyDeVRgOK0GchpyUndJlbQXPwoCvuOX4V0btWtkMb86EKWDmbestRE4QLCa9Y
	e4ZrB6ugpgG6cgoX0axxLj5MdEVPhNeqd1q+agOWaUo/cG2vUa9LZ9STQKkZzoIEMECmKqpO03k
	IINaFr00n5ieBc6OXIo0yPN0K3a/xyR/QgdTi49ELUOLYfeLT0qwt6U2wih
X-Received: by 2002:a05:600c:6212:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-4830e972f95mr57609885e9.26.1770243139635;
        Wed, 04 Feb 2026 14:12:19 -0800 (PST)
Received: from localhost.localdomain (173.red-79-153-132.dynamicip.rima-tde.net. [79.153.132.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d47sm8327099f8f.5.2026.02.04.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:12:19 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net-next v3 1/4] arp: discard invalid sha addr (b/mcast ARP poison)
Date: Wed,  4 Feb 2026 23:11:58 +0100
Message-ID: <d51bdc5aa3236ec4b7cc98c9d6a098f27f45477f.1770241104.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770241104.git.marcdevel@gmail.com>
References: <cover.1770241104.git.marcdevel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-256835-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: A35EDECF18
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


