Return-Path: <netdev+bounces-159154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF01A14876
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 04:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B10F3AA408
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E6D1F63CD;
	Fri, 17 Jan 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2drVUrQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D5725A645
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737084061; cv=none; b=fri26O7gPXgD3nsbsohTk0udeYgKd7VfHzqXzySB57V8Yn4qBNRiAOs5p+AuK+BcMsc7c3rckJoVAltoYx432cf6qIHCzzd7hpAh8xv1StsiHXtnbkux54CTNiWE9PtPT2QfLM9LkX3Kb3ByiMYpvtgWNnz/q7uSOR4WMNL3ZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737084061; c=relaxed/simple;
	bh=+Z331O+dwQFWIfcz5y6k24mU9VksTk0u1PlmkGD/l2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dAuXn7DiX7ZrlF2K5ct9UfRq0+kGjiyCjKPk13Wxj+02hKFlkcB7xBPVvCyLK9UhPYSPA7y4ieJIxniFxdR5RDHhhd+LIKrMBJYW9LS2MLB8tGTHwRqi6L0j1EQ8dRHKEhZ+/an2sO328yqLUl1Zm+n+8bt2QakqrQJmhZAG08I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2drVUrQ6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2165433e229so34503895ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737084059; x=1737688859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0If6DrQeE2EZRsaz5JFRc6xigp6fj64mwTYgrUT4HIQ=;
        b=2drVUrQ6LQM4QaEdyrOutM0f/YOsdgwXwzTBNnU9CnHZ5BCTk+Rr1YUoWpg9GYfHuG
         LunGIVEF1aqdiLPK9B7KZjQ9SiDrwhsYrpa/jQpY3YWz8kqQ/dU2Imzd1vjfHuR3mu66
         1dWX9Yy0bhBVQ0EQDk9wrrlyASkvbYDOfhmaUhpYTnNpB51CSV+trblu+AgvxlSARiv3
         3kNrR0n7bXTtp0Lv32rzg2bXpdAtUFKSJsmv+sd1A4idAuQ2AZQkb9lB2EOXiyQ309PJ
         X/LGh9UE+H1bbArzTcXggdh6yetlYvf9TxwKQvyEiKTdp0USs4OWMwua7gJVkLK8fPcs
         9lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737084059; x=1737688859;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0If6DrQeE2EZRsaz5JFRc6xigp6fj64mwTYgrUT4HIQ=;
        b=d5tgWBU5R9KeaISQ2SGGAOr3v7GRNcmnsuT+4xqDMBDz827G/FOhNeQXdCaNyVunhE
         gguMuox2GfBjjgPFwW8xqz55h9hXyvGPNLw26UBegZiksMwc0w+3iYwhSZGwc0ACZLjl
         HUZwX560DYnnHhtKWmeTAzEmD40cpFXlbfGNqM9Au+6vLcHg3j7PZ5hhGku1dkOEsu98
         qPhxFtaT6DhtwLcT3bMb/EazOSEU7+W4xZ5WULN8IC6yidwUkoONp38A5XmHZ9wcHFuw
         1zU2fRhx8vlKxGivYXKuijL3TpK2O2ORf9dBljrpp0aim4dm1VcXfnUW2Em9GeURHPwI
         52SA==
X-Forwarded-Encrypted: i=1; AJvYcCVbxtqydL1b2aZXlKDZO+F14kwEuflN0/6fevt5+aKwBNDgeyvxt+iN9W1Dz/yp8TtdxQDy7yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA14mDu4q+K8e5tjONKYuimNL6lpZBAkrYcYdeuAbrI85BFgn6
	xKlPx0H6UY1eBAqAlRMdNwPkWBldpv631bOEGj+Dx/MRCzh4JmxT28hQj/dGWdF3EqBWBoYm9rI
	Wf9lysIopm/+XCxCApE+nTQ==
X-Google-Smtp-Source: AGHT+IGZcxsDb0OZPKHVMFp2fk/r5ltq1LP9/dPoWC13s1iH1d515VWpf6ObJXBoJoyf8W7gxFYqOVhsXrSig9QYpw==
X-Received: from pgbbw35.prod.google.com ([2002:a05:6a02:4a3:b0:7fd:581a:dbd5])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b72f:b0:1e6:b2d7:4cf0 with SMTP id adf61e73a8af0-1eb215fb5d5mr1421010637.41.1737084059610;
 Thu, 16 Jan 2025 19:20:59 -0800 (PST)
Date: Fri, 17 Jan 2025 12:20:40 +0900
In-Reply-To: <20250117032041.28124-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250117032041.28124-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117032041.28124-2-yuyanghuang@google.com>
Subject: [PATCH RESEND iproute2-next 1/2] iproute2: expose anycast netlink
 constants in UAPI
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change adds the following anycast related netlink constants to
the UAPI:

* RTNLGRP_IPV6_ACADDR: Netlink multicast groups for IPv6 anycast address
  changes.
* RTM_NEWANYCAST and RTM_DELANYCAST: Netlink message types for
  anycast address additions and deletions.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
 include/uapi/linux/rtnetlink.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 478c9d83..6c652145 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -100,7 +100,11 @@ enum {
 	RTM_GETMULTICAST,
 #define RTM_GETMULTICAST RTM_GETMULTICAST
=20
-	RTM_GETANYCAST	=3D 62,
+	RTM_NEWANYCAST	=3D 60,
+#define RTM_NEWANYCAST RTM_NEWANYCAST
+	RTM_DELANYCAST,
+#define RTM_DELANYCAST RTM_DELANYCAST
+	RTM_GETANYCAST,
 #define RTM_GETANYCAST	RTM_GETANYCAST
=20
 	RTM_NEWNEIGHTBL	=3D 64,
@@ -781,6 +785,8 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
 	RTNLGRP_IPV6_MCADDR,
 #define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
+	RTNLGRP_IPV6_ACADDR,
+#define RTNLGRP_IPV6_ACADDR	RTNLGRP_IPV6_ACADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
--=20
2.48.0.rc2.279.g1de40edade-goog


