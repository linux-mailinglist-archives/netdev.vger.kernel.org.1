Return-Path: <netdev+bounces-194223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BCDAC7F74
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BD01C05923
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2FB1E5702;
	Thu, 29 May 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="blvCc4EJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B302C147
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527339; cv=none; b=aAmYbJbmuGVhQApMQ7JekzzsIAk5a52OwTQAtikJ/u9U0rfSRK0tt42CwB/DyAqjK8TJOQtC9D6FtdT5mPgYOdYXPE7VYlBfRaxOrolVUvFTjC4fj6u9lNI24jzVskPoTU8KbcyYyaCIh18Fd05pr+2TvPsJ/ebDX/LQ7LXZC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527339; c=relaxed/simple;
	bh=dJgXAUMVD6kSHiHh2uEYQaqs+kyvixpCu9uWnuNHBkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=VwThUm/9c9n0kIHl/JnmLmmwCj7/pD1F8YTkHY3Cc8oIQK6Nvp3CWuOKzwLT+cb3OoLJ7aSKx0zPo0GGmQg/OL6Dt1bbxlqOK1u/DL0IUc4kfXExv24ELZXESl2lHEZ4fnsY0hKJ6QZVUj7KcSysTN+Iz1x4iSLStn7yDCimZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=blvCc4EJ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250529140212epoutp03d37090e31b9b3017663fc040c2754b9d~EBFg8L9Gw0427904279epoutp034
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250529140212epoutp03d37090e31b9b3017663fc040c2754b9d~EBFg8L9Gw0427904279epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748527332;
	bh=y9pNydYdLfIWmaaXuT2nu0TA0EohmmnilFcfWIq0wUo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=blvCc4EJ51xSusfMhXXLU7qKeFsyqR0mPzC3C9iyxjNIExPwR1MhzKtZstlwov12u
	 NS/uglzOF7AZBrTXvvod0aI+gT8dNAvYH5ClRXJ1Iiqb/szB8YBNzYtJ9MRejDPOMC
	 JzbALS1T52bmiXH87ordwEBb/X3bD29iUpuHnZp4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250529140211epcas5p17e2ee7904959287d422f6c35d6ab75ad~EBFgZ6Atb3115231152epcas5p1y;
	Thu, 29 May 2025 14:02:11 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.177]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b7SjZ04HMz6B9m5; Thu, 29 May
	2025 14:02:10 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250529111705epcas5p25e80695086d6dc0d37343082b7392be7~D_1W07KGo0063700637epcas5p2D;
	Thu, 29 May 2025 11:17:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529111705epsmtrp22e4cccc11d5fa110f20c3ea67f069624~D_1Wz9Gu92239822398epsmtrp2a;
	Thu, 29 May 2025 11:17:05 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-0b-683842312f0f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.AF.07818.13248386; Thu, 29 May 2025 20:17:05 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250529111702epsmtip161036a380bdac99085e24f053709caf6~D_1UDaLqw2002020020epsmtip1B;
	Thu, 29 May 2025 11:17:02 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	sunyeal.hong@samsung.com, shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chandan.vn@samsung.com, karthik.sun@samsung.com, dev.tailor@samsung.com,
	Raghav Sharma <raghav.s@samsung.com>
