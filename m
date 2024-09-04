Return-Path: <netdev+bounces-125292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744F96CAD4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C298B24B32
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B171779A5;
	Wed,  4 Sep 2024 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IbFn0LTk"
X-Original-To: netdev@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECD14D2A7
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492980; cv=none; b=WVBR3EBqBHUwJx00Sl4rupuegvgXyAwpsylLlGdyKN10qKK3/a6+1/P97g58cBOlO8zRgkjRjsIjMUlA9yhxYUWrjQiBCB00XztnPrwb6WIrlNTWvk7vXrydriUuqzl0c9CSnbycvky+5PBu3VN/oMS/GYWPfGawR0YTfjYllUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492980; c=relaxed/simple;
	bh=gGKTS5e69eGwsuCxPYviwNkaaS50fkXjlI55u9zXG/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lBs47gwiC5likLwOijuPSFOIn+CmGV2GJbYYkmRee6A/1+0da/EZhGZOS5hgkhOMpDMGabUItDWrGvVryDwm7eqQrCqdKmYeXef8S2Pb4A+js0dsvYCIeb/LPcwSqIpBnEPVJvR1hviLAQ/IQk2R7pDrL5RsVWYiOYB+8ake+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IbFn0LTk; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725492979;
	bh=9rDPKSc7WMZoY4WpNOd2VKz4Iu3eG9WY3g92yxKTVKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=IbFn0LTk0cC1B27JOHB1R1BEnvJd+wa8mFOoYdXmu5yJWsDetqbbE3FUiwtN3jFTN
	 4en5DNJy/tB2XAcXHw6ZkEOD8bgW8/qxh6+stssXlZP4sqi4qt541aAxTB6uBe6xS5
	 Rh292rXOYoxKF9fkPhpxtlJ+tHn2uJ82xPhGKxAb8lGb1e4MvVCacK9Nteb5WB5qtz
	 S37kRpHecrIgwPbSxky5DO+pXHkIeor1CUSnuCqlgA9z8D5A+uHhc7g3GTcBNxKC1a
	 xE7Zs7JFqGHiV6FFGwYfK8ORa7ETqA4mojgNwpuwd2Bdu24GUtmj6fGmgmBTmpnDaE
	 s9B0N+mCKfeIQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 5B64D800063;
	Wed,  4 Sep 2024 23:36:11 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Sep 2024 07:35:38 +0800
Subject: [PATCH] net: sysfs: Fix weird usage of class's namespace relevant
 fields
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-fix_class_ns-v1-1-88ecccc3517c@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMnu2GYC/x2MQQqAIBAAvyJ7TlCxoL4SIaZrLYSFCxFIf086D
 sNMBcZCyDCJCgVvYjpzA90JCLvPG0qKjcEoY9WorEz0uHB4ZpdZ+pi0D6pfhxSgJVfB5v/dvLz
 vBx9d2WNeAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Zijun Hu <zijun_hu@icloud.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: nYYn2LZ9ZsL0_a6pdNzhYxjTe8JmaiRJ
X-Proofpoint-GUID: nYYn2LZ9ZsL0_a6pdNzhYxjTe8JmaiRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_21,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409040178
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Device class has two namespace relevant fields which are associated by
the following usage:

struct class {
	...
	const struct kobj_ns_type_operations *ns_type;
	const void *(*namespace)(const struct device *dev);
	...
}
if (dev->class && dev->class->ns_type)
	dev->class->namespace(dev);

The usage looks weird since it checks @ns_type but calls namespace()
it is found for all existing class definitions that the other filed is
also assigned once one is assigned in current kernel tree, so fix this
weird usage by checking @namespace to call namespace().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
driver-core tree has similar fix as shown below:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=a169a663bfa8198f33a5c1002634cc89e5128025
---
 net/core/net-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 444f23e74f8e..d10c88f569b0 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1056,7 +1056,7 @@ static const void *rx_queue_namespace(const struct kobject *kobj)
 	struct device *dev = &queue->dev->dev;
 	const void *ns = NULL;
 
-	if (dev->class && dev->class->ns_type)
+	if (dev->class && dev->class->namespace)
 		ns = dev->class->namespace(dev);
 
 	return ns;
@@ -1740,7 +1740,7 @@ static const void *netdev_queue_namespace(const struct kobject *kobj)
 	struct device *dev = &queue->dev->dev;
 	const void *ns = NULL;
 
-	if (dev->class && dev->class->ns_type)
+	if (dev->class && dev->class->namespace)
 		ns = dev->class->namespace(dev);
 
 	return ns;

---
base-commit: 88fac17500f4ea49c7bac136cf1b27e7b9980075
change-id: 20240904-fix_class_ns-adf1ac05b6fc

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


