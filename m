Return-Path: <netdev+bounces-84019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82411895551
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C977CB29D17
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C376883CBD;
	Tue,  2 Apr 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOo8budB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543F83CD4
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064423; cv=none; b=WbTV/4l+er0IdtQDllT7tWLWgH+5CynY2KKj3BQC0Y6z4+kNUJ87h0+EuqJC5/JjMAhvFGH4PRFmJ1IlFUGtkN4R3nZzL7gHanXeS/V4giZgMzx+1B2YNV7SXr1J6TTlE4rHXbzFOBo+i0035Waw4EMSeab44jwNod0rMu9mWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064423; c=relaxed/simple;
	bh=VYKh4t9Eh8pYLxGiZpIfQUqF91Xl5e5WgRVi0E3C5lM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IVevk9Mbj1N0lPESZQ3iCSPEFLAeIDcfgWa928Nqz41EQUT4j0mYcwkA4uadwcbChacBfgg3kC+Mh9EOCWseBLifBK4D/YHprCa5JHDj7TtSIXoRhVTkJhEwoqLPoB7r9QssGwS7+ZBqTteQC9BzgHcv6Gku0kdQ0Pnqi9zXHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOo8budB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513dca8681bso1849370e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 06:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712064419; x=1712669219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88rvRX0w4uXtO4kqkbcYGStzLCH335A4zmp0uxFLmqw=;
        b=cOo8budBdvWlGIbz4z6EhvfUC0r1gF5m2Fe9i7LYV+GNBpGNlrQwLv7p2rYYYJSB2O
         lQ/PzxWg271arNcnEBvJQIehbGNVbEvR07+gbN1bnh3h0kZR08fFrT7mUSn7HBlpCCMS
         zdV87U6Q8uR4iMaCS/lo1vg3e1PkAekOuMOEwXDfUxg1uAAonVoS/mlUd51iqObJ9IYd
         8UYF1Y0kpibFcjHN2PQEoiaibBSJkkLl6J8wjhuM4MYgl15PRnnxEQt/f6SR84bTlnbf
         977f4HkxACFCNOG9Nm0HfHWDZ51lnKWMfyvdVl+VtnbglcFnk4tnoRf+j8rB/yVHvjgz
         MfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064419; x=1712669219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88rvRX0w4uXtO4kqkbcYGStzLCH335A4zmp0uxFLmqw=;
        b=j/t72DLtNOweMF8DSzkB5FrTJJgDwhKXhDVr9SM+RRGKiJi5IsMfPE5OkhbVc+qeZf
         68+3g3IIKpSg3I6JKyfGw673ACcdRtq9mqO2bwofnAtVot647WtzUhgZ+jOoXvixs+ZD
         2uUsIEfmviFYkjgWhRiJqanUpEE0YEbsNVkXZXkUS1NFEseUxUI44oNkwGktCnERH36g
         Vn5QSKaTEaV30VUyW9pWAwl7x9Oo1is00+szMSlQ4zNgU5REMQ1p27aTObI0Ev4EMWGS
         UmbdiLpFwg7u0Ggfu/FEVVZtD7zchMNDHbTX6MzUTwL6VJbu36rU1oIGBgDcTVuzgYwM
         NpuQ==
X-Gm-Message-State: AOJu0Yw0jqPj6BAg4v8BMCUxJLdNToSii4p1N6eQlL+95HX9ZCpzgImW
	7O0E7RUCl7am8UqfJ0SA77xlUa6chr1C0URXTLH5Y8eYQoJ/DQDzNAN+F3bGYGjOXUks
X-Google-Smtp-Source: AGHT+IHS+MmuqauB6IbV21cDQQC/xs9rd1vhoCQuA3p3LkK8ux50VNwt19BWf1+gb1Us8r3sKk+WFg==
X-Received: by 2002:a05:6512:4007:b0:515:d5e6:d48c with SMTP id br7-20020a056512400700b00515d5e6d48cmr7281865lfb.0.1712064418998;
        Tue, 02 Apr 2024 06:26:58 -0700 (PDT)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id h26-20020ac24dba000000b00516a1e2a6fcsm879186lfe.256.2024.04.02.06.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:26:58 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH 5 net] RDMA/core: fix UAF with ib_device_get_netdev()
Date: Tue,  2 Apr 2024 09:26:41 -0400
Message-Id: <20240402132641.1412-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to ib_device_get_netdev may lead to a race condition
while accessing a netdevice instance since we don't hold
the rtnl lock while checking
the registration state:
	if (res && res->reg_state != NETREG_REGISTERED) {

v2: unlock rtnl on error path
v3: update remaining callers of ib_device_get_netdev
v4: don't call a cb with rtnl lock in ib_enum_roce_netdev
v5: put rtnl lock/unlock inside ib_device_get_netdev

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 drivers/infiniband/core/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 07cb6c5ffda0..7b379d3203d5 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2240,14 +2240,17 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 		spin_unlock(&pdata->netdev_lock);
 	}
 
+	rtnl_lock();
 	/*
 	 * If we are starting to unregister expedite things by preventing
 	 * propagation of an unregistering netdev.
 	 */
 	if (res && res->reg_state != NETREG_REGISTERED) {
+		rtnl_unlock();
 		dev_put(res);
 		return NULL;
 	}
+	rtnl_unlock();
 
 	return res;
 }
-- 
2.30.2


