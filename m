Return-Path: <netdev+bounces-248080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED09D0324B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F8E3097D4D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D854E2A2D;
	Thu,  8 Jan 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a2tE4Xjh"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-105.ptr.blmpb.com (sg-1-105.ptr.blmpb.com [118.26.132.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65F4DBD9E
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878048; cv=none; b=KRsr9Ajbz7FncqDG0GlkXrNRL5CsQb/+WY3lfsP4p5Nod+8QYKwYv1GNuTHj6OObb/i+diw+XZi1nqkP9FNWFFNdEltT74ZmuM7WV97xzExlhiNe2HN09oUESYqQ3MPptIF262rbcMqzeA0n6vIdeBuh3c0NtYAgf/FhJUDdxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878048; c=relaxed/simple;
	bh=SFmiJaN3ONjkE9h4CmYC+F0bzaOxK/UW37PXwRAcUnw=;
	h=To:Subject:Cc:Message-Id:Mime-Version:Content-Type:From:Date; b=UwOmmIt0upYFCmjQaCMNxhHzWRx2MV2muHt2hj0WfQtmKIepy/r731MQvJX2VVV0dJfKYcqF2teYzNrdf0b32OVJIMH7Is30DlTt7dhhd5CC7kANFHokSfo/5kbL9vxPOWtezDvDRJRhxH1dtgIwlAsI8X9Xh1dQmEZzy0NFBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a2tE4Xjh; arc=none smtp.client-ip=118.26.132.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767878036; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kybuBjhJ8ENNqYO08HJbTeAe8vlxFKiTuQ7Y009ja4c=;
 b=a2tE4Xjh4cWfs3RUpllW7etRrObMpNkj16bh07jRH6vCW3iJ3eZEC9+h/p45xyuCNxbXHw
 Zg/iCIki1d39obFTDxnUhvoPGUbw+kjPWqMjShoWisRjNFj9Ft6omnQTV84Y2mtbRk2PO4
 sSJi1OLLkUNmOAha3cQr0pxuJReko8v9MjsMnX4Rf/GrZ7znZs9z4Fqixzfv9llk4o8/0p
 1r4kXBSXfQHwNBTTT10c4VqJdkgLvRTWC82hpydYe9jOXZ94xR4Qn1wFKlRb/EtGEghslh
 70rb52jhTXoPdt+26V0JLo/eblIMWZXL/GjRaEDjMlhJYgCIBVjaIdPgBvGvgw==
To: <netdev@vger.kernel.org>
Subject: Question about RPS hash collisions with IPv6 flow labels
Content-Transfer-Encoding: 7bit
X-Original-From: Zigit Zo <zuozhijie@bytedance.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Message-Id: <b7aa237d-e35e-4af7-a4c3-f8315c2f7310@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
From: "Zigit Zo" <zuozhijie@bytedance.com>
Date: Thu, 8 Jan 2026 21:13:01 +0800
Content-Language: en-US
X-Lms-Return-Path: <lba+2695fad92+c1662e+vger.kernel.org+zuozhijie@bytedance.com>

Hello netdev,

We have observed unexpected RPS behavior related to IPv6 flow labels on
5.10/5.15 and would like to ask for advice, on our 5.10 and 5.15 kernels
under the following conditions:

a. virtio-net (no hash offload)
b. RPS enabled, skb_get_hash calculates the hash here
c. IPv6 with default auto_flowlabels enabled

This causes RPS to keep selecting the same CPU with very similar hashes.
This might be a coincidence, but it keeps happening on these machines,
affecting around 10 RX machines. We have selected one RX machine:

xxxx:71b::50 -> yyyy, [flowlabel 0xeaf27] [skb->hash 3568038043] [cpu 79]
xxxx:71d::36 -> yyyy, [flowlabel 0xbf206] [skb->hash 3544518926] [cpu 79]
xxxx:71a::34 -> yyyy, [flowlabel 0x7b6a8] [skb->hash 3538231196] [cpu 79]
xxxx:71d::40 -> yyyy, [flowlabel 0xbd4a4] [skb->hash 3572956790] [cpu 79]
xxxx:71a::37 -> yyyy, [flowlabel 0x5dbe5] [skb->hash 3573425965] [cpu 79]
xxxx:71f::41 -> yyyy, [flowlabel 0x6acdf] [skb->hash 3571406812] [cpu 79]
xxxx:706::22 -> yyyy, [flowlabel 0x124ae] [skb->hash 3541372961] [cpu 79]
xxxx:718::28 -> yyyy, [flowlabel 0x5ca00] [skb->hash 3551598012] [cpu 79]
xxxx:708::29 -> yyyy, [flowlabel 0x1dfa9] [skb->hash 3559424332] [cpu 79]
xxxx:71c::40 -> yyyy, [flowlabel 0xfeb81] [skb->hash 3545152152] [cpu 79]

Most of the connections are long-lived, but even when the flow label is
changed on retransmission, RPS still keeps selecting the same CPU. We are
wondering why this happens. One possibility is that the TX side is running
a rather old kernel which still uses prandom to generate sk_txhash (flow
label), leading to a higher chance of hash collisions. However, we are not
sure about this, so we would like to ask for help:

- Does anyone know how to explain these hash collisions if they are
  generated by prandom? Is this very likely to occur, or is it really a
  corner case that we hit?

- Linux has limited ability to ignore or override the flow label in RPS
  (for performance or security reasons). Are there any ideas or plans to
  improve this?

- The flow dissector BPF attach point is somewhat hard to use, especially
  for IPv6 with extension headers. We want to remove the flow label from
  the keys rather than recomputing the rest of the keys that we are not
  interested in. It also affects many other places (we are using the host
  network without network namespaces), such as the fib, which we do not
  want to touch. A tc BPF program can modify packets to clear the IPv6 flow
  label, but this still has a wide impact.

-- 
Regards,

