Return-Path: <netdev+bounces-177954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CDCA733A8
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D46189AAA3
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6D215F47;
	Thu, 27 Mar 2025 13:57:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D58BEC
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083824; cv=none; b=pYOUG0oVnXLQIS2KEsUZURk8hwV2QmYa3jzyxKkkdxfqJCJ63rew2/rJNux9N5DB4KkHQ2IUq2StuFUkHTz9P0vB7/LFvDTCS02RSl0P1JdQIsj86qHYIpaA+Lb326HybY34AYLnoy9jQy+MjpGzVVuNwuKIlNuxq8C7Auk1ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083824; c=relaxed/simple;
	bh=ue7ECn+lM6dU0O/6JNgmmhYeJ6BO5Xvv0EynQrzeIWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtbZxwSxbopQ0N8Jcpl8y52ORTqX8xrYSwrQ1FDUpYLE9oURFE3PQ4qpafavEJoIYDLJknnCauhNWg6ybJDsHke1+WNLNxWwQAMGMVxjcF7idb/my9rvb/8zrDt/qqnNuvfD6SXau1HyO2m5G6RjQQBTAvp7pzRuH5hlW3+Qtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239c066347so23718615ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083821; x=1743688621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkTfq5JYBzO4gUpnbWQujikRkVHUuTeRo4oB88b8HLs=;
        b=Wgc4hspsvCwS+dFyY2upuBU7uETIy3vh/8y7+EM/yW2jANPv3dyhn3EFv6VKgtObpt
         JAtd9cnhYjryy7uT8MqzCN55yMC38gRZNH0sIBz0EjaBhOMn07gScA3lclvvGQIsKRyH
         wqT8eyBV1vzNdBnxIpdpDMVtl5Hj5U3MwAireXWNFGMNXELwRMhXb2NYI81nJ4jJcCe2
         n6DkJlhfY8JXeoVzuxP0YtuUQvFwksuf9vUYqZZsARai/rjbnzxJwat9hW121DOjrEKS
         m442KwYXF4kS8DruVicMka67R5xNiG66557xAYl7Gin6wTLln1Ojm+zBvZXIQz41vshL
         1yng==
X-Gm-Message-State: AOJu0YxNN/0UdIhCYLArV48Yh92jQFBS/Zg1EljtUc4DHlYdwut9/xs1
	TW7JkTmVMg5FFpASGFqww0pHfyBjZbAQQ02/PSycoDNMEqMfSxnkMv4uI8zkJQ==
X-Gm-Gg: ASbGncss7oYI5cx8/SrIt1SW4JZKoVEtDJnomJtFRFm11JBDV52F2N3GGabmr/wq9TF
	XtDbFSSxh65+cxG7ZDdptVZ+LxZ1eaR5wFsyHQaSFc1iHfyy3kp+aVlh49ax4LNJLrKxJ5cXQXY
	p9B3x3c6RfaAZM3nXfYXNVq3lQlX9tpvXsJG99BGh1W3mmmenXDh41X/eULcI1esFKhghj3w7MJ
	meb0fBX8sdH+9meRoj/+daYTfAUcuoW9IIzEfT7QdazZxzTDCiRF0uyW93+MkLqe50v5yQccAzr
	CQ3MxCu/WTi1GzejFprfuo2D5E+X0YRpkiIIVcn1myj9
X-Google-Smtp-Source: AGHT+IGnr4NENGy/+N9D17CQr8WQrpRHnhh+cIkPM2KIcWQk7/UMSWGxxqxEwtVTKm2wowNVXictQw==
X-Received: by 2002:a17:902:d551:b0:216:794f:6d7d with SMTP id d9443c01a7336-2280495aa5bmr64325025ad.48.1743083820503;
        Thu, 27 Mar 2025 06:57:00 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811d9f1bsm128674895ad.166.2025.03.27.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:00 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 00/11] net: hold instance lock during NETDEV_UP/REGISTER/UNREGISTER
Date: Thu, 27 Mar 2025 06:56:48 -0700
Message-ID: <20250327135659.2057487-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Solving the issue reported by Cosmin in [0] requires consistent
lock during NETDEV_UP/REGISTER/UNREGISTER notifiers. This series
addresses that (along with some other fixes in net/ipv4/devinet.c
and net/ipv6/addrconf.c) and appends the patches from Jakub
that were conditional on locked NETDEV_UNREGISTER.

0: https://lore.kernel.org/netdev/700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com/

v2:
- export netdev_get_by_index_lock
- new patch: add netdev_lockdep_set_classes to mlx5
- new patch: exercise notifiers in netdevsim
- ignore specific locked netdev in call_netdevice_register_notifiers,
  not all

Jakub Kicinski (3):
  net: designate XSK pool pointers in queues as "ops protected"
  netdev: add "ops compat locking" helpers
  netdev: don't hold rtnl_lock over nl queue info get when possible

Stanislav Fomichev (8):
  net: switch to netif_disable_lro in inetdev_init
  net: hold instance lock during NETDEV_REGISTER/UP/UNREGISTER
  net: use netif_disable_lro in ipv6_add_dev
  net: release instance lock during NETDEV_UNREGISTER for bond/team
  net/mlx5e: use netdev_lockdep_set_classes
  netdevsim: add dummy device notifiers
  net: dummy: request ops lock
  docs: net: document netdev notifier expectations

 Documentation/networking/netdevices.rst       |  18 +++
 drivers/net/bonding/bond_main.c               |   2 +
 drivers/net/dummy.c                           |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +
 drivers/net/netdevsim/netdev.c                |  58 +++++++++
 drivers/net/netdevsim/netdevsim.h             |   3 +
 drivers/net/team/team_core.c                  |   2 +
 include/linux/netdevice.h                     |   2 +
 include/net/netdev_lock.h                     |  16 +++
 include/net/netdev_rx_queue.h                 |   6 +-
 net/core/dev.c                                | 117 ++++++++++++++----
 net/core/dev.h                                |  16 ++-
 net/core/netdev-genl.c                        |  18 ++-
 net/ipv4/devinet.c                            |   2 +-
 net/ipv6/addrconf.c                           |  17 ++-
 net/xdp/xsk_buff_pool.c                       |   7 +-
 16 files changed, 245 insertions(+), 42 deletions(-)

-- 
2.48.1


