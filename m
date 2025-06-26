Return-Path: <netdev+bounces-201498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD3FAE98FC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511936A6277
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FBF2BEFF8;
	Thu, 26 Jun 2025 08:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2FA255F53
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927770; cv=none; b=A0JsPs3NJKRXtMHcsiNLpIbDxXvtMrt/CxdGmKSyc4SPITA4MiYGfujgySF/gg2c/GOAh6+ewrPsrQU034fUoRQsHPwrUKXfqnnedE+cc/24AZV4Ov+qEvCaDW3EjhCK2qkVvm+cfEyth5wy8xeJ+FfYNr+fcw+weaA76UTm7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927770; c=relaxed/simple;
	bh=4psFpXt82qns/uuvjl9Uw9Pe/mmvssEmjnWA0QTfCPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7QqkMoRfdy/sSIAOZX/MezudOXeluhx5qBKMw+cs36gIp2Jxz5HyUg4g30j3SgrT9sIRZcmxrGgElzjxxY3IP/KhNFyz0iHAqXslIo6GIB89vTUhbLJWZUqGn8fYw11TVA7B3MIB6oiyKrn0jpGB0xPIS6ey5ITxAcc+aeaTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1750927699t500e887b
X-QQ-Originating-IP: EfQTCNqDGVIQ5crNk7cifpamRPr+Bk2kIvgdt5Id4J0=
Received: from lap-jiawenwu.trustnetic.com ( [36.27.0.255])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 16:48:16 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17449456144270092963
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 0/3] Fix IRQ vectors
Date: Thu, 26 Jun 2025 16:48:01 +0800
Message-Id: <20250626084804.21044-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MBNbvlyee8Y4Yjkz2klBO/SqbMxwCi7IZEjTitZKLJ4Fx+erthsmVkOc
	hWRh9+VDsMf1tKFWDbYvqsl2gLpzDtEQ56DELVWcjZJZf+HcYoNacmhlbBYyur+fWDcMatc
	uh9XLmArDq53o8q92jKCiEeQE3A9Ud3pGfr5DSWZppCm6LtnREDYxoWthJg+3DB1gQaPzJW
	IGhU1CV/6tanZaUGfnaS/r13tMuogkev8GJ94X+9AYACWCz+MMPbT9F2tBj9V6Gp1cB0W3Y
	sRkfwn98mGUKUuSKnKLutMdWSLI1qpaGLfGC570v0xTU3exuHRb2uKaFkyQ0U23SeaKaTrG
	V8/KI666OMts8a1DHQeCOjq6cPyGLUgWqnhtGhZ3GBD1FLRRP4QjqGOUjtrBdYD0NBYSYVe
	q/rD3NLHXSAaL9bzyYIrAvgkDvYP6iQpT5atAYAFK3TsJORtJkXssF4Xo1StkIqwS9hnl8v
	e1nyvczhtaoxIcKCNhCaBWwdNm20uJHLWrrZ3Upa2h+zNjFG6TqPSy3Nb42g7UVcOSBwF4R
	0ihncyD0asKCIpNhiuM5vOW5295ONQSnPIBsCKWxyTbbP4oGFXF5AvtwEagFb1hLy/jl03r
	BBIa4BlULjzouKSGuGlNT81njihdC+mVOBInD/lSpiHfVh8YvxJ4PpGpuP1Ep15FKrTzORJ
	6ytcLOowu8npWNI3JBjctxGjwTpEh50RG81ei2h3dHlWGvbO4fLChpP7hy2Yd4Hvf7GG+GV
	XIaSkaBc6CtPbg01AzTdPRI7xLhrEezFWsD6hKXOV39kff/+X9fQ9qQ0dvxOVan2clc+c20
	oD/Bh+eGYpDmkAPRTUEmBrfD5EOgsdfVyYTmPnDs/3Yj2sZ0LhXS0SgODSDrZwjx9/2Z7kn
	imWC/Zu14Av2gwIQLlzktEVvsyvrDzg4dkPubNPqOrUk/EOpOhW7DYHpNvwfJ4UGkrYKe23
	GYTQGWj7gQGWJYrODkrATXz6F3BlujbWdWXGTtuAN8IMuqpE3tOpUl+5zzGF0hou9L2/RrV
	b9qNN+Mom/1juDNKw98CeOerh6Q9IusS96YHFL4YfF9dNpYFYbwiEqLBvILHSdIFj6QBBUL
	Uh/k/2G3VFjJyAv+Oc/pG0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

The interrupt vector order was adjusted by [1]commit 937d46ecc5f9 ("net:
wangxun: add ethtool_ops for channel number") in Linux-6.8. Because at
that time, the MISC interrupt acts as the parent interrupt in the GPIO
IRQ chip. When the number of Rx/Tx ring changes, the last MISC
interrupt must be reallocated. Then the GPIO interrupt controller would
be corrupted. So the initial plan was to adjust the sequence of the
interrupt vectors, let MISC interrupt to be the first one and do not
free it.

Later, irq_domain was introduced in [2]commit aefd013624a1 ("net: txgbe:
use irq_domain for interrupt controller") to avoid this problem.
However, the vector sequence adjustment was not reverted. So there is
still one problem that has been left unresolved.

Due to hardware limitations of NGBE, queue IRQs can only be requested
on vector 0 to 7. When the number of queues is set to the maximum 8,
the PCI IRQ vectors are allocated from 0 to 8. The vector 0 is used by
MISC interrupt, and althrough the vector 8 is used by queue interrupt,
it is unable to receive packets. This will cause some packets to be
dropped when RSS is enabled and they are assigned to queue 8.

This patch set fix the above problems.

[1] https://git.kernel.org/netdev/net-next/c/937d46ecc5f9
[2] https://git.kernel.org/netdev/net-next/c/aefd013624a1

v2 -> v3:
- use wx->msix_entry->entry to define NGBE_INTR_MISC

v1 -> v2:
- add a patch to fix the issue for ngbe sriov

Jiawen Wu (3):
  net: txgbe: request MISC IRQ in ndo_open
  net: wangxun: revert the adjustment of the IRQ vector sequence
  net: ngbe: specify IRQ vector when the number of VFs is 7

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 26 ++++++++++++-------
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  4 +++
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  3 ++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  4 +--
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  8 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 22 +++++++---------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 +--
 8 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.48.1


