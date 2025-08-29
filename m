Return-Path: <netdev+bounces-218187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0FB3B6F9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B565984D70
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5B302CCA;
	Fri, 29 Aug 2025 09:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C862F3C0E
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459169; cv=none; b=R6hRuPcVEIKBk4aVu0yLCSYHXa3EDd8KaCEfXbmxLtkPIv9wAD0cf1vXqMSXGN1MmifC61IFXijVIhz/hglDhMuPq3h0aDlwzNJn1le3qUzuMbP9yKeid+XmaP78IJtG3KwAi7x4bC+GbEBuEpjufSed/jns+NrbgQ3Ngtdazp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459169; c=relaxed/simple;
	bh=jFIiii550M4PW96EW7IlJlQ5MVN9j5pijVtKyFcM/Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cHjf+EMwxMZTtMtfARqlLHaVK1jjztk/oU6t/bUm+oKPYb7qhWiiiv02+7Fjdy+dHtAQ3Lo1T5YFsI67X3v8CaL+QRqwg+czhB/HZxWRoMxawkXCyq4EdHiCw2oVi9Q76IJh2knB9ONOqBC/4GvU8XCcJlItW/JpwPARSrHjCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz2t1756459086tdd814e95
X-QQ-Originating-IP: 9Xi5bkLwZO0UtmTGGNZ0jVZyqtfQupOWTd9I4wexJ7I=
Received: from lap-jiawenwu.trustnetic.com ( [60.188.194.79])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 17:18:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13793811014313054338
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v2 0/2] net: wangxun: support to configure RSS
Date: Fri, 29 Aug 2025 17:17:50 +0800
Message-Id: <20250829091752.24436-1-jiawenwu@trustnetic.com>
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
X-QQ-XMAILINFO: M0/UNHhZ6hMGdsWmT09WVHImLgFTPcDhzpzgpTQwAobrNcuyzVB3BXig
	HbBKYT+7O/bmqk1Dz+UoNI+2Yf7Pnr64ZhuCzlO2DBGI6XyPYpHX3gHFMmd4j5DKRwTA0aj
	YEDei7AZ4HCvko2pM0TdNOPSYqFq8NJads+tR1M15e6PD+cpq9oPbrWC+5JJN1Zhadpsbp6
	avEDlcrkR/lH8DCFv+XRe5N9IMgJ++WruM1DKuhVecfHJWWKj/8roFgTNhQYFweNt2E4qWN
	/cs8GLxV3WszxOAD94Rj5INSelXRrko19cgvu7gVPr/v46EoSWAh4j1EvpPihCn0NN5Zpld
	n3bbo0HmYb9Xg4gvEakO39Vb8+UfG700udQXk2DDhNCIhF5wWCVi4weqt+oglrXfj0rno4l
	zYvyCvzj1daEq0AhoIDdhSx0KrTkPa4w/fW308M22d22hqA3WrvjJPHOJkeg3X1MnZtCP4O
	HOD43u9kv+Fhb7oG1/924hjkPGr9TNznd+UmqKtzlom7+wxtyRH5RhRgag5Xz5GX1F7yd6m
	E0eqSI8FMOhCY0vuml6XessSwfeDBYwBCYcY3ugzetmRna6wWHbvhn8OakJUVMAYL5GlU0h
	hw2WVGBD4ZETw4aNUvqhyef5mhw5rNSe/quLBzcUU4Z4rwvHdgB3at2UlTaAz6ZbKcDpCJC
	CPrLZhfdyIzZYai6It2nR1P0apZMWvwy8M7mzJvloP/aJYaCSsj4qrBNCBPjdPOzEdzEhEM
	fja1EXj6OjIKZVOg4IeiOe7rwRcaGlB8s8tR8W1WJRoNe80CyWqu8Y6u2fuadwNqjsKcatr
	UrK1XFXxDie2YvZUL4k2YoXE5n4zqFa7Fy5tuqhLrITSaE6S1NqEUx5YTuprSVpw5pB8l13
	ua0wFXgZ8+bMQbZJ1mMGb9ynU6SdNHoK9wTdyWJu18l8iNDCyBcTgeaJ6wIgha1Z6N3VCgB
	ZaFaUlSB8rlK6q+PxaibJWCmRFzF7vr1aTMTUggvTYrm+fwTb4fSTVIFAifpYtywqWpKCsl
	XxWcjPOLztF3gtBm4EjKco4HgHXmLZWz35qRWsBnix14SfmdhJ
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Implement ethtool ops for RSS configuration, and support multiple RSS
for multiple pools.

---
v2:
- embed iterator declarations inside the loop declarations
- replace int with u32 for the number of queues
- add space before '}'
- replace the offset with FIELD_PREP()

v1: https://lore.kernel.org/all/20250827064634.18436-1-jiawenwu@trustnetic.com/
---

Jiawen Wu (2):
  net: libwx: support multiple RSS for every pool
  net: wangxun: add RSS reta and rxfh fields support

 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 149 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  12 ++
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 111 ++++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 +++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   6 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   6 +
 8 files changed, 291 insertions(+), 31 deletions(-)

-- 
2.48.1


