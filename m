Return-Path: <netdev+bounces-294570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4GVkLjDIH2p2pwAAu9opvQ
	(envelope-from <netdev+bounces-294570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:22:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B576349E4
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:22:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lF0g4W3l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294570-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E478730393BD
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884802253EC;
	Wed,  3 Jun 2026 06:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE63DD51C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 06:20:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467651; cv=none; b=CO3OLrLet8s4gTFJyFFwDadvnI0IisDsjJ192q708c+gkKBnF/3kPRCLKLnZGio9txBIRoEj2FV30UF8Doedi9JZLqEAWVC+JDtDJkjRUN71Z7C/jS7Xgj1iCGtrzPBvTwvz9CRyJdg+17dRjDlJWYeQp9e3Xf8vsmCYfHSdBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467651; c=relaxed/simple;
	bh=72uIvwtYb0ffvlK6rOk1y81hrwQMcn04JoppRt1oGSM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JnkYHPTYAgZOLt8VxV/WBlITI4ClRxxvOkxxcvqEyWhvCSGZyDKI0plyoYLOi/njSk2WDKOB2kDMh/Jo57bW94cHx0MsYSVbk+MexM5B8fss9a2GVrkhkXbcjFGuSx6YlZDRbPLcPZbJhoZyxW7RI4myKB1BzW/wJRAnNrURZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF0g4W3l; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-91579011fd1so380202085a.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780467645; x=1781072445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gvz3gnyLsuHx5pMNmUnyOzuPmFWCBtH/mjlnKZ++9TE=;
        b=lF0g4W3li/78A6YxGT2ZQ8Xi1mnzVWD9iHXevPZMD0G1wfMbCIl9JTDJvWUwys6V2A
         mjW+jlqUeruQ+FkuV/2BQoAx52p2De8nCZyMBTwqw2PTqSa3EfUAxoJuuWQHyFWtAB0Y
         l9QXFH+Yp+4TwXwUzYUMqRI6okTJlajhmkCYkJJ7HaiGcWQmsFulomEW0w6zI7fS+2xk
         xFhSzIy3b8kOeMKP7FPsIwFibYfjsSL/VFke1u1Jw/z14mi4FACPaZVJ5j1mUc9DOzK4
         jzcqe8h4ZOJS9PzF0BLK+OT1c/EckRVSMwN3z7Twg5dw0vqZFRwLG41vKMa/aif3Ph3E
         P6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780467645; x=1781072445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvz3gnyLsuHx5pMNmUnyOzuPmFWCBtH/mjlnKZ++9TE=;
        b=dtgrpizSrxai/lc5ncgpGz+u6p9Z4NjtfdwpyaXTrUGeoebVFMbMD5qNdbLG1SHGc3
         9oyiuqtVN0F5q40HUCf5qnnz/iT4Dn4mj45MY94RSpb/XiBivDtyoZKXjQlYMd0QeiqM
         n+OR3378RpAjEzt2VRkfahlucS6I3NKHKMzlCc0Ps1GHZallvSXw+amu8XHpy3yhkr97
         /U4LpS3F7wcOrrGGl+pMslMXN4Cii4hSnzHnEcGVNHfYM3AylnrRjh2iP2vNBvIJhb/6
         8H83XjLZXRl2B7+tD/EMZ5vn5bnM26sgS5C5YOB3vuShLmG+yekWdlUbe/cNTo3Vom/F
         t3wg==
X-Forwarded-Encrypted: i=1; AFNElJ/T4qxdytuaUzDmcQ3ERz8p8UKe9m1fr16uWNKmk6rBKeL8P0aa7fPw7/VnzfjlJKihFts3rI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc60VovtpmYkmWiunHeo16hq6jag25OSxc+KoFcKtecfmbNwa8
	qJtaVn3rpZH+8AeEyI+svRQk6Xa5m6FEhbdtl5M6oQ2TyE1ROwmh6ECceoSdJ5zxtmSH64U/wnB
	W2GdpAtZiFSgbzA==
X-Received: from qknuc8.prod.google.com ([2002:a05:620a:6a08:b0:915:8bb5:dfe7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2544:b0:915:89d4:df18 with SMTP id af79cd13be357-9158a7d9aa4mr377039585a.41.1780467645144;
 Tue, 02 Jun 2026 23:20:45 -0700 (PDT)
Date: Wed,  3 Jun 2026 06:20:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603062043.3911278-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/11] bridge: prepare lockless
 br_port_fill_attrs() (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34B576349E4

medium-term goal is to allow "ip link show" dump commands to run without RTNL.

This round of patches adds/fixes some lockess accesses in bridge.

This is not complete, more patches will come later.

Ultimately all changes to p->flags should use set_bit()/clear_bit().

v2: addressed Ido's feedback (patches 5 & 6).

Eric Dumazet (11):
  bridge: add a READ_ONCE() in br_timer_value()
  bridge: add bridge_flags_bit enum
  bridge: use BR_PROMISC_BIT
  bridge: use BR_ADMIN_COST_BIT
  bridge: provide lockless access to p->path_cost
  bridge: provide lockless access to p->designated_cost
  bridge: provide lockless access to p->designated_port
  bridge: provide lockless access to p->priority
  bridge: provide lockless access to p->port_id
  bridge: provide lockless access to p->config_pending
  bridge: read p->flags once in br_port_fill_attrs()

 include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
 net/bridge/br_if.c        |  8 ++--
 net/bridge/br_ioctl.c     | 10 ++---
 net/bridge/br_netlink.c   | 55 ++++++++++++++-------------
 net/bridge/br_private.h   |  2 +-
 net/bridge/br_stp.c       | 45 +++++++++++++---------
 net/bridge/br_stp_if.c    | 16 ++++----
 net/bridge/br_stp_timer.c |  2 +-
 net/bridge/br_sysfs_if.c  | 12 +++---
 9 files changed, 134 insertions(+), 94 deletions(-)

-- 
2.54.0.1013.g208068f2d8-goog


