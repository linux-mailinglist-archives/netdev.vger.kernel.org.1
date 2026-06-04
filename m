Return-Path: <netdev+bounces-295273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pwj4F+OLIWqWIgEAu9opvQ
	(envelope-from <netdev+bounces-295273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:29:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05D640E42
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:29:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Ab+eTKcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295273-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295273-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B031B3056DDA
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AB480DD7;
	Thu,  4 Jun 2026 14:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDE220687
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:13:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582435; cv=none; b=prv/z2AxsceW8QPef0C4Mkf9fkY4uk8XT80ntyt8z9/QLfxvbSwCkitIy3I8KS+yw+wxgaLC69K6eSO63cVD1m0MTpcWi0HsFeI/pQnlcUspuew0QSEuYFaYWoclGDVXX+lhVUaUfS+azL/3PeODgDLJFFiO5IrxnC4TkSP+HV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582435; c=relaxed/simple;
	bh=5kiYgtejzVyV+JpDv7e9F60ZAquH7BHpLb7LzbGEqpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GX6YtYV/bdiSTA7cGf0SDeHW+PJofaJ6l9ps+DWUFsdS73AGEEA8K9++liEc2w2ZVizlj0c5ap4lW0nWvPzfC27GGBx0RvVD57XbcYQBbj6TdMKMZZQCBv4OjoOMCc1MhwG1gC4zkV4/s7bysE5uDeAvV3L4W3Lh3Yd7Rgj/KaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ab+eTKcC; arc=none smtp.client-ip=209.85.222.74
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-96396d1f745so765350241.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780582432; x=1781187232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gK7Emg534F4JW6hH1rLMSqCrF6VX1T/6ZiMun2x3Zc8=;
        b=Ab+eTKcCQ6D3kG04oT/3KQqiWJ+YOuj7uICybat+agnR8dz9Gtb8ZmdLIVlO9v+uik
         p1TlqlBHJ6uy9KGuIC+t6CG8sP6NrR0XCFvblmjWUpv6igBoxl8F9CF3Bn5qfS3TIniO
         5sJNV/hfR+eoRLVGrdkI69iLqY3FEH91STZ9XfxnnnIBKEX/IefsTHqW2717PI0PSyMl
         We3fu4DEjnn0XQBosetWbAo3KY1w+jOnnUc0yqrdyWFGe/YUmt0WcIPBW7SHRkh+3QeG
         9KOZtew25+XnZrvY2K6psCG/jiBXmcNb7EwtyI3keDwZP8xdYuV43x7+iO3XT0u2D2mj
         Diuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582432; x=1781187232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gK7Emg534F4JW6hH1rLMSqCrF6VX1T/6ZiMun2x3Zc8=;
        b=Y/RrED97U+hrOKhZqLDC8K5VtxdZbRAFLkZnnFkWWBYWbJyIwgNeku3hIRmB789vcz
         FNU2K7mOYG9pkD8xrqrA4jhEMX+8Lcg0uevw+a9Mbe9TL/8iHaEIM24z/xzNaxBaaQpw
         ESiiYxnl4pqrUxme5Jnn28z7xlJbpSjDYMUYcJuwfFU75egCSzlixi9cKq8WhQ+mO8Jy
         OSbEaX6McN8aqGFTyYRZubs3kz9pOwZxC5Xb3cvdAp2oEuewtrJhPzRdIhANZrjrpmqX
         xEJSEw7ulWUpC+4u/wbiJLgcfWmmredu1iBHm8gwq/o59FpYJBEllCFdT8iJXDV0YfnO
         vHVg==
X-Forwarded-Encrypted: i=1; AFNElJ8EoupL0QR5cS904+/rUM85gA9C//TdqO2r0q7Jji0Q1lut4UF4i0o07RcHXSaXKi1bwmZwtqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKqe5i89TpOmR+G9bIm5vdfymMSA51HS6zgjfixmVV48RYUfQ
	B02VEFkjpSaYV+xrW+LgIOErcQzlHPgjZ3P8zLVr+RsRh2Ap9QkqWpP9OA4aFiZW4hDuaWpfd21
	u3vPAgftUTNMpdw==
X-Received: from qvxr2.prod.google.com ([2002:ad4:5762:0:b0:8ca:264f:a095])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:4684:b0:59e:f988:51e with SMTP id 71dfb90a1353d-5a6e4e347d2mr5417570e0c.5.1780582431402;
 Thu, 04 Jun 2026 07:13:51 -0700 (PDT)
Date: Thu,  4 Jun 2026 14:13:36 +0000
In-Reply-To: <20260604141343.2124500-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604141343.2124500-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604141343.2124500-5-edumazet@google.com>
Subject: [PATCH v3 net-next 04/11] bridge: use BR_ADMIN_COST_BIT
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295273-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,blackwall.org:email,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B05D640E42

Use set_bit() and test_bit() lockless functions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_if.c     | 2 +-
 net/bridge/br_stp_if.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 3169fab686a534cf2a6458ff228eee2b6fc7e7e4..0bd5cf925fa321b785e3578d6e99d8d7003fa89f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -75,7 +75,7 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
 	struct net_device *dev = p->dev;
 	struct net_bridge *br = p->br;
 
-	if (!(p->flags & BR_ADMIN_COST) &&
+	if (!test_bit(BR_ADMIN_COST_BIT, &p->flags) &&
 	    netif_running(dev) && netif_oper_up(dev))
 		p->path_cost = port_cost(dev);
 
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index 28c1d3f7e22f6e0a0edd8b3b3f501ea7acc31394..b29dc97b9ad8a5b5c56517d34fe426abd00e2ad6 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -340,7 +340,7 @@ int br_stp_set_path_cost(struct net_bridge_port *p, unsigned long path_cost)
 	    path_cost > BR_MAX_PATH_COST)
 		return -ERANGE;
 
-	p->flags |= BR_ADMIN_COST;
+	set_bit(BR_ADMIN_COST_BIT, &p->flags);
 	p->path_cost = path_cost;
 	br_configuration_update(p->br);
 	br_port_state_selection(p->br);
-- 
2.54.0.1032.g2f8565e1d1-goog


