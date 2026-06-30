Return-Path: <netdev+bounces-302885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8TTQCTEhQ2o8RgoAu9opvQ
	(envelope-from <netdev+bounces-302885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D22C6DFA7C
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:51:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sNtJEcuA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302885-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92578300FB62
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D32E7F2C;
	Tue, 30 Jun 2026 01:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961F280A20
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 01:51:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784301; cv=none; b=S1B6VmpLyzd336lGiDLoJbIJDtuQ3RRFeLQ+i8bzXE40/F9CIwYYCPxmEgmunqIN4Zmowug2/TT9nrxQ2INRkM52W8tZNY6aQTL7/HsXsHTAOOZJzIEowtrPSzC4o+yUeaIiH44tfBkgGvNT6EI87RteJIohj8uMxmzJTr6S+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784301; c=relaxed/simple;
	bh=Nro2/uRBsIACU9/5NnGZIEwc9X7Jc+IgR2TzT+jC3nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdkCgtzGUjBAtb+aRSEnWg1ejAQho6IVFiwEgA+b1g9Exfmed06EYpqHU4+nl3eHLwcXQ43P6NOd6+Fkvp490LZ5BeM+v2wThzj5+52o61faNFsl0rYw+FMce3KX8PwFnIPP0Mo++8fMUa0zKchSeeEv5W/aZobjESlKv1K1b8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNtJEcuA; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9b42be8feso22279145ad.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782784299; x=1783389099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcnmiNNJkaSC+0FL1vKeL8WK6R7XjC63mBxVeUEUy60=;
        b=sNtJEcuAo4vyDPmPWDVmqmy4aA/mf0835cQ300ea8RRmtMnD2utWG1KdCeF3ItJFSd
         MFg7rTZCS6+dWnl3X9g5vmbFpAbpnQLfCIP5KR0NvvH+OQI34KKEZ8JC7IUDLUDP3omh
         +Xo8O/rxHu5ApM/xnLMD6gBtB6hj3qKgVXn4L833duowVWSst7VBXZtZABbkxv9k47yd
         2jSO1OJZ/MB4sLlW8yqWHuTMtwl40GyClglHEGwaMnB/E7hvFvr2a/zthSyGEA2PMT69
         pbjjGthuIekwrzMFWa2zSuGEmSb27mFc83NHV9eVucxFypL83i2pMrUcTX6pfBn1dw7b
         xVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782784299; x=1783389099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcnmiNNJkaSC+0FL1vKeL8WK6R7XjC63mBxVeUEUy60=;
        b=RK9zKrJZp+9otKcgyzHid9004xdlcBGaGvcijILv1NH401DIbBBLA5q16NT/iMafyl
         j0lFNSVgc8txgGZDtywDEqPTw4peByVtVRBcmcSyJXbqO+ST2GAVLcyQjURNVOc/RjvG
         nXeUy2EzeoD46L7cnwfbJeMLOL3VcEd+JVqxqq1K5qwgQV59XwmEZgp9NNBagP+/Ba6I
         RJyG6cAxWrX60tDnKkYxXKMFObnKdmlcdu9kGD8rEXbJcJof294sc0jze4u4DCpktSLW
         oMOFXyaCeo96nE4X8NzGMeeRLwuVAqbckdVjnAnOp5D4oTKpHDejNcGnC6SI03Iq/8QR
         h4vQ==
X-Gm-Message-State: AOJu0YzR6lG39Btp20bVcXlEQCg8yxRkwlSjuEGNlW/IyHxNfE1m23gd
	u+qygSbf7V062W6aAvteq57RaOKXaFraJVw/1NaWoiQ2Lv5AawZ7HaDGsH073fA8
X-Gm-Gg: AfdE7ckuzG/De3URVmsTJQrgYqiTqP7nH/xzlGjiYT3phCqgE9NRv92/tfsNMY0RO+d
	SPuWvVYZMFalTYNVK3BA38zQInMWVFCj3uiu7N9ugrE6QNNbIv+YpexeoLZjMlcX0N/E0VllyKn
	ZRsS9cECneKPY07dJLO4p5bydjaYRwXNFPm5uG2utpLb7GmbFbvQpjKPyTu90++REYSIbD2D2xz
	E4i2JB2ce8aj97MyWRoHCWk7ByrQHCZXHC3P/4svEWkAtxdo39sK1BVnFh1pfgmMxUnx3fbhR8Z
	UbUhA67qwNVzdkwwpdTLLZ7p6orXR+GtitmF3JVhh/awN6yE5PYWur5ExMWseiiSSuph7D0eiJI
	i1aL9k6i7SokDZH5RAC4WM0Si7d1IopTyHrIhqPCLVYxaZjxYrOCFZcizvNuNWceXlgixE2CpaE
	pxQHbzeaz2y/GAem17KnQ+g/1MSO5yFZ3IsNWgftLAefuvgg1wokWPjeGzNS/Jxw/SazhG4KD9t
	cRpZ3JbGg==
X-Received: by 2002:a17:903:4688:b0:2c9:97a8:8c19 with SMTP id d9443c01a7336-2ca2eb3214fmr12356575ad.44.1782784299209;
        Mon, 29 Jun 2026 18:51:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca3828b10csm2672685ad.40.2026.06.29.18.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:51:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: dsa: qca8k: fall back to ethernet-ports node name for LEDs
Date: Mon, 29 Jun 2026 18:51:37 -0700
Message-ID: <20260630015137.1591152-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302885-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D22C6DFA7C

The device tree binding allows both "ports" and "ethernet-ports" as
the container node name.  Try "ethernet-ports" when "ports" is absent
so that newer DTBs with the preferred name work.

This matches the handling already present in qca8k-8xxx.c

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: resend
 drivers/net/dsa/qca/qca8k-leds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index ef496e345a4e..0ada28377f46 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -457,6 +457,9 @@ qca8k_setup_led_ctrl(struct qca8k_priv *priv)
 	int ret;

 	ports = device_get_named_child_node(priv->dev, "ports");
+	if (!ports)
+		ports = device_get_named_child_node(priv->dev, "ethernet-ports");
+
 	if (!ports) {
 		dev_info(priv->dev, "No ports node specified in device tree!");
 		return 0;
--
2.54.0


