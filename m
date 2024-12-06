Return-Path: <netdev+bounces-149717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A999E6E8B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B451883827
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9D202C25;
	Fri,  6 Dec 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gcpcr41L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2A196DA2
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489162; cv=none; b=aZNuxgocoSEZ29XFXD+GjwncNbYKpkvYWAdkN++X75MehLfBfXJwcGnirTzVbPr365VVbcU3dtXvB4XFiRTfJgTAz9RUU4ssm1HvDKmnJm1Wxt7kv3BxKOgmRMUD7uWof03gDfJVPvN6Bt5/7luQKbeD2Z2/eb0vnK8RfXbL/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489162; c=relaxed/simple;
	bh=NTx5bH5I9pgr5modJ9vq7mgo1kwCUmKeLwlZ0Ni+atM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WxNCVs1NiclmDNdYiWe/T9EIYNesg1G8/76xYAcaXoKieTqUUZNNZnAIYDp9h5n5yquDzB/6dVJWSv+ud7ejnWPDLdaDZ17k7Lm2nx9kCWkUO+/o1fxtVqUuDqPTboXOKXxomlhb3D3JZCVopS5yS5vcuO6v6XBRqkDPQQX4sVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gcpcr41L; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fd312feb10so41664a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 04:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733489160; x=1734093960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zuZyPX8da6qL0JlvYVBXZyCB52f+7jTWfs55cORTM0=;
        b=Gcpcr41LKws0r8WqkVJ+JAmgzd9KZEGzaZxER+BxLwzTfGYvFVjOf+ES95ox+JYf0+
         GbNiH6+dGsLz6R53jTgV+4ik7GkcnbzgUSyE680KVlV+G6Cc/i0aY5jpY7YUQT2bonUO
         QxKVU2/lrxM2Mvz3++y0qIrnF7juJh9R8+ukqetwO8U0/AlM3UHkI9wsHiahHrac33U4
         imCQnoi0cdFzsvq7cWjtnhjcKujy1ePnSJU2W9+BndMW7tLXK2b7Ce0L8/QvtYBFPWqU
         tlkSoF3nodvEHzKLdrUDQghrnEdUcHc98mfDWZ/VhZBYzacrUgXgCtW2zhIXU3LJBZLw
         zYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733489160; x=1734093960;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zuZyPX8da6qL0JlvYVBXZyCB52f+7jTWfs55cORTM0=;
        b=Bcu05233qfwcZ/eOst0NAVa422h1IeSP0zUht4LGnN89JYHtlG1qCP4lJDewmQhGQH
         75uYt6JQp9cXrl3u1KXgHI0Qi3VD9wG1a+W/7BP96fOAWaM4D59t+zLph5vd1ZAPPLJp
         UWpLTaC2ZW66xp7BKJbDrEcAtUM4LR55FQxgmiNHwdFQyJtNa/G0htQG+dmuj212znVD
         G9WoeMUIohn/PcLJ4GWi48ZxZkyARARO1Efz+4Yra9YY1iLr4jqpJ7DuD8no8/s+FKjl
         lDDrKk9dKrxjzgkV1ZMfAZvCmWxH41hExCGbOA6MFKGYw9+3IFOirrptXe2d6Pfj1oij
         m/WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf3LgpONc3zVKtg107p6NWFDDfi6hKSRltWKPcgrSdKPVo2Ur/rxQeasa+Td2nTYNNFa5HmKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdvCS0JzNSqrSPiDDElwuOCnIOWP4n2SRC3QcQwePBEBykWt6
	cX6vmwmGLYy1Vwf6kYJEP5ZW5wKceXeDBvK6RViqeEYplvaEIFWLMiKk9xx8ly8ijnqieJ00Qnc
	Ru0jzZmGkZ1CAz/qjoDg9Dg==
X-Google-Smtp-Source: AGHT+IFiE+cNuX/5Dk6phE2/IOwf2C2Ypzf8RC1H8VBZzHnPUZW/+W7EMSdzCCbiShnG59rr4es6N+jgv8o9D/DP3Q==
X-Received: from pgbee11.prod.google.com ([2002:a05:6a02:458b:b0:7fd:1a19:6f8])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9985:b0:1e0:dac7:ecd6 with SMTP id adf61e73a8af0-1e1870c44a9mr4378545637.21.1733489160586;
 Fri, 06 Dec 2024 04:46:00 -0800 (PST)
Date: Fri,  6 Dec 2024 21:45:53 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206124554.355503-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v4 1/2] iproute2: expose netlink constants in UAPI
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

Changelog since v2:
- Align RTM_NEWMULTICAST and RTM_GETMULTICAST enum definitions with
  existing code style.

 include/uapi/linux/rtnetlink.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 4e6c8e14..04be20ee 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -93,7 +93,11 @@ enum {
 	RTM_NEWPREFIX	=3D 52,
 #define RTM_NEWPREFIX	RTM_NEWPREFIX
=20
-	RTM_GETMULTICAST =3D 58,
+	RTM_NEWMULTICAST =3D 56,
+#define RTM_NEWMULTICAST RTM_NEWMULTICAST
+	RTM_DELMULTICAST,
+#define RTM_DELMULTICAST RTM_DELMULTICAST
+	RTM_GETMULTICAST,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
 	RTM_GETANYCAST	=3D 62,
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
2.47.0.338.g60cca15819-goog


