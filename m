Return-Path: <netdev+bounces-146171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00729D22DF
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AE1F2292F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D221BC073;
	Tue, 19 Nov 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NsBuOOSM"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B61993B4;
	Tue, 19 Nov 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010266; cv=none; b=QQunAxSpLlrw9zQ/4uuetzunz22E6KUSfvj3XyqY7xpywfd+MDOXZUe2B8Ll+Ruamj76ifA7zVq+83CJFuEmK5+MiA7Zf5pd+wvi39cN6GO7+40RicVdrM9ObXnGNHH2vRdIHL0o3WPfUUObREZImj3UvcKDGaYMkJTdaY7qMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010266; c=relaxed/simple;
	bh=NEvsz9zuzYBru0XtLeABkUHT9Y7jySeNVBKDNRtCxNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mV3CMD11Yaxmsx+fTvcYkjjDkFGJn5eu5k3yxaS2JSDDY5kwrC56A6JLezIqUzL5MRBdOoqv14+VILhQHdaupx87CrUSLqtEogf/tkqyyKceGmjfkIokbkrx+dLpYWLZ0uJafQD1HZVWWTKsOAGARHLs/RxuS0jix+euIxyeMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NsBuOOSM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ9vCNc92265147, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732010232; bh=NEvsz9zuzYBru0XtLeABkUHT9Y7jySeNVBKDNRtCxNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NsBuOOSMYPgw2/guOvL5rZzTL3JRdEY+zETkZJu7oWyCiN3uCSIcn1s4JXzhbcKFY
	 Qqiee+n+oVoP3aDIZkG1RuM4gVoWsbt96c9vxcNtX786fJRTQcRbJPf+rNQN7EMdKK
	 mnTIoKEvUOuwimqe0qXf2IVl4tx+pmU/ZX8hyMErpJfD44mDHZTOB2tGDRzGLVTOaN
	 vixG0X6E8XJPUhel/3txL4W/sJVSHpa0ibIpP/2GfDq6qaZqyxD13t3CCMjPwLym8/
	 TUl45cE1HvJCHjQGFtgneU6k5uBnwKuE18rHl7Z+LQxxE/KdPMcTYlUjeAw2fJe9sh
	 EEw3BPMWQ+71Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ9vCNc92265147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:57:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 17:57:13 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Nov
 2024 17:57:12 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v4 0/4] Correcting switch hardware versions and reported speeds
Date: Tue, 19 Nov 2024 17:57:02 +0800
Message-ID: <20241119095706.480752-1-justinlai0215@realtek.com>
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
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This patch set mainly involves correcting switch hardware versions and
reported speeds.
Details are as follows:
1. Refactor the rtase_check_mac_version_valid() function.
2. Correct the speed for RTL907XD-V1
3. Corrects error handling of the rtase_check_mac_version_valid()
4. Add defines for hardware version id

v1 -> v2:
- Add Fixes: tag.
- Add defines for hardware version id.
- Modify the error message for an invalid hardware version ID.

v2 -> v3:
- Remove the patch "Add support for RTL907XD-VA PCIe port".

v3 -> v4:
- Modify commit message to describe the main reason for the fix.

Justin Lai (4):
  rtase: Refactor the rtase_check_mac_version_valid() function
  rtase: Correct the speed for RTL907XD-V1
  rtase: Corrects error handling of the rtase_check_mac_version_valid()
  rtase: Add defines for hardware version id

 drivers/net/ethernet/realtek/rtase/rtase.h    |  7 ++-
 .../net/ethernet/realtek/rtase/rtase_main.c   | 43 +++++++++++++------
 2 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.34.1


