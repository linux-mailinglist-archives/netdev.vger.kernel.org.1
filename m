Return-Path: <netdev+bounces-151416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533F99EEA49
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B1D188C007
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06702216E3B;
	Thu, 12 Dec 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ir+Sg0XV"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FA21660C
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016080; cv=none; b=Ov2yFojV88Xhe73tUpT4TKf2HGugePtVA/V8oNWcgc4I/uUQaRvsTK8n+aWCgAl/UCvE1E0f3VJgyr4PPS7IVb2b+OeC5YCoHD9E2O43sS67iWVLevprR5jU8IY5vz756eq9nTpn92jX8SU5yPfSXvGwdbPWB/qN9wcq48VCezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016080; c=relaxed/simple;
	bh=doQxPVzGWziwxyREawjlfslIzJOEBIwlGwBz7kfSYxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bdBBX3b7JdnfnnewJo/Orl0EnsaSZ4vIzOv7b7rHRzUJDvSqwbVhSedh333i0eR3xBK2v1M3WU/PjwaYvughYkuB12CrRcu8iREkDUll51/oxxiFOb/+sgolVoUFcT3gRaLKdluocXkjgdMECW5wittj6DPxQDmOtJWtghLA6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ir+Sg0XV; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734016077;
	bh=Y657PHepeCM4YKXKWvciAElOeTFE5M9NAbpEcEmX/do=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:
	 x-icloud-hme;
	b=ir+Sg0XVgsedQ65YlYDCANn69LaFR+se/YH452aygyuGc2iFkheCo+IYYX1q+SB0h
	 Cl8AJojnxDw+fcFSbUxX+UnREO0Bk2Nlhl9VL3j2oaJ2OgOuzes+imuIlKU8Neg44G
	 nBBbwJms1hOy7Ba06ZNaORLahWF8YivY+dIC6ve1fTqYzvsGpk8f8fHtErEAKLAq4D
	 SrHY7/DCNLucF+LtEHFk5TIcjm2u0hC33cSDEax09E+fgT+ngJLBY0Pgb7XCFnXyd4
	 EI2hlwTQadr3aQq94gzlj2mOINOEblNo53AEgtn2qwnbX/4XXr4PuBg7nQqJYiXTYa
	 kW49ZKsZkP2PA==
Received: from [192.168.29.172] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 5BDBA34BA9AA;
	Thu, 12 Dec 2024 15:07:47 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH net 0/2] net: Fix 2 OF device node refcount leakage issues
Date: Thu, 12 Dec 2024 23:06:53 +0800
Message-Id: <20241212-drivers_fix-v1-0-a3fbb0bf6846@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA38WmcC/x2M0QpAQBQFf0X32ZZdlvIrkmQP7svSXW1K/t3N4
 0zNPJQgjER98ZAgc+IjKtiyoGWf4wbDQZlc5RrrqtYE4QxJ08q36Wq/+hbBY+lIi1Og+r8NFHH
 R+L4fHWxl0mIAAAA=
X-Change-ID: 20241206-drivers_fix-735f56ed5ec7
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Simon Horman <horms@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: UaOEoChBY_NlL3gq-XIUOe0mQESBMOYL
X-Proofpoint-ORIG-GUID: UaOEoChBY_NlL3gq-XIUOe0mQESBMOYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=839 adultscore=0 spamscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120110
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to fix 2 OF device node refcount leakage issues.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      net: pse-pd: tps23881: Fix device node refcount leakage in tps23881_get_of_channels()
      net: bcmasp: Fix device node refcount leakage in bcmasp_probe()

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
 drivers/net/pse-pd/tps23881.c               | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: ff7afaeca1a15fbeaa2c4795ee806c0667bd77b2
change-id: 20241206-drivers_fix-735f56ed5ec7

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


