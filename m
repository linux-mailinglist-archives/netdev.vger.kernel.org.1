Return-Path: <netdev+bounces-276315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJcaMEAA1mk7AAgAu9opvQ
	(envelope-from <netdev+bounces-276315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378123B7FC4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A00DE30416DD
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5DF37700F;
	Wed,  8 Apr 2026 07:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ8w5ImT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040B371CF5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632141; cv=none; b=UXzhBXW294abFExHztpZ9OinZomdgL8bil4TTPr+h4qbBpMsaHn78j5b0BZtEQK/4r7CF5bURV3zIuKy0C8fJq3DFMZ7n06uiszAn3BBN6mPJt45dI8N3bAclPpQH5ax+VV6XKA/WxyJYSuHUg3xbuSKCmud/E4zPexMFcc9pNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632141; c=relaxed/simple;
	bh=feFw6IVXve1DpkDo+M0LX1fTZEw1YMZ6SfqXev0Btu4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lLdTcXkauXSvevOtv4yK6vihOdIQEA28W3LxKmnycaIBM48Yj+wHvXILgwv4MStogwsvXy5Z4la67AXF4cIRIhRmcvOhHenG2iF46LpUFtNDFA/yUbFBC3hRQucq9IrbHxW2C4+YXjsyoULKi4ObCUy/8ObiLGEXZLdUCY6ajrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ8w5ImT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b258576d8cso37117325ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775632139; x=1776236939; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sHpHGFAFr6N1nLJ0rv6fDETZjOTMbNtpx03EFXi5Mtw=;
        b=EJ8w5ImTygiOqh+5M70ntHc2uTUyRikWRvfv0W+gYEX1EBe7vQ7XkUmUz4oAPGJm9B
         ryao50xXAdjvUrSvP6AUTHlduPRYpY0+AloXOgFfztO27QbOg7waj4ydAQlxDGWE8Txb
         JSsT8nF+Rm1GQQ+P0Pf66B64b1Vm6VzVL/nnGthoTEWzskNWDtnII47rQIF1OQ+H80L3
         eJvmiAybswdOx0kM3bY8mNGlj0yJh2fq4xox8aGDO6Agdv2mkm1nexRyBcUw5gwBiQN+
         EK8B7bW2QHpYs9eIdITtZS7KxSiycdPssZCoFgU2rZBt6TgTjpmbaiNujpaE2ZNJy2Gs
         /KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775632139; x=1776236939;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHpHGFAFr6N1nLJ0rv6fDETZjOTMbNtpx03EFXi5Mtw=;
        b=RI0HaXTT7oxaSPR4w2wAqJngbOi7bhiItscguU1ZSsMwC66FeQ1AHr56xhrLS4pnir
         LPSRBYOoMN7j2k4e9VThUJ00KLdqpqBZ7abXBFImvJAMhJLXzOzoHtL6mpvI4t8ycx0f
         dW/b3HzE3xLXvRPZb/3e8lEr4P4qI7HOKKty91P73magICsGNyWVGdEQsf1rAwcVcWGZ
         0pXZd3Liot3DIB4aniswx5BLrKUzFHnW6sX7q+2WhgBfRCyTMqnwUNLyZOe+qpRe18vi
         pbTPsyX+l02Q9aT9Q7aAZ/w4tAfhlfGMKVhLKvHn6EHCX82hZNeNWsqAHBlotq0jI69b
         Fv1w==
X-Gm-Message-State: AOJu0Yxb7F4SAkEfFmFuuTAp0rkrCYcALiOINocq4s9LaApK11cNq7WO
	PrYQAZuD06IhoiMsEPi5d4gRAUcmGkIkzWI+STpfV3xJq/os0btYU2EJ
X-Gm-Gg: AeBDiesgJ2hyMpsVk3BcFxHH7sSHOgp2EIiThFT6qllizhQtVImgJ1CGOQK/u9IDQZT
	6p7thhEIh6+M/lAB1YS0orpIpVJOWIzWAWpEhF2/X0FmKN958mCuj90EUrRu5LraKXe1fWfyxew
	NUnBiMKRDJfvfE42Uh5qe7k88mu6NVZG33wL/aT08oNXizkgXsJ+WNhtRVDBdX0R3MKrf5580ZH
	Oihp27W6gl9Ykpba0w0YfP/KHc9B5Xhvyl2RRjCHxBnaeggJlvnvMEXH0Wtp5mW6+7UGQcjq+Pv
	tfZCJp9TFRFGXOY4ACUmvEHvJjkTXd75SNYV7kWs/cHkRWBCnyMKcq3Ka+xyDauW0zgmwUNTqCe
	R5Y8o3vMYlRwaqG3RhmDrTzMDeCvOX2PFIPraJVJlhdFzFW6m/1CBJlkb5/JQ4YrycjAyp1qnow
	plUWTV0ZiZUPGIr40a+HiGa6cEii6/mABvlgu2tYeLclwsjgqn
X-Received: by 2002:a17:902:ef4f:b0:2b0:663f:6b53 with SMTP id d9443c01a7336-2b28180e4cfmr197581305ad.13.1775632138533;
        Wed, 08 Apr 2026 00:08:58 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm202917785ad.68.2026.04.08.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:08:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v2 0/5] ynl/ethtool/netlink: fix nla_len overflow
 for large string sets
