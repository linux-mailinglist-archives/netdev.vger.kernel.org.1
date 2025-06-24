Return-Path: <netdev+bounces-200822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D0AE70A9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56C11BC4D63
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03442EACE2;
	Tue, 24 Jun 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPdAC1FR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A82EE260
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796793; cv=none; b=rIuyDCSrMN2dOwVBXOTZvgR502vCpm8C6+GbIkKp8UwRAI1djtYfe7KZxKgvn7YJpf323hNvRfT2Wwpo1gU6+sFsTnQu5i9YeanxQqcfE5W45IXELkEjOLTX0kbYULjF7g7sIOWQ6/FcsBgMeGimsieqZvAyVDIU20FcVYlbmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796793; c=relaxed/simple;
	bh=CSjywOFISuVG2Ax6w8TLfJX5S+sf8DRYS5jaJFGuW0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEQjvALVP2SvOleuXew518zpvtUyTq65jDvMfoitPDSns73QVhMU6z3FsSsBM3vwNbXHZPR2OOKSUws6aXopZHBwS4wUbOV7UM5loJo9e+NXt8n+ZecxNl9m7VfBiv0kXyBPi3UrOZ7c4cPjNqRxkjO3PCa8yQTCY6gx3zTlgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPdAC1FR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748ece799bdso3828480b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796791; x=1751401591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z1WV08rHXrRQzZ3rSNzIEQOnAEPN6BeNRr0yFDesPc=;
        b=WPdAC1FRIVnTQes0PF0o/WrCeDL7hXxC84MWc+2oIS+4DdfpsDYEJkQPNahCqyXez/
         CkY/WwOIfeXac2p8+cTjM29AP/fFY8HhTD4INW5PNjhC1B7Uc+wPETBAK6msrXRH98xw
         cQao+0B5la8zZuQt88+VVH9szcy4Ji+uKYDcSfQOckOKLEvEnwmHz5r2ruQGbfe42XKf
         SR5Z73LlDQgflk5lta+oLzPCviQ/S9nYG++Co1GRVFfNreW/Ks+ZNr7bwknt/p2bclbn
         d8DwFWVdOBYhjMy2kK/TLqZq/ypReoZqklrwU4Ou+Vd6Tgd3RWAAlLkBRLT/5UL38O1c
         WlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796791; x=1751401591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z1WV08rHXrRQzZ3rSNzIEQOnAEPN6BeNRr0yFDesPc=;
        b=lls1zJHMzeHH5XkE8jXiibv+jemvAx/ZgFcu+qvOZ6x93BCDacGeL3wXUTclZAmkmA
         4Vj0E1LVdW2WgYqzom/Z2Mp37StDYUT7xUvXpYbMc4I3kmPBou3GJrt7TKU+VUP2Hho7
         +M43A/j25JYkkePpgzXjjDW2/HekxaqGP0mXOItGgTHr/3YOaW2lXhXcAerqEGUvYzoA
         PfrLaHBhVt+AQJ67MmE6futKGadspHqqh8MsTqeLXD2h/iV52i2k39nSSGLiUgC622yC
         pXhSwK7eVLP9HtRz1ZO9vXGsB1TKZwc86Usz8y2uHba1cDYAbBK5RmoHY2Y68tcT4nAg
         rbuw==
X-Forwarded-Encrypted: i=1; AJvYcCUCBU3STiNcPvwFiWsyq4VHR2GrNXg9NLLofg2UnqiX3KNwfaR4Akrj00Foc27HS9W4L2zitrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKsMqQWK5iAKRu3zLvQOtbNh/Ovb/XuC20+hOJyQwD/UNLvQk
	4d6ByOrBdt69Awsf6Vvd0QuYqaBsLmKQaX8wnFClpxZUwNpnTxbujTQ=
X-Gm-Gg: ASbGnct386svQrGX5w2MiBMSzXsVrB19Qkcu0rXaYRoIfRkZmqlK46CTb00/fdjO56s
	hin1WHFLRx8HXyM+UG6FbfeTKyQkqUDjRW/Ea521r52f4hoOH0FdSe+9CU3TnClODo7EufQIQwA
	K59kYX25GAmwY2Y4uL7U5VcJyigFAcFg+hSMVBJ7vjGy1FlVg5uyfWIOMKbNlw9uplrXlgnuHaR
	vdD7f9x73T5rQotwRJNkQbiOygAF473kw0bVimrfIGid1fCCOuSFLVaXYuv/43Qz30brgWoZhRm
	pDCfK6Pu9YqKYFMGtjFMAXidfyVIZewKKDeJlWA=
X-Google-Smtp-Source: AGHT+IGt1FIVHtwmURJqC4MF5BpLs1bcXoYN7QI8sNvxOlqz9KTZB2auLS8yLbjQ4AsTed+jIPe/TA==
X-Received: by 2002:a05:6a00:1953:b0:749:b9c:1ea7 with SMTP id d2e1a72fcca58-74ad458e64cmr658338b3a.17.1750796791435;
        Tue, 24 Jun 2025 13:26:31 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74a9697817esm2252994b3a.124.2025.06.24.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:26:31 -0700 (PDT)
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
Subject: [PATCH v2 net-next 05/15] ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
Date: Tue, 24 Jun 2025 13:24:11 -0700
Message-ID: <20250624202616.526600-6-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624202616.526600-1-kuni1840@gmail.com>
References: <20250624202616.526600-1-kuni1840@gmail.com>
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


