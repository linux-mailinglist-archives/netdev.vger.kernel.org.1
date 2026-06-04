Return-Path: <netdev+bounces-295270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WjudFs+LIWqLIgEAu9opvQ
	(envelope-from <netdev+bounces-295270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:29:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61F640E2A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:29:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=azdgDWMF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295270-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295270-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85AD3303C8DD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F147ECD3;
	Thu,  4 Jun 2026 14:13:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D1472772
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582429; cv=none; b=Elo8JlKPpa/v5g1aZ7H+u8+3Z9YjGEf3Jw5YsNtaoYFsWKo/yoyXIA3t0FtjRO6tMf0oV2nGFErDMy5F65YfhpPA6BMaw9MlID+dHdSBSlOw4Lxs52xsRC+2oEYEmeWT7HxwbM7P9zlfQm0Da2XO1b7E5VFyj5vPzVeSZdtRHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582429; c=relaxed/simple;
	bh=ll1d6D/mCvvNOaZJ2ZWt1HhXCi/uNGg//rlXeO7ijV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V1gyQ83byWCXrLU0LRdsxz5qeVUdYFBXvN+UaMnIz4VI3ZnQchypA2XIOzdMnIvW1rB/3mBnfoSBCIaTj2pqTnkdFJI/8xIplquvPDAmijfQHnpaRjoz0j4doLrOLqwxELejyQUNoEHUz1wPAZNWJig2//lC+YmoTg0Jpl8Rojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azdgDWMF; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-66043ac620fso1417244d50.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582427; x=1781187227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aveLMHlnviqtytDsiSdbRJSwTX2GOpu8oXn6tzESZ2o=;
        b=azdgDWMFeTGglODFO7+4gkEKacghbhYeMxhhE9KvYnu7g771y2tzRvW2IFdDSa9fVF
         ATPJsojfXOetlZyAbZ7rAFckAj6Cw1IdfvGvmRSnFgfsqig9h8Y5GOrhR8E7zM3vEIzI
         gTAo6WlTqmjQJf191tmGqMSfj5pRF7yn9hweHqa/BE3wXbnrjNvDjrI9VPYQjzQdFrju
         FMgU9mqBncMXPBXV82bhTgyLrZNzzExko2YsJtPttQ+JIZDLYFKYZWabJtnCvEl/gr/y
         Px60RDeKbEme822JlaKIp1434RM0JCjaboXSi57cmrsKk3WvK1eVw7fLt+1+n/g4aFfd
         iMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582427; x=1781187227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aveLMHlnviqtytDsiSdbRJSwTX2GOpu8oXn6tzESZ2o=;
        b=IvVAQzOk8QMyFJwubnoxkiDtIBTe4wdbb0YDnyNY+X0mEeEctaIpHcc5TFWhq8loBJ
         XT8FWii4TYeX/aSSqqrRIA1fdgdYTbrTZLKcdEeEJ/wGqLjTnn30Dx747Gwa4m5K2O0x
         DvKcVZstd3jPKypqZ/siDSggV6E6WtzFeWUY8rg+TKL7q8P/qVR5tx217y+xyxyJFNBL
         qpqwygsKvmLaebHjm4OQ58srzQ797vjpUEZglR8qTB78CbazsoVcZkW/m3YK3OugNlgC
         //3g9toIAf+KlrFbHBsiLML9obmR1DUfRYozdmEktLVmoCGlH+ug7vrBpTL3xVdvtdYk
         g9Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+VvjU8/0OFXvwkg7eHPMxHyEFciVMoZ4dUp1FdYsIaBOXRejc+Kx9WTVrd+gAzw2k7YnJW5Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3my39AwUAS3K8wWxKOOOwiXpiAxiWLIux4QIXRSwf9NbkIu/
	Yd5UkdjgcNwiEjhTDLYZ0fiGs1ny1WLDwYC6JvpYTMV7JCr4sCiRktYrT4zLEdjzH8gULqjEKAr
	ny2LOrvKi+rSF3A==
X-Received: from qtbki14.prod.google.com ([2002:a05:622a:770e:b0:517:82a8:c7a5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1288:b0:651:cf29:430b with SMTP id 956f58d0204a3-660df4810acmr7057208d50.12.1780582426617;
 Thu, 04 Jun 2026 07:13:46 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:33 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/11] bridge: add a READ_ONCE() in br_timer_value()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295270-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,blackwall.org:email,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C61F640E2A

br_timer_value() can be called locklessly, the expires field
could be changed concurrently.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_stp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
index e5d453305381baa34225a144ac99e98f2a62d810..83cc9c6a3943508eb94d20ddc1b7e737a58d7abb 100644
--- a/net/bridge/br_stp_timer.c
+++ b/net/bridge/br_stp_timer.c
@@ -160,5 +160,5 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
 unsigned long br_timer_value(const struct timer_list *timer)
 {
 	return timer_pending(timer)
-		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;
+		? jiffies_delta_to_clock_t(READ_ONCE(timer->expires) - jiffies) : 0;
 }
-- 
2.54.0.1032.g2f8565e1d1-goog


