Return-Path: <netdev+bounces-209234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AA1B0EC6F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8B91C25E5C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312D277CA5;
	Wed, 23 Jul 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="kiuDzqEw"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DC277C8A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257272; cv=none; b=jzHRg9BCoc6idEwhW8ZxCTHZ+Pjgfx0TPaqMNa8ONGKyK6tTCbe5KajCn6HiymFT8274bplcxqaVHtSUkw9V7chfTXMlqVlSZznbEv0+fC3OxdwEZHIH0TDcE7B+gqMS1d8AhOJ2E8uEAd56CykFofMYQMkDL8Iiky2b/XUvOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257272; c=relaxed/simple;
	bh=nXtksd1sPYoh2IuSlmadQiRpGiFl5Da435QLhfOm03k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqAY2oAOR8E7NBZcF9CP9PQR6nNLMAU9v6PTlbk6p01jdZ8lvkzpiAPza3DnTPqWMNGVVuc00hN+AOzQeqOrJNp6hxl2d9MZ1pVq17iM2WVt0M/yslY8/STt5SOCiA3hVDalDWEOh7haKlMLLgyC2fY4bJwU2AURhZ+UIiMFPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=kiuDzqEw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DCC2C208A2;
	Wed, 23 Jul 2025 09:54:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id urxJ8AEq6vZI; Wed, 23 Jul 2025 09:54:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1543120820;
	Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1543120820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257261;
	bh=ttDPGIdZYtrZgcV4a0hy55ViuSrryFKhqSAMzYhFpvg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=kiuDzqEwUVI8aoqImqW+gxL+NNxKz/r9IzG+1WzvxMk1HSm+VNpGDJF4/L7P/gzl7
	 5B1QDsGu5ab3W/jHlBHUApylhWe01RlxsKRB+qxB2194IuIi6oUEzfpyChT8v/bqHX
	 Hnvyb/loRNN23NszBgcYKBdEieMKbrU5tJaNhQsvYaqV3ChM5ncLOXSkyJ7QOBQ/F3
	 CaMVRnT70Gab4EASDh4brWdDYCXi4Ia/Y7+9sUzYUvcMwtcc4avcQZLGeo6jqTulKc
	 VHrmvR20F3wJYNr6LoRpj1JsxuUSpZqCnOCrQ1084F/0CUQdiK+gI8YjKDHbx9hL2n
	 Ie+IlW9Hetm3w==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A5C3B31841E3; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/8] xfrm: ipcomp: adjust transport header after decompressing
Date: Wed, 23 Jul 2025 09:53:57 +0200
Message-ID: <20250723075417.3432644-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723075417.3432644-1-steffen.klassert@secunet.com>
References: <20250723075417.3432644-1-steffen.klassert@secunet.com>
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

From: Fernando Fernandez Mancera <fmancera@suse.de>

The skb transport header pointer needs to be adjusted by network header
pointer plus the size of the ipcomp header.

This shows up when running traffic over ipcomp using transport mode.
After being reinjected, packets are dropped because the header isn't
adjusted properly and some checks can be triggered. E.g the skb is
mistakenly considered as IP fragmented packet and later dropped.

kworker/30:1-mm     443 [030]   102.055250:     skb:kfree_skb:skbaddr=0xffff8f104aa3ce00 rx_sk=(
        ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
        ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
        ffffffff84281420 ip_defrag+0x4b0 ([kernel.kallsyms])
        ffffffff8428006e ip_local_deliver+0x4e ([kernel.kallsyms])
        ffffffff8432afb1 xfrm_trans_reinject+0xe1 ([kernel.kallsyms])
        ffffffff83758230 process_one_work+0x190 ([kernel.kallsyms])
        ffffffff83758f37 worker_thread+0x2d7 ([kernel.kallsyms])
        ffffffff83761cc9 kthread+0xf9 ([kernel.kallsyms])
        ffffffff836c3437 ret_from_fork+0x197 ([kernel.kallsyms])
        ffffffff836718da ret_from_fork_asm+0x1a ([kernel.kallsyms])

Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
Link: https://bugzilla.suse.com/1244532
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_ipcomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 907c3ccb440d..a38545413b80 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -97,7 +97,7 @@ static int ipcomp_input_done2(struct sk_buff *skb, int err)
 	struct ip_comp_hdr *ipch = ip_comp_hdr(skb);
 	const int plen = skb->len;
 
-	skb_reset_transport_header(skb);
+	skb->transport_header = skb->network_header + sizeof(*ipch);
 
 	return ipcomp_post_acomp(skb, err, 0) ?:
 	       skb->len < (plen + sizeof(ip_comp_hdr)) ? -EINVAL :
-- 
2.43.0


