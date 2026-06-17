Return-Path: <netdev+bounces-300228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xuzQKOXlMmqm6wUAu9opvQ
	(envelope-from <netdev+bounces-300228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:22:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0969BED9
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 20:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OuarVTV3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300228-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8506C300E150
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF4A31E823;
	Wed, 17 Jun 2026 18:22:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730833263A
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 18:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781720542; cv=none; b=Kvw8rFn5wlLe7U/F6HA9hLRVRV0Z/NQomzc7Rk/WhCzSrokcOxz2FrRKmfFTNEp7eUDbMOOG1X0D/NAp48QTUzNe/f9RUaXQfwUQgIYO39TMzyhSngIh3zQufYSfrbSUz04McncxcERQFQgazd88blT8/gaF9ydWn1FqWcfZZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781720542; c=relaxed/simple;
	bh=7u7EzRuUYvbMZj8ZaGRw0TrDTGp/q+KebVWIUaH9cxs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=vEgUGbPZ80B4UQkyY0iG18JVXWgnKMtUKtwEwiyhQNsUdoDC59lKYC4Oo3//ocyry68E5NZkRHD9AH43SqGccPXw7T4NZLOT8wUG+YgBYgkkvSPd+N90jRxHAleZVJHcfZD4KyYxRtCZjqe1wHkmt5/oGrsES/QjcP9+H5O9tf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuarVTV3; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bcc877b4cso245694eec.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781720540; x=1782325340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgCzcqH4IWNrKDybpVLEd1w34Hk1jlKkTZczYza9DXM=;
        b=OuarVTV30uLnql0rNoZlL18biRvNZn6ytn+q7R0Ym+al2xAG8Rw78nzzMmcrPEv9ao
         oWNoQPqTlvuZCpOJJL8irWe2u8YpdQvvwI6elVv9veacFoaxNWPKBqJ28YcX+bZCd6bj
         Em9jgu1pEEFABJ+YcwFR+peiNN0bvaDs7BK4xFHxBPykcsc+j0C5ICm28uo2FIqOG0v1
         C9i9/9BN9ffgWktWsUEL/aNHhvMolbgppqv/XGrGoPxeYZyWlaP9Fg0slMR3p1XQPT69
         125qbC9v1pbC/BxqK/ud0AcPL9osEfzyK2uVtNQXS7R4IaOBF+fHZPKft/Zre5ydFfEG
         K1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781720540; x=1782325340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgCzcqH4IWNrKDybpVLEd1w34Hk1jlKkTZczYza9DXM=;
        b=WKlAPLko7SubZR4HMD6Edr0L5ZGZqwiKt3E/EdFh9LpIRXLG5PR6V0lDvxwMKzWGF+
         jOwACjq/ttEsklGquuiqdJSXW/bCFcHMdGDjwIGNstyMqFqKRuj4yJR8OTBK11zDhwtd
         oUQFDQj5iUi9OEc+ySTWrEm89HgrZa3i+Gn9sQ0ZZRJaOk+L2e3Yk/4fi4m809+Xwavf
         VD6jPblYiYsuE9KXmjjmi8HXHRjuOXBjMt0XFit+m75CcZPqcbnnXjIJ9b15OksqxQgE
         gpZ0YLKqDq/0rlrIu3JoVEAn0EHzhS8pFzyCMcKxKrcl7n4BJTlP/cUqOO96Hn9sXPdO
         0rAA==
X-Forwarded-Encrypted: i=1; AFNElJ9aWN4MH2dVpuDsXNXaON/smRmXX2hvvFIQln04ZQrShS1UdJ8qVuWvr9CNI6wpYhcik6+vMAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDYAgEmAiP8Ld7gWf6zVtYNoj8Y+661rgj/qb4Sg2V2ty2D68
	z3+y7c87PrPuClVkRNkvoAIzNuKX6T1vTZ8UQMVpntGYAYETxBVa9Vy6
X-Gm-Gg: AfdE7ckPEya6BhJZDzt6HtOgyqyUqwodFok92zaQUez7wAthbVY7Ebxv6wAVvGBaT1e
	0lZCe6feccIa3MEF5Pv9UdigC7LzhYKk5BpOt7P6CUQMFMfpRAx3sFGMyg5Y0qEnK6E5M3O3OQf
	4L2oEIKfv/fChGAHC3M9WqzZZg8JQn7uSjd3MNDeJtpUXSGlVCrGStSP8GENYObeNBmHaUk2Vaa
	/y/+vYLdWkArH/gOs+/P/J9LcOzQb7r1QyZjNAsUEvPIpHhYWZbaoB/v8mmW8dslUtEzVE068Cz
	sot8ihQ4rsgnZLPHAQBLvjyVYOBJM0XK41jd249jrVCgXNj9LkVzeSK4LjBq3WKPV9iAshu6Lpv
	PH+raUQsNJ19GhfNGkilaqo0b7kDdgo1xjwJN5Lta6MkOqSGcQ0j2QXVWYXTHgUzB7tqZ20agDu
	MG1Ki+6zRPoIm4jh/FlsLZaETD4xk+v255
X-Received: by 2002:a05:7300:230f:b0:2c5:b23e:48a6 with SMTP id 5a478bee46e88-30bf099f8c6mr30944eec.23.1781720540523;
        Wed, 17 Jun 2026 11:22:20 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm24724030eec.0.2026.06.17.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:22:20 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Taras Chornyi <taras.chornyi@plvision.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: prestera: initialize err in prestera_port_sfp_bind
Date: Thu, 18 Jun 2026 02:22:14 +0800
Message-ID: <20260617182214.963694-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:taras.chornyi@plvision.eu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300228-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DC0969BED9

prestera_port_sfp_bind() returns err after walking the ports node. If no
child node matches the port's front-panel id, err is never assigned.
Initialize it to 0 so the no-match path does not return stack data.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 41e19e9ad28d4..a82e7a8029851 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -373,7 +373,7 @@ static int prestera_port_sfp_bind(struct prestera_port *port)
 	struct device_node *ports, *node;
 	struct fwnode_handle *fwnode;
 	struct phylink *phy_link;
-	int err;
+	int err = 0;
 
 	if (!sw->np)
 		return 0;
-- 
2.51.0


