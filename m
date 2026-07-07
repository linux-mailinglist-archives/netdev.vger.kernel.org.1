Return-Path: <netdev+bounces-305285-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id glpoL82ZTGqVmwEAu9opvQ
	(envelope-from <netdev+bounces-305285-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9E717DCB
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:16:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305285-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305285-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F16383008D27
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF038283FDC;
	Tue,  7 Jul 2026 06:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4E388363
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:15:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404961; cv=none; b=TDJj0YZ/Xbq6AqDLTlB8OWiIo29z8JpW4y6cZcJQAHrlZ7Bf6pDBpofZ7Nx+azSo7+xi54hG2s2G+iDc34FC1PT4NRv+O9XjX+6CLX8KBPGn1ReYt/VpCdcnBXfgemeiuW4R/GOBthHxjtkUiJXCzKiPe4f9BhRXkAZ9MeVbSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404961; c=relaxed/simple;
	bh=BMR3JodvbgS0zHLmsFZBILZFcEt08mIJeXJ+RZRjRfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B/5FnEWTxO/DSJuYRKec5EKeZ6EsY76jPU9+x5RqmjGMwAWpxyaTnvvCNSDeYj3RtF4bZNw79W48uFdYUq2h94UolYuhVHIo58HFCSAJO7Fh+qlskQmphmh8SCu1IFso43MtYsjJ8Dm7UaPjZbblaWpzzo62q4Gw4fHqK0qzCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
X-QQ-mid: esmtpsz10t1783404900tea42a8be
X-QQ-Originating-IP: eDdfl7p/6wtlmiqlDI3cCTT35hVnln5C9XOvsUQiMkE=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.196.189])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 14:14:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14897438653831546274
EX-QQ-RecipientCnt: 22
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Jijie Shao <shaojijie@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v10 0/5] net: wangxun: timeout and error
Date: Tue,  7 Jul 2026 14:14:50 +0800
Message-Id: <20260707061455.39564-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: OFWsfmE1GYcu5EzLQuHlksRtNezP2mj79iYjzwrcvqqmJJVPLp0SRA4j
	gCoCEBhGXJz31DkYnCBN4nmMFcIvM03XLnZ+BVotMzD1MywNkagg6XMLFfPliTBqEntYACC
	LF3l4Qxw/kY+Q/XqcwwjGaGnXNcx8BKfxgKK8LehylgCec9frFyuJshps+xMb4CZcjCTA1i
	doCI3xKSjbPYfRpACd8l8AbAR2VjjYYYlBr5+wmoUPkHJPzZlX1PH0hoRtuN9gtVE9qEjZN
	7tcuu2kLgYVk34wbZOJ5oRcc0+gPWso2A3EH2LOwNxqfwiQ13KKL1m3kT6cMYdpaOxkMcEE
	92xyaDwDURmfyThLZJgD0Bf3dbcAcQMITyHfJq6nYqBRhgQH2sJRSelNc0+mSGtPw4mVXpP
	XMwoksGcGTGv4Qc9bYQyFwK88potKGMWjqDO43gjohhGacsn1pmWg9MOYwHtTiCbnaQscsb
	M2WPumQtJGqGWR1tEyS4jP1hViCEqL+aULxT2c4o1IEnGaxoxbC0E1bqDkWk/s0Ub+ctQDs
	qQIRk/+SCbpwkrzLxsDZQ2FqSUjnn9PpiE2FHhQwSuL0Xku7Mwt4NCYviRAXV1rkliRd8lx
	K33KsVVvjkUmQUHx6PV/IP8yZnkJvBEsdbVG92yZoexmc7u1Aqghs8p9c1MVHTZCYpKhLuV
	0wLfgkatG0xc2uefrw7PWSjx6+fZggAL8PpYxwsU+I/lyX9LgszzwbJB0zL8s+6tSyPNe5j
	4JzYFZThaORoxU7MORhs6h3+7D6kKiY5E6iDsrnoQqFg+KJUji86DnsX0gi2ccG0bMDDh/R
	LFLkS7qWK0B5vhPCnFFhFDf1q8Wi9mcra6w4TkweQ53vhrOR/Re4XusftQ/DMnuG5bgvD99
	aGpjNpUR5aMcvOzEZ0L9A+EF4kJuVh0dbIAkY2KsLWE1nN3fM2xQtW7z5xTyyfVKNtMMCgh
	mWPcBfsFSVA6bm/k7dgj/UBbfuAi2g39cA9UJAarYrNMzGsfhbN9unA4mskW0DeN8mJ2gCq
	iLtUYdpdYYm4VB3zwed/5ozVKm5b0MUl7sl5aUck+2BJ1azFNYaH6fUZn8kMI2fMJ3E0bRh
	A==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305285-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:joe@dama.to,m:leitao@debian.org,m:shaojijie@huawei.com,m:u.kleine-koenig@baylibre.com,m:weirongguang@kylinos.cn,m:larysa.zaremba@intel.com,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,huawei.com,baylibre.com,kylinos.cn,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DD9E717DCB

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

