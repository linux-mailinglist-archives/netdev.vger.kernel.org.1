Return-Path: <netdev+bounces-202764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4695AAEEEC6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3663E11DD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 06:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B734E190477;
	Tue,  1 Jul 2025 06:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A4218AD4
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351556; cv=none; b=j+p30aKPyT+AQFq9DF3ld7WipWe5gcfrnUkNk7OIvumX81hGot8aej7x32YXukzNs63Km4CUYkOxBq52t6lj7uX/5lZf2F/IOChvHk7SRPyqPAoImBcMEeKviCcIUG2DH1Crbq2phW8CK1muxCszFcob1CgorT6tFXzCUUEiAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351556; c=relaxed/simple;
	bh=D3wMD2TzeNPlE6WatTBKPEFv5/G6/7QU2b/0+u3TE9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WaAKqP58rH0z96ejxarJwytDlLsZ3hW3Xy+u58CJIUxml1SnrbFvFVhscqzUN/H73VXypbmy8VM9Rt4qnNQRJqNagYf416+HLTO8myHKdQm5L8xDlS6aTnI3mGQjLSMtBvphQIpVSl+MIaomX7JZTXsIMhJEZ1yRuNnnBIEf4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1751351481tddb91b1e
X-QQ-Originating-IP: 1NJc/eb08hfPk2GUbEgM4tTqJ2xU56ymLvHmQYdEGGw=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.151.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 14:31:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3425705688295320490
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	larysa.zaremba@intel.com
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v4 0/3] Fix IRQ vectors
Date: Tue,  1 Jul 2025 14:30:27 +0800
Message-Id: <20250701063030.59340-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OJaSdNvGbayWnaZ8fFkEqpjSvaDh/t7fGvbq6LTd5EV7zx8Js3W1Xesw
	Tza3onjdNllh7c0rRrsanWuix8yN2B+tFfEnq+/f0QbgwKtsN4crdjcZwWoKKv1Vk7dXwcc
	BhByy5NkbNkdtQkD3d+TEHmyn4wC3WKWGPHH1KI2/5WyeVGb8qKXvV11oa0OrhMgM6A/J+C
	6u11sR0aWzdmJnrOOnPW0yw3krH0CEsrZntVrWrz44BSk1HnpDzJ/9w6PXnRM0jWua17WHV
	2rKciNK/jTIOW2k56BoL4O5mloW7xI4KO6i0SHh0E+yDdGMDuMhpovp1b0zyUOuk8wz5pVI
	dnSYm4U0YU3QX1U1NFlIhTIlgVh8ThRVAtZ9ibKA8VXDqKe/7VcZfFNsxiVHEVQcxywpHEZ
	FtE0eukpDgjgFEkr52FRN6+8/JdPTXC7zT6OeW+LR85bFKHD0i3ybnnis5UaOJi35HGHlXQ
	Gs0Xpn2rUxM/nocTh/UEiQSUIC2jkzni3FpFEzv+40xc+yjzt2RirRdxIQfyoDxbekkokLC
	fsgmuvhA9YpOe/IgEFx5qT82N6WJdROLGLrUHxTL+LMGMefbAMZZFwNva5ZLxWcSkLCA4Jr
	ehk3qAMi+ntSYiDHOV7irpKTEqqQ5ePzNwYlTDJivzgTLgghrAU8Cq8dibVunZ7L6gTZri8
	70A+EHwZF4lRUBwBFUXqRe+XrFvxQjlxvgA2vhLfJzHJ9UPvPsBkhsKiwPSW60myTuCgp9F
	Vrb5p5/fnmDJcAC9wW1oOhUR3RmobtkMumVlGjSY4FLuOh0OzJbFPqkwlUJaYUtjfD/16uE
	tfM88zvBvx3DjRropYMpwPoBMCwDm4KvMbSruFjqxYUV9EQTXab9OV5Es9RdtsJppcch8Mj
	Xyqyxu6lszYPABioptjXKaQ7NnizXNVYN0CyICCMRRoA7zRxNRtdlbv1YHjvCqiK2GysZn8
	DUfTakzSkt0Wafm4/ZBDWur0jrBRtKRGLYo8ccZ+tcKr42WwyOSQnnPCc1hIBLrt2cG/Gd3
	LY1aNCdG+6qy/nchyvrHsFlCqwR1SQB+G1Otg1y5s64JW+/vJ7FLkysIMnaEITTuEJp90nn
	V2g2PdHzDVk
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

v3 -> v4:
- correct wx->msix_entry->vector to wx->msix_entry->entry

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


