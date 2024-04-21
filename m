Return-Path: <netdev+bounces-89882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6608AC0CF
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDD61C2085D
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C093D0D5;
	Sun, 21 Apr 2024 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjsfPMdy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B37E6
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713725877; cv=none; b=od7A6kgjYj6SY66RSBE+b4/tGVZWLi/okcn1O4qkDlkjVSRpXJM7klcmCjqkEwcOjDuxCf7EGbePd2gkzm9prw6YeTTCh1tlWnW6FEZ1KPuQyZur9aYKXaudoQU3QKnhfgRSUCxDSbWn3WpitcbZTQGxi4st0XcoU6vuIaLfP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713725877; c=relaxed/simple;
	bh=vgg2edpB7NkgE7vKYun5OY2GBnZeaGsZJAzfjP9OqDM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QDWeVGsUe5h/5vpfB9va6WN9qxwGdecyg+nW4zFlcOi9tzsfcYRfLxXvKtozYfcH6pUdWlNwRfIlXIZ/jqGLfBZji6VNNogzYrD2TaXY9D6l49PMEE43GJjHqSjX6P2WrSYTSe0uAb69IOWw6Hnws+6AfJotaaeU519kWLjKKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjsfPMdy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so7663970276.2
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713725874; x=1714330674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LkqPGQ54KoQX9FYj+4LiBoEzxd9T+rpddbApRBQr8w=;
        b=hjsfPMdyRY5qyIZbxPBXRkS0nqY6+kyFooLK2bGN9ArrDFghrqthqa3+xcpYUcPpNq
         /v3J3BLGUZ+V+5ZbpQX/ueXU0f8UGncUT0isCDGLo9DcZm0CLG6Ag2jWjOc14IQIxN8E
         4JMP0oaNRtVfAsrIyFkybYO2Ov6ejXeWMi7A98ZnaL42rGOOE9D/gmvo/yHDB0wR8eTK
         dovMLodyuYgxapJIMcIBls7Udr+J0aRIp3DtnSCGSYiBVN8vOJ+yO46pckVtiVMRe8e3
         eomVIqT+zjO8NXdxvTyGWMCN6b6U+gD9ctfBJfiF/TUyrbjDjG2taxaZ37o+VuXuWfVn
         ppgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713725874; x=1714330674;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LkqPGQ54KoQX9FYj+4LiBoEzxd9T+rpddbApRBQr8w=;
        b=ngkrdpuJrHcPNP45wRnKCOdX7Ffh43HIHVUApFGxqEhgYTw8tKLb0egyzVmWhs4HcU
         eaqLAEYO/wwvMhirF86sBES1hTlJHv6fJ8Ztoc/uzddBUYzYC5HzMNHpvSJHK6pmCEbD
         k38BNI8cOqS2de5CTAsjXtyuBJp/k3sWjRMt9Lzi5M3/0dSNn7lZsda1mEdo7JfzsavW
         061SSqa/fNutr9/NpyUOOLTzSuslV68cPyNvdrCf9BIq7ZxVgtDphXnLAwxC3jaxi5NP
         00d4vJn48/8bNiPs5Y9jMY2Mt1wjDcwh4pnVrPmvewm38lQ1MH3mlHPDRdvbFebjfl+C
         PFHA==
X-Gm-Message-State: AOJu0YwYZ09wi5Yu6OTrK0uiMfo2eg1VTe+f8nLtb1OAALDN7ESYY4Ee
	/PvRAPFOjQvpcwHmEXPZ1nE8+kB1YHoPrkx7dQArx26sosC3gO58fmZ/TsANfNNfipODr4m0NY7
	g726eAVOIvQ==
X-Google-Smtp-Source: AGHT+IGaydiuHICqJYjW0yGkVnn4sUnFZqdt5njxKItuZFzj7EjRsD+U4ouKnli/NSkaCwki8fH0pZNMYNlDqw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dc42:0:b0:dcb:abcc:62be with SMTP id
 y63-20020a25dc42000000b00dcbabcc62bemr2388162ybe.6.1713725874605; Sun, 21 Apr
 2024 11:57:54 -0700 (PDT)
Date: Sun, 21 Apr 2024 18:57:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240421185753.1808077-1-edumazet@google.com>
Subject: [PATCH net-next] neighbour: fix neigh_master_filtered()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If we no longer hold RTNL, we must use netdev_master_upper_dev_get_rcu()
instead of netdev_master_upper_dev_get().

Fixes: ba0f78069423 ("neighbour: no longer hold RTNL in neigh_dump_info()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0805c00c63d434589aeedaf8c40781b822d70b08..af270c202d9a96f64a409cb7f37f1d4620d948f8 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2682,7 +2682,7 @@ static bool neigh_master_filtered(struct net_device *dev, int master_idx)
 	if (!master_idx)
 		return false;
 
-	master = dev ? netdev_master_upper_dev_get(dev) : NULL;
+	master = dev ? netdev_master_upper_dev_get_rcu(dev) : NULL;
 
 	/* 0 is already used to denote NDA_MASTER wasn't passed, therefore need another
 	 * invalid value for ifindex to denote "no master".
-- 
2.44.0.769.g3c40516874-goog


