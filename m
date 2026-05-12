Return-Path: <netdev+bounces-287081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CAzNIgFA2r1zgEAu9opvQ
	(envelope-from <netdev+bounces-287081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:48:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B13F51ED49
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C63130162A3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFB3839B6;
	Tue, 12 May 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GCGnes4T"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5CE1C69D;
	Tue, 12 May 2026 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778582916; cv=none; b=UYjwws4Y3aw+7LkPWfkk7PWLiORam9qQOdh5Ng86hgvUfMO3XHL2aGUrFap4LzVCL/8yLh3Pia5/4oi0JfkRxjj/KZL//Wfac4i8W3V7rScDa+zkTyMBsymsCkKxYiS2Ad0FyR3+ePVYa5+LMgTSzyjdXwVQYfT3bRVzY8vHdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778582916; c=relaxed/simple;
	bh=Xpyhu0gx3qAWZfyagSYtaIwF2JX8wODFKIww0MHlD3M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hIkYj3IGm5JJfdbIxktqQW3H6hyPdy3NxvxBs71Td+2VSRmqcq42IHfgDwRAxjuOdiH3lnqZcrtU1S8V+uLY/nMtUCtCV34c5QluV5ABTQbxsXJ8usvaGkI78xp8Q/6wjKmJUWMf8mrDhXcOBgQXOoFmRUIItw6Ua6PIHlJfINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GCGnes4T; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NTHc7/TXQuaG6yxJNobhq0qcy+zWSc7ve7icffpht4c=; b=GCGnes4TRyK6+KyaphhDt0WjCg
	UVw97AwBm47CVC6tEs+kkce5NOg13zQiOXhYejKiKVmMjn157PU77yX/1IDlvGeo1M90Rmi4fjZeV
	A5mQgOFxi9dXVXCGFirOG9526SWDIu/V9kE6eMXDfJEeecSpWa1JA66ev5VYKPYuxzwVdZwoQQaFE
	5lMliEEgul504DEPoozoKMdyIoh4uCDrdZAwUKbHxBIJEpprg237yfs4QwD3UROlQEPvTa1KLKObs
	Rg8eMygUvP9T0wIvD8VBgy1gujUb0cH8iTPLKAsA5smD/g1BqtWlAUN5p2KcyYfMTjycVk2hZIiVd
	ln85/lIQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMkeu-002K1D-1X;
	Tue, 12 May 2026 10:48:17 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/9] netpoll: move out netconsole-specific
 functions
Date: Tue, 12 May 2026 03:46:33 -0700
Message-Id: <20260512-netconsole_split-v2-0-1191d14ad66d@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkFA2oC/3WNQQqDMBBFrxJmbUoMNqir3kOkRJ3oFJlIkopFv
 HvRrrv+77+3Q8RAGKEWOwRcKZJnqIXOBPST5RElDVAL0EobdVelZEy95+hnfMZlpiQLVxZK28p
 WzkEmYAnoaLuUDTAmybglaH9LfHcv7NNpPNmJYvLhc9XX/Hr8D625VFI5YxQaXRa5ewzYkeWbD
 yO0x3F8AXEoivPNAAAA