Subject: [PATCH v3 0/4] Add clock support for CMU_HSI2
Date: Thu, 29 May 2025 16:56:36 +0530
Message-Id: <20250529112640.1646740-1-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnK6hk0WGQc93XYsH87axWUz4EmGx
	Zu85JovrX56zWtzbsYzdYv6Rc6wWjTPeMFmcP7+B3WLT42usFh977rFaXN41h81ixvl9TBYX
	T7laHFsgZvF95R1GiyNnXjBb/N+zg93i8Jt2Vot/1zayWEw+vpbVomnZeiYHUY/3N1rZPXbO
	usvusWlVJ5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXxe+0MxoJ2gYovPXPZGhg3
	8nYxcnJICJhItC45ydjFyMUhJLCbUeLMjousEAkJiX3/fzNC2MISK/89Z4coesso0fKjiQkk
	wSagJXFl+zs2kISIQBeTxLl/r1hAHGaBnUwSbY+3sYNUCQuYSTzfextoLAcHi4CqxIcDJiBh
	XgFriZd/X0BtkJfYf/AsM0RcUOLkzCcsIDYzULx562zmCYx8s5CkZiFJLWBkWsUomVpQnJue
	m2xYYJiXWq5XnJhbXJqXrpecn7uJERw3Who7GN99a9I/xMjEwXiIUYKDWUmEt8neLEOINyWx
	siq1KD++qDQntfgQozQHi5I470rDiHQhgfTEktTs1NSC1CKYLBMHp1QDUxp/JA+XwsvLrlOt
	lH+HbXKRtk9S5nzXfSTF1pb562yZ+LlLfs43UWJszeCsbYmamdpkYD9BwtTo6ZewR3Vhe+9I
	923jzVi9zlRi92v7QyVi+yuitGfczGO+Y77BUnjdqiWRxmki15ckzS5Yc+R3fIewsGftxUlB
	AuG3dm+Os9pd8VDgsL3xtJ+FFw8LCN1c/1p1Lpf47Gb7ybKb83oEGP/OO6a39qfUEb600099
	u/y0f71IO3U37g7j2ZQnfs+bK5ed2/1ik3Qd75LUmakvAp52JSr5r878ubH69Pe10x6677mU
	vk3y3NLQPZnzd88yYNDk/f3nW9yzvDdNKUw2r22up794mpHT6MQm/038uRJLcUaioRZzUXEi
	AMj6OTEKAwAA
X-CMS-MailID: 20250529111705epcas5p25e80695086d6dc0d37343082b7392be7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111705epcas5p25e80695086d6dc0d37343082b7392be7
References: <CGME20250529111705epcas5p25e80695086d6dc0d37343082b7392be7@epcas5p2.samsung.com>

This series sorts clock yaml and adds clock support for the CMU_HSI2 block.

Patch[1/4]: dt-bindings: clock: exynosautov920: sort clock definitions
        - Sorts the compatible strings for clocks

Patch[2/4]: dt-bindings: clock: exynosautov920: add hsi2 clock definitions
        - Adds DT binding for CMU_HSI2 and clock definitions

Patch[3/4]: clk: samsung: exynosautov920: add block hsi2 clock support
        - Adds CMU_HSI2 clock driver support

Patch[4/4]: arm64: dts: exynosautov920: add CMU_HSI2 clock DT nodes
        - Adds dt node for CMU_HSI2

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
Changes in v3:
- Added a patch to sort the compatible strings for clock definitions
  in yaml, as pointed by Krzysztof Kozlowski

Link to v2: https://lore.kernel.org/all/20250514100214.2479552-1-raghav.s@samsung.com/

Got a comment from Krzysztof Kozlowski
Link: https://lore.kernel.org/all/20250521-resourceful-majestic-octopus-cfaad1@kuoka/

Changes in v2:
- Added cover letter with the patches
- Submit the patches as a series as they are inter-dependent
  as pointed by Krzysztof Kozlowski

Links to v1:
[1/3]: https://lore.kernel.org/all/20250509132414.3752159-1-raghav.s@samsung.com/
[2/3]: https://lore.kernel.org/all/20250509131210.3192208-1-raghav.s@samsung.com/
[3/3]: https://lore.kernel.org/all/20250509125646.2727393-1-raghav.s@samsung.com/

Raghav Sharma (4):
  dt-bindings: clock: exynosautov920: sort clock definitions
  dt-bindings: clock: exynosautov920: add hsi2 clock definitions
  clk: samsung: exynosautov920: add block hsi2 clock support
  arm64: dts: exynosautov920: add cmu_hsi2 clock DT nodes

 .../clock/samsung,exynosautov920-clock.yaml   | 37 ++++++++--
 .../arm64/boot/dts/exynos/exynosautov920.dtsi | 17 +++++
 drivers/clk/samsung/clk-exynosautov920.c      | 72 +++++++++++++++++++
 .../clock/samsung,exynosautov920.h            |  9 +++
 4 files changed, 129 insertions(+), 6 deletions(-)


base-commit: 3be1a7a31fbda82f3604b6c31e4f390110de1b46
-- 
2.34.1


