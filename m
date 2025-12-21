Return-Path: <netdev+bounces-245659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE4CD45C6
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B596A3005297
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF8248F5C;
	Sun, 21 Dec 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gggK27HE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEE251793
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352018; cv=none; b=PRZW4zudYM9JRs3HmRvhe7KkJiAekRfxTDM6n55M1J+kCUKf4RvHMBlQv2AilfvrGMMHrvMsXhm9WKw/+NoorfKoO0B1kDSkcJ20Xk+sf8pN+V9GNp0ysMMfUZkF0GoTECXh+qzXVAdIuZGhwbhE/yYsvsTysneOaesAx74oIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352018; c=relaxed/simple;
	bh=cPCzlw4cfz9iiRiyeVehc8A5NWiQ42j6qfZYp+j7H+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDkGbk0n531vj468sWmNRfvAwC0qwLdpKgz/6TS4Uw1xvvf8Aqf2WmM1wU8t0JKepjWfTPh0aJCkcqB3GkGXutr3YSBGcpUCj36WNye5M5yD9KiOPLMYjtC/M7DClKKjboqJ7OiZpw6C1JWF84BNhKoBkYi5rGyeQ/xeHouZot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gggK27HE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so1664201f8f.0
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 13:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352014; x=1766956814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBdmYO5C0f2zAYbuCiccN2Qd3AU7KFZdhxM40uTLuGw=;
        b=gggK27HEj5CY+JyUiwUyaBPSFbvns6RV9A1QhD+5SrRt4LG/plZp248nPHoh0SKshg
         Kn5inMdJr+eKM6jHfIK2w1F7G+47fO6WdjVsGXDzMjhz7jmfHKvSMsmETU1DZNDhaOlM
         +rxJwDwi64TQuCbAhVlmi3JL7Og0I0alMTiEwxY0gOL7JoQfGAFMC2382Y8VrnRLh8LQ
         9ZGygA6B/rg8nH4oHZRxYupdTYdn+yGHuDR2kuvvyVP29BS+r8rp1WIj3CzYMO6oYIPx
         Ve4wfnBrf6q78Qkds3vOgYTgKS7K9cow6kCV2o/gFIEii2KvWAag9/Am7n8V+6Q10MH5
         +Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352014; x=1766956814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBdmYO5C0f2zAYbuCiccN2Qd3AU7KFZdhxM40uTLuGw=;
        b=Ivy8KfiU5moQHXZmq1qPVB43aPgP/OhEYPvEr9StsGg+OcDPNmVP+q+jgh1etOwTvA
         Txcm0fcvhiVgjxdU/0CxwUN9/nhLoHQV8n0pHPjnyzurF+r+niYQ4e8SeSUvOTHxq0DU
         /wLn8xFOUmTmUKGu6WeUHZ7gYZiWoQYZerqFHkgmBJ6wmjyZU/p2aEzrFtkpVFgxna8N
         1xekZ1FOt3Z0jDljyrDq9+uhPSbmBH8/Nd8ncj7etxzyfpNgvalcdWwx32zzTBJqmU+7
         EdlG6X3dbGhx3hrhpUH7ZO9T6jrbgfZYhq63ZMcEz3bl8fzKDXUuOWWK+BXETn7SLsP7
         6tQA==
X-Gm-Message-State: AOJu0Yzy9ZYDfO1dUhUj7r4umt/tHSnh9BfuMzPFKgPiemQnHDdpaIDX
	klNQySAwA2faRv5sxkUa4Ju/rK2YqAO0ZeaKbInfgZsOc5t65pT8ynrp
