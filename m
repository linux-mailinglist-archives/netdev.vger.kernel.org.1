Return-Path: <netdev+bounces-267287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JDCCaJ+s2kDXQAAu9opvQ
	(envelope-from <netdev+bounces-267287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:04:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C357627CF6C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 04:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D1D303829B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D39322DAF;
	Fri, 13 Mar 2026 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8JAe+E9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386CE1EA7CE
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371030; cv=none; b=olrzQWY/DCz7804JI0OGUR9AQ7p70xmdkbMWLVCmcY2d522GvSkgYJc0SY9awGEjahsGxQ8vcIo/cqHxoCllaptqdtyXIpAISt2o+LOdXP1n+AFc+BMIHJNy6/9h6OvFSBG0s0K4xco7hrLaT/NfsMRV7cR9OfI8wZqsJTFmgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371030; c=relaxed/simple;
	bh=j7tVW9zGV8oXmoLeTvHG6D3Jq9SYP8Wv5IU1r0Pb1+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bsKNSS2ZZQGu75xmQp4v0HL/SN7e7Vwk1gOf4rg7pzVoEo7+bOCfH5ljiiy5PlIA2f1AuNhPmNMaqPYaPY8lyPkfwnN3VkAo6Wp6qcRVzWoI94gN0a8NRCGs9fQo1fSjE+rW/RmT6NSZ9HHIFtsfP20jA7YhbiD9PyFlqnzuTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8JAe+E9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a0b413684so1107497a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371027; x=1773975827; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTHg3LXjfzPV5AkfTvIAZXI/emA8+u1EQzwENzgt9Gk=;
        b=e8JAe+E9233joeNBibdmhcfK8mdO0/gvR2/4esABT6KtVh6N40c0P+c0Quk9xLhK3U
         hh9Xcs0WKYOULDYxItunOg0ggBuHctwxBoaIghjj9zVPoYvSh2ojf0j0A6ZqZi8R2daH
         gIPGnJYYsuDXU+8hqXKGa+72Wgw4qPErw8q9lff4LEo/jUfaTG4rdPXUi/vCTUOK9vPi
         3Nv+zMyOvf4wLFgE5wkmF94xj3e7Yt79Fdgnv2jwlrz92WbqpsAAPDDubceN7sTsbsnR
         pnQ9mKQ35FMfw+GDW/1J08AW/T+eIrfxp6rhlTkT48eK553OOO+rYthUzKBa/aq70YT1
         6kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371027; x=1773975827;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTHg3LXjfzPV5AkfTvIAZXI/emA8+u1EQzwENzgt9Gk=;
        b=ebonkNth9Z8LH4xxywHmM4qGFS3l4yrvDYiXkL8Tk6agpjLZWvQAty1QMUSvtb2X1x
         kSyMlv0Lwt4oTlkY+qAc/wQ9u7qLQ2NqUqC3JthRKjib1IvFyJis0FQmYlenGjgUsXXE
         pEK5tqQbiMbYXQ97HUmdyUb9/bZKsrZUuk9Tw21aPIiwIW3tP/qYp7zLKRrmqvpv7WJU
         Qf2UeSjVE0W90tBN0cfw3HfKprS5C6BCyKNl468rn2m3ZGMFR/JADozDfzv62KfdmDvn
         cXsr2LKHR4wHOTZoOWlCQAU+0n3F+0AgyoAO/dtwHVOUO9PFzUBOTKhW1EqoRQFIfsHJ
         EUmw==
X-Gm-Message-State: AOJu0YxtmTrGQ8fe2k7S2YdRLL3EJYxPAlEn2Ov9QnOzXTK2xFPNCt8p
	DXxC4/tuuDdM7jGZC+1yf6/lB32ItXR3rmXBrRnfIFh/8z2ovzIrpW5k
X-Gm-Gg: ATEYQzwuLSyJzPRfdt7Z4gYrvrtlcrUO5Olnuj7PDkP21ho89HhPhQPUrAJZdC4mpR5
	euso+2aZautS0GZZvnr4F/Z1keRQY+JDSZTSWHdHWhky0CllTV6Gdtq995rbw6M8twJXuIqcUma
	lnrk4A4ZNjF+a4V85zwyp/2THULDtbdTAEMyq6voZYsnGdZnvdr/cYnKdymjdMwXvl+TvQa43kS
	RahPRZaPMvzUyMzp5P9uM61DMF+ujxdOTFMxoz3+1PRUFaOEgYKTdymlQwPMD/u8go6lF4uxviO
	WCnsCSy/owv/5IPIo01IS/MA4TqkzbkL9SiM4i32lQ1yTDOhSzOkQMQdFxbz/XWkf3BhDPELDrg
	tlEQrBzylkson9Be5Cob+NErypjZVZLJwyZky441Wmb3/b/Xv1a3iViD1BEHpVDSkyyOukLgQmn
	b48+/jn4ZVdNwtZsqia88rZycCqgKTI69h+JRWuNesxHJKg9WkE5rMfGYIU2mH3nqoWkHzCjptD
	4MRVtqvPaZDXryzYDoo2XR/e58jzbogx45slbTR7Gt0HLrtadV9Didhrs4q3OU=
X-Received: by 2002:a17:90b:28ce:b0:359:8190:eede with SMTP id 98e67ed59e1d1-35a21e795e2mr1526915a91.9.1773371027407;
        Thu, 12 Mar 2026 20:03:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:03:46 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 0/4] net: move
 netdev_compute_master_upper_features to ndo_set_features
