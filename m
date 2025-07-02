Return-Path: <netdev+bounces-203555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A5AF65C4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091CD4859C0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7422D77FF;
	Wed,  2 Jul 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/ltyzk4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216C2BE7DC
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497343; cv=none; b=DXoL5DlpPahzeg7uWVubkRT3Xm8COVfRFdFvwsSxWPkf4yLbe1ieWJPTZL3f0P6Meo4/e1/O8tnBVdIKE27FVoRc4uza8HrmsneQZnr3Zupf2LF/E5A9pjJOV06PU3Hrf3g1pxguR0S7SjPyVgBPkmohZu9AqqQabZ9krkW7I+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497343; c=relaxed/simple;
	bh=pvl+dnAVo0IHYRGvJWk01zuBx8YLVDekLapURhCu/Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyElcswgOT3i/teoecG/8ONzLbgNlu6RrDXPERZ+xP3ogC3RTwiJ5fhwNoU2hc26/PNMwwBqCr829gUVd02lqJEPiKvToV8fZBcaVlBkBQt7mlAtpie0M5OjQddCmWgjZXjXQyr49DukpthJWtbt/9bfxxErO5QeCrw+H+/zSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/ltyzk4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23c703c471dso3806435ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497341; x=1752102141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSLg/ETMC1zIwNZZ+Ni0SEVX/rKmMANz8+uZezHLMDs=;
        b=O/ltyzk4ZSQ78GkHSNlbGXpJMSJBYhrn+3038R/OaUy31VOOJcM+a2mkwEa26iYdAH
         52V4zpTgpi+zCaELed7cWsH56/brHYBcd2AUOtT703w1lt47UpZDDsd6ZYZGy0SqKxYp
         BGxGnVmRNfK+ISSSjtUVVplKaoXIrWe8ZbKWWuKjE16Vo2tfdDP7blw/GG0/LRZHuKjV
         rTM2aVpYSJT/J6k9EkAvkbEx0xWsa1uIk+mJocgBwtK9FE/8mhsuprBeO8xJhBBsj3xY
         0BZohgJEejxwg/b5HuVPLMYWjn+evVWGAhqbyPcFpnJc3FEqBelyRY6gU2ZUunytQR+G
         he8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497341; x=1752102141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSLg/ETMC1zIwNZZ+Ni0SEVX/rKmMANz8+uZezHLMDs=;
        b=mdie3Q7od7mia3BZDZHtU/7gy8K15ORyTbLLbt81srH7agIkqwpsCcAvcQ153yp8aB
         BImd1abAY3ISK8pQWAeMEcUr7N97Ak8KlFuPlwbRbWpwYzGRPNmjg0kqt8ksr/HdqB4y
         FpNGEIP1A8nsy+a1MCHc9FOSrn6Kk/4ULUl+i8Sc2m6pPrX3xoDQVV0U1Ndunh2YP2bI
         JuTu2FwBGHC1wTKowAsehmQGAnepVsAGYP3fa9iTEEWpBC13bB+veUjijgoa0gpF+HMU
         NApcflMC/vTVWnTuLeMWxcZoOiFrw9+pQwIM9Y3jyzsix89WCY9G9KuLfPS+NeJWcTX0
         G72g==
X-Forwarded-Encrypted: i=1; AJvYcCXZDYPu9aBCZ2NWwYJkHnIqUtK0GhHFSYDaQGRaCp42se4FvMvP6ROtCyWBz52LMv7yRKLS7ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPFd/O5FYFVGKHDxaEAqMTA/ZqQ69Ufv6sUNPsqZxkVPGpNnz
	BV9ITjXa6L5tdEQQVzMp3UZinT/SfZBz4kEyEf38gb1BkhPMTSo+r+Y=
X-Gm-Gg: ASbGnctfavZWe3kFzix1oLgwRnBkFkiVErWoppVTvtFEiwdh2JbF+2ipSvsyF/aSnyw
	k3C6D1iGgoO2FkaHiMoOSgqIAM+fGSnwdb/SV6TD9Ifvu2DdmXNqMAGvDu7Vm4kEstUvQGV6AWQ
	NzcdDEUxGklKHS+yiTPDa/OlZEoute81mq5dG7WVSFzxyUcHxkUEpU1COMCiKY/Ks36sbFTFxW/
	P//41xwWh/qtiCxUkzau8R7XkTlc54gdccXygwcrn5Mmlo6n8pbaBPzlrNGpvEjQlgYR4W4YuBo
	c0H0QKqjBCxxcgEsFtyRhANBkeAMYeAdk8u8MORxECDNYfqUkg==
X-Google-Smtp-Source: AGHT+IGKrpIU9xQVa3J6AY36BkaiOxWfpSXvOqV/aGnz1tdPTUdZ5ZUe5h8vIjSQMoOuoUASs8VQhA==
X-Received: by 2002:a17:903:2407:b0:234:2d80:36 with SMTP id d9443c01a7336-23c7b8bc5afmr234425ad.14.1751497340928;
        Wed, 02 Jul 2025 16:02:20 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:20 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 05/15] ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
Date: Wed,  2 Jul 2025 16:01:22 -0700
Message-ID: <20250702230210.3115355-6-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702230210.3115355-1-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

As well as __ipv6_dev_mc_inc(), all code in __ipv6_dev_mc_dec() are
protected by inet6_dev->mc_lock, and RTNL is not needed.

Let's use in6_dev_get() in ipv6_dev_mc_dec() and remove ASSERT_RTNL()
in __ipv6_dev_mc_dec().

Now, we can remove the RTNL comment above addrconf_leave_solict() too.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c |  3 +--
 net/ipv6/mcast.c    | 14 ++++++--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index dcc07767e51f..8451014457dd 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2241,12 +2241,11 @@ void addrconf_join_solict(struct net_device *dev, const struct in6_addr *addr)
 	ipv6_dev_mc_inc(dev, &maddr);
 }
 
-/* caller must hold RTNL */
 void addrconf_leave_solict(struct inet6_dev *idev, const struct in6_addr *addr)
 {
 	struct in6_addr maddr;
 
-	if (idev->dev->flags&(IFF_LOOPBACK|IFF_NOARP))
+	if (READ_ONCE(idev->dev->flags) & (IFF_LOOPBACK | IFF_NOARP))
 		return;
 
 	addrconf_addr_solict_mult(addr, &maddr);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index aa1280df4c1f..b3f063b5ffd7 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1004,9 +1004,8 @@ int __ipv6_dev_mc_dec(struct inet6_dev *idev, const struct in6_addr *addr)
 {
 	struct ifmcaddr6 *ma, __rcu **map;
 
-	ASSERT_RTNL();
-
 	mutex_lock(&idev->mc_lock);
+
 	for (map = &idev->mc_list;
 	     (ma = mc_dereference(*map, idev));
 	     map = &ma->next) {
@@ -1037,13 +1036,12 @@ int ipv6_dev_mc_dec(struct net_device *dev, const struct in6_addr *addr)
 	struct inet6_dev *idev;
 	int err;
 
-	ASSERT_RTNL();
-
-	idev = __in6_dev_get(dev);
+	idev = in6_dev_get(dev);
 	if (!idev)
-		err = -ENODEV;
-	else
-		err = __ipv6_dev_mc_dec(idev, addr);
+		return -ENODEV;
+
+	err = __ipv6_dev_mc_dec(idev, addr);
+	in6_dev_put(idev);
 
 	return err;
 }
-- 
2.49.0


