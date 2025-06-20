Return-Path: <netdev+bounces-199693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3DAE16DA
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24523AC082
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648427CCF5;
	Fri, 20 Jun 2025 08:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F031E51D
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409910; cv=none; b=PkL9VMYYs3g1ENJSeKeJ5reMD5bdhqpwFVD/pr0LvBszjk3xlcRTPfi5I5mP36Ng+BNY7zJnxwSEmtDR7gYLeLis9HdCpbqXOddr4M8cFOs6I7yN674ZbyRqMPlO/7bBladY2bQrVXHaLNDMFcbdTig3zaWCoY3wuPIAfWLoLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409910; c=relaxed/simple;
	bh=NrnVVu2CtFlreMp2ihhMQ70OnuP41S3r4xLDxMRWl8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUiiydfzbwmolyC9302YutXWaY+GhhkJ+UX4nGcTJr6ukGhNz33xegMat190Du/t2CDK1hTRlvSq79ScxzdgRz8Dwl3xC19HVT7lmMxamPbKVW2/ULUw0wOqeNGed8gCipy8QQOUifDhVGCi+125zKXEYNb+s/fxKbZRml2HNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz12t1750409856t1d7efa2c
X-QQ-Originating-IP: f4WqN9VHy1zxO1X+vowBA7Q/1DUkFVV+8ST3GKZ7wHI=
Received: from lap-jiawenwu.trustnetic.com ( [60.176.0.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 16:57:34 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1078190502005058225
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net 0/2] Fix IRQ vectors
Date: Fri, 20 Jun 2025 16:57:18 +0800
Message-Id: <20250620085720.33924-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NWgtEeAVRIGZ+SmJrcjpMoh3lZsPxAtvEHFgSs0KSl5zJbo+TqUNsXOa
	R2IFsyAUPv32s9BOD5CmZTr/PDFe+eoFNIBs/bGBWX+ATJEfXwdMYBCRREZcGHIJlzj8Ks0
	tS/J2ODEBrokQfw6E4+WwfCi5dlwWUEXHwkc8N82f4wltKM2/XwKLiJlQQ23awsB8mPAKtD
	igonQb0wglNpnCu1icjTHgjehN2AV/7+DYMaoVB6xd1786jWv5EgthHH9tSkdmGDzxg4Ih3
	T2QbU+9WCOvZJ8qSJorZafJ/Kb41Gzob3UsBR4XefFt6lm5CM6mfOdAefFhuaHQyWJrwP3n
	9qp73i6H7Rrqz+JRHPsso9HRglRdZbEcADsIU+3jm3RFthCk3Vj5T6622Yg5BMOLYZdi5x0
	oqbjCbB8OGXcxLk7d1A4kN663iqwAjiEvoj0j9R97NpPyVTd1RtssSrp7Zb/VrTiXm/mZWp
	aFlOrx2cNYRbrTnaDdBJfoXArH25yfUkBFsZMCYVYnr6Taxuksbup7Scnghj5CjDLl15VBj
	hiUqqRl3jpBG7vjeHAxCc8C2WDaBuTGIrlFYxwFNASCQsUrq2OqC0P/TU2fEdjqKY07CZHC
	XsCnxmaoU2+RpTWpta3OXd6cNuP6ddM0QZU5E6PMuD9uQL81v/AxPeitdcoEgTOqvHUncS0
	uwlXtGr6ZJOtULeO/FM4yQriCknPa7QxXOnUESvamwWgqUOwasQ3iWaeQM6kl7s5kvG4abZ
	4zeDxmptViYe7HotICjCi/lgE3cyAqjsV0tL4hIKcC3alg3Af4VIEwbpVbxBdhnSC2pvTk7
	0cpf01mGOEqmoqnShLNx3RDMevTFDJ8boTR+nZ/D9YkJ9VV9HmMW4GVuoA4ZVoEWefWVbTy
	vluKCCWq2NqlzPX76wizfCw3KNsJb4ul3BIEsVAgmzApGJKcZ8DVcnnZd6dMat/BCPOSME8
	MZp58ti/TmKVCMF6lOCLZxeAbgSf9pzuORncFWv9lHcvPNErEZNncjrf7MmOnHjuHLBemVu
	q6+/jiSMNM+Fvni49fkdjJWk96w3Qjy/+ErRXn9C+8oSoBNAs4gyAeKw7tFA+4OnJP2jBTn
	u0E9df4wpROnSiC0tyAVrw=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The interrupt vector order was adjusted by commit 937d46ecc5f9 ("net:
wangxun: add ethtool_ops for channel number") in Linux-6.8. Because at
that time, the MISC interrupt acts as the parent interrupt in the GPIO
IRQ chip. When the number of Rx/Tx ring changes, the last MISC
interrupt must be reallocated. Then the GPIO interrupt controller would
be corrupted. So the initial plan was to adjust the sequence of the
interrupt vectors, let MISC interrupt to be the first one and do not
free it.

Later, irq_domain was introduced in commit aefd013624a1 ("net: txgbe:
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

Jiawen Wu (2):
  net: txgbe: request MISC IRQ in ndo_open
  net: wangxun: revert the adjustment of the IRQ vector sequence

 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 17 +++++++--------
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  6 +++---
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 21 ++++++++-----------
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 ++--
 7 files changed, 25 insertions(+), 29 deletions(-)

-- 
2.48.1


