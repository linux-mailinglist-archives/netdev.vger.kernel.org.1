Return-Path: <netdev+bounces-173264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036EAA583FB
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D07D1891415
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18D192580;
	Sun,  9 Mar 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JrrE2pRo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C19211C
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522556; cv=none; b=g28+kfGdAEH+j2Y744dgUnqnPB3bwUvJRsJmlmFLUNtqCbFAnl4XJUgeTOEngUb+LNBul7kYX4zdrrZfRM3JaUNJOULAjIXYIxfO8AJeVQTuh4hksaxwk55R9G+qHKxtTcbIvUhvD8yQwLUSENESTGUWnz0zNNFNq3jOoibOge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522556; c=relaxed/simple;
	bh=tg28/9hanaFbrmazqnyGo9rUsvy3BxgiFLHrwpc0Hds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYkZ+/4chu7wYZfo7qeeuY6P3YdwIlmYgsB2hQ4FMwkIZusCJ6DCUUqH31kp65AdW2KsvpT4RaY2i/TJzCAjbpKSwpxnBa2+M8EpaOdAr24A5W9Uwm9TPVoXpbDyGDj2Q/Vt2c7R4gzkhC2T8/tGPVzDAvqyVzBumguQqkWmAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=JrrE2pRo; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9EE9B3F20F
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741522546;
	bh=7oajGXmwoZ14RjsiUyyOZit7FlCk8P+EMjDV4rSKNPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=JrrE2pRoMhQi3TRsECdhGqVEOXKImB+mOcHl97XzjHXBljwHPvLTZK3L7V/+w6m9W
	 lr+Yo3H+CjAy5dOcB4ZTbbNCtQqyEa2Rky+mawrnww0aQhsssu2T5t0DvA9vVwwyIe
	 nE43rSFXieXQ4qfLDUsVAr5KtxUv8A/HE7ilPN74/s2xxRPxVsY5a3PsixoGPHI7C+
	 zQRRyFYLTUPf+H2CpmBBcXI406ai4BMaJTefOOktaucmqKhSWrVWm0dvzpYfjiDLHh
	 OsYuGe9zm9E8Ozse4QZ3MWYd1A8V52+e/ZIwmeZtXWYJ9/xb8j4QkNCku0TNMUnTZ+
	 x79i8KwivjwwQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac27f00a8a5so65527966b.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 05:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741522546; x=1742127346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oajGXmwoZ14RjsiUyyOZit7FlCk8P+EMjDV4rSKNPI=;
        b=Mv3teVUBj9lXQ5IQkjMY3EjmmqHwdBCkWzeiSALaXqChpM5w2vjp5WH4za0dXYvzqH
         EosC/6LxQshmO+P7Y6rTbihyDb3s5qfsbBZuDI9aju4ghTQZIBb2RyTeMBVuaKlrslFB
         6ikymmz4G0r1fgNu5MpU8J03CBjK/eys0tLaoXoUYxzGeJZ6+NjO0dDpd9zbp4+PQ+3m
         O1jATjUw5hQRpAzLeltYyyFMy4h19fRqhTrCKbXJPN9c/eZQlvEppSRo3jDtIffhmIOB
         VnP9OAOZMgwWev1kbCEyCf5qudOhe5qZuJJ0B7mqgOf9bsvD2mYR+gew5fwbru+OqiVP
         9ERg==
X-Forwarded-Encrypted: i=1; AJvYcCWYYyrvi25MYWa/r/oaQfv1ZKp/cVuvnzEZf3365pKYiBbkAcaBtEtJzVMj3vnZoVik3GdIZwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEHS4Qz9n2j9Oc7yqXnf7k1tC+xBDDTDmVOoTHQH1oy+w51D0
	PzH5vOql86JC+WReyTAmbE/JrKRzceNOb8KegmoeYU4f028IFcHjH2b+veAcm3Vfv19pEkMYVbj
	F7fVxbuoWRPECqBM0HcbyjXsQJvReo/mur8M9iNnP2jL0oVHn0NTYZQ7OOTl99zrRDZGSiw==
X-Gm-Gg: ASbGncuTv30Kmhvko0TGGkZK4jYkey5PvKOItzqhEtPLrmIzOUNFmrdlrwVGf5U9A6M
	DBCiOeKGfK59V3X6uhL86cBvxnnP8Mka8OExg5g8C4cAriRcA7mPseUhfiwi+9ikVoFmpBQLKIR
	WKXi441qzq8y6GKGuJo5xlizT6stwweq8VVWYGsxxwtpPSr6Znhs6DLZ95U6/iuQPyvog4Fk4z6
	yzh7zU9lZBY3QcbxsiwgxuKRiskevRgQYzzomzlp+f2aKQ7lTFh/SgbkeiVd4daEmb63wUEFa5x
	yzxBu94vJ39OjUOhGYUR/m/YR0gvH+k22oQR4rqg6HkhlydATA==
X-Received: by 2002:a17:907:3f9b:b0:ac1:e332:b1f6 with SMTP id a640c23a62f3a-ac252102b70mr1161848166b.0.1741522546042;
        Sun, 09 Mar 2025 05:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+yHI6fDgActxSSCyVGaL5W4KOO55ngcP2uSoo0/npYO4T8MWeQ2E1aCzAa+KpyTjjPU5KmQ==
X-Received: by 2002:a17:907:3f9b:b0:ac1:e332:b1f6 with SMTP id a640c23a62f3a-ac252102b70mr1161846366b.0.1741522545691;
        Sun, 09 Mar 2025 05:15:45 -0700 (PDT)
Received: from localhost.localdomain ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac296998256sm69160066b.46.2025.03.09.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:15:45 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: edumazet@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
Date: Sun,  9 Mar 2025 13:15:24 +0100
Message-ID: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.

Accidentally found while working on another patchset.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index ffff554a5230..aa5016ff3d91 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -119,14 +119,31 @@
 
 #define SO_DETACH_REUSEPORT_BPF 68
 
+#define SO_PREFER_BUSY_POLL	69
+#define SO_BUSY_POLL_BUDGET	70
+
+#define SO_NETNS_COOKIE		71
+
+#define SO_BUF_LOCK		72
+
+#define SO_RESERVE_MEM		73
+
+#define SO_TXREHASH		74
+
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
-#define SCM_TS_OPT_ID		78
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED	80
+
+#define SCM_TS_OPT_ID		81
 
-#define SO_RCVPRIORITY		79
+#define SO_RCVPRIORITY		82
 
 #if !defined(__KERNEL__)
 
-- 
2.43.0


