Return-Path: <netdev+bounces-281593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBGiA7sX8GmvOQEAu9opvQ
	(envelope-from <netdev+bounces-281593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553247CA47
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A01302D118
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849E372EEA;
	Tue, 28 Apr 2026 02:12:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D230ACFB
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342367; cv=none; b=CcWJ58tdYcgRPFjxgd0vtnzmgiXMHnHJ+fV97grnlsfdPORtUJsvOry/NP23rHbcOFfQFJTwSmvrWSVyWrqCorAm6xYoldm1aYdulZz0E/p+zr8z1zSgIdVCRI/9qyk6qXjJkXM3QcaU2qcYWWftZYDoDSa+5mtS7TNxJYEc5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342367; c=relaxed/simple;
	bh=c376wI9bbvUHaE4/CxYnAK/vL/4Qgq7MH2Z/nC1xMGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SYrw8+2Wgps1TVfHmCXC33nWchkWon7qZ8muWl8lAuhVSCMgtdOlS3swKJt7sgiDwx0i0b0kboXsyJkJ/SvQLb6vboll6NyRm5ryf4bellPTxaa7tUKTAt8l6JYefoa2gpwDVoGsNqdrdjGh2Zun6Iwu1q73NQQ0nIMFE3UsOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz11t1777342321tb4963b07
X-QQ-Originating-IP: zKLmg0MCRGt5wzGZ08GjFOfHz7bEfZsrmuZkSmo5DL4=
Received: from lap-jiawenwu.trustnetic.com ( [36.24.191.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 10:11:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3115868903190520075
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
Subject: [PATCH net-next v1 0/5] net: wangxun: timeout and error
Date: Tue, 28 Apr 2026 10:11:51 +0800
Message-Id: <20260428021156.13564-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: NyuFfSM9ChgrAHe0KvoqsWvYZG9LESRtqkGNw3UpaErch4koy48lrgKy
	IakBog34GnI7Y2ZcJRpow4gGSWURFHr7deLBxmk6kM1UTKmJUvW6IBUnREyd8BfODl5WZt9
	GAGkil4rp1zgkWpADgM29FUAU8FptjUTAk0yPPgDyHGac1aAln7n2dd5qsHeMeAnir2r0yi
	DlPzAHF1MSw8jBrxS9NQ+ZzOJHjv7T1Bh7cvPQDKgO91z404C+cgUaj1IAVYmXgcL7Gp6bj
	jyrnOi4N6ZTE7fXESS0NjtIXL56u+vD4pMWGcJICpwMd5+cZ+UGZqjrYDbRspmJC/0kJ+CE
	FnonMC+IU3YGzGNvs2ZoapesIa17ohlxukk6z12Y3A0ipSnn40A04eB+smuzk5kfqexhJAD
	UMydE2SwI/OTKteI8RJSZ7N26/EhZuim5aKvpA0AtjH9aCsYwlBrMOXk1PPrONYfEvV8zku
	Dr1h/L7rMaschMiVL2G7qRyNT4Qp2Mr10jrhDjdb/A4X9dCkPtSMGJU438Imm2SJCCmarzN
	7MmKD9NPW2VQypmTiVnS48zFyxrBJrS2fSUZtyzfpZrfDngMU9yHIb+tlLYGHYl415wnid5
	p0F40K2jOzR+TKg4g28HUaZ/leki0z2xKvuXI68eEhSFzSrqG7Fj3uxR1hWU7gTaAu+Fz5R
	v3QVAO1rBY9ompf6iI0o2mU7VBV4IehEzkg0Soh1WyDUJ9EgjvLZbd2u7gm8fHqxiSJacd1
	qr7vAKNvFjVBj1FtU3BJ3SJgqfNqaJE0o0t0FInUgXOyjDsuHV9QehPnchYIgJ081zCQKGl
	d8O5ypB8hxgmrx4AbDjhQJ//0qYMt5754Hc1o8gwhluaIyxaddf92269KTmiRWETqUbp7bo
	pjjg9HFlUOmQkUCQBuUtJumz4SUUqXNM3gHpbJtCoSarSnW5S/DdQmDXuaDxEoSFX3KSOKR
	Y9+E47+/oMXSXWczxeHEndR08MFdOe2gr1UYhCbzxT03LgDki7klCPGRvHEq6T07FS8eRKK
	FHw3dmEjfoNqRJpF2EYavsYPjBN0bepctsJ9Oez5EDCEnYzdgAef74pqkBHvzxXPQalrOVT
	LH9JwJBAJjzbrpPdyCwE1lADCwaXkE/ref1VVjJwQmO1OW3v4sQ3xpoa6eqI74Rj742iZKd
	MpFSlEAYdducYQqv0RIY48H0nw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 9553247CA47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281593-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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


