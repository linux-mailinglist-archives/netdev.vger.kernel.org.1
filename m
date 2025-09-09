Return-Path: <netdev+bounces-221245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46B3B4FE31
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4417178541
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FE343D6B;
	Tue,  9 Sep 2025 13:48:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573E33EB0D
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425729; cv=none; b=dcek3QGpBIdF71urUWhHBcGtvWZCaBXHAq+ajFdhctmbBlQCK2mVHDnJlvo25EuGqp9lndaxe/UAjOo6dCYNj2XRz8xpk3RIDtmlnZa69FJ/RQoY6Qk9hp/UIQcVrgYh0jGq0TpUXDF1GMUNs+IWHLvg5SXJ3E38KxZvKwxiJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425729; c=relaxed/simple;
	bh=lN7Bz6VZzaO9UZ45VkLrICZaXV0AFbELXh06zyYEfBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onuoxpURjH4JrzKRogOziq8YP/oFrEn3bjrbYEVdGeLfHNzP4g6iQF6G6nOFsDr5o1/KtDBNN2X/HRlDREawON/75qhw5WTWw8hK5h85fAU/l3z4op7oo8/bPrhZZVS35lonfY7xvblfuKqdHXgea0ZH+D2PBkINGjteX42//Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiD-0002l1-I2
	for netdev@vger.kernel.org; Tue, 09 Sep 2025 15:48:45 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uvyiC-000QmF-2i
	for netdev@vger.kernel.org;
	Tue, 09 Sep 2025 15:48:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7904046A053
	for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 13:48:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6069A46A025;
	Tue, 09 Sep 2025 13:48:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c3126140;
	Tue, 9 Sep 2025 13:48:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Davide Caratti <dcaratti@redhat.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a module
Date: Tue,  9 Sep 2025 15:34:55 +0200
Message-ID: <20250909134840.783785-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909134840.783785-1-mkl@pengutronix.de>
References: <20250909134840.783785-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

A proper kernel configuration for running kselftest can be obtained with:

 $ yes | make kselftest-merge

Build of 'vcan' driver is currently missing, while the other required knobs
are already there because of net/link_netns.py [1]. Add a config file in
selftests/net/can to store the minimum set of kconfig needed for CAN
selftests. While at it, move existing CAN-related knobs from selftests/net
to selftests/net/can.

[1] https://patch.msgid.link/20250219125039.18024-14-shaw.leon@gmail.com

Fixes: 77442ffa83e8 ("selftests: can: Import tst-filter from can-tests")
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Link: https://patch.msgid.link/f1b942b5c85dda5de8ff243af158d8ba6432b59f.1756813350.git.dcaratti@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 tools/testing/selftests/net/can/config | 4 ++++
 tools/testing/selftests/net/config     | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/net/can/config

diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
new file mode 100644
index 000000000000..3326cba75799
--- /dev/null
+++ b/tools/testing/selftests/net/can/config
@@ -0,0 +1,4 @@
+CONFIG_CAN=m
+CONFIG_CAN_DEV=m
+CONFIG_CAN_VCAN=m
+CONFIG_CAN_VXCAN=m
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index c24417d0047b..18bec89c77b9 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -120,9 +120,6 @@ CONFIG_XFRM_USER=m
 CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
 CONFIG_IPVLAN=m
-CONFIG_CAN=m
-CONFIG_CAN_DEV=m
-CONFIG_CAN_VXCAN=m
 CONFIG_NETKIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_IPV6_ILA=m
-- 
2.51.0



