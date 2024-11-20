Return-Path: <netdev+bounces-146418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14089D34E5
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E672825AA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AF8158DD1;
	Wed, 20 Nov 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="V0zhzWaG"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E1155325;
	Wed, 20 Nov 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089431; cv=none; b=ftk0/6e0+2RyGpug62dl04/OFrJg/9sejcdamJv9kUsiHg+0uiLXV9cgYl92amHFvMciBjUG1G6etXgl1kIFUwrz82tG8CTXhXDZwWHuPYFvl/RjJKFlIKqFfDL0IiNjnMH7RznfBRtx6OV8KHFnHH9PetolCXOFLmWvEgI09rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089431; c=relaxed/simple;
	bh=w8HKr7mHvGUeZYvGZ9jSxlUl2wzwUTO1cmkE/Z005TU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKjmLGQMMtP5fMQx1roOF1YgYHPgQEMjX3vxK6XXaXJCSuxp2wfIno8NrMWoR4KOPlOz7b5WQ5Hvmf6UeJNahwjkDQiRMfQWdvm/2VWnELSNMPbBf2PGB167Wldg3Y1cgmI3qNOtzgNnVlNhrUsKqxlJg3vTO7EgXAdubNXs/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=V0zhzWaG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AK7uWZc93743917, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732089392; bh=w8HKr7mHvGUeZYvGZ9jSxlUl2wzwUTO1cmkE/Z005TU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=V0zhzWaGkJZC5/ZkqqBRO6Vn7yeu5p6qvPKEDUwJoKAbxCqyBO5U7Lwz4486ty6sB
	 eVc8ws5WGqzMw5tOM1deW1zEtHJfcQ/CwGSxU1JWu6CgRH1glGbTw3/tcof9vw5a+w
	 Gn0mMALHpZcMAvDTsUBoSpUU1OGzGTDrbAIbXy0GaPo64zanxiGmd5U9qEoSVCoCQ2
	 8hnhDLzcjrZ6ZMfNn3WQ3zgLTE4Oy6O/SMGxj+pixW8YAr4GE00ASE/6VSfUJvCGyQ
	 p2HmH5iq391NWWrzsPgTkrzlcs9Qg6b9Akz3Xkc83Br1VHD6xsH7dbT30fSe411/0P
	 N9o7AXjOtvwag==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AK7uWZc93743917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 15:56:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 15:56:32 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Nov
 2024 15:56:31 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>,
        <michal.kubiak@intel.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net v5 0/3] Correcting switch hardware versions and reported speeds
Date: Wed, 20 Nov 2024 15:56:21 +0800
Message-ID: <20241120075624.499464-1-justinlai0215@realtek.com>
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

v1 -> v2:
- Add Fixes: tag.
- Add defines for hardware version id.
- Modify the error message for an invalid hardware version ID.

v2 -> v3:
- Remove the patch "Add support for RTL907XD-VA PCIe port".

v3 -> v4:
- Modify commit message to describe the main reason for the fix.

v4 -> v5
- Integrate the addition of defines for hardware version ID into the patch
"rtase: Refactor the rtase_check_mac_version_valid() function."

Justin Lai (3):
  rtase: Refactor the rtase_check_mac_version_valid() function
  rtase: Correct the speed for RTL907XD-V1
  rtase: Corrects error handling of the rtase_check_mac_version_valid()

 drivers/net/ethernet/realtek/rtase/rtase.h    |  7 ++-
 .../net/ethernet/realtek/rtase/rtase_main.c   | 43 +++++++++++++------
 2 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.34.1


