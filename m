Return-Path: <netdev+bounces-247357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31024CF84E2
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 13:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 255973016657
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A4530FC2A;
	Tue,  6 Jan 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2E8Nvme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFC329E60
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702264; cv=none; b=X+Hy3rte46iZGbkDYdYlip2fUtx8u+ZBKzavcrlqeR6TQE5P9ZLaVxK/8dr6SkWo3BmxmIifm0pzp/fUt8SsX0NxAvMH/otsRdV+E7aefyNXrKj6OlvG3kBCbHrz1gtt1palkpCMB5JjXdLkLgArytHmfK7n+OasWuzAFM1S/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702264; c=relaxed/simple;
	bh=JlzqUYVrnaHz2InO4ctyOyg/bXoPXsr+fDkAXeijmog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTpLoqvESqfYeNtqujyCHiH5uu1KapFrLZxshC1tyAbHgsIsoMqco0adwobnuypSAriII83oq+fvQmEwtpuogUKW70H+V/MUUdYp1WK503fMzT2T/WAKkBTrJgBQyPSMqZd1qMSJNMeHCApJrLJgVejmtKZR4mGdPhxwkkfWgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2E8Nvme; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so750601a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 04:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767702262; x=1768307062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kB/rXxT1WWg4PHV4NRzo/SLXv+EVmzodXTSgH+OphrE=;
        b=a2E8Nvme9EpBL9ubeLjcOqxVi497ZlEPxxihYRbtcWv6EeQ6NR28teVjsbzApUVWp2
         NGIdw3mPn9ONrn2NN/cTxTX49RXECuDWnHIWbVi5vWisJe953CJzcIoFp19qq5Cu8iDQ
         IVlAO/C35FV5XHhvxFpyu6YbFdcpqezeUAdQOEqCtcWv7HvLNVrTzpXNsMYdi7gMjsnK
         2tqv0hbEIJYrdjPu4HJGfvjufkfXDw7DS0VcjHvIeQqyYKzjnlAoL4IBJdhV3TGb2jcw
         BYIEiO68BROb1vK1wLDltHW4xs09cTpPUfzEudnSS+XFkokQqu4kow6GN8oA26WCI2Y7
         XI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702262; x=1768307062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB/rXxT1WWg4PHV4NRzo/SLXv+EVmzodXTSgH+OphrE=;
        b=S4IaBsKka8om5a5Hu4Ps/jCVRzk2EGjoaTaAy+rtJTz8YL0qUZKXolHyJWUeiWf6qV
         khQ90k6lep9LYBE9/pFao64KxlpH3j8jhYhKn6YRP/31uEG5pVBVF8t4LmniY6yMNJiq
         CXVdZoDy5ay+nDohKWaZhDAJJVNCO4v52RSuQDmGOV0VwvK6CAmqhb/BzBOiQl4edPJz
         iQva2WLL+bqVhHCgP8UrhUmVpPQj2RHQSOqvMp2eIReTTsg3DpPraed1MsJpxY3y6N+p
         oBpP/b/Lq7zXjeUGTTEikoYm1bcT9oo+cKgJTD28Wcns7bskxhh83YZsVvDeIc0s6Mb1
         4sUQ==
X-Gm-Message-State: AOJu0YyK1hgZyZFMbX6XQlqbAoBasInaa3GWhniAfxnz56uLJksPkcrF
	YG+1mWEu8JkAoq8nbPqLSTp4fekuH2G1NBiKR5fGNjAfng7XTukDDFWo
X-Gm-Gg: AY/fxX5m7iO/FyW7Fx01EAhY+w/RZHPgI0PUuqBOMtpLYK6BSFmRCuYkRyyT7RxZyXk
	IIwoRrSWHyqCU/T2n/htR7UEAWC1Orr6yKXook5kRUT5b6+bzO0VVlo60DNoOSDHGO4vXARznrp
	Metnp4Sv8FYSqojMHUgvh9hRsDtfmcaCJx0huiSaYqk9z06UCvaIkALqYpSc882l3ZCmRo24+TE
	+e4ktgFcDB3Fgn3mL8S6eHXMJSsHbMW1t+KY5HETIoWQxkIhZ4BUCLplSQtpQqGgNNPHVRreVpz
	bv9GHtCjGKv9rbaZcQ5jrxAc+7t1jXS+oR8F+9ergYOR7MIOW+ejAVvpXLp9dPk6MHXvhp4WIP9
	qKiSwD+AP6IXL4WY0v47GmZIgqXLA8Qn+kO5/Er8tH/heCFT2KmjhWH6KqyxS40/C7XVPAv+m3D
	6GNwmyHNhr
X-Google-Smtp-Source: AGHT+IE5qO/QJl5wEvjvpnvEPFTM4kWVtH2dV4GxlRkpfZ5jyYcH8cKefSIihAbFLcNxTEcNkVxuOw==
X-Received: by 2002:a05:6a21:33a0:b0:364:13c3:3dd0 with SMTP id adf61e73a8af0-38982334d2fmr2587649637.36.1767702262563;
        Tue, 06 Jan 2026 04:24:22 -0800 (PST)
Received: from mythos-cloud ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfe1ca23sm2311982a12.12.2026.01.06.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:24:22 -0800 (PST)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net-next] net: dlink: count tx_dropped when dropping skb on link down
Date: Tue,  6 Jan 2026 21:23:51 +0900
Message-ID: <20260106122350.21532-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increment tx_dropped when dropping the skb due to link down.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 846d58c769ea..edc6cd64ac56 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -733,6 +733,7 @@ start_xmit (struct sk_buff *skb, struct net_device *dev)
 	u64 tfc_vlan_tag = 0;
 
 	if (np->link_status == 0) {	/* Link Down */
+		dev->stats.tx_dropped++;
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
-- 
2.52.0


