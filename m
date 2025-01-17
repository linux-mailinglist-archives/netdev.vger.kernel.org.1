Return-Path: <netdev+bounces-159164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B511A149A9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418BF3AAC26
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8A1F76A1;
	Fri, 17 Jan 2025 06:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01825A658
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094883; cv=none; b=hRqMsDN8d0Am9+r9TWpoVsegrYBiwBEUs7pOGsru8O65nElOpTrpi6O+R97cV3MPpRI2M4j81q+j67xInevHCUkRbJGwX0/wcIG1NR3ImEZE5z4qqVb9r374F6ddIgOknpaC7AYzJjX9cAJS+ZRl4Ic8SY2RlPW2/PYjR4cPVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094883; c=relaxed/simple;
	bh=k3H9ld7Bhu5Bw9aykxZ/lunJqkhM67tp9fhaZDMC71E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KqD61+rVrjt3BlsJiNuCVsg7Fzz65gZRal8rFnBH4+fFX77Wr4Oc06v/54hkF9VjgzzKCF6+Q3qhovxTLiqGiwtcKnwgiK7J9Z7a6SigQ4dWvCH54M4Yw49T8o0nMY8i0E+JjrGUd2ZcJlBQp0YRgPWzrjHiTTfNm1W3U/DIxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp89t1737094867tjdb0l62
X-QQ-Originating-IP: hzx5pNLqFXwHnCI0CUwtgwQQvsB6S7P0BhmhTciJfow=
Received: from wxdbg.localdomain.com ( [36.24.187.167])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 14:20:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16084230402434091574
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
Subject: [PATCH net-next v5 0/4] Support PTP clock for Wangxun NICs
Date: Fri, 17 Jan 2025 14:20:47 +0800
Message-Id: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M182XWJxg1fqlm8iKRw3vCW5y5j5CFI/PSKWxWp1fHxkiWE1iqAIgJ1r
	GCqwNWMmkeN8FIMyYzdFIKbIITl04xPe0J69gfhzg+EOKvEky1VlOw6AO3RQh8npg6F3XFq
	GocUD/RVKLk8Rdv9CAzFDurFGVly3lrBITNysComqmNx0ye9QctN1p5UUqjEohM26AweTJ7
	aqpEG/6q3UsE37+pgzfqAeyUbwi54GnA0yvcuNPy+a6bhvnook7N/AxfufhdXpO8QJMWNa1
	jpealJ8tj6za2sNHHNRyr3U9esrMWkHXa7VY6d0ZHKSty1o2+NHhi1Pz1g8SedGiROUmbe4
	Y7s5trHzsJUk7m9Femitv+LCNSjH9CGMwtIsNGe7GyUBgRCN3iK3GZN+CkYgXAn1RvH0FYO
	mJ89WbqSFM+V+l9jB8odqeNjrOmfdlUl3IC0lkLS4WfesdvN/lv8JZW0rKRtZet48xAFp96
	mesz3W14ugmteGs3jy8xDtGoNtqxeMwNz/xLCZ9XtT7BxSqL51qGnVHjmZKYTjVSN+IEXrk
	JR+onmVq3EC/KYCm33wHtsbKZ0lH/F/5IOIyv5AnUX6gxKDb2ILTeW4s3CQIMYAzmFM6cTF
	LdF6ZnWvkPoIYbDCe5MrlJ+aztAzNLrKwpuElQ4lZQNkM++ci0JF4tiRA5/sXHsA1Ko+GTm
	Man/cAHfxW+Xc7kX5uzPek2kiN2KjnkAqPfnjDQwIgnMiPJ6VDC1JLmA0Nd+C84Et1VJtCt
	1D3NzkweWZK5LSM8QPVxIECtt3bARAy8MPhZjHwpSwZMmOdea4L0++J+qSH0z/5kFv5qTEI
	qWjtjRjglbPHVwORtYhP8C0r8dgvvsiZmaxLxb4k/gZmgl05Z32lU7poy9NTJc2bPXPHMAO
	HtVDWetEgb+P1k1faV/sb96tZ+49wAxemdv3EI7WtB9+jgpu8TQL21CqVsFAi7pQOkWcqvi
	Zaum0f7Z4DJItzPX//YIcw8CzeScB0nWPJjsaXDZttDYLE3w1NlwWqyCe
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Implement support for PTP clock on Wangxun NICs.

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
  net: wangxun: Implement do_aux_work of ptp_clock_info
  net: ngbe: Add support for 1PPS and TOD

 drivers/net/ethernet/wangxun/libwx/Makefile   |    2 +-
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   53 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |    4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   19 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |    1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |   52 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 1021 +++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  106 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |    2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |    5 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |    2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   11 +
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   10 +
 16 files changed, 1332 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h

-- 
2.27.0


