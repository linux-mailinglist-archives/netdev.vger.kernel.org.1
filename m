Return-Path: <netdev+bounces-151023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB49EC70C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746B1284A91
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C31D7E4F;
	Wed, 11 Dec 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfpqPVHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E01D6194
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905499; cv=none; b=O3Z7j/39yAO0ZM/3tIvpp+n1r8yGJQITe7352q2pq3y9wb2Slcs9/z0QjlC8uf6bwhZO/V7A/3LmtCDKJmcQZvfRDMzUA3rypw72GlA6TqejjLLzSJZ7zRVSoJOCS32GBu2pIkfzWLd8f4IQx9fCCDSIQ+56zoUPQk1lM9CQdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905499; c=relaxed/simple;
	bh=+sFTX7r/yb4jwNLgBP0XGE8R3OIUGzxNfxkUlLSms80=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mz+puSctsRE49pDLIpJkk0PGPG9EYBD7fBGGcJpjD8QfAsYzR3FhlQQpzLZl13Fm7rHEalHI4+m0y598UB3RB+oZCEFurT1qLUKxbWMBS8P2uXZBCbZhYNsTkU3U9VOPYxe5a/qRoNe85416O+i6NDInZIM5Xt/413M/n+iN1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfpqPVHE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725e4bee252so3264252b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733905497; x=1734510297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5d15Vwu8V8HugfMJZUl9U2aigNO62hfS5LhNvf+0CAc=;
        b=cfpqPVHEceVuuXSZxSmfrJ5C4QID/0XOoptZhdcYuB/l5RPbz+74abJwLkja6d64eE
         BuVAAFMDgV/eEybuF+YDd8R2/z/zjnNu6c22hSY4bqXhRZ7TBOK05uQCFjVUOg9NtThk
         yswefv29zKUm12ivpnDNYC6s53JsPBB+DWlbhVZf1H+fx4QAuXV7gT0b0H3h7j44SJU8
         cg11cEGhJgOvSZP9uxQv2ij3FjErgBywyRch1zl9RsnUvxwnlMqSyjt594wR6HzG/HNR
         LMQxOFgbetKTYjLIM26DdQ2g4MJJ0R+QBj9dZbncs9PXHqwsR5LOpBWCQb9XpuYTs8Hz
         t9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905497; x=1734510297;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d15Vwu8V8HugfMJZUl9U2aigNO62hfS5LhNvf+0CAc=;
        b=Pr6dT4H4ASSslSKxV0h4CYYhB5OvgmZ/gaopqz38Z+D7AfCwA7AfJrNgyrSU2VmHJ5
         1J87s6W3/78hM0gVy/vKij3h1OOHraO/Tb3IrR8te9wwHcQHVl5f0x7HGU0mdV9cmG8U
         FN1rvTmplhc5pwNhHOQortiXn3PpS/yE90TwhenrfMTYN+9cJQWxyTwZsmDz3e2cq2OO
         u2ZzhTqtd9vV/eS/A0dDwfSrkzZQRNglIIBlbSrrRlL39GQBtS8MbWY18+MnA7qH8+Kq
         LL/6nNP35hjpU66Mm4l2pVaTUsNKwSLAdSmKHHhMJmysOt4znCyiz08i7JWoOfX4ukFI
         fhFA==
X-Forwarded-Encrypted: i=1; AJvYcCWyd1TVFtzNPjBuI27qZw1lAnSu1+hRlrMpoEJitpu77eXovx4saye79Q0tEOX8Vs7BqF4C3Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMFObcn/eC8TxndBwxkTkIuRHoWxUdojAt6m/Ke5m/eHp8pT3O
	owmz2J31hAMVoOHXst5DUzbmg04QmkKcitMczg67wlERsf75p/X6XTHJ57RSVRWmXylV4BtsB9s
	GRKDLzOAOAotFHfH3YDcHcw==
X-Google-Smtp-Source: AGHT+IEAiTxDYJ+uvj3+WOj+VTFwAj91AmaVhGRRiL3df+LEqh9vB8gQVQ+1lZ6+clbJED/iXSBkmRlgC/XQxNpqIg==
X-Received: from pfbbq10.prod.google.com ([2002:a05:6a00:e0a:b0:725:f045:4714])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:179b:b0:727:3935:dc83 with SMTP id d2e1a72fcca58-728ed3dca59mr3321106b3a.10.1733905497517;
 Wed, 11 Dec 2024 00:24:57 -0800 (PST)
Date: Wed, 11 Dec 2024 17:24:52 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241211082453.3374737-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v6 1/2] iproute2: expose netlink constants in UAPI
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
2.47.1.613.gc27f4b7a9f-goog


