Return-Path: <netdev+bounces-301542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GLw6HDtNO2pKVwgAu9opvQ
	(envelope-from <netdev+bounces-301542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DDC6BB127
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 05:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PbLZAZ2G;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301542-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E57130309BC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 03:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328C3090C5;
	Wed, 24 Jun 2026 03:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB4308F26
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 03:21:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271287; cv=none; b=SONS0/FiV5Ua/9b31iRojkbU7pvdgDuYUzZe4PHGfSptdHpTH4O2Q4NVGsA4VzFexxpVpEQE1BcLeSya/HBvmJNuV+Xb5ygdvfs505W64BE05anVCKZAUVu/V+pf+l1s+kAZBCLLCYvQu3wiooVEUI9GrGbuzImKD7L4TwQIGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271287; c=relaxed/simple;
	bh=LHPuQ3fYoRkUuqJpWAlUR2uR31JNU+MYzy+B2oliw98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBr1p4b0KLj0MTR+vbsc0GfzIXgyx03b088zruOdzX8nU41XtVul0babYZB0nkXbU9XWWbS7XxefAVYgEghS1COcDZ3bg1ZsM33jgkGNZmeV8r/DHr4zCtNatsLE1398Mxbhu1ANhF0F11S7jf92f7EtzkZYpMGUU3GfLSsF4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbLZAZ2G; arc=none smtp.client-ip=209.85.215.180
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c88973b6965so913953a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782271285; x=1782876085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4+6IeyaZHLRzdbwK5J3iMdZMMkHItrfJDK1pzm0fPU=;
        b=PbLZAZ2GEhh/m/LmkMn/sEh6Nw/P7foHWOjq4vjdUp7XQinF5w6uP5PAPvuZTlEPAH
         ZhPV5ffE2/5pHMlkpFBw5SlZfdaxcbe4b7SMk1+n+0HPUMMPtCK2IKlATRhLXfE78Jzi
         +XOAixwddfcmTpcx5qCqjpoaUvP/kFD4Kh8ONH0dPGEgC6eoVOduN7PlwYRIeTuWD/wq
         ySXV/A5WKIfgPSVrkdA018H7HbqTFz7UY5E5UJW52S7FNFLkJ4A64+kWoTC1igm2+VdS
         O/M9vn5Bp9XuDrr2KQKSSIc+P+0zVreZhDcx8DiB0+qJcRCMZczuXF0GMVPX7IyTPZyJ
         YZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782271285; x=1782876085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4+6IeyaZHLRzdbwK5J3iMdZMMkHItrfJDK1pzm0fPU=;
        b=pVY1NFkFwnntiA+Yu/VXKch8Eo+2TIKuKVZj1Az6t9EKzVN676YvBvM+9wop/+mSs4
         eknCKEZBLkap48sI39ID+WQVolTQbl5+7wAG0bHh7FCYTZg+5vk90/7S/+oBVCUESI2l
         401AINFn6tLshDsWpNk6v9u9TEqFG2JMW6crsZH6UYALipagtT+v0ospsn3okek4zcyy
         foT6tVmtYhGnoiEwZdX0vQz6DO1H+MKuIUs90oSzAc8Qx10mMgZGq8HPANDx2YC9ohI0
         CIboSeXnV86I7Hvv9/m6FhjKZlcmK9oxLJshyEccAmS30CU+bLzg6ShJMBtXYCr3cWTe
         yUQA==
X-Gm-Message-State: AOJu0YzmC5z871UsssUolJfcNFlBCeBycwE2icFguPsrOU/q8d0D984W
	FhBC40k9iHt3IYn/qv6iSdaOUnNNr3R6XezsS0mU02JHH7PXmzmXYPq1hd7g+g==
X-Gm-Gg: AfdE7cm6QhyPp4AkvhKMch+x4Q8nh/Th57iitoQ1daRrTqPG/9ZLnHr7erx3xqqYWhp
	q9xL1nk03s/beCyI5nugRQuRhQj9YXB4K2Efc6u6jZivoapEeoOte29Qjp81h3D+jiCa2iWAegv
	VL9IP02r4hJycpb8MwVgUVdufCsrg7g1udp2NEhZ+u644luII260B8xuteIUDRMs6BrngpTeEJ2
	LEglpxeMbEMbgqrJ9vohCZatdmaCeSVFyO5jVF62I0SvxRY0+TEAgfnQp0cXQJH3mLuF/Z9zX8x
	UV9CdyzVf794jEFdLOK3UcZHMDab04C8L0NDdvOqUtwbtvKGdAlKwxWHCjILg0FW7Cd8HLiG+JO
	EFAeE54HFs5iK8ZKLjA/srJ3SrN3HIGHoKClM97J1i6zQV6/zJvZ4+Hytnif16NFtFbc1BboZWa
	0bjakwVLl6OUfBMxht2vw6760HK73MBKOjlCigdnOFiuZYs8RpgINz5wPnpWdVKI6XjH53H4W9h
	r4YfR4g0Q==
X-Received: by 2002:a17:903:90d:b0:2c1:41f8:7ef5 with SMTP id d9443c01a7336-2c7c3ff85b9mr53445235ad.22.1782271284992;
        Tue, 23 Jun 2026 20:21:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:5b5d::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad78sm140624075ad.81.2026.06.23.20.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:21:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Fleming <afleming@freescale.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: gianfar: use of_irq_get()
Date: Tue, 23 Jun 2026 20:21:22 -0700
Message-ID: <20260624032122.986986-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:claudiu.manoil@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:afleming@freescale.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301542-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9DDC6BB127

of_irq_get() differs from irq_of_parse_and_map() in that the latter
requires calling irq_dispose_mapping() when done, which is missing in the
driver. Meaning it leaks memory.

No need to map it anyway. Just need the value stored in the irq field.

Changed irq to an int as required by the of_irq_get API as it supports
-EPROBE_DEFER.

Fixes: b31a1d8b4151 ("gianfar: Convert gianfar to an of_platform_driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 12 ++++++------
 drivers/net/ethernet/freescale/gianfar.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3271de5844f8..17a0d0787ed2 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -514,15 +514,15 @@ static int gfar_parse_group(struct device_node *np,
 	if (!grp->regs)
 		return -ENOMEM;
 
-	gfar_irq(grp, TX)->irq = irq_of_parse_and_map(np, 0);
+	gfar_irq(grp, TX)->irq = of_irq_get(np, 0);
 
 	/* If we aren't the FEC we have multiple interrupts */
 	if (model && strcasecmp(model, "FEC")) {
-		gfar_irq(grp, RX)->irq = irq_of_parse_and_map(np, 1);
-		gfar_irq(grp, ER)->irq = irq_of_parse_and_map(np, 2);
-		if (!gfar_irq(grp, TX)->irq ||
-		    !gfar_irq(grp, RX)->irq ||
-		    !gfar_irq(grp, ER)->irq)
+		gfar_irq(grp, RX)->irq = of_irq_get(np, 1);
+		gfar_irq(grp, ER)->irq = of_irq_get(np, 2);
+		if (gfar_irq(grp, TX)->irq < 0 ||
+		    gfar_irq(grp, RX)->irq < 0 ||
+		    gfar_irq(grp, ER)->irq < 0)
 			return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/freescale/gianfar.h b/drivers/net/ethernet/freescale/gianfar.h
index 68b59d3202e3..c6f1c0b6229e 100644
--- a/drivers/net/ethernet/freescale/gianfar.h
+++ b/drivers/net/ethernet/freescale/gianfar.h
@@ -1074,7 +1074,7 @@ enum gfar_irqinfo_id {
 };
 
 struct gfar_irqinfo {
-	unsigned int irq;
+	int irq;
 	char name[GFAR_INT_NAME_MAX];
 };
 
-- 
2.54.0


