Return-Path: <netdev+bounces-151997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D8E9F250A
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE26E1885909
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8EC19048D;
	Sun, 15 Dec 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lba/hEJ+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180381547FB;
	Sun, 15 Dec 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283850; cv=none; b=SRnlVLeJnvidHW1oJXW0k8WbwIUYYY4r1ag7CJCIprj0YBo5KkhBfOLXxoCY9beqFvaaSVZOKYBBR80UBAXlG9Hbc9gCwAoceaX2e12kXzuR7RvpGqrdEEI8TITjfND2Cj9ULkbz0YNr4ZGTWimKgvP8IeMGeyC51Hb7OLFCtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283850; c=relaxed/simple;
	bh=/efaqbc42+v+ciq/3FM4TfPTRhewVv8qEyjoYpqBCtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tkhfNTu/FP3OpM/VH1md/AOWg0YtPQdjCjy3f1ak/nFJgRYuHWm1/WzeBSObkskzZg0mPC/R3qHiyhud4pF10b/oFwrE8H4TAcPgi7DPzkylpXYAc9v3WvLb62O7f0BdLZggK1clgeUXD03UdG6AbUSxabukt6XJkdWA68f8UBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lba/hEJ+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qhnKUnZU2bi37bD6EJemfvDqOmaYI30ZEPYrAK+ItOc=; b=lba/hEJ++6wHBHPCstHDOJg70O
	xy4lDh1HFgEobDeFHB9GccptnI7kHqYHlGXZwDdO9I642G1ac7Yq4hYwPhya7xbak+nPD+hTC3oXN
	hJOoglObkugRvUF4juI7k76V3dQG42jcG6Fu0ATmqWkyu0HFfrQcdHbWoZ52WCd/dErs=;
Received: from [94.14.176.234] (helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tMsRz-000WHi-7t; Sun, 15 Dec 2024 18:30:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 0/3] dsa: mv88e6xxx: Add RMU enable/disable ops
Date: Sun, 15 Dec 2024 17:30:02 +0000
Message-Id: <20241215-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-v1-0-87671db17a65@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoSX2cC/x2NMQ6DMAwAv4I811KcBoj6laoDIg71QEAJRJYQf
 2/U4YZb7i4onIULvLoLMlcpsqUm9Ohg/k5pYZTQHKyxjqwZsQ5IT8wzYeKjoQeu1XseVBXzeuK
 2F3TBTN7FPo6BoKX2zFH0v3l/7vsH9uzulXYAAAA=
X-Change-ID: 20241207-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-4d0a84f5f7d1
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Mattias Forsblad <mattias.forsblad@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=/efaqbc42+v+ciq/3FM4TfPTRhewVv8qEyjoYpqBCtg=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBnXxI2zYaImhZL2iYGgRKggQIuDUOLOX3iKSEOE
 v1DWz+45GaJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZ18SNgAKCRDmvw3LpmlM
 hIA9EADEO+QSD1K/qpMoCscEBacVIf4ZN8cCc2rxbRWKkV8ws0ncgolY7Xe6QMVYNCkB8A4M0PL
 1e1K1cVJuVYiHSdp+00+mHCtc6RPcbGDb/6UfmZ2GogT/lySC/ewx59DDQ1dLhY/y1nrKy5ml4K
 byobJnZCP+/CtliiX2f/gm+qAITSZI5eb7LE6f6FnYGAA2AcPpjClDwG08w7liqQ+PPjjShG4tH
 ukLGuUlbWwasyuFga5wjYI5fSCsWIncqivz0gs6nbfHhVqEUM95uBJr1ncq6nHdh7eIJdads2In
 Ll4BZkkimiucXrYP7Fncc1mesxxUKxecvoNiV2xrjykfqw68xDYQJwuGUmHOGStcSmJ4bU7HzEW
 y2ODq2uAYaQY6xM5taGla1TKBduEmP1h5XdfjfImnj2hWBn+wbBRHn5mfnDeDHqrvx+U1p+W2dP
 t7JpVjYR20Nc4//1Ai+wQ9MxkzLreG9IugjRBQNXhm+sIraImnZLIiJFKKy/GNzWKH1xO7nIqVo
 v4zAr4ni+xOJsZiwDoqueMisyRSkOHZOnhZkgd6DgqjX/VTd2zZZYTk3U4p8f2hXqHVhfIFLSTK
 hDElxQj5qM0BZWZ6uWyv7kyxgdIbMf5nxrNi2iA/KkjhBL4XyUjh+ETLFSwvXv5+na3riebYcZS
 iih3bTd2vdav1vQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Add internal APIs for enabling the Remote Management Unit, and
extending the existing implementation to other families. Actually
making use of the RMU is not included here, that will be part of a
later big patch set, which without this preliminary patchset would be
too big.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Andrew Lunn (2):
      net: dsa: mv88e6xxx: Enable RMU on 6165 family
      net: dsa: mv88e6xxx: Enable RMU on 6351 family

Mattias Forsblad (1):
      net: dsa: mv88e6xxx: Add RMU enable for switches that support disable.

 drivers/net/dsa/mv88e6xxx/chip.c    | 29 ++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h    |  1 +
 drivers/net/dsa/mv88e6xxx/global1.c | 89 +++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h | 10 +++++
 4 files changed, 129 insertions(+)
---
base-commit: 2c2b61d2138f472e50b5531ec0cb4a1485837e21
change-id: 20241207-v6-13-rc1-net-next-mv88e6xxx-rmu-ops-4d0a84f5f7d1

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


