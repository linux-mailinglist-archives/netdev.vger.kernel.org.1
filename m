Return-Path: <netdev+bounces-153367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A49F7C5E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B7217188E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A276D22540A;
	Thu, 19 Dec 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGQhDQXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657F2248B5
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614826; cv=none; b=D/0fjwUPfKY03FyOmlqUDlD1NVhP7qNzr3DIXYHhftN/brkpFqqe4GFzYM1VUpAvZNIEBgbqzkYiYi62axfjciy93UQZkf2qTN2vFQ0UhZS/o3myEXK4qGdjxKTGV4jT18p4SjXeGq/NbKJ6qdLsX5VKeNYFxcN/OVclekUsdT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614826; c=relaxed/simple;
	bh=7JfwExJPXf4+KZWdRVEHYl9X78Kvj0EnGruR0/vAKco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CtcLk5JfwUKAxv8cqBo/iS8I0KMGismNemP4MQxLALDCnXETcGtumVcJOXeXo83DfDpSVICdaG6C6qxh1V97lPf5UUy6zko5EdVjqWvDXEwCjNjHvlHZ8cGD+ecgKxv/ew5fQ6Pvv6MzdMPgURDTTTANSvRrC+6TrJrd07+DyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGQhDQXW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so7830435ad.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 05:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734614824; x=1735219624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRWfvID/RC4EXwKHHgpdoiAEifz/0Wnw+i3ttSJGD6Q=;
        b=GGQhDQXWdHE4kZhik5HvwDeiuLPbOHeT9/F+Ctp9LrOQo51+8GnyZr1WbwLANHhgEy
         FP8ms7wb2uUd/NtdXtNP6j0JKvEm7GY7snNMUhxaJYeIE6+MxW1Rs6KquFNAJsW5jRH2
         lU+RKUyQK2wdL2aoxKWt0dAReA2Rw3RHlOH/ED7N2JKlmnJn0LucJIyK8US8RaZ7aqis
         ifg1PRzGC6ZYBBHloR7F0EYDOXWMdCpV+eXjeYxnkECHSCgEPOg2Ke6II95XrRadI8Ht
         bla1Ko96nB85rx2HqfOdeVMTp4NBCXjgRUNVz/iM0UTLkrIKpLi3zNDJl4VesN/q2Bri
         tu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734614824; x=1735219624;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRWfvID/RC4EXwKHHgpdoiAEifz/0Wnw+i3ttSJGD6Q=;
        b=rrG/od2nkSeFZc8kTXNHPvWJsipaUf+O6pv1fnXTsWHn1CvfiGvB0ryGebf8V08jVu
         NwApuN0CklOavOAUcXYDhTWrevBvr5TFtIsnFiM7jQ5HDE0XqfV70f8iH7iEmTtK69Hb
         DipVWa/84k8ILuxjHRjf0M2/mQU+FrLotHsMqekTIzjSLIjxIc6lg/8KZCxg4xibDmts
         YyLK/vZxXnxCKw/CvmNWMyIaZRDChYTx06QFS8C+s0/aH7Lz97XSVG08bspEeUfyf6q+
         zubfcdm4Qm0ERcmqJRXDaKH4UtCaBGlcn9OAJyG5XGPGBum26z4nxuhWsRiVRjJIQx2H
         nkeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo3uuqvA0HJ667AEy0hbvqUKSYek4kIfhYDSp2f0ue+Dno19YryWG2+zqR9fj90Sv1SVhdUQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUsAFoxGjK4WVfMxWQpJJNYuQ514GLNSNJaBGLRH/ojCRPBvq
	vF38qufQeALKfCFt/vv4zzTFekR9MyeKSqes8tMs1P2cfEMN4JhFZMgxfovKClhOlUvsZU49mz5
	vhh9JjZGzTJesVAPM0VupfQ==
X-Google-Smtp-Source: AGHT+IEifO1Xh7iPIWFHQo0fw8WocMHb/FDxCv4p9W4etVR7dgBHNiasDrr0nmfB6JfEEhQI92rXw1KW5DAVUC2dQg==
X-Received: from pjbsk5.prod.google.com ([2002:a17:90b:2dc5:b0:2ef:8f54:4254])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec8a:b0:216:59d4:40eb with SMTP id d9443c01a7336-218d728de8amr91619585ad.57.1734614824382;
 Thu, 19 Dec 2024 05:27:04 -0800 (PST)
Date: Thu, 19 Dec 2024 22:26:44 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219132644.725161-1-yuyanghuang@google.com>
Subject: [PATCH net-next] netlink: correct nlmsg size for multicast notifications
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch, 
	pruddy@vyatta.att-mail.com, netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Corrected the netlink message size calculation for multicast group
join/leave notifications. The previous calculation did not account for
the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
payload. This fix ensures that the allocated message size is
sufficient to hold all necessary information.

Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notifications")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 net/ipv4/igmp.c  | 4 +++-
 net/ipv6/mcast.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 8a370ef37d3f..4e2f1497f320 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net_device *d=
ev,
 	int err =3D -ENOMEM;
=20
 	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
-			nla_total_size(sizeof(__be32)), GFP_ATOMIC);
+			nla_total_size(sizeof(__be32)) +
+			nla_total_size(sizeof(struct ifa_cacheinfo)),
+			GFP_ATOMIC);
 	if (!skb)
 		goto error;
=20
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 587831c148de..b7430f15d1fc 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_device *de=
v,
 	int err =3D -ENOMEM;
=20
 	skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
-			nla_total_size(16), GFP_ATOMIC);
+			nla_total_size(16) +
+			nla_total_size(sizeof(struct ifa_cacheinfo)),
+			GFP_ATOMIC);
 	if (!skb)
 		goto error;
=20
--=20
2.47.1.613.gc27f4b7a9f-goog


