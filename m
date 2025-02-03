Return-Path: <netdev+bounces-162219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FE5A263AC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0330D1667B9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789420F071;
	Mon,  3 Feb 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qszbztml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AE20E71E
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610253; cv=none; b=kNmx2xbPmbWrHnbIEUw3mMSND+G0346FXMRD55v+knc+dXIm9ydJhJLKrBDSkknO/nwowxLLGg+PPYpA2nBqr25wYbBOE+0lE3Jja/OdKifvOKZIJLSzxk4LaOXw9fsi5Bik23OENLlhyUS6tFHe6qCz4EiDKWV4SGvq+YQhMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610253; c=relaxed/simple;
	bh=UQ1+/UhYDCAc88I4jH9qhRA47laIsXE39uyV/T0ipVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R3s5PvhrnKuqWZFM15GuvMwajlrDSta8kzOs+wYbRI7lTzPZUKdSa1MVuEMUmg6hDVFzahrLWfLsienfv0vccO/2kqKPklCy/2K5EEcDYEX2yQhaZN/x6trTPwfsBSEabFYO9fOOa84ghcvL2D6X/QGFzHVqcW924JzhXzUDhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qszbztml; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21bc1512a63so91768615ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 11:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738610251; x=1739215051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ma8oDYqKo7lDdjgaSZH7Zvfd+MYM+1MHiJpHOWnUAKY=;
        b=qszbztmlNfYs65wZ1+iDR60XzrYiYb+SpivpCcd5wP4G8Lze9QrJRcB8crAIZJlsG+
         78rzDzQhOA/3woKITISN9L2ZXNy6kB/BgfOfyJaeK8pSuy+N2kfSzQrzYn0uQ5Ea167T
         R4Q3lgIVoGS2xRlpzv5Win/3jT34du/VfcH+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610251; x=1739215051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma8oDYqKo7lDdjgaSZH7Zvfd+MYM+1MHiJpHOWnUAKY=;
        b=j4DcK1nTOtckSUVJIT+LTraJTxcNFzJXk+bO8eQC/oscpF7AE7aGmJmM6BEGZczAjF
         skhsNrWM7an8mE2bv+ZVm2L2fPBvhTFxWudKex1q0olkyZ54lpeX5z/zUgpaJMuawEbM
         ny/8plfOnqXNmM1cXERSFg84r2ChySB0SeK9EEb0cR/BoPo2GRkrbPKAd/YIRs9sacsq
         c3T0XiQH2adcFQl5c/zJHm1wKtyMjTqkwzq58TYQy104zrdaUjEG8lfmGwUJ6E0TaaT5
         BnreWoMb7Teg8Ri+3oswzB52aowsyuXXoAcOrFM1BXBxl8cRkzS1q5sS7xbuNKMJlMxl
         UFSg==
X-Gm-Message-State: AOJu0Yz+y9bdQVij5sUW+iqdWplQmLerdjCHisKq88aepzyCbSCW2Age
	H581a1CcR656MnoK4itknY2IfO5ru8PShtq9feM9Qk6k2Ohg1Bjuv9wKSdW4Gcp1r9nBk0jg+EN
	NLp30sMsBeF8OG4fptx7/3iE4IX8e567TEChLswnwZW/iwShBPkzmoQVLSIhowTFU6OYG+FVbDP
	WePuu4QoLpIAuotAC+EPe4PWcTfiuM7Bb+9dg=
X-Gm-Gg: ASbGncuLmA3o4dfCOKv5MsQxyVlWGU5IreGi+O//A8BUey7ufHaj8gMuGlCPvlZDDdt
	7roF67mtitOwUahxsyCrLzVYxOUQBl5/e8fcVoxMxBAePL6NbkTdWfSomFNCHS+Mmj7gUvAU/Fp
	ppm6LSf3nhf63JGwra+ohJrvruDYwSxgtGrkcY99XLj2KV/Mt60Rzt36bgyGdFru/cFPMjjr83E
	kw/zAIYmK2npw71B06k6p7UQPP0hKwfMMnyVvdTyMmW+wUV+/kLCvKnx9E+6+tH4IpWj0m/gxJg
	gsMI9Cv/JjXzAEtgELUEtXk=
X-Google-Smtp-Source: AGHT+IHzG6PqWTcyGDPpk3jh1F2SSoETgcl5mCtn5/bNJ/NqYro/MRaiKmT8q6TwTBoZ+pejU4zr4A==
X-Received: by 2002:a05:6a00:b95:b0:72a:a7a4:9c6d with SMTP id d2e1a72fcca58-72fd0c9da62mr38596585b3a.24.1738610251091;
        Mon, 03 Feb 2025 11:17:31 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba47esm9046550b3a.96.2025.02.03.11.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:17:30 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] netdev-genl: Elide napi_id when not present
Date: Mon,  3 Feb 2025 19:17:13 +0000
Message-Id: <20250203191714.155526-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are at least two cases where napi_id may not present and the
napi_id should be elided:

1. Queues could be created, but napi_enable may not have been called
   yet. In this case, there may be a NAPI but it may not have an ID and
   output of a napi_id should be elided.

2. TX-only NAPIs currently do not have NAPI IDs. If a TX queue happens
   to be linked with a TX-only NAPI, elide the NAPI ID from the netlink
   output as a NAPI ID of 0 is not useful for users.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Updated to elide NAPI IDs for RX queues which may have not called
     napi_enable yet.

 rfc: https://lore.kernel.org/lkml/20250128163038.429864-1-jdamato@fastly.com/
 net/core/netdev-genl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..a97d3b99f6cd 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -385,9 +385,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 	switch (q_type) {
 	case NETDEV_QUEUE_TYPE_RX:
 		rxq = __netif_get_rx_queue(netdev, q_idx);
-		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     rxq->napi->napi_id))
-			goto nla_put_failure;
+		if (rxq->napi && rxq->napi->napi_id >= MIN_NAPI_ID)
+			if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
+					rxq->napi->napi_id))
+				goto nla_put_failure;
 
 		binding = rxq->mp_params.mp_priv;
 		if (binding &&
@@ -397,9 +398,10 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
-		if (txq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
-					     txq->napi->napi_id))
-			goto nla_put_failure;
+		if (txq->napi && txq->napi->napi_id >= MIN_NAPI_ID)
+			if (nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
+					txq->napi->napi_id))
+				goto nla_put_failure;
 	}
 
 	genlmsg_end(rsp, hdr);

base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
-- 
2.25.1


