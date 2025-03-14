Return-Path: <netdev+bounces-174993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F069A61F62
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 22:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223C27AFF6C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616CA204C0A;
	Fri, 14 Mar 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ISErfzVy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02520485B
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988542; cv=none; b=aDDIjGEKSJYJu0yUy8c9aCYSAihww2NC5mW2XQ8gCA3JjG58A5pPfXGlu3YBfL6l9TlKX0MzB/IjZ9QyIrUt58b5nRga326O731j6ZqksA81zOOV45ljzm62fasH2PSpjdmLNXGJFr3LxD2L+vYfsk+kgF98xczh9Ydpn5tCHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988542; c=relaxed/simple;
	bh=uGg8JXJSXC6XUKko3vtFo3VClaWGJcePp4VmFBAeI6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TL3eUqOTqoHvoZdy/PLptfRPE3GloFm+sp4pYCZIQzEOocfLJS5BZ5APlRN74zUnIVQJgyFa33XL1JAQcCvFque5z93IHXtRrr3OlxTlHoPKG4N7aK2mXNBksvZhV0Tj2OZMP/HaphM9FLSMCB3or5/BiG3mfro/BhXuXgwMoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ISErfzVy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1577B3F342
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 21:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741988536;
	bh=lY70/mS/r8Et37CQTVQ0HZOmZvOsgWjqVKwtQtIRegA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ISErfzVywVcSsK3jZpsFRi/nCanVFBQCqGJm1Lpt6+XoE6c2WkUXyCT/2xKx5W44v
	 5Gp3AfNnFwyFZggxTTcicnByu8B1Pn+pON+p3Bit1YRg0Uz4gqS3IYhZnu3nNH08Yf
	 5VwQlZz64Q2BEZ6+4zdYwAASvBg2XxgKmgE4TgrnxExvHkoF0DP1G3aay5iM7g/UOq
	 7SYXLWPolIuAFZQvkJ/WdkWWcJwtINNcIp74xsN2bXQNqBhV3IbbxPswYMGIBKD3ol
	 ry3MQt1xx6Dp3Jy1P0+ZyZ3Sg1pm7q9hnD4DEz07DJgLKu9DjJJlu29d69a6XhSk6K
	 Ao2nMMRkyDIag==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac29ae0b2fbso250847866b.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 14:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988533; x=1742593333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY70/mS/r8Et37CQTVQ0HZOmZvOsgWjqVKwtQtIRegA=;
        b=dMXIFiVZGYWDxHND15KswKj4kdcLk2FBJAksQhI2NKSIw9sKUvr/fi2TjKnx9ihBpP
         2BVA+75ia7ArcWNvoOLs5nYjy/zJMI3QrSbQEADvQZ2fQzopJGdC5mVj+mTbGl6RZwIW
         UZi8N80I8rYry2+qgp1voSs6aF2ZFM7gd6Kp0a92Iget+nYha3W2Lj8CIkK4u3qIXVw0
         76zmDAZwk8oxxvLciW/In1RKPixZBBig5HYURUXbtVvnW9HKIqyln2TPt2Zh7d1IyqLi
         psFW5WbwyHWrzDS7Gtp8BNkvSPiBpdYjy49leOgGTw9Av29/xR5QtaYln6ujtU8ndrRw
         2WWw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9K9vWvaEeKQWjsQSYki5Fb/+FYGMsvxSfa6jzhwk/BCZ/CYa5YpB+slyVzX5vrI0XKLN82M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd/1jBO7guPkB9EcvW9/UDeslU+IDmpJLDxP9An91SSQrRgCF6
	UQqWjQnr8VZPSMeTzcfiDa1T2Risyj+KsIKThCJfZnBt5CO5LZA5fiP3PictVRvEt6TgVPO28eK
	rAXsH/Ej0t3eiv3BzcIKjhbyrTnUYJTixMIAg3ay8IHzDUEihyzxso+TYPlB+Knm6rUjo1g==
X-Gm-Gg: ASbGncv+CebM5waDbhYxE+eUGVRdNRFkdmrm7gsnBMlbDd52bx5RM3Vbd3ZzE1JgxBd
	9zN7Db7j03u9LgVobdAyIZ4zkfOO2JI61aI5EFd0s+GB90Dr7x2HD7Y+S/yQrrjNNhqcVlFlry9
	M/tnEv5p1O8mdZbsEYvPMkz0sTIn6Yf6fV0APQtjqUgT/HseQUyu7KHbn6QwkgXlGLQgXgzXccu
	n6mXigFotGDamfpRZPNzsgP3XqgdiKviIMvF+Cpak0i8b+AD2joB+VNJfVdLtdppBFKSgMTGweo
	0sa/P0GcnGtrm00yOQYscXIC7uVWm8z96AqScARPM674f+TlqA==
X-Received: by 2002:a17:907:2ce3:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac33041a398mr452869966b.51.1741988532712;
        Fri, 14 Mar 2025 14:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYZ/shXBTmdAZ4tudDMccFXpts+ICQBG5lI5HLvE8Waomrj9sbmxYGzKr+xsBq7Krj4ozlDQ==
X-Received: by 2002:a17:907:2ce3:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac33041a398mr452867966b.51.1741988532379;
        Fri, 14 Mar 2025 14:42:12 -0700 (PDT)
Received: from localhost.localdomain ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6083sm272732866b.182.2025.03.14.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:42:11 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
Date: Fri, 14 Mar 2025 22:41:54 +0100
Message-ID: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
Link: https://lore.kernel.org/netdev/20250314195257.34854-1-kuniyu@amazon.com/
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


