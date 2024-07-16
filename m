Return-Path: <netdev+bounces-111646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E7B931EAB
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 04:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06A0B21B28
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A896AB6;
	Tue, 16 Jul 2024 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VbjOiXpA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFB15EA6
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721095758; cv=none; b=N47p5+7F5h3A9pPKHJkd2uKGXBMYxm4uCk+kdDHjCwJiR3yKqErgyGXO9ajU6ZdzlUx1g6sYrV6TZEgchh6ASvpbI85thU2VmKDCnIJUDAh8IXfH5q7cV0OGkHBPCp8L6D2b8o+gBHTSwpNQj3ur6gmPZAS9nzs0cuKFmKjZcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721095758; c=relaxed/simple;
	bh=EQ/d8foBBq+VS6MAD20sgr2c0XaxLAxViHNN0/fGEYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XewNqyX/zS0yYUvH9dPKxuevUBOY1c1ndxYRp2ou3gW9/9gES4Ja2W93Sr+awuRDKix1L6kiqDjVwBBDX3PPNx0RlNDRWQglsiTTsWnNHBwc/Z/CHyM2+pdoOr2D/bJzf/jJWccpbVlQDIzzVKbxWwrFsKxHV+HRBczO9hkp+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbjOiXpA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721095755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIknwgt3WZbEYtW7Oa6ppzhHIFfrnlWcfMVY2Y/ohwA=;
	b=VbjOiXpAnY+ijz5HNqN6AgMkQ6HKSCfoT/6xcJrhEJGJ+b2qDGuyVT9s5cWO1CKHWF9bWb
	7XDUjqVdQ89qFWqFxy7lD/DN2EVwl4kvzTShhsUuI2G/r4A1MuzHm7/IFbYIWSLHS8Cz+1
	CzpEpzz7PELZ0fonLeXeOETeGRn6TvU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-dRm0eYBdPOiJk9SlBXtONw-1; Mon, 15 Jul 2024 22:09:13 -0400
X-MC-Unique: dRm0eYBdPOiJk9SlBXtONw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-70377dcee38so5310425a34.3
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721095753; x=1721700553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIknwgt3WZbEYtW7Oa6ppzhHIFfrnlWcfMVY2Y/ohwA=;
        b=Ac1MDYvSjQA1qFn/SWmL/b5TtB1pdyS59zgMvt0ypYdVh+9/GJUnZ5vZqozChiq/6j
         0TL3AhVJlTVl87IRIqBT40/VWU5+Xr6l40AIjGFgO18/+V7EDPEgVOu0vZq4E5PZE/4w
         wpraIyUbY6Q+JjDSgzaV1toOwQ8wtADm3DVeoMK5N52erw7M22EMa0akuDy5sLtfx44V
         8Pwf8D+XD08DzPWk3DXD878jUszo7YLYmzuoBXUJ+zdZmm123zNvYWydJCCOUqGprv/C
         07WZARxehSTN/Z2w5yMoKb4ESIZxbQ/6vp3Zj0NCTTBGe2RAew6vcZKYfIfa3dcdJ2GL
         Kw8Q==
X-Gm-Message-State: AOJu0YyWL0K8Tx9hbK9luikjWNJPQDEKReC35i3ShGtFLZd0/sV52zWA
	ulbBtCx9IJj1/cJuBGegJZqOTC6ZvDCjSdUpv5JdNjqICW1ryuJEZ5x7r5ukzz8ImGQB4Dc6II6
	6kCCxUP6mAY6gq8GSMwDjU6RuQAvF8eh7vKEWn1qwYTRMDc9ZAwHFeg==
X-Received: by 2002:a05:6358:7f13:b0:1aa:b152:c7c5 with SMTP id e5c5f4694b2df-1ac90338671mr91429455d.12.1721095753235;
        Mon, 15 Jul 2024 19:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHToJBzDqTy+m/P9dKtcdi5ezAE80yB7IO9O8c7H/EXRfieHW2SvVSBvvIDE4/q1oonAXV+Zg==
X-Received: by 2002:a05:6358:7f13:b0:1aa:b152:c7c5 with SMTP id e5c5f4694b2df-1ac90338671mr91427855d.12.1721095752939;
        Mon, 15 Jul 2024 19:09:12 -0700 (PDT)
Received: from ryzen.local ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd3e4c24sm7088932a91.21.2024.07.15.19.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 19:09:12 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] tipc: Return non-zero value from tipc_udp_addr2str() on error
Date: Tue, 16 Jul 2024 11:09:05 +0900
Message-ID: <20240716020905.291388-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tipc_udp_addr2str() should return non-zero value if the UDP media
address is invalid. Otherwise, a buffer overflow access can occur in
tipc_media_addr_printf(). Fix this by returning 1 on an invalid UDP
media address.

Fixes: d0f91938bede ("tipc: add ip/udp media type")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/udp_media.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b849a3d133a0..439f75539977 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -135,8 +135,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
 		snprintf(buf, size, "%pI4:%u", &ua->ipv4, ntohs(ua->port));
 	else if (ntohs(ua->proto) == ETH_P_IPV6)
 		snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
-	else
+	else {
 		pr_err("Invalid UDP media address\n");
+		return 1;
+	}
+
 	return 0;
 }
 
-- 
2.45.2


