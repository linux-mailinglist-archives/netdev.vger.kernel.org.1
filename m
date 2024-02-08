Return-Path: <netdev+bounces-70178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F884DF89
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510751C26C00
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372C6F06E;
	Thu,  8 Feb 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmE5wkGy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D96F07E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391015; cv=none; b=lM9Ql+l9WXz+YNeVFoBDod0erM7FQhqw0CWDbAJQ+bIB+8B9sUS+GHUNFqbznNvZ4XnoPABuCovYw+n8tIlREfszwOq+w4Hew3Y29SO466becSVaBHFlixkkGhc5mTZ7D0/SvDZIlFkuSuqcb+qIufUm4nT+mWqxFvq7W39zkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391015; c=relaxed/simple;
	bh=CbQN6xcbU0b/bO5BcxS8jUDfGEhVbCo/V9vFS/KWTdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kKLyHyuR0Kks7eXhYIeAyTSUZhxMSMyL1X03s7hUIIXiBB0dxNotFZaH7OyWDTXF6+6SdN4/UNX9q4RacidHEfymU8122/xrTtchM7PCsJ6W+AKpi0ajxdQjE5RI0I2KRcCxq6ocN33ZOScaQXaP0ObK/zGAlIicuhcuLLyNsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmE5wkGy; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-785a91f4c28so36917685a.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707391012; x=1707995812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4sN2AtdWoAwYAK9RlB7jQ6bQLlakZmg/ZTHp++Hfmg=;
        b=pmE5wkGyHbOtoW9qg6rHIdpHyNDMSnAiZQHh79WTFdmJPOL/e88aVX0gwixdDCswH7
         9/E8erBO2RMIBbmkwhL+PIPaT5CwwYMzV9huQCgm99VAR3JzmbxOUwfUEzZS3iotxqRb
         BYy9RGJ4QC4kGvs3HBzuj2g4JWdFmfOUYQhuEcFK3ffAWPBd2su5YfcNpeLsefBRT3aK
         oD90n4uSIdPpWHw7FG3MZQnehwrQ/FSg8Ix5Sl0A6EuhzcbX1ckv7TxqiXoX4SHVddsA
         9sqZa6sYziZOGcSAWZE22jIRBT51d10FXIQT5jN5djjUu12ll7asKmXJ4CA9RW+jZkPo
         AXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707391012; x=1707995812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4sN2AtdWoAwYAK9RlB7jQ6bQLlakZmg/ZTHp++Hfmg=;
        b=svki08FnrG1X01p3cqtH8oaSjn7wfthF9dXibLOOdJL6gBVEu/iTp3zrIQLd7LwnzD
         zCiTpbg3Kuhb2y4gd+cEbEhukVvlHMarWdfr44WDoI6Lx/tgqnSpd2/2UPzzYNc/VlJu
         pRlF9puqoOGFP75cLHxDLkJimQMKodihxXVN+3H6shS4foWZpU2TLMGHMvighjV1OXpo
         UAjQIXYniTiiLDodoxodnvRxffIFioSd/vGsKlwgPBAugMgGQc9CQo7G/0EL4iLpA6wj
         i72a1eEAGdLCldHBm7zoAgTDQlaYmyEsCf4/9QO/i7n2hBg0YNFvfLO4r1vP95TsA81R
         fstw==
X-Forwarded-Encrypted: i=1; AJvYcCWHNwxePLsRHdnat4a4bY84dGvLGd0gVYvVeRCjayudp2+0gMlV2Zsaxpj4ABc6QW+B6t8iVerzO/JT1kcKHqimiRdQhmS1
X-Gm-Message-State: AOJu0YxTtQ4f3HWM4UwzLQjJIC4ozqZ5T4vJEmB4mcc7ONV0l/fjMg5y
	oIPrdFIhZTXq3I9HYbp+JDRbxesFkkf7Y0DrzoXuc5XNpRG6J1f1VU9YlxiuR5w+Ims28rnP8NM
	H4Ak1ddXxmg==
X-Google-Smtp-Source: AGHT+IEg+6xWGELdbDDafeqbhlAvL3fhxYLPY3nPlVOHpUqG58h34I2ZJxvjnCMTkOUrCsjVVsDIQ4PltVc7Hw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:2112:b0:785:9e3c:2097 with SMTP
 id l18-20020a05620a211200b007859e3c2097mr23940qkl.11.1707391012439; Thu, 08
 Feb 2024 03:16:52 -0800 (PST)
Date: Thu,  8 Feb 2024 11:16:45 +0000
In-Reply-To: <20240208111646.535705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208111646.535705-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208111646.535705-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] ipmr: use exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using exit_batch_rtnl method instead of exit_batch avoids
one rtnl_lock()/rtnl_unlock() pair in netns dismantle.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3622298365105d99c0277f1c1616fb5fc63cdc2d..708c79c465e7212d24d2eb74165b227b9bde1c5f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3119,20 +3119,19 @@ static void __net_exit ipmr_net_exit(struct net *net)
 	ipmr_notifier_exit(net);
 }
 
-static void __net_exit ipmr_net_exit_batch(struct list_head *net_list)
+static void __net_exit ipmr_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
 		ipmr_rules_exit(net);
-	rtnl_unlock();
 }
 
 static struct pernet_operations ipmr_net_ops = {
 	.init = ipmr_net_init,
 	.exit = ipmr_net_exit,
-	.exit_batch = ipmr_net_exit_batch,
+	.exit_batch = ipmr_exit_batch_rtnl,
 };
 
 int __init ip_mr_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


