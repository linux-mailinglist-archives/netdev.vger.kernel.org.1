Return-Path: <netdev+bounces-295122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id utkPBjVBIWopCAEAu9opvQ
	(envelope-from <netdev+bounces-295122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217263E615
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:11:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295122-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295122-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF2A310A969
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F93F1ADB;
	Thu,  4 Jun 2026 08:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9293EBF20
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:57:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563468; cv=none; b=Kh0oALofP6v06suTkfASrk29/K4War+r9joyZy7ukXCqrUqlfIwcHglN3za2IcD1uypLtFVJ0JqY994v4tCT5STQ/AZRNi4Ep8OmA6D4qyWEtS+rntad22sR03ThIOo3rXKx4SFEwR9VAdiFp5Jb2pT7UCT4X9466ADJcrdqiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563468; c=relaxed/simple;
	bh=BcCW6dR/cfd9Fri6Al9ekzmwrYX09hMtmwGFX2Vync4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oNB1iqLTOA6d7E12yvrUXYhq9M+M0B17up0etHRC5xaU2aq2RZrfNdT0RE101fOJA87MD5yenflJZbgbS5rCwBWPKNws0T0YobCeglz3kJ69heKbJGR1kSvDhF33+0HFWF6U0ddDwPLwsh2IlB0/9ZC5rBoDNR3N+1OiwMFgcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
X-QQ-mid: zesmtpsz9t1780563400tde0dc5af
X-QQ-Originating-IP: DtcjXhuActEA/HaGVxRzrzhMXgl7mQX7B2pF0Ssi05c=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.207.111])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 16:56:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9348588480966831644
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
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v5 0/5] net: wangxun: timeout and error
Date: Thu,  4 Jun 2026 16:56:26 +0800
Message-Id: <20260604085631.12720-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OUC5DGN0mB58LQVcoNVdoWsZy1vEmcGJW8Q0dp5WaCPDXU40f2jXeU+Z
	QcIxaXKPXJlKLftpJDs0laWNqNYB5M5UD9QSAaYhQOFq5Mm79kZxp3EUW6C/DVA7l3QT0I7
	yDmMc/V0/7QDPEepvOOlGTX5DhhR5LDhhZml5OjIGrwFYAUAMCJEK61uKzwZuGtA4Clg1R9
	/DPnhlgX+sHGhoFZ12FrveITkpoyUQwh50dDbDIcmhyPf5gHGfUki3OlI6mY9JhlEr/0zsm
	vgBwri4bdY0DUe9O98gY0FzxM9n/pTb/FMwiI0YB2f3iL04HqxgCS5MX1VRrn1krf0kvgxI
	ThvToQmxhfuwiZ30wxZ9yuCqQY3Th99Erl4wgiSieEujsJBjsZh2yQmiEOI4TKeWU9J3pnq
	djq4qOemgSEEGdoe+U0vaxc1xhTil3T8QgSUmUR/jR91amkHJd8SHPZb6tsgyGB+ZQlnHZG
	raFxrVC8jVmRt1pwandcqtII4z/hNr7dnAox6g7LCeHFvNFNnGtPP9N54n2mUKrS6zUCnyU
	KVCqjl9DJQD3QYua2+nAVJPGuhL9Sx9Ddudk8hw389mGXIxeptTmpPbAyz8+fgJfwvtdzgz
	xQ7morKBm9czYx5DDrEHoBv05HOKN5/AKrHWcFIavEfCB/8Ez2q68i3jgVJeDdgkDZFlYNa
	I5Weobw1Q+UPCQuCSTe6PaXS4lTg/ZcSh2fay0fjLsiDEdLEfF3pG9utSzFh5grHybn9g9E
	IzMsnhUHn/5BkIfwhH24JkzA2nCiXTPxmSjWvlwrUgoV2vjCK8c0Fxd4fvpaWoIlQ9DBm5G
	qVtSaPA+y0pOw08J3uXFDqgdcqGXXAl8LJdORQyPct3jPev/mKBmyZNQTDGuhIq/2ssIi+Q
	M9/AdpzIXV/fjkD/AaYpvPtlFtEcaKZuev3qkxGajwnu16uCnjgw4NeXFsA0+bKfFUnDiws
	ZD7vLxoSlwIVlXHZi3A8ePW02n/e2MNL8gBtawjfvx3vNbU/V2MIirIeQzkB9lVzsWkwS1l
	S3ASkMJhUn4Xn548+9lv8kjpXdYyhPREnte2Hqd71F/AC7DAtY08MA7TjY5lFrJO8rsZaJ9
	ARSP+jWtXEu7v+qM2k1+0ag15Cm9kkKnp8m2X8aRG+b
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
	TAGGED_FROM(0.00)[bounces-295122-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:horms@kernel.org,m:kees@kernel.org,m:larysa.zaremba@intel.com,m:joe@dama.to,m:leitao@debian.org,m:aleksandr.loktionov@intel.com,m:u.kleine-koenig@baylibre.com,m:fabio.baltieri@gmail.com,m:tglx@kernel.org,m:gregkh@linuxfoundation.org,m:jiawenwu@trustnetic.com,m:andrew@lunn.ch,m:fabiobaltieri@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,linux.intel.com,dama.to,debian.org,baylibre.com,linuxfoundation.org,trustnetic.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trustnetic.com:from_mime,trustnetic.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8217263E615

It is about adding the Tx timeout process and pci_error_handlers.
When a PCIe error occurs, the txgbe device is able to recover on platform
that support AER interrupt. And for Tx timeout, the txgbe driver can
recover the device by reset process.

For ngbe devices, due to the absence of the current function, it cannot
br fully recovered once there is a PCIe error or Tx timeout. Its
function will be completed in the future.

Changes log:
v5:
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

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: implement soft quiesce for PCIe error recovery
  net: wangxun: add pcie error handler

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 289 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  18 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  55 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c   |  21 ++
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  74 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  79 ++++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   4 +-
 16 files changed, 566 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


