Return-Path: <netdev+bounces-273749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMxBDTI5zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:14:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E13717B4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4EF3062491
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8244CF25;
	Tue, 31 Mar 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqP47ucL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C843CED5
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991260; cv=none; b=G4YRaWkJ82grDL2yGfTA65hcGGI8rvEB2YRfQVfbnTV7sHpGVFAsR/jvRVPAeylRRKQRBORo/LVxB3Gb8gL7AEhfycqeSEixJWwco3BTTKhu+sJPLglvsZKNDPI3cmSrJ63g+9eTI/GuH3F2Oa6lJ7pC1BbnhPQQTyz44ed3VOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991260; c=relaxed/simple;
	bh=UE55KhM6GuZncb7T3BcNm6ZqBpgyiOIYY+HsG6tJxEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDTX9CMjLNXW0xZ/k5a0oWeEnjVtQnmufp/JvWRuO7VYXLGF27U41VEyPcezW0G1fnauqlWE2nuWwp0jTj+HYu+gKyYzBkTN4Emv/RaSB9bMGpbJXlPYeUvIb9cAC1OZUt4fE9/fkfvZjHCRyZSWJSMDVo5VDf9aBtatBjucSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqP47ucL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso76751585e9.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991257; x=1775596057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCiRS8aWbO6iZJae5k6OeoD65iJxJIA1uOfxsYtE9pI=;
        b=FqP47ucLsKwsYkQ6JB+qGo8HTMFU2G6+T/Nww27GTH4hzG59y1zohhGa2Iz1Y0Ay2t
         2M2i/LCR//RLfu4bWW+n2Y2KP78eCK9ocfvuRuWbUPJimsrllkC7tHbyKbmIo+U3y2sR
         Mf3Ox/T6KqcCrURPvT+pKycPB79qEjACuMpR1hBmHJfYs0H9p/qERQCkxi7uf0pZiQMZ
         OA7OoempT0hfMkNa2pWtiTpMv62VEMXkivnkFLaTBl3Eg+rWNd9kH6mENu8zIa/R+5Up
         a9N+lm5DMxtsdckk8w2iD0otTfRyhNsnEMI1jNMkQxxSVEPXsyB+JbCH99Kcz3fLgqON
         MVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991257; x=1775596057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCiRS8aWbO6iZJae5k6OeoD65iJxJIA1uOfxsYtE9pI=;
        b=QMaakEfdSTvrYaKW2SaeN8xlcQkll/nkP4Xax0P1g0F9u5PPylMv7n01TAe909XTDp
         EXV70k20HLKmephYB7HjIF1RoWiKvgvmgxltvR3QDqJOCgspxszS4+JCRygNFVkngjMQ
         ME3kS2YeQqTPj16ayfiYa6XmeRmf47WuGr2Oa+JF9rHWPHRyL3EA4cuBnVSo8ru9VddU
         PJgTxgX2ajsASM/cUbobijFZJ1zc/i8+noOq++jvjJ0rRGc7t7IuSAyeoMMT7Xo4vnNI
         3gdc/8yvA2vFr8wmut0dsi4P0X8Afz4TnXN5HdCVgAFuMpxhQDK5ar6sKjo4o4VZEXaJ
         toLA==
X-Forwarded-Encrypted: i=1; AJvYcCU1JGj2cCtvsaPb4HC6zWi/DyUHFM7EfJHsssEbaxe2OLJm4ngf5RDmQr13aj/dbHMlMKTVEBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OeQ4GBsTcTFs7XPojQ125SwCe2gIn/HEIgI6HW9pP9SfLUXx
	HJ15vRLRn7shD9ZmuDqlhrqPlXDFQHEUnBGItK/HZB64aDON41lImPgW
X-Gm-Gg: ATEYQzxucXJhNES07VfIz/Gg2RNHLrP7mHbpIzeRZcPOheHCDOdcslJeHNcqELym4sX
	AJBOC/7GzXZqsC3Qn70o54vkAKcc9Krx+7v4IPB/fjHAlSV0U8Sbblv6TURQoMDnXavQMi57ZQZ
	zHnL1wTxA8fS9DnZVJybO1EIHyuttht6qK1qJ0+/gVAykoeB9dspcw0dDBLqrAbYKFR5da/rBcY
	EsbwGCM4LJnK14DrQKQdSLFUmjslSTAQ5tPu8aIiW0gELBVam6f0bxo52vBsqZD/JJngDhown65
	NUOLIFyGZy6IbLq+nTl4743fyhlM/Q32QO/DvNiju9Jzt6+3KSHLpI2wBSZ9tKIL3A0PjartPDY
	/6b5Dp+p7dhqNvYyMLNTUDIjLILPPcZuulg7lNYKCa7d5UTKEqK1HqxJL+Qvwnq9R8IRTapnaOn
	a1GeDJJZfMKnCVVYhlsVY/papckJl3F3NSj4H4aIGoOynXmcO6HwAfOp7lN+ofykXlHTnzlAo6s
	Igk83PirEZblxKNnFwBBksxWlVsvm6KZgyFHejV
X-Received: by 2002:a05:600c:c056:b0:487:300:d9ca with SMTP id 5b1f17b1804b1-488835a5998mr10223415e9.31.1774991257520;
        Tue, 31 Mar 2026 14:07:37 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm32431393f8f.31.2026.03.31.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:37 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring-7.1 v3 4/6] io_uring/zcrx: don't clear not allocated niovs
Date: Tue, 31 Mar 2026 22:07:41 +0100
Message-ID: <cbcb7749b5a001ecd4d1c303515ce9403215640c.1774780198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774780198.git.asml.silence@gmail.com>
References: <cover.1774780198.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-273749-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 817E13717B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that area->is_mapped is set earlier before niovs array is allocated,
io_zcrx_free_area -> io_zcrx_unmap_area in an error path can try to
clear dma addresses for unallocated niovs, fix it.

Fixes: 8c0cab0b7bf76 ("always dma map in advance")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 5c0a49340722..d84ad40eae49 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -289,8 +289,10 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 		return;
 	area->is_mapped = false;
 
-	for (i = 0; i < area->nia.num_niovs; i++)
-		net_mp_niov_set_dma_addr(&area->nia.niovs[i], 0);
+	if (area->nia.niovs) {
+		for (i = 0; i < area->nia.num_niovs; i++)
+			net_mp_niov_set_dma_addr(&area->nia.niovs[i], 0);
+	}
 
 	if (area->mem.is_dmabuf) {
 		io_release_dmabuf(&area->mem);
-- 
2.53.0


