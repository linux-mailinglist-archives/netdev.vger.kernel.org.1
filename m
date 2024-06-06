Return-Path: <netdev+bounces-101470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A18FF044
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46BF1C2587E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950B196431;
	Thu,  6 Jun 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="0FCru1X+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BA198E65
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685964; cv=none; b=kKC6iE5elFrw+5p/zPAZRiAmDS8HcfWccLUEaaewcVj8VFfWK1W5x7uIyzv4wVEwjUhn/p9i4wnk6bYnldZf+hrNhoOw+o1WlwQ6S578DsSIb+V9XfA7ubNvLY6aFlknf2QvuPzUarjURks9j91rMJB1fyZCs6HunKfFCQTKEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685964; c=relaxed/simple;
	bh=GWUvPV+ShGdxr5ajGpsS4KtNOoHWujrvxxiM5o2bS+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKxMkjheP5ra5dgn3M0BcXTJMMSu3ubsG9VQOVTk96KeNdrtO/x1M/AYn9qNsGSSovAlAzHLfcsMtkO6+UludcaId2iR3pD/zWKC5le4hjnvt4HRfJ7HFV62eT346HZDGhaLuE8JcClDzdUk6LMJpmmKIf1A1uumQj96EGMwIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=0FCru1X+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6cb6b9ada16so834186a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1717685962; x=1718290762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1HBRTga8Uvus+FDhaGj1c4ywlGMfhJMwS/oedJ4AAAY=;
        b=0FCru1X+dAMAJuxTqGHET/6/22mAuvZjIbz7sAaeyRSv1hCqM+t4ZAzdbbMFRjsh9Y
         mLQQ7gDNjARVq52H1DIFWxdD/d3WM6qdPw6Pz77qG4fl5jmvTijva2vzNhGyWTvqu+ZS
         QFOrYJq95HDOuQLWZukx6QthZUv0L1QLS1cUpTrq5CmCN8Q3wJ8EB6fSofw6N3BoV9sS
         tQK0bPIq97Qa3tKz6aahiVoKUNSaVhOMjQnq8T3AT0Tf8jH/6oRYYwVQuG0RNW7OqRdp
         u/jxIQn+BI27sep8vGX0+lWvPTGjJQ79+UkEjHL/bn0NmpRNNv71xXkrsgFw2nTxFtHN
         KT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717685962; x=1718290762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HBRTga8Uvus+FDhaGj1c4ywlGMfhJMwS/oedJ4AAAY=;
        b=ugBlJ2FAxqDj+IzMJf8DrzAWDfXMVyVoXzniBcvbCU2qeKLBtBTD+feG6Skvip9i94
         rG8GbZ//YOT5+Uo10kpjzuErWFBGbtp0Xh/OXgr/Ps33MAdjxxz2oixYxT57ojUsNwx3
         HrH/3VCD8Esi86KYB8r1kqbspRHPQ5oULC3Glz13trFsRee2QldouUcQgpQh4ZuiM8PX
         jHa95Ojkzb/7M5p9OkDs8MYYwaR3aeHaKWnQl2lo1u7lSpPfo2/T1T8X1H3O42GDiLhD
         p+Jmz3LxvlRSFKUu0Jsd4iGciULbh27BIrJx4mF2D8gDDJw2ISzFbQtTEz5xlLxxhtDy
         W7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU2Hy0s5GU/TM0bAelsZt+BBwll5N5NHwcYeg9D/GUNpWrFCJPW6+8YDUxE+SatJcGbiBjQRv+K79Hfqj+o5hfeRrSsfTMy
X-Gm-Message-State: AOJu0YzTxVWBVzjJBwBSbVwCqdvj2fkCoFWVt/OMoJ54miLdRgqKkSQL
	j3rU9/M4aK219OPQKDM8ySWcafD1Ph/qG2KyZqHk8NUkf/hhjYjcC+vcmTF0A7A=
X-Google-Smtp-Source: AGHT+IE+N3+Ez4+pgbP5ANXxYle2Dm6EqpPibfaDjwD1bnVJmqIwEnvAuHV8WiCAs8n+lg596GcD4Q==
X-Received: by 2002:a17:903:283:b0:1f6:8157:b52f with SMTP id d9443c01a7336-1f6a5905e51mr69642925ad.8.1717685962550;
        Thu, 06 Jun 2024 07:59:22 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c146sm16009795ad.106.2024.06.06.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:59:22 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: Yu Watanabe <watanabe.yu@gmail.com>,
	netdev@vger.kernel.org
Cc: Maciek Machnikowski <maciek@machnikowski.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] netdevsim: fix backwards compatibility in nsim_get_iflink()
Date: Thu,  6 Jun 2024 07:59:08 -0700
Message-ID: <20240606145908.720741-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default ndo_get_iflink() implementation returns the current ifindex
of the netdev. But the overridden nsim_get_iflink() returns 0 if the
current nsim is not linked, breaking backwards compatibility for
userspace that depend on this behaviour.

Fix the problem by returning the current ifindex if not linked to a
peer.

Fixes: 8debcf5832c3 ("netdevsim: add ndo_get_iflink() implementation")
Reported-by: Yu Watanabe <watanabe.yu@gmail.com>
Suggested-by: Yu Watanabe <watanabe.yu@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c22897bf5509..017a6102be0a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -324,7 +324,8 @@ static int nsim_get_iflink(const struct net_device *dev)
 
 	rcu_read_lock();
 	peer = rcu_dereference(nsim->peer);
-	iflink = peer ? READ_ONCE(peer->netdev->ifindex) : 0;
+	iflink = peer ? READ_ONCE(peer->netdev->ifindex) :
+			READ_ONCE(dev->ifindex);
 	rcu_read_unlock();
 
 	return iflink;
-- 
2.43.0


