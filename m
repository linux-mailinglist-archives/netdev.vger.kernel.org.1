Return-Path: <netdev+bounces-165375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82217A31C3B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327A216195E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B01D47AD;
	Wed, 12 Feb 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="nRH0J9zY"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F927183C;
	Wed, 12 Feb 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328441; cv=none; b=hv7iyfgIIDKW7bWReh7sO3y9x/pbsgzPTd6tI0jId1jZXFPps2Y1MgOGb2gaGSs7070x0n1+FRjF0i3d3gbXJCqQTLamY6jeJMhK9KRnUcyvX1YxJe2JTs4dF4QCrc5P7Q1d8RQ8KT68vmGo1q0098qv+/evOfPU7I5pQclHFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328441; c=relaxed/simple;
	bh=8U7BxGlajuRx1zgtQoYLcdsAt3WP9jTukvHfgBFw524=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PgXlHORS2QYjBJIiaehYOKGEJEGggnIQ3qbBLUxOVSIAdQhtxB48+6OTV+7i0UCV25UFk2VWAMy9/6AYXrQQ4TsD3BfpTSibWIwda+JjLvlGWi50seBllgP37jINJkeiDWwreFLHylbrQdhehoMg9SUG8jwv1A5A+m54PMrUueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=nRH0J9zY; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739328431;
	bh=JNPZnHcItB3V8s4XgYQvSmAMqku9yB/jh5nDCelGUI4=;
	h=From:Subject:Date:To:Cc;
	b=nRH0J9zYFZGTgPY5gQ7WcqmvKWtDEQ/S6hPr08K0CnDNMA/9zbXG1CbPLRD8ojMMC
	 fibk+aS+HUKn5IaE2cP1eALWcV6/8oIT3N8zluieDj8mPj/OdFrR2xrB3/nqhqwCKG
	 WYN6OKagBcPM7iq+CJL/jIYEx7zltpeWCfzQGuolMD1YLiq7uhiYT6oJyp0aK13E6V
	 Nz1GwIRmfJH5pSy52KzqwMS5yIs1yBGCXzZK5W1oEhdNpJg4mV0VtMv7IvvL98V0Bd
	 7VAumPypGLHcWb23kA+n1rWBbkNHmnNIURRIzIyoTu3v6xZr8yebMghUTXw1NyFXyt
	 mqflBtNUnZVsw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 60EEF75693; Wed, 12 Feb 2025 10:47:11 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH net-next v2 0/2] mctp: Add MCTP-over-USB hardware transport
 binding
Date: Wed, 12 Feb 2025 10:46:49 +0800
Message-Id: <20250212-dev-mctp-usb-v2-0-76e67025d764@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkLrGcC/22NQQ6DIBBFr9LMumMAi6ld9R6NCzqMlYVgAImN8
 e4lrrt8efnv75A4Ok7wuOwQubjkgq+grhegyfgPo7OVQQmlhRIdWi44U15wTW8k3Vs2VbW9hjp
 ZIo9uO3Mv8JzR85ZhqGZyKYf4PX+KPP3/ZJEo8C5vuh1ZdaaTTwqWKfiU40q5oTA3ZoXhOI4fo
 Ky7ob0AAAA=
X-Change-ID: 20250206-dev-mctp-usb-c59dea025395
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 Santosh Puranik <spuranik@nvidia.com>
X-Mailer: b4 0.14.2

Add an implementation of the DMTF standard DSP0283, providing an MCTP
channel over high-speed USB.

This is a fairly trivial first implementation, in that we only submit
one tx and one rx URB at a time. We do accept multi-packet transfers,
but do not yet generate them on transmit.

Of course, questions and comments are most welcome, particularly on the
USB interfaces.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
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
 drivers/net/mctp/mctp-usb.c  | 368 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/mctp-usb.h |  30 ++++
 include/uapi/linux/usb/ch9.h |   1 +
 6 files changed, 411 insertions(+)
---
base-commit: be1d2a1b151deb195cd9749988163aa26ad6f616
change-id: 20250206-dev-mctp-usb-c59dea025395

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


