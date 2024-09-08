Return-Path: <netdev+bounces-126284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D907197077C
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 14:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1E281E15
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59AD1607BB;
	Sun,  8 Sep 2024 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0l1ePwO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A662158207;
	Sun,  8 Sep 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799309; cv=none; b=HK49K+i1U0YIWmAkiNx6Z0VbbLDLCONado7H8LYThfpdUlzoWKYhOfbShMnas1QbU9Y0Vx8IUgbHtLbJ2VNOEhZHn5kg60jvbFVvfDXSg5bjbDFYenw8Pk/0uYxukwjHSKCfAptoQCLo6fDJkgeqKXRPBJ3ulFgT6vvlmgBq/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799309; c=relaxed/simple;
	bh=dSSkl+KGlfulG7hsv5Lp90NxDM9LuQrFnIANkpCIoiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwVvIxNb7PEJVYAe1eUqrJE29mPH6Z6cdrwNnM617gYv9g5St6L3096xvAL4NmbaN5InH+MS2hcTvMkTl9LjxjdHQ1R1wS3wW8fqVeQUiPJg9+fD5RYc27n1Hbrcw4H6OSn+hziJgXWP7cpM1Rd25Sd+dsixYCLWpz+WHTNZjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0l1ePwO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20573eb852aso30082725ad.1;
        Sun, 08 Sep 2024 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725799307; x=1726404107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uYWtj30PbC+917rXwj2ZeDN/ilM4G0ReBuNs+bagbU=;
        b=D0l1ePwOfWdFSRXfu+3UEX7CliJG+Y4WYeLIzDYhHl26v+Otz6oEQe8KmR7ofZzDo5
         GZbaXvxl9yTcf6V5ggkt9+4PtZIX0Yzp2fd14NgxW3GLTyYq2fqLg2smqBb2AuJVP/y/
         7tWhGCAPZSno964ckT2DCX0YSUvpP6Fj0b3UHWSj8KxHFCegaDYHa74UD7roXylALTEf
         euU2lppb5a5n7fUlrKMbpj8R4Q6lnorgzQkXQJ7fB7BqpyUgKq8htmH2pWo4y6BO4n8y
         QxaJDSIJoiefCX/tnsgMmlJe+LNVOUFzxL4F2UeIBgBExIJuOGUQFEuAi3m/mWnrnJpD
         64AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725799307; x=1726404107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uYWtj30PbC+917rXwj2ZeDN/ilM4G0ReBuNs+bagbU=;
        b=s8p0xZzhkIVSdpoeKI05KrUeHlHRb+tEO01EI3y0XhjOzmfIiMZ8UEcmesLzXGP4gB
         cFl1w/voAU5pvxpabZNHoM4ZtgbQDh5snHWaRl/elGkfIcNa3kZn4AEFC6bPk5GniCkT
         ofEc1el4h4svtYuz+Fp+7SAcMC5RXphPbLmxfwV7QknyPQTQeyDCuOZHXseiGtOssJRm
         tpgIb8N3AKYM8/supUnq7ikYYXdGC/8En1933xQWEhhjPSPQcl1ILUR6WfD5tPuYIRyY
         9kzEu6L2XvYFK/ZaoRK4Bkz7X2IxgnEL5BlKLvPiL2LEXx6EuunvPdUVq915yd2OMp8f
         7gaw==
X-Forwarded-Encrypted: i=1; AJvYcCW2O40mQw65QG5+6Wp5k9HXqMvefteNJTnjTgLR372NP5/51DBElKuo6o8bSIvuWpu6kByNcag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyvpFtOisFMJjt9U83i1TMRYYl1On+3guumkfgo2lO7f6m9RW
	QYw+QP5QtOaqUe8yrYN04niErIt7spFKpLEPUaEDHpC+HzzXSR8q
X-Google-Smtp-Source: AGHT+IGrT424fLPVfYZiCIEctYiHnbMimt/Ni7p7o/63fwBCTfokuovnFKgsCWj0t+LGSsq1YbVVHw==
X-Received: by 2002:a17:902:ea0a:b0:205:3475:63be with SMTP id d9443c01a7336-206eeb8c61amr125659135ad.25.1725799307324;
        Sun, 08 Sep 2024 05:41:47 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([14.155.188.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e11e31sm19604355ad.62.2024.09.08.05.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 05:41:47 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net-next] net-timestamp: correct the use of SOF_TIMESTAMPING_RAW_HARDWARE
Date: Sun,  8 Sep 2024 20:41:41 +0800
Message-Id: <20240908124141.39628-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

SOF_TIMESTAMPING_RAW_HARDWARE is a report flag which passes the
timestamps generated by either SOF_TIMESTAMPING_TX_HARDWARE or
SOF_TIMESTAMPING_RX_HARDWARE to the userspace all the time.

So let us revise the doc here.

Link: https://lore.kernel.org/all/66d8c21d3042a_163d93294cb@willemb.c.googlers.com.notmuch/
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
1. remove the duplicate word

previous version
Link: https://lore.kernel.org/all/66d9b467d02d3_18ac2129427@willemb.c.googlers.com.notmuch/
Link: https://lore.kernel.org/all/66d9c3f875b90_18de412948b@willemb.c.googlers.com.notmuch/
1. cook this as a stand-alone patch (Willem)
2. add Willem's reviewed-by tag since this patch doesn't change
3. move the reference link at the top of S-b tag
---
 Documentation/networking/timestamping.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 5e93cd71f99f..9c7773271393 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -158,7 +158,8 @@ SOF_TIMESTAMPING_SYS_HARDWARE:
 
 SOF_TIMESTAMPING_RAW_HARDWARE:
   Report hardware timestamps as generated by
-  SOF_TIMESTAMPING_TX_HARDWARE when available.
+  SOF_TIMESTAMPING_TX_HARDWARE or SOF_TIMESTAMPING_RX_HARDWARE
+  when available.
 
 
 1.3.3 Timestamp Options
-- 
2.37.3


