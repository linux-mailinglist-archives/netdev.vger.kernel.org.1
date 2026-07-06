Return-Path: <netdev+bounces-305143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DYHaMbTdS2q6bgEAu9opvQ
	(envelope-from <netdev+bounces-305143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:54:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 141567138BA
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ieREcGSs;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305143-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305143-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDA7A3046439
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F33BB127;
	Mon,  6 Jul 2026 16:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEC397699
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:30:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355450; cv=none; b=Gvm069TSs+NdAb7zFldPS07ptLeTzL6Q8XM/unMmNMeU2prZ5VhDpntACinbXowQ1dGvuguZnEiq9k1oJcXY/Cy7bEbUCZaDnze0ZRR6MKnSi00nRrglvAKqAklvh9E/yPkejN+gzAwVF///l1hk0IRDqhL4B9zM/ZQ9ph1VF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355450; c=relaxed/simple;
	bh=kZGJ+AG8k7z1AhUHlMzSYpOB0PjXJkfnba94h60d2Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UArJKgZh4NUNsNWCeHiZtW5/TacvKnjcXv+i9+OidTKgMD5Xv+FS+m+QmFI09XZHKWJ/UmChEM1aAlksVqvOOlCPxssIuUk9kvj7Rl7VwSPR+Y7R5fxOSQG48kODil8QqEtFgzuhMfav1rjwbJU5QJceOSCJOqNbO3xAJvMdeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieREcGSs; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso2377993a91.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355448; x=1783960248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2S7p41fhdY8PbIbjp4e54yvRY+OXbolqYasQoMvZcM4=;
        b=ieREcGSsrbnb+a08LXD/CXVbMh1sSoSm/X20QqguKwjQGhgYoDSSCZZA1I7nMoZEwp
         WS0XbQF9VQQA5mjBD9sZLYVkseRWvwUF+b+9HeT+Vf2GDhIBO2Ne830bBEGJm5307ezk
         0WrlMVEFEi+U69C608ROFLIhXeS6fry6doh3tjXXZt0NCpR3ndvbpsc9i/73WJjw8IOk
         8hMQcU/BhBD4OYNDxBLFpJ24PTrgWydNLZZb7wUS2qFf2kmnnErXR2XCHGIlKz045irI
         ZlyFzX0oIK24n8fqFw6HzCvhzOokwPrjzBlAybyDYp8MYMsqop7SXBUSnze4hcj8sa3X
         AurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355448; x=1783960248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S7p41fhdY8PbIbjp4e54yvRY+OXbolqYasQoMvZcM4=;
        b=S54Sf+6suWYCd2Ll4Z2gVGjtnIuLXQ19cbj1EgKs0kjPBsmQDQanYqB79lQKEwRmX2
         lV5kCFPx67QATvDayJfW/NjtUU6Dm0bmdh+C1UWrdNFLSMY1t/nsM3iq3psGYADhujZf
         HuzSJvU3kW9wfrq3eU3XNl2nBSLbRWMff+qpabWwvXzQMht1n7CsCDjSeOa5/JWpE0d3
         hWUu9f3uKuDsOBHMasmL4tlEL4fDFS8kwPuUa//hprMf2YpzEfZbZdL5GvGYMKi8pG35
         ORJhpvVChKxGJxEQ/BQKk3pV+h1xFLRv7+R1L/Cp83xBJ1NSfGP8C0Nj4o2nTbVseyXc
         Szsg==
X-Forwarded-Encrypted: i=1; AHgh+RqcIiUcvvpmQiw/zwiWM9+868Eh6WtJej2nxfBQCFIKA3Y+37w+CUa7AuU12ua1dyocV78B6Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIQZFvO2PcXP/cYQZp7VRUmYfyO/JyqePpZ8VzDqiOrtYnLTj
	Fj1MS08GaXu0xg01vz7O8GJ6T32ZsTRZNLSD/NrxkhsJnDezDIhSUM6F
X-Gm-Gg: AfdE7clemIOvIVPCzD50kLCrirNjIg2+z08YLAlOt314k6qQ0JQHcgR8Z8OuJAVQZDo
	pOMP3M6H/8FM59FIQgDZzf6H7T+4S/kbmXCgn7ODbzotOOsaO/d2Nc78e94U5g0/c7aP+KdtvPt
	WxgUmD+FM1QNa4ocy8kIOvPY+1O8u66Bbc2T7dzmu/Wu64PeATZW48ymaXgnC+173obkd/XxuoX
	IJXCNuinTPPJnJAVNfPRwBD/X9S7elXc/vMhgxGJgAP8iSWBfrsF38a2/tLNgtuJdcahxjzYuhY
	/DNkokcPubbWb7yrozhA50IO/m5Pl6k/fduGnEBZJnpgOJQkT2qrUunMg+vBXx+rsU9a7cZ4ObF
	weZDRhsMRo+okAl9PlYKSwhcZSceBCzZZxN96j/16gepb529IkIw/Cuyg6Vq+iDdkEjo3jWVZjD
	9rDVej8cHN3KfNkdwZTryqOdcq/8KoeiXRyVHTjCgDy2vYA2xqIa0mZ8aADGP6afftz+gq
X-Received: by 2002:a05:6a21:487:b0:3b4:b276:3650 with SMTP id adf61e73a8af0-3c08edd78aemr2004759637.26.1783355447937;
        Mon, 06 Jul 2026 09:30:47 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm64650831c88.8.2026.07.06.09.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:30:47 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net v2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Mon,  6 Jul 2026 09:30:25 -0700
Message-ID: <20260706163024.1205930-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,dektech.com.au,asu.edu,vger.kernel.org,gmail.com,est.tech];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305143-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hoang.h.le@dektech.com.au,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:tung.quang.nguyen@est.tech,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,est.tech:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 141567138BA

named_distribute() builds the bulk messages for @pls into @list and then
dereferences the tail skb:

	hdr = buf_msg(skb_peek_tail(list));
	msg_set_last_bulk(hdr);

If @pls is empty no skb is enqueued, skb_peek_tail() returns NULL, and
msg_set_last_bulk() writes through buf_msg(NULL).

tipc_named_node_up() passes &nt->cluster_scope. With a node-id
configuration the TIPC_NODE_STATE name is published by tipc_net_finalize()
from a work item, which sets the node address before publishing the name.
The node accepts links once the address is set, so a link that comes up
before the publish runs named_distribute() on an empty cluster_scope:

 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_udp_recv (net/tipc/udp_media.c:392)
 Kernel panic - not syncing: Fatal exception in interrupt

TIPC genl ops use GENL_UNS_ADMIN_PERM, so an unprivileged user can reach
this from a user+net namespace.

Return early in tipc_named_node_up() when cluster_scope is empty, so
named_distribute() is not called with an empty list.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
- Return early in tipc_named_node_up() when cluster_scope is empty,
  instead of guarding the tail access inside named_distribute().

 net/tipc/name_distr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..60ccaa862162 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -218,6 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
+	if (list_empty(&nt->cluster_scope)) {
+		read_unlock_bh(&nt->cluster_scope_lock);
+		return;
+	}
 	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
 	tipc_node_xmit(net, &head, dnode, 0);
 	read_unlock_bh(&nt->cluster_scope_lock);
-- 
2.43.0