---
Changes log:
v10:
- Remove pci_aer_clear_nonfatal_status().

v9: https://lore.kernel.org/all/20260701072357.33984-1-jiawenwu@trustnetic.com
- Add calling ptp_cancel_worker_sync() in wx_ptp_quiesce().
- Fix the typo of 'out' for wx_control_hw().

v8: https://lore.kernel.org/all/20260630031016.19820-1-jiawenwu@trustnetic.com
- Not destroying PTP clock in wx_soft_quiesce(), and keeping the PTP worker
  alive but idle during PCIe recovery.
- Move wx_soft_quiesce() after wx_napi_disable_all().
- Use PCI_COMMAND_MEMORY and U16_MAX instead of magic number.
- Fix the leak of wx_control_hw() when WX_STATE_RES_FREED is set.

v7: https://lore.kernel.org/all/20260615065016.21672-1-jiawenwu@trustnetic.com
- Move ptp_clock_unregister() to be executed before free wx->ptp_tx_skb.

v6: https://lore.kernel.org/all/20260610060917.23980-1-jiawenwu@trustnetic.com
- Move the check of device status inside wx_soft_quiesce().
- Reverse the error return of txgbe_disable_device().
- Add PCIe error check in tx_timeout.
- Add WX_STATE_RES_FREED flag to avoid double-free of resources.

v5: https://lore.kernel.org/all/20260604085631.12720-1-jiawenwu@trustnetic.com
- Avoid the same name on two functions.
- Encode the device identity into the name of reset work queue.
- Change pr_err() to wx_err().
- Check WX_STATE_DOWN and WX_STATE_RESETTING at the entry of every work item.
- Implement wx_ptp_quiesce().
- Add netif_carrier_off() and netif_tx_disable() in soft_quiesce.
- Move resource free operations after PCIe recovery.
- Return error code in down path.

v4: https://lore.kernel.org/all/20260601072221.2952-1-jiawenwu@trustnetic.com
- Create a separate work queue for the reset task.
- Gate wx_watchdog_flush_tx() on netif_running().
- Add rtnl_lock() around wx->do_reset() in wx_io_slot_reset().
- Change .close_suspend() to .soft_quiesce() to avoid MMIO when PCI
  channel is frozen.

v3: https://lore.kernel.org/all/20260509100540.32612-1-jiawenwu@trustnetic.com
- Merge the multiple string line into one in wx_handle_tx_hang().
- Remove the redundant warn messages.
- Use test_and_clear_bit() instead of checking the flag bit then clear it.
- Drop the Tx hang check in tx_timeout.
- Call wx_update_stats() before wx_check_tx_hang().
- Add Tx flush when link lost.
- Move wx_ptp_stop() into wx->close_suspend().
- Drop V2 patch 5/6 because WOL packets are handled before DMA ring.
- Check wx NULL pointer in wx_io_error_detected().
- Check perm failure before hardware teardown.

v2: https://lore.kernel.org/all/20260430082517.19612-1-jiawenwu@trustnetic.com
- Add the missing rtnl_unlock() at early return in wx_reset_subtask().
- Replace ngbe_close() with ngbe_close_suspend() in ngbe_dev_shutdown().
- Add a patch to clear stored DMA addresses.
 
v1: https://lore.kernel.org/r/20260428021156.13564-1-jiawenwu@trustnetic.com
---

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: implement soft quiesce for PCIe error recovery
  net: wangxun: add pcie error handler

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 317 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  21 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  25 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  83 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  57 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 588 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


