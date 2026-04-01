Return-Path: <netdev+bounces-273899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMpXEKi2zGnMVwYAu9opvQ
	(envelope-from <netdev+bounces-273899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:09:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B389C375104
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40D830CB55C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC3D33A6E1;
	Wed,  1 Apr 2026 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2VbRUg0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DFF3101CD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023549; cv=none; b=YMF4jsiIMOaNOIBEP0N5dpCuS5rgu/YJyLuJSFOS4ujCbrQZLlsIJfn9zNWjMzdr8avmjR4KVcJ3uwdXN7IiT9qNHO2nqV3OW3A/XvO/lvJSaw4fVTtqaoZ3uS4VV8m/c0JzttsT+/s5no+kNtN4p44D1tXa9qU7gByulo1HpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023549; c=relaxed/simple;
	bh=YS3YiatLBj7qZwctFvA+P73cI4VV70CVdOZYZZPriYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iqueMnaScYuGkMoa0HP/nqOkjvWfJLo/Vw1yv8pBr+7VUMQrK6GYpSMF8lgYBUK+8ylpgWm9oURCzii4tPeUyO/xrdUfG/yefq+8ev0mRRr4LYSzxf/rJmqRCvfYT6z6QFYPGrNA2iXLC2rzNY/K/sc2WJx+KTtI+eAVzaoHV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2VbRUg0; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marcharvey.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so5915694eec.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775023545; x=1775628345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA8gFrLqFTd0mUoJLyKqA0q3Ee0rtvXH48v8ujy7q5g=;
        b=U2VbRUg0sINu9P+I0+pGKCbPIWm3dn1KcrN4wu99zyihNj/UhmQNT3kK1pRpN0b2m2
         J7RQJ0I4oA6fXtyVuDNa/NQ2kpQad/HfIXRYYjatOy9Sy2PeSvnYnpHH4Z7XhM5DGBW+
         EOJH4j68URMOlq0Eqkt/IRi2s/WAdLaIy0Vrl/wJgwOA5PyLWylOcOMnwh71wCsE/E1k
         DRgsBq6NDW6dOfFCnMaj/3AEqOwgB0KHQNd9aGcIcBvPQQU1wn7yLkVnv1sZb8VilwA3
         uaeXBtEMKLU2H+2xYqpq5cl5eQ+vW4XJre/nTAkBhOtfe/ACKeCPKq08qhuf9xDjSd7h
         tOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023545; x=1775628345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA8gFrLqFTd0mUoJLyKqA0q3Ee0rtvXH48v8ujy7q5g=;
        b=Rh32uG5QN+CRNXhFWPfKjE7dGyB6BEA4rEr5Se4nw4bXDbvtM+BAgKAElm7nBTT7E4
         Mt0CVYudGw9VNnqSoiBZ0nRw7AnDpXhmmsBc+L0D8MfgQ8pn6g+NB66A+l/7PV1TM8Hb
         qP+tvVt4opkyLwA9q/ZLZOSWDgV/EbrFmJo90lymGWyqv3t5yVHTtsgN1Ad79xa4DMWC
         ucmk/ur24HP+q9SeCA2YQjwf+7KkuMqrvgzQeNf58wD5WlPq/PDXuO2PNM9cDVXHByKM
         QmaQ/G9gxPIv4lTj26OOsVpiW8dZNqw6gnJ3XgzgKJTrVtzzz9KXGB3PyYg5SlLlvT8B
         lX8A==
X-Gm-Message-State: AOJu0YyJXEPittUAai47rPDWtyTgeITnu3J+kwFf7P3foJfrHYCnyc88
	GHaMDC4G3V8C9OhMp/GG9Pz+09vC4WxacGp44ZqFk5KzqRK4z77cL72eFNG3CMnjE/jvNzbe1CN
	Dz3ukeVislyFXZ9YqeZ1ZAQ==
X-Received: from dybbp18.prod.google.com ([2002:a05:7300:a892:b0:2c8:7753:33ac])
 (user=marcharvey job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:80cb:b0:2c7:2c0b:f33f with SMTP id 5a478bee46e88-2c9325b0162mr1371078eec.21.1775023544546;
 Tue, 31 Mar 2026 23:05:44 -0700 (PDT)
Date: Wed, 01 Apr 2026 06:05:27 +0000
In-Reply-To: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401-teaming-driver-internal-v2-0-f80c1291727b@google.com>
X-Developer-Key: i=marcharvey@google.com; a=ed25519; pk=OzOeciadbfF5Bug/4/hyEAwfrruSY4tn0Q0LocyYUL0=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775023538; l=2533;
 i=marcharvey@google.com; s=20260401; h=from:subject:message-id;
 bh=YS3YiatLBj7qZwctFvA+P73cI4VV70CVdOZYZZPriYs=; b=CbIq+Ggm9PWPjSCVHiBf4TlPgoy7zSsGtrHeaWJ1Xtuiw0yEyFjDVqJzUY4UA3VG6x8C1Tu9N
 dGuLh4TZbQMAUKGvK9wVExy2ZjxaNXaim0VUFnfxcQMJ//GvcDdZHUm
X-Mailer: b4 0.14.3
Message-ID: <20260401-teaming-driver-internal-v2-3-f80c1291727b@google.com>
Subject: [PATCH net-next v2 3/7] net: team: Rename port_disabled team mode op
 to port_tx_disabled
From: Marc Harvey <marcharvey@google.com>
To: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Marc Harvey <marcharvey@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273899-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B389C375104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This team mode op is only used by the load balance mode, and it only
uses it in the tx path.

Signed-off-by: Marc Harvey <marcharvey@google.com>
---
Changes in v2:
- None
---
 drivers/net/team/team_core.c             | 4 ++--
 drivers/net/team/team_mode_loadbalance.c | 4 ++--
 include/linux/if_team.h                  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index e54bd21bd068..2ce31999c99f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -968,8 +968,8 @@ static void team_port_disable(struct team *team,
 {
 	if (!team_port_enabled(port))
 		return;
-	if (team->ops.port_disabled)
-		team->ops.port_disabled(team, port);
+	if (team->ops.port_tx_disabled)
+		team->ops.port_tx_disabled(team, port);
 	hlist_del_rcu(&port->hlist);
 	__reconstruct_port_hlist(team, port->index);
 	WRITE_ONCE(port->index, -1);
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 684954c2a8de..840f409d250b 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -655,7 +655,7 @@ static void lb_port_leave(struct team *team, struct team_port *port)
 	free_percpu(lb_port_priv->pcpu_stats);
 }
 
-static void lb_port_disabled(struct team *team, struct team_port *port)
+static void lb_port_tx_disabled(struct team *team, struct team_port *port)
 {
 	lb_tx_hash_to_port_mapping_null_port(team, port);
 }
@@ -665,7 +665,7 @@ static const struct team_mode_ops lb_mode_ops = {
 	.exit			= lb_exit,
 	.port_enter		= lb_port_enter,
 	.port_leave		= lb_port_leave,
-	.port_disabled		= lb_port_disabled,
+	.port_tx_disabled	= lb_port_tx_disabled,
 	.receive		= lb_receive,
 	.transmit		= lb_transmit,
 };
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index a761f5282bcf..740cb3100dfc 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -121,7 +121,7 @@ struct team_mode_ops {
 	int (*port_enter)(struct team *team, struct team_port *port);
 	void (*port_leave)(struct team *team, struct team_port *port);
 	void (*port_change_dev_addr)(struct team *team, struct team_port *port);
-	void (*port_disabled)(struct team *team, struct team_port *port);
+	void (*port_tx_disabled)(struct team *team, struct team_port *port);
 };
 
 extern int team_modeop_port_enter(struct team *team, struct team_port *port);

-- 
2.53.0.1118.gaef5881109-goog