X-Gm-Gg: AY/fxX6NrJbDdxvd5vuo4BFDmXbO/7DbQY8Tp2L/tnjlwd4ze9NMtcleNyHMOI8LZn7
	DYv/YSUF5kfM/5TJOpjD/5bQXA0iT3zLwso8QhXOd2vNThr2YYm0WjaGZFpiZxklft0oDII9RoQ
	SZVdmN3n3IeS3q1G8pg5tZSDJ9pNTP83qkQzRi27pz4Y2JFNAvaSJU6iWh8X2F9OtCkixRaWEqA
	7lxvtjVTmhuBW8IFeg6Ox3YSxSG72HGCdiAhoyOJ1wIJTrTZIoPYxIE4t9zXRzXXfglwgF9kRzK
	Q5WhCvIoWhGE/8oxjG8dj64QZBJyUT9ZBdXN4s1rppz1LGRYN7+USVmF7kesEqNirSKM/CwjUoK
	UOYnj17vzcotOsGB5Q9O+gNCi18lqZy2yxW7zRGfqA/CU/yaPDoa+1YZi6mXhIcODsbuC7pdMFl
	er2JgAhu6SO23mkejA3g13wdvm76UWqyrxbdj4MdiaYA5HZQmk0ge2uBlkkYGjhCMo3cgurKg=
X-Google-Smtp-Source: AGHT+IFpAxNIevAfEgNx/G6EOWFeSfwnRM3aADvtL7aCpTncsLnYFYmLR9lpY1jF3IEenRkCRcYOKw==
X-Received: by 2002:a05:6000:310a:b0:431:a50:6ead with SMTP id ffacd0b85a97d-4324e4c9b44mr11528082f8f.20.1766352014357;
        Sun, 21 Dec 2025 13:20:14 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm18254455f8f.39.2025.12.21.13.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:20:13 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH RFC net 3/5] neigh: discard lladdr bcast/null (bcast poison)
Date: Sun, 21 Dec 2025 22:19:36 +0100
Message-ID: <0a53d41598b65645ec9e0b6ee3773c6b66267142.1766349632.git.marcdevel@gmail.com>
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

The current NDP implementation accepts NDP NS/NS with the
broadcast (mcast, and null) MAC addresses as src/dst lladdr, and
updates the neighbour cache for that host.

Broadcast (and Multicast, see RFC1812, section 3.3.2) and null
MAC addresses are reserved addresses and shall never be associated
with a unicast or a multicast IPv6 address.

NDP poisioning with a broadcast MAC address, especially when
poisoning a Gateway IP, has some undesired implications compared to
an NDP poisioning with a regular MAC. (see ARP bcast poison
commit for more details).

Worth mentioning that if an attacker is able to NDP poison in
a L2 segment, that in itself is probably a bigger security threat
(Man-in-middle etc.).

However, since these MACs should never be announced as SHA,
discard/drop NDP with lladdr={bcast, null}, which prevents the
broadcast NDP poisoning vector.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 net/ipv6/ndisc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 59d17b6f06bf..980768a79092 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -830,6 +830,17 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 			return reason;
 		}
 
+		/*
+		 * Broadcast/Multicast and zero MAC addresses should
+		 * never be announced and accepted as llsrc address (prevent
+		 * NDP BCAST MAC poisoning attack).
+		 */
+		if (dev->addr_len == ETH_ALEN &&
+		    (is_broadcast_ether_addr(lladdr) ||
+		     is_zero_ether_addr(lladdr))) {
+			return reason;
+		}
+
 		/* RFC2461 7.1.1:
 		 *	If the IP source address is the unspecified address,
 		 *	there MUST NOT be source link-layer address option
@@ -1033,6 +1044,17 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 			net_dbg_ratelimited("NA: invalid link-layer address length\n");
 			return reason;
 		}
+
+		/*
+		 * Broadcast/Multicast and zero MAC addresses should
+		 * never be announced and accepted as llsrc address (prevent
+		 * NDP BCAST MAC poisoning attack).
+		 */
+		if (dev->addr_len == ETH_ALEN &&
+		    (is_broadcast_ether_addr(lladdr) ||
+		     is_zero_ether_addr(lladdr))) {
+			return reason;
+		}
 	}
 	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
 	if (ifp) {
-- 
2.47.3


