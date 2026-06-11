Return-Path: <netdev+bounces-297972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N3zbFS5fKmpHoQMAu9opvQ
	(envelope-from <netdev+bounces-297972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C35ED66F413
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:09:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qPceCMOM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297972-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297972-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 233F1301443B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BE341068;
	Thu, 11 Jun 2026 07:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B623264D4
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:09:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161769; cv=none; b=VjvkGP2djdMePLF30nhaPeIW/dhlftAbXxxq+tO6IX+jcm6lcNUYBWYvqUw57Sv0V4uE40pXlyn6NsoHxM09OU8WkioxBeisEKb6Em+wdB2aTtyD/JggqgNryT1u/yP66kfOohLuRTNg4ur8LDjmOeWo3IHUne3fDJTmv4QX+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161769; c=relaxed/simple;
	bh=kfg69es+mtd/qa78TUvJo94JhOhlvo4gcYGq3wpJG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+sIXf0zHuutzfz2q9Nc6nPAmte1Aw+lIzKEkXZ0LIH2C52F8qi6PJ+h5JB4MLyX3x62oLpVxJXamQI1x66vbHb+/oGLoKLnr9a27H5Q5FFn12dyhOpi/cIhc58U2gTwSxnWws5f22x57oSiBVRiYmQowqOC/e/wPOD/37F89e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPceCMOM; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36da8439078so6651125a91.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161767; x=1781766567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb32EB9wjODrFYN/xY/R7ZmZaAJDYCQuqcYaSE9811Y=;
        b=qPceCMOMcOoS7+qSpYw55R9jUYk5mlagkLSnJc1x+VS4f8qi/P4AVdPGL5CXr9RBgz
         517NOCoJHkHgVKDJo4P9bomA3T+QsPaft0kCSMhUfDiy6gDXTfj76fo8RmqQtIhNwmGX
         gk3+GwNMYHIq7IOS164FKJ+rZs6Ibgo8dZ5A+u4xZJQNl0wyPr62191Vw8poqNjZaxyd
         wNLluJ4rzo+gXShJS09bej+BjY5xZMJ+wfM9ZWNkWeCwSVvN1m3as2PyYSdyHJFs6gMb
         FfEMX9tFB2C7C2T/Pee3oWHTJLCju3UFW6BxxOBFiv7FiNm6KDbjN/xIkqLmPFQ/cupq
         o8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161767; x=1781766567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xb32EB9wjODrFYN/xY/R7ZmZaAJDYCQuqcYaSE9811Y=;
        b=d3qowEr/quRqRoOKjY8vIcLO5/e3lsnUT4xp1ZkBOMtmLj6kxGWp2Mo/HzG6rIIqvQ
         9KFu/GWzMsTJj2IX54rVaiGiYsl/bi9oZ+nB34uvpk+MlLnCJCz2r4TcTIWpvhc7gtMx
         njeHQ2vkRDR8mhObiSO/uSZmTuZPm56UGQgEbpL25sKzdrJwDU4ECHUqo+P4EsOqO7QA
         ngB1NhPROZMDBcEIg61/IJK6QTuJUBRs5tasDMKbsqBlBjjLskEA/4G/5+QhYQqTv6nc
         G2s11UUu2R2YihqDvqDADXQbqFhOphj3OowSFckVuO891R2+Nam5KivGQGDATrpVwaKR
         /8Ag==
X-Gm-Message-State: AOJu0Yyat5RQ6Cb56uHGrcwnN7cKDK8ngoC8QQmrdmKRSpeEzSnj9oUr
	SWoEsbrCUz0hiNM97w64fhJBEYcaaEQfUBfXsAAwK2YM8MkyhMF91cRL0Kee51Ye
X-Gm-Gg: Acq92OGL9w2azr0NBCgLV0x3Bu3pPzXQCgzGmqhYJgXhIpTn4ZFfw7nXZZrC2zDvHIz
	TRbBHNrIOrVp1Rke8NeyfEVq36t2/I9ZIX/hrTJnZEyJ8kQThxgZUn3a/6bYOwB063Aoj5hDJP6
	Sd5AomPjl7cXqKuPkbg6NbCD5wakpKgQQOf/j2QmOG2kcTRFXOYrBSTvwo3ep8y6xh2GUHczxKu
	4S6bZJNLLXIGOydLelJjHMDkuOVtQGcnpXmMOXO7nlYVcvUFdJgyCc+P23r9Qikcsmf/0+3Ok8B
	bv4vsp0SVH+Whg4/GFL6MM2WIODmwbOMUJlKWMCJVP29DJpBiaIFp/+133tEhVHlj5K5dUkg65p
	ziy50+pl6n2e6B8agpEUQFksdgm6ppsgQ3Oxc1mypsWVmnuOINj6e52nIfSewsRp7mpduDf0w58
	mJVkF3x8WG1bP5IQTM7R1GK2SXXC44o/k+gTYyD85jqXwUam4zMupOfSipD54/
X-Received: by 2002:a17:90b:3f48:b0:367:cb53:7435 with SMTP id 98e67ed59e1d1-377abda15cdmr1847081a91.24.1781161766709;
        Thu, 11 Jun 2026 00:09:26 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3046::4cf:39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2d9bb2199sm18818975ad.77.2026.06.11.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:09:26 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/5] net: dsa: dsa_loop: avoid devlink resource IDs collision with PARENT_TOP
Date: Thu, 11 Jun 2026 15:08:47 +0800
Message-ID: <20260611070856.889700-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
References: <20260611070856.889700-1-mmyangfl@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297972-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,resnulli.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kurt@linutronix.de,m:jiri@resnulli.us,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jonasgorski@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C35ED66F413

This might not cause real problems, but the dsa_loop devlink resource ID
collides with the sentinel DEVLINK_RESOURCE_ID_PARENT_TOP (0). Avoid it
by keeping the real resource IDs starting at 1.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 7058faf23592..0e35e9841b9b 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -75,6 +75,7 @@ static struct phy_device *phydevs[PHY_MAX_ADDR];
 static struct mdio_device *switch_mdiodev;
 
 enum dsa_loop_devlink_resource_id {
+	DSA_LOOP_DEVLINK_PARAM_ID_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
 	DSA_LOOP_DEVLINK_PARAM_ID_VTU,
 };
 
-- 
2.53.0


