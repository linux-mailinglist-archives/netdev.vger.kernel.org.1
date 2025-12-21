Return-Path: <netdev+bounces-245658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32DCD45CC
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 22:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEDC3005EB1
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A02505A5;
	Sun, 21 Dec 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXw8Bn09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4E21CC44
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352015; cv=none; b=CSHzL6o38gaQz/kuvdh4pmClzeLp8p9WOGmJtt8JaB4XnmfEaD6oSmDNv6DZDhX6KdDr6AEzvZ5B/y7EADpCKGEDI5nigWZisgh6ZT5Tf2lqn4ys879KfVBtNDAWvsfb2JTRrg9oRrAA80d6QNrdvX86Io489rCZt8YkW0xyiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352015; c=relaxed/simple;
	bh=dUEnz7NQPE65EOrhlheZ+/DZmdBPx9Yim8tuklmeyM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDr1LXzMjL2o+xZiXv+Eu03QTu3peJw/S9xJOP6IlL9VJNh/OwMFSisox8wMTrLCGLgezQG6plQkafui7xAtIILeu3G/BFJUr4QfvU3/vwdB8Wh1wvANiZqPsMTlNfJmkVtKXFNda+B5VXLoPjgqFwOTBUK01v2FBiU2Pd0MCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXw8Bn09; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so23660185e9.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 13:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352012; x=1766956812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkUty2o2up5gj10PyDUIyLHSYqP1DZxLsDljnx5J5xc=;
        b=iXw8Bn09HTCZ/i1yf87y+5QWB48qP2wd2WqkM4HYfrSdLGmJCSzB/AK098iBtXfIfq
         AFwdMxlU22AvuA6iWKy9mQz/8qcvJ70Nyv1xSt+FMu1JmAhYenXK1Dbgzcf7Ps+An8n3
         rz6qb7G214kq1xGpXDTekzBKDerqRwjRCLxS5kVodfv/URzPIdl7la5tfiJPWu/Mp8Iu
         7ec2KqKpiV5NYd7sMC+8ykeB70dMW9HNq43R907NHp4dp+mmMe8z4Yh0Y+qPREii+vGS
         rMJHXhibSd3kS4+MBGCexuK0WDVdxKJyvtzshjMI5keX0o9/GH6QVsHXbEPQI4K6JkJ5
         wEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352012; x=1766956812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkUty2o2up5gj10PyDUIyLHSYqP1DZxLsDljnx5J5xc=;
        b=obMvdXeKS8p3R1ei8px+tvh1BjegwLtFFdztEQF2Y7F2yIjG2T1xeE7UpJM7DtQZaM
         RCJxkB1BZ77TUfqA3zZQJLf3dC2lyT9cK/Kim1hyoV7DRU2+d6fecEbdfbp6iyxpeifr
         bc3GNY5a7ADGi/5chdKrbJtkxgi+dkayyCOyyTVOg2+v9yaUa8CBIeyzAX2MED7lnGtT
         PDS9W2VGltB+ZlMIc/V8DaeV0NV6+E9bZTf4zZNuDxJF5yFaEIJuvJcI+BFo3SLqezdn
         zN5xydmZ6swlwzJ1f7dOL81wPf9ZwhDiCXYvIfXOrLqR2BoLQxrBOKYJKQTDm5fiiEBf
         VNhw==
X-Gm-Message-State: AOJu0Yx6XFjQEtrb1GobqUym6eh5NTsvMnOYa3+vs4xMCofBx8Ft/8pQ
	b0ax+G+Wa73+nzJdhW/FAY9RRMwvc/SE9vNxeQ/wBG2gB37AMHl1SU5H
X-Gm-Gg: AY/fxX6ajmAXE7vm4xyIm57rPpfFCLfr2DGvoPECmXpgQ4U4vCuKGtAmyQiXU2fjZoO
	29xdVx+g1uhFY2P+hBSWx1zg1J0y6YFr4pvvKiH+2qWgatYwYv0Gz16HCjQ9VzImNne5LtWfbr/
	YKfTKL6bif8ngaoPSfzdP56uhBrav84bGa4N8+XC8OxNOYqmGZsDeGCxmZU1O/94XsqY8OTqwJQ
	WAsCQjoMom4JANFkmPw/kfdTxG3D5FT/fLmlmzVYI+3nHo4fE+xGazEsVPCKrodPsEhoohHpFas
	VqdpFA0FxZmOVW7x/H39JlXA3oXM7a5/bwbzYvbu5fbPA0BWebZiakIjkJJeFdusvGG3Sy7Ubs8
	T7PISWWtWE96L3MKYdYmCvP08HDvUlCkkpuard32c7deK5n3MhORXS4N6u4TTWsiZTNIaLAiPfZ
	QzU8iX6oCc288jbrWcP1oDpqaIPSJAmeHr3ZevTK8pyXpPQV0lw1Tj3B71EazgjJKX5Uf4Z5qm7
	x0XAveAoA==
X-Google-Smtp-Source: AGHT+IEWWszpCwpxghHnu60kZBbOZrPDx0rrVUqcap5po9b02P9VTP/kc7WvZ58dpk0aZ7Lm2v9lnA==
X-Received: by 2002:a05:600c:a016:b0:477:5c45:8100 with SMTP id 5b1f17b1804b1-47d19594e57mr90004795e9.24.1766352012065;
        Sun, 21 Dec 2025 13:20:12 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm18254455f8f.39.2025.12.21.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:20:11 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH RFC net 1/5] arp: discard sha bcast/null (bcast ARP poison)
Date: Sun, 21 Dec 2025 22:19:34 +0100
Message-ID: <99815e3b40dccf5971b7e9e0edb18c8df11af403.1766349632.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1766349632.git.marcdevel@gmail.com>
References: <cover.1766349632.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current ARP implementation accepts ARP req/replies with the
broadcast (mcast, and null) MAC addresses as Sender HW Address
(SHA), and updates the ARP cache for that neighbour.

Broadcast (and Multicast, see RFC1812, section 3.3.2) and null
MAC addresses are reserved addresses and shall never be associated
with a unicast or a multicast IPv4 address.

ARP poisioning with a broadcast MAC address, especially when
poisoning a Gateway IP, has some undesired implications compared to
an ARP poisioning with a regular MAC. See Note1.

Worth mentioning that if an attacker is able to ARP poison in
a L2 segment, that in itself is probably a bigger security threat
(Man-in-middle etc.). See Note2.

However, since these MACs should never be announced as SHA,
discard/drop ARPs with SHA={bcast, null}, which prevents the
broadcast ARP poisoning vector.

Note1:

After a successful broadcast ARP poisioning attack:

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
 net/ipv4/arp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 7f3863daaa40..83b34b89b1be 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -799,6 +799,15 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 		goto out_free_skb;
 
 /*
+ *	For Ethernet devices, Broadcast/Multicast and zero MAC addresses should
+ *	never be announced and accepted as sender HW address (prevent BCAST MAC
+ *	and NULL ARP poisoning attack).
+ */
+	if (dev->addr_len == ETH_ALEN &&
+	    (is_broadcast_ether_addr(sha) || is_zero_ether_addr(sha)))
+		goto out_free_skb;
+
+ /*
  *     Special case: We must set Frame Relay source Q.922 address
  */
 	if (dev_type == ARPHRD_DLCI)
-- 
2.47.3


