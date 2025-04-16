Return-Path: <netdev+bounces-183528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0801CA90ED5
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79497A47DC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ADE234966;
	Wed, 16 Apr 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WMNo6Yg7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048B1A5BAA
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843703; cv=none; b=M7kSWR1IBzhenkljeIvVMZHQal28SPYl3KNs1pJIQFFxWpm4Z19O0+zuJLBhIoaOIkoCfAO5Nj2OMBxrsaeyoCIdH3JssQwaNRLaGrN8Gn7rBNDulJEErfUHsu6KprbxNJSfIX9muM4mkT1pl4GmNeKFpzx/EBBKITPSqCFoioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843703; c=relaxed/simple;
	bh=OqusOPeMjg/sJfnLfpn1gMh+LaQA/7Og/SG2cOd3jy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulK+44wzNdJhcYY+CmYe9JDEPiIDqCoKuv/00C7e9nldOPjFrSWCO6z2rtRtwszC3ZlltvOFbxR+3NDvChNsEdaoSCdiIMTTEMfC8vgRZEJaxky7QmcSlnD73+kESnnSHm/zdY/jd05pop9XQmZI9Zebx/EMyWKSGKhTO7Q/1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WMNo6Yg7; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d09d495c6cso21606fac.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744843700; x=1745448500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5/PQOoVcW+1fkczXDMdutM7S7PmnuJhL9tq/POXOzo=;
        b=WMNo6Yg7/6UHku1JbmAmrEB9mO64jyGXddmxcULdv1ekPgzzpgru8W1dfIOqsVbeFR
         8s5o9KuD71d6DaAfo7UpVms4v1QNXiqpu0hQxSb4nw4ixQXx42B8cumDm0qrSDRv9ZBZ
         E+0cuHsvGpt4lPYuhHQaGGJMFMQg3Pwso01MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843700; x=1745448500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5/PQOoVcW+1fkczXDMdutM7S7PmnuJhL9tq/POXOzo=;
        b=dfyuu9ljkFikon2juBKLYoc/lmqk37ABjDqvNITV0yMNHqTa7c2WzM2lgpSH285M9u
         +gzJL34R6yJ2VTuF1qGH43DE2ju3HQ0JMq54QBOBcmEfHn2+KmZmOa6VrQBVY6/tWLC1
         U5j5gaZ8xH4/W0HRwenmJD0ZAQ09gVCW0+bHohnHnqQDIwTeIZsFFY/d/ylM1Xp/ApZN
         X4eHTLtn9SNpuM3uBG0IEjtOey6lr4/+al5eraRMYiihwWOm6vMn/KjUJwh4nRtjvtlM
         xTzCDr4MIU7wmWkb7xK4ecMyzqQSdgMNbvyF/bjyGKchjJFMHsQMRhfbKFve3x8ww4Ab
         AgYg==
X-Gm-Message-State: AOJu0YyI1NRLNcepi1SCf+m1hBE9mB/ekphFADQTMi9I/ZdXuuA7wVPf
	7Icv14JtfAEUqAJP3x2P7LV0ekmXeGRav4qJilSugKe0dx1rZ15u4Ah6AFu/Cb5Iopoj64pRXRZ
	2/isB8OBeaePZ+Ep4OYMmKqsbxm5sS8Z7Z9G+vDVyDjCzLkOVaXrDlj4iU0j78gdoPa5HOPpBgF
	NG4/AGCcn2u+DjIhh71yTkEp5UIa28xGXIjAankTA=
X-Gm-Gg: ASbGncuk0dAxED6onA47z3Vak7P74kr27+IvOpu2YpsmAXyChTw6ZYa7gmJE2veqXWz
	u0aasECaxhc+sv9/H4rABH/p507yPAmCQ14lmyI8/drwtU6gKea/rtEaeNvjqDu+//gwb8Klnmt
	2MrUaEozqvDZrlw6j7mU5CR8j67gLBs2+nqbnkvDSrC+7gNDlK9sxVHHd2KaUqMOknVHLaRgVyz
	+mcOd5z9Ah6oVXdLvy2KcTnMZzWYo0US5zHS6BT2b64Mqk/VlOkKiy67dFcMPRcu24wuf+gqEcB
	ebrwk8nJvI58LkMb7Ya0O3t96F9ekcVzCilBc6cXi2pINLjWzVPUNizw79C8P6BGKkGdNIGc6Jg
	nbC/YiJMCKgfRD9ImLQ==
X-Google-Smtp-Source: AGHT+IFvWB7nerAS/OVdF2vlk4PsLsujkrdnqtsNqoOQHOCMZc0s84dRg/yS8fOHAzQVF96v6vvtuw==
X-Received: by 2002:a05:6830:61cc:b0:72b:943f:dda8 with SMTP id 46e09a7af769-72ec6d207d4mr2354863a34.26.1744843700017;
        Wed, 16 Apr 2025 15:48:20 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d71813sm3015956a34.26.2025.04.16.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:48:19 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next 0/5] net: bcmasp: Add v3.0 and remove v2.0
Date: Wed, 16 Apr 2025 15:48:10 -0700
Message-Id: <20250416224815.2863862-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asp-v2.0 had one supported SoC that never saw the light of day.
Given that it was the first iteration of the HW, it ended up with
some one off HW design decisions that were changed in futher iterations
of the HW. We remove support to simplify the code and make it easier to
add future revisions.

Add support for asp-v3.0. asp-v3.0 reduces the feature set for cost
savings. We reduce the number of channel/network filters. And also
remove some features and statistics.

Justin Chen (5):
  dt-bindings: net: brcm,asp-v2.0: Add v3.0 and remove v2.0
  dt-bindings: net: brcm,unimac-mdio: Add v3.0 and remove v2.0
  net: bcmasp: Remove support for asp-v2.0
  net: bcmasp: Add support for asp-v3.0
  net: phy: mdio-bcm-unimac: Add asp-v3.0 and remove asp-v2.0

 .../bindings/net/brcm,asp-v2.0.yaml           |  19 +-
 .../bindings/net/brcm,unimac-mdio.yaml        |   2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 178 +++++++-----------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |  78 ++++----
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   |  36 +---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  13 +-
 .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |   3 +-
 drivers/net/mdio/mdio-bcm-unimac.c            |   2 +-
 8 files changed, 126 insertions(+), 205 deletions(-)

-- 
2.34.1


