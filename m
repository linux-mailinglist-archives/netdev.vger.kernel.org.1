Return-Path: <netdev+bounces-198331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318C8ADBDB2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327AF175BBC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE1236435;
	Mon, 16 Jun 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZJpCADs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C2235070
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116886; cv=none; b=qfihQfkl/ohsrAw2A/D4LeLilSXW/sP48iKj8IN0yYXtAbx3PcuFTkaKL+a3EDlBWof9U5AGZ9Y8+JnwWtvsWrqL34TC7dy9+bFzr0stGQusaL+bn3PlL6+sEeGFpHB/l4k156bgOTGF6ldq2N6hJVtp8c5heNZXVZRGxwjjkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116886; c=relaxed/simple;
	bh=CFY0+/ROCIpp3jNkxcHrUGXBDUA7+sqKqyBNIY6u9oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdIHY+tw9uWAkyQssEB9m78Kq2DJ1Bi3IYfU1rBDlnRdUCQlE+Yoz6WH7eNWuxV/QXgqKtFv4KZFaZ2rQ8uKnJFw+q6/kYpu5g3AKT+jRNtj2uLjp0FZRXZQMDNfw2CBf6FZAx0HzBE0KEh6+jSy0AL1fB/lII/rEnTJrnbkFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZJpCADs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ea292956so45714445ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116885; x=1750721685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrRGiW1NI7Y+ZXYjvCGr6b3oeF0yBgwvl5Xp2ryRHUk=;
        b=BZJpCADsMLNaWLNsXZLLCzRSNYa3YYLJ9G/hLMik8n5wNE0oEQgy/c442Wovw4uysn
         WnKue7nwB33BhlpY/qYMuyV/V7rKeTzPAcwzXGpfzVebmrXdaqS3WOtimYmDcJF9E0kZ
         8hZl6ubTxeFlXOUJ4cH50hie3UY9DsjZ0AIYFIua4/qQ7Jr5yquIKGddCEhfeTXC07fB
         slJc84KM95KcTRQgFg3Wk/GCXiUfDzN0aLRbkssE3T0VomueO6EYQ3e4prCWaPuWlJML
         HUoCfw+/FwiRFcKRePIWoVXEl8qB2DJEdp7JYrRhnYX7xZpuVC4/U3hXvvmXMJfjK7iM
         XkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116885; x=1750721685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrRGiW1NI7Y+ZXYjvCGr6b3oeF0yBgwvl5Xp2ryRHUk=;
        b=a4Pk/WvprIZSI1AmxRN94XIeXktx+O+O6Qc6EyTzHI0+wWvUeY4wpc3CP+okSdCEkl
         sWx32SosgHhHBbQ5f57pgOuHq7o0q5GjmHmrYDAZVwQSqNRjwSQagaB/5zJDayCACJRd
         VIUaxKEJ1HDBzmjpgFeX5B4tK8q/yJpFalXMd1eOFo68vPe/bZ/BnbMuZCE7sZBGV1bs
         6as21TPRVJ9fznnqkq3COw3EwzoeT8T5/wTn8NttitwbpwGJz6nJb1hPoGP0/rN5Cxx8
         XzE5EotHAI1h+0fLafDwayMY4xg3mFw7ZpHv35n80DCcct/e5ijjV0Ntjkq9HTKMBkQz
         n6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUxazQCQFdHAYyqj+MzZTDq6/fMavGPvK3R7SgaYKflQuHzuqmW54XziQjB5darICuLWfHAoko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdmX8hlkyEN9X7PuiIP2TQ+14L4M+8GDge6rXrjDO8RmiVfP1
	G9wjFcnbt0DzBy/YfIo4s1QX26I8ZMrwk2di4fgLe/I8cVGYqli5080=
X-Gm-Gg: ASbGnctArDnjCgv0pjU4+Sf7ban5oml7jQcvlzSVIjnyYestig8tigd/iDxkHmAY677
	dc2LAl4P17S+UjoCdf4pgvBcEC2wGRXc6F2j9bjk8IAKuDVAwAh6vAi8K1AHdK5hoWPlGtwqdwr
	e7mF/KcCQMfuyvaUxtgOXP+rFFTAt+Ys9c1JvkbP1dS8RZV3JrmyIP7++8SDa1nSAP9PErs+zzr
	vUo/mywh/Oa2DkAcYFA/EqPYqo3JUAMeITW5o5PkNctoRxJz3+rLsiEfJyrUPmilCKTQa9Z1dNQ
	eixK5u/Oz+BYC/ApMVusb5WX8X7AAT9eoN/jFVAlnHeKwXxPdg==
X-Google-Smtp-Source: AGHT+IHbxrXwG4Qwtf/FeYDRXEjOy4IweHDpi4vJbGSkxEMBPZEbl49dA465J3Wu8PUMyt2GVrUrrw==
X-Received: by 2002:a17:903:22c8:b0:235:e942:cb9e with SMTP id d9443c01a7336-2366afe993amr165947925ad.9.1750116884663;
        Mon, 16 Jun 2025 16:34:44 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de89393sm67220485ad.114.2025.06.16.16.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:34:44 -0700 (PDT)
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
Subject: [PATCH v1 net-next 05/15] ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
Date: Mon, 16 Jun 2025 16:28:34 -0700
Message-ID: <20250616233417.1153427-6-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
References: <20250616233417.1153427-1-kuni1840@gmail.com>
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
index e4c48638211b..78ee68771229 100644
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


