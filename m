Return-Path: <netdev+bounces-94036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E48BE003
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2028AFE1
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F960156F3D;
	Tue,  7 May 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fNk8CNL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CC152E17;
	Tue,  7 May 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078689; cv=none; b=mWbCRHjnYGMzVvK8Z5lEXFPe5Y8k/mQfeUAVQJb/qX1fjKfudVkOGP/Ji910cWzlwEJk7eJMtdQWxNvIKRNQ+jQjx9ziTzk4QbMxz0w+frGyoq9cmZBQGTYomErwi6XVt8GoNPTPV/7OWfmJsckbnP+ZHKMn6psOFWFrKLyTSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078689; c=relaxed/simple;
	bh=JfbhjlW1KWkqWGqmmmMWFU0X6uUALH+EM6KsMRvG9vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhlB8T2uxPK5zhh6suNxm0DrMWtf2yZSfAbnRwGK4OGo8aPsGHVAtQvyday5u5BCX8NOIwUGanlRfudnDyzOebtFgOy5SaB8SHh5VHzbznvZa9xr+0j/n+g1TCMO/mZMC+mYFOVM8Pi76X3hnSikCKq525O9vz59ZcKOSnhIn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fNk8CNL1; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4311F600E4;
	Tue,  7 May 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715078675;
	bh=JfbhjlW1KWkqWGqmmmMWFU0X6uUALH+EM6KsMRvG9vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNk8CNL1807Ra60OPGQxuklCAUAm6dekJmxkij1kciC0huXY4fT6Q34WKbXIJHHdq
	 Zv4pR/SPAskXRVbWelf+DLyt49iECvFOQTBMkOlk+afU4gmWIEAQxFQeJdl4ZRrAlx
	 l3sFBrlmMXIGE1dtXFvn5VvMBmwhyaUTR2Bkiq3e9qsZcJe5hEu3SElSQrRVYWrY/3
	 p15kFKgsQCrcCZk6d+FVRQ8G8j05D/cCWw6YeJpCoUmoGw0XJYl+fpJ9Jj5HEYzHwm
	 /nDNqjtZ4S5nftIqbF5scbkVA/YT7MBqkX5xqF9VCRw3WLc+wwVHCbcX8XW85ntvVr
	 qySbNBKOj3mZw==
Received: by x201s (Postfix, from userid 1000)
	id 78A332040FE; Tue, 07 May 2024 10:44:25 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: [PATCH net-next 14/14] net: qede: use extack in qede_parse_actions()
Date: Tue,  7 May 2024 10:44:15 +0000
Message-ID: <20240507104421.1628139-15-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507104421.1628139-1-ast@fiberby.net>
References: <20240507104421.1628139-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert DP_NOTICE/DP_INFO to NL_SET_ERR_MSG_MOD.

Keep edev around for use with QEDE_RSS_COUNT().

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 7789a8b5b065..5a3ce86fba1f 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1671,7 +1671,7 @@ static int qede_parse_actions(struct qede_dev *edev,
 	int i;
 
 	if (!flow_action_has_entries(flow_action)) {
-		DP_NOTICE(edev, "No actions received\n");
+		NL_SET_ERR_MSG_MOD(extack, "No actions received");
 		return -EINVAL;
 	}
 
@@ -1687,7 +1687,8 @@ static int qede_parse_actions(struct qede_dev *edev,
 				break;
 
 			if (act->queue.index >= QEDE_RSS_COUNT(edev)) {
-				DP_INFO(edev, "Queue out-of-bounds\n");
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Queue out-of-bounds");
 				return -EINVAL;
 			}
 			break;
-- 
2.43.0


