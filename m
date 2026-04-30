Return-Path: <netdev+bounces-282698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPCxMTES82k4xAEAu9opvQ
	(envelope-from <netdev+bounces-282698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:26:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B849F369
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C8D30131F0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D539C632;
	Thu, 30 Apr 2026 08:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F0374E7D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537582; cv=none; b=T+UL033ysYnzAqzu1pW7BgHOBXs4qM7NZgXorBEQHcKNBe9u4ZwOrsjW8LkKBNRup3tSR833m6aFCvOxbhlWVq12FGn+Yjlw99Eiscc5bW+tcnNhD8iwG3VYtRiYs5R9bVrpvtzz/esLa/lOZtJHqbGXgQBfr6XgNQxUQqnuJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537582; c=relaxed/simple;
	bh=PJjPjthIIeWzZk47RWWBa7mhcTk0U2JgeKm/jE8RVsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M1xIkL99NomkXYyrMSPdtSmWWnfgWEAOj7Sx5p8HXKdtcamVwg/d8ii3Xg7naYHNalZG9j2w7TDeFfODb/cFONRjx5oHJnmDxIgmYUB5biFzkmTlxKC7uoArcRSsNefXkaaRM27xZ5IVJNG7VeXskX74zyASvUvU2mcNq2e/QQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz3t1777537541te6409ba7
X-QQ-Originating-IP: TlLHuA/tFaEKPJGMx1EVEQh4gPnFBNOWElgJHKadWJ0=
Received: from lap-jiawenwu.trustnetic.com ( [122.235.155.141])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Apr 2026 16:25:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12986491680959024494
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
Subject: [PATCH net-next v2 0/6] net: wangxun: timeout and error
Date: Thu, 30 Apr 2026 16:25:11 +0800
Message-Id: <20260430082517.19612-1-jiawenwu@trustnetic.com>
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
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mi0NhBPPe/4Rm55Tag6yTmnHad9PNiOJhuNrD6cKSl590C50Rszv9V8m
	j6cFkn6aB45GoP17OHxOemNn/KMNkwBIJkyPxpaF/B/k/bbY6T8u+RK7iTzRDiw4YKu2OPa
	mRjYGBcGfOrnEMh9XxizXHutAReM1dPpU0kbSN+hgqr6K9bo6CjCuBuO60g9SheCJ1svujW
	7PYdcVrmnI5UDC4aP8GRPhKILR7aJPDFTgx6PeudlSTbbzL26WVjGTd+d3akEy5eIjpc7We
	YTAYwoR2VzHZH2RnkImiSVlZzC4wEbJc2gYOA2ISWHqm4C8NnpkFvh383J1UecX+52BaDNa
	cadAfsj+6CXqyGYtCgW9Hu7RcZ8Wrg4MmJnvHmsOeRvZOUlmfGvuFTrkdTPfOQyrVOSsMww
	1lEk9N8sSvoVKThPmhmIzVztdBAK/MJXr1cACIgXuvx/U9qbQQJlhJx3mK4kqxsfMg+ChCn
	ZoH2/GaijqC1EF8yEqJRbcuVkJDpCSZ5B9qwgk0YQfFjd9g46WstMkIAtxJ6oTKggsyKasY
	dN8PpL4FxThavehwD/XnutHR6aS+adE3V2GAoKlLUW11QrCsGaHHm1AmShnbpYOCLytcSrj
	elHHDCZmcl7weKjl/M9u4tcLV/U3D0uLNF0nrlduNPB+ujxpV+WbbYJap+tsYwU5xhGqf9/
	VoOW26yRAkIFBKUqLz4qwqNo7fPBJcyYZycdq0fcoIjCSIXrMApo26c/l5E4MfCDWIZhsVY
	iQX6a3iHMqz9MA7asGQouFEd6WdAXNpMKpwsGotHZQqylS8oZzRQSc0dzJav26l5ZfGNot1
	Wk/5CFXGOR1iIWlL5KtW4z9g2lfYAGpumWlcyzWekfhw0P3zjFqzjqp2dywoLOB8V604vXd
	skTnvgVTdEwyOSeQP0wLUrmVdv/dNUWPx9lRPD50QQEzgSpOFdAl5jGDOwgbLf5MFSmg3TS
	7kM4wbTmPR9/MQV6WYH87mgIvbQqVe+eie9KfIcyYe8JZXLJa5aA3Ay9ZkjlgFB4LEPXc+k
	ADZ1JwR8Vy0o4SEXU0dVvb/3YUP0izBgaIwgvRFj3sZt4XSoZjkqXXnlq7UXiOhypcTdYSc
	SoOJJXFGD8E
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 104B849F369
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to,trustnetic.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.562];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid]

This series is a split of the previous series:
https://lore.kernel.org/all/20260326021406.30444-1-jiawenwu@trustnetic.com

It is about adding the Tx timeout process and pci_error_handlers.
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

Changes log:
v2:
- Add the missing rtnl_unlock() at early return in wx_reset_subtask().
- Replace ngbe_close() with ngbe_close_suspend() in ngbe_dev_shutdown().
- Add a patch to clear stored DMA addresses.
 
v1: https://lore.kernel.org/r/20260428021156.13564-1-jiawenwu@trustnetic.com

Jiawen Wu (6):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: extract the close_suspend sequence
  net: wangxun: clear stored DMA addresses after dma_free_coherent()
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 233 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  46 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  16 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  70 +++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  29 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 13 files changed, 407 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


