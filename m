Return-Path: <netdev+bounces-239438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A7C68649
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA84A3415C1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45E32E74D;
	Tue, 18 Nov 2025 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KLGsDxs3"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A032E12C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456046; cv=none; b=h23w3R5avZ6++hJ+q1r0YPWKz0fUWxOOJF56WwW93XriMLntIppsZMZTNiOijnF9bBqwr+yjZbsiCR0jgHKfRZi08SQatLSP/644z6JIeCNGlmHqql+a7ux1ZGt5omEHkd/pRWVOXzzvIqFWW4zWjbPDrJ7zy11kks3fjvYJyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456046; c=relaxed/simple;
	bh=koklGohexrbjaML+xugHkjU4FWGU8osQ520Aqu9TZfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJX3WxB8YW92Mk1Kce1V6usFdKahsVzeyRg7KCR4tD3FBa4m96Q6n1HsLJkUO+/S9pNWI4UNI0io1Jc3iAc/o7tJ2LVAh4A/UQ91f53UGywmhd3X8W5QbjX6fexWMJEjcumz1UROr4L3yM/A6Rsw/1Kuybp7XM0cGYkbyO/x87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KLGsDxs3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3E8C02083F;
	Tue, 18 Nov 2025 09:53:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id to7NnYlZvl4V; Tue, 18 Nov 2025 09:53:54 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9583C2080B;
	Tue, 18 Nov 2025 09:53:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9583C2080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456034;
	bh=T55vH/nbz3+UtWx+DKx+9tczdPjZsd82nHEwXSQ/x5w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=KLGsDxs3Cqzxv8lf0m6CrtY5IZSbA1I//fzf4QPzAn5ja/pQGLyv6FNUt/8Ucx1+U
	 1i2+IqgwZGWnfZGQsUjP32/hp0pB9m7c2pfokXbIbHMhvYaiA8DXnvhsouprc7ASIF
	 X7+C0efXDAAtrCEU5CpG9SB/D5E6jU+EAFgR3fO0MnlgX6MTK7xnRjvco2GPPhd8J6
	 UtLVRgNblz1rtroKIq2jzbX4gVRx/ZLUSN9WyC0Vmv2Sz6uj+pn0YROmZVrNFiwp3E
	 EaKCapw8oonarMIi3Yqe1DkXV2l8YucbsrTICGX+7/pWAR+VG44j8eK5Ug/or1icN3
	 0sBr/5H+a4P7A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:54 +0100
Received: (nullmailer pid 2200672 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 07/10] xfrm: Check inner packet family directly from skb_dst
Date: Tue, 18 Nov 2025 09:52:40 +0100
Message-ID: <20251118085344.2199815-8-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118085344.2199815-1-steffen.klassert@secunet.com>
References: <20251118085344.2199815-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Jianbo Liu <jianbol@nvidia.com>

In the output path, xfrm_dev_offload_ok and xfrm_get_inner_ipproto
need to determine the protocol family of the inner packet (skb) before
it gets encapsulated.

In xfrm_dev_offload_ok, the code checked x->inner_mode.family. This is
unreliable because, for states handling both IPv4 and IPv6, the
relevant inner family could be either x->inner_mode.family or
x->inner_mode_iaf.family. Checking only the former can lead to a
mismatch with the actual packet being processed.

In xfrm_get_inner_ipproto, the code checked x->outer_mode.family. This
is also incorrect for tunnel mode, as the inner packet's family can be
different from the outer header's family.

At both of these call sites, the skb variable holds the original inner
packet. The most direct and reliable source of truth for its protocol
family is its destination entry. This patch fixes the issue by using
skb_dst(skb)->ops->family to ensure protocol-specific headers are only
accessed for the correct packet type.

Fixes: 91d8a53db219 ("xfrm: fix offloading of cross-family tunnels")
Fixes: 45a98ef4922d ("net/xfrm: IPsec tunnel mode fix inner_ipproto setting in sec_path")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_device.c | 2 +-
 net/xfrm/xfrm_output.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 44b9de6e4e77..52ae0e034d29 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-	switch (x->inner_mode.family) {
+	switch (skb_dst(skb)->ops->family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 9077730ff7d0..a98b5bf55ac3 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -698,7 +698,7 @@ static void xfrm_get_inner_ipproto(struct sk_buff *skb, struct xfrm_state *x)
 		return;
 
 	if (x->outer_mode.encap == XFRM_MODE_TUNNEL) {
-		switch (x->outer_mode.family) {
+		switch (skb_dst(skb)->ops->family) {
 		case AF_INET:
 			xo->inner_ipproto = ip_hdr(skb)->protocol;
 			break;
-- 
2.43.0


