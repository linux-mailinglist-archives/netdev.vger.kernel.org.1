Return-Path: <netdev+bounces-126924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD397310B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D972855D1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FBE190068;
	Tue, 10 Sep 2024 10:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3C191F88;
	Tue, 10 Sep 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962665; cv=none; b=EhJaUjCD98KWiBktMH802Mw3buZJtDZE+xZbdI1p3sKgroJnwDOgBRGbw0rVKca515bqFF/LRnDP9FfMC0jVTltmqzCS5J5SUtM6KlZ7NqbZF5mT/GTADml5WBgVHCfiN8D01FKXEXbLrXNZpdscSQEUWMBsz7L2X7YJlXS2BV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962665; c=relaxed/simple;
	bh=pRaK3Ku3IkQXoZTZoJ3KsKO2/UXaI4WyWbGGP/VRtPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCl39/kv0lXk/ShVTaP3r0fiyhrHtlvo+1C+yPxTaYiUt8n+Bha55JRxLKLD+ApsmxPMm3JA/8c7GWFWQuwmjZsOT/D9UuvxtCNRXfzdng1Ve5uXmFkCW1eaArlznQuKcL57zoF4d7hpYyZEVyELxEu9Ak5ZltVfq7UXVbpXU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53567b4c3f4so478103e87.2;
        Tue, 10 Sep 2024 03:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962662; x=1726567462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEjz2XP772fB6v2V8zpQRQxhqoxNSwh9E/XJx/MNIPQ=;
        b=VTBILaNE3Z6ileZNj3+lWH/q4Evx9U8MB2j991PHVK+fCdKNHD+/NDRIzBIGwuqHAn
         KaFZ0vVW17sgN6QAzANnN/emvojBSMlcL7iPpeGLCcKDKbnBGeABOQND2R+rMp4/6SmO
         vSXV3yO41hEkATA01J6GiGFQWT5dBUxb8nUbIbP0EQOvh0Le4BJ74vuhe2Zq83lOGPR0
         o6m0ZYt1vWC+rE0h3dNw03z7GTbF0kAsRILxEXcuymga5JB7aoCFIqB+cgQxr2dRtnhK
         siW/ADrluhkeHfOpOGIaGIyCEOrkXURdJw9SO45a2FXx3i3983sIcbY+my747LbvqO/i
         022g==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ptgb/NZjxXx4Ua6svnEfRlQRBN2LoKZBcsECtDn7oFwTJTpSixN99xsvxmyqaICS+IMyN5X7Y06OX2M=@vger.kernel.org, AJvYcCXeNnoJ2ZbX0V+/QlR1j+d6q5XYwDKWfabFoADSZEBPGA19E8mIjCbBpU1Jmezyf93mwNzAKIMN@vger.kernel.org
X-Gm-Message-State: AOJu0YyxaB4RSXdPcDPVWY6K72NWTDYiCFms52TURpiMIdt/RsJV3fYr
	tIhYSWwksxJHwzdyZvTq+r6ng870wWEdSulW81Llm+8wD1g+aTNC
X-Google-Smtp-Source: AGHT+IE3ZKxexYx7/n/qTN1mtxrmEimDS+7YnBn8vip6x6vR0UHx41KzroI4bn/PfVHaxvzecZ3wVg==
X-Received: by 2002:a05:6512:114b:b0:536:55cc:9641 with SMTP id 2adb3069b0e04-536587aa77cmr9607708e87.16.1725962661279;
        Tue, 10 Sep 2024 03:04:21 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf4a45sm455770366b.180.2024.09.10.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 03:04:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v3 01/10] net: netconsole: remove msg_ready variable
Date: Tue, 10 Sep 2024 03:03:56 -0700
Message-ID: <20240910100410.2690012-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240910100410.2690012-1-leitao@debian.org>
References: <20240910100410.2690012-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable msg_ready is useless, since it does not represent anything. Get
rid of it, using buf directly instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01cf33fa7503..03150e513cb2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1075,7 +1075,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
-	const char *msg_ready = msg;
 	const char *release;
 	int release_len = 0;
 	int userdata_len = 0;
@@ -1105,8 +1104,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     MAX_PRINT_CHUNK - msg_len,
 					     "%s", userdata);
 
-		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp(&nt->np, buf, msg_len);
 		return;
 	}
 
-- 
2.43.5


