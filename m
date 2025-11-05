Return-Path: <netdev+bounces-235777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF4C355B5
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D39C54E5DAB
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BEF30F814;
	Wed,  5 Nov 2025 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qe/aFmJS"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307972DF3F9;
	Wed,  5 Nov 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342111; cv=none; b=Hhxwp//TQDNHZI/tM1FacDcKd+2eJREiYNpbRqeOoPjCKkcMJgOLR6UF5QwkEMtref+7WejfUmtt2dSkxuX/r7NqfTbMtsaRymdKLyZVmEjYEkcMjfaxr6K5UwXb9FTRvaZkGKV3tItKQnPZQuFTOhb3+pPv6hc5S2urDr8sRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342111; c=relaxed/simple;
	bh=w47xBcuMg06xjoFaJzzdgZahc81scB/a/eUlVqcZS8U=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=h9tcNsVMDzpfSbX24XuL5NJLjTCl8hly2z2F5DgXMB5xF0ceMKvwoGnLkKO/NfnwOBnfz6Fe+a8JAWVYnIu5skKZshHrtZO9bOTFz6v+KtfKR3hR0AjE/Nn2byDtG2csvuuoVtqsaPY/7zlSjA1uGFjqWsXgLfHfHzNuF5xSFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qe/aFmJS; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762342103; bh=hZPC+fHUcP82seNGfrgAVOlT7ODrX/JE38X7yy+Y5fc=;
	h=Date:From:To:Cc:Subject;
	b=qe/aFmJSPFr3JImfVModKruz+gVF1XyI7T+f4aE/25LmOh3GskvJO9cx39g3/wgzV
	 f7/dHrenmfSTm0cVPI9EqylI3vadXwUUko0ZDn7g/ktdtiLbFz+MT1O6n0Gsr6KTiL
	 Kdn5CJ+jhj1iYkV9AN95d4uFiDzxh9FWKR21ih2o=
Received: from cjz-VMware-Virtual-Platform ([110.176.31.207])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 71492442; Wed, 05 Nov 2025 19:28:20 +0800
X-QQ-mid: xmsmtpt1762342100t1frdw4ur
Message-ID: <tencent_DCA505773DEBA2EC5F3B04526C606AD6A608@qq.com>
X-QQ-XMAILINFO: MlsYLnHA0UVjGNCr94CpU79QH5oXVzM4dgXD8MIrZnDRS/jh0ZxU4mWOditSnY
	 NkZjgnhz696cLNHFL6xHWJRbjpD4xvNEE1ZyVhYBmtl/IiQMXbkBgDEObWygG6Yr9qsH+b+IyJFa
	 50ZE2fmjVzExIoKpWNjkIi9C/7SGRBBQ8B0dJYBbb+pzvS40vLRpNmy2xmoJYaXsQgGQF5yLnvAE
	 3Iugg3u5b5dwIM+iyPJrD1MouXr8Ug+nTDakjEbySZ5+QDkIT6WyGYD6LXST1FsgvlHiHnOlMfMv
	 knNkFSVaBugrUZeZmEOsKhV3CnPK5tlF6gv1QuqlB6tSO10tOIWGpmgEOz5eTHyFgMisv2acuXDE
	 hJfhHdHXdrR+jCzfn/XRnyagDPmXwkVYQ5BCJmuzd7FYgd8RdgIps0PmSBwqnJMQP8N4Kty4MqJQ
	 /uitoVVHWiEd7vRW0tRQakva4LPprvmi970obpuYTTCaKjuuIm+T1gI9Mb0n9zpCEOlrPLdw03KF
	 b1yen/oS9w+KBV5Xs16OkprabY2d2UEnhbOmYZbMzMBS9fiOHexkLX29Eu/gKb5KnXOf6vaBm34V
	 NgHsRy0HYSHbheLXiLGOWsE2WhvbPl3QJ4OwFpFC+ep/6RdsdpmZ11cs3qD8fbcpvl6onnw8xErN
	 JWLy61q3uX2T2M5zHSDLDaN6m/DI1itpO2a+DFNF8Vg8CaaIAhz6lfxB3N04JZVMiXiXfSglfJ5h
	 eE2PTNQLCpdRuHobiDUHLl1aobpOV3j/KLaC9Gs6SG19GiNITRCzqq6fP/Elc9/l41pC8BVKjzVy
	 GgvBg6QrolePNAZnYFjip0Y16tJxf/vj4BWFvhpTQluXPjgCyTiLWgQyRqPnPV8jNpFjVZya1Fip
	 bYCZzpGIBkJePI3Zuo3DX7qMV7o+l+ZjVVex+nRKiwHXB1yipZz4Olsd0Tua8VHKlW2nr5Si4tlz
	 8DqgOBG9TTYGYvkaFPp1IHheYgxMa4
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Date: Wed, 5 Nov 2025 19:28:20 +0800
From: Chang Junzheng <guagua210311@qq.com>
To: rafal@milecki.pl
Cc: bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: broadcom: bgmac: add SPDX license identifier
X-OQ-MSGID: <aQs01M0qRsMNEuOR@cjz-VMware-Virtual-Platform>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add missing SPDX-License-Identifier tag to bgmac-bcma.c.

The license is GPL-2.0 as indicated by the existing license text
in the file.

Signed-off-by: Chang Junzheng <guagua210311@qq.com>
---
 drivers/net/ethernet/broadcom/bgmac-bcma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
index 36f9bad28e6a..2f32874698ab 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for (BCM4706)? GBit MAC core on BCMA bus.
  *
-- 
2.43.0


