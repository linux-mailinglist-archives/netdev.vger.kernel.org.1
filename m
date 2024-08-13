Return-Path: <netdev+bounces-118054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719295068F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8391F230B3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81EE19D081;
	Tue, 13 Aug 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/+VatEt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37619AD6E;
	Tue, 13 Aug 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556041; cv=none; b=ayxs3eizMsprGo2apGcbXVCEJFgoJ5XzXojt1NvVAnGZPrFxNheYyCKII/cl6HQI5+mWg2UB7bZcDuzzy8CLkQRZuu44pdoeR0nbl5D3lOGisYAVh6uUliF55N3kqjqF5OEX6BSotEU1g69PraR8PfpvUVBxHkiJ97Du+lQ9RrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556041; c=relaxed/simple;
	bh=YjUeMGxUokPWbR1FpTGedLaSX1C6UavzEGCHc8VtbR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dwg4VBhmWpv7FFUGNRc7O9HkXiCyN8uTOUtLVFhaav9pj7chKTP6plJR6hHQMaCeaI87AU4FxIXW+lcH42KmPva1HY6fX2gksCuXXuWEegdP0O4+xeYNeivPy/yijRmc8IEL8dy+tmwYqo4gWoKR62bl/K82O4VRjL1p4dQqQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/+VatEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C13C4AF0B;
	Tue, 13 Aug 2024 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723556041;
	bh=YjUeMGxUokPWbR1FpTGedLaSX1C6UavzEGCHc8VtbR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q/+VatEtPTBjkcOq0MBnr6OXIJnKVOTEx3h+Yq7EBHNuSom/YOwF8j+XP/D2B2ov3
	 XfuKY2e/uxf16cjp4pksVT+3uipxuLeGmF1WC3+/B+171i4ACPwkdI/oR8/HQvslsb
	 HpyTDZW1mNs0yiSp+BBSoUDTQj32Kwejtn6oepGUzH1XfAjXAR6QOsugLADwacQnIO
	 DcVpPfnpngTQ3YzBG4Aovfiu/yJdr4gaZXlnZPlPKMTEd8akxDOtFBU0ap3/H7QY9v
	 FWWgg16rytcSUqiQT8OF4H7WjK0tqxgI1V5+NEUOVdUuAd/jcoMGT+TYBTSoqG3iCg
	 KBnsuFGpYJhSA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 13 Aug 2024 14:33:47 +0100
Subject: [PATCH net-next v2 1/3] ipv6: Add
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-ipv6_addr-helpers-v2-1-5c974f8cca3e@kernel.org>
References: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
In-Reply-To: <20240813-ipv6_addr-helpers-v2-0-5c974f8cca3e@kernel.org>
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

Add helpers to convert an ipv6 addr, expressed as an array
of words, from CPU to big-endian byte order, and vice versa.

No functional change intended.
Compile tested only.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/netdev/c7684349-535c-45a4-9a74-d47479a50020@lunn.ch/
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


