Return-Path: <netdev+bounces-174831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1EFA60E36
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1AE1B608E6
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146141F2B8E;
	Fri, 14 Mar 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tWGlkfz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F21F2BB8
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946866; cv=none; b=sm77xqGLJqrBvL19yhYrrCuXuh7+McKlIDq8toHC4p79o7Me6w86dlAiUP1WK05BVyWUv1A0UlGgNsChuZUQ4de2OhuvioNBjTHAaNdIuwDI1Hd9Pm2I+SiNLo7hzAkPuX+jBy1y7L5SgsyTIXcQZJk2Vn4FC0rxjrXOQMiAnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946866; c=relaxed/simple;
	bh=8HKls/vyB5Nb7yFTUbMYOUr3j4jvqnSvKpBCWy4txP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d0mIIN6VIssWIbWoVcqKbhwtBZHj7f2YnD3c073GC+caOMdY3Rap1ldV1fx3c4j3GWzAQr07qY8JKxcCqMkx5Y4vf2XLP/B3CLrt9WQLO89C9BkkbPaBt7+gioamPGiqfXB228sCWXPhgX/5Qp33GRQzeRnmwztMOEjFbE/Nq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tWGlkfz+; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so5585232a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741946861; x=1742551661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cfffNHYI49Xl5zPC144OdkSFN9wBx2U8lL7yj9iYGbU=;
        b=tWGlkfz+aKHcGrOBwYwQh76H2PcpjJhP/ObQ3hq6L4MWncxEJYXtMMEeAgnDXpRo/C
         t3oFhCdhFHrnSHsIjzxt2JibUJy76l+6x5RnOl0uGNcgjFKj26d+1QkLbipeOCsIez21
         V4kTFUabxYawT0MdFcYgYL3mTVBOMIhSKwAIJtJs1zNL++MEMhyjW80nlIyet3+261ru
         8Mb8RiNLWWEqkvCy6emCYeVEe3f3pL3dqisvABKSymIdvyZ33hTiv7LZO6Rw3ryDgfnD
         trBH5EhR1seGJb69tCeDwW9JmuBo7LS3XrpAWkQJAlgUEYTg1zX/ZG4x67dJtg6l8NkL
         cQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946861; x=1742551661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfffNHYI49Xl5zPC144OdkSFN9wBx2U8lL7yj9iYGbU=;
        b=s07E+aHEeN7wnBFowbf63ilb9CrTVmdHmolAWmU+8kKlabpEVVmERihZpaEsmQkLlQ
         VuBNGATGqIUtozA3fFQ9E5MWkL1zk1YZofpv389nSoVAlWMGVCFcnleWp3pjofJWXGeW
         r+bpSjZrwOnMED/YY2ehLGveRZE1zKTLvuHrVpQtNnTxVup7aPn1VYY8mujCC3zjS2ry
         HkMPdR8z30hxAmBlqBuhVPZHtvqGDYH9G9QKy1lckcHzAk++FHy7uCXbQeMgPa8m5yTp
         y1RMniyAqx1xlOXJV5geBfPnL1oeUQUO6sNqIqEuZXqXM0wpF681z8yZIQICfvgkQfoM
         5P4Q==
X-Gm-Message-State: AOJu0YyGyw3+edlB6CFGxEQRp/4Q4WArIFiORR6Z5FPsc8xFnFIZnkJw
	IChYn97XRAVFi3MlbiVmLe1NVdmuA5rj8oPKSxXf38/qaQhr1vqC1IMC7/Hw+o8sU0Nh+6XCQzo
	1ob8AKziv
X-Gm-Gg: ASbGncuc10FoG8xYj1aTCy9BdjTjh5DH11zwqR71nspAq2jjxJLpMJTHKthupO0719L
	KM5qTAYIHxF9Zj4Djp2XtISdcS8FgcJJuAcrq8vqQBdjmEWZRBCrlkkEWUUVhKFXWOwt7eGIczc
	Ct8zsIGQrEM8LsBkKW/IFB2sdkcc8HHsprRduXbJiR9mLZfITYiWrysl8+RIyt3G4jqCehlbfkO
	sqKFD1LpJ0XmqHi6v53xVr6LYncGc0YmC+i2RLa3ioQVjWT24WzER3A+NHcH1rcOzX7HoAdBYKR
	uUI2yrP78B1UBdhA6pDQcyZoBtTt9qBVD6Q=
X-Google-Smtp-Source: AGHT+IGwUZoSMFSvs6YN2fIDJa6ZdB6rTlqmRL2w5zcN20nZYYMiUFmpXajVLtXPMDz24Mri2X0QDw==
X-Received: by 2002:a05:6402:1ecc:b0:5e0:6e6c:e2b5 with SMTP id 4fb4d7f45d1cf-5e814dedc7dmr6711949a12.9.1741946860969;
        Fri, 14 Mar 2025 03:07:40 -0700 (PDT)
Received: from dev.. ([195.29.209.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe26bsm1770804a12.72.2025.03.14.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:07:40 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	idosch@idosch.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next] MAINTAINERS: update bridge entry
Date: Fri, 14 Mar 2025 12:06:31 +0200
Message-ID: <20250314100631.40999-1-razor@blackwall.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
step up and co-maintain the bridge with me. He has been very helpful in
bridge patch reviews and has contributed a lot to the bridge over the
years. Add an entry for Roopa to CREDITS and also add bridge's headers
to its MAINTAINERS entry.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 53d11a46fd69..d71d42c30044 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3233,6 +3233,10 @@ N: Rui Prior
 E: rprior@inescn.pt
 D: ATM device driver for NICStAR based cards
 
+N: Roopa Prabhu
+E: roopa@nvidia.com
+D: Bridge co-maintainer, vxlan and networking contributor
+
 N: Stefan Probst
 E: sp@caldera.de
 D: The Linux Support Team Erlangen, 1993-97
diff --git a/MAINTAINERS b/MAINTAINERS
index 241ca9e260a2..3169b1e3f006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8590,12 +8590,14 @@ F:	Documentation/networking/devlink/etas_es58x.rst
 F:	drivers/net/can/usb/etas_es58x/
 
 ETHERNET BRIDGE
-M:	Roopa Prabhu <roopa@nvidia.com>
 M:	Nikolay Aleksandrov <razor@blackwall.org>
+M:	Ido Schimmel <idosch@nvidia.com>
 L:	bridge@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.linuxfoundation.org/en/Net:Bridge
+F:	include/linux/if_bridge.h
+F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
-- 
2.48.1


