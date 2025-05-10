Return-Path: <netdev+bounces-189442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE5EAB2134
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 06:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17719A063F4
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A411CBEB9;
	Sat, 10 May 2025 04:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F21C5D7B
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852507; cv=none; b=SJyLjnEUZiKWzteXCw4ivWg3sBOhA4RtDC/14hXQi4DAuR+amtfF9iS0Hma99aa3IpNexiCq3ORT9wDI9wIFnq7qJhUELZIiJrry2E/fojXcNHLknF6WVilVfG/GP3s8HaFyo3L8qMVK8G2LP7gOg2SKIn2jq50+l8Q8KkkM3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852507; c=relaxed/simple;
	bh=54um06UYwdjS1cGkgUJzwQjSSiNDtqmLRM+75g4bxUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sE8mCt9AGlsO+HJVAt/Yk6LDfia54DT/cK2y3iQU7WPjR+a9EkWG22KsDrLUxqg3i9hq1LQBFgZ84pz6uhrr3B3mn8wgOLI0zMqttIvGSXqHQ8YRQFSp/Y6gO3doVjS9Wh6w4zyaKsX/w288jsdARd2boN3YfG5O9po2DCigU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1746852331tffc1f23b
X-QQ-Originating-IP: 4+gpm76m/G0Fv/YQxwOMRFdJ+Ya4cvAb6GmOGZKrxFU=
Received: from macbook-dev.xiaojukeji.com ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 10 May 2025 12:45:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15960051894760270678
EX-QQ-RecipientCnt: 10
From: tonghao@bamaicloud.com
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 3/4] net: bonding: send peer notify when failure recovery
Date: Sat, 10 May 2025 12:45:03 +0800
Message-Id: <20250510044504.52618-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250510044504.52618-1-tonghao@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MowohnWo6wX75KBabTSylOmOLDNLEHTSyPaS+oHaE95xfSUNVngYj6DW
	csDUgJgi423o2Zhlzrt+UBSDcvSR5WVOE6+JbVsvFGPPwYylvShg0XPeyi8GK41gKNeRycp
	ZQD1F7B1SPhAScdwqJ3DW80JeWKLrB3AHd23s6OpazZh9SliClbU1SY8G5JWBrIMi3H+QjO
	ssMUtWeQI4eiWafxsPHDqgNLlELv4AJI9D57D56HJCqzGrgm54YopesFuWvgAm8LTNam3/U
	wRF7FXcxdAH8ca8jw18ISRNL8bU28HBk2OAzxJoO5g7HJ/xjjB8san6As6K4DdKgUSyxP3r
	/f9EJ8e2aFoSYN+59n0DWHrVQqmBh11Jd6yf0U81yIO6J8kuXaEptnpsEW+P+gA2cs8imC8
	0t9zri9+AS6cQrnRkl93rfSDG3Jbsdg3tmU7yNn4rspp9EQ7BobZVgFjeyN/5m3edah5/Rf
	6pIQs2D4U6TaSugyTCuBsC/aeDd43fGdICdqyBlnC+cPoKpPmXeGWUAmtKkoj23K42MN/Ek
	YJ75hA5NUUabVbe0Fg83qQEf83Ct+1Z9DDPh+9TIoSgC004GUMF2F+8CczB//djzOrAc4Gh
	3FXHwRZ3/Ikun7zqRRbqNi7+IPhGwrQ2UeKfS4wJgVsWTgbulzd4Ww3HDQlOudgT7rFgrjE
	JZQogMN4IGmCV9vpFXIvTUS2I9GL47zWMPfCL8h7azqd8layPWpWoErRyx0vumQsTJj/2iQ
	2EQID8F0Uiw0TfBCYKAbRh+At9iNRxjFsdhW0N6cLpkXOEGh0CeamRVJa4YzbiqmRcxhAu5
	kYRfr8dnIlcaHIQyIlDwrXZJEsqb5zel6qowQhGgB2bq1xgK9JMQ2H//USfxy0xpSZr9pEk
	0KBMsqd4OL6ZIIG2dXrOo58l7pQKho+WkklFCvqTAGwIOD9yl2hAllMLm7mTXM5tcGupelH
	WPAp0hs36CrRCn+2ZE0/eJE/p391e6M25fhCmzvM4rOQn2FY2KGVET+Om
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

From: Tonghao Zhang <tonghao@bamaicloud.com>

While hardware failures in NICs, optical transceivers, or switches
are unavoidable, rapid system recovery can be achieved post-restoration.
For example, triggering immediate ARP/ND packet transmission upon
LACP failure recovery enables the system to swiftly resume normal
operations, thereby minimizing service downtime.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 drivers/net/bonding/bond_3ad.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..6577ce54d115 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -982,6 +982,19 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
 	return 0;
 }
 
+static void ad_peer_notif_send(struct port *port)
+{
+	if (!port->aggregator->is_active)
+		return;
+
+	struct bonding *bond = port->slave->bond;
+	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
+		bond->send_peer_notif = bond->params.num_peer_notif *
+			max(1, bond->params.peer_notif_delay);
+		rtnl_unlock();
+	}
+}
+
 /**
  * ad_mux_machine - handle a port's mux state machine
  * @port: the port we're looking at
@@ -1164,6 +1177,7 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 			port->actor_oper_port_state |= LACP_STATE_COLLECTING;
 			port->actor_oper_port_state |= LACP_STATE_DISTRIBUTING;
 			port->actor_oper_port_state |= LACP_STATE_SYNCHRONIZATION;
+			ad_peer_notif_send(port);
 			ad_enable_collecting_distributing(port,
 							  update_slave_arr);
 			port->ntt = true;
-- 
2.34.1