Date: Fri, 13 Mar 2026 11:03:08 +0800
Message-Id: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBBFryKzbsoYW4td9R5FShonOqCJJGmwS
 O7e4L7Lx+O/v0MgzxTgXu3gKXFgZwvIUwV6UnYkwUNhkChbbGoUzpjZqeGl3bJ+IomLxrcyShJ
 KCWW1ejK8HcUnWIrC0hahL2biEJ3/HlepPvzfaqoFimYwt05jR6q9PsZF8XwuHvqc8w88iJjQu
 AAAAA==
X-Change-ID: 20260310-offload_compute-4c0bafa2e022
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C357627CF6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, master devices (bonding, bridge, team) manually call
netdev_compute_master_upper_features() scattered throughout their port
add/remove operations. This approach requires each driver to remember
to update features at the right times and leads to code duplication.

The series moves netdev_compute_master_upper_features() to callback
ndo_set_features so that the offload compute could automatically
invoked during feature updates when upper/lower device relationships
change. This centralizes the feature computation flow and removes the
burden from individual drivers.

---
Changes in v2:
- Fix macsec Security Entity uninitialized issue (Sabrina Dubroca)
  - Tested with macsec-offload-sh, rtnetlink-sh, link-netns-py, all pssed
- Link to v1: https://lore.kernel.org/r/20260310-offload_compute-v1-0-3df79c09ea65@gmail.com

---
Hangbin Liu (4):
      net: use ndo_set_features to set offload features for bonding/bridge/team
      macsec: move netdev_upper_dev_link() after macsec_changelink_common()
      failover: use ndo_set_features for failover offload compute
      net: no need to disable LRO specifically

 drivers/net/bonding/bond_main.c | 14 +++++----
 drivers/net/macsec.c            | 23 +++++++-------
 drivers/net/net_failover.c      | 67 +++++------------------------------------
 drivers/net/team/team_core.c    | 15 ++++-----
 include/net/net_failover.h      |  7 -----
 net/8021q/vlan.c                |  2 --
 net/bridge/br_device.c          |  7 +++++
 net/bridge/br_if.c              |  6 ----
 net/core/dev.c                  |  8 +++--
 net/hsr/hsr_slave.c             |  1 -
 10 files changed, 49 insertions(+), 101 deletions(-)
---
base-commit: 06fc88a6973fa6203c7c0cd3f5cef9d3405928ca
change-id: 20260310-offload_compute-4c0bafa2e022

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


