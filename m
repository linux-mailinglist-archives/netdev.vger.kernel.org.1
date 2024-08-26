Return-Path: <netdev+bounces-122010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB11E95F8EA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD22831D6
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655981AC1;
	Mon, 26 Aug 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VoXbRkfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2177119
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696817; cv=none; b=gHi8oczscS6tyzhXyotAvPyZhnACmjMzvdKWTQrk4fDIKOFBC72e5LrOD1Rg+m5g884JuyJmr1RTPRicu6zxEE6gjisnmoKvRkHqpsnPxvDas3hO8mHoOyKNhGXKkpX4alw2sNzXlMaMwXZgEZwMnPV6uQ6/knRRlb/S4xoJfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696817; c=relaxed/simple;
	bh=vf6hjI1ICx8m4r7yxx7EU9Z1Etq83mh+tT3xC191mFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6I9zVyFbaQC0R0p8i2bwjfT+HxmB8m0UQOOIWsTh75rHvyAXYQMu8GMYEs2eNKDO4DkABtPVGmYcNE25vTpRDMuXQVWbdwhGFB68CZyidYLaXJudi5aPiSLEKlV+ZnZzHo/B4WIwoQ1IiIOET/1kr1DX3hP75O98VYnfZ0rjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VoXbRkfP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1e0ff6871so298757485a.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724696814; x=1725301614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMZCb7iB66Y1W1Ryns5DKj2T2TKMVtliIt3MIZTvWbI=;
        b=VoXbRkfPC6YByLvao3rshsuXAd4bLhm1OQLs/armIEswTBOQ04R/Uvcf72YHsLV3tm
         i0XyTRcvbr9nDF97dx4u2/y9vOFBRfSIwyXFum2ktcWpT8UrBw/gCKsbDpVsPmbyWMxP
         BGkt7aj5BXTFh7E6RrI3Iv2oP8IhGhskyVDsg4yfKK5O1NV+i72wxDDb4ur/JimnTKrr
         Zl8MjGEb8vu0sMR/ky2mN2h27F+MhjVo7F+Pyd/YOsfdONbgzPnf6yx/1C4ZHDHgCXzm
         F4gmYYi4oJTO2ymCC1Jr8CC6ChmfKWPriQw58zbKV2uwGhjHxNSZwu6jnsJDptw5BiWv
         rVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724696814; x=1725301614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMZCb7iB66Y1W1Ryns5DKj2T2TKMVtliIt3MIZTvWbI=;
        b=TJAv7UKtsbpdjx3esXPg67KuwcgVPuKvQKu9d2RZsWbqOs695Hd2091iBlo5YXAD6R
         6VugH2rkUv0tjkAkbM5qyuBoOWozzIgH/Xcf0Zv3xwwMWFGePCqk/jkom5uKVeCQsWAJ
         XlgcAHgUu2bKD7qBgEelzTBr6DEUnDckytQd0E/ico4Ath84KDRx0zAfiI5Fu2+/06Jz
         5OmLlAUBeknum9hE3HVAhAoIk87NTbIheIRTHuu7Ci4pTXgdKAw5K5xZLKLNm4unQh6H
         PNqtUSN8k5xfdX+7e7Y18/iojl1nD5y8QXgbSjjW4TdWlfJ0ulVGm1XpozATWYy2OQnb
         nSfA==
X-Gm-Message-State: AOJu0YxwitSDOeFJCEuB3qcCPlQSXTowVVkCnRKfzBVQRFwLMaDOTABr
	Usqc06pDfU8bXQDBStd52BaiktIUcPrTqKoWAz+u639hhjwCT7RfC9EYVTmYWogFpj8VeX6zME+
	w6io=
X-Google-Smtp-Source: AGHT+IGMbwrMjTB6suqc2Zw4TDMy5Z2Pr87vUDeGD69GcUGpb6D/dsdkRq53eYkvtU6pia34scjiQg==
X-Received: by 2002:a05:620a:170b:b0:79e:ffc6:c435 with SMTP id af79cd13be357-7a6897c4103mr1085304085a.63.1724696813847;
        Mon, 26 Aug 2024 11:26:53 -0700 (PDT)
Received: from localhost ([130.44.215.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3622fasm478294685a.70.2024.08.26.11.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:26:53 -0700 (PDT)
From: A K M Fazla Mehrab <a.mehrab@bytedance.com>
To: netdev@vger.kernel.org
Cc: kernel-tls-handshake@lists.linux.dev,
	chuck.lever@oracle.com,
	A K M Fazla Mehrab <a.mehrab@bytedance.com>
Subject: [Patch net-next] net/handshake: use sockfd_put() helper
Date: Mon, 26 Aug 2024 18:26:52 +0000
Message-Id: <20240826182652.2449359-1-a.mehrab@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace fput() with sockfd_put() in handshake_nl_done_doit().

Signed-off-by: A K M Fazla Mehrab <a.mehrab@bytedance.com>
---
 net/handshake/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 89637e732866..7e46d130dce2 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -153,7 +153,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!req) {
 		err = -EBUSY;
 		trace_handshake_cmd_done_err(net, req, sock->sk, err);
-		fput(sock->file);
+		sockfd_put(sock);
 		return err;
 	}
 
@@ -164,7 +164,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
 
 	handshake_complete(req, status, info);
-	fput(sock->file);
+	sockfd_put(sock);
 	return 0;
 }
 
-- 
2.20.1


