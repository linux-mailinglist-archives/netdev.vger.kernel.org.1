Return-Path: <netdev+bounces-127823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98576976BB9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482E41F23260
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FA21AED23;
	Thu, 12 Sep 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxF7j5eM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DE188A01;
	Thu, 12 Sep 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150488; cv=none; b=maT+ZSI/MRN6Z7pmcwUgE8gwuqwilA3bJdUdH0Xp0kIMhkE+GL55+K8FeGtrLcTnEFDBPPUl03OZctmgfblCq7DZFngE6jBEo7yuvveZxzuJKPDBtmII/1cTWTQE8PlalJgejaJGHto3qC2F/CVp8hTtuFNiCcHDKXtJXXZZmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150488; c=relaxed/simple;
	bh=N/8v03rBrpEgHqb+PXOydlfeoaazZNe9MY9sOeCvP6M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FzSq9EvqbcwpvwNPA0anMSD1ywy4dkANIZq8yHd4VSrw383qEWWpT/7jdV8GhJlYuU34ibaZIE+aOhwLdBVD4tbAI+E3uZUYOBih7vtPc5yfheKrALwBuGl3O7DltvC229Sqq8M5LVfU6WGxHCysnRUM/ZmPX9bWdv1dqhUIsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxF7j5eM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb806623eso9005755e9.2;
        Thu, 12 Sep 2024 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726150484; x=1726755284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g714x2KPyDdUULb7WdPERfWkw9Cpc1SnJyjrBIWDKVY=;
        b=VxF7j5eMNYAeGiY0QfwF9f+e9rYlgcIHDZR6RKv35eHJ7RREO9sADDgDQn5qxKDcAx
         8z/hk9dkNQGmMHFqF/hBs0iS/5pizBBojH/5YDLs2y81xistQUDgqj7K9lxRpiKbheSD
         Ga5duaUdBk9XrJP6xWHOYD1zpRuUfHSFlGtSZC7nQxhtEziq2EWZln3quQjHqQSGyZzr
         Dkf2idhqqoKAnRRifc2Pah9MCwaJH0SChB8ssqrVXcaqIKGxqa8I8qiGKna6hTc0yHSR
         A3g48Ir2M9yAhiFW7+HFsMq+496tJO7vb7BSDOyZIKkENMPC8sNbCFG/hKhBoi/mxbaM
         O0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150484; x=1726755284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g714x2KPyDdUULb7WdPERfWkw9Cpc1SnJyjrBIWDKVY=;
        b=rIOMBW3OIa7ldtBtTWLCwqVBy4vXkY+NiR81Xd9V9RyurDxU7gLHa5jdkRI+rhhwN4
         ja6oDgBEdk5liMY6io8mrfy1RJ5FpGuiLqGQBIQ0EH0HvtoDuGdXALwRQQbHNO0Wn2sG
         W3LF3wNobBV2hrvf8+GZOZrVi4R7jLCsGj4Ppu3ICMGQ26CNCV9olGoo5p8WKO2uSOwD
         V9oGSXeEfEbG/lWs/KWw0agdK5IB76nV1Ck3yS+p3qPI5IbsOnJ5LBphadRBa5VtMf2j
         fX15o1h2R7sa02pdQVv+MHKdv4Yjx+JYd0vZwSJbIzPBYvdiBH7l/c1aBgu9VROpFlHK
         YNaw==
X-Forwarded-Encrypted: i=1; AJvYcCUsXVTILddJOr7NXiWT0fG5Y2l3PPnuPk+YQjEumj2Au380J5bj6X5/mZwQc+MNsTs+vg7dGzYT@vger.kernel.org, AJvYcCXhreXq78A/fTRYIDMMPoB9S1+n3b6sxns8nulJwIbDF2UIRMSI6an1g0hiyloomwW5HIsDHfkOtRNeWUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/S0qeD17115cQvcVbKJD1vDRXFXZ8/ANw6eifIDYXqxTnZgM+
	v7J8HYcWX/RlZnhIqTpHArcYxyR8vZqmKS/DTHrsCohex1hdmiIz
X-Google-Smtp-Source: AGHT+IGkh/I4jLC8F1W7DHi3pewlNhPDdyiR06lI0MufFjfNvYiL/lSsmteSIJ2MDt446X/fOq4SPQ==
X-Received: by 2002:a5d:4811:0:b0:374:c08c:1046 with SMTP id ffacd0b85a97d-378c2d0650emr1692383f8f.20.1726150483926;
        Thu, 12 Sep 2024 07:14:43 -0700 (PDT)
Received: from ubuntu.localdomain ([46.121.16.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb45c81sm176654735e9.28.2024.09.12.07.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:14:43 -0700 (PDT)
From: Guy Avraham <guyavrah1986@gmail.com>
To: guyavrah1986@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net:ipv4:ip_route_input_slow: Change behaviour of routing decision when IP router alert option is present
Date: Thu, 12 Sep 2024 17:14:40 +0300
Message-Id: <20240912141440.314005-1-guyavrah1986@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an IP packet with the IP router alert (RFC 2113) field arrives
to some host who is not the destination of that packet (i.e - non of
its interfaces is the address in the destination IP address field of that
packet) and, for whatever reason, it does not have a route to this
destination address, it drops this packet during the "routing decision"
flow even though it should potentially pass it to the relevant
application(s) that are interested in this packet's content - which happens
in the "forwarding decision" flow. The suggested fix changes this behaviour
by setting the ip_forward as the next "step" in the flow of the packet,
just before it (previously was) is dropped, so that later the ip_forward,
as usual, will pass it on to its relevant recipient (socket), by
invoking the ip_call_ra_chain.

Signed-off-by: Guy Avraham <guyavrah1986@gmail.com>
---
The fix was tested and verified on Linux hosts that act as routers in which
there are kerenls 3.10 and 5.2. The verification was done by simulating
a scenario in which an RSVP (RFC 2205) Path message (that has the IP
router alert option set) arrives to a transit RSVP node, and this host
passes on the RSVP Path message to the relevant socket (of the RSVP
deamon) even though upon arrival of this packet it does NOT have route
to the destination IP address of the IP packet (that encapsulates the
RSVP Path message).

 net/ipv4/route.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 13c0f1d455f3..7c416eca84f8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2360,8 +2360,12 @@ out:	return err;
 
 	RT_CACHE_STAT_INC(in_slow_tot);
 	if (res->type == RTN_UNREACHABLE) {
-		rth->dst.input= ip_error;
-		rth->dst.error= -err;
+		if (IPCB(skb)->opt.router_alert)
+			rth->dst.input = ip_forward;
+		else
+			rth->dst.input = ip_error;
+
+		rth->dst.error = -err;
 		rth->rt_flags	&= ~RTCF_LOCAL;
 	}
 
-- 
2.25.1


