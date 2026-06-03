Return-Path: <netdev+bounces-294613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4nXECCvcH2o2rQAAu9opvQ
	(envelope-from <netdev+bounces-294613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:47:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B456355DB
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=ktaJSYfV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294613-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294613-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDC413080E0C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4843F8EB7;
	Wed,  3 Jun 2026 07:25:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B53FBEDF
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471539; cv=none; b=GXhUIhM5R/je7mxSsGbXQoq2L85AUuQNQwMgaiWv/PCIRfW3LJyfRvxdYrfVN2vIHi89Ow6jX547uCAzaSZ8vH4vQwFJCM7jvHGURlybSB1wSXfOT0vrCfjcSTIbLJIJmWw2FjvIwuTNlQIaGCE9p5TUAaE3buvNvWRlW/HU+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471539; c=relaxed/simple;
	bh=lOFrGIB0RXuE+tI/wl5OfkNPREXS18NGpdjBWvnxaFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvPkUcDVtdONIeUPx8JQI7a7+jr6+N9SFZqxqn+KxEgVU3WMRBAmzwrmHQaTwgh6ODvKoDooVLgnfILYW9PcTIYYx0IB68ZZe34uxWVO4tQ0DPHgVfv+LyJWywt9Q8tp+m8S7s5KrqpcGYH+IfJ/dGfT3FW9FIAbkECEPUMKB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=ktaJSYfV; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sxZPgU99qOXY+5M+wANcE85GhLL1lWamNFd4yIpqUI=;
	b=ktaJSYfVJdGU6SVFMJBv7Y5EIB/tPeulo7JNNbgfceV4d1cKNABUOjYjHbWf2d3GjNaOWN
	KT4tncoCpOyynvRsqY8wmOAt+TSHC7+OpZMvBnWTh8ZbIovrKHdJL5WuBbaTEvOQ5a/2tT
	1NKjId+CFZa6qMIlGEH21Z6wNQnk6JRDeYb4VVwcF6VFxZ/XiSbEi6kQHR+pHHNj3n+E/Z
	vbzdbQuwaEZN84mxQIw4CR0oeQIdGKCYHqn3AcBe5xaZzMj3y6oF7K9h730xMkH0tmMbxF
	trkF3vpti48pV3X93lj39kJfqaGk+lZD4gcPDcpRPUovo1HRDlI1EBKkC43avA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/15] pull request for net-next: batman-adv 2026-06-03
Date: Wed,  3 Jun 2026 09:25:11 +0200
Message-ID: <20260603072527.174487-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294613-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[open-mesh.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:from_mime,simonwunderlich.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23B456355DB

Dear net maintainers,

here is another cleanup pull request of batman-adv to go into net-next.

Note that this pull request includes multiple fixes which we consider
non-critical and/or minor, and therefore want to send them via net-next
instead of net as per Linus' direction [1].

Please pull or let me know of any problem!

Thank you,
      Simon

[1] https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u

The following changes since commit 3bd64ca11d9a1672d67d3130a7264c2cf7f93cdf:

  batman-adv: use neigh_node's orig_node only as id (2026-06-01 14:22:03 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260603

for you to fetch changes up to 626fd14371614b7a8177f79b357fd323a7b91032:

  batman-adv: tt: directly retrieve wifi flags of net_device (2026-06-03 08:27:17 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by
Sven Eckelmann:

- tp_meter: fix various minor issues (8 patches)

- tp_meter: split generic session type in sender and receiver type

- tp_meter: consolidate locking for congestion control (2 patches)

- bla: annotate lasttime access with READ/WRITE_ONCE

- elp: prevent transmission interval underflow

- tt: sync local and global tvlv preparation return values

- tt: directly retrieve wifi flags of net_device

----------------------------------------------------------------
Sven Eckelmann (15):
      batman-adv: tp_meter: keep unacked list in ascending ordered
      batman-adv: tp_meter: initialize dup_acks explicitly
      batman-adv: tp_meter: initialize dec_cwnd explicitly
      batman-adv: tp_meter: avoid window underflow
      batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
      batman-adv: tp_meter: fix fast recovery precondition
      batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
      batman-adv: tp_meter: add only finished tp_vars to lists
      batman-adv: tp_meter: split vars into sender and receiver types
      batman-adv: tp_meter: use locking for all congestion control variables
      batman-adv: tp_meter: consolidate congestion control variables
      batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
      batman-adv: prevent ELP transmission interval underflow
      batman-adv: tt: sync local and global tvlv preparation return values
      batman-adv: tt: directly retrieve wifi flags of net_device

 net/batman-adv/bridge_loop_avoidance.c |  28 +-
 net/batman-adv/hard-interface.c        |  25 +-
 net/batman-adv/hard-interface.h        |   1 +
 net/batman-adv/main.c                  |   3 +-
 net/batman-adv/netlink.c               |   8 +-
 net/batman-adv/tp_meter.c              | 739 +++++++++++++++++++--------------
 net/batman-adv/translation-table.c     |  32 +-
 net/batman-adv/types.h                 | 141 ++++---
 8 files changed, 572 insertions(+), 405 deletions(-)

