Return-Path: <netdev+bounces-295563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SqKRChUqImp2TQEAu9opvQ
	(envelope-from <netdev+bounces-295563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:44:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D56447EF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qz76HM1Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295563-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E7F315B9B0
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFDD3E63B2;
	Fri,  5 Jun 2026 01:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105E381AE4
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:43:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623825; cv=none; b=nQWM1IEISxwP3CpkBTs5YvpiNvnqtVaRPoiMoL1/bGwexLB67dJlyjlvtxDSDyikieoI/l63DGwVs/NGhOOshfqUn907L2k+H0woMv7/a/5QRE4NHNfWVI1O6TNJ6D2AgTO4fXUEmzcSKb9RRKuPB0AGe97NZJNxIwFNxn1sa9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623825; c=relaxed/simple;
	bh=58lYn4NE3WI2y/xPW1YkIlCmljVDW939C14m1Tbmczc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XpD/ooPtf4cWewl9F7BraY2QyK+WBRwWS2VK91XiGusyXRddZBqNRjoRBpl635VgEkj7T0mWP/x8aj1Ay2XB0YYmvQ+ffim6Qw9k7EObU9LPW0YKiOmb/bq/WODuvAESsrXbtnNBBYkqble/kkMtsttIugWH3HOsJXTs3NEAibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz76HM1Y; arc=none smtp.client-ip=209.85.222.74
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-963a02dca36so1472341241.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780623814; x=1781228614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2ow12NtxvVPueHOKMb1jCbeRS9jueVp2e0oPGXbXU8=;
        b=qz76HM1YxS8yz5eVGbzZyfa3fzrR2rEcl7nUi07T75BF9q3FnJe0OR+3T5bzL+fh9Q
         FiERhpLbE1oQAfpt6NvdfA1C36rmA4ykMIwZoi6vSld+Q1pj+HYMgRiKF4hKEaO+/5Yz
         f+40nP1w9lrZxHvG4TSlw/Quxut0Bv87BJd/B2TqMSsLTOkh9J/oEIeK24nqxKUJTz0y
         t28TnU5f21C3pBljaPQK8POTBG7ZFo0MNC48TLJxK+y0MPL+zQZ29NjyGsf6Ngi6Ef6r
         TtN5jL2YVJrEyrDx2VOxNyDfRI5EHwdcn0hfgDUS2M8m0sSY9CsUQ+03DFUmibbvo4u8
         PF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623814; x=1781228614;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2ow12NtxvVPueHOKMb1jCbeRS9jueVp2e0oPGXbXU8=;
        b=AR92JSQ1iHpIlFb1IdT8GEMextW6J6kyc9Ds3Kv6r1PHTF9tZmlQcRnFIwJi1W+Wvy
         vPZoKLk0ikbj0G35um5ZzgmqwtAIKE44oTTZ2rk0bnwXI3g6/PeXGMT0I8oogNp6CBrh
         Ft2g34G+d8S9Yu9GyNabUqk4xZAmeepiNrmuDQVzzcFSeWcr+MmjYZ1BKc4O4w+J+obX
         9pOAsyNYW6AdDvxewPRlMWs65OkZMTufDQy7msJnyd3Q36VMj9zTDUl3zWrV0roYrqkR
         KzHmwJra/tJIH5NXomEuKZQ3YA5SJ6lj53osoGBmHpa13fkz+wTC1va3ThXmZbpIvwUw
         Sqxg==
X-Forwarded-Encrypted: i=1; AFNElJ8R4dO5Q5mBftecvyXlarm7TUrzTYRzSUY+eLAoq0k2W1V/MVdB+2fxc0D7esUp2ga6iqEpWD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4E3LYA4YqOV8VpWQzA7cl8lzq5PKY8arGQTZwRp+SkqLtWlv8
	8OwNrBmoTXLq8+z/746ZrrXcC/CFrLE97WnaTBwfHuXR8tK2hE4hsr6om2rZVG+cDF1X7LtK1ij
	ewD/h3OYIzpa1GWA3IHmvBHGlRQ==
X-Received: from oaff25.prod.google.com ([2002:a05:6871:c919:b0:441:1c3d:9b6f])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:358d:b0:42c:1f88:ac with SMTP id 586e51a60fabf-4413dcbd75emr730101fac.29.1780623803290;
 Thu, 04 Jun 2026 18:43:23 -0700 (PDT)
Date: Fri,  5 Jun 2026 10:43:16 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605014318.3890804-1-yuyanghuang@google.com>
Subject: [PATCH net-next v2 0/2] ipv4: igmp: annotate diagnostic procfs data races
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295563-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B69D56447EF

This patch series addresses several unannotated data races between lockless
RCU-protected diagnostic reads in /proc/net/igmp (igmp_mc_seq_show())
and concurrent writes in serialized paths (RTNL and group spinlocks).

Following the precedent in commit 061c0aa740d5 ("ipv4: igmp: annotate
data-races around im->users"), we annotate these intentional data races
using READ_ONCE() and WRITE_ONCE() macros.

- Patch 1 annotates races around `in_dev->mc_count` (interface-level joins).
- Patch 2 annotates races around active timer-related state tracking fields
  (`tm_running`, `reporter`, `expires`) on individual multicast groups.

Changes in v2:
  - Remove "Fixes:" tag from the commit messages.
  - Fix reverse Christmas tree variable declaration order in igmp_mc_seq_show().

Yuyang Huang (2):
  ipv4: igmp: annotate data-races around in_dev->mc_count
  ipv4: igmp: annotate data-races around timer-related fields

 net/ipv4/igmp.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog


