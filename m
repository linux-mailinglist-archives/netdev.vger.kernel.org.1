Return-Path: <netdev+bounces-78474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375987542D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193AF284574
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564312F5AF;
	Thu,  7 Mar 2024 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABQ+23Of"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FE41C65
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828989; cv=none; b=qvgOwQTv+GmcqK36hoPKevChBd5IlxQ0ZHn91YGPDpF37WTocSMEj5io8kKrblpntU5cXiLhWDWBs5Cfc5lclIHsrPwO+5e9dYSzw96+Fhn+FG4fep4SpR4OHEp0NYNj0TGiHwz1hQQTUReKA46LpOZC2bxsvCwwbIMOIwCRAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828989; c=relaxed/simple;
	bh=VvFtvmvQ+2Yu69KqEskLmNL25nZm9yFkAnTplSrfTQ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GVM27JMaH/z33Mty8jOca66QMXdWp/x+Axik6qhpR4BpfKv67ol41e23759+Ijt45dhAyBPdNEKowf77H29onFZDgYQSFlTxY668bYs35NmWbWF3jB7cDFywekZ4lrvClJRZ8pzIH4ZDblUnbUO0YK+Q8mH3itlmnF6f2g6Pp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ABQ+23Of; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ff5727f9so2836087b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709828987; x=1710433787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uTMDWzJGfbta2PLWqidrNFozmi45c2ECaB8niitkyK0=;
        b=ABQ+23OfIZ2Epe6M/I7n6Lrnt+YaMv+r3sSJngvqOyK5zJYzRW8pt57rwiTM6Eg9Lx
         7ug6P/Um7I8A+oUb/zf56rNyASwo/NON3J15TeXPX9W1Nbe3P2PxwLmM+/cBMpAtG4rl
         +RiVAcDusJoJl5UgevClOVuO6QgK+HyNMK8On7TGmHkV57WEbkXKdny7U93sTgsgbdSc
         tjJJJBHi06tAGVZUlAmOxRprej81pAiQaXfhUAPFeyQIYZp7D6VNoZHIHySs33adZVwL
         gRyp9p95jLGiEeciAoBchb7S97pzSBDqBmbmOpAbYORkihzb+zjSXqxtG8Qf8XxYRmpV
         ftmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709828987; x=1710433787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTMDWzJGfbta2PLWqidrNFozmi45c2ECaB8niitkyK0=;
        b=Vf+aKxTFsNbDekM0nhVSpJ+j6t6Q8Ytx+2o/pXw4ky3lDg6jUcdkyZMTNwOI3oLyaq
         OQ2Prvi426v+Vbf03iBCeVkizNCGfY3qRBanwcqzAFTkrnRNe60quNL132nCMC+liJ3v
         lbgZMkg2T/Bh9U4oijlsOnJM2vMvZLcV4SQHwUc6MMhTuZGsNMPYAyPUSnRAorjLzRb2
         rDhrM2Ub99pykItYYyGV2ZTQkzSPZL5ARdUIRArD0RIz0BiTIQU+eeFFVaqv19I8oYVj
         WMYzCnd2pAdtJluSomG3lg5H1y6PYoab2ypjzDS+UDlDUQKdEhl3d+mvrBoXZHZoZ3qA
         A2pw==
X-Forwarded-Encrypted: i=1; AJvYcCVzOm4dIcM3ElGkbn/H2C2urxlKHia82COJtOtqIIivdVI9f1ueL3kblinUd49nenKpzTBHe3ZqqNmi6BbpM73CI/NsvPzG
X-Gm-Message-State: AOJu0Yy964hb1QRux6F71FGgDMHSpBxPQg94xiey5FuibWS5Lr7+ZyTK
	Q0Coiie+4sYwtTFZv6+FWYdDrgsznPLdQOC3BngZLVc+M0ypvoduojjVfvDx3Clv1yJxNhIfDN1
	6yAuG0gqKjQ==
X-Google-Smtp-Source: AGHT+IF9RyIZTkdLLfMyufBIkQUJLg6HK2nz1MGbGxzRMZU5iPbt+accHdbmnRJwu/OX8XebCc0lBu3v3ZzI7Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:441c:0:b0:609:82e7:c0b with SMTP id
 r28-20020a81441c000000b0060982e70c0bmr359344ywa.3.1709828986807; Thu, 07 Mar
 2024 08:29:46 -0800 (PST)
Date: Thu,  7 Mar 2024 16:29:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307162943.2523817-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: raw: check sk->sk_rcvbuf earlier
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no point cloning an skb and having to free the clone
if the receive queue of the raw socket is full.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/raw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 779274055abf99530048ad4738c2263e97c94cce..ca49e6617afaff3fe6c5f3a174bbe6d96f94ac62 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -160,6 +160,13 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 		if (!raw_v6_match(net, sk, nexthdr, daddr, saddr,
 				  inet6_iif(skb), inet6_sdif(skb)))
 			continue;
+
+		if (atomic_read(&sk->sk_rmem_alloc) >=
+		    READ_ONCE(sk->sk_rcvbuf)) {
+			atomic_inc(&sk->sk_drops);
+			continue;
+		}
+
 		delivered = true;
 		switch (nexthdr) {
 		case IPPROTO_ICMPV6:
-- 
2.44.0.278.ge034bb2e1d-goog


