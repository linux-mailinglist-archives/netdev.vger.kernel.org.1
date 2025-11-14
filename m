Return-Path: <netdev+bounces-238609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC12C5BC49
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61B494F1929
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358BC2F3C3D;
	Fri, 14 Nov 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vR4NCeqh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7151EF36C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104839; cv=none; b=FiL6Q8EZP3hye+NR6r8Y1CGoyVZWRZMsn9Rn7KKkUwGIs5uN7v2/NPImqQNbHkSK3NeJLRXUwyWdaOdfDLooxXxefY+hjXX0buXSgL5+GRTCddnYHDIbj5Dir4++AryLxb2fyzGTSrfIA9zhoQ6ZL+fUYAXDW8Q5dAhrwsLA/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104839; c=relaxed/simple;
	bh=F+eux7yWpElcLJXOrH1Btxiz4FLKcFEJVBy0FM6qB3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nk4Y/0po2NrFP5lT0521eZfBXVV0oNNQeFwEWhQj9ERGrqShAdZFhP79ZiVrHJm52NHC07SWSc5hJuW+TyKt35L9+YSEDa9mIbvI0PDVFSG9pzMEeYpDmIyaj2DDfnk0hGgrbh2MsvScEEvNgPc0q/EJnDTG2/8k7BFBO/3uZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vR4NCeqh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 664824E416AB;
	Fri, 14 Nov 2025 07:20:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 366596060E;
	Fri, 14 Nov 2025 07:20:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B40A9102F24BE;
	Fri, 14 Nov 2025 08:20:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763104826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=k/9ZgPG0n5e6H9PXL5ixzR64GkWl0Sz7L1vAFR9Y9f8=;
	b=vR4NCeqhaOUl6Ni0NQIiCnunMCXzrN4IoboPAvU/uYTlnwpuEu8uzJBJz92TKlXEhoXgl2
	M+fNlyWeHyt1+kOjxK3HfZlplsvYd5EaFojfZ1rqqd5dqk0Y4l1cI7fj7lTzdENEHmw37e
	8JZQTgXK2S0pNgfwikONjw6i+RcAkANypa0AfOCfVbhT6E3jgzRaJfoNAo81Hdvwu2+hlI
	z9YFfMRk5Q3i2mfHEUHR4PAuO1sxBuJzoZdK/Z1RAXSxVghLG6HFpki3k2WdNYEWfMSM/C
	Oa2XmEbxe9ZGa+EUDCgUWKuCvZ5cJQDskXeOUD0csbqCY891JvnVrNDFVc7+eQ==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net v3 0/4] net: dsa: microchip: Fix resource releases in
 error path
Date: Fri, 14 Nov 2025 08:20:19 +0100
Message-Id: <20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPYFmkC/2WMSw7CIBRFt9K8sRg+LVBH7sM4sOVhiQoGGqI23
 buESWMc3s85CySMDhMcmgUiZpdc8CWIXQPjdPFXJM6UDJzyjlHByC19iHUvYgbRdsYqKToL5f2
 MWOpqOoHHGc6lnFyaQ3xXe2Z1+hNlRihR2EqDfd+jYcchhPnu/H4Mj2rJfCMZlRvJC0kV09pKq
 rUSv+S6rl97fuUP3wAAAA==
X-Change-ID: 20251031-ksz-fix-db345df7635f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

I worked on adding PTP support for the KSZ8463. While doing so, I ran
into a few bugs in the resource release process that occur when things go
wrong arount IRQ initialization.

This small series fixes those bugs.

The next series, which will add the PTP support, depend on this one.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v3:
- PATCH 1 and 3: Fix Fixes tags
- PATCH 3: Move the irq_dispose_mapping() behind the check that verifies that
  the domain is initialized
- Link to v2: https://lore.kernel.org/r/20251106-ksz-fix-v2-0-07188f608873@bootlin.com

Changes in v2:
- Add Fixes tag.
- Split PATCH 1 in two patches as it needed two different Fixes tags
- Add details in commit logs
- Link to v1: https://lore.kernel.org/r/20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com

---
Bastien Curutchet (Schneider Electric) (4):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Ensure a ksz_irq is initialized before freeing it
      net: dsa: microchip: Immediately assing IRQ numbers

 drivers/net/dsa/microchip/ksz_common.c | 23 +++++++++++++----------
 drivers/net/dsa/microchip/ksz_ptp.c    | 17 +++++++++--------
 2 files changed, 22 insertions(+), 18 deletions(-)
---
base-commit: cd2f741f5aec1043b707070e7ea024e646262277
change-id: 20251031-ksz-fix-db345df7635f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


