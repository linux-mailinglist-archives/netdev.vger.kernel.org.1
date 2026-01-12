Return-Path: <netdev+bounces-248867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7DCD10607
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E6C3014A05
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CA2EC55A;
	Mon, 12 Jan 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="NIgcZDCJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979321B195;
	Mon, 12 Jan 2026 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185991; cv=none; b=ctdQzWzGyM4gVZhuBbUfhsdSKJwXmeObmonjJ/7Vi4P9jssmgsrV2BnMRbZxqap4s0YBQ0yfkkPz/h5KpDM2uH3gXDGWzCtmttrWoGMk6XdPWcV0v4JGzFqw/dy6V5hx6GS89Wetl12sn7fABw44K40Wv7uNMTqhrdhJGPIIFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185991; c=relaxed/simple;
	bh=2UkDgzSOmT1r5xYxFIA1b0+97iYtRFAie333tFc+pdk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3VnafXaUC5SvisPHHSyNikwSqRq6qStAx5q7oj07F874Yb81WPEc/2/7/8tLbsVfYOl5KvtwcPqUNx1EPST5SrMaVAr+zvnsqXUuPUP61U40k+rjSwq6VSYZ3V5LUZw1McomzDdU3wWSBBKCG/mD4d+6CnEI8X6I7/yyHcSWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=NIgcZDCJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60C2jgCX34128682, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1768185943;
	bh=Dk9zwruXP1zBKgmyeXb5TsHiJv7Obg0LzIASjbknT1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NIgcZDCJFcKjHm5dX5r/hhfxFv4bb+wufumvgfFB9xwF3I9VneB3ATyEbAsghTZsA
	 cYC7j3aNlwSWguvtTyrWdSDhJAz0IeBc9MKn6K+gQ5b+75tMKcZyC7dfAoGYo6UITq
	 Icr/5mVTOwHJd+jR/vBUSpPupc8Zysqeo53MVzXSP71AKvHUaqmJEPy51uVz29UVmj
	 YB0VbtbwYZu9OOSUA0XVk/l3TxaCpXw9/MC98uFBG++PNJKRJCyXPvrd3PkChUXUA9
	 RNePQTHyq0hQFabu6G7Vl07YxFAAXlGmiYvpYeCfjVBFx1I1HyMk1Z+nfjnMfdw7Fa
	 e4K9A9UQnhlSQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60C2jgCX34128682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Jan 2026 10:45:43 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 12 Jan 2026 10:45:42 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 12 Jan 2026 10:45:42 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 0/3] r8169: add dash/LTR/RTL9151AS support
Date: Mon, 12 Jan 2026 10:45:38 +0800
Message-ID: <20260112024541.1847-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This series patch adds dash support for RTL8127AP, LTR support for
RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 and support for
new chip RTL9151AS.

Javen Xu (3):
  r8169: add DASH support for RTL8127AP
  r8169: enable LTR support
  r8169: add support for chip RTL9151AS

 drivers/net/ethernet/realtek/r8169.h      |   3 +-
 drivers/net/ethernet/realtek/r8169_main.c | 130 +++++++++++++++++++++-
 2 files changed, 130 insertions(+), 3 deletions(-)

-- 
2.43.0


