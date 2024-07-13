Return-Path: <netdev+bounces-111230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88493051B
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B91C2108F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD76E614;
	Sat, 13 Jul 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Dot7xhQC"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910F47F64
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866270; cv=none; b=klC1q4cs7pdat9a0R/r1zgUlRg7xzV3RTITxBbohIzWpl4eNEDJ/aSRCd5vba2ARuOSOe5gaES48YCJDl3ugrD7NfSWyJT8CQsTg24muRk3SyLLTtu2xVQF721RtuGU8lS96qEe79SR1HdPrMGF71nXCfMu28tzflwqzzeDSLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866270; c=relaxed/simple;
	bh=1QXPQI6PrJ1OBriAxnoowLwnqZpoXEnxPQLHLwr6VJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIYesFUO5eoIsY32f3ZECBL+Ct+zI4XLDBZ+JjkG9HcIdOMABZ+9TSqyNTt+b/pmfgr5rUdZwwMVVXUZKQlMLPIrzeFyWQnewxxCGu6W/Q+YZSnPIAQBA2EA+w77wp/5vtA8CleA/g3hnlYkCh6FJXg3iun9Ob0Kwvuayn4BKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Dot7xhQC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E76FA20538;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bq95n5QhC_66; Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4FE0A20754;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4FE0A20754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720866265;
	bh=W+8WwKDhmGJBiBnB3vlU0VQPngwOYf3w956+Gh7Fr/g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Dot7xhQCmyv9LxElXzdVj2YTGrP8cWMTGgA314XX6mj9MdPOKs23wCThhxiNy+96U
	 orHV1n3bxf+2T23mwikA4UEo9I4pFRVCXez2L6xEbLK2lpc4HfYkKe1lTDKnsl8qEn
	 jt9h66ieRpV6egIdZKobGdda1A262t5pCsiTnBx7PZaiWAR/okQaT+PF16pcPQX3V6
	 NzwSKgTXBPuPPqv+8HtcJ0IwjD51JVMYygjXRzb6XGE0SDwj6DSQVfr00sKKp0yUBl
	 Ia2p/LuY7YmONEFjfKm3QloFa6lT2wmuFWys5rQ/RoJIiTXWMA9NO+CoQxTr23RDUF
	 ge2Rw3zM6Wc1g==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 3A39080004A;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 12:24:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 12:24:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 51C76318304D; Sat, 13 Jul 2024 12:24:24 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/5] xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO path
Date: Sat, 13 Jul 2024 12:24:13 +0200
Message-ID: <20240713102416.3272997-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713102416.3272997-1-steffen.klassert@secunet.com>
References: <20240713102416.3272997-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Mike Yu <yumike@google.com>

IPsec crypt offload supports outbound IPv6 ESP packets, but it doesn't
support inbound IPv6 ESP packets.

This change enables the crypto offload for inbound IPv6 ESP packets
that are not handled through GRO code path. If HW drivers add the
offload information to the skb, the packet will be handled in the
crypto offload rx code path.

Apart from the change in crypto offload rx code path, the change
in xfrm_policy_check is also needed.

Exampe of RX data path:

  +-----------+   +-------+
  | HW Driver |-->| wlan0 |--------+
  +-----------+   +-------+        |
                                   v
                             +---------------+   +------+
                     +------>| Network Stack |-->| Apps |
                     |       +---------------+   +------+
                     |             |
                     |             v
                 +--------+   +------------+
                 | ipsec1 |<--| XFRM Stack |
                 +--------+   +------------+

Test: Enabled both in/out IPsec crypto offload, and verified IPv6
      ESP packets on Android device on both wifi/cellular network
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_input.c  | 2 +-
 net/xfrm/xfrm_policy.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index d2ea18dcb0cb..ba8deb0235ba 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -471,7 +471,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;
 
-	if (encap_type < 0 || (xo && xo->flags & XFRM_GRO)) {
+	if (encap_type < 0 || (xo && (xo->flags & XFRM_GRO || encap_type == 0))) {
 		x = xfrm_input_state(skb);
 
 		if (unlikely(x->dir && x->dir != XFRM_SA_DIR_IN)) {
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6603d3bd171f..2a9a31f2a9c1 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3718,12 +3718,15 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		pol = xfrm_in_fwd_icmp(skb, &fl, family, if_id);
 
 	if (!pol) {
+		const bool is_crypto_offload = sp &&
+			(xfrm_input_state(skb)->xso.type == XFRM_DEV_OFFLOAD_CRYPTO);
+
 		if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
 			return 0;
 		}
 
-		if (sp && secpath_has_nontransport(sp, 0, &xerr_idx)) {
+		if (sp && secpath_has_nontransport(sp, 0, &xerr_idx) && !is_crypto_offload) {
 			xfrm_secpath_reject(xerr_idx, skb, &fl);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
 			return 0;
-- 
2.34.1


