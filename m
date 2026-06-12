Return-Path: <netdev+bounces-298681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s3ujFd0QLGr4KgQAu9opvQ
	(envelope-from <netdev+bounces-298681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFA367A075
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Jx206vMN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298681-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298681-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB91306339E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923E30FC27;
	Fri, 12 Jun 2026 13:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E3374745
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:59:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272793; cv=none; b=dYfovuyjwJ+XCkrVPyoutq9S96+7/nDR8cBncTP1vGPuQa6jwn4V//ZAcF3rib2oGsGfj2MepBGfHqPkP933vNEW5djtkev+ip5kk8eld3yLHY7SgSlnBIejvW8EnY9lkmeXarj7hPAMSSmR6th5pROBTtVByFh8PT+gbLu/a6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272793; c=relaxed/simple;
	bh=E3HVX7EHCo7aWBdUbef2HXXBxG7P73WLrcVCwzz9ac8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=crFcYD7rZbbHutsQtabDMGdgmnWcTkIMEIAsGGZC/au1AEYLOS/FHrurLg26dC6W3clBJ3lAwABnMNDtP58Ck6H4CJ1GHOpCwLA70aHsz13Bv1WG6ftInpadgIM9i+XPznXWz4dhUYq9J7f4ROTkmaMSXmCEFLXXDCuNZ2s1kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jx206vMN; arc=none smtp.client-ip=209.85.217.73
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-6c6dc39a6afso429948137.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781272790; x=1781877590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BreDQzRrIvVHgEfF5pB0PLXgNVhe9oipEZNUtxN47wk=;
        b=Jx206vMNhFcnmzYgFh1xOpgf8yTiBjzprk74onWF03rpWIg9wM27/Bb7/SIHOGYj56
         3ft98qOmK4zpGseR/W0o1JTDL9yK2CmqMapDlXumWbEsCNvbEDX87pSMX2sbtrRVyiq1
         b3GcdjlUOxSjy86967/ETPo436FvFXgD0sxK+L1gTBc/2RzcKW8aT1YcdN+IXABM+6W/
         oNOOIFpbmAbmpqDkdcXXhD7FPo/6AHP4wWT4keqCO7hFgRVT47i0pO+ZcHBuZC1u85BS
         2L6z5Wx9j3NuWrPfnilfWMybFEqTvk8l4QAKnun4zDjqVayEDZBkLiZ0kXyxdigVbj8V
         yq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272790; x=1781877590;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BreDQzRrIvVHgEfF5pB0PLXgNVhe9oipEZNUtxN47wk=;
        b=NsVfJ/RBmyGMJ7lFv1d+D4P+q6JJMdVgFnXjN/7LHtcVPSrGpfTeoopDbLabAtkh6K
         yiJHDjMIG5X++UH9yDHgP87b3bTPOV+AYhrWKLmmfTt5YEST93ogjvma6PqQPb9UTW83
         1srJUKOlju3Gu1VuLg1sGVTDi+9WGgtbMe6+KgHjsnpp+YtuI3ElDwe9uJKrKeo78OP0
         Vtvl99DgYSCLennGwQYxoJfODGq1uIsGdr77Rv171IYOhlmnmxFqgjywJNsHuWZuZrGD
         a2MAT+HJxsRIIKBROCNVENcGl3VBZruhKucECJZ7kocn/4EBwLr+n9/eScvneZ1DLxrJ
         rx1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8BpAnOX8RVMwZsxKx9jTLe56cL7jlBuvE+gOO6SfxZyYnOJoNLnQgjNuxYTL9/7ikgAutG92o=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOhja0grqpIoLiECQy5feqbMSe+aj5ROVeBGEA5m0Ph3e5Do6
	YW6VF7XF0UvBPkGKxg2Dtr9s0fDMeIzjetop1Y0HSkw+Np3HEf+IGoMiiZKYA1865+EERzIDtuT
	VNBZgS6CeuHfu3w==
X-Received: from qvbmk21.prod.google.com ([2002:a05:6214:5815:b0:8cc:2486:6603])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:cd0:b0:631:2cb0:bf8d with SMTP id ada2fe7eead31-71e88acea9amr1576961137.6.1781272789876;
 Fri, 12 Jun 2026 06:59:49 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:59:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612135949.4010482-1-edumazet@google.com>
Subject: [PATCH net] tipc: fix UAF in tipc_l2_send_msg()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com, 
	Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298681-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com,m:jmaloy@redhat.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,64ec81389cbad56a8c35];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDFA367A075

Syzbot reported a slab-use-after-free in ipvlan_hard_header() when
called from tipc_l2_send_msg().

The root cause is that tipc_disable_l2_media() calls synchronize_net()
while b->media_ptr is still valid. This allows concurrent RCU readers
to obtain the device pointer after synchronize_net() has finished.
The pointer is cleared later in bearer_disable(), but without any
subsequent synchronization, allowing the device to be freed while
still in use by readers.

Fix this by clearing b->media_ptr in tipc_disable_l2_media() before
calling synchronize_net().

This is safe to do now because the call order in bearer_disable()
was reversed in 0d051bf93c06 ("tipc: make bearer packet filtering generic")
to call tipc_node_delete_links() (which needs the pointer) before
disable_media().

Fixes: 282b3a056225 ("tipc: send out RESET immediately when link goes down")
https://lore.kernel.org/netdev/6a2c1007.428ffe26.258b27.015d.GAE@google.com/T/#u
Reported-by: syzbot+64ec81389cbad56a8c35@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jon Maloy <jmaloy@redhat.com>
---
 net/tipc/bearer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index a3bd1ef17558a37787bb92f2c3805c0fda874d8a..05dcd2f9e887a6e5ca6665ab41e4d5b5107f158c 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -482,6 +482,7 @@ void tipc_disable_l2_media(struct tipc_bearer *b)
 	dev = (struct net_device *)rtnl_dereference(b->media_ptr);
 	dev_remove_pack(&b->pt);
 	RCU_INIT_POINTER(dev->tipc_ptr, NULL);
+	RCU_INIT_POINTER(b->media_ptr, NULL);
 	synchronize_net();
 	dev_put(dev);
 }
-- 
2.54.0.1136.gdb2ca164c4-goog


