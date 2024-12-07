Return-Path: <netdev+bounces-149891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E99E7F59
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF5F1884965
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A3C136345;
	Sat,  7 Dec 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqBJxwja"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C50200A0
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733563215; cv=none; b=iQn9HCf+Ota/eIggSGuuNi9Ki0/m3553Dt2/e4LbtudXXjOHHSor0NgR072hUVaAJfIsOHYe+7hCzNh/x48tuvDP7zeMtC25yraE4LVd4aW13qWxSFDKiFn2c4VFrgwqZSArf/9XtlWTWwTz1SCB5fTfMqfYbd023LGveoTy1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733563215; c=relaxed/simple;
	bh=NTx5bH5I9pgr5modJ9vq7mgo1kwCUmKeLwlZ0Ni+atM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QlvlLA++tqPMnX20cGVZoCHumg8RdnVyrFDJLV4FMEayddr/8kPq1Wmx2TdUW9buUlweSFPBJajFmaMURUlngDnmvm19OD3yGrW2cs35a3GRNErzupGiBZjxvYSxEG2E3IOhk8N6Rp5fFpzJBZIc0zFMtH8A54qlBnrEJH/Gn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqBJxwja; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7259ad34b4aso2868886b3a.1
        for <netdev@vger.kernel.org>; Sat, 07 Dec 2024 01:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733563213; x=1734168013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zuZyPX8da6qL0JlvYVBXZyCB52f+7jTWfs55cORTM0=;
        b=kqBJxwjat0pIM0jPqPMw8eLK015tx5h2zNw8wL7/Ws8UK+2biewFI0YFs5Hi1FgbdL
         iRLuXQQR1XE7FcpRQ0gIumpcCUDbA5tw6MBVO870cp05pxgvhAXFqPk//JpEN+Hx0OV0
         Wc5MU4gf6SJrVuI1Rv7zWfV9swps2dEF83tZNH0e45cyKVDjWXu6ZEKJ8z3VLOBLu3m2
         qG51A36UxTIlc2/LFHXuPXH++378eSPqTKyVdRe1bWLw8cN0zxL6bbkPk4dM9YFtgjQU
         bpbb2uaGSI7W5RK0eF/9aTgxRdh9UukeWBUEp1Rvj9nudN/qJ003vLKrMbRA/DPYsOVU
         uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733563213; x=1734168013;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zuZyPX8da6qL0JlvYVBXZyCB52f+7jTWfs55cORTM0=;
        b=n0FWKcBR0kVJzI4rV5dZ7eU1OrS1dvdDxafat0jM+3BBPDUQit+24RK1ukAD1ktD/q
         WXFKH+17ikXbBqp1h84pzRdt/0iXQm/k9FZgPNe5pxe/n68z/MLoYzbmes+leTIbmiPT
         kFMoBf01aNuBn37m4OIkRh4M+ppBdhVkdkR9WUsT2pxYqbPWzQYtfFuDH2lM5iAi3x54
         a3a3Pl8zGXrCGXLCEsqHvUYzKXgG861xrl0EZ634sq/Bbblg5nm/zQfSOULCWnauUzP4
         UPI8/BjYKPeVdtXiP3B8Z/pkQIqaqDTVssdVsOxfA8KFWU17AxMpTIV+bhhfv+wMXGgS
         cClA==
X-Forwarded-Encrypted: i=1; AJvYcCWuR2RnkfEZxs+TbemuRYNckNhSMcqcVs74YwsppyZX2/Qjd1xk0J6JiME5KJcZ0imOxU0hXb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdmDZrGiCME3/XJhw5ppZ66wF16eJJ1FcaVrOGq7xr5bOlYij
	lGwG1VDnx+Zh/xxELtlLGcxs902TkyzR+qrAJrAsS+ClJWmpvObPbTlYHas8jn7HpuHO7pc/dDN
	Zt3cSgfLgrfIqy41Tq9cqCw==
X-Google-Smtp-Source: AGHT+IGqF7Q45iSK8UgeZRECcIyU16HLcqXJo4URfugvzj5uFk9HydVSREBTxVhbYqIwZkxaYYBTzKcLVpIEQ9rS+Q==
X-Received: from pfbcq21.prod.google.com ([2002:a05:6a00:3315:b0:725:301d:d8b3])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:984:b0:724:edc5:4726 with SMTP id d2e1a72fcca58-725b812dd1cmr8143875b3a.13.1733563212916;
 Sat, 07 Dec 2024 01:20:12 -0800 (PST)
Date: Sat,  7 Dec 2024 18:20:07 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241207092008.752846-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v5 1/2] iproute2: expose netlink constants in UAPI
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


