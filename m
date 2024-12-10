Return-Path: <netdev+bounces-150804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA049EB961
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6BE1886D44
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26892046AB;
	Tue, 10 Dec 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDc1hGkb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF101C232B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855639; cv=none; b=GndZQ6+TYp0x/Kd4d5uoV4atZWUDk5/RgxjAMcbyHKAxLbuTZ2gfQiO74W+3Q5qfHC+yUzLHdfDMaxA6M/eOI1Fawt7K1NsHh+KfAe5hlakfgkQ+NjShOYl/kxZlt/GAYy1YgWEbul/UVPnmgLllIr7oQg3W02Htap0xlruhmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855639; c=relaxed/simple;
	bh=RvbrZKsSMdwuC8yNMk1/dKa/VT9CcogRcvHUC/ypim4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I+XLHcn8dWaJ31/BEnejzjYeiQ5p98lBpajXCGJXMtn7YKdLzqBSzemXpua/bjmotrHoty2XIn3dOksmydMs9M9mu4EcVtyH8eIVGBzOdJasLLSF1PC9FQ35RMj6KA1AtM9U9jWcrCuIE0GzSXZ7BJrIM0qo9FlGIell0Pp5bq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDc1hGkb; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e1b0373bso102761585a.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733855637; x=1734460437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyUk0ShoQ8cIWbbRD2VRgpEJQN3ZI8TQuneBjLIYmSM=;
        b=cDc1hGkbJWI/F8dnRmQB0Dpwi95PrZpktDIT2L9K6MVsWjSD2omHA9V1VMjivFDJLC
         6xGDnBOVoptBmUKMTuG7QXq8fgIuuH9B74ktR5cTYpK6D6n0TP971bcQpyF7tndhAvDa
         1WuB/zU3qgX6FIOez+0mm8nCOh5juBAmXD5KDoXZPeWdrBpaS0lqPG7qWsrbKVuvyynn
         Z18aLXSI2fXROGyUMKizN5iCuyWXcWsKRdo6pPsaBF/b1P7qxELir1j4QHYFO10KNiLH
         ZckmGyUZURYn6xDenBYoIn7AQIiDQxR2prat3Jy5NrTDsTe/n2NvImqv3e+jvE4OaHkm
         wBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855637; x=1734460437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyUk0ShoQ8cIWbbRD2VRgpEJQN3ZI8TQuneBjLIYmSM=;
        b=w/KH7TvdMzIuyZTtxlHKYxsG1OQkXfpD5o+SKZvLpGcZR3dOGGezgK6eO0wuOhGswg
         aNYBIu+7cpczp5uGuRBxrcrNw2Fc6tkuB1s65ZwtF+YcbUxDGd0Uca/8sYU/IJFHPZgK
         HQ+82OKsyYK+XMXSiAV3PiL/WANUcPVrPudPDSso1++EcqWYUmooF6falUHI3QQTU1wQ
         t+9gYDwhue4eIUgyZ5Nbl+Mn14XPEACqKNHG+WmZhDWatgZh/miwLDCJGrmFF5O3A9k/
         ibXKwePlP0PI/wMQQQ8+RFDSoZSipiMzyOCxsAyGF+qDwXejHumzrKmEr20K0v+uB3k+
         Du3A==
X-Gm-Message-State: AOJu0YzyYgLkRXjVRSSP9tqPSzIH7unC6m7gTk8OFJ0n+/hr2zlqJwO0
	lJK4lXH8W7r9mMSU1zzAYT5Yk14/tLgvekHvF+Bsl6OGDkNaSy7Vq7CLd3IyNwR4jXPYZ793GAm
	14hejtpjZDA==
X-Google-Smtp-Source: AGHT+IH6sM9NwjwzLaXxwjox1CoKRL3dIvleBSUcJkG1icw6RjvxUhg+6HuyoSJiJqXe9mg1W/aVXjq+OvTAjg==
X-Received: from qvbqv11.prod.google.com ([2002:a05:6214:478b:b0:6d9:122d:a689])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6508:b0:7b1:ae6c:fc60 with SMTP id af79cd13be357-7b6eb4200bfmr25791285a.8.1733855636968;
 Tue, 10 Dec 2024 10:33:56 -0800 (PST)
Date: Tue, 10 Dec 2024 18:33:51 +0000
In-Reply-To: <20241210183352.86530-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210183352.86530-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210183352.86530-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] ipv6: mcast: annotate data-races around mc->mca_sfcount[MCAST_EXCLUDE]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

mc->mca_sfcount[MCAST_EXCLUDE] is read locklessly from
ipv6_chk_mcast_addr().

Add READ_ONCE() and WRITE_ONCE() annotations accordingly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/mcast.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index afe707b6841d1ce84f11cc588200615b504a591d..09622142b0705bd81491f148dde4612c0f8fddb8 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1039,9 +1039,9 @@ bool ipv6_chk_mcast_addr(struct net_device *dev, const struct in6_addr *group,
 		if (psf)
 			rv = psf->sf_count[MCAST_INCLUDE] ||
 				psf->sf_count[MCAST_EXCLUDE] !=
-				mc->mca_sfcount[MCAST_EXCLUDE];
+				READ_ONCE(mc->mca_sfcount[MCAST_EXCLUDE]);
 		else
-			rv = mc->mca_sfcount[MCAST_EXCLUDE] != 0;
+			rv = READ_ONCE(mc->mca_sfcount[MCAST_EXCLUDE]) != 0;
 	} else {
 		rv = true; /* don't filter unspecified source */
 	}
@@ -2505,7 +2505,8 @@ static int ip6_mc_add_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 	sf_markstate(pmc);
 	isexclude = pmc->mca_sfmode == MCAST_EXCLUDE;
 	if (!delta)
-		pmc->mca_sfcount[sfmode]++;
+		WRITE_ONCE(pmc->mca_sfcount[sfmode],
+			   pmc->mca_sfcount[sfmode] + 1);
 	err = 0;
 	for (i = 0; i < sfcount; i++) {
 		err = ip6_mc_add1_src(pmc, sfmode, &psfsrc[i]);
@@ -2516,7 +2517,8 @@ static int ip6_mc_add_src(struct inet6_dev *idev, const struct in6_addr *pmca,
 		int j;
 
 		if (!delta)
-			pmc->mca_sfcount[sfmode]--;
+			WRITE_ONCE(pmc->mca_sfcount[sfmode],
+				   pmc->mca_sfcount[sfmode] - 1);
 		for (j = 0; j < i; j++)
 			ip6_mc_del1_src(pmc, sfmode, &psfsrc[j]);
 	} else if (isexclude != (pmc->mca_sfcount[MCAST_EXCLUDE] != 0)) {
@@ -2561,7 +2563,8 @@ static void ip6_mc_clear_src(struct ifmcaddr6 *pmc)
 	RCU_INIT_POINTER(pmc->mca_sources, NULL);
 	pmc->mca_sfmode = MCAST_EXCLUDE;
 	pmc->mca_sfcount[MCAST_INCLUDE] = 0;
-	pmc->mca_sfcount[MCAST_EXCLUDE] = 1;
+	/* Paired with the READ_ONCE() from ipv6_chk_mcast_addr() */
+	WRITE_ONCE(pmc->mca_sfcount[MCAST_EXCLUDE], 1);
 }
 
 /* called with mc_lock */
-- 
2.47.0.338.g60cca15819-goog


