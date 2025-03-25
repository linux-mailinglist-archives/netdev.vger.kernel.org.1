Return-Path: <netdev+bounces-177625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73291A70C0F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FEF17107D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE6B269827;
	Tue, 25 Mar 2025 21:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C2261581
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938267; cv=none; b=s63WCx4NeT2PgKiq74Nljc8SXtbSQcxubwX3pf/Ioqb/MlmKndiTJo2mM5dpPWuqFSnzvq1pnNCPX2A5Qoyg4NkjDAmezuGOAYjJlwB32EFDjg9NaKLOfqP5Fx4Qh7YZ8LtJeDsQCfdSncqZW+O+1CZkD/Qt63iD1cRbzEJqLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938267; c=relaxed/simple;
	bh=3hKDtQW7nguGUkP5QSgPQw+SY81a3nOos9zYGryXqG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXTtS/83lHKvBeynX6okfTyQUla9CwyjRjTmrehAxjU2u/zBXon2pmz8jkA4PEga70tAyiKeiBp6a6+5NFxNMPbbSiCV6AqZ1UGU1KVWs5doRWzecMCkXYgDSzafKsMoB+dnY/yWGTaHNWS991JGa3W0Rx93s9EzhqSYs/0G+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so10314061a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938265; x=1743543065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpWV28lY7+LV+jqD0cQnrZVOXDsPx+xK/tnI27PxWX4=;
        b=dVUHs42Y8cuZRE70F+kWA9xZjsj+ofI4ojIsFzfrcatZ8OjyWzZf40Jbrz9pQRELbs
         Suco79LJewIZxVhMNtMlIDLqSSBvFohIpbMzu0L2+1q6KBPa9Ji2nortgMGQkmtH8fCU
         gPxFIx6giTXzOOQ0zxiHnXtOnfph0Tix/sdTQVQj9rNOETagPNeQTZ/ZGODyGUIOND2q
         fwVsUVjikFxlo+W+FDvIrzbom+MV4N1+y5tyfUudM1ejjv607gJdl2PAQxUiOF/8kFEU
         KabxpKiiEUtIpw17ZEiCOyI45D6RoZAoKMl9Yq6//YiqPn4VJyN7WFiLXyfps7NKevyK
         fTZw==
X-Gm-Message-State: AOJu0YwF98BtrQmhUVLIPwwvfgRmWOX6wRbcUFPAXzW4knEzFSy17W6h
	lVXUlWzDsNJmaU0HajB5POTuxy0HnrmOW/pOBhxqsNAjGXMStBqV/MqF73zpSg==
X-Gm-Gg: ASbGncvhiYIJWw9BZbNHT+xG3bLCjeRgIKgm7UMfa9xaysUGHR7VgsFn0gdSo3yHXVU
	aSeB1aZH9zH9Dcw70XlUc93ht/JUMo977IradjF5aXTD+iKBWURmfpaRKhNn/51vxqOA+K7VBxi
	Rh5at9WbcmHhG6PZSJ62fe52uw7vpUTZmy4Z3Bd4YybvPnqCxfe4/RWgk060Rw1u1GqH49mV6eU
	K4YrHak9kicYNbmaWXHX95SkmTgtzSkzGz7iiIzHQWYYgVfmfgb+Qq+8CRdHmLK1AFnz/+sc19M
	KPGPzhOYzO9X6PSRNtKlJOPyuuwNXD7VYAAX0NlKc4i6
X-Google-Smtp-Source: AGHT+IHD7y8DyJwwKJUrU/beMMyQQP279Umly0jZ34acnXzak34t+byLkvAMFJgSQxQDWKv39It1ng==
X-Received: by 2002:a17:90b:48ca:b0:2fc:a3b7:108e with SMTP id 98e67ed59e1d1-3030fe726f2mr27907263a91.4.1742938264552;
        Tue, 25 Mar 2025 14:31:04 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811fa212sm95407405ad.242.2025.03.25.14.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:04 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net-next 5/9] net: release instance lock during NETDEV_UNREGISTER for bond/team
Date: Tue, 25 Mar 2025 14:30:52 -0700
Message-ID: <20250325213056.332902-6-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
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
index e7f576d52311..7a1b160c5f23 100644
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