Date: Wed, 08 Apr 2026 15:08:48 +0800
Message-Id: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQqDMBBFryKz7hQdtdqueo8iJSYTDWhSkiCKe
 PcGu+vy8fjv7xDYGw7wyHbwvJhgnE1AlwzkKOzAaFRioJxueUkV9hVudnpzHKNzE+q2kaoiXTc
 kIY0+nrVZz+ALLEe0vEbokhlNiM5v59NSnP4XLYv/6FJgjkoJEve+rpVun8MszHSVbobuOI4vr
 Y8XvbYAAAA=
X-Change-ID: 20260324-b4-ynl_ethtool-f87cd42f572c
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276315-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 378123B7FC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses a silent data corruption issue triggered when ynl
retrieves string sets from NICs with a large number of statistics entries
(e.g. mlx5_core with thousands of ETH_SS_STATS strings).

The root cause is that struct nlattr.nla_len is a __u16 (max 65535
bytes). When a NIC exports enough statistics strings, the
ETHTOOL_A_STRINGSET_STRINGS nest built by strset_fill_set() exceeds
this limit. nla_nest_end() silently truncates the length on assignment,
producing a corrupted netlink message.

Patch 1 moves ethtool.py to selftest.

Patch 2 improves the ethtool tool: rename the doit/dumpit helpers
to do_set/do_get and convert do_get to use ynl.do() with an
explicit device header instead of a full dump with client-side filtering.

Patch 3 adds a --dbg-small-recv option to the YNL ethtool tool,
matching the same option already present in cli.py, to help debug netlink
message size issues

Patch 4 adds a new helper nla_nest_end_safe() to check whether the nla_len
is overflow and return -EMSGSIZE early if so.

Patch 5 uses the new helper in ethtool to make sure the ethtool doesn't
reply a corrupted netlink message.

---
Changes in v2:
- move ethtool.py to selftest (Jakub Kicinski)
- add a new helper nla_nest_end_safe (Jakub Kicinski)
- Link to v1: https://lore.kernel.org/r/20260331-b4-ynl_ethtool-v1-0-dda2a9b55df8@gmail.com

---
Hangbin Liu (5):
      tools: ynl: move ethtool.py to selftest
      tools: ynl: ethtool: use doit instead of dumpit for per-device GET
      tools: ynl: ethtool: add --dbg-small-recv option
      netlink: add a nla_nest_end_safe() helper
      ethtool: strset: check nla_len overflow

 include/net/netlink.h                     | 19 ++++++++
 net/ethtool/strset.c                      |  3 +-
 tools/net/ynl/tests/Makefile              |  5 +-
 tools/net/ynl/{pyynl => tests}/ethtool.py | 79 ++++++++++++++++---------------
 tools/net/ynl/tests/test_ynl_ethtool.sh   |  2 +-
 5 files changed, 68 insertions(+), 40 deletions(-)
---
base-commit: e65d8b6f3092398efd7c74e722cb7a516d9a0d6d
change-id: 20260324-b4-ynl_ethtool-f87cd42f572c

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