X-Change-ID: 20260508-netconsole_split-4f8402a9a9ff
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xpyhu0gx3qAWZfyagSYtaIwF2JX8wODFKIww0MHlD3M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAwVruZhaqqofMqOBnYmW9iviwPrCLlujSPMCY
 jxF0jcrBPaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagMFawAKCRA1o5Of/Hh3
 bbwmD/9DF14TyznXOnWjRYSFWhsTnU5aWIgry3dtQ9zgqTZJaWaK3x97x1/cKttOlhPH8JLormK
 rLLc2UFdXG64Hm+kvB2A27gmqmG4OOtI6dprQl8u3zNn8zWbPtHeFbEJ+hK79DsPI0+PEpPvxpp
 rXgSsO5YujgIdpWBWbZJyKrV0uBjm4MbEcmrsU9ydSp9/uT2Jqn23BQpX7UdWnVcBNpkKYurRO7
 pf8qg1PHR4QlEAaKRm1qzPJwxNA8qp1ujnxxs8JmRxghxLVxsBGHuvqZSodbjnm3VT/6ijMmxKN
 3Xn1Cjsq0gks+1AbOy4IkAmtDpfXKz4nnF2KvmaSA3pcnvwYJSThgzXmrLNw3UsskKujGqEG7tK
 8kg2tpAqM3U9dFWOS7OrqSiVEODGUDjNXJ2SK5MlV9PNG8QCfMN/Ypu+46gRJryzHksm2f5Pox3
 N1ikRQIQoj9+toj/oOuiNijKPaagLoTotqHIksFlMqb6pLexYWwvAra1x2/uNZDvZspH/CMNaGL
 TfM93eh1hH1rLxqMfWLzuyfB1fwj2JrIVysHS1kzw5mrO+c63iytuq/xkigNd6iffRgYKWiy5L9
 dttZMxaCe7ikPLpLTA3Ah8xjRbr8M2vSOAAqJpZSMu2LFhhxVxIdbIDM8XuSeD46QnLiO7LGAZd
 Jngm0w4KNyd12NA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 4B13F51ED49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287081-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

netpoll and netconsole were created together and their code has
been intermixed in net/core/netpoll.c for decades. The result is
that netpoll exposes two send-side interfaces:

 * a generic "give me an sk_buff" path used by every stacked-device
   driver (bonding, team, vlan, bridge, macvlan, dsa),

 * a second path that takes raw bytes and builds a UDP/IP/Ethernet
   packet -- exclusively for netconsole.

The packet builder, an skb pool allocator, and several
netconsole-specific helpers all live next to the generic plumbing even
though no other consumer ever touches them.

Worse, every netpoll user pays for that overlap: struct netpoll carries
an skb_pool and a refill work_struct that only netconsole's find_skb()
ever reads from, and net-core has to review unrelated changes (TTL, hop
limit, IP ID generation, source MAC selection, pool sizing) just because
they happen to be coded inside netpoll.

This is a waste of memory for something useless.

This series splits the netconsole-specific code out:

 * netpoll_send_udp() and its private helpers (push_ipv6, push_ipv4,
push_eth, push_udp, netpoll_udp_checksum, find_skb) move into
drivers/net/netconsole.c, leaving netpoll with a single skb-only
send interface that is the same for every user.

The moves are one function per patch for reviewability; helpers are
temporarily EXPORT_SYMBOL_GPL'd while netpoll_send_udp() is still in
netpoll calling them, then those exports are dropped together once
netpoll_send_udp() itself moves.

The only new permanent export is zap_completion_queue(), needed because
find_skb() still drains the per-CPU TX completion queue before
allocating.

struct netpoll is unchanged in this series; making the pool itself
netconsole-private (and reclaiming the skb_pool / refill_wq fields for
the rest of netpoll's users) is the natural follow-up, once this patchset
lands.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- rename and export {netpoll_}zap_completion_queue (Jakub)
- Change the commit to remove #include <net/udp.h> (Sashiko)
- Link to v1: https://patch.msgid.link/20260508-netconsole_split-v1-0-0f660e62841f@debian.org

---
Breno Leitao (9):
      netpoll: expose UDP packet builder helpers for netconsole
      netconsole: move netpoll_send_udp() from netpoll
      netconsole: move push_ipv6() from netpoll
      netconsole: move push_ipv4() from netpoll
      netconsole: move push_eth() from netpoll
      netconsole: move push_udp() from netpoll
      netconsole: move netpoll_udp_checksum() from netpoll
      netpoll: rename and export netpoll_zap_completion_queue()
      netconsole: move find_skb() from netpoll

 drivers/net/netconsole.c | 175 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netpoll.h  |   2 +-
 net/core/netpoll.c       | 182 ++---------------------------------------------
 3 files changed, 180 insertions(+), 179 deletions(-)
---
base-commit: 73d587ae684d176fac9db94173f77d78a794ea4f
change-id: 20260508-netconsole_split-4f8402a9a9ff

Best regards,
--  
Breno Leitao <leitao@debian.org>


