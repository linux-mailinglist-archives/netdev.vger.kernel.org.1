Return-Path: <netdev+bounces-168339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EEFA3E980
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B56119C7D58
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A719938D;
	Fri, 21 Feb 2025 00:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CZLqLx8T"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5E3A8CB;
	Fri, 21 Feb 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099430; cv=none; b=ANJU8ect+tcvR8Y26oBXHv9UjVb7AqCCQGWI/vR2mRe80aPqd1WGj/31XZ8HAUhdFcb4Nx+Zttq3CJh0oRo3qr5CJy81mf/a2BmhjC4vc4jkJEgaYSwhhDEK1x/WeaeWWE+C3oJ/Hj++msGaWnuZyTsds9T7LOSFX0RryFnSu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099430; c=relaxed/simple;
	bh=rtrAeCsXXoCUpu9+jSYoMdLZOLlxltcO71tPwj8qZS4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hvzgr+CzOfSrUhbyIIC/++iw/CGQEu/CKgLaYla9HnB+bBN0EUj8oxPRQNKTbNuaCtcVYmHn8FlaHFkWb3YlJD5zEueu1L3pR9uPfnvH1o4eTOb0uS6ipS2y5QKY3QFumIBcPUIIdrkH4kC3zGUhn59iVgMKxIEytiLS72UUj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CZLqLx8T; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740099426;
	bh=riXhQfcYCweNUzqtSXew8PnVpn+jAe3Ir3ZEIQHjWEg=;
	h=From:Subject:Date:To:Cc;
	b=CZLqLx8TrlnggiAVBNPIJwELOlO2qLzrEfa48x62mCxV0cOwpznhEc1In9B85+J1S
	 is0rf+lCFqjwch3uJFCIQpRB9iLp6elvkMskSr32oHWdVcfuRasD4TrwpUOLXjuScm
	 t8QyP33e8q1Cd1jtojGHh+STsX/3vNXZIXR5UlviECVSxDdVQ5eWFtaXeGb11/Aq1k
	 qDd16xLg5rMo1U9wffLHuZZGuUZuNNGJIYUsvyXln/3FJCQprQapAnKi1Y2fZn7DFi
	 TEeT5DlXhDvfIaz0l9Q+aAaDSz5SRSTJ+9e+46nkCdaWosjbumf8Rz0n+abn0cMFJm
	 VBDB7BfQbLH2A==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 5D6BC76B8A; Fri, 21 Feb 2025 08:57:06 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v3 0/2] mctp: Add MCTP-over-USB hardware transport
 binding
Date: Fri, 21 Feb 2025 08:56:56 +0800
Message-Id: <20250221-dev-mctp-usb-v3-0-3353030fe9cc@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjPt2cC/3XNQQ6DIBCF4auYWRcDqFi76j2aLiiMlYVgAImN8
 e4lrJqmXb78mW92COgNBrhUO3hMJhhn82hOFahJ2icSo/MGTnlHORVEYyKzigtZw4OobtAoc2q
 GDvLJ4nE0W+FuYDESi1uEey6TCdH5V/mTWOm/ycQIJWfWds2IXEjBrsppVM6G6FcVa+XmWq7FT
 PzDYfzL4dnpBYo+Z92L9o9zHMcb0P/aKgUBAAA=
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 Santosh Puranik <spuranik@nvidia.com>
X-Mailer: b4 0.14.0

Add an implementation of the DMTF standard DSP0283, providing an MCTP
channel over high-speed USB.

This is a fairly trivial first implementation, in that we only submit
one tx and one rx URB at a time. We do accept multi-packet transfers,
but do not yet generate them on transmit.

Of course, questions and comments are most welcome, particularly on the
USB interfaces.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Changes in v3:
- Use GPL2 consistently, rather that 2+
- Changes from Jakub Kicinsk: u8 over __u8
- Changes from Jakub Kicinsk: use dstats helpers
- Changes from Jakub Kicinsk: skb_cow_head before skb_push
- recovery mechanism for rx alloc
- Link to v2: https://lore.kernel.org/r/20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au

Changes in v2:
- greg k-h claims that it is 2025; update copyright year
- Add spec references
- Clean up dbg/warn output
- Changes from Oliver Neukum: drop usbdev ref, avoid a GFP_ATOMIC alloc
- Changes from Simon Horman: do rx stats before netif_rx
- Add module metadata
- specify phys binding type
- Link to v1: https://lore.kernel.org/r/20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au

---
Jeremy Kerr (2):
      usb: Add base USB MCTP definitions
      net: mctp: Add MCTP USB transport driver

 MAINTAINERS                  |   1 +
 drivers/net/mctp/Kconfig     |  10 ++
 drivers/net/mctp/Makefile    |   1 +
 drivers/net/mctp/mctp-usb.c  | 385 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h |  30 ++++
 include/uapi/linux/usb/ch9.h |   1 +
 6 files changed, 428 insertions(+)
---
base-commit: be1d2a1b151deb195cd9749988163aa26ad6f616
change-id: 20250206-dev-mctp-usb-c59dea025395

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


