Return-Path: <netdev+bounces-145219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87629CDBEB
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C7CB257EB
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA4192B9D;
	Fri, 15 Nov 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YHaQQctR"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB7192B81;
	Fri, 15 Nov 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664504; cv=none; b=g7ZvDCuIJmuurwrxqTe5yvtV2lpTuvdtsuzVS647R4wHkZvCPpG/WvuoFLQqcMjm2kE/E3moJv0U2cbOmTSH2aXbuZOYloubSZ/eUXzDg0f3TIyJjQey6W1+nfyIqvVqUQn0ArpK0cbWkK9WE+4Uanh9Jv63zANT/0lpOZvdo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664504; c=relaxed/simple;
	bh=axyrq6N4b771lYu+VAUSZ2EcRaMlRa942/4QTI6peZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYfTNBFWqiFLkIhnuMfjlkhwj0u4oZw5aG/XdFecRSLQ7gWJce3OqyTbY/9vkxZtzI1qyU2XSjQePS4BefMIkQBz0NQoj9/IgZgz8xmdJI3P+OJv4pzdx9tQjFHxH1Os5roKy6ZTwXkYYwIRAxiYdpsWo8rTjfsbQG+eF5SfxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YHaQQctR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF9sZ7a9284316, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731664475; bh=axyrq6N4b771lYu+VAUSZ2EcRaMlRa942/4QTI6peZU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=YHaQQctRUw6xViQH68sBFtgKTNbEzPhCN+ejEsatN7MkKVv8nCoCQtorjzrpHeRDO
	 v7LSxSX0wjr7eTG+pRVQZtquW645SX7B7VSAi4rU2wXxoQKpdPKJMJ8g7qWEL5yBZQ
	 V4ZkAA6/BHzUwNAlnveebhy8ohVfawkNOn7kgVEF0RxKIUaCQc2OSBVw4wU8aIgTvB
	 eafvSJjRobJBXDgzX1NaJJdZ84ERvbvOY66K9YwQyogSvxz+WUMsNDj9BlJtq8Qbb6
	 FNhmGdwHOzweXxOdood+x4X1fu3k//HUPEXYeSlyVgqtyFsmulkaVd2/O/xYLIJN1u
	 kKgPB/k+MrJVQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF9sZ7a9284316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:54:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 17:54:35 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Nov
 2024 17:54:35 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 0/5] Updating and correcting switch hardware versions and reported speeds
Date: Fri, 15 Nov 2024 17:54:24 +0800
Message-ID: <20241115095429.399029-1-justinlai0215@realtek.com>
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

This patch set mainly involves updating and correcting switch hardware
versions and reported speeds.
Details are as follows:
1. Refactor the rtase_check_mac_version_valid() function.
2. Correct the speed for RTL907XD-V1
3. Add support for RTL907XD-VA PCIe port
4. Corrects error handling of the rtase_check_mac_version_valid()
5. Add defines for hardware version id

Justin Lai (5):
  rtase: Refactor the rtase_check_mac_version_valid() function
  rtase: Correct the speed for RTL907XD-V1
  rtase: Add support for RTL907XD-VA PCIe port
  rtase: Corrects error handling of the rtase_check_mac_version_valid()
  rtase: Add defines for hardware version id

 drivers/net/ethernet/realtek/rtase/rtase.h    |  8 +++-
 .../net/ethernet/realtek/rtase/rtase_main.c   | 45 +++++++++++++------
 2 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.34.1


