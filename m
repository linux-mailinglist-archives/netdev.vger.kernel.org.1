Return-Path: <netdev+bounces-127279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF9B974CFB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3B01C25CC0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4616B391;
	Wed, 11 Sep 2024 08:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5350414EC46
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044339; cv=none; b=J9VouQqMowoHSnuskqW410iPBKJGG7ngH8a45WD7+YQ0XwaVY4FR4J21kVlHEyr83dWXzq3ebFLiDz9uGsOWc9QpL9DTTs+rbPSokMZpflPP8QGc8V6h+93qYd0BMzTP1E3DauqdLE4VZvbpLbakXC0oSMmPvevPvTaLX24hju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044339; c=relaxed/simple;
	bh=KsJDe9Bok6Du9C+BSWYMCjn52SKb3MGmSqcwhKcc3kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZ1gbPLd+wjrw4gL3xKXAdylpOeARuLkPqWlQVGvkAATYRrar44la4MdFzcUZJwTS8vDhPI/jpcjwgYlWIKemK90xS6fkIUjBeUMD2gsw3/3nuyUByhMGzYxBn1FHBxiV8JbIGe2aMQRBbI/YshcUUh3aBFXa22SAUxkGE6sBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyl-0002gB-Ij
	for netdev@vger.kernel.org; Wed, 11 Sep 2024 10:45:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyk-00760R-KK
	for netdev@vger.kernel.org; Wed, 11 Sep 2024 10:45:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 50CF033815E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:45:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 115B2338137;
	Wed, 11 Sep 2024 08:45:31 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0a04ff54;
	Wed, 11 Sep 2024 08:45:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 11 Sep 2024 10:45:25 +0200
Subject: [PATCH can-next 1/2] can: rockchip_canfd:
 rkcanfd_timestamp_init(): rework delay calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-can-rockchip_canfd-fixes-v1-1-5ce385b5ab10@pengutronix.de>
References: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
In-Reply-To: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9WfFS70YrDr2qrfetTrD2fcBkV55eVvJHa3bbG4uxs8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4VinquE+Tws44QEClswYLm8kNwf80a6ISQYBA
 mPD6Zr1Ds+JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuFYpwAKCRAoOKI+ei28
 b0oAB/4g5Iqh2BWMbyXjya4wJb266mMCniZpg89eUuNb1jSWxUfSFVOkqdif+aLiaQ+MPiY/2fS
 oR1lDkgLs5zbSMwZgK5GnPgDtS7ziBYK20IdVE8Li5COjb8Wti/36hW6bPvRJ/1KMuDvJkZMD+m
 vnUP8O+8KBEBzp4YqgWSKb+XKgMt2ETWuoZscN6J7rWDrHmaavJCTBq82TpKUCVyoFW3Hn17Q+K
 xR0Z/LtOibuy+X3SuQd1ogL4z7Hf5jVtNwrjxlfmpaKYIseJCBEJMFM9r/MBmS/3lhvKnvmNHKu
 f818F71y4FhIkTCQZvzbuqrlRxGBdgGQI5MpiUfuV8aVUW1S
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Rework the delay calculation to only require a single 64-bit division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[mkl: port to on-top of existing 32-bit division fix]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index fb1a8f4e62172b06570b95e6f32c4c0f70fe1ea7..43d4b572181215c50dda9d4f8cdb2d22b7938b38 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,8 +71,8 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = div_u64(clocksource_cyc2ns(max_cycles, cc->mult, cc->shift), 3);
-	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
+	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift);
+	priv->work_delay_jiffies = div_u64(work_delay_ns, 3u * NSEC_PER_SEC / HZ);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 
 	netdev_dbg(priv->ndev, "clock=%lu.%02luMHz bitrate=%lu.%02luMBit/s div=%u rate=%lu.%02luMHz mult=%u shift=%u delay=%lus\n",

-- 
2.45.2



