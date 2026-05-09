Return-Path: <netdev+bounces-286135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CSyCioH/2lg1QAAu9opvQ
	(envelope-from <netdev+bounces-286135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 12:06:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA874FF174
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F6930115AE
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B238E135;
	Sat,  9 May 2026 10:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55A346FB3
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321190; cv=none; b=g3TCcPaRk1xDQF5nBD/v3P5Vb7mtZQv7Rdq20UEzH+7wWgI1Eb0WzIZTfMMq7AJAP2Nc9waL3qCMooSyfkkLa28qs4VVme8y7oHuyvPZXeTqupKL43mzoFFRl2HYde+FVnSrnlLxLJh3dsWQNTq6UeHuW5BjPEhzBIP/tOmWDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321190; c=relaxed/simple;
	bh=Z78U3ntXqsJiOkj/plFJbU1bQIHpmoBeQotSsrqtaXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H7/VnR9bquTgZzTR7ZmmVtcmhlbWQm8hTQV6kEMewrXo2laPbGK2fiU5O8mlqjpy7PKDHEtVkBt2lIiWwXZp+mt4LDlv9gIDB5cQWDMqfpwdmJWFZGlcbR2C3CLHd3RsTqjhHs5b94qBWNtV/lyGiX96uwNULp3XQIYZxHAkndI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz17t1778321145t6ae93e6b
X-QQ-Originating-IP: iy7uGjHXY1gEf5jD/na2OWzFnDZBVBh6hmGfU+Vh+pI=
Received: from lap-jiawenwu.trustnetic.com ( [115.204.251.157])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 09 May 2026 18:05:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17504687254180504696
EX-QQ-RecipientCnt: 17
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
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Joe Damato <joe@dama.to>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 0/5] net: wangxun: timeout and error
Date: Sat,  9 May 2026 18:05:35 +0800
Message-Id: <20260509100540.32612-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NXg1pQ+Gy0fD9h58WqgTQEtBN8x9e9CKdygUkzADkVWRlEnWIuvuxweC
	uUE4ADSfjdPYJoC4feAMhbuR4eeEcizuwDnQ1diuzvZuPX/L8VvrcD2ZIWxGUlzKgzX/h+Z
	LVFCfegBAh5bjbB4ZTcbu3rvxOJiiIkRJiMnhFerKdNx8CB58LsHztZBSkKfoGrUA1A4+2O
	K+bLnnESEpXXzdvGR+n7BX1Q2n3USP08W2A3P0pyES+L71oNcKoxP5Hse76X2VqKx972oUm
	04RXdCdUT7sa0z6WqQzuscuSDN/kZnNvaY+YkF4sCGLtvVgivzzyPS2rLH8XoKl4+S2bylJ
	hj93h28yOGySpazUrxdk+UKG84X0cwYUEj1W2Crjh1nc3n2gyQIlVwOaDa8hau/XJOhQyfh
	0g00YO04jjvLo5wCSWpW5beVhPDYUA5Y8xs0JmwpXjFsY7DcY8eQrgtUCudcLZwjgQBSnL+
	0O2afkUhRuRlWPS0d0YlEIHPhnediE0yYd5Ds6xX6NNn0k92x/BoKhHlilPw5rtb2RZR6rH
	FXVFfYLtWJ1r2YLm4Hc7jHgaKbgz7QK97NKJMU68hQaL0KUi+2W3+hbuK02wd476SE/UIOv
	Ds48+2iM8jFd4Sk/R9I/qlWHPLSOzEO3Y6tFL9EzUR6blHKCjOuZNzyniCP0uSmkKrbmWvW
	H43j/v8cQQOWqTLKJRMcQ8J0G8QLp+WwHfuBQrlo0MCgMhI1IM80XpJMnOh441OFtiJfUQX
	Mcwl5ciRR4fa+21oWaqNY/e60P96rDz5GqOrSsODzNtpS/rqNoEHkpXJnf0jmvW1j+ujkyP
	9Hoi6A83UNTkO6U9mxrQf1g1c6xi1iDFcClAFhgnuPffa+yirWrDKGuuEa5Fp71xRomFdGJ
	NCjERcSQPaQMcaujwg+1ZoMyBGw79ZxNVeGFycxW4fJ4cqxOhq1bycEdfzMx0MZmKgaVv0/
	PKP8oKS6rd9QNkks0oE6+DRUBKUN6YvjGiuzSKH/ZmnHRUK/IlXsVzz75o7VRFzpbgSWGXi
	tip6Bvs1VTOCoI4uewuFck/l9DuaYWjLivaAcJw3ijeDrJe4ihdcFkvwS3upluPUbG8+b0E
	QuPg04ijbvCtvCAVrSR2SSfONNCQDZLOymaQDr3GsT6rZTKrVEJarBDvgUTohOpzIQq2q+x
	LouAaGSMNrZ9vkA=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 4FA874FF174
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series is a split of the previous series:
https://lore.kernel.org/all/20260326021406.30444-1-jiawenwu@trustnetic.com

It is about adding the Tx timeout process and pci_error_handlers.

Changes log:
v3:
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

The changes from the last full patch set V6:
- Add 'else' handling in ngbe_do_reset().
- Acquire rtnl_lock() before checking netif_running() in
  wx_reset_subtask().
- Use test_and_clear_bit() instead of test_bit()…clear_bit() to avoid
  losing another reset request.
- Change ‘u64 tx_done_old’ to ‘u32’ to avoid data race between
  dev_watchdog and NAPI polling.
- Check the return value of ndo_open() in wx_io_resume().
- Drop pci_save_state().

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: extract the close_suspend sequence
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 262 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  17 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  41 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  21 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  73 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  34 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 12 files changed, 441 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


