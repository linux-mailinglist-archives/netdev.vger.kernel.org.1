Return-Path: <netdev+bounces-165872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256BDA33999
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A421D3A3615
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAB6207DF0;
	Thu, 13 Feb 2025 08:05:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C45204C1E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433959; cv=none; b=B8qVB7W4C5a1Th+QAnioXJ2Q6L+W7wimejdoYluf51KR/Y5hpb9lqeSo5uMxKpKEbPKzXCHIF8Bnk+ohDvIvJ3wZm0j+F/PBv3bjcH1obGe+7NGZCw+XZIcgMJuZJWkFmijUR8/52XIDwd/Q7D9KqNXjWrBQ7sYdx4WqcoNZedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433959; c=relaxed/simple;
	bh=OATSO7eHoJILP+GQWU/a/eBJyObmrM/vmlJA1K+5wRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qcd9GIhexsuGFJ34ee82l2g1KQLbmNEfZnb3QGvpd2uHko1nJi2QkVwWAyr9Z9T7eTgzrc3wt6eTMojNdYdjzmPZwSo4CZGh+AygPKhVHx6Xc2vuoImtAzHqRcAe+NIdPya/oopJLEhKSPaloUTM+YeGidknEBYZqYf0UzQOoiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz2t1739433938tobom9k
X-QQ-Originating-IP: e/q9oWX2QE/9T+2nK816yX6fbqZIEG6WLqgZGMbgli0=
Received: from wxdbg.localdomain.com ( [218.72.127.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Feb 2025 16:05:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10265486340148631416
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v7 0/4] Support PTP clock for Wangxun NICs
Date: Thu, 13 Feb 2025 16:30:37 +0800
Message-Id: <20250213083041.78917-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NG7xP+P+sy64dTKFJ1lcYnx1O9cwXm6x1pF7Hr/SnYtcAJx6HuB+f+PK
	BLRP8QMkMGJ19zeirysvVCFoMZDJks4O/X9yP6m3SkDss3qERzZb/a88VBs8AJFtTEscGa5
	vvunLdx59izlKLOiCgUGoPNlbkQ5/+Yzt2a89GsG8UAj52fU5hrC9aFSA+IU1qQw8oCscVi
	T2KUh9YZl+Z3Xb2FepEIu7aZFB9mZa+ykfFLhSYPfqgI5L0Q8jOx17tZ0E4D+cAmjrrH+42
	O1XC+ButMiQzJ9JxDKdGz+Rwtql5FJSX64l3G4ZKyLLTV2ZgSeE/7ea4plWe0Fn2G39Gl1X
	uQFDCS2d2DaXGGIFsQu16PevueiR8c1YFHZ/76Sl2gDDmi9VUvzDKTWbsnjzRhUmkxbahAd
	4hzQggofalEhDzIhib6GUDB8u11ZW0vegKdXHmTjht71W83krze/nZo4IljFK+h0tgkV/Al
	3vBY/mpFBstNqMBP05XzVGo52CSE2U+pzdYLZji5b1aSDb+OlONEqR/eJ0TRE86FHkdMFFq
	GUzlW91zQ9O0MlaMCw1vxSV+K1f0gcquu01RZudxAx4gf+37JTXiw3jzIAGs/duM9Q7v6h5
	LYUFEGG3dZkTwmBSTFXIwfFPZJyxs1LJ+yJilVcM+90FSipvNbUtgwoxVRDXgkYkpShYSPx
	17WxTiodDOsEZhYs3hs/KBZ7gg86VKqrq2xrs2OPcPqUqIXOnKaHqyz9nzjGBZ5BAHzTtml
	Grk5U8uwgxBb/+p676cJaHklZoTiCnwtCQaQZtJcsGFIkfNjWX7a84kKB6LwENSx1QQpg8H
	c70/OdpaRmI+BG8GaLeWvrq6MFwFo4qNmWtnWOcuOV97l9MKZu20bYXK+7dEsmetV3GSn/w
	LjWnKXeifgyNK8FR14fDewwM+E/kGb4VSO0eL5EqIDZ5XZo22FOGGEQWnfET5ha9wyLZY01
	jupvTvsHo3xEfnLDlPtH55XNLjyfCvhrp8ybp7iMZQ7ISmXCrgS/5vJecq3SBv//C328430
	8iivv+A9RGOm3EgTOBa0TIiZXclOGk9rQohRXvAw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

Changes in v7:
- Link to v6: https://lore.kernel.org/all/20250208031348.4368-1-jiawenwu@trustnetic.com/
- Merge the task for checking TX timestamp into do_aux_work
- Add Intel copyright in wx_ptp.c

Changes in v6:
- Link to v5: https://lore.kernel.org/all/20250117062051.2257073-1-jiawenwu@trustnetic.com/
- Add "depends on PTP_1588_CLOCK_OPTIONAL" in Kconfig to fix build
  errors

Changes in v5:
- Link to v4: https://lore.kernel.org/all/20250114084425.2203428-1-jiawenwu@trustnetic.com/
- Use reading template for timecounter_cyc2time()
- Move the same piece of codes to the functions
- Fix read sequence for time registers
- Remove skb_shared_hwtstamps zero out
- Pass duty cycle for the pulse width

Changes in v4:
- Link to v3: https://lore.kernel.org/all/20250110031716.2120642-1-jiawenwu@trustnetic.com/
- Add tx_hwtstamp_errors to record errors of DMA mapping
- Remove flag bits clear for default case in setting TS mode
- Change to use seqlock_t hw_tc_lock
- Add ptp_schedule_worker in wx_ptp_reset()
- Remove perout index check
- Refactor the same code into a function

Changes in v3:
- Link to v2: https://lore.kernel.org/all/20250106084506.2042912-1-jiawenwu@trustnetic.com/
- Clean up messy patches
- Return delay value in wx_ptp_do_aux_work()
- Remove dev_warn()
- Implement ethtool get_ts_stats
- Support PTP_CLK_REQ_PEROUT instead of PTP_CLK_REQ_PPS
- Change to start polling Tx timestamp once descriptor done bit is set

Changes in v2:
- Link to v1: https://lore.kernel.org/all/20250102103026.1982137-1-jiawenwu@trustnetic.com/
- Fix build warning
- Convert to .ndo_hwtstamp_get and .ndo_hwtstamp_set
- Remove needless timestamp flags
- Use .do_aux_work instead of driver service task
- Use the better error code
- Rename function wx_ptp_start_cyclecounter()
- Keep the register names consistent between comments and code

Jiawen Wu (4):
  net: wangxun: Add support for PTP clock
  net: wangxun: Support to get ts info
  net: wangxun: Add periodic checks for overflow and errors
  net: ngbe: Add support for 1PPS and TOD

 drivers/net/ethernet/wangxun/Kconfig          |    1 +
 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   53 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   52 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 1011 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  105 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |    2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   10 +
 17 files changed, 1322 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


