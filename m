Return-Path: <netdev+bounces-148992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5259E3BF9
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF75280C80
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4D1F7086;
	Wed,  4 Dec 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ieuEd1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB01F7083
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320936; cv=none; b=Il5IFkXTPM7ibwl+48NlsVn23wP3r5u27xsD1jqjbQORSPJm3X0hehVLbf8LSAwR4mC8IVUNM9XaK6Eo7640ya21EFc7GvHDHjXjESyZoQiEfpXLWQb6q8/yaVeksyOA7XzGqNJ+x+nflX8lM9bmYRV9qx++KJ9UH0XM5Y6Qisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320936; c=relaxed/simple;
	bh=NTx5bH5I9pgr5modJ9vq7mgo1kwCUmKeLwlZ0Ni+atM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fC3gGsXRKNhLoBzVghBee6kYMUgpcyyC971Bwx0laBOCq6CWPlu8floje+aW+zwVTKemvqZNNlskntM/4ViHWH6tJ7qDEq86nOP4DKVkjI/kry27MJqLP43lAypuoGrJ0eEp7TmCBZyIdNP2eWO/yPLIhhugaNp9ttx14yooRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ieuEd1V; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72501c1609dso6814465b3a.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733320934; x=1733925734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zuZyPX8da6qL0JlvYVBXZyCB52f+7jTWfs55cORTM0=;
        b=4ieuEd1VMGLgbSVEFfCerq6AOW+RPfGzqp6QwAteWPWLN56t9gFThjURm8SChNnIoC
         Qo9YReWmd8wEBtkMfaVV1SxhphKa4C2/ieTkcOFf8PKD0Drn3aBhl6PsUFDtUGNNHOpg
         dhYh5+rxGI9/EkUITmzJ7SYxd2sDIila3jC4uatEy9qaUh5WaAMb9SU4o96PvPKZr5ST
         aiNBVYnQE53X474WITp7hMjm9GW5f9vWoXXMqaCUYYF3AU4PuNVwHVaKwadyXGrwepb+
         9yVYJHH9hEGrHn8XKSfj9kS0OMAc8cT20X8rJpSybSexEYJr40COgz/fwONYdlhF8ONe
         hNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320934; x=1733925734;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zuZyPX8da6qL0JlvYVBXZyCB52f+7jTWfs55cORTM0=;
        b=OQjwYSyG9YWHPbDe9BHevJGWKxnBYbn5VsjDM2FuVIccEYq0dSjvzVFVma1Qsfa/qi
         Y7BWx6VvM0Hy6KoQDBmfyvluSumNT/CYGdvJ/iAXKtynFxp2YeN/vSO4RPMSB8dXywXM
         mf1LWfNupunYW6aaGQ7D1Cu36sDnHwTS6ksCp+xV8e6G8tQXqjOkcmA50n5/Oh5L9EeF
         W/ov5fJ3U6s+5L2+PrEvpBFFjy8w2xOUz0scUkg3bvaEUdO0bkfI/Dah+567yovKRlpX
         DSU4aj9gvCvxfpagxMJPAkm/ap/DBihzqDMJ+HIaYuOEWNBsIOEgYFJ4X++DvhgOEHdd
         k3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXoMe1thJ8HGZIH+wsbtlQS+8JG5OdLwLoXTZkrSLSc3nlAeEUpKwTnt9tahLO/pPsgszaHz7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOTCERtaVMBDID+TPp8MH0PkaM4ITOBA5t+WWDCSkK95+0HTT
	eqVPJYEsiviYyLQIV52kCUOEUUjTbJNF96/C59qbvzVr1dgpeuIO1Dc5ReTDd0cYnc0n3ETHWmu
	W4q8v6eMaLgHu1f6B6Bdsvg==
X-Google-Smtp-Source: AGHT+IEp9PdPD6CGniZDUxnjuRM6z9U8YkTeTStWLecer8uJir7XRqV28fPqDC4vusdrdOn3X5xF7fAjbEO4mdzVAw==
X-Received: from pfbbd16.prod.google.com ([2002:a05:6a00:2790:b0:724:facc:74ab])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1496:b0:724:f8d4:2b6e with SMTP id d2e1a72fcca58-7257fa3f671mr8569825b3a.4.1733320934150;
 Wed, 04 Dec 2024 06:02:14 -0800 (PST)
Date: Wed,  4 Dec 2024 23:02:07 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204140208.2701268-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next, v3 1/2] iproute2: expose netlink constants in UAPI
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


