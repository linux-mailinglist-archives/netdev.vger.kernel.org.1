Return-Path: <netdev+bounces-160755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9FA1B359
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C09188A613
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C6219A9D;
	Fri, 24 Jan 2025 10:14:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E9207A03;
	Fri, 24 Jan 2025 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713654; cv=none; b=d7SXUm6VrvjEu2TNbAanh86sQ/5Ur1y5uIQYAJYCxpK2Q6ztX8PNSvdSUW2n6FXxNo7VFpBZ5JIdBdoXmn6cnHJU6mjor+L/pWXK6DclbiHKpeBIIp1YPM6tMwEoCXZoqpLEXhK7fhyVbLzEhp43fa/SmBhMvQx0DAt4gV2KNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713654; c=relaxed/simple;
	bh=dU0xQWaREagtHELUuHSOxZCDQkRZ0rLL43Af7+7Nikw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TKnDexV0S8YbFIXqLBPloCyZRO50srN8DiGT+tqzDcFWCuVf0Ndp7kmcfNAfVDtTkdFsMzhIyXZju8fifMjqP1WPbuM61IXK6lSYcSXzLL6FvI1p4wfd12E84xD3VJD5On51c6CHfuJ5TH8nwhHR+EpqAFl47x52eEDcJDFWqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 24 Jan 2025 19:14:04 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E8688208E6F3;
	Fri, 24 Jan 2025 19:14:03 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 24 Jan 2025 19:14:03 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 865B2373C;
	Fri, 24 Jan 2025 19:14:03 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Yanteng Si <si.yanteng@linux.dev>,
	Furong Xu <0x1207@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net v3 0/3] Limit devicetree parameters to hardware capability
Date: Fri, 24 Jan 2025 19:13:56 +0900
Message-Id: <20250124101359.2926906-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes patches that checks the devicetree properties,
the number of MTL queues and FIFO size values, and if these specified
values exceed the value contained in hardware capabilities, limit to
the values from the capabilities. Do nothing if the capabilities don't
have any specified values.

And this sets hardware capability values if FIFO sizes are not specified
and removes redundant lines.

Changes since v2:
- Check if there are hardware capability values
- Add an error message when FIFO size can't be specified
- Change each position of specified values in error messages 

Changes since v1:
- Move the check for FIFO size and MTL queues to initializing phase
- Move zero check lines to initializing phase
- Use hardware capabilities instead of defined values
- Add warning messages if the values exceeds
- Add Fixes: lines

Kunihiko Hayashi (3):
  net: stmmac: Limit the number of MTL queues to hardware capability
  net: stmmac: Limit FIFO size by hardware capability
  net: stmmac: Specify hardware capability value when FIFO size isn't
    specified

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 57 ++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

-- 
2.25.1


