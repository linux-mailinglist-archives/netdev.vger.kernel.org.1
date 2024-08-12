Return-Path: <netdev+bounces-117681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DD94EC80
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3A71F22121
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6817A92E;
	Mon, 12 Aug 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgZS0vd2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B3179972;
	Mon, 12 Aug 2024 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464735; cv=none; b=llazJr9aBwYMww6EoBlXiunLrtG3raV3BEqEdtjgCjShXq80jw086Pb+FYhqmh7vIi1lsngj/hxBY6T9v0V314sO17H5xUtGPvJVHFrM9YYkaR62s88IwWFxbXvFFLeQEzuMYvoEXcrBFXunI63FkMD18EzS+f/Noc/8D/pnvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464735; c=relaxed/simple;
	bh=feMZ11amsOB5MfZgo8CW/vk5lh85VqxPxLLtSo9jxdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/Iqoy0LnXCiJxfJlLqowZ9NWSdFM4bj6iNY73qIDmG8Qh2xjiY7W2XEkPbQpBPzab4rZTopDafQwdZ4qP3res62dNN+7dXOS9N0Yd52f5PDopxvYZLg+HqGz8zRDGxMar+3SEzolx1/KNPj3nPu4ARuVWEasAJrSp6gOWxBkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgZS0vd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65CFC32782;
	Mon, 12 Aug 2024 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723464734;
	bh=feMZ11amsOB5MfZgo8CW/vk5lh85VqxPxLLtSo9jxdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tgZS0vd2E/r60+JfFvuAq+1P0K0KF3X9jMjOvMu84AUncArQ4UWB6TmYk95FDQ+p9
	 To8wc/6GzDVxex1ZNSyn90kXE8XVM35zel2l4oayqWpzJo8BMu8M8lEejxQSfpV8Ce
	 G1WCdmA9RGSbmy8mX+tYEja9avN1o/YDeriSLvaC5EV7qxNFvj5aBFDpUOF+qqP5S0
	 QzTU5rRf3uBSXZP+/GwCByy22Te7xkMzf/dIoybccO32uBEuASi+9ZYHuZThPpK3EW
	 3RRlD9Q7KDaLwkkV5jxmMcB8nv2vjFyF86xLtU7vRrzK0Sc5iISWkrM6//uFNYxNcf
	 AyEu5vG0dMmQA==
From: Simon Horman <horms@kernel.org>
Date: Mon, 12 Aug 2024 13:11:55 +0100
Subject: [PATCH net-next 1/3] ipv6: Add ipv6_addr_{cpu_to_be32,be32_to_cpu}
 helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-ipv6_addr-helpers-v1-1-aab5d1f35c40@kernel.org>
References: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
In-Reply-To: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.0

Add helper to convert an ipv6 addr, expressed as an array
of words, from cpy to big-endian byte order.

No functional change intended.
Compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/netdev/c7684349-535c-45a4-9a74-d47479a50020@lunn.ch/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/ipv6.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 88a8e554f7a1..e7113855a10f 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1365,4 +1365,16 @@ static inline void ip6_sock_set_recvpktinfo(struct sock *sk)
 	release_sock(sk);
 }
 
+#define IPV6_ADDR_WORDS 4
+
+static inline void ipv6_addr_cpu_to_be32(__be32 *dst, const u32 *src)
+{
+	cpu_to_be32_array(dst, src, IPV6_ADDR_WORDS);
+}
+
+static inline void ipv6_addr_be32_to_cpu(u32 *dst, const __be32 *src)
+{
+	be32_to_cpu_array(dst, src, IPV6_ADDR_WORDS);
+}
+
 #endif /* _NET_IPV6_H */

-- 
2.43.0


