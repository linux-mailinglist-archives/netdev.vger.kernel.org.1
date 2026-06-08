Return-Path: <netdev+bounces-296646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7D53HDT3JmqmowIAu9opvQ
	(envelope-from <netdev+bounces-296646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C912765916F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:09:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lOPb86gE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296646-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296646-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DEF323654A
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DE43E5EF9;
	Mon,  8 Jun 2026 15:40:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654333E5EE1
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:40:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933218; cv=none; b=ZEUDUadu51oqEVUObIDMYsG/PP4q66/yy3X3c/ADSJ8E/NGsRsNpgwTvyQiv4w9T0rnsfD+n4JrYs4aPKjY0g8HwKgfVyNsbp6V4yOZg5j7ZZtAEbdTH+p5jc4d1CdgdiegqXOsmZRSd8MlChvu7/l6Qmf2okjpeGzJCAGTFMO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933218; c=relaxed/simple;
	bh=32yU1Fls0YnnQk257EHKQfCm6VxXR8avCY4E8Yvwm4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxJqHYXeOsSTrTYlI8+O+T75fBY+lRIB4YSynCibNnoBbU7JLbve9F8axa04/rUIZWg1FZamk4pPAikLGMzDxqLIisDvq6vmnJ+m9tHjsjRIC7Ujai+OQA0LKNMKgxOYeenYeR905hYmQBwcRrE7fcnFVsxQByphrUeyua5h7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOPb86gE; arc=none smtp.client-ip=209.85.214.193
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso30783535ad.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933217; x=1781538017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDYY1ViyIuncS161Vvb0hr9ZD5sY6BMKKyfEzNWhWr4=;
        b=lOPb86gEFzC0KljRqhApiTo7r5WJFvSWnMbwJ0BJaMCTAgduEMH8D6ms4pCs1OB7CX
         0rm9n8RWvidV6m0YHIOZ97jV4zWOi2M2PjrkZC1+WBv+GDZkCdfhRpTyAc6mGjEMQzk5
         r+UgcQqjeimJJOdyHySi4dVSQsnoDgXYy72/7+GdgGUecfH8EOWnvOTNwZLmCLEtXdcq
         4VlFzkI9sESaZxv9f75ADAYXo8FnGXeHN7RYODzXETkF3R7M5DfeM8YVbHZiU6921k7+
         JfQOX2OA+GO314GDd5/CW8XBKd7oO7AI4GwySSQJfQqx5wlQ9Y5yeuARmrTg4rW84CWY
         CPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933217; x=1781538017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDYY1ViyIuncS161Vvb0hr9ZD5sY6BMKKyfEzNWhWr4=;
        b=EGHaUYcLsixmlp9Eeq8EJNnh+GyKEO9ht6ygxzS/XiArrZxTvVTWvCLaL5aDFmNaPk
         BRjOAVXRTdW43M9rQKT5ji0c9lV2jZEN4b/rsWg/88ThxrXUNgHWvNzJzq2YX6mf7FdY
         02yfekcSsvjmiSc50TNhPY36gT2tAkRvM3xsbIS8IdTqWMPG3yP4y/HTX9YCWF1MmW0a
         eUpvK72eKwXNAAZXFgfqF5QnqyfjifWxJJvxFHx8QJBF4+wWuSjjSAFtyoGMGz/Wh42y
         1gd8QMyClHTjf4I5x/sCnInP+GZsTVvZwiuT1UYmHCiTbr+hdy5KsHIAgNk/YXCZN8Gg
         /PHQ==
X-Gm-Message-State: AOJu0YyAMpwGIOf3ScawgkZ8kjb0qAVVOOCSXQZR6RnDy9fL2FlPK+eR
	N4Y7m9PejkiL7dra500oXXp6g3tzFCUMr19PT6LqNtXt8XipWZziG56MazBxaq4H
X-Gm-Gg: Acq92OGzBeioQRL11oJJIZAqdaW/hJ+Yp9WrAM8LCuldNP6qqrUss9u547EP5EHJhFY
	ukKk6XUxBluQj2twoBeNJtJE48FePXYLd/gpoThgWyA901pL9k8f4P+zTUm+IEy9BGK7WKW+acQ
	NHwPPgeCNrMMQ21o2tDv1IAw1xFQjlt2t2cV7vN8ha94OVo0wThu2cPJZHfkxGNVEMiDSMpWo7q
	v5iJbcUqWzJFJjBJJBTyTMfHHfoBqBoRODrBKOHzyjst7sN3M11jxRimKJ1loJio2F781tfmy2b
	6ZSyU0ibu6ujQwrxODm5rYHghiuQpUM0Zd0tBlYO5m7bw5ltLwjIeCUkMJ5atiVlzceaEiUcKUR
	khIUhc9NG/CGIOvmeIVJXBL5ahm34V5GhQiy8+cx2ylly3y5kpPkNlbMbCn55e9KZrXBPPT4+Nq
	7fedaVFtCxgqYMEKymLq1eRxr3QQ==
X-Received: by 2002:a17:902:fc47:b0:2c0:eee2:fc45 with SMTP id d9443c01a7336-2c1e7b2f6c7mr193362835ad.4.1780933216459;
        Mon, 08 Jun 2026 08:40:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9f358sm184775805ad.30.2026.06.08.08.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:40:15 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net-next v3 0/3] net: add retry mechanism to ndo_set_rx_mode_async
Date: Mon,  8 Jun 2026 08:40:11 -0700
Message-ID: <20260608154014.227538-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296646-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:yzjaurora@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C912765916F

Original async ndo_set_rx_mode work left one place where we do netdev_WARN
in response to a ENOMEM. The intent was to see whether actual real
users can hit that (adding uc/mc under memory pressure seems like a
very unlikely thing to do). However, it was quickly triggered by
syzbot's failslab. Add a retry mechanism and downgrade netdev_WARN
to netdev_err. The retry logic is a typical exponential backoff:
1, 2, 4, 8 seconds, 15 in total, hopefully enough for a system to resolve
memory pressure.

Link: https://lore.kernel.org/netdev/20260416185712.2155425-1-sdf@fomichev.me/
Link: https://lore.kernel.org/netdev/20260519095557.3749407-1-yzjaurora@gmail.com/
Cc: Zijing Yin <yzjaurora@gmail.com>

v3:
- add netdev_warn for bnxt_hwrm_set_vnic_filter's EAGAIN (Michael)
- use netdev_assert_locked_ops_compat (Jakub)

v2:
- rx_mode_retry_work -> rx_mode_retry_timer (Jakub)
- (ulong) rx_mode_retry_delay -> (uint) rx_mode_retry_count (Jakub)
- remove dev_get/put (Jakub)
- drop fwd decl (Jakub)
- move comment about total retires to NETIF_RX_MODE_RETRY_MAX (Jakub)
- use -EAGAIN in bnxt to signal retry (Michael)

Stanislav Fomichev (3):
  net: change ndo_set_rx_mode_async return type to int
  net: add retry mechanism to ndo_set_rx_mode_async
  bnxt: convert to core rx_mode retry mechanism

 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  9 ++--
 drivers/net/dummy.c                           |  7 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 ++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 -
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 10 ++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 +--
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  8 +--
 drivers/net/netdevsim/netdev.c                |  7 +--
 drivers/net/netkit.c                          |  7 +--
 include/linux/netdevice.h                     | 16 ++++--
 net/core/dev.c                                |  4 +-
 net/core/dev.h                                |  2 +
 net/core/dev_addr_lists.c                     | 53 ++++++++++++++++++-
 13 files changed, 116 insertions(+), 57 deletions(-)

-- 
2.53.0-Meta


