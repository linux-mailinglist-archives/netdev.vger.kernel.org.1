Return-Path: <netdev+bounces-153952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B575A9FA336
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 02:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3FA167232
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 01:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72334A31;
	Sun, 22 Dec 2024 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04EMcE9o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF628F4
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734829555; cv=none; b=ZaQyAs3WLw8gJ7Ru+arm80JzDJqD59Zw3uaKTQ/DfDZs6tatBuutfXJ3wB945zjQgk8eA2p78kaIsP+e+zjGsgirYcxfC6pwx9zL9vHwYzz/NX5NveB7BCnG1OhaGcJnJ738VXXCCcmi6t5YEVzPsie68R1fPBC5hQeQndbgVHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734829555; c=relaxed/simple;
	bh=ykHqtnrOUM43vFoKo0w69pPswU0xfasFdMqcpH0S+qI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RHj5L+yJsTVH9FjwtXP+oMxDIPZbCGJjCxVJSM3MUvFh0gHSk/uEG7uSm8eKzjjQ5Rv3+w6eyKW8DhkbznIYe2tqAY4JGOQ8tAxDYDpODjAYIzR317Iey0sp6ymKVdVaa6UYbEaSw1OsEfOBUAXt5mSCdaHAuMa6MplhbvIykYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=04EMcE9o; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so2756049a91.1
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 17:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734829553; x=1735434353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ci72wKlVPSJOABEt4uTAfJhgxKeP2GzBpC5K4QDLH3M=;
        b=04EMcE9ofLqw9+swxI71wWqK1rPwdXW4A7vHVSKwnEdXJWyewmSsSfeuz5lRHfSAaX
         m0u+f8mHJemTAl3l2hBJtBgyDyAsqDoxcHi8We1kNzAx695762ekFSwlZ0D4aufVfcyd
         bF9N6f3uh7UkkOlWyZg858fUj5L703eFuGUkFj9E1KVamXtjJGKFIiGiqr9T3wzrpph+
         DaG47+ZEOjSpt0oKF7Odn+6X1rRRZEWLcBA1U/w0+nkqL9EJpwgp9u64r7TtDUgYWnVC
         IH05dsCaFoLMzptj4mBAusfd6/44twcDrO63djWcziK1hxYbO1xhG6pL/Z0vzJmwajfi
         6Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734829553; x=1735434353;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci72wKlVPSJOABEt4uTAfJhgxKeP2GzBpC5K4QDLH3M=;
        b=h+kX/KaCv+P46JBrfJpsrr+O5n2zPVXfnD5EpXwr79OGjHR8qTNKKr3bmghT6fnyvd
         LTDBPE7heAYCUw+8oMOo1fgoD+a6ROGzbEjeVxXSPE2py3RSa4MsmdWm5ZP8uVEsZ/Qy
         OmlNy1CzEx3MPmJHoqIVgj5wA0VTWUqVPoBsoyHWrNHFhWB8moYeBKb52EDRmxNv6KGz
         FPg3d8VWtOUrGh/b6Ne/DQXKfjB6fK2GEyoUL8n8fDJ8p5N5nAZ9xtfFDpi0FBaoStOi
         +75wFRCK4B7TRpma3+Nn+jQFSAbMTNz5OK0RwbGMCUrIZJtfPEzYFZI1SdknmZ/Afb+C
         Y+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtAxmfUgYCSFv3EUfo4heWp08k1GN6foqfRlDMQbws9QzWghsXhFLKnTuRWrZp4Y6fWrrCtW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Ea5rfASTjuGb9hAshP5pSFpCFxvV540roIfMuk93214PDO6x
	n8DeMabNSUSkBzG5kbswWpZbtRBPsN1wxJ2nGde7bWuirzmF+P0kN6er/YODHW10LHuWB16ajj7
	XkBGYTUsIk+JNDqdE4LxsrQ==
X-Google-Smtp-Source: AGHT+IFifdA5nn3jegLimpEltuuCvJABgIT8Sry/mjioQhiOf6NIamBsa3NpjeQerEd0pONkvZ/McT3zdF5HP+FC5A==
X-Received: from pjj11.prod.google.com ([2002:a17:90b:554b:b0:2ef:6ef8:6567])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:54cb:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f452dfd2eamr12759602a91.7.1734829553613;
 Sat, 21 Dec 2024 17:05:53 -0800 (PST)
Date: Sun, 22 Dec 2024 10:05:47 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241222010548.2304540-1-yuyanghuang@google.com>
Subject: [PATCH iproute2-next 1/2] iproute2: expose anycast netlink constants
 in UAPI
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
index 458e5670..1d074add 100644
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
@@ -780,6 +784,8 @@ enum rtnetlink_groups {
 #define RTNLGRP_IPV4_MCADDR	RTNLGRP_IPV4_MCADDR
 	RTNLGRP_IPV6_MCADDR,
 #define RTNLGRP_IPV6_MCADDR	RTNLGRP_IPV6_MCADDR
+	RTNLGRP_IPV6_ACADDR,
+#define RTNLGRP_IPV6_ACADDR	RTNLGRP_IPV6_ACADDR
 	__RTNLGRP_MAX
 };
 #define RTNLGRP_MAX	(__RTNLGRP_MAX - 1)
--=20
2.47.1.613.gc27f4b7a9f-goog


