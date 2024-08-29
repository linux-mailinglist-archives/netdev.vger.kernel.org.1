Return-Path: <netdev+bounces-123513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C89965248
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746411C24581
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DE1BAEDE;
	Thu, 29 Aug 2024 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbyLuGiy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517F14B949;
	Thu, 29 Aug 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968123; cv=none; b=QlazMBo9A5pjmrC7WGv8hdOflGNyCnKYYPWWlVELoK5AgFNz5cEMXNX7k8oJMBbYlfA/nyk1WfHIpNgHkTEDpJSZJOOb57uapXa1kv3CPd0/ZVu+2w9PoZ58i5WTBjc/t4CYcjKhqv5nohxJG3gZcj90ZTuKlo7aJWXaQ8XRgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968123; c=relaxed/simple;
	bh=2Z/PqP4sbWzkhpb9e3kg/1CiXGRJONT2WYqdf5/n7eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8BlhBuIuQE/mTqzcyjvfodRdCl0LGGDTgCZdBRjix1vc+Fu/jXKDRNlyXciBnJPrhRIIepUC+2SJWpz72aVA3g47aphMXD45stiCac44GC3lqy48AdUV7hjACVxRaYmO6BffozuBlSFd6xtyjA1+Av7JTGsvAjVg6Dl5deoQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbyLuGiy; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5dca9cc71b2so658171eaf.2;
        Thu, 29 Aug 2024 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968121; x=1725572921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3eESsElB7GvWhyi8B4HAOuCsvVymEaPvXQjfpmPGj8=;
        b=NbyLuGiy2XebV1RW6nZ0qSgAo2AbiM/8fYyuSntT34aO9pkF3X2+gUHVz7yVv7PUyt
         jmLYSB9HVXjvPZibJnLD5pKXv7SsLxmKspV54re8wShDo0qJBCyZvu3GqnYki1bxJK/s
         z5eVBe+SfM2VrW5rl4UBIHK+FXZIYPudAhfnWoCQ0rE0YnYr97pXYhv/x0T6qo0EHHOa
         SFbEAm422I+B7KEGgQL9TFGDLa1m65fpwu+0P6ns45By95Jgs/T2arSFlMXEQEXmF/Ol
         EJ7KKpI4/pBs7L/z/0LfY+WqjB0yejCF3ivLsrmrahcvr7XVuE5HjzPQlmMbk/5pd9ww
         hSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968121; x=1725572921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3eESsElB7GvWhyi8B4HAOuCsvVymEaPvXQjfpmPGj8=;
        b=SJMLtaEklteG4oWJfy21yvQ0+cA+Hn930KwW5XZLLJHJ0s1ZeM/l9qO6DflUcavA5d
         BOhA7SJIySMTxEp3NLJyEXOMVl0Xs5CuIHijyw3OXSaWsLhAMzal2wg0GOxaQDkbkSm3
         I8n3TE9lXB+I9hDg81s8O4qGYvDfZxAPwJ1hcm9L64tx8Wa0/6YbIzGafh0lOTGopFoF
         BcXdaRyJ+JgcLOlIKOZJnOaP2/euOTFkWHmyTB2y9Z32CtguJKRmZTSP/w7GVCMrGnx9
         bR777FOH+uaz27dP0cZi23yy41mIplcJZCjeZYW+4WpE2qI71O+XC+8eVMbmMWuFIWu7
         NPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPJG8ft8AVfNQszxTBEA/0TiNVE1kpU6n0Deej+j/v2KogAxnYOpuYwNeho5xAVQqxqz7h9SLGI+1TyIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJGjTDbFRsTxliS0ChW+g7W5YvtnXP1A+ee/3zx4F8UyKAytJ
	71fprrqNEXN4aokdmBnljD56YUqCuPP47qg4fVoSjbU/3MX3zSp7zOOKqwR8
X-Google-Smtp-Source: AGHT+IHaNrCZk/pnHHwfjof7JObkw2sbhj2DbwLzhh24MXvS6NmUtg+C93m/DAGMw5mI5TrtbvLjnw==
X-Received: by 2002:a05:6358:78a:b0:1ac:671a:f39f with SMTP id e5c5f4694b2df-1b603c14850mr489979255d.11.1724968121351;
        Thu, 29 Aug 2024 14:48:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 1/6] net: ag71xx: add COMPILE_TEST to test compilation
Date: Thu, 29 Aug 2024 14:48:20 -0700
Message-ID: <20240829214838.2235031-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829214838.2235031-1-rosenp@gmail.com>
References: <20240829214838.2235031-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this driver is meant for MIPS only, it can be compiled on x86 just
fine. Remove pointless parentheses while at it.

Enables CI building of this driver.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/Kconfig b/drivers/net/ethernet/atheros/Kconfig
index 482c58c4c584..03b31bedc9a5 100644
--- a/drivers/net/ethernet/atheros/Kconfig
+++ b/drivers/net/ethernet/atheros/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_ATHEROS
 	bool "Atheros devices"
 	default y
-	depends on (PCI || ATH79)
+	depends on PCI || ATH79 || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -19,7 +19,7 @@ if NET_VENDOR_ATHEROS
 
 config AG71XX
 	tristate "Atheros AR7XXX/AR9XXX built-in ethernet mac support"
-	depends on ATH79
+	depends on ATH79 || COMPILE_TEST
 	select PHYLINK
 	imply NET_SELFTESTS
 	help
-- 
2.46.0


