Return-Path: <netdev+bounces-177958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF5A733AC
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4787189C19B
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBA21766A;
	Thu, 27 Mar 2025 13:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E7215F6C
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083829; cv=none; b=X1dLQL5RWLr80JV/IlfLAYRqXZW0O9bIlHo/tyWeIVSWHkiWm9bo1yBu7X0bswGHujSElv8tb+DMeoiOrQ/eg/8F9FMGx9zO+HqoxaI4a2pnxui1HFMw+yp/sa6mO3L63SU5NN5CognihXvQN2br+ZMO5FU+QW9WPILg1MOPcJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083829; c=relaxed/simple;
	bh=ULYcjFcYN8Ek24nx7HnK26yS90k5oRG32V8suQnV9aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBeSD2w8XDAcy/Y5d4n473J+TR44Bz2iEoaSr8frotEZa8DpqYqsX0EEIAojRQJzPPoIvJSq3GjwrTHV0K4nqcDOutFhiVjWDPCCF9U7TAPdPgKsWwyq77zTGmVapJruMUw+xvnHjdVhGtj2Gi+aiRVH09xZz0D6JHP7u5TAqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so2209312a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083826; x=1743688626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vtkERddGy3ubQOVBjaWiY4FjSm3HKUTtr8vteqq4d8=;
        b=X1Gxlyw3wHENS7wYiOmYx+Dua21P8njNxVdshQCepM4YMBGpEpTFcX4zFgSMXdmquc
         2jEQ1/HbDodyRWO3/nvHQAbqq5omy5IkQw3NM3GzFpb3bYVMAcAxmX+Rq3y6RXmraCTy
         Vj7QWA/yGu+nPaAMhfdfTh12p5zZBashykwRKF+HfkHyoQXqs49JP0u6+3ahKEfSaMZh
         FdVfuVyJ4laejNSl5mvbqI9y0YTYhcTDmWUZ+Qi/YSHgkX1INL7w9p7JNmoGDIrOoKvo
         v966CXtM5JQljHEuowHgS+UFBywz/JQusRH3hidf7t4Df9iSij95ZlgOJ71X/rM3ysDL
         lijg==
X-Gm-Message-State: AOJu0YwyqfKmsQEtDv3g7VrdKWcpTSG0hFDRur9B1A6tCz8ji9WS/o1r
	PQVwftTUySkMisQeQnqrnlJENWf+bOtWyCBTh4HrZubPLRgyFKEt3iBhDp2Lhg==
X-Gm-Gg: ASbGnctkWNCPb3CRZSTivhtgmqCLY7wRozDR164lLDMzc2Yk2Rv58BDpJ7GcLQv4Apb
	fFFlCKfTABP/UkEHMGoEY05kHsc6GgmhTrPZv8hNYYwjfUu3HP1eIzjARTlE+BNP2fFnXZg0HhD
	YAUgItYaG3ZnVk+4LWs2SbbZM6zaJxDvSU4vJafUT5EwqubHfN98U+X5/+DjufJPZ71bIgkY8fd
	/VPSiP1KtF3z6T65CDrewClUd7PCP+SVKhT3EC3GfajDlm0iNb+5Os00Jpzb/UYEh8fjNnndnOD
	g5wrrktMR7bM25z6gPi3mA4KtOM3JkPO79q2CqfU7+8c
X-Google-Smtp-Source: AGHT+IFjWQdzWValeKzE46rdldVNCBkXUWUdaAhvYnjoPtVt7aVK7Ix5j6E9PWYQMJbPonnFTz1uNA==
X-Received: by 2002:a17:90b:5344:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-303a7d64072mr5468601a91.9.1743083826297;
        Thu, 27 Mar 2025 06:57:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3039dfd48e2sm2229046a91.9.2025.03.27.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net v2 04/11] net: release instance lock during NETDEV_UNREGISTER for bond/team
Date: Thu, 27 Mar 2025 06:56:52 -0700
Message-ID: <20250327135659.2057487-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running NETDEV_UNREGISTER under instance lock might be problematic for
teaming/bonding [0] because they take their own lock and the ordering
is reverse in the notifiers path. Release the instance lock in the notifiers
and let the existing code paths take the lock in the correct
order.

0: https://lore.kernel.org/netdev/CAMArcTW+5Lk0EWCaHOsUhf+p31S8yAZyQvi3C8zeRF3TxnC9Fg@mail.gmail.com/

Reported-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c | 2 ++
 drivers/net/team/team_core.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..82f887adb33b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4022,10 +4022,12 @@ static int bond_slave_netdev_event(unsigned long event,
 
 	switch (event) {
 	case NETDEV_UNREGISTER:
+		netdev_unlock_ops(slave_dev);
 		if (bond_dev->type != ARPHRD_ETHER)
 			bond_release_and_destroy(bond_dev, slave_dev);
 		else
 			__bond_release_one(bond_dev, slave_dev, false, true);
+		netdev_lock_ops(slave_dev);
 		break;
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index d8fc0c79745d..4a1815f50015 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2997,7 +2997,9 @@ static int team_device_event(struct notifier_block *unused,
 					       !!netif_oper_up(port->dev));
 		break;
 	case NETDEV_UNREGISTER:
+		netdev_unlock_ops(dev);
 		team_del_slave(port->team->dev, dev);
+		netdev_lock_ops(dev);
 		break;
 	case NETDEV_FEAT_CHANGE:
 		if (!port->team->notifier_ctx) {
-- 
2.48.1


