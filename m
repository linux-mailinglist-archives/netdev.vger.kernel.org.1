Return-Path: <netdev+bounces-280369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN0WHuWc6GlNNQIAu9opvQ
	(envelope-from <netdev+bounces-280369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:03:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23D44463F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15436305020C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E43CA4A8;
	Wed, 22 Apr 2026 09:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF734C9AC
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851842; cv=none; b=D1Qvd9REawbNe/aeoNsCrwwxO3XnonspcmsuNQM0TUuO111DwwoMsNtwoW/hYCVN58pX6Gq+tRbfhLbLpRGkOw8knoAwyfFTVltKwHdPbymoawusb9IKLN7qpAlRRV9JRNWQD5q+wh4kE+PjIY7fxNjNIttCQEX+f3vIQ5fVAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851842; c=relaxed/simple;
	bh=c376wI9bbvUHaE4/CxYnAK/vL/4Qgq7MH2Z/nC1xMGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=plOW1Rc2NR2V6+Uch1FIQxM+KsEHZdV4mPO87xjpYGrJq8A5IheOqX3fFEmwCOXx9iby3udjLTPj5hWbrMRq4Ek0xwc1D8+RtAMQx5BLFgYR4haEEq99UBJ7L4AcNqmIq0lU6UVkZV6MDis690sHwqzU/hW5u+t5aL9Q/sa3gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1776851790t3bc52678
X-QQ-Originating-IP: czZiHjKyUPojHxxTid1qlj98yy3WIcCFpMvV9S8O+48=
Received: from lap-jiawenwu.trustnetic.com ( [115.220.225.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Apr 2026 17:56:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11127821316921811768
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
Subject: [RFC PATCH net-next 0/5] net: wangxun: timeout and error
Date: Wed, 22 Apr 2026 17:56:12 +0800
Message-Id: <20260422095617.27080-1-jiawenwu@trustnetic.com>
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
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MPImiETYjPupEFa2XSCy3byLd1mOjIxLBMQ0bkqHUJhMQmJHjG6UAfi1
	WvoXPL9CD0x19BZfJ6ZWswLorHJnxy3i5NkuKkP6zVaFUGv/uEFSk/OC1W+iVCmRXvxwYem
	lc+ukDCYpsR51QnO53G2dIFL1ng9fG1G4hHkoDcNotqZxbRirPltSSXf4DL2snaTlqt/EDo
	VHM+7XGATg8n8dJLJG/QvgK8T3UyeCycuZirocCGQTvTONsQhJzO42wGKGgqpiRTFBThje7
	GLV5iEOEn9tDLdNZGcwQ0rqGHpBO2xYzohZKtgjk7GnFOoPUZXDcOWkDJKsyw1hD3D48yFQ
	XWU578wRuRdYKl8TttBaNxuGMrXIEvPTKA98T0Q1NqbVp8mrX7x2ekCajnABwWGc9Q2Vrin
	cS5Xtz3BfJxG/voZQ+V14RVLiV/uPkwgPmZmv6rA6ef12LOIseJ2z/C0qItfXj+wtoNWTZP
	iir+uynfE6Pxmx/7D7n+/nvvJfPaLsqJW/jigZc7fGQ98GtF/Ewe2bAHp9dU9SPXqUDPLww
	3/g5BxnbH5sz0BVoVOSsXKms42h+uTuV1stxGj/n0H4ywNe2T3cztGwBvH6P+1J20xrgZAj
	d2NaHSFRauvKqW4I2baH5Uflp/r6BlooMUpaONH0VzTx8zAqImONy6IDBAslDYbuIIyFOoD
	AOCaRi0kKIyxWkUgLA86u+e46oCioAb5Yeg86yReczTxK8kLN+CmxcRWx9z43GBPzLQpK4Q
	TklxccJXteFFR1Z0UiVHtB1q19X/BvGrxhr4qV+4FNaPVQEpBTR1aFg+Btez7kTkl1271Hu
	8w7jbKbxX7OQMkPOYDn+PJw79p6iQQSDLdQP3XBF7PlmHEfxoAh3x+F1wKIEiIlbrKBKolU
	d9azYw7zmRA/vBy7coaR4ymo+AFlm4iv9vr2ks9fFMEJgO56nCBg8kPvGvPYpRFH7Kp1PVo
	sqMMhLGjqM7+ryt3JG1wVQSI8H36t962ijAF4o93Ko7LdPcPrQM8LRFZsYL77a1Nd0agcar
	Zgdx5OTpUUnYUGFMQgz09iDxV52CDA8TmTfO6KStnuzKbOB92yBrYaTOQAQvYV+t+qNxI+a
	0YRQRtLwbRTlIfWAFW3tYgi2TMUA09u86qR99p3z7VJyRWyZs6jlSVr/2g1l4ew20256J5k
	hwmxqNyKv2/zbr0=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280369-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustnetic.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE23D44463F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Jiawen Wu (5):
  net: ngbe: implement libwx reset ops
  net: wangxun: add Tx timeout process
  net: wangxun: add reinit parameter to wx->do_reset callback
  net: wangxun: extract the close_suspend sequence
  net: wangxun: implement pci_error_handlers ops

 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_err.c   | 232 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_err.h   |  16 ++
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  17 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  41 +++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  16 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   1 -
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  68 ++++-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   2 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  26 +-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   3 +-
 13 files changed, 398 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_err.h

-- 
2.51.0


