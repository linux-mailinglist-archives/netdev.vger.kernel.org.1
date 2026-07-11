Return-Path: <netdev+bounces-306725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+WMLjaUUWqSGQMAu9opvQ
	(envelope-from <netdev+bounces-306725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 02:54:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2A73FDFC
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 02:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="ESsO28b/";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306725-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8838301F9AC
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399A1922FD;
	Sat, 11 Jul 2026 00:54:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701D175A68
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:54:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731252; cv=none; b=aQ73hMWfHpaWEyAtZ5wCEB9w7EQvgxwpqoohbD2+FA1wrhLtZ12AwUD3ffKgwLdXMkePf6CiKVnyLCWdLLH3CPLihibdJlg3sExvfM9M46Kb1eh4EiHy6kYSKs0TrV6c3cqlJrFL6igsn8bQ6ulretN6IOJm5HIsULd1tbDrBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731252; c=relaxed/simple;
	bh=oApeQBB2es6SZQwjV8Xt9HR9yOpez9QQ+SzH7wnSmV4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QzfWZFx4iNAr2R7D+glTf82TVwmGZk/bkW2AUU4ZdViJUn4oP7Q/tsb7cuuQXA2dJmOWcvzDR52I8Qfi+9jB5BxNHajaGNnB4m4Kq/ayIKktc+ngLWJ8plADxMZDR9u5lIwmqMdId+tbAnxUn2ySMCoA0ctuVAlX0rY2rScTIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESsO28b/; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cc88e22f92so28213405ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783731250; x=1784336050; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jBFErHW4jyCZ1FOOH3e+xQFnVy/CtEciwfCwQ/d/uI=;
        b=ESsO28b/zEH5BnqomcqD73V1jokz7seISPuY/FyMbCn0DA57D40c4tvd/95gXuArlN
         AMPnOaK8T31U80m9CPASi+KMPKKNH7R4ufm/16eIcmc7Fzvb7u4GM3KJ4hlYmgWWawhf
         z4MIy+Zu4tHicksXA8oZakk4U3u78WhoNiEjwhFGxrYWmxoBpzIkM7MkqNO1hXk/9H64
         WvBGyCZngRvAnK7frbdJX72lt3/+H2RFExclj0+BMovApk2pys47CidLJPq53eoGxVY+
         7cxElK/WWzNyi9HNeJiUSUfe1soYwQHcb9VP4v6JEwz0bdzP9vN5JamlRgfjq+osxA1A
         jmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783731250; x=1784336050;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jBFErHW4jyCZ1FOOH3e+xQFnVy/CtEciwfCwQ/d/uI=;
        b=a7sNGJTA+oQjQaE9cQnUJrKExX9YhgawPEvuYucqf9QHNnqRik0RjsQjZsvYpClJlO
         56N6obkGi1aIxVfBgge+HynmeMdjxvu6aJG3j4kpj15VasP+3P+CTKMD75FMNMNntjdK
         MplG9aX+GT6TB7aqgs6eGxrUpnVq37LMkUpzH23s7FCdHZWm8f7UHal3Y2o4dLy+n/b0
         zvwX0J2e+7MajPkQ8tAjk5+7vaYQ6YcWM8huAypFTeQCaD0XmZuKa7tFi8LEYawvaLsm
         SUelDbuZEmoK28C34iWcvf6VcPoI+vYKKV5TdWOGVOBnBnf2+tSycdONB8Mj2Xyq0kZc
         rZHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJSSOMUWaCT/acu8AUD90OYugXPKqV+BeKcWxKn6YUcz3BBni8LZhzEgIzgs7yKmNQrCpWtY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydioFa11US4h8sODGl+QsLK7qX++LEnudJRil4ZLtxVCKwdzR6
	ZkdMFS06sJM7yldmHFGRHAa/oKdAi1klQnGUk4vqYuftHbYrIVM+9sVzoJX6hbfz2bCE2GJpl/c
	vFnaCQI2KbOCDLdcDeZsDrty4hQ==
X-Received: from pldd21.prod.google.com ([2002:a17:902:c195:b0:2c8:4c1:883a])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8f:b0:2c9:97a8:afe5 with SMTP id d9443c01a7336-2ce9f27e6dbmr12598325ad.40.1783731249956;
 Fri, 10 Jul 2026 17:54:09 -0700 (PDT)
Date: Sat, 11 Jul 2026 09:54:01 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260711005405.2861680-1-yuyanghuang@google.com>
Subject: [PATCH net-next v2 0/3] align IPv4 teardown with IPv6 and fix driver regressions
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Elad Nachman <enachman@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:enachman@marvell.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:johannes@sipsolutions.net,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306725-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14D2A73FDFC

This series aligns the IPv4 address teardown sequence with IPv6 by clearing
dev->ip_ptr early in inetdev_destroy() before freeing the multicast list and
individual IP addresses. This prevents RCU readers from accessing a partially
destroyed in_device structure.

However, clearing dev->ip_ptr early causes __in_dev_get_rtnl() to return NULL
during the notifier loop in inetdev_destroy(). This causes regressions in
some drivers (prestera and mac80211) that use this lookup helper in their
inetaddr notifier callbacks.

To prevent regressions and maintain bisectability, this series first fixes the
affected drivers (Patch 1 and 2) before applying the core IPv4 change (Patch 3).

An audit was performed on all other registered inetaddr and inet6addr notifier
listeners, and no other drivers were found to be affected.

Change in v2:
  - Split the original single patch into a 3-patch series.
  - Patch 1: Teach prestera to ignore duplicate RIF destruction events when the
    RIF is already gone, rather than returning -EEXIST and aborting the chain.
  - Patch 2: Fix mac80211 to use the valid ifa->ifa_dev from the event argument
    instead of looking it up via the netdevice.
  - Patch 3: The original change to clear dev->ip_ptr early.

Yuyang Huang (3):
  net: prestera: ignore duplicate RIF destruction events
  wifi: mac80211: use ifa_dev from event argument
  net: ipv4: clear dev->ip_ptr before destroying inetdev

 drivers/net/ethernet/marvell/prestera/prestera_router.c | 6 ++----
 net/ipv4/devinet.c                                      | 4 ++--
 net/mac80211/main.c                                     | 4 +---
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog


