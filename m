Return-Path: <netdev+bounces-93732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883A8BCFD2
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B347285796
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847113CFA5;
	Mon,  6 May 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sbS98IdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D613CF96
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004910; cv=none; b=EMX4SwYsYFphtfO2o04HfYSUYk9sWvOkrBs30c2rORL4eMmbUz0QFw2YaiujPYHfte7VqeElbLIOkDWRwNf95It2d9uXb8Vr61JYZ2Ud3UHXYbdLJaqjIxHqy2Yog7v4ufQ5GgZ2blc/ABx3HClZ0gvLAUNr6NDTC304b6aR/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004910; c=relaxed/simple;
	bh=wcidanXZQTb3aE8biUO7m9uGWdjY9fC00+u5PTnfNfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9pyZvt2FZtIDk7w4Kd0y1LPJFQleZL9UUFIm/L2hZN6TC63CiTD+ASavhi6lk/ezrZoislL5ZfvwPeIG4CMGX9tnQ6o6HUsH0Yacrut2MRWSs/muz0J2T9DdH7JCjvxDvCmuZ5ES8pHzJ1bTQ2Rgi7Z99ex9Qx9Euq6rpVRsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sbS98IdI; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A5EC13FE5D
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715004899;
	bh=ZyaYKGnkDPnTk6rgEgUZ2eoc97Zq0+zWClbbP5jrG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=sbS98IdIhDA+HiWrxDk4PBqJ1yqfWEhdL/hqFkB2gB8VyALk0zS67Baoc1wdNMQ/p
	 BJrF9HQbJ1EXhSCnZhVo5lVeRnQoX2Gd+J0hmEujKMTnnSeLK6DFXlGUwh/aa03Z/R
	 wmud69y0C5nXU1j1aEfmMWvlJ8JFQuE+uDnvICcD90n2ijfc/Nhty3fw4U33oJKpSE
	 OlQFBfqXOWCatShRe/+VEHZjIdXWKCmZQlfwk5OxzPc59vGYdFcAoTgWhzJCkbQ2RM
	 i/km//BR3NIhUYVzyPIV6kffl647s6CNx8mWCNOq2ysoMzBUj1J/u4q0JVxJufi/V0
	 isbPSMhcvRX2w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a59a17f35c8so123114966b.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004894; x=1715609694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyaYKGnkDPnTk6rgEgUZ2eoc97Zq0+zWClbbP5jrG5Y=;
        b=Oxg6KXknH7V7b2H7ePhrfWV1765wchwBs7kc9WS/a3o6VjU+dCwWU3p0Dyuh/fIqWf
         w2ZNv59gK0avUoGb9GBZKsJFx2L/hPqJIw5caLA+lfs1xNQHUpk84HHop0TmSKDIpT6c
         z5jwnw3rrRTVQ0Qwz4aEb4pnk08JKZ7dQr9vQkWkWOTa5dvUKJJU+rEJbvpTtpVGtrXY
         h/ccduYmDwB625sOa7NfXLJyHHnauyJ8sL5YhwV6xW5OpVbOvOd3leEskErb7HacBZMM
         cBPcCQdAfgEQb8RxdccUTRbCLOeWbMqU74l+fj40hdFhVr8AgncCbHbEfar2DTPgaRNy
         vSFg==
X-Gm-Message-State: AOJu0YymepZDETFGZYVizEoHwoGiwGZyPRFwDPTEt6QNc97b03rUZ3kL
	1mlaVLxiOzPlkcpe1NgGJUirpV8EOQ8QJqfwPE0QtX2PAKhtyImZX8umIZ8ndYkgpTsMAfYZofK
	I3BCBG8xrUQaK1Cn+Wz+0L6wYgr/IXi/uLijyKMukFxyePyJTjIc90xTZkEJONhBuHCz3jw==
X-Received: by 2002:a17:906:4899:b0:a59:bfd3:2b27 with SMTP id v25-20020a170906489900b00a59bfd32b27mr2701622ejq.70.1715004894084;
        Mon, 06 May 2024 07:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk/9m6RYfEf0M6hlNPk6/CFatHUn4Rb6d03W4Hp+pLLGOwdF9b9V1H4mNBZdkFpbMX/boBAw==
X-Received: by 2002:a17:906:4899:b0:a59:bfd3:2b27 with SMTP id v25-20020a170906489900b00a59bfd32b27mr2701599ejq.70.1715004893754;
        Mon, 06 May 2024 07:14:53 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:4703:a034:4f89:f1de])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b00a597ff2fc0dsm4663754ejb.69.2024.05.06.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:14:53 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v4 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
Date: Mon,  6 May 2024 16:14:43 +0200
Message-Id: <20240506141444.145946-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 50b5dbe40eb8..e122fa367b81 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -94,6 +94,7 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 {
 	struct sysinfo i;
 	int availmem;
+	int amemthresh;
 	int nomem;
 	int to_change = -1;
 
@@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 	/* si_swapinfo(&i); */
 	/* availmem = availmem - (i.totalswap - i.freeswap); */
 
-	nomem = (availmem < ipvs->sysctl_amemthresh);
+	amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
+	nomem = (availmem < amemthresh);
 
 	local_bh_disable();
 
@@ -145,9 +147,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		break;
 	case 1:
 		if (nomem) {
-			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
+			ipvs->drop_rate = ipvs->drop_counter;
 			ipvs->sysctl_drop_packet = 2;
 		} else {
 			ipvs->drop_rate = 0;
@@ -155,9 +156,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		break;
 	case 2:
 		if (nomem) {
-			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
+			ipvs->drop_rate = ipvs->drop_counter;
 		} else {
 			ipvs->drop_rate = 0;
 			ipvs->sysctl_drop_packet = 1;
-- 
2.34.1


