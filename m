Return-Path: <netdev+bounces-117794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6794F59F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB208282E98
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A32187FEF;
	Mon, 12 Aug 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHaE/tvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1B187343;
	Mon, 12 Aug 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482561; cv=none; b=ZNx2z7+3WXbomgHfBpMFYA18pjITNQJBOeLJItyvPEM2che3BnJGYFTbTqnKzBDZ+RaFLpsHMssfgDtSFkAJ2/n7djDLrPoFYVf9BOYTgwZ0t2TMiIc1XW7F0Wz/Q6pL/qxGNMFnrIVfzpJPsYOWogRsLM5Eipva8jYCk6vqe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482561; c=relaxed/simple;
	bh=0MQX7ArPk4mAV4iN9yEqbL0u20EthjGUcGLNVJxyVtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=awGnEprKftSfSh3h1oBE+oL6ccsU6QKGI+m5KfKl7YZiMQOdZ4UhKEZnwyu4SPTV+ZK3tT81DPpD4lMAVg2mhhlQVdd4XZnLwEKyQCyvXy9AERqM1725vqJR2fmKGSQBPmDTlBk3HTGODyJ1qW6QP7PHqaUHceYvjxwR3rFjXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHaE/tvI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1c655141so3275274b3a.1;
        Mon, 12 Aug 2024 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482559; x=1724087359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t05NaBT7bFxhrNH1lXOVprHE6cItR2aJz1lL9AZNeks=;
        b=KHaE/tvIpXHFuJmzla6vrHJTZMag9bApJpduxx/sdUZuH5z0LNJnPF9Syw+JtGzNiS
         qLtWjMFr2DLaZ/zWAw7jzDHf6EB2LKmOltATEtjvPP3CF/lh0gcr2C8JLwjrpqNPfY9t
         OalFXNUUMCIc34EuJq6EY5N3Xg+l5Mzv6K12Tzj09Qy0N7G4t5DMO/ViQO7Rdmf+D3p/
         PXER3LvPFIQKwyzLPMnikoGlzijyoSIcsmF/wCxzTebDb5jsAOCpdNT6eje+fs8W2MNj
         jqg1yTnDzUo6GAXi1NJpAtNZDi0sLePal2mEz+gyqBndlkzQtu6RxtcBRhxWZut4GtmY
         KARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482559; x=1724087359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t05NaBT7bFxhrNH1lXOVprHE6cItR2aJz1lL9AZNeks=;
        b=nvjl0FsmSCBDxwvNEG1U3RmFR03xZDHi50l/ObbZj32eBzDTub9DRLpMt3bnuDP7tB
         7YGfcR98rfYGdm+FMyf4X6C5FNchQWBqX5TqHgu2ON/tWEGhHlWiVPRsFbb0LzhCQiwL
         4X2quVFxfTtmCzL5pMqQWreQQjalh4cFozq1w7N95G8g0zpii25umk/RFgaqLvSZC17j
         VsORP7fX/NjYX2ft/p9g3vQQScFfPA+AsM8wwRtnaLTzWgQUEfr/A8DKpy0GMX6Ly3Dj
         MdUhDrjcGjHfzrnvdT5fhmiyQcEm4MxwUajfmmwvw0QhionMU5WOk92x2AlHWzj1NhLA
         PwKA==
X-Forwarded-Encrypted: i=1; AJvYcCUonXD8IshBbtpq0fOyxYsCcr+/P0TqOTQkL8+HmdvQUIaIhIhwzU987/udCxViOPYDXLNbgMtKu03ayyjOF9/aIpP+h5LCsUMO/gwur/4VjHH0lsiBWCoo9ZeszHzpslpLyL9u2ibkx2xGIyu5w9kusUtiaz64y1BedMkFSO4Z
X-Gm-Message-State: AOJu0YwPFmM8VaPMczHj6e1SlfTJZls68LfTWMK3wJD44EV+J9U2OPl2
	P/s/dDkht1lnis8ueV1ch/Z/unnpJOlXLhCr980uYNN2PqVU9ASm
