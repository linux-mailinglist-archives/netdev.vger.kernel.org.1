Return-Path: <netdev+bounces-304168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mefPMs1XRmq6RAsAu9opvQ
	(envelope-from <netdev+bounces-304168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1CB6F77D2
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 14:21:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=HcJNZKAV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304168-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAC47305C10D
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3549447DFB0;
	Thu,  2 Jul 2026 12:20:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2747DD60;
	Thu,  2 Jul 2026 12:20:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994838; cv=none; b=KVlQpv6gqTYEnzBPuMyT35MdSiBWG6ct91hmXgh6Tln+1reLRZlPqN+JKn4pxDe36z8M5oa77waKYFnylQw+4KBeo01Y7C7w0F8Qqyi24ZGtc+UQCvbISZirKyTw9XPF7/mDUCcaHiffOyIDAZpKwxl7bwqZbrOVjMcGZ0ZGYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994838; c=relaxed/simple;
	bh=k+RdVW4y6XRNAP/tCbAlDHhaQJqH9iAsrdawXtfwFyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LfFHP/VF+Dow+uWLC3dlrpeR7yH6BOyOjCotfl/5xNBef8bBGeLsQ7Z/vnfoDZe1Yk4VJ2+ROOMvSW1CN/OS4S5UgOJeax2nYdmWUXOQvhrtEaxRDKS9kxWpBthwYUn4HZz5PKHaKmOG7KJGrY4K87pxyb6hymcPS4QNwPpSxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HcJNZKAV; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=XzK7ebhzrgYV2swk/MVDTECwNp3DafJ5DvO3q3lgdAo=; b=HcJNZKAVG3zvjXKt6TXJnqcEcL
	/8puBKEBOWT8ra7p87DH7GPSjwNiASuIlxuJhYeEANoy+DryVB5coTmiiNXqAXxY0dF/vlkPtRnhS
	u+CigaQQxiggIxGJ7O6Egc1umJZcu2X53ivNK+o8vHJG6xqdXNGcwE7+7SAat1OaUunCMVvLdUD7f
	EdtJOXJlUCYqNEvAmtIAayfg57XOZvvMddsU4Vvzozoq+q77ghQ7LwTjTFzfYo+vgugwYNb71iLNF
	2druNEEnkFDxWrNbXR7c8Wy3IkBs20sa/RsO1rsc+TPx9NUBVAVIqjdMbnCGB+eURBC7RilUG1xed
	cZ1s1gnQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfGP4-008cQA-08;
	Thu, 02 Jul 2026 12:20:26 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
Date: Thu, 02 Jul 2026 05:19:44 -0700
Message-Id: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGFXRmoC/3XNQQqDMBCF4auEWZuSRNtGV71HkaJm1IF2IkkIF
 vHupXbdzdv88L0NIgbCCI3YIGCmSJ6hEaYQMMwdTyjJQSPAKHNRZ11JxjR4jv6Jj5fP3wkorbW
 jQ1W6cbhCIWAJONJ6sHdgTJJxTdAWAmaKyYf38Zf10X+0+UNnLZWsVe1015e17aubw546PvkwQ
 bvv+wdQjcqawwAAAA==
X-Change-ID: 20260514-netconsole_move_more-888fde03dfc7
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=leitao@debian.org;
 h=from:subject:message-id; bh=k+RdVW4y6XRNAP/tCbAlDHhaQJqH9iAsrdawXtfwFyk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqRleFYkUrpNqPSs3KddBkKtTfIfnb7UU0Yenrp
 kt5tQWiGqeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakZXhQAKCRA1o5Of/Hh3
 bWRFEACSNBkepay+H1Gh3vD7yGijhIttAJLuA7aEr9EFr/ioSsRLKBMSRshTWRbJjxnrT1LMWmT
 brZUOE1HA1+AmfuzM26pMcWlxjeq58sEe4/o6j3eSmWDVLMG4GqtxoHczFg7ah9NDdAcdqXmLUP
 6Fxt6cb2OmhgP4FZhkDj0+u1WxbqrY6Eo4o6y8xpjmQim/Jdhp+DJhajKm3JM2RlVUHwMLaArkA
 Bqn9Oht5r84tqEjRMvaNfEQAUq1ZFDETey2Tc+xhIhkQ0WMzjzxYYmPpyetANu1GKGuToBHO6Tc
 KS7bKQV86X78MEbKjSYcsvoUnqV2nFV01/VpE6p8wuc5qbQLICKXKzsAOjrqa/O/PKnZSY8Ts96
 OlfMp4gTka5djLMw8dP7sAp1hmsbenWSK65LtIt2Ksjnm6N666HhoRWJNbNaBtigZdQryKIiheb
 QaUZjVDjpwMsNzfkHm3IUbzUFtjWIkUbZCu5MrGaxGQvQe2Te4f1HpWTvbFspZCXetk4dy+5yZA
 ncACuLzp309170Kzeifm246EbA5XfGfxSJwkZZdG15mJhsDbWj7wEWXdD789B9zX7MkcBLqJuzP
 yXjmPIR/i86r83GrZhWVqWqZz5uHqNvAipSTQncq5ZwSUO/kE07G4Px9DFPECwqOx+YA0hb9Jb0
 XEUjLxFoBXQpoRQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304168-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E1CB6F77D2

This work continue to untangle netconsole and netpoll, improving
memory usage for netpoll users that are not netconsole.

struct netpoll is shared by every netpoll consumer in the tree:
bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
netconsole users only need a per-port handle that lets them transmit
SKBs.

Yet struct netpoll has accumulated a pile of fields that exist only
to serve netconsole's printk path:

  - skb_pool / refill_wq: the fallback skb pool find_skb() falls back
    on when alloc_skb() returns NULL, plus the workqueue that refills
    it.
  - local_port / remote_port / remote_mac: the source and destination
    UDP ports and the destination ethernet address used to build
    outgoing log packets.

Every netpoll user that allocates a struct netpoll pays for all of
these fields, even though it never queues a single skb on the pool,
never sends a UDP frame and never looks at any of the addressing.

Move this netconsole-only state out of the shared struct into struct
netconsole_target, where its only consumer already lives.

After the series every passive netpoll consumer drops
sizeof(sk_buff_head) + sizeof(work_struct) + 2 * sizeof(u16) +
ETH_ALEN bytes per port (plus padding), and struct netpoll keeps only
what belongs to the generic poll/transmit abstraction or what netpoll
core still reads itself.

Follow-ups
----------

local_ip, remote_ip and ipv6 are still in struct netpoll. Moving the
addressing additionally requires relocating netpoll_setup() -- whose
only caller is netconsole -- and its IPv4/IPv6 helpers, so it is left
for a follow-up to keep this series focused on a single responsibility
transfer.

This is pure code motion with no functional change. The pre-existing
target/device teardown races reported against v1 have since been fixed
independently (as suggested by Jakub) and are already in the tree, so,
re-posting this one.

Changes in v2:
- Rebase on net-next, now that the prerequisite netconsole
  teardown-race fixes are merged.
- Squash the local_port and remote_port moves into a single patch.
- v1: https://lore.kernel.org/r/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (8):
      netpoll: export refill_skbs(), refill_skbs_work_handler(), skb_pool_flush()
      netconsole: take over skb pool lifecycle from netpoll
      netconsole: move refill_skbs_work_handler() from netpoll
      netconsole: move refill_skbs() and skb-pool sizing macros from netpoll
      netconsole: move skb_pool_flush() from netpoll
      netconsole: move skb_pool / refill_wq from struct netpoll to netconsole_target
      netconsole: move local_port / remote_port from struct netpoll to netconsole_target
      netconsole: move remote_mac from struct netpoll to netconsole_target

 drivers/net/netconsole.c | 184 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/netpoll.h  |  18 -----
 net/core/netpoll.c       |  51 +------------
 3 files changed, 144 insertions(+), 109 deletions(-)
---
base-commit: 1c664ec4b9ea827b609d296921ed5bad8a40a158
change-id: 20260514-netconsole_move_more-888fde03dfc7

Best regards,
-- 
Breno Leitao <leitao@debian.org>


