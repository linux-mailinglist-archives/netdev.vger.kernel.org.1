Return-Path: <netdev+bounces-153402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262D39F7D91
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B31652CF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFC21C182;
	Thu, 19 Dec 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5VnODcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319841C6C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620617; cv=none; b=GWfTGmpVa5ewe5/HDFC6BI8SKxlNblTItvEILLSxjeKuxlbO5oQ+YI0/6vZ43FQ54HcmcGowxuuZSWt4N0B8uZ89RoSFSKmhHjyAsChuwfaIkkKXJ3qMirqtj+akDjyNgJkG0phPEbeCH7BnueqLruzSDpOT5LevTdNqPWZL5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620617; c=relaxed/simple;
	bh=cjoQbpqNQCMays5FUi0iw5PxYvzF5wG89yCM1N61ZtA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e6dWb3LtY4jODdgfGwMgYS1kPrwAPD0uqxQoBKxTJG6cYbBArDMk3w5pnCV7IcvoAaJkcB90cmOYothlIkiYh3V+L6dykYkrjqN79pXg4sGevjtgFcc5wOg4cI+FxjAstLW3b0Wtxs2RqRxwWza30IVquXPUsw910hsKoC1yAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5VnODcM; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4679aeb21e6so16343591cf.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734620613; x=1735225413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYXQzEmf/Sap1RXFcM8emfzZNVqZoJGBOycpRIPyCOw=;
        b=p5VnODcMOJeukA/Q6svzKYE9wVGviBA07igGM3H+2Nsjo98iE55sgh/uzwOm9TRN34
         Sy6Kl0S/zepTNEYGVJSCMpWjH37teXo4MUvVtITwtlFV4VbEYYm2BMRXc78CuohifICe
         Y8tuSjTNtvNfQp0jBUe1emAkddfFkm5xu7bn7m8W93I2G/7azY1zbji8oQuKgCFA1Sja
         aHO3lEm0xQosU17OxeVrHLTGDlWsmOpukv3cu5SsPg/sFbgg9IwmWABAnfgdNUkeYFXi
         lOBlfzAUC+d7xnnOGQq+rS/4umxJASY9bgnex85l+yLTp12d4zmZ1TUkXLkYrF2XzG+U
         Xs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620613; x=1735225413;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYXQzEmf/Sap1RXFcM8emfzZNVqZoJGBOycpRIPyCOw=;
        b=MdAwATvDOtfAPjopO/HIGuAevoS/M/VN8dcNwSJZeWadirS6jXY2O54/I7/Uo50vKQ
         U0vhTIrnUbSr12hvZFyCLlpn7FflN9vyHXAbcr/mMAIDa1clFKrt1PzvBySntpcVyGji
         Jar7HYh1ihV2tqeJ1cVAa0x9z0vq8o48dX7+3dVP9jR/2DwxxwQBwwveuSsU9q2TvFXm
         f9VWlBqNQ8HV+NdG3O2ALbMjcBMxl6DdqPuGAhMB91XtEiDwc+qarDU4jhfXGMfPLE/x
         AKDayeaedLw88nUQg7UBQA7+lKiBki2DKEx6hgAhM+BY/7TupPTCO7I5UYvdi2RBYIWo
         4Jrg==
X-Gm-Message-State: AOJu0YzhVybfh7Oq7gm3vKWei1VE0NrsvssufDRThTYeVJT0HsqMuB4M
	g3xpD/wlzLfHvnr68vG+s2u0q7BIvSPCmM7IlyhyjUeqsPgj5BwLHA24oO3Uki9V3nzHZLlI96m
	V3rQJwM0dkQ==
X-Google-Smtp-Source: AGHT+IHnqgEoIIgiX4JTK5wL2RCg0Lu0CqwWh/AVDPedROdgWz6lfRtm5BTN7V+tAlRxTverwbDCeJJZRQ/nqw==
X-Received: from qtbfe8.prod.google.com ([2002:a05:622a:4d48:b0:467:7076:37d7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7dd3:0:b0:461:22f0:4f83 with SMTP id d75a77b69052e-46908e7e9bamr99718151cf.43.1734620613416;
 Thu, 19 Dec 2024 07:03:33 -0800 (PST)
Date: Thu, 19 Dec 2024 15:03:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219150330.3159027-1-edumazet@google.com>
Subject: [PATCH net-next] inetpeer: avoid false sharing in inet_peer_xrlim_allow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Under DOS, inet_peer_xrlim_allow() might be called millions
of times per second from different cpus.

Make sure to write over peer->rate_tokens and peer->rate_last
only when really needed.

Note the inherent races of this function are still there,
we do not care of precise ICMP rate limiting.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index e02484f4d22b8ea47cbaeed46c5fb0a7411462a1..b8b23a77ceb4f0f1a3d3adaacea2a7c59a7da3c9 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -246,23 +246,27 @@ void inet_putpeer(struct inet_peer *p)
 #define XRLIM_BURST_FACTOR 6
 bool inet_peer_xrlim_allow(struct inet_peer *peer, int timeout)
 {
-	unsigned long now, token;
+	unsigned long now, token, otoken, delta;
 	bool rc = false;
 
 	if (!peer)
 		return true;
 
-	token = peer->rate_tokens;
+	token = otoken = READ_ONCE(peer->rate_tokens);
 	now = jiffies;
-	token += now - peer->rate_last;
-	peer->rate_last = now;
-	if (token > XRLIM_BURST_FACTOR * timeout)
-		token = XRLIM_BURST_FACTOR * timeout;
+	delta = now - READ_ONCE(peer->rate_last);
+	if (delta) {
+		WRITE_ONCE(peer->rate_last, now);
+		token += delta;
+		if (token > XRLIM_BURST_FACTOR * timeout)
+			token = XRLIM_BURST_FACTOR * timeout;
+	}
 	if (token >= timeout) {
 		token -= timeout;
 		rc = true;
 	}
-	peer->rate_tokens = token;
+	if (token != otoken)
+		WRITE_ONCE(peer->rate_tokens, token);
 	return rc;
 }
 EXPORT_SYMBOL(inet_peer_xrlim_allow);
-- 
2.47.1.613.gc27f4b7a9f-goog


