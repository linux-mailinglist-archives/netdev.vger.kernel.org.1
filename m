Return-Path: <netdev+bounces-183353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3EA907BF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59DB5A1876
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BEC20DD42;
	Wed, 16 Apr 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkArxdwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04C20DD7E
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817337; cv=none; b=DEnOUVEw9Pm2GlszkT9LCrdRrTf1rw8CZlgUzA+IFvkh0kkVNk7ptGUjScuIPiJydty6wtIwq/ByVtKI6PY/ysTI3XLePK3OfCy/2bAGvFywKcMLsgq2JwRitF5pao8Hx1/oJnTzMP/O1DrNfM2iGiUWpo4Kt+7biSpKy2xCnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817337; c=relaxed/simple;
	bh=joTiQadMm/fKwVonH08uwRfHQB7B5N+dtEcPIwzpxi0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFlxD1p/vrFHKwSi/fMZFrqzkYP2wUSnmjRqeK7bKRMycerRDkLTL8hAn1AiYGGLPvK3WkQ8htBA1rm/t/37MrAZ7RKwkrovqlqY/Wjk9t3u899wB6FXD+hV0FwgIKtQ8iZmJmNrC3esT4JZj5dLAUADamelNltO3jsYn7QAA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkArxdwr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736e52948ebso7963238b3a.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744817335; x=1745422135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqWXTqWgCVDPGe+5NTCx/6JeOXpwSyATZnQsdQbR9E4=;
        b=YkArxdwrcmiuEbtbrn0Ad9Ix7sd7XoBKi+TU5RRJ/WQ+HXD+PuCcq2MT+3bjHdh+oA
         CtAvA3TPyxD5SbW30+UWVAC1+/13o5eQ0obnCKAirybn3BjR4KJo3z/96Bn+0WUw62cm
         eVGUt2nReEB4yPoIm5Pq0XWhR2zWoRHG5cEthNE6CBUfP4ymoQbbR4pZ8b9FMHU2kQHb
         SKLYKIk2lXeINcO/8Lvqi7ieo+Fnf0OcVouPv4U40zx1gpfvnn+hn+5BvjEUVmwPoDL3
         0jwZ1VZSbjPknzLYlAlT2IxhkGKsufQL1iocuFrp7RqQT0Kt/tkyiGMv/COt4XyS6Yr8
         VsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817335; x=1745422135;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqWXTqWgCVDPGe+5NTCx/6JeOXpwSyATZnQsdQbR9E4=;
        b=f4yp2/YOWJtBcHfh1TmlSvvDd88NclItkg34YSM39CEHDuJxa7TErLmbqLHI3JZ4Oh
         bcObdc08n4BK3GU7laIviyaTNOcELZRz/3yEtbdmwLtre5aNef3MWsiHI86zX3I3F1Hv
         q5u2P6sxksKa6FWC3T0Qv5J27v9KCXQBNTkysLivA3h7ozHtGnNKKE2bjYgP8APvkvv1
         i9L7LR4cC8f4519MmeAYf9MmnXkxSNRLQH9hF41jNKWU3zwz2drNZ4jUwNdVS5CgaeYn
         WsfKVpbCLr9mTcUHLEm+XZBtA+rGbvIlXZY2TluILAb/paSHSSJtoAWzY3bAQqsOjHhR
         mh4A==
X-Gm-Message-State: AOJu0YyjH2YN1d8P7MZJ0oxNduWxGtPcGhsHwlfLi3RSPLL/+xKnFMPt
	aN+6MZ0iJiRupe8f4Cphzje8KEy1nUoPgc7eb6oBBVC81Ddt0BzN
X-Gm-Gg: ASbGncu/b3ak7Tm4gdBG8tA8Vnbx7q5Dob2fYco8odtlXh2JzZbyGVMW9vrodLo2elg
	9PaWz5QgFbsQjAkza9oqYoiZqlnaB6hd/lCp8TC/vbBYv37mxp25suF1MIdjsrF/INp1br+zUhH
	8n6D0GIaQaJ/u6kggbDdx3lBWWJWoPD4xdLIvnpL91sa2Ua/zKAerSbV2GIajt6Vlk1HfKAhP8Q
	sUvsA3kLs3Yvuo3xe6X6o3rauiNT0SW7nkfnigNertSiMyKuI3Itz0re9BLPHXj+OG1e6Hzlui5
	jzajzp6s67mPSgbhid/cCLVDUy17LZUBSpuMXOA4j07El96E1QJFOgXh2Q1Hq4cG6qI/aL1sOTQ
	=
X-Google-Smtp-Source: AGHT+IE6VKQ6w1DlQktcswo0TOSy33wR5gvnKoHL0AV7DsgIMKFqcaLnENKpWevRsiNWNlM5SIFINw==
X-Received: by 2002:a05:6a00:4516:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-73c26700592mr3981308b3a.8.1744817334929;
        Wed, 16 Apr 2025 08:28:54 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230de19sm10518990b3a.124.2025.04.16.08.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 08:28:54 -0700 (PDT)
Subject: [net-next PATCH 1/2] net: phylink: Drop unused defines for
 SUPPORTED/ADVERTISED_INTERFACES
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 16 Apr 2025 08:28:53 -0700
Message-ID: 
 <174481733345.986682.8252879138577629245.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174481691693.986682.7535952762130777433.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The defines for SUPPORTED_INTERFACES and ADVERTISED_INTERFACES both appear
to be unused. I couldn't find anything that actually references them in the
original diff that added them and it seems like they have persisted despite
using deprecated defines that aren't supposed to be used as per the
ethtool.h header that defines the bits they are composed of.

Since they are unused, and not supposed to be used anymore I am just
dropping the lines of code since they seem to just be occupying space.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phylink.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index b68369e2342b..942ce114dabd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -24,13 +24,6 @@
 #include "sfp.h"
 #include "swphy.h"
 
-#define SUPPORTED_INTERFACES \
-	(SUPPORTED_TP | SUPPORTED_MII | SUPPORTED_FIBRE | \
-	 SUPPORTED_BNC | SUPPORTED_AUI | SUPPORTED_Backplane)
-#define ADVERTISED_INTERFACES \
-	(ADVERTISED_TP | ADVERTISED_MII | ADVERTISED_FIBRE | \
-	 ADVERTISED_BNC | ADVERTISED_AUI | ADVERTISED_Backplane)
-
 enum {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,



