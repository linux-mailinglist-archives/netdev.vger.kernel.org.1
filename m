Return-Path: <netdev+bounces-295671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t2tUMTV5ImojYAEAu9opvQ
	(envelope-from <netdev+bounces-295671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:22:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D0645E8D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:22:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=kF9bpel1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E69AC30298CD
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3EA472775;
	Fri,  5 Jun 2026 07:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8A41C31B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644017; cv=none; b=vBKAge8T9DnbhYTzdd47Qr9OWZXwOhhWw4WnljIdztrG5cMUGk6lQZVoShoCQLAqsVmItvd8nJgamywFgslfC/7f7sL3Ni/FWYP3+XwUZdIgIzK6ym7YHcHyYDv9v6mQgVCJf8JaOODm0XCmFFdNh1GIZOL3EUV+BL73L9MBSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644017; c=relaxed/simple;
	bh=kmQh30uShESdgxQeSFBEAfw3lvFAnHgFESPVnlPvq9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZB7P3hbGNumfRAFYMWJGVLfBYuibWddkcYFPse6cr7qAoEYwCw/5qq25R7r1sLVod6eiPniy0salCxj0BuSzGG7x0FFEnMwlqyKm95lhengNNPbcdzG5liQxI831mqpCP1UaEPYFwMO3O1DW/rUDTBmBTkbPH4e9LEOhdMDkJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=kF9bpel1; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=naKYUFl2vGqcev/VZdeDENqs5fMgwMk1BQg8G5Yx5BA=;
	b=kF9bpel1wv90SxzGm4i0Ys3SaCLT73q9xxuXHFnFr32SAjrUZAaLdBgWkld2kHCbOwRbR0
	KUF9UCSJxqqtY6b09AUR3smIuBEOPA3wZzbxb6Jgjzg9g+tvWkWCiygzDGOeS3bYFJClMN
	ABeVNMNC57rkwyNFnrRGBxNpoQvKuG8fg+igGRDMhfYu11eWs/D7A4/o2Ts1XYDRojSO3a
	NerSNQnQ9/RmXbvWhODd2b/pvVW9sZf7sZ+UXr2xq0lIjnKoM9skkKdHmNEgf+wIKRbJqS
	/oBedh83P9ddQWEnA1fEKD/6NbDRsUrBnqU3T0gW3qx04831zNDXffpCMF7Wyw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 00/11] pull request for net-next: batman-adv 2026-06-05
Date: Fri,  5 Jun 2026 09:19:54 +0200
Message-ID: <20260605072005.490368-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295671-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:from_mime,simonwunderlich.de:dkim,open-mesh.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 674D0645E8D

Dear net maintainers,

here is another cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 626fd14371614b7a8177f79b357fd323a7b91032:

  batman-adv: tt: directly retrieve wifi flags of net_device (2026-06-03 08:27:17 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-next-pullrequest-20260605

for you to fetch changes up to 1e2fa2b10c234578d3c98c70f89c04a7aba4db92:

  batman-adv: fix kernel-doc typos and grammar errors (2026-06-05 09:12:09 +0200)

----------------------------------------------------------------
This cleanup patchset includes the following patches, all by
Sven Eckelmann:

 - tp_meter: initialize last_recv_time during init

 - convert cancellation of work items to disable helper

 - clean up wifi detection cache (3 patches)

 - clean up kernel-doc: corrections, reword, typos (6 patches)

----------------------------------------------------------------
Sven Eckelmann (11):
      batman-adv: tp_meter: initialize last_recv_time during init
      batman-adv: convert cancellation of work items to disable helper
      batman-adv: drop duplicated wifi_flags assignments
      batman-adv: use GFP_KERNEL allocations for the wifi detection cache
      batman-adv: document cleanup of batadv_wifi_net_devices entries
      batman-adv: correct batadv_wifi_* kernel-doc
      batman-adv: tp_meter: update stale kernel-doc after refactoring
      batman-adv: bla: update stale kernel-doc
      batman-adv: uapi: keep kernel-doc in struct member order
      batman-adv: fix batadv_v_ogm_packet_recv error handling kernel-doc
      batman-adv: fix kernel-doc typos and grammar errors

 include/uapi/linux/batadv_packet.h     |  6 +++---
 net/batman-adv/bat_iv_ogm.c            |  2 +-
 net/batman-adv/bat_v.c                 |  4 +++-
 net/batman-adv/bat_v_elp.c             |  6 +++---
 net/batman-adv/bat_v_ogm.c             | 16 +++++++++-------
 net/batman-adv/bitarray.c              |  2 +-
 net/batman-adv/bitarray.h              |  2 +-
 net/batman-adv/bridge_loop_avoidance.c |  6 +++---
 net/batman-adv/bridge_loop_avoidance.h |  2 +-
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/fragmentation.c         |  3 ++-
 net/batman-adv/hard-interface.c        | 15 +++++++++------
 net/batman-adv/hard-interface.h        |  4 ++--
 net/batman-adv/hash.h                  |  4 ++--
 net/batman-adv/mesh-interface.c        |  6 +++---
 net/batman-adv/multicast.c             |  2 +-
 net/batman-adv/netlink.c               |  4 ++--
 net/batman-adv/originator.c            |  6 +++---
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/tp_meter.c              | 28 ++++++++++++++++------------
 net/batman-adv/translation-table.c     |  2 +-
 net/batman-adv/tvlv.c                  |  4 ++--
 net/batman-adv/types.h                 | 24 +++++++++++++++---------
 23 files changed, 85 insertions(+), 67 deletions(-)

