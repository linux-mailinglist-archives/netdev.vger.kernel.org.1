Return-Path: <netdev+bounces-297696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1kiTLf5vKWqVWwMAu9opvQ
	(envelope-from <netdev+bounces-297696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:09:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7E66A1C8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:09:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=SyCy4opW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297696-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18E85300CBFD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAE40FDB6;
	Wed, 10 Jun 2026 14:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFD40E8D6
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:08:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781100502; cv=none; b=ZxarP39IDh7b3//D/c9XiZkkxpibPVY9eNZ7fm9c3y11N9vq7e39TJM3+wdhq/4bAZllx72eONFuki6i3CBjNnDCt3IhuqE3HVHVSSM4JTCWgOSqX/b0QKOhiOgvLpKaH/C0Clu7ie+Z6bsLZCoFsRkjoEQliVh4OB+slhPv0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781100502; c=relaxed/simple;
	bh=BaXtRqnSIkDfq8w8OcgapsnBGhZ5lXNVgCqg6yhWQzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI4X5dTuW9nlYBDnTztpNQc9ZGrRojI+hOLx0x9NNnA3H6UCqNlPbjguGkmr2FUIWd5zYSaLfelIf3S8I3+5uFbpKaSZOmbFaoPSe3PV+rnklcxut0GWZiLTwczVgHXeRz1u7RIHfGW+7wkkJ0X99UAPPDo0hBSyIDCZ/UVM2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SyCy4opW; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1872E2084C;
	Wed, 10 Jun 2026 16:08:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVE_IR0hfvra; Wed, 10 Jun 2026 16:08:16 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7632D2083F;
	Wed, 10 Jun 2026 16:08:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7632D2083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781100496;
	bh=QPmhyRYGyUdsh0WLAWjDv0qEczS7Kh2q6Ow+RaE3HJc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SyCy4opWW4pZsz1qitSW1LuzbeSJIr6TLzSKGFRlEIcWX1ZKC6CqL+5hyvy7/TSSL
	 7JqvBR1289lRu9anBcEox+1tfrl/qLkEH3M0wSQ3oa/yu03G9hGVFFTfpjxAU15W6+
	 C1xoyVZrAACLJ08hcxvRfZy7GzxFWs3YAAiEKhFeoFV+Dad3apIKm8nnr7FVSIM8mc
	 LD+QP5Rt9cVKyEmBsbldid8eLg+y2GODgi2zxpu/oQkwnboBpT4bTnydUvGvxMS+D4
	 9wgznoGwL/wT5qduU8/+R1I6cOSpHCoSnvr0mC2FxBiPuJnn3TyGTQpkeFq7YqEsGL
	 gIK1/6H3Df3RA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 16:08:15 +0200
Received: (nullmailer pid 2563197 invoked by uid 1000);
	Wed, 10 Jun 2026 14:08:07 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/6] xfrm: iptfs: fix use-after-free on first_skb in __input_process_payload
Date: Wed, 10 Jun 2026 16:07:41 +0200
Message-ID: <20260610140800.2562818-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610140800.2562818-1-steffen.klassert@secunet.com>
References: <20260610140800.2562818-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-297696-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,secunet.com:dkim,secunet.com:email,secunet.com:mid,secunet.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAC7E66A1C8

From: Zhenghang Xiao <kipreyyy@gmail.com>

__input_process_payload() stores first_skb into xtfs->ra_newskb under
drop_lock when starting partial reassembly, then unlocks and breaks out
of the processing loop. The post-loop check reads xtfs->ra_newskb
without the lock to decide whether first_skb is still owned:

    if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb)

Between spin_unlock and this read, a concurrent CPU running
iptfs_reassem_cont() (or the drop_timer hrtimer) can complete
reassembly, NULL xtfs->ra_newskb, and free the skb. The check then
evaluates first_skb != NULL as true, and pskb_trim/ip_summed/consume_skb
operate on the freed skb — a use-after-free in skbuff_head_cache.

Replace the unlocked read with a local bool that records whether
first_skb was handed to the reassembly state in the current call. The
flag is set after the existing spin_unlock, before the break, using the
pointer equality that is stable at that point (first_skb == skb iff
first_skb was stored in ra_newskb).

Fixes: 3f3339885fb3 ("xfrm: iptfs: add reusing received skb for the tunnel egress packet")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_iptfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 62ba828632f1..aea63a000d1d 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -954,6 +954,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 	u32 first_iplen, iphlen, iplen, remaining, tail;
 	u32 capturelen;
 	u64 seq;
+	bool first_skb_partial = false;
 
 	xtfs = x->mode_data;
 	net = xs_net(x);
@@ -1161,6 +1162,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 
 			spin_unlock(&xtfs->drop_lock);
 
+			first_skb_partial = (first_skb == skb);
 			break;
 		}
 
@@ -1172,7 +1174,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 		/* this should not happen from the above code */
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
 
-	if (first_skb && first_iplen && !defer && first_skb != xtfs->ra_newskb) {
+	if (first_skb && first_iplen && !defer && !first_skb_partial) {
 		/* first_skb is queued b/c !defer and not partial */
 		if (pskb_trim(first_skb, first_iplen)) {
 			/* error trimming */
-- 
2.43.0


