Return-Path: <netdev+bounces-135425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E951899DDE7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259181C20EDB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D117C9BB;
	Tue, 15 Oct 2024 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="k/xcpSeB"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2D16B75C;
	Tue, 15 Oct 2024 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972223; cv=none; b=gtB3VX08DBZvFQuyhd9pvcFhl50AZqvVLyauLLCQYDzczq++JmiFtNKFMXpMDXjv3y1alUlkGCpeNVfsyAmsx9bso7kDOr/y4W9DYCCpqSrOQdqFGmyse9fs4YdlIF4tDVfWNUnTFQ1e+j9XhP36lT+VuB9Hi5ATeQIFcfJ7nZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972223; c=relaxed/simple;
	bh=MT4Syxyhvq9KQIe5zvbI1/JRK++jzOE7izxfWUh/TvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2WQuK6D4M4aC0twntU/gxy45x0EGDC64sL7ooEcD/Da/+Qs7sdFBgoGUfas1IXaKl+ML4A3qJ5nRm6Q6iegv7mHxQPoyJxMI5s5DkSzBxkqkxI0WyuHzRXB7E4IqC0DfW9mBaj6Lou97JGWOVnMLYj1YkMGqHHtgE5OAOirRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=k/xcpSeB; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 2459F100002;
	Tue, 15 Oct 2024 09:03:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1728972194; bh=Q+9KDy5kVUHWZSFEh66UUdeL0bXwNloDRdkP7dBZj4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=k/xcpSeBwb7lMZZQHlAP4dk4j3FNQalyE6KLoyErlHp1/XD0pbFH1xL81pLB880DC
	 rFH8lt681VPyCkYQdztihzkEHL40Rdu0cByzcOfgt6djsMr9Inlsvk1MPQuWxzL33x
	 Z0/El6KXnKWo3PyKMIi3P9bXypB0pbVlESOwYcv6fNl82Xa4pdrrAa7jF2pp5Nurmz
	 lMGmJuWXDWOI5q6snUzypxqFSfeePNetxjBzjctPIu9NPvVD2L4ed8a5jwizv4Fmiw
	 R5fWcnBlyni+Ycgdwly/tWE9UuMFBADVHOluIGODHmZnCuxp/ru1kTp8ao0D8E9DtT
	 qyCw7Wc1ERzPQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 15 Oct 2024 09:02:02 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 09:01:42 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Igal Liberman <igal.liberman@freescale.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Simon Horman <horms@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson
	<sean.anderson@seco.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net 0/2] fsl/fman: Fix refcount handling of fman-related devices
Date: Tue, 15 Oct 2024 09:01:20 +0300
Message-ID: <20241015060122.25709-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188432 [Oct 15 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/15 05:27:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/10/15 02:26:00 #26754966
X-KSMG-AntiVirus-Status: Clean, skipped

The series is intended to fix refcount handling for fman-related "struct
device" objects - the devices are not released upon driver removal or in
the error paths during probe. This leads to device reference leaks.

The device pointers are now saved to struct mac_device and properly handled
in the driver's probe and removal functions.

Originally reported by Simon Horman <horms@kernel.org>
(https://lore.kernel.org/all/20240702133651.GK598357@kernel.org/)

Compile tested only.

Aleksandr Mishin (2):
  fsl/fman: Save device references taken in mac_probe()
  fsl/fman: Fix refcount handling of fman-related devices

 drivers/net/ethernet/freescale/fman/mac.c | 68 +++++++++++++++++------
 drivers/net/ethernet/freescale/fman/mac.h |  6 +-
 2 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.30.2


