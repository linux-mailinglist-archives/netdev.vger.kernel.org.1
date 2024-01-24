Return-Path: <netdev+bounces-65324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC1839F94
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 03:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF621F2E1BE
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89F6125A9;
	Wed, 24 Jan 2024 02:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA312E63
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064436; cv=none; b=Q1Xmz/9G2XrB3RtcPPMM418r9/XMEH1VjZm218MPnIdoh2OA+BGUCYkcUKV0/xwJOgIZdkrzr+4HqZjB3FvLf4hYlauYql8ZDAGu43+pEfOcaMPCAF2YWFLAQ6i/3WnAc2VeN/YEpJ+Nu0PkCg67inqWVWoM9f+9jPIwGQS2PSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064436; c=relaxed/simple;
	bh=ng1jC3iclQrHJi8Rqf1EJub0jdYjx5Wo7YhrLpBNAJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJhJBkIjThDqkl34NO9n+pPP9jAlgwP3MeJ1Od5z1dQdSsC8sq3LCbcQIsFwMo6hmkAq/iONoVF51D06GZlnhQhArEwnL12gjK1xnrr08/vA6leuCg7Rdr4gqPCHN1ezNFVNvD6axx5iG2+W3wYadtSATHMcrenByRdeVDllsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp69t1706064333t70jaw7p
X-QQ-Originating-IP: xxn1fRkgqgfrDWfHyTMBY7esED+ygJ1MsMTkdk31lGU=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.185.81])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jan 2024 10:45:31 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: /gpUuYPpeIXDr1EldbMuVMZPvS3YeHTJP8dglff/EaTeYTvBGjc8DirjI6ekW
	QMuY9Z9zxGTgBhjezA2qNpjy4FNnzeElEN3Zncz3A367oPjLjPu3vsF+Difb+gffAGJrp36
	DxBbU+18Q+wFawnouCr6Hx+c0lHsEPZ8SnkGqugrUN3HXUpwHMiJWXotRvlQnPElSKf8B+4
	Js70jdUgDBSwtDkQ3396GcYdyoRTzEyyhlqYNLyTt01J5xW5UgoYzINHaiMX46JRA+g06jO
	frGuIm3dCliR8ReDyhOc45LfCAH2KCeq2/4t0cj6IX2tKB0W/TI4smCrTKkhzOhfqMoAhbZ
	Q5D6Kh65XN+M9MuZzFp2D6XVz9BshBoGiwgjL5gNlQhqWnfSR/shrifGH3wfQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4913081081443217952
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/2] Implement irq_domain for TXGBE
Date: Wed, 24 Jan 2024 10:45:23 +0800
Message-Id: <20240124024525.26652-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Implement irq_domain for the MAC interrupt and handle the sub-irqs.

v2 -> v3:
- use macro defines instead of magic number

v1 -> v2:
- move interrupt codes to txgbe_irq.c
- add txgbe-link-irq to msic irq domain
- remove functions that are not needed

Jiawen Wu (2):
  net: txgbe: move interrupt codes to a separate file
  net: txgbe: use irq_domain for interrupt controller

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   2 -
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  20 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   1 -
 drivers/net/ethernet/wangxun/txgbe/Makefile   |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 269 ++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_irq.h    |   7 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 140 +--------
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  59 ++--
 .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  17 ++
 10 files changed, 337 insertions(+), 181 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h

-- 
2.27.0


