Return-Path: <netdev+bounces-183658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D2A91716
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11FC1756DD
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051A223323;
	Thu, 17 Apr 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oDZM07lM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B4187553;
	Thu, 17 Apr 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880269; cv=none; b=BfGfQLaWQfhqpZu64Cj1M16pCvH1O+lo+V0fXM+KF8wf+BcCXPQiYSMdWi6Fg+HOxPQUkr3CwwpEoIVYzvu6Bvkw7+hbDMEsPDKPI+n8elPZoeYuY4el5qCPESo7KTPhpz+drS/+jFsYuFTXgy0Ti6M6pSjVBwd2TdpCTNAJMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880269; c=relaxed/simple;
	bh=FCpwxuPTacYt0lsO9t2zHF88eLGaZzTxM4S7W/ep5AM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZ4QUzpf1z3ZaOg5enggF+sIHi1B0wH91isjj+AFvuh6HB/68uLoc6PYfU6+PXDuprwkYKQrQZile3Nxa3+TB2KIiO+Zx0h5yERG4RqbBq9aflWI6zbj65PzZz7AoD/0Y0igP6EzPvspgMm35lXpxQLQbOgeBJdzprYgJVv5PxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oDZM07lM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53H8vI8O1615689, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744880238; bh=FCpwxuPTacYt0lsO9t2zHF88eLGaZzTxM4S7W/ep5AM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=oDZM07lMkoLb5yWdCG7+wDMH5QQkA6OGmPEaqTCO+zu8I4af8aLU6QbxPwSLQy931
	 heiZ8FJ93XY5syB8S5DyRVpjPsh8Mb2fpKT0P+EB68tTTV4qZmWkMv2zyvNTkn/kV1
	 wN54Tmdo6VArbh8wDtxwiWeLyzmRdeDOjMktE7py2HeGmFXTxI7aJUXPEyhDXHRyqj
	 ckBSubHtIj9WtgZIzsNShYLg7EkrLwAuMUdjTUtFn0WUdSCdpLIldK1z+yOHq+2OaA
	 NKPHzKyZzOHX+nZL1hNNAFeLQBNXWtrMJnmFuR34/bC3VZd5yL9/nf8Wybf0uXtuNA
	 tR9PEqCt0cHXg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53H8vI8O1615689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 16:57:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Apr 2025 16:57:13 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 17 Apr
 2025 16:57:12 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3 0/3] Modify overflow detection, expand ivec->name, and correct type in min_t
Date: Thu, 17 Apr 2025 16:56:56 +0800
Message-ID: <20250417085659.5740-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch set mainly involves fixing the kernel test
robot issue and the type error in min_t.
Details are as follows:
1. Modify the condition used to detect overflow in
rtase_calc_time_mitigation
2. Increase the size of ivec->name
3. Fix a type error in min_t

v1 -> v2:
- Nothing has changed, and it is simply being posted again because the
initial version was posted incompletely.

v2 -> v3:
- Modify the subjects of the cover letter and the patches.

Justin Lai (3):
  rtase: Modify the condition used to detect overflow in
    rtase_calc_time_mitigation
  rtase: Increase the size of ivec->name
  rtase: Fix a type error in min_t

 drivers/net/ethernet/realtek/rtase/rtase.h      | 2 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