X-Google-Smtp-Source: AGHT+IFdGC6guWLvF4TTcjvzGJhWOlSp6tMM3/62nMpRD4XNdu5tUKIiuxEY4mXAiijdjKX7ZB7kxw==
X-Received: by 2002:a17:902:da85:b0:1fa:2401:be7d with SMTP id d9443c01a7336-201ca122751mr12138855ad.8.1723482559480;
        Mon, 12 Aug 2024 10:09:19 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e4d9-f7d4-34a5-a177-48aa-18c9.emome-ip6.hinet.net. [2001:b400:e4d9:f7d4:34a5:a177:48aa:18c9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb5b004sm40341425ad.304.2024.08.12.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:09:19 -0700 (PDT)
From: Jing-Ping Jan <zoo868e@gmail.com>
To: horms@kernel.org
Cc: corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	zoo868e@gmail.com
Subject: [PATCH v2] Documentation: networking: correct spelling
Date: Tue, 13 Aug 2024 01:09:10 +0800
Message-Id: <20240812170910.5760-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240811134453.GJ1951@kernel.org>
References: <20240811134453.GJ1951@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling problems for Documentation/networking/ as reported
by ispell.

Signed-off-by: Jing-Ping Jan <zoo868e@gmail.com>
---
Thank you Simon, for the review.
Changes in v2: corrected the grammer and added the missing spaces before
each '('.

 Documentation/networking/ethtool-netlink.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d5f246aceb9f..4acde99e405e 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -934,18 +934,18 @@ Request contents:
   ====================================  ======  ===========================
 
 Kernel checks that requested ring sizes do not exceed limits reported by
-driver. Driver may impose additional constraints and may not suspport all
+driver. Driver may impose additional constraints and may not support all
 attributes.
 
 
 ``ETHTOOL_A_RINGS_CQE_SIZE`` specifies the completion queue event size.
-Completion queue events(CQE) are the events posted by NIC to indicate the
-completion status of a packet when the packet is sent(like send success or
-error) or received(like pointers to packet fragments). The CQE size parameter
+Completion queue events (CQE) are the events posted by NIC to indicate the
+completion status of a packet when the packet is sent (like send success or
+error) or received (like pointers to packet fragments). The CQE size parameter
 enables to modify the CQE size other than default size if NIC supports it.
-A bigger CQE can have more receive buffer pointers inturn NIC can transfer
-a bigger frame from wire. Based on the NIC hardware, the overall completion
-queue size can be adjusted in the driver if CQE size is modified.
+A bigger CQE can have more receive buffer pointers, and in turn the NIC can
+transfer a bigger frame from wire. Based on the NIC hardware, the overall
+completion queue size can be adjusted in the driver if CQE size is modified.
 
 CHANNELS_GET
 ============
@@ -989,7 +989,7 @@ Request contents:
   =====================================  ======  ==========================
 
 Kernel checks that requested channel counts do not exceed limits reported by
-driver. Driver may impose additional constraints and may not suspport all
+driver. Driver may impose additional constraints and may not support all
 attributes.
 
 
@@ -1927,7 +1927,7 @@ When set, the optional ``ETHTOOL_A_PLCA_VERSION`` attribute indicates which
 standard and version the PLCA management interface complies to. When not set,
 the interface is vendor-specific and (possibly) supplied by the driver.
 The OPEN Alliance SIG specifies a standard register map for 10BASE-T1S PHYs
-embedding the PLCA Reconcialiation Sublayer. See "10BASE-T1S PLCA Management
+embedding the PLCA Reconciliation Sublayer. See "10BASE-T1S PLCA Management
 Registers" at https://www.opensig.org/about/specifications/.
 
 When set, the optional ``ETHTOOL_A_PLCA_ENABLED`` attribute indicates the
@@ -1989,7 +1989,7 @@ Request contents:
   ``ETHTOOL_A_PLCA_ENABLED``              u8      PLCA Admin State
   ``ETHTOOL_A_PLCA_NODE_ID``              u8      PLCA unique local node ID
   ``ETHTOOL_A_PLCA_NODE_CNT``             u8      Number of PLCA nodes on the
-                                                  netkork, including the
+                                                  network, including the
                                                   coordinator
   ``ETHTOOL_A_PLCA_TO_TMR``               u8      Transmit Opportunity Timer
                                                   value in bit-times (BT)
-- 
2.25.1


