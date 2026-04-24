Return-Path: <netdev+bounces-280944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLW9HXcC62lsHQAAu9opvQ
	(envelope-from <netdev+bounces-280944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9641459F9F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDEF7300DF47
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC0344D8E;
	Fri, 24 Apr 2026 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6aRxtxz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD943446C4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009136; cv=none; b=blvvLYoeJ3soZWxLb4YXvKPK30F1yzYuAjBzd5T1JYM+T4kqxTARRwsGCKmY13Da7g67CdXBkdl0dZxN2A7oxT+87kq/lo/GUjFdl5SD7NdlxppnVa/QxQbcuznB605ZbVrJctb5Iy2+iG4cYNiLr5L4y56a37iNQr988o8Yw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009136; c=relaxed/simple;
	bh=hQTOTAcAM7dSAaT0JT96AMlFkrzDUi5FN0X7qA2AwNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhRyA7xyWnWaGQBubxPedcG74NBpT2U2Q9Y/G2X33JWLv1d/DfVY+62WX6/7BXrH+NmvQjxNOrFjCNGqGc8G2ewXNJ7v3tkmWTUbQ/6Cw2LvHlYePz3ahmvdhjY1j/jqMNnTajlz66A+n8MERDbxTC4qIQVurbkQXIxYAWWPwG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q6aRxtxz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b4650d5f5cso28142575ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009134; x=1777613934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlECDRyT4eHN/C8Ao43eaYpseh2z5fQuz0y+K5GaXwk=;
        b=q6aRxtxzj1OSp7X6Zpa8b908z7V3Go8QKnkJ+HfIhQU/I8jNa3ZQJIIgIsy2DQmoJG
         ynqwYmmUkz0jCZVL6wB+sL3fXI4+KF4QOPds6AJLW+BJgthFIrlHHhjtUWS1IqEaOJM5
         Jt7n7TII96/oz2Lj5gE4fg1bMbTPQS/OkKobt10jOOBLTCN9P5c7ISv6gQTPwm4Sr1nT
         dpTae+Ph1f7nsqzzhMFDX8cBJ8aD2H5SxSfqUhYrA1fsEjhbFaZGpUH7RjFgkev8B2qI
         JOc+iNoK/k2s5ZCT8i4JWPYja9TM2G50GSgg/5gKn0xWj4vshDM37dJpWCt8ryijwPHN
         TRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009134; x=1777613934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlECDRyT4eHN/C8Ao43eaYpseh2z5fQuz0y+K5GaXwk=;
        b=GXzmFRx0ginOLPeL127CMNtIivrBqePWI1b8w/v3C5fCEvfMyyA1PSYm0wdwfYI1no
         q3xykaAhFOZGxRTlwKe/bvJRrCw+1dX+v05GJ4v9hzFGguh8rYeVyETXe62ePToF0my8
         ZCMY4p2M8WUddUKRIHEfmzZoE9Lb6pZsBow89gB903vtwkqIU4JnietwMPIpuuZdyXuE
         ua/jNyNZCZsNDvF2uNM1vJ0oRiSsO2Tn6CiMLSFAd6jVvP2oytT2xDUA817p8ygOGYFQ
         kyRhYEuyQ/uRHRyf7chERdxWZcKwFaHpfojqWLaXoO+V5nkDD10ldaThxqkTIiRSz4I0
         q9Wg==
X-Forwarded-Encrypted: i=1; AFNElJ+zxug0joyBo/VOJyEmKZMDCBTewoondMxIaToJCSASXk6xeojrfMgfOFBu6VG/PDSIoS5mlgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAY4aqpXerKV4Sd9RhGIpnug/b9dWEd/w6wgeqdQDE/Up5PcF
	IDKdb4lUXF2RBEjd4P5XaPceLUwNYxRuOd98qHi+itDx3cYEw5Ftx/BMmOfWPOGcu+HbWw==
X-Gm-Gg: AeBDiev9iPYc0AQ+o3iz+cD36dA93DZ2IIrRu0s0nKudjXkGj+Y4QNi4gs/3AddS9Db
	vrY7RQeyQKldZNYFVF6E8jGg7uwkHo/pC/yL+404uBvmUU76evJt1oYeok9+VPeUng+O1zywKQP
	v4SrBh0q76JpMEBrZ5pGi8Jd1BYOj1kUjGVtM0UDP14GmzB4YEVRJ2UPnyBDfZBhx3fsNEyjMoP
	IStcDqb3IffHtwYzrgbymhvZzdNam3tZBm7Tu03y/fnn57GF0/v1eZlQk0eNEcOQy8AK8dzU4h4
	H8Cd4wWPExoTaLuIMm2erPczznKeXsjtqy6cbbdsVUXObOY69N9uvSlgVPvZJx8ZloK5GR2PeD8
	E0Qp9ePt3poB+T0i4EPKn8m8FQvQNCyq99miUm5CMtlod+2PrXcNbMXY5hZqYo4dOMh6k31uXdz
	tBsPvjAO3oYofwW+bPOxn9JwBYzu++gqCT41VaB4QWc1TKkoQ8lG4Ri8Oho9V+/0WvqlAy0ZhhN
	y6zgtVLvHJze2HTZmlpgX5idXei283Mf5yHdgnh
X-Received: by 2002:a17:903:2983:b0:2b2:57ee:c04e with SMTP id d9443c01a7336-2b5f9ee2d5cmr303296495ad.18.1777009134654;
        Thu, 23 Apr 2026 22:38:54 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:54 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 6/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Fri, 24 Apr 2026 13:38:14 +0800
Message-Id: <20260424053816.27965-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9641459F9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280944-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index c49b58199d2f..5e6326e076ab 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -776,8 +776,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3


