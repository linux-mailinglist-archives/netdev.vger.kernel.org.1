Return-Path: <netdev+bounces-281273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C+yOQIo72lE8AAAu9opvQ
	(envelope-from <netdev+bounces-281273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:10:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37CB46F985
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EACA73002B5F
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CEF3AF66E;
	Mon, 27 Apr 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhDNyH6M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2C3AF64D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281020; cv=none; b=oXqbbs/qlIUzKj45Uu0ngkK7aom69IPdhtbIvyq8IzJOeX8WzZif6f0L9EWhgiUQtojSKtL37UhcHR3d/3IV5WpXBMNDulUuWv7T7vw6JtGY3IfurAzPNqH+k2zft/rUEZg+0m7zHbTgiXUmELfRTEv8oxwqtrxWrlu0fjuaFhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281020; c=relaxed/simple;
	bh=KcBYy5gE0rcC70cVBpWdyMlYiej7TxV8POZ3cCXJ1+g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ok1bYeBCSEdkIueYpUR1A2WPiQ8BlU1oVno6O2LqI+fR+lZ1eFeU3xNG5fHe6d/+TlLlIwDdqbi9Rh/TALF8hf5DeWEd8z+qG52WOYDfjT3vNBqpDPckeakCd3KFD2NCxE+JH0cwEQ+SBJvZ5Q8m4MBHi6PFMJIQlPzEUDN4A44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhDNyH6M; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8f4ef450191so193453285a.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777281018; x=1777885818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfI0Dkf/Zmvbvrmq9b6GnnGR4/LmoayXepGLlAlqINY=;
        b=BhDNyH6MmWK0XnMiMqK/qwtn9+ESiggzTkQG7XCZxU1xcJ/TdKBVGtwao7l93UOG3m
         rktcFyq11YVOKdWVpxdOg6dMqQqsmlyMeFzNjOYQYCbGqNPDSOMMEBpnwWL1suUWi5Rc
         POIuFLGXzmnDRvUxevdKPwFri578UIzTL/YYtfmYtgUtDGIFy9Jb0h/W83MVzUI0SCv3
         BYSGgRGhEKuyU81mbDR8KWRc372a5I/OEH83NND30/OE3XqiOIgWo95uH3A4ZIXUlHO2
         7yJSrRvECbhSZyT4lWkgNRY+H+RZ3w2suCArn9AEuo3a2CcdTnITe0YyKTj2E0hh6qqe
         S0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281018; x=1777885818;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfI0Dkf/Zmvbvrmq9b6GnnGR4/LmoayXepGLlAlqINY=;
        b=PvbMcNG+IAxjmPVZxNEgkPkxA3CUheDBSwHYRIbgYG4myRuXY3jU3evZm9JiX/I0Dx
         LqDhNcXNgHmcNHslOwDlaUx96YYDE5rnmssjVHie9nR/tBRW6HD5qh/jSZrZWz/b+6/8
         LPBhGfukdvH6pJnsVQ4NlfN5W1Qok8qn1dRphNe69GfKMfYtwfjiJCXgBzFDDUPup0K+
         4SMdjQWF5bQ5uDsZwEmnWxmgL3yEmFrkjTnxwlnorXRyiCD+GxwnkAjdOyDGwveWYkQ8
         BSVKMuPA26mLAGEsPu38Efzlc+O6XSu2MvVqUBY8qlu+Qf1W4jqdk4tWc4qT0zdGRlGU
         YU1w==
X-Forwarded-Encrypted: i=1; AFNElJ8BYGOc8e2FKTGkA1aVTT+4Kzs254yGdwduv4ZdB7R/f03R8s2EgPZNqspwOMZYFm7HecR7XnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTVRbRgrmF7HiraQwozj8NFjRowFizHrt5s4PImG3y5LqXPir
	vA66/oaxh81jGLpgzLNyrF4NvhO/VnsY3B39/jBKWvT+/ANC2Ak+0AdUNAESLLJNuU6whOdF55g
	/wqEpjf1VNRzkqQ==
X-Received: from qkll6.prod.google.com ([2002:a05:620a:2106:b0:8ed:c809:7fe3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6ccd:b0:8cf:d565:fcb1 with SMTP id af79cd13be357-8e78f5427bfmr6114150785a.5.1777281017834;
 Mon, 27 Apr 2026 02:10:17 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:10:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427091016.737015-1-edumazet@google.com>
Subject: [PATCH net-next] net: dummy: do not acquire RTNL for too long
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E37CB46F985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281273-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

Instead of holding RTNL for an arbitrary amount of time,
call register_netdev() for each dummy device created
at module loading time.

Tested:

modprobe dummy numdummies=10000

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/dummy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index f8a4eb365c3d068399c7af9305785aea1a5a7aac..f6732eab5923f02d0164f2a47258b87740f8c593 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -158,7 +158,7 @@ static int __init dummy_init_one(void)
 		return -ENOMEM;
 
 	dev_dummy->rtnl_link_ops = &dummy_link_ops;
-	err = register_netdevice(dev_dummy);
+	err = register_netdev(dev_dummy);
 	if (err < 0)
 		goto err;
 	return 0;
@@ -176,15 +176,11 @@ static int __init dummy_init_module(void)
 	if (err < 0)
 		return err;
 
-	rtnl_net_lock(&init_net);
-
 	for (i = 0; i < numdummies && !err; i++) {
 		err = dummy_init_one();
 		cond_resched();
 	}
 
-	rtnl_net_unlock(&init_net);
-
 	if (err < 0)
 		rtnl_link_unregister(&dummy_link_ops);
 
-- 
2.54.0.545.g6539524ca2-goog


