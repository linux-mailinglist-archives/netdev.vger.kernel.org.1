Return-Path: <netdev+bounces-227874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C2BB90F9
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A64189F4B3
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9762222B4;
	Sat,  4 Oct 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b="CHkfoke4"
X-Original-To: netdev@vger.kernel.org
Received: from out8.tophost.ch (out8.tophost.ch [46.232.182.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F553594B;
	Sat,  4 Oct 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.182.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602429; cv=none; b=jXbYgiG1jzh7GTStq8RRjczsMIKDJxSOW2FBHswrVGDn+By3IGBydsxWT5BybgqJfKMiv2EYUMnjHsQwXwC2RSU45sF37yWu9hu+sJRcwDSUS82BRT6I/vDv1/X5KHkb6P32OSK1/jUswS1qnThSGj289s8Z7bhzPNOXwbpu97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602429; c=relaxed/simple;
	bh=aaAL1ZjE8/RUjANNkQ756JVzAIKsnpo5g0LdUIMWjXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orUBvbTlr2cAcRWPRFqmvT1WiFBhk+Tuovq78xOt9h280E1Pxe4JWvo31vnU3PczPq39HxO9i3PGVYAFzePFu+IIhzyU2JZYiC+pFIH6pXaGQ5RrWC/6NV4G6syu/K8hViFxD7peeaHQ6ao0Z8traLTjSYS6BF1BguZ6i8OpoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz; spf=pass smtp.mailfrom=wismer.xyz; dkim=pass (2048-bit key) header.d=wismer.xyz header.i=@wismer.xyz header.b=CHkfoke4; arc=none smtp.client-ip=46.232.182.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wismer.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wismer.xyz
Received: from srv125.tophost.ch ([194.150.248.5])
	by filter2.tophost.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56cT-007JBN-Ua; Sat, 04 Oct 2025 20:04:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wismer.xyz;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LlyG1IJXvba9MKr6Z3HkiagOcCNkkc+YhGxvzBHtazc=; b=CHkfoke4MqfPlxp1l/OQguJQuV
	hLQrFP+/jyjK0PcR9cAkdCpzEbWvSWpYAPeI5bSGOxT7Ae72At9VG5kHUTgIySEtzhN2PXCFpnVAF
	0EHRAQViY4QTKY3gmjnx9hGKKEBi6U0t4BYAxZ7pGfMZ74EBMwwhiMzJ9Wl/sTUchKhuH6QPQWI3e
	xPLRyYhZ3WoFMFOP7KFyUMsTx9XDDO0YogHVnBr/Ztscs7znC7JT2qojnPypzLxem0PtiXjiQgeCL
	1VRorXsKqvSnpuO+YOlkSAt4ZoEELVuIBCF4NIY/dIqgnbyjPqpJvCVRi1ZY7IqzBsOU8x1NNPXfF
	nldKA5Ug==;
Received: from 82-220-106-230.ftth.solnet.ch ([82.220.106.230]:60199 helo=pavilion.lan)
	by srv125.tophost.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <thomas@wismer.xyz>)
	id 1v56cT-00000001wpX-2KK3;
	Sat, 04 Oct 2025 20:04:31 +0200
From: Thomas Wismer <thomas@wismer.xyz>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Wismer <thomas@wismer.xyz>,
	Thomas Wismer <thomas.wismer@scs.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] net: pse-pd: Add TPS23881B support
