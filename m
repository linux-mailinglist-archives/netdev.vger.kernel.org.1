Return-Path: <netdev+bounces-146578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A19D475E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 06:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DB281835
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9D80027;
	Thu, 21 Nov 2024 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQyLEew6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7E2309B6
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732168583; cv=none; b=XyZ1BbvnOTdgr2keZqgoKFFGegpiFH7uAqU62pVw+bUz6z0U0jRo31TU5aIr/mqZYQSR9HuheqlS3J4HR3JPyCzpmBvr9sKy8Jbyef7pMxn5U14E+g1LqSSxy4qBdH3Xc7XiKoTPsCL6maY84omEkgDKUIGfWq+vnK2yx0cQvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732168583; c=relaxed/simple;
	bh=ztknavxuIVBDUI45LRspwNFcluis/bcqOBEq7fbbVHg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q80s1qxnmXDGCCGfk0gzNdU8gPWVgsiyDxK4gire3vlgzHQOTHaXAKydQseo5/2EZWpv1E0TwKsKb+6Xtrae0GgwbO9UQtDz+W/vRSjlR6K/gXntAZrgHMjMLofBny7gqdqRaai+rRJ58fjwLkc1+A+F9thVVKFtRWkgWmzFOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQyLEew6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8901dff1so8011537b3.1
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732168580; x=1732773380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5VNkpWoVPxuHBX2Pcnf13AY6LQMDvUHfwQtvBvrrKg=;
        b=WQyLEew6Fhr0LXrw0ts4vNNfW35mlkzLDzuwso2ZJKqk07Np7NhMcXo8LycmGtZp8G
         qnPmL6UXPGutfxb+Fv/D3Z+VrbUf9TAXgScBpg0hhZmkKjHknoHjOYkZyytGjMMdopBf
         7ZagTZmrALkOC6UKS7LiFJIS9EgjHkmglQwESkdxPow2yjf9TovFc3xAn3s4yw9GfMeC
         /g3WmtkcFc1Z+BKNzD2nquhaNpnmtaEIiTzBrpRwWuV7/MNd4EKp4ELxCU0eV661B4No
         J6HAt7c7XiC+FHUi/sAZcYrr34jNjMKSZzrLXGkQWhwZe3m5zGIQWJfdDKE+iEiLTpzU
         eFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732168580; x=1732773380;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5VNkpWoVPxuHBX2Pcnf13AY6LQMDvUHfwQtvBvrrKg=;
        b=UJYrys/d32Vi5E6f90if44Y9RTHRJad4WciujnvrG/Mum17Q3WfEQTFq2I1ZWlGA2f
         lsn2I/qiyxmi0J9Qlb/I3MDfS57aB8/3/RGBY5B9u67XOUCQ4wQzVS8r6KcKQAr2RTtT
         3WDaIJHpJrJeXoutJ3GDVzu2NWXt1E11nvg8c0R4rmc4KhvenKceUMdcnscfzeL/rCUi
         ZBTZo3PY3cDQX7GjebABSJIVZYO4AlO/KEZgkhU4E5x9Zyk4YkAOjPTiJPs0TSebOpbG
         0bGNoE1135OlXXA7T88Zqb4/guTkn1MkA2SxPuvW5CXCoIFttAsp+ifQATB5LSduHGau
         5+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUhbVBOpEq51cTNvxoMpyBRRjhhQdEN/ymbYsTAUIMs8vmxLr/bErzxoXDiqlvdCBIqQo6yic0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vChyXAb8xKdddDpn++dQfDwZV3qX4BWY1m+gIPgNqF+m1G+T
	FbN0ZmzxtXsLxks9BYa9QSHyKcLzDL/mQM2B4KjBsqAiZpiX4roYqWvv/ODHZO3qDr6COKUCw+5
	rtHAxvvOmsldmwqcBPfnQhg==
X-Google-Smtp-Source: AGHT+IH53CQR5B+ZXp6BN2nQgHDSPFZeHTLSsYHJCpctFuJ+JRzp5TZZGJKVH+pDsEId0GV4vTZCHQ4PV/865ttQQA==
X-Received: from yuyanghuang.tok.corp.google.com ([2401:fa00:8f:203:b514:d526:a415:3fd7])
 (user=yuyanghuang job=sendgmr) by 2002:a05:690c:ec9:b0:6ee:7ea4:4925 with
 SMTP id 00721157ae682-6eebd2f0fafmr1194457b3.5.1732168580253; Wed, 20 Nov
 2024 21:56:20 -0800 (PST)
Date: Thu, 21 Nov 2024 14:56:14 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121055615.826882-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v2 1/2] iproute2: expose netlink constants in UAPI
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com, jiri@resnulli.us, 
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com, 
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch, 
	netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change adds the following multicast related netlink constants to
the UAPI:

* RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR: Netlink multicast
  groups for IPv4 and IPv6 multicast address changes.
* RTM_NEWMULTICAST and RTM_DELMULTICAST: Netlink message types for
  multicast address additions and deletions.

Exposing these constants in the UAPI enables ip monitor to effectively
monitor and manage multicast group memberships.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/uapi/linux/rtnetlink.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 4e6c8e14..ccf26bf1 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -93,6 +93,10 @@ enum {
 	RTM_NEWPREFIX	=3D 52,
 #define RTM_NEWPREFIX	RTM_NEWPREFIX
=20
+	RTM_NEWMULTICAST,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
 	RTM_GETMULTICAST =3D 58,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
@@ -772,6 +776,10 @@ enum rtnetlink_groups {
 #define RTNLGRP_TUNNEL		RTNLGRP_TUNNEL
 	RTNLGRP_STATS,
 #define RTNLGRP_STATS		RTNLGRP_STATS
+	RTNLGRP_IPV4_MCADDR,
+#define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
+	RTNLGRP_IPV6_MCADDR,
+#define RTNLGRP_IPV6_MCADDR    RTNLGRP_IPV6_MCADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
--=20
2.47.0.371.ga323438b13-goog


