Return-Path: <netdev+bounces-157143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E9A08FFD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 13:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B29188CC7C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856B22063FE;
	Fri, 10 Jan 2025 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vMIyk6mC"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BA2063D2;
	Fri, 10 Jan 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510860; cv=none; b=a23CwSb/zEQ4KqJDC3JB5Oh0iKW+2QW8m2YbFgIWH6CAgZM9Ob/UZmQn4PrCpd+eoJEf0ss73Rm5Iz8L8COrCodXlZcj9N0g+fvHl14O4/RJbY71xWGJKbmaVE6KgVkA2vPk+bUwHLXxG//rnxyU1BE9QMk1WjGIVsi8sGWHOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510860; c=relaxed/simple;
	bh=dGyXiHXYSkXULV+7gq5B3uZ51dNtzN5PZbK8aBV0on4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgYZWABucdoXu20qLWPk9Ov9bVCgOKilErAhYHbqA6jeErREHRtRAwliXoV2hlXdwavsXnEWUB/8wulGq/X+WPhkaCnh/2mKGFl49X+EslMuAJ/Cxt4xixr8AgtxmQ7DHz2JA7U3oRSeQLijpV15BMYJFg08+Sh3Neg+s2eJaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vMIyk6mC; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736510850; bh=SppLlbAwX++5g3aw7t0/ZLyCLAOdweh/cAZUiMzXCbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vMIyk6mC8/CkJ9sjHBi7QZNLwpCCI2Rsc6fAWFJE5SRRUrJJDfNzJiQS2z2kViFIP
	 9KK9hDQ0sWsLi/bD9m8LLx9UrMQEeu2Ety+IP1mD9cXfMybaMUiHqcAbzPO8NUpbb2
	 mLyoMezgg5UOmcSQjYYMo3dpphMVjHB+XRSML1EE=
Received: from mail.red54.com ([185.220.101.106])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id DE229AA3; Fri, 10 Jan 2025 19:55:34 +0800
X-QQ-mid: xmsmtpt1736510134tfb195ql6
Message-ID: <tencent_6CF6E720909156A227D23AE8CFE4F9BA5D05@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jifP4Fsi15RpHUIitcR95FdyfWxhH2jqhuP2FXqt6AVIQLZSmHg
	 I8stj84Ve2RyxVylHtnVfVIWK7rmAHEclkYIQ39AI8jfORQkRIysKYEkuqMdbY6jFF9XPZpKjKgR
	 r5eu2ofsr7IR9emVwz8+eouymsDG9LmsYs8/I42qPfo5u2NEBNgIoG1/DTNUlqHwWqjwwijhqIj8
	 6vo1q5ereMqAmbmvMd28TbVfcjO5NmFUCd6JFEIdCp6RmREebBBAcAkkBMwS0uhbYuAAijDUNfiT
	 0neMQb+u/MtzRmF3TnugOeYU7/fKFjvTGF2JsmAAwcxpUWZig9jbOkslmw4ThwCOGfWUzMDIsbhk
	 t1NFkg5MT5o9o0FwlKnoQa5uGfV8Do2E/ePIocO2aYuuuZbudOxNGd5b2m2SRlBSGDqt71lLpovJ
	 91dJMCFa5M0sDe3mKimT7BMMAb9ngb3jtJObR3vntFXCIT+U9YZ9vWFxEPoN5ZgRhWgS3OCge+GT
	 Q7dWeTOoz9RBcnE5PMFUoIVnQ2VxoLTQEjoz7nV6p9vixmsAhnO29lxrSRhAOGwJ0YwvXOwzdOce
	 NM/+aDqxD8cwcQ4iS9guG3uPrgt1+8Fys49e6KluonC1hRkCY5Q8gfpTQ/u6b3ZM10XcXKaZMbka
	 ZPek+MBJly9J07OU5JdLdBQvXaYSGLDSwA4rbv9SOHciUfPky/0wsKakEA3r+XJvw2j2BYS4c0bs
	 pKRyFoTMj2HGPyTaxCb24p3EvTRPR59UGgnqtZX4AyNDRgdyWmzW+rrXGwPb8po+qFRf5WZLG5fn
	 2XIVVOacQMf44w4DGww6Gl9/rsbm0fcxoQjbrZs88cAQ6weOYgLCd33SCAZB5c7ABqr29thPviwP
	 FLAQjaJ4rZFpxUukwMEikC9o/pgCqQbRWIRvocFxgJnB7wypUTS1NFJ660vDsDvlD8oR7OK+gnxg
	 Tih8qKIhW0xm04we5+Ibd5FFi27cs3
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: kuba@kernel.org
Cc: =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20=28XIE=20Zhibang=29?= <Yeking@Red54.com>,
	Wells Lu <wellslutw@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Date: Fri, 10 Jan 2025 11:53:33 +0000
X-OQ-MSGID: <20250110115332.79191-2-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109180212.71e4e53c@kernel.org>
References: <20250109180212.71e4e53c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

The device ioctl handler no longer calls ndo_do_ioctl, but calls
ndo_eth_ioctl to handle mii ioctls. However, sunplus still used
ndo_do_ioctl when it was introduced. So switch to ndo_eth_ioctl. (found
by code inspection)

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021", 2022-05-08)
Fixes: a76053707dbf ("dev_ioctl: split out ndo_eth_ioctl", 2021-07-27)
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V2 -> V3: Update commit message again, and add short author date to the
Fixes tag to make it clear at a glance and reduce misunderstandings.
V1 -> V2: Update commit message

To Jakub Kicinski:
The old Fixes tag style is at least 10 years old. It lacks date
information, which can lead to misjudgment. So I added short author date
to avoid this. However, if you disagree, I can change it back to the old
Fixes tag style.

 drivers/net/ethernet/sunplus/spl2sw_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 721d8ed3f302..5e0e4c9ecbb0 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -199,7 +199,7 @@ static const struct net_device_ops netdev_ops = {
 	.ndo_start_xmit = spl2sw_ethernet_start_xmit,
 	.ndo_set_rx_mode = spl2sw_ethernet_set_rx_mode,
 	.ndo_set_mac_address = spl2sw_ethernet_set_mac_address,
-	.ndo_do_ioctl = phy_do_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl,
 	.ndo_tx_timeout = spl2sw_ethernet_tx_timeout,
 };
 
-- 
2.43.0


