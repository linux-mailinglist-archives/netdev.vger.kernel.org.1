Return-Path: <netdev+bounces-300233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qmnqLGf2Mmpe8AUAu9opvQ
	(envelope-from <netdev+bounces-300233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:32:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760169C2D7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:32:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=chfhepGi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300233-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300233-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE53D31444F7
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8937998C;
	Wed, 17 Jun 2026 19:32:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264B35E95E
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 19:32:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724761; cv=none; b=qQkEnvnK2AEKOIvC1tj/04RWiEIRmVxqM9W7iZfNXcy19pjNnEJoES43X/IcfFcSKfQ9klweOYVtjUqx0D3Y9pKjItJPHmYwqvnTtWnAz+N4akQdtekODqwPZuB3lH3Qi0nnP//2qio1fFsoSOQtZ033FDEyW0BSZElGugi50l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724761; c=relaxed/simple;
	bh=nKRdkhzwzEm90owcL3p24QS4bGL3H7hAHBUqc1YKGsQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qOsPWSjL6gNb7fpG25sqz7WY62KSylpAQ/GHNKgwAUvrXAj4tgncggQOxrOgxLcPe1MYW9YDrVr4sBHx8BO1SUjrochiWqQeHe79vpc5UKaa9DmbJT2HJBHVIE3UfETfF+z4aoffw7OWnQDUjY8s8667RN4vwDhxceaLLSlqQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chfhepGi; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c168baac83so837505ad.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781724760; x=1782329560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6f2LzXtdnvpe92q5bjdHaZ0Bfv9oZUQy+JVLYIcGw0=;
        b=chfhepGi30Pd7Jub8CFLqMVa00S+Y5vdhYnOZocNkGzAhGVSaOfZBqyJrqRmmX39av
         4jlF4dWOaUW2BSX/DZRUzwKD15qdqQqTKBcMb6KwggS9+YHM6QbZ4Ed4fscEkdcxUamg
         xlAKL+PPCVgJxCa2OHjsT7Up2j9+4At4luALDZPf8+7oX9swTjUH0T0XlcCsT9arT2vb
         oBh1wxpa8r+anaipJ6D3mn85sZwJV8/LT61ok6PDlx3wupW7KaILM1Xxd4x4zalVAkJq
         Wpu+YB7o3uC0vZAcWHHLLOfCy0BN9kduDRBeFvQySuc1eY0Pck8YyN1qpJGzkzusEgoZ
         mhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724760; x=1782329560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6f2LzXtdnvpe92q5bjdHaZ0Bfv9oZUQy+JVLYIcGw0=;
        b=h8XAL5tqM2hWNLZbHxxwuctqnKMkT/MqaC41XbKhTPX6feyl2F+aQAbVfNIVqU8i4N
         OtkP/7Ph77jv5AMgT8G0vvDPrkaukwDgSgxnqDxnvvx4duGQjqsMzkbZTkE5bPNb48Ms
         CqAsKwDnFltlvnm4PThDnVCbWmxs3PgHEKL0lGZMwqiwtp2kbbsIX2+GphJyz+2/y/FV
         dxsfsZjYbMrabyA9DFSBZR+rkxMXrl/vzylq4cxU7iGa+ARmGv7J2/aDPkL0qKu//ajP
         d12jZJFHbjbhVQYFnez3GlAER8niMH+7PlWEPMvwi78qGwTdgRIB9WQY8s+6bsbwu7dk
         6aIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+ERUql8GD6TwequVcSuX76MNmX2PjyLCGJzWEQI4nsrdvlnyYPHQXRJHTf3XOU3PN9nZkM/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdklREZSawO5nL2cpD0p4PbpIp/rtvav8GA0roCYgTW6tK39+u
	h5+rN/GFDlY1KPNZLI7nXPhtl97MRrSAtn8ix0LXxFmN+IqlqdvmL/vu
X-Gm-Gg: AfdE7cl9bbH8L1V1qtq/EkLbxIXuGlR+hdcbTpVdKJ91pNu3CjxV++3VnsSKKxKJ4IG
	5/vNlXupCRQYP4NVSEdt6b7Y1ZMnyaMtf/9CyoQ3wjC0p5dEmoFlugjWNXdhrDfnkeRoZbQjlpS
	XrRkampPx1o4SURxez3TvsPpxfa/KQTYT5nTwsu28LwYyRfpmrKah1MQzmF607VjT5KMmm1fjXp
	W+8cwRumMHv5Nzk+By9y9p5WTid74OY/AlQYH3voz+Lnj1OHRQN48gSxNzlLi9SwHnm0AlBpBPS
	R+TmJjJIZsPsLk1eE8wwXq9xNPCdscafe5VcxjhqqXOfkhYn1QCw/DLExoqXYQL5LIFH2qqBHTd
	FFsYRUg34VCUYXYepVisr+ORMtcQ3sSYTEyjrwK7zky+MNOjppzyTA+xAVMcICwYiCeeuv3vkJG
	zccMpXh7AwKPujJaTSLcivB0RX5dQfnwZq
X-Received: by 2002:a17:903:2b0f:b0:2c6:6424:c79f with SMTP id d9443c01a7336-2c6bbf98e47mr55775115ad.8.1781724755407;
        Wed, 17 Jun 2026 12:32:35 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432f77479sm173007915ad.63.2026.06.17.12.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:32:35 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Taras Chornyi <taras.chornyi@plvision.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
	Yevhen Orlov <yevhen.orlov@plvision.eu>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: marvell: prestera: initialize err in prestera_port_sfp_bind
Date: Thu, 18 Jun 2026 03:32:28 +0800
Message-ID: <20260617193228.1653582-1-ruoyuw560@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:taras.chornyi@plvision.eu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:oleksandr.mazur@plvision.eu,m:yevhen.orlov@plvision.eu,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300233-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2760169C2D7

prestera_port_sfp_bind() returns err after walking the ports node. If no
child node matches the port's front-panel id, err is never assigned.

Initialize err to 0 because absence of a matching optional port device
tree node is not an error. In that case no phylink is created and port
creation should continue with port->phy_link left NULL. Errors from
malformed matched nodes and phylink_create() still propagate.

Fixes: 52323ef75414 ("net: marvell: prestera: add phylink support")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Add net tree target to the subject.
- Explain why the no-match path returns 0 instead of -ENODEV.

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

