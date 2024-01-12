Return-Path: <netdev+bounces-63308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177F682C367
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC680B21157
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5A745C4;
	Fri, 12 Jan 2024 16:17:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230CA73166
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rOKE8-0000I2-4v
	for netdev@vger.kernel.org; Fri, 12 Jan 2024 17:17:48 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rOKE7-002Bnn-Lv
	for netdev@vger.kernel.org; Fri, 12 Jan 2024 17:17:47 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5197E275224
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 16:13:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 28927275213;
	Fri, 12 Jan 2024 16:13:18 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d9b81a73;
	Fri, 12 Jan 2024 16:13:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 12 Jan 2024 17:13:14 +0100
Subject: [PATCH] net: netdev_queue: netdev_txq_completed_mb(): fix wake
 condition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-netdev_queue-v1-1-102c2d57e20a@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABlloWUC/x3MQQqAIBRF0a3EHyeoVFRbiYjIZ/2JlWYE0t6Th
 mdwb6IAzwjUF4k8bg68uwxVFrRss1sh2GSTlrqSSmnhcBnc0xkRIdCppm1sbbGAcnJ4WH7+3TC
 +7wchRTDoXgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=CkEKs9/ASN2pww0g0ug4I7HYAiq8bIX4Yqwzznlyw/4=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBloWUa98YtsGRxO4OY7nG90d2rMUTs9xKV9hUp4
 YoKoQPLipmJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZaFlGgAKCRC+UBxKKooE
 6KeICACY3D2klvan6Q4R965DSPSOZiScSg3DoNHPLut+48r26NGzmPwepHnGUvxExCKWShF8O9I
 55Q5qMSQO8dFKIoNoyrn8sitRwUWP/tJQFpg8kTwJBfcLySxyL58BVHccxbsovVPont8s9oc1Ev
 WWtYQ+gu/1RFbkuetQJF9QegiSmiqpVZD9wZkHW9nPJPWGuKTFGwHqwuPFSP/y6yOtsjzBwXmXi
 2VogySlyZSSdaTiyZ3jeKuCWEOfS/KQsAIo5Bx5+Y/LYpEolrZks8G5obTYJJOWEC+1PX/ZvVwz
 Nr6PDmdONeeBuiTwRnOGFhM9BsWzyKP+auS1SeSDhjVpH7u0
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

netif_txq_try_stop() uses "get_desc >= start_thrs" as the check for
the call to netif_tx_start_queue().

Use ">=" i netdev_txq_completed_mb(), too.

Fixes: c91c46de6bbc ("net: provide macros for commonly copied lockless queue stop/wake code")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I'm currently converting a networking driver with a TX-FIFO depth of
1 (CAN device with lots of errata :/) to the netdev_queue.h helpers
and stumbled over an off-by-one error on __netif_txq_completed_wake().

regards,
Marc
---
 include/net/netdev_queues.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index d68b0a483431..8b8ed4e13d74 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -128,7 +128,7 @@ netdev_txq_completed_mb(struct netdev_queue *dev_queue,
 		netdev_txq_completed_mb(txq, pkts, bytes);		\
 									\
 		_res = -1;						\
-		if (pkts && likely(get_desc > start_thrs)) {		\
+		if (pkts && likely(get_desc >= start_thrs)) {		\
 			_res = 1;					\
 			if (unlikely(netif_tx_queue_stopped(txq)) &&	\
 			    !(down_cond)) {				\

---
base-commit: 907ee6681788556b9ade3ad0a1f6f4aea192399c
change-id: 20240112-netdev_queue-e91686f5fece

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



