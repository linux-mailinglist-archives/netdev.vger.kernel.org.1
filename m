Return-Path: <netdev+bounces-302912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w/TkHO8zQ2r0UgoAu9opvQ
	(envelope-from <netdev+bounces-302912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:11:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EBB6DFFBA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:11:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302912-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302912-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B33F43020E95
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D61306744;
	Tue, 30 Jun 2026 03:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BE2DB7B9
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:11:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789093; cv=none; b=tdByJeKFbvXNlnk6xtn/1YBr5XQIF/zjBRDWqHutTNwJkXqRO1/PrcyaebcOd6Dii8uZXf1VayO0TR2Rv8kBOT34ldjPBbygKh73J3oewTbRG6Rb3P8ZMvp/vJGA+hnzLm+CWUhI4MX/M6cWbM0nywAfBXcA5NhUCoq1oxoxzYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789093; c=relaxed/simple;
	bh=NnIVQCE9y02UXtCt0/4MQsEYOiY58+w3GGdvO4TyMNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fxpfN7ZsZ9iJ0tdNkrbQTltMs3tZouo1GTEkDSVHU7Hii5pGCL8kMe0l9lPq8j6nyHIVcR9f3eXPKX3s6XKSndi0KLRwsbMy7AfHO+TeAI1YzJZPLfw1FOdcr7uh23FD2p3cC7OGds7alADDAle3zHzTKPWxYYkLJE8jpn4DU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
X-QQ-mid: zesmtpgz8t1782789031tb2a285a9
X-QQ-Originating-IP: hAzGNopo940tmuIBQTPAxrYOUcEZ1YUa78FO3QBQwH8=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.190.76])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jun 2026 11:10:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6731971070072915029
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Rongguang Wei <weirongguang@kylinos.cn>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v8 0/5] net: wangxun: timeout and error
Date: Tue, 30 Jun 2026 11:10:11 +0800
Message-Id: <20260630031016.19820-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MzExSPfJsR+Be2xapnp3InKrZCr/SoN2BcO6E6UQY3tfkB8htNjUkcO6
	ZofGtwbepUKkUzMNFwFh4X38EP+HAMrK58UlzXeQ5EvDJGkAaiDJ4ajDS5rcH2INyW35+LB
	yxtvyga9wL3kZyUkOborVtWTLGRottI9Ewuu37Pf/gDwjbheULuvuRpZ4vipFXYBExgbeZ+
	iB7Z7iP8cskthBVCSLfziGlwiZ096tGvrLj4E95xom+a3Ziiri5ii6d1O3hXCpUmRepNx+D
	jmcLcbtZzuThvi8WyieUWGUm4G6MIpXaAy/VrOJ+3JLqaHXtK+Yf5nKOsttDnOakzC/kLYE
	HMPnzhoY2cmnOCQ8wFMgChH13VQY/IqRUvltNjefOeggtfPnKpySkXkrpiZtLSD2BJIRu4b
	Gkss7dBBtZlPMp27x1b0y9ZAHdhJWg2SctrSYgxjkvFIwzNqr1hJTHaNjo+O7s6a4msxnBI
	dl8AUYzIeCpUmST2LvdpI7PiTiobtL4CZAh6wDe9CVost45p0+KV++05qR3q5XYcxgSBapy
	RnhwE8NPq8MkiiWxwEBJrgT341Ig5XWkWpL4gelbjgdqGw7ZCXxqc7ed3KGmsPFQPfJIazy
	+OUDLkaeTJlBEuaSLZ3DrU+15FFmp+sS85kOn1F/tnTVvDn1ismhp0zO4PFE9JkhPM2325c
	k0tiZPp9VpAGsBDaoPJjCNW86Ju/i7SZlvr5JswoHmFi6jTmQ7fI+rLquFEr7YvsBvVnqK4
	Jc2UrXW/35V97WzSaHklu29QvoPWdiqEtl4GT++DvPDdKGOJL/j+pifYaHb4GC1pQJVrt5E
	6JFBA01JyQlTMvIaGqZmUW0Us/SjgWRO1dkOMT86rtsKLOelQ/Zq4s+hRRYKBWl1zK2s1jV
	k2fzlBxbqUDvEAOlUaqPS6xV6nEfMphhTqCTLLVtPGmiwfuvSKImjAeNiwVr9Nr3GbLv8ns
	TkZXelOEA33OE8N0XqNNnFMaDBdWFkFE3GOITtOZtb1LbB+YBdYnYKbbTN+Ff/FZMohowZ7
	ia014sE7LDB91XnbcAs6Rz14ZNsuxpW6WGM1ko5D084VlO0Qvx+pOC2pCdwvQRL5xm9Izo0
	7BI19DOKuH3H+M+qGFfgyk6BxZEA0xY1w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302912-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:aleksandr.loktionov@intel.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:gregkh@linuxfoundation.org,m:tglx@kernel.org,m:leitao@debian.org,m:larysa.zaremba@intel.com,m:u.kleine-koenig@baylibre.com,m:weirongguang@kylinos.cn,m:fabio.baltieri@gmail.com,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,linuxfoundation.org,debian.org,baylibre.com,kylinos.cn,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustnetic.com:mid,trustnetic.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24EBB6DFFBA

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

---
Changes log:
v8:
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
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 321 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  59 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  18 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  25 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  84 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  57 +++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   2 +-
 15 files changed, 589 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


