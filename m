Return-Path: <netdev+bounces-171772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A83A4E960
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4AD17D63C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762DB2066F7;
	Tue,  4 Mar 2025 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZAQ4yBgK"
X-Original-To: netdev@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1162066EB
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108119; cv=fail; b=V6I/BQz14e0cH7XnSiBZtAZkI8vYR6h4y/TxNRLETLcP2Cru4sM3lOo8GVU4bJStR1jubLWOBLW9oP52PKmMBKXbYGM0SLXXvNXN8sw98SPAFL2aLbbbx4ABtIMTbHWYmG2jLZdS05wBznduKthbunNxt3gFEDSBvejibPqI49U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108119; c=relaxed/simple;
	bh=R8gIOfIp7hKULFNS5WiFUDEAMlTSU3MV4RQ95vTGb+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HxnkbKu+bzbJ/nT2/JOSkS+daNsVnzyiPZG9bFFLy5fRZ/1uccN1Xotgvz2VyitLMtDmeig5O+c9G2DV2N+0xxwTgiVn6DODeo5+u4RX4I5hgp38VhNeWzs6DtS1zPriFJ1KC0wPQ10ikNfj1nz3s/lLcwkoSyKLbaZkXBWPN7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZAQ4yBgK reason="signature verification failed"; arc=none smtp.client-ip=198.47.23.234; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 8EF6F40D977C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 20:08:35 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dqG3X2NzFxZ8
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:48:58 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 52E7E42728; Tue,  4 Mar 2025 17:48:50 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZAQ4yBgK
X-Envelope-From: <linux-kernel+bounces-541856-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZAQ4yBgK
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3573241C84
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:54:00 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id BCCFF2DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:53:59 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE743A94AD
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03088212B0A;
	Mon,  3 Mar 2025 13:52:42 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD582135B9;
	Mon,  3 Mar 2025 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009959; cv=none; b=DWHtBl1AZLaXgg5LOtDeDLfnBGaA1MwVZSOuc9xVgRjkXcp573MJejD1Mp6tcusv8ocjLo3NXk1cqyMWMOhRA321oYO8zyyPME4Hluv3Swz1OvQHwmkj8vzvGVGCTz8/Ck54IQfYz+drZR3b55yyG9U71vRr8ZFwjuipWuJMwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009959; c=relaxed/simple;
	bh=hzXQnKkQEKaBU/KLPLOtoh0ihbySNCk+e6ltpzYt4oo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0nubo1EcEXFzRytmA8YtEHZi63aigkjM/mY/QrSkDlUjdl62/7rTl9GsxVsgjG80lQo35WzcJQpo9YPdR36ZjzXGsLAcVvgF7HZWZnCAt/EBNhRFJvnPaMNM78d+1d2448MnL5sVj6x8Mw7nbUtKMJ9qXbWrw1uiARwjJwNlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZAQ4yBgK; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523DqAQA2770688
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Mar 2025 07:52:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741009930;
	bh=HKA6epoyG5k7PVVX2SWKSB8APlH9M5pg/2J3Q1G9Iqs=;
	h=From:To:CC:Subject:Date;
	b=ZAQ4yBgK/Lk91iqOLs9LBj877KPeCh+db+1G/l/eZs3N1BA7S8TLyRradc9EKO9iD
	 KFSeneUZOYTm/b8C2J7PsAXFWdnfMDJOjOSWxDYmDf/VQOtHJSnWAXkYghrReMMZgF
	 4QiK2UjlOwILg+EEK3P9qI3lYfXyBw/8nU2aqVMs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523DqANo095277;
	Mon, 3 Mar 2025 07:52:10 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 07:52:10 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 07:52:09 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523Dq9k0047060;
	Mon, 3 Mar 2025 07:52:09 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 523Dq8NA018076;
	Mon, 3 Mar 2025 07:52:09 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <jacob.e.keller@intel.com>, <m-malladi@ti.com>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 0/2] Add perout configuration support in IEP driver
Date: Mon, 3 Mar 2025 19:21:22 +0530
Message-ID: <20250303135124.632845-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dqG3X2NzFxZ8
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712815.34248@cQYmdH41DJo/+ESkMTurlQ
X-ITU-MailScanner-SpamCheck: not spam

IEP driver supported both perout and pps signal generation
but perout feature is faulty with half-cooked support
due to some missing configuration. Hence perout feature is
removed as a bug fix. This patch series adds back this feature
which configures perout signal based on the arguments passed
by the perout request.

This patch series is continuation to the bug fix:=20
https://lore.kernel.org/all/20250227092441.1848419-1-m-malladi@ti.com/
as suggested by Jakub Kicinski and Jacob Keller:
https://lore.kernel.org/all/20250220172410.025b96d6@kernel.org/

v2:https://lore.kernel.org/all/20250219062701.995955-1-m-malladi@ti.com/

Meghana Malladi (2):
  net: ti: icss-iep: Add pwidth configuration for perout signal
  net: ti: icss-iep: Add phase offset configuration for perout signal

 drivers/net/ethernet/ti/icssg/icss_iep.c | 65 ++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)


base-commit: f77f12010f67259bd0e1ad18877ed27c721b627a
--=20
2.43.0



