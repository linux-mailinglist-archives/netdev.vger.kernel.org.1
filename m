Return-Path: <netdev+bounces-127277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBF974CF9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EE81C25C22
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D274015CD78;
	Wed, 11 Sep 2024 08:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C0154BE2
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044338; cv=none; b=DJyeHNtD2Q8RbP1JNbntrqvC89UU6s8LXHLk34fMyfW7qSUXI/2IQns3g1lokdP5Z/UsSFo1P63tAtTAW2aMAGzsglJpUvy81wGBgSGXmUmPku5cEtsXAAMBM7lg5rlwwu0tL+XNSy7R4jdrlWli4t+U65foYifrlw+71U49uLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044338; c=relaxed/simple;
	bh=z1Sls2n11L+NyqRyx21XaMNYbilJHnl4mnyykHR+kB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lP26hSpTuQleI0MAQ6OapFhUJcIuwvHtIQApRCXv0Av1eVqbwaXehw0zZJGfJL1cAn49dTJ2mYoCR+w0CGfI+KWdqbA15Q2qNCFzdpB8846odOHomyjug/+MtAJDQpzIWpjkHIw3SnA/t8L2dosDsk2E3iWyQYEF5yIuZjQIwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyl-0002h4-LE
	for netdev@vger.kernel.org; Wed, 11 Sep 2024 10:45:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyk-00760Z-Rd
	for netdev@vger.kernel.org; Wed, 11 Sep 2024 10:45:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 7B9AE338160
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:45:34 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id EAA84338136;
	Wed, 11 Sep 2024 08:45:30 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1821535a;
	Wed, 11 Sep 2024 08:45:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next 0/2] can: rockchip_canfd: rework delay calculation
 and decoding of error code register
Date: Wed, 11 Sep 2024 10:45:24 +0200
Message-Id: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRY4WYC/x3LSwqFMAxA0a1IxgasP9StiEhJUw1ClfbxEMS9G
 x0eLveCxFE4wZBdEPkvSfagMHkGtNqwMIpTQ1mUddEbg2QDxp02WuWYFd6hl5MTVtSYhuu2s86
 D7kfkL+g9wnsFPn8w3fcDZrbRQHQAAAA=
X-Change-ID: 20240911-can-rockchip_canfd-fixes-3c515e468adf
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=z1Sls2n11L+NyqRyx21XaMNYbilJHnl4mnyykHR+kB4=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4VilI0P9TBDe89yRWf6HL3KJAgbMZjw8r7kTS
 DuF7qx7jVGJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuFYpQAKCRAoOKI+ei28
 b3sxB/9K+4jwWrSFXsxaF9hmc0HDQI2tlaPXFcnWO26UFF6XTq5QHVukznE9iHMTKApMsRStFag
 hcO83Z959iDeFd72z49okZRCyYTm4pXHdD1+tLllaBdc3MwtqAV+TO0WUQ/mA614QhZXzrTAmBi
 wCsobUxr2x75uD8AccRRrhuPBHB6OwyZVqAs+w3UCVcefpTr7y2WZ3SPkfQQthzlNRyytjsrOp6
 8aTTUrI+cTbFRn1sYHKfyn4eaaAQ5IrNvFhj8vwD0Bq/bQu30TE5+EYeDYI7+xL7Xhb5oQyyg8R
 3fBtyk609PyTmnwQ6a5ZV5oCNxUnLF0Fsa/aTkSL7gMG6px7
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This series updates the delay calculation for the timekeeping delayed
work and fixes the decoding of the error code register.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Arnd Bergmann (1):
      can: rockchip_canfd: rkcanfd_timestamp_init(): rework delay calculation

Marc Kleine-Budde (1):
      can: rockchip_canfd: rkcanfd_handle_error_int_reg_ec(): fix decoding of error code register

 drivers/net/can/rockchip/rockchip_canfd-core.c      | 4 +---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)
---
base-commit: f3b6129b7d252b2fbdcac2e0005abc6804dc287c
change-id: 20240911-can-rockchip_canfd-fixes-3c515e468adf

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