Date: Sat,  4 Oct 2025 20:03:47 +0200
Message-ID: <20251004180351.118779-2-thomas@wismer.xyz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Get-Message-Sender-Via: srv125.tophost.ch: authenticated_id: thomas@wismer.xyz
X-Authenticated-Sender: srv125.tophost.ch: thomas@wismer.xyz
X-Spampanel-Domain: smtpout.tophost.ch
X-Spampanel-Username: 194.150.248.5
Authentication-Results: tophost.ch; auth=pass smtp.auth=194.150.248.5@smtpout.tophost.ch
X-Spampanel-Outgoing-Class: unsure
X-Spampanel-Outgoing-Evidence: Combined (0.50)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuV5syPzpWv16mXo6WqDDpKEChjzQ3JIZVFF
 8HV60IETFiu2SmbhJN1U9FKs8X3+Nt208ASTx3o2OZ4zYnDmkLm5Mv/tafLC72ko3Lqe/Da7zGRu
 tVdZdUk4la24/lWb/vyrAP5R/Cae/ZemygD++WnmCtmoQhY2xrBb8C+tWUvqrqBKsSdhvd/J5sX5
 daZjkYsG4jVZi5Tfop5qjCZejidXzthz0vNkOX8Em4cj6D/wdR983ISMXlZYfkTQnVvsLb89W7vD
 6C469DIPe8wH3iOJ3xyMg3et4b3PQUopDmbZCssYHNuxAmlPRpR5yzngsxCROUzReCS8EpKh0It9
 L25JS816nuiE0t5pG6MLXGczoanVmeCF7bI0BP7dENKtPTBPq+vGO3Vx+SwwWschmkdvs376y2A4
 OBi1/UyqO7jQnnICeA+KlS7G8xqewTcs6w6HLg3eq1lKkYVFbZT99AeINpdbOTIWFiLv1jhppNXa
 xS6MN8xFxlxHZge6OlcoYA//qN5p5dmu6xjQN9nmCfj7VmpmZJyx9iy0UVkVD75IgLollI+8fg4q
 Ktu8I/h2Z0dHZM6qE0STp2v0JiRE8jhamJNIkblvt3tmDvgtmN4H4BUM9bndab3XlnlqHqi4QKnn
 k14/ADuPHCWFyNV2T+avjL9wVRCXwYDpBqMLHNY9B2Ak8LmqWByQuE4NgLCNvMovQedDpDK2Sljn
 CNAO7NpcpxuVcnpyy186dygqpmiD9OtONQZ4S919qVAB9i6zlzTjcVXthHorhNpu23mgOZsC6pUL
 aCdNIXkTykmnK/9/QX3JlnOAYOwvgs4sv7ykOBxKEjX2P24wm2Xm0Zxro1P7++DuIQUs/5JJj4C/
 n4CILsmQ0SO9CeLTQh8bH8PiEW+tX7qDfij/psJ5Sv6V58b1kyiK9aRmotIe5mkuhQ50hdHxL8fL
 MkT6TDHnwvPD+cRl6DbasrEImAe+fJfqFuhNsSc9CgHJcMu7KTfBvyswr4sEMysPur9wmiDBurOy
 6iQJ5124E1ny/UQRZHHLkqd13aH9Eyp21gmT7cyCAVA5VIwTo2sAmG9WZnbp9bHNxXxTu3T2QkkX
 krzDq9owtXIcExAHlwca76VdLw2GWIYs+ljrnXdo8M1GW0TnoMpI3UJ+pvlHhV6a5QjptwQBGybQ
 vv1ToHZWNpcnifjzWnmjtnV75K45oykd3VjIUdJS/eyxyfnoc8x6re2H7v/VN3foTPbrWOwDJFM1
 LKpMibQ88o0ORb/rEGGznznyI8PFeRBLZ0Kc+vvfWass5t8K0zA0uhq/IGZ0cCvl49xdmzHJuw==
X-Report-Abuse-To: spam@filter1.tophost.ch
X-Complaints-To: abuse@filter1.tophost.ch

This patch series aims at adding support for the TI TPS23881B PoE
PSE controller.

---
Thomas Wismer (3):
  net: pse-pd: tps23881: Fix current measurement scaling
  net: pse-pd: tps23881: Add support for TPS23881B
  dt-bindings: pse-pd: ti,tps23881: Add TPS23881B

 .../bindings/net/pse-pd/ti,tps23881.yaml      |  1 +
 drivers/net/pse-pd/tps23881.c                 | 67 ++++++++++++++-----
 2 files changed, 53 insertions(+), 15 deletions(-)

-- 
2.43.0


