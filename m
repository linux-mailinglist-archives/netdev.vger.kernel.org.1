Return-Path: <netdev+bounces-291279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N6oN0kfFGobKAcAu9opvQ
	(envelope-from <netdev+bounces-291279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC25C8FB6
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58E953002B5D
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73414337110;
	Mon, 25 May 2026 10:07:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC921FF23
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703620; cv=none; b=R36F56e0Y74Kmg7pfh7L4kdgJFUdPuPETEiwguKalGKVwBtJN6KuC3EMIMdJlvKWZQn3wuRlJem33NQWgJDkdVNyHDCjGbDe5z3eLd3+1S8gWK1gtVztirmM7o3JAOwa/1TrMZm+7Ug/IhForYb3hIOQmyYFko8onk8G8JJZlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703620; c=relaxed/simple;
	bh=mWVN/VQTxA+A/4yFTYO9sc5WKP1KSXBlpKjAi5xfc7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gTwxD0wKSEkDJE4sS9SWxcWkCGntujL39LrAdQK1n/IlAuyo7/KEcJ/TPvGafnQD2Y0QlPL34ZWQhzFOMguEJ0RZXS60b0eBsUtVyKrQW3qIRsFPDXx6GEwKJRtzopc5avclnCB1GBywAMIzmnr4i0xBtkI9oWy6lnoPv+bC7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1779703552ta8981f1c
X-QQ-Originating-IP: bFXf3+thFPpARMXvdQ0cQLvTzI/hcvumMb1jc542XWs=
Received: from lap-jiawenwu.trustnetic.com ( [122.231.28.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 May 2026 18:05:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1092396924819628532
EX-QQ-RecipientCnt: 12
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/3] wangxun: improve service task synchronization
Date: Mon, 25 May 2026 18:05:40 +0800
Message-Id: <20260525100543.27140-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: MABkn+BX1UZ4ovff1MRaRd9q7B7IIXd5a4gPxhy7hIZiO4OIYdA3FaQL
	0ACK7kqz2uN3uKryByZt80rv1T5vopBZDMXTGrZgLpBTC9xphm6xQgDtKzhpbbw1xFMfUfe
	Vl5II+XUMgC6p4e/7mhByvPMT04AZ5So6u96HbmIw+Ccn8RQU52OeslgVW2mLsJ5/5aDC6W
	FOVDyKtqzZmXH5avHX1ctsn/hWXUQhZRqQR6AN+PNZRvprXRLY6jcu6RZ7y9EUqWPJl6BUm
	9jzF8jHemfu92SyMBnxUhglGKK07nQ94e3LtubrFk+hQMTpX7eW88ocX3x73OW2aVN9YXVq
	ZrJs49oxNQ2r5bCDLFMDkvQnF6NHq+Vma/Gb7qNOuR4ITZYmkcbockkVjL6rKB4yJhM2gPi
	DZomj/zYmB1b2PlDPLBJpK5APD81870CarTnOn66in+sV0rN2j+gMnfPzXuP95/2O7+g75H
	lck2oKJyw3DPjIWV7WjeFkJAejeBZaFOLmA9aGaIF8kWPcFfwQcVPClr4w26pw6wW4v1SBC
	fjnCqWNYxVYvlOOdY9MhMdQt+72UgXR1KzDUaHZLkqzN4B81JNzocN4bmmeaFL7uxE6B8FQ
	aZ/8NJtcDdK6Boqssgtqbxwa1fX8a395Y2yeJN4a3WDwbmfATqery9F7QXzNko23sp0MEzs
	z6CCxWd1wxmoYxBzX0w+N2ETxQyzP42HOnhIRcMST6D1mahgC5/+MQfsCW9MszkcAj3nS4X
	lqCIkWzRxKEhcpmr1qIqO7MFR6/eSp6Qa//ARxpGPe16dBWYjjoZ37z2XdIcvVaRHcfSb/I
	WOCbtoCwo21LpZIw1ko6D+S4kyIL7a/hPalirRwBX0Mgvv/9ZORmhMZKRNitKYba/7C8nVz
	Etqw06PUVVJGj1u8IDITofVIcOJVTkfXnmYNX4LeIeD633mC1Q2Ga1VGlsp5H+neEjPsXS+
	/EAAI73zcWaSlQWagAJCc6O188laagY0ygRaxfruA32fkt2VtpvhgE6vX7w7WVBcQfPOzqz
	M8ojpyXHzMvUNetDBnJ7/yARjZ3L2Myq0xiqVtGn4TrnWp35vbJYVYDKTOZerEQU4wjal7J
	xwWDMCd/O8Q
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[trustnetic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.776];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 35CC25C8FB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves synchronization between asynchronous service work,
device teardown, and module event handling in the Wangxun drivers.

---
v2:
- Check WX_STATE_DOWN before setting WX_STATE_SERVICE_SCHED.

v1: https://lore.kernel.org/all/20260519080048.7448-1-jiawenwu@trustnetic.com
---

Jiawen Wu (3):
  net: wangxun: introduce WX_STATE_DOWN to serialize device shutdown
    state
  net: wangxun: avoid statistics updates during device teardown
  net: txgbe: rework service event handling

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 ++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 ++++---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  8 ++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 14 ++++++-----
 .../net/ethernet/wangxun/txgbe/txgbe_aml.c    | 10 +++-----
 .../net/ethernet/wangxun/txgbe/txgbe_aml.h    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 25 ++++++++-----------
 10 files changed, 39 insertions(+), 37 deletions(-)

-- 
2.51.0


