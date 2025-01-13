Return-Path: <netdev+bounces-157698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA0A0B394
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D433A4DF3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7F235C01;
	Mon, 13 Jan 2025 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gYt8ejXX"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFFC235BE1;
	Mon, 13 Jan 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761665; cv=none; b=SgoivqC1kqJ90Q2l09PtRy/PwnXKHO9Uwq/uaX0tICW3jEz7AuJ2Qj/DKBuBohRSDwXabDKdgfWdrR/ziI2O11jvJTB39G7cVRALZ6pPO9xqmj95/g12NsLLqSu0JUtj1tOL9LNzRiggi4tis/VngtOVLl1yYZGPfBkbmxVZp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761665; c=relaxed/simple;
	bh=r+T1p5CixKbGFH66eBDxjVN1xnclKueAwN2x9vZhbso=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jb5VHnxs1FNy43QA/uglpY4DS9X4QsiFay9ZC4rwwZ4SC2wBFk+42pFYPGdS83FVQJvMsE6OQFI+NR7AH1QNzkaHbXsnGx94cTwSS0HSPyaCJDwyGx6X8G4SXJcj4WalzwjB+8Mo5ct9M2lTpCSYyetMzC95p0HLnU6IcSws97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com; spf=pass smtp.mailfrom=red54.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gYt8ejXX; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Red54.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red54.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736761353; bh=2UvtDxOV+5yVrrcHRwHZxj+kVtZRPaDDdFm5rO5bOBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gYt8ejXX6R2uylUT5Ap+3f4q3Rb/R80zMzH0YRRuQEHWShSvRcekvxv7GmiKJZ3vf
	 hTigW15a7jPZDDfgboy12uC4a2zPI9F/1mvVQX4RotQxLaJqabod1TFDtmIb7cqiSQ
	 R2raJ6YJ2VrKixlQ/7UpCRWezQ8lpu1yJpxGXfGY=
Received: from mail.red54.com ([171.25.193.79])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id A8F8D474; Mon, 13 Jan 2025 17:42:15 +0800
X-QQ-mid: xmsmtpt1736761335tah1uxfxe
Message-ID: <tencent_8CF8A72C708E96B9C7DC1AF96FEE19AF3D05@qq.com>
X-QQ-XMAILINFO: NcC2/Q4ACKgy5h67QW8b3z8fwpmZnCfTBTIJC2GVLbOGaw4qQy4bwI8G/DgKcU
	 NvBjPsoTIL11xsTeRMfp7swXCL5KYg7dSww+Wvqm/laSj3C6iincIGfI3BuU3k5PdkU/xuG2wsMd
	 Zjx1VOieCI9EG0YiLFhXLf4T3hcgj6G8DTk35P4h5Y5uFSFsAtdeL3PUJjvqqSFop64tMlGAwGec
	 v180jcWhC5ArwtWKXVH5Nh13V9Bn0Jv0CfV8IOXpupYY8HfA6TBuSYl23pF2NtHkLOy6Vf04VkoL
	 aEg8O7Q5SWiAjlSxsKotr6tvVA/kWaFYheuOQVjzmWknD8eJl5CNsQkFTP222g5Bq6xyPiMTvQoC
	 Rb+QHK4MR9LcFWfchu/jQeMN0koYJxjS+j6xO+4hbZdtweCTzily8o9p6mhiYh1I5TVhGHdgHukc
	 GcBYgapy8p+YWlBUOEBwp3Vnm/Y5Y3I9HRWcNo3xI7FZjgrGApWmaUEySV3NlBstHAxETAdn9+ix
	 3JY0+0JmJpdLfa9WymYUHH3xTu+HoHvUyWh84QFwkaRXS60tNAL1kSOppg8WIEtQZI37NMtJ3Csq
	 DevFYLmfW3zVGJilCIiq7H/oVa1oeo/TBOAjwjZuIPhSJSNp2roaw3ht+FcS7/wbI2IuyCAy5Yag
	 eKnR4V5A8ErUWxEGJyYyCPLS1ZOj35r7DOc+TYkYM5NO9+HaJGbN/mM1QyJlgKxTN25oiJgL+K57
	 qhPBWK/o7MjCcnI6Y5Syl5WMAF3cTgZyGS/6O2mCc9TuHU0F3tQDAVIo1/oYJA92a33YHImYQxeO
	 diJM0Dg7HJlm1e8MG7m87Z77igEny0DAemjLmzmXxeXG7rU4c14ROdLUDxfla6NlxK7MU7nw6t1s
	 aYGiH6YWIE+oJarVqr0acFxjBKPzXSHzraZh++6o9e8w2/baW0VDCR4YmuKbxxUuLuwKe2Kd6CNj
	 QDYu9zl5DOpZwraJa246TMYaikCfP8xcEGm7bmkQA=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Sender: yeking@red54.com
From: Yeking@Red54.com
To: kuba@kernel.org
Cc: Yeking@Red54.com,
	andrew+netdev@lunn.ch,
	arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	wellslutw@gmail.com
Subject: [PATCH net v5] net: ethernet: sunplus: Switch to ndo_eth_ioctl
Date: Mon, 13 Jan 2025 09:41:56 +0000
X-OQ-MSGID: <20250113094156.141741-1-Yeking@Red54.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250110175737.7535f4e7@kernel.org>
References: <20250110175737.7535f4e7@kernel.org>
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
ndo_eth_ioctl to handle mii ioctls since commit a76053707dbf
("dev_ioctl: split out ndo_eth_ioctl"). However, sunplus still used
ndo_do_ioctl when it was introduced. So switch to ndo_eth_ioctl. (found
by code inspection)

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
V4 -> V5: Update commit message again
V3 -> V4: Change Fixes tag back to old style, due to the objection from
Greg Kroah-Hartman.
V2 -> V3: Update commit message again, and add short author date to the
Fixes tag to make it clear at a glance and reduce misunderstandings.
V1 -> V2: Update commit message

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


