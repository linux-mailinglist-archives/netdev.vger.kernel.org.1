Return-Path: <netdev+bounces-227651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB00BB4D70
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E5189E826
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF2273803;
	Thu,  2 Oct 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQSeBeVC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DC272E63
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428408; cv=none; b=FBDh7zo0uh1D/BzVbUlv0TEvz+liEEVgoe3d9ld/q5dgZCgB1YQfdCU9TLGrsE3DV2puj2NP01rvQqttyb7u15cOjZTYZnnF05aMSq8XvlmewJk/qODmw21jwHNwKfecBzx012kcw3p8rYQqXMWytjBMCgzgC4eRfRXglgCJDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428408; c=relaxed/simple;
	bh=0TvBx+bBoyxxks6of1f+mQcu0jvRrKaAXsF7UrPsagw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PnbiwyvbmTUCBm5WQMQf8VeBpoLxh8gTO4J6mA6/0jiSgV6WnbgVs8+c1LnfEWGKSpO3DKpQeeiu0KGlde9TjweDxpbDb4R/aAdJzmbM+ANxkd7agxcMKLbhecGPxni3o0SXuXHRcPD8xDBHygZC9mQeHW3slvTIBm5t442GluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQSeBeVC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781010ff051so1046638b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759428406; x=1760033206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NaRlW9cRulPCQvMjfuOQg+XDpvDBCH22Dz56ia8tBLk=;
        b=MQSeBeVCQPEpQDmmZdCVyxTaZbD++Oiavks7RXVcU0gpxgWjXoI+l/Cg3pvhQTwjKD
         3INUtH+CHlf38nLbMW4iXU2407I0paJfsGwgoHyJs01wIsGh1cMEAaDOSmIT4jbK92q1
         H9lX4BtXO+FmSBUUtmDTkmJD3pcRTSC+yI/Re3i3CskzyYCzjn6hjzMiEMM8fsTXaYV1
         qrEO/iXQJ+RKI2J6ZID7EcjpRKW+u3BZouHlcgJomE7pEEgoYfphgaDnqRwdsMDhhprt
         p02wW1lkEmZY5QzMc5sqPrWLnvYNAPxzR6BjaN/7CbTRiz0h34hWjqxQSW7GuLPi2gpP
         OwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428406; x=1760033206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NaRlW9cRulPCQvMjfuOQg+XDpvDBCH22Dz56ia8tBLk=;
        b=gt/+au3w4LL0jay5NXPtwU8mUFtAgdNPDSlD6nHjIPkjKulwD7CIlSK9k0z2MMKeag
         k3LP9I4/uldPaDtPHBLjVr+tq6nY77DP+UCwtTVVMC3IJIC+8zcsP5IC2aE6ONui+e8C
         3PIBkYr1XMO25teJcjjxtWphHWcOqHShGCDqvHykHyDHcsZdoZvs20oA2kkDHmY2D1Q3
         Uceh8RdICEpH6vB1rK91hrdtplDpXIBZPqoqo0Sp5qs6OcUb4Oz42RHnyWRR4kRPDcIG
         ZoW+DnsJ6f4tXy4e1ffE3muZgXEeahYqRbqV/BYAQfEE/zwIJFpJKI86tW+bkWqqjdOs
         Qccw==
X-Gm-Message-State: AOJu0YyZKFLQemsX8hxgSOZd2L70FWgIQiSHA3LwK4NDnzIBqnY5gFA9
	z6Yhi8uEnWjRJuVRMxTHcPbhvqBpSVp+C3nysdaEcn96VsEI27fvE+h7/WBQDbWd
X-Gm-Gg: ASbGnct1EMtLkX8vEP2q4ZVIX4V+gu3BIexuNRedLsvoB5m4wDOswEDZ6kp0WM7M7dW
	XpM+l1Lu8ytNaP/9rPWn/3AZI8PYzG2lWNwHfJT00S88HJgVR3gql9+l8YEEkUHIgPezn+mkpO4
	hE1Jqw30/9tk+1IjXePwQK/yDEIrK+hPXF6MLySC/X2Z6TBNTt3OVXk1wZOSGQz/qWhwrpEcw77
	guhXMdJEw1KvhC7OriNpQ6LPL+KCAyjIXZrnkwyFNk/z5NWP+rZiwymfpzTMkdXVWrkeTnDqSYf
	DlhxEzQxB8FSolo73QATwn8mTCkPjoVm4Lld+EZRwdQ7aMlGrecBfYV2fdb4+IMtA7mH47q+FuM
	51zfFusAOwNmjOni4sOwBHbjiby9VI7b09bVPT9DyVOjYdLxNUrdqibSdlljnPqBwNg4z4JxiJy
	DCBHh+qKh9/HvYi+Ts/pUFTg3cSFMBWJ0G/98Y8uNRf5pDj8agkw==
X-Google-Smtp-Source: AGHT+IHbfrpRJoegzbMifEbArQe0pmEL/MKe7nEOBYzWsJyc2a7fn7nnLBoWsEfmGWDetHChWeFyqw==
X-Received: by 2002:a05:6a00:14d3:b0:781:16de:cc1a with SMTP id d2e1a72fcca58-78c98cf1261mr679991b3a.32.1759428406466;
        Thu, 02 Oct 2025 11:06:46 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm2728075b3a.37.2025.10.02.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:06:45 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: khc@pm.waw.pl,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in ppp_cp_event logging
Date: Thu,  2 Oct 2025 18:05:41 +0000
Message-Id: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes warnings observed during compilation with -Wformat-overflow:

drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
  342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduce local variable `pname` and fallback to "unknown" if proto_name(pid)
returns NULL.

Fixes: 262858079afd ("Add linux-next specific files for 20250926")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/net/wan/hdlc_ppp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
index 7496a2e9a282..f3b3fa8d46fd 100644
--- a/drivers/net/wan/hdlc_ppp.c
+++ b/drivers/net/wan/hdlc_ppp.c
@@ -339,7 +339,9 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
 		ppp_tx_cp(dev, pid, CP_CODE_REJ, ++ppp->seq, len, data);
 
 	if (old_state != OPENED && proto->state == OPENED) {
-		netdev_info(dev, "%s up\n", proto_name(pid));
+		const char *pname = proto_name(pid);
+
+		netdev_info(dev, "%s up\n", pname ? pname : "unknown");
 		if (pid == PID_LCP) {
 			netif_dormant_off(dev);
 			ppp_cp_event(dev, PID_IPCP, START, 0, 0, 0, NULL);
@@ -350,7 +352,9 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
 		}
 	}
 	if (old_state == OPENED && proto->state != OPENED) {
-		netdev_info(dev, "%s down\n", proto_name(pid));
+		const char *pname = proto_name(pid);
+
+		netdev_info(dev, "%s down\n", pname ? pname : "unknown");
 		if (pid == PID_LCP) {
 			netif_dormant_on(dev);
 			ppp_cp_event(dev, PID_IPCP, STOP, 0, 0, 0, NULL);
-- 
2.34.1


