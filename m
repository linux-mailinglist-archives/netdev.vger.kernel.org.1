Return-Path: <netdev+bounces-117277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF894D635
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F121C209F8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909C1474CE;
	Fri,  9 Aug 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYYMRlRx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FA20309;
	Fri,  9 Aug 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227491; cv=none; b=u3OouaidNtAW7hhwl3URgHYk8FRPNiYicE5BZVFRzXXH6N3OB8FsTax0LmuC3Oz20HrJpsRFW6MLfxkqPhJ+BA0YbwdgFTzyaRd8pUVal9KrONU+TY88aGQM9TFso9AzV/SE1JK+4DywNL6hiXOcwfOdy4NeRE1eDGrvkrW15Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227491; c=relaxed/simple;
	bh=jjnLbbdVBpfhuDZxF6ajgOKZIJ5+WLD/XKTaZtyKMzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hRnTu11/mPsWAP9J8Nqw7/ONrqhrxcEOwUXpzbd2LW4IzYAID/j+Ci8BUFBrZS2kJHGoFyW8t4L4rqytZ6F/j5XUxbNo10FrElgA+f9C1zXgKmnJro1zcjfojhYoFBra8KfE/R2QgjyVnptHLL47wI79+9dTLUmjUdH6v/SW2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYYMRlRx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc611a0f8cso21040835ad.2;
        Fri, 09 Aug 2024 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723227489; x=1723832289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPrUGarB5nEOXoX/2BO/BZ/JE38Dogt0DthDK7mWKJI=;
        b=YYYMRlRxDmD2hzvu5ab9hlVu0XHz1FU+gHlLT3P0xqB52pfPnQEtup/nDPlFnJXAZy
         CBFyIi8WGZE0xufDiC6THMNjHgx0QL0dK/WIFAGU0+TRDRQ0sQsY5PkIkL/mSUsbO7+b
         sGdljGC5lCYwCYJLBf3tVm3gCF2hHAm/iQXtikGgSUGAlxcdFRDwL89OqPwGT3lF+8qr
         giKn2SDU/8B/Iavy4EJ/lurHsnTrzUCrCFXDS3ryYcdmCYPfv2t4bGm4SKT4QXFYVgZA
         ZdZNCjiUo1bPLbE+l1xVxIp/+UfKpYxIjW7TUVmq0CO6FIUsiwhUL3aubHwQOnv0rZZV
         8kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723227489; x=1723832289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPrUGarB5nEOXoX/2BO/BZ/JE38Dogt0DthDK7mWKJI=;
        b=sOfakCXBkpV/1BQXsQkpfepvv7ZUyXdwNqyLIWWFIek5jJG6wjqLJGTnyOWus2drIF
         vsIsxRLcyNSBcmx9x6f6maRYeZU/z3ZAS4fO0EhIGia16novervYLYstz1qmahBXoL1D
         qZLUfRGUe77T6hxIvPYsRa9qtRyoTBkHNHlwAo8HhomNnvD3LBpEvLHX5OypB1nzQbBx
         rWRY+r/yeDNFo0nor5DFlIwjwbtFQu8hhLXzSNqhMEiETnqwsLIWtLagwOehlh5Bb59d
         LqwPNTcF6AR0TPvApkzWjj3g4hmTCtr0vBrmDZZOXsGzsUZm09tPV459kxxyNRFLqWaw
         vkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU62Dje5FUi6Zf6zD95MZNICjuIMTFVsFlugd8IWrX28LKI/6P/b5GIonLOrz9/WRLlEulzLtvL@vger.kernel.org, AJvYcCVQqAOlU/u4lRY2EtQlYvrmY2rVqQN966u89j0y3aT0XlbOm0XKySGrEIwcGPXWxKd4e6/RrsKG/5H8umZL@vger.kernel.org, AJvYcCVjVINaOsQSzQ4tyx/LVNhYhski457e8ZuGAygRYDqJXQWRJj24sl5Lrl8T2NSZWeSXq1j/rtAnlD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFK2LyKkOAwBogNBZcdtbW+Da/lwHrnG6InbLfbze+td445OW
	PxYHJIUrt6TryYVIQUPN0M5snNvITowz+uVFer1t9Z+h204kouyE
X-Google-Smtp-Source: AGHT+IG7gHVQ1+zrXCDxWoCSdNYTRlR81Bxw6R0G+q2ZC6+nT2iFTV2lojUwUasl8ULDe7FDSD11sw==
X-Received: by 2002:a17:902:e804:b0:1fc:57b7:995c with SMTP id d9443c01a7336-200ae4dba44mr25153305ad.7.1723227488723;
        Fri, 09 Aug 2024 11:18:08 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e451-b7c6-a4e2-bea8-613e-3352.emome-ip6.hinet.net. [2001:b400:e451:b7c6:a4e2:bea8:613e:3352])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb900c2esm608255ad.112.2024.08.09.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:18:08 -0700 (PDT)
From: Jing-Ping Jan <zoo868e@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Jing-Ping Jan <zoo868e@gmail.com>
Subject: [PATCH] Documentation: networking: correct spelling
Date: Sat, 10 Aug 2024 02:17:50 +0800
Message-Id: <20240809181750.62522-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 Documentation/networking/ethtool-netlink.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index d5f246aceb9f..9ecfc4f0f980 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -934,7 +934,7 @@ Request contents:
   ====================================  ======  ===========================
 
 Kernel checks that requested ring sizes do not exceed limits reported by
-driver. Driver may impose additional constraints and may not suspport all
+driver. Driver may impose additional constraints and may not support all
 attributes.
 
 
@@ -943,7 +943,7 @@ Completion queue events(CQE) are the events posted by NIC to indicate the
 completion status of a packet when the packet is sent(like send success or
 error) or received(like pointers to packet fragments). The CQE size parameter
 enables to modify the CQE size other than default size if NIC supports it.
-A bigger CQE can have more receive buffer pointers inturn NIC can transfer
+A bigger CQE can have more receive buffer pointers in turn NIC can transfer
 a bigger frame from wire. Based on the NIC hardware, the overall completion
 queue size can be adjusted in the driver if CQE size is modified.
 
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


