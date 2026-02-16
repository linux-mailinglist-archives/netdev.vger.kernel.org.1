Return-Path: <netdev+bounces-258897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI1lNpspk2kI2AEAu9opvQ
	(envelope-from <netdev+bounces-258897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:28:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F6144A91
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C31DA30089A9
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186043112BC;
	Mon, 16 Feb 2026 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujvJV/rl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D5311956
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252122; cv=none; b=cCBSccqAvbQJ9V+HR5/wkchlmX5OXM/zN5QB49iZawYoxZQsnumpK0qONLpOARWt3ddhBlCOa5lZ/1/muj1ETlvHYUNAItzvF+KiFQ9GZ90JE1K0pU6r5EPADyqx33FjgubJWF35Bc91d9Eiqh6BLlN56XMh7nTP74gclpQQjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252122; c=relaxed/simple;
	bh=4yQMBwHwYOFVs5e4djBwLsjwPp+SPgMo2KUwyl6ugLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t2QoyPfkVRIxYmJWzn++I2C+z7uLuEzrBNflHZXKtZ6orRxFe8F/zckAf3gokrt9VLRdlTEXFTdleug1VUlIvgfsoaqc/qxsnChdxs7V7OrrNtcL2+2Qslw/x9EyDzyKNrGTPFzoeQD+jVOZ4cEkQGV/hmu+PDs1Lj5J2SK2jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujvJV/rl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c70b6a5821so1756804585a.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771252120; x=1771856920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR5KkdYlX5nClLDWPRAX9WooqTd04sPPtlXQNfq3YHM=;
        b=ujvJV/rlZFyLlYRTK2YRZdUZcNi5vQXtEWhrGSMo90E9jQ6A1fa2ymSd5DIwafqoZo
         /1WWd26LYqoViTFt92OZIIWBkhahDTo1rljvWIdsp9UpY/e/69SPJZSDOjdAvCWGYTr4
         /q6XegmbEv1h7cHXqNO+lRiKIDniiLlLGvWIwvk2rh4eG/+iiDA88AN/AsdbxRCIUo76
         In1LacQqktNPc8nX3TtpT8B8KTZlnNI8o6MIJQGZI/3iyd4ELWBrv1sJVMEn/uP49OUh
         AFVo0kst7cmE8hcF5qJHZHjdmwltx+hmgfZ3LuxzBazVjyH0MhFP8MWYLwAzzgu78ftr
         9cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252120; x=1771856920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tR5KkdYlX5nClLDWPRAX9WooqTd04sPPtlXQNfq3YHM=;
        b=TngeeCIfKQ8MVqpX3p+/MxYzhTAXeX+1rafEK6n9u96x2xlg1JVGrPqbWSHYZFA91O
         8MUgjllScnT+fMbxGdHiHzDDjyz4DSHnZfEJejQpp4RpmL1B2LX6gGNzUcEpIUxzr93O
         /Ww8b9bZFjjYeqOgteDa8YSPTcW86bUcZsCxLGzbj1E2drWCw8v7WMtfYjxUg9XYBCek
         BLZvPKcPAOMb+gSTvBnCkBwZ7sFCil5wGbxygB0uGc5gl7mF3NHiLGfNgDqkzOc9DwW6
         +gO8CtEAnvMHd0Hbfa/ijJI9TueEIKzE/B4pK7saIWLMk3yLz6bwD1g6mZ/kVsCk3p9M
         5Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCUBGKW4ixoNCcew9FXS/pgYx+cgSsc/HMYo2tVz9yEu3XUFhH7x0gu4/aHmcOMNZc1Bo21pCas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4mnddh86hVjw0IR7CMI+MJIWJdIMrg3Udxrmj8ZKGzDHp18F
	yPZJKP0hQ1LiJxK+Mg/F5rzGtAGznzUtLPVt784UmDedQqPtqpDwVNDm4o4l5TTOdZK+5RUX9Bu
	QJWY2ZnxNNhMMnA==
X-Received: from qknuw15.prod.google.com ([2002:a05:620a:4d8f:b0:8cb:3dc3:8e87])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:258e:b0:8c5:2ce6:db1 with SMTP id af79cd13be357-8cb4226c4a1mr1184139285a.3.1771252119353;
 Mon, 16 Feb 2026 06:28:39 -0800 (PST)
Date: Mon, 16 Feb 2026 14:28:28 +0000
In-Reply-To: <20260216142832.3834174-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216142832.3834174-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216142832.3834174-2-edumazet@google.com>
Subject: [PATCH v2 net 1/5] icmp: prevent possible overflow in icmp_global_allow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 850F6144A91
X-Rspamd-Action: no action

Following expression can overflow
if sysctl_icmp_msgs_per_sec is big enough.

sysctl_icmp_msgs_per_sec * delta / HZ;

Fixes: 4cdf507d5452 ("icmp: add a global rate limitation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index e216b6df633123ed475e28907d788db6bfb42115..eff8487c0aba8df0d1e515b9ac6ff7f9ac1de436 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -250,7 +250,8 @@ bool icmp_global_allow(struct net *net)
 	if (delta < HZ / 50)
 		return false;
 
-	incr = READ_ONCE(net->ipv4.sysctl_icmp_msgs_per_sec) * delta / HZ;
+	incr = READ_ONCE(net->ipv4.sysctl_icmp_msgs_per_sec);
+	incr = div_u64((u64)incr * delta, HZ);
 	if (!incr)
 		return false;
 
-- 
2.53.0.310.g728cabbaf7-goog


