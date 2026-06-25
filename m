Return-Path: <netdev+bounces-301875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B4duCf3RPGpCswgAu9opvQ
	(envelope-from <netdev+bounces-301875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 710DB6C32E6
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SSR1da6e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301875-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301875-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD446303FA9B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852203C0A08;
	Thu, 25 Jun 2026 06:59:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176803C1413
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:59:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370784; cv=none; b=oUwOdT0BJuTW6Wp4V1UqCFp+QH3lkSJwRpbaJXEFxXeuTEhi/wAs23eDvemu/HIMupADBVooFOPgfxlAaDaHXhGNjSwcfjmu51qW+K4ykvNAmoWER8bZEGbSUfXVTj/sVipcCh7hsmm2lVDN61LEqVH2Dw6PRK1dJZcTZmbZN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370784; c=relaxed/simple;
	bh=k2hkNVOm3fEAsbOoHXfBIjlhvNAQZAhhkr4z4gKOYdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X5NKe41Akt+FHALCVKo4PtayGfbQs12pdmFS63P5eRB/rm3/+9+r2hJdI9m5A4/d5wUpGIofkRz913A0eROlmZTV4J3z8Qc2mSGFqdzjzwDCloVLU8ztytE8Cq1fZtcGMIhMCQtH5zCZptTHP50wTukhBSC7ainAJLZuS3cw1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSR1da6e; arc=none smtp.client-ip=209.85.222.201
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9157d38ab37so158389885a.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370782; x=1782975582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYrxUau0BD1qXyAIrpir4FJmc8wiTGKSYlayRcir03E=;
        b=SSR1da6eNC2Mtzvb20JXMZpK/psmIFcPc1d72OPl70d4Bycug0h4/Ii/I44doQb76H
         zB2sNuTJM1kCt6RVMtW+8HehmAvGZvQ59iLlcn1jP2NjOMCPRKas6f+VwvcAU8yuAGzC
         GnOCjd2kbgeV5CThffPVmMOOniOTIBKd986Pa3zZ21yN/xWiH7ilb2DWhll18SRWTqKB
         7wx7qZcxLpoSy9QoS1Nyq8TSR4Q2zNPo9vSOJNLOwdG56722vnE+yVGEFjHm2kDcz9Tj
         4CMzjU94B/cFYeOR3gN6mB4TYjiMMehJ/xOUDFPJIvOYAkdjC+rU66w7Lwi0inzAqQ8E
         jl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370782; x=1782975582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYrxUau0BD1qXyAIrpir4FJmc8wiTGKSYlayRcir03E=;
        b=M71LyWVX6Imw89UW8bqk8J/q+D2lUME1I6siLTyH61GGuHEP5vKWFAK75yL8TwSsJx
         SotAQqdcVUGgZP8SLQG1ul2Y7R5xpi7eQhm2Sg5A4Lt3H7Jdfypul23VRYrC1NL+oyIy
         fbz3zBevZ1J/kZVrjo8QQpyXZFjotkfXq60lgud8oiWo39DzuWwQU2qBJnFcxPsmZusp
         m0SXpECG8Z7jvAFhaYWxsJtrfLn9WGBwtc6kLQVeFdmYdXeQQg2yN//6WhepLXSeuI3z
         6PmT98aQRPPLa68avMQfsJ2MYFisb1GGSje4VUXC/cBG4Y66ByhuZqNn6eL2Uva/BPI+
         viXg==
X-Forwarded-Encrypted: i=1; AFNElJ+BXqrshu+ZhlqloV5WZDx2Y+ElEFNRnM0Z2cQi9H7tZASPMCkFUBlkznIZHTKUv8XeqUFsLUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNz7y0p6lQdUr7q5TpJQqMZCm0SZ7X6FKnyyviVGhO5v6W3cIJ
	dYqXkWxwknO1MboV+ww/YEJ3qagAV98wmn3l6SUXuaF/k6oTyAG4GrbwK89sb6h5howM6pgpiDv
	xnm8pTaKl3ZlWwA==
X-Received: from qkntq7.prod.google.com ([2002:a05:620a:3d07:b0:915:7b77:7800])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2686:b0:923:2337:7fff with SMTP id af79cd13be357-9293bb44b0fmr140792885a.17.1782370781603;
 Wed, 24 Jun 2026 23:59:41 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:59:36 +0000
In-Reply-To: <20260625065938.654652-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625065938.654652-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625065938.654652-2-edumazet@google.com>
Subject: [PATCH v2 net 1/3] net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fomichev.me,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-301875-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:samsun1006219@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 710DB6C32E6

Yue Sun reported a use-after-free and debugobjects warning in
udp_tunnel_nic_device_sync_work() during concurrent device operations.

The workqueue core clears the internal pending bit before invoking the
worker. At that point, a concurrent thread can queue the work again.
When the already running worker eventually clears the work_pending flag
to 0, it mistakenly clears the flag for the newly queued instance.
udp_tunnel_nic_unregister() then observes work_pending as 0 and frees
the structure while the second work item is still active in the queue,
leading to UAF.

Fix this by returning early in udp_tunnel_nic_device_sync() if
work_pending is already set, preventing redundant work queueing.

Fixes: cc4e3835eff4 ("udp_tunnel: add central NIC RX port offload infrastructure")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp_tunnel_nic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..3b32a0afa9798d3c416d9ae570e6d529f70e6697 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -301,7 +301,7 @@ __udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 static void
 udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic *utn)
 {
-	if (!utn->need_sync)
+	if (!utn->need_sync || utn->work_pending)
 		return;
 
 	queue_work(udp_tunnel_nic_workqueue, &utn->work);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


