Return-Path: <netdev+bounces-273875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABKQJj+TzGmbUAYAu9opvQ
	(envelope-from <netdev+bounces-273875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:38:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06573374712
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9606300CE45
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F31F4176;
	Wed,  1 Apr 2026 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb3LisZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8F37CD4E
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775014351; cv=none; b=PIoWPFGq2rLuV+RoocXgPyxLPjSSU6fNS4V2NYObJap5mkSs/EuaUjzTwTU1FHgkDwNXNmxF7obKJi6lQD2o9x23rQ0WRl0SbJRk5zOjf17rzYvLi2SJGxBwBnHDQ2NRSTqkPvLjDeXEl+rDdXvnH8bikFaiWPK9MLdx5YKAP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775014351; c=relaxed/simple;
	bh=wnJsnJU64ADqx4/tSoxZYFtmhN0btbYPUKoYC/ebkAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMgN5x+9/3UF9YSpmRUBgptBLUqVIkfkFWkHInOvdGUi3QQXi1BFOt+fv/ugejvwJRRrFIvyGGSP9LQUb5p0lSNJzvxvP9VH3Embgg9SdLXHxmVPuOFGbVWMxCdDuowKlkdPoe8jkCprhd4ysQJd8iGiS1ULFwYeEbf6qV9YGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb3LisZL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82ce09b61beso522367b3a.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775014350; x=1775619150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj/WGRj2hrcyLz470AN1pxvEeG/u/RZkFoKoMJL7Gu8=;
        b=fb3LisZLDjrVFhrQKWLF3iRzK2l+CwlAnKZOZsXYa9ejYR6VSQ25eISA02z6EPCBNW
         RzmPbwHn0q3iqFAwVMotv6H9fsrbPctccfaB877mhw7KLevuBD6c3TnqdJwsdVkoqoRt
         8BDJxghYhVleWFPIfefltKZAn/IZYXhtAwbZfOCd4B1x41BO02H3g4eorM6iXfJQzIfZ
         fKyJWlhDChHXAY2E2Rnrk6S5Y7t1tAGYNMiU1uZBmcJuxZhsNyfELtT6GJYTDLY1wWci
         1sNoCAuc2ahnsKm5VwP/jLrMycGWLrZTf9pJ2gy/CEtSBCl5vr9k+MxHPejmvvRhRg26
         p1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775014350; x=1775619150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tj/WGRj2hrcyLz470AN1pxvEeG/u/RZkFoKoMJL7Gu8=;
        b=BaJAK/cTHoFtVaxTAAcDjFbCMPyAXVp07DXZzl4DoS1K+99HNUCRfI3VGBfoiIx8jN
         zOAzS0YpB1FYo16pJhl49Igeo9LCyA7KAuy4Bl2TD/FK1M3O0mmoTblGldpCR/6Ljrvp
         ZyhvH9/3MIOs1lpA+57OOpp2TaIvr2uKgANzdIVC/M6Hh+PhveD+QQl54sN9y+9SBA7G
         cNRYX2jijgEq45Kwqi0DjD08C0d6KDZQeDQ/uMAhRpP0tQTdN1qiiy7MvotqE2sZ9Ati
         DH81pqA2/eNXepbg27/4R9LyJ0EDJf3mwWRDIad28cj6jlTDzEdpxYMiwvcDGHlqpuiX
         s/Tw==
X-Gm-Message-State: AOJu0Ywri8McgkjTGxoBWKLTxLZsXlVNiLQ7hvFgymwXA0r+70RYaR/0
	FDtZC73d0dTNbEVVmbI+p1GLgGhiiDCQAuVorGyh6J7gtaqOog3aaBXc
X-Gm-Gg: ATEYQzyXDVW6Jvntirl7cbEqWG5nzJw4NAdybzl4u8LbYkmRkaARV7Hk75X4Co1lMlA
	gx0gjUdlOjla9AC44Aj9mYjvbjd5Ekd0ZPslOPy8ueRTF1BI+8mBGvXFFvd53NNHsCuJ3AXm3p1
	Hu7VHIYrx1A+dmaN8K/0+MEIsFun2KYNjS/jVnxBQD3LmdQahi7bTI01IfVxe8XMCF/3XXxQMpL
	xXS0q6DX13Y2mpXEdRTkROY1HVhoORFTMqVQAycli+G59/lH65K3zipe8ofbzQ6JoDgEhVHMpJF
	zbLb/lAs8Zajjdt/ndNaIvFFsajF9z+tNxyN0Pe5ZHl6B9yNELIkGos81UinK0kxZlVIjwAoFWD
	h/HHR2/QMKWm9GPDZ2jZG6P5iSCoTCzX7uo5aH+48hdpBNAIMEXGON1kaDGasq7yMOZXt9omRf+
	Q+bG7ax88JE7kfSgXhZqaCh7rOHZ4G0HV0Y0ZChtIUM1/uMlURHcgfasZH7gcEw/niEATtyA==
X-Received: by 2002:a05:6a00:2d08:b0:82c:dad4:44c8 with SMTP id d2e1a72fcca58-82ce88ea943mr1900236b3a.11.1775014349627;
        Tue, 31 Mar 2026 20:32:29 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf3f1c20sm13453141b3a.12.2026.03.31.20.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:32:28 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v3 net-next] net: advance skb_defer_disable_key check in napi_consume_skb
Date: Wed,  1 Apr 2026 11:32:11 +0800
Message-Id: <20260401033211.44463-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273875-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 06573374712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

When net.core.skb_defer_max is adjusted to zero, napi_consume_skb
shouldn't go into deeper in skb_attempt_defer_free because that function
adds a pair of local_bh_enable/disable() which can be found in
kfree_skb_napi_cache(). Advancing the check of the static key saves more
cycles and benefits the single flow/few flows workloads.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v3
Link: https://lore.kernel.org/all/20260327153347.98647-1-kerneljasonxing@gmail.com/
1. use a simpler approach to avoid adding a new sysctl.

V2
Link: https://lore.kernel.org/all/20260326144249.97213-1-kerneljasonxing@gmail.com/
1. reuse proc_do_static_key() (Eric)
2. add doc (Stan)
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3d6978dd0aa8..c1562ba6903e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1519,7 +1519,8 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 
 	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 
-	if (skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
+	if (!static_branch_unlikely(&skb_defer_disable_key) &&
+	    skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
 		skb_release_head_state(skb);
 		return skb_attempt_defer_free(skb);
 	}
-- 
2.41.3


