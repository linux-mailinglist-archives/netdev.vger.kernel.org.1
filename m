Return-Path: <netdev+bounces-285833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPBLNI/l/WkNkgAAu9opvQ
	(envelope-from <netdev+bounces-285833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BBE4F7173
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E2F303AF28
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB883E6DD2;
	Fri,  8 May 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="l+tDFQTG"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD373E9589;
	Fri,  8 May 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246992; cv=none; b=flQcXviZ29/nQWJ5JZvn9FQgA2Snq/BL4IU2i4/9ht6IOUyPUiNvACqhKHgYV6I6DCel16yxA2k85BxfhUdXGuI7wyhBE+sbZSLZsANt8ZY6b78ECkF+6Q+H/Z1Lkm2WioTMsHFmUxqOC67wCNDdMVUDEZJA9rZjDZZk6u+8fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246992; c=relaxed/simple;
	bh=BygvRR3t8USioVj2IGPqyIjxDn2BecI1XCX+WTdsb6c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o/URHYEbPjQuOp6jPgYLfzEiKGsBAFOHRwOXLp/hY1SPFAuKS2AiZM8h1+BBB7KPt2ybtAdbdiYFcSjvTbDGoE2UhJV+TmDrmncElb8qo5XWaW7znwKb/FOYRTG7M7SCv2/1GlTy1x474h2FGARvp4mkq70QegVqBjvxXRzXZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=l+tDFQTG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=y02wCtygcu40KPA+nx038+vjAPgW28mGZJQDyB/oInk=; b=l+tDFQTGNn9IKaou6hMam1b6uG
	7YZsLXiJnBVWyziXy5Wu1cyZ2wsO7Q5toA5BgI0EVLEaspiCFn6ACAqwzQh0Zd4I9o6F+hGKMBIsX
	dS054l4hWPjpmN371Rer4buBULhfECv/6cgDdukmDAcfxIRvraU+xQoBXmofbm9wGMrWOl+4TyDcX
	ByfeQd2U22lkMpt8eVTkaMeGgk8H5JP/znu6iCUVq477Nb79WQaI/g3ThjiW7qxv3inXfpu3qd7Jh
	+RrrL6Y66iDyHuProIXafr4cv3bT7uq3CI9WTprUahPkzSAfPuLgNq2OZrBW9RfOU47Tt3KZoLH8z
	8XSQyZBA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLGn-005AyD-0w;
	Fri, 08 May 2026 13:29:33 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/8] netpoll: move out netconsole-specific
 functions
Date: Fri, 08 May 2026 06:29:14 -0700
Message-Id: <20260508-netconsole_split-v1-0-0f660e62841f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvl/WkC/yXMQQrCMBAF0KuEv24ghiptriJSYpzoSJmUTJRC6
 d1FXT94G5QqkyKYDZXerFwEwRw6g/SIcifLNwQD7/zJHd1ghVoqomWmSZeZm+3z0DsfxzjmjM5
 gqZR5/ZVnCDUrtDZc/qKv65NS+47Y9w/GGzwBfgAAAA==
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
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2825; i=leitao@debian.org;
 h=from:subject:message-id; bh=BygvRR3t8USioVj2IGPqyIjxDn2BecI1XCX+WTdsb6c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/eU4FwsMhaHJwrTK1+tWOId2ghJRsiWn+e3+E
 cWZY56cUq2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3lOAAKCRA1o5Of/Hh3
 bQzmD/sEkVLNcLihzwEUbyf51jnxUgsg8ZtThSeX5oVo0tIBYl3ZP2RH8/k2+DyC17pwAtNXrGe
 P3+QB9V31MUwVFKHJzJs3Tga1h8cJG9OydOxTsfChPid5MuMpNMxrDvuq4bF0ThfVnpfHC8iBET
 K15mwMzDK6FW87cXA8B09KnTHKKwoRbHmHdffDbY2KwEtcjUhP1UmKVCUZ6ZhFwF/Clv+tIraXX
 KN4GuZuVi+zrCdG7z/vWHQXfrmWxsW9bDmtgBNeXqJ/dpue9k1CoDgXrL9iFN0JHRVB/9N6ihFr
 GoBWLOyffU3xsAvO6ElMi/IpCuAPBZjMEm/Y2VhXmYdRIC1xkIiLYFZCQBbEXJeMJirkZok3gzy
 RVorMzxOb+DsYLzM31y5SvqI02cZp3o/iML42eO886xqwMnpUPKMa2l7gtxx7PnCAfL0DFN2w/O
 DPoqKO59Z8+CzDSBafu3dBoq6yioWZ2VMNeIrX2+lXwkyd3l0SdqYNC1Y5uIqGo0rr3GK3JGB9x
 MPgC55rhNlvk1VTfUpLLrv9DmlW1KtHPhWx2CyQ+MLvwn3BnrqcoXFkx1RvRKhyMutv1FUncAlf
 hTOYwWVrJcVJnz5H3IxrSbh71hXaSZh4MqGNXsCgIvfnt5/vIoDQdNM01Z3jpkiSOZssrbWqXap
 vkhjNs0ORxEhT2w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 54BBE4F7173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285833-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
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
Breno Leitao (8):
      netpoll: expose UDP packet builder helpers for netconsole
      netconsole: move netpoll_send_udp() from netpoll
      netconsole: move push_ipv6() from netpoll
      netconsole: move push_ipv4() from netpoll
      netconsole: move push_eth() from netpoll
      netconsole: move push_udp() from netpoll
      netconsole: move netpoll_udp_checksum() from netpoll
      netconsole: move find_skb() from netpoll

 drivers/net/netconsole.c | 174 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/netpoll.h  |   2 +-
 net/core/netpoll.c       | 180 +----------------------------------------------
 3 files changed, 178 insertions(+), 178 deletions(-)
---
base-commit: 6a4c4656b0d2d4056a1f0c35442db4e8a5cf8021
change-id: 20260508-netconsole_split-4f8402a9a9ff

Best regards,
--  
Breno Leitao <leitao@debian.org>


