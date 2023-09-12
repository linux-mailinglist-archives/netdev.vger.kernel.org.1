Return-Path: <netdev+bounces-33364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050879D937
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 20:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E827F2819D7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92975A934;
	Tue, 12 Sep 2023 18:55:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14BA933
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 18:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9524C433C7;
	Tue, 12 Sep 2023 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694544916;
	bh=mxNkHEPFMagVcGX4A+M7gEivrs30QJDxDaYd9yCe8Ww=;
	h=From:To:Cc:Subject:Date:From;
	b=MJDri5+8BKWHQ8tBxmzLk3OyfkcLeokFmdy20kAWTLrPwMy0TQuNjipTPsgYV56jI
	 ZmMjDWuAtSl9O7ZRJA+DAQd05HLxp03CfCd5VcJo5mGqa4NC04aeNQId4Iiaqt7xpy
	 6CreB7V/TMNWZ5dY+1OiYgl7YFQpfzNwPG6+JVeL8xwbTWXEZHAkC4mKdrXKM5u9IK
	 rA/dbty3Y1+sCVVz8QNd9F6ieqoXqskeNFwVcdtgpMImQXpmL0EqDKL2ngXVFIk1wF
	 HTFjxS013oR2xvmlomSSw8WXhHzI/w7dzkL6fF+mQt0NQq9kmIlneeAqIuKpLM1FIC
	 cQgbVL/dby9fQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ti: icssg-prueth: add PTP dependency
Date: Tue, 12 Sep 2023 20:54:51 +0200
Message-Id: <20230912185509.2430563-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver can now use PTP if enabled but fails to link built-in
if PTP is a loadable module:

aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
icss_iep.c:(.text+0x200): undefined reference to `ptp_clock_index'

Add the usual dependency to avoid this.

Fixes: 186734c158865 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 7f3e2e96c6e20..26ddc26fc7b8d 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -201,6 +201,7 @@ config TI_ICSSG_PRUETH
 
 config TI_ICSS_IEP
 	tristate "TI PRU ICSS IEP driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on TI_PRUSS
 	default TI_PRUSS
 	help
-- 
2.39.2


