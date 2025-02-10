Return-Path: <netdev+bounces-164595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0242A2E66A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20051884616
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4947E1C07FE;
	Mon, 10 Feb 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POW0EQUO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10491BFE03
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176092; cv=none; b=aZlq3wrj3t8pSg+AEI0iQJsiRrhjjLpl3FIMUvCLewT+hvVSYJZlPMbRRdRk5cN0kGtLILgh13g6R4p4a09a/9cC8cnyQ0LXOP33DAz7nZ4J7rb5zPFXVS+j5O4aKi94sUF/D5LUFRWgwcMN5fpjOWx2SoxmRfLz0Bt3LkQKO+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176092; c=relaxed/simple;
	bh=ayfR++ZeFX/AUSDvHtw2VYyUWBaMOEdjxs/NlJb58PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3bV7W/qGqBdfaPtQgOqzomFUghTGfHPwnwTvOhwVopGBenkWrpKIl0hd2Zch7A2y1IIigVxqamUEhLfsY85FPp9gvTv6rBcyv8MWxG35sSFkRVurzh3yK4PDppv7EWrQPi4L/Ie84zyJgVq0hk8A+C5OgDJs+0heFCmeg7Dv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POW0EQUO; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-47191977c21so20258851cf.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739176089; x=1739780889; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OB0pFMHBGPIqfhxLFFeOsSG9n4Qav98e6VUkoeWr3EY=;
        b=POW0EQUO45Ohor0l3rLFOHciTNyhGYoO2N1MoosrJDWVI8BbzfXqdcJ4++UL3awMSP
         Xn2CxW/m1zMzLCOAylSpwTr8lklOkt9hoMsH9Ifjvb8SWRGD2XI0trSnAWeB1Xwk5WXA
         ykeVJgjpK+j1+2Ly7OmaQ2MHFXlMel1NWET85qicqqKqRapk17NnNn2WKiRuCEG7vUlA
         4sA2qM/v/Hzk2EgdACAMVchHyUPGQ4LQQwlITRz//aqs0CdyGixUsRfqydlhBbx7Rfsm
         8DqHTZkqOnrRs1VNWLpDbRnrFuRcSLpIdzbivXHR8zBBQNh6pmLo2JFYdgF8CEBhsT/t
         0sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176089; x=1739780889;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB0pFMHBGPIqfhxLFFeOsSG9n4Qav98e6VUkoeWr3EY=;
        b=hAIP39YzihvkxaSYVeF1HiAlntCe3Iu7P8KHMopmc6Wtb69e5S1XKaKpJQFVkMjkb2
         MoG8NZnKFuNt9lOhn/uPDxBH2cDAlVjmy7auiKPiqjguXWOXJ4CZToly9UkY4OtT1r3M
         kzsANTj3KDICERgPkPeX1MH/xXUmEr3AYpX7BYadsJ8OxYoKDvrn22QrubsY+vt1oysy
         zH93S7j455nuzu2rDPqPK/LTAjkFKhmH3WPNYuHcTFTijA8iLX2IOzMmOTxlzTBfmoqz
         xA1EiPKRyjfj4OT5v+rGvq3n10fnmgdhc7ouS9CORccYsfrpLIOH/dlsC73ywT+VbBkq
         scmA==
X-Gm-Message-State: AOJu0Yy+pCLDUwimiaFM1UiwmNc15fF4krUKgA763wQcH/+Qz0cu3GRC
	3V6aK1/8zUxfWCohLyP+kW9BEYu/lKnYXGeOM4iCVO6jGsZjEcjPNjEcqV2g6gCqlh2KpOIaWlr
	HSX8u54GHFw==
X-Google-Smtp-Source: AGHT+IEJ8IIeDpsLzhGUrzpQDywm6z/tNKnhIdEbiSWu83LMzmE/D81QuKmL4KX3y8Zh/XBwMQuE0e55vMtVuA==
X-Received: from qtbeo9.prod.google.com ([2002:a05:622a:5449:b0:46c:7332:f1bd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:24d:b0:467:7208:8ee8 with SMTP id d75a77b69052e-47167ada385mr171625121cf.31.1739176089663;
 Mon, 10 Feb 2025 00:28:09 -0800 (PST)
Date: Mon, 10 Feb 2025 08:28:03 +0000
In-Reply-To: <20250210082805.465241-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210082805.465241-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] inetpeer: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EXPORT_IPV6_MOD[_GPL]() for symbols that do not need to
to be exported unless CONFIG_IPV6=m

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index b8b23a77ceb4f0f1a3d3adaacea2a7c59a7da3c9..7b1e0a2d6906673316ec4bef777e359ac175dbf8 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -60,7 +60,7 @@ void inet_peer_base_init(struct inet_peer_base *bp)
 	seqlock_init(&bp->lock);
 	bp->total = 0;
 }
-EXPORT_SYMBOL_GPL(inet_peer_base_init);
+EXPORT_IPV6_MOD_GPL(inet_peer_base_init);
 
 #define PEER_MAX_GC 32
 
@@ -218,7 +218,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 	return p;
 }
-EXPORT_SYMBOL_GPL(inet_getpeer);
+EXPORT_IPV6_MOD_GPL(inet_getpeer);
 
 void inet_putpeer(struct inet_peer *p)
 {
@@ -269,7 +269,7 @@ bool inet_peer_xrlim_allow(struct inet_peer *peer, int timeout)
 		WRITE_ONCE(peer->rate_tokens, token);
 	return rc;
 }
-EXPORT_SYMBOL(inet_peer_xrlim_allow);
+EXPORT_IPV6_MOD(inet_peer_xrlim_allow);
 
 void inetpeer_invalidate_tree(struct inet_peer_base *base)
 {
@@ -286,4 +286,4 @@ void inetpeer_invalidate_tree(struct inet_peer_base *base)
 
 	base->total = 0;
 }
-EXPORT_SYMBOL(inetpeer_invalidate_tree);
+EXPORT_IPV6_MOD(inetpeer_invalidate_tree);
-- 
2.48.1.502.g6dc24dfdaf-goog


