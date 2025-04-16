Return-Path: <netdev+bounces-183291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5ECA8B985
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101743B991F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD14683;
	Wed, 16 Apr 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qdVyksBZ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC7029A5;
	Wed, 16 Apr 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807567; cv=none; b=og4GmH60zM0VrJMnMerJRfQp+VBZyUmjg9cSLR91mNoQgFM2UMRuV/UMDeJg+r/Hg4RlscoovrPHSyFim2Ivh7EnQs2Di8oMkUqGSww2v25sMKpJI60BiqWGczMlIfk2wJ1N3gQMdLSoiWadM2fGyRGCWfT/tJdoJ4YpevyOJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807567; c=relaxed/simple;
	bh=kValmFNM6cznbTzlmwphAIjmm+hlMN23O+RwDf6r7C8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QxY7Y37mBpY+qlhZY7H5vaLOjZ8KXsJcUiYL4QVLhdATf4Sc/ZZ6ZJAW6kftgLZVYso3EvaJCk4jX1WYx/LYEfvfCjdTzktp/5S+W32kk/GABfhUhSdcBBlVSlfzfF/idyGtQ+dDiQ14L6xNDjfO3sL3XzZHRy7/K/iUtOWHk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qdVyksBZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53GCjjjkF3269288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744807545; bh=kValmFNM6cznbTzlmwphAIjmm+hlMN23O+RwDf6r7C8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=qdVyksBZTDNBHMTaovYwneC5cGTkjj7d64eTrt8q8i9SiQu+Ce2DsKIpoD0YMeAI/
	 gl4vQdwnanMOwDa7c1ELIUZv65BfKJQH2H+cpf/l0iDpuLEmexPeYncR21TpK1qCq6
	 25hLupeFkymksPksX7d5vkTQbJn7SFXZvERpqs9wUsZCQLyHUx7buJ1CuZJ0dnPAXd
	 EBiz6GJSEtzh2VdEUQA42cWXWJbnM4VqL3so+RFWFdsWZTZjGjP95SEcvmJGbAE2NI
	 mW+wmXMWt4TrhOGHJzji8wUKx1lHw754RmoJTjt6y8B86+ZOr31s2gKBcnszoUESzr
	 lkM4f+tPM1CRA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53GCjjjkF3269288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:45:45 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 20:45:46 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Apr
 2025 20:45:45 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 0/3] Fix kernel test robot issue and type error in min_t
Date: Wed, 16 Apr 2025 20:45:31 +0800
Message-ID: <20250416124534.30167-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

This patch set mainly involves fixing the kernel test robot issue and
the type error in min_t.
Details are as follows:
1. Fix the compile error reported by the kernel test robot
2. Fix the compile warning reported by the kernel test robot
3. Fix a type error in min_t

v1 -> v2:
Nothing has changed, and it is simply being posted again because the
initial version was posted incompletely.

Justin Lai (3):
  rtase: Fix the compile error reported by the kernel test robot
  rtase: Fix the compile warning reported by the kernel test robot
  rtase: Fix a type error in min_t

 drivers/net/ethernet/realtek/rtase/rtase.h      | 2 +-
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


