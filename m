Return-Path: <netdev+bounces-257451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKmzLTRfhWmfAgQAu9opvQ
	(envelope-from <netdev+bounces-257451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:25:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FD0F9B8B
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33009303CD3F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03632F77B;
	Fri,  6 Feb 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJfYJ2vE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5384032ED3B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348072; cv=none; b=r7qvJhDla3q46JvEL7F3xRmGwjoKJYJN/srzBMdVSsSrhZZMC40hEf8o5zMPUNFhpxXKMRGqj6j5YWQK2ADrZD83xWXCC2YOSpyC9yATuWwbo2p1O9tYy1fSs+Rs0sfgBO2BlAJjCjNq/xOGgpjGvmu+9h9lAy0psAnM/SPmn6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348072; c=relaxed/simple;
	bh=+4JrAqDQmP9veLgwI7O2JrBeM/2llqAoqV6R4Fcs/Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hFZJq+ayMzqzeJ8kyvUvkkZJ0i4O+vbBDsIzlLMnVSOm1sdPG8EHeL0TYVgkWujFV4taOI8IFNK9n/CIO5tpBkHcysgMrDHq9w0Bdk3kX1ksRg+2ARXZIa4Rx3ONdG2Jw/sxt5wckngma8CG3Ed2Ah7KCyywiVP9Od+Fh3iCWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJfYJ2vE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89505dd3e24so22587116d6.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 19:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770348071; x=1770952871; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVj2UxZYs+OgmoKfmy83dBmS2UcHn5JNr1hYSfwf9oc=;
        b=cJfYJ2vEnQx5RyfDx3j5kqUkuII22spIXqqb/ptSBTRIhg2wtjPQEatD3ebzkvLvjC
         eDcBks7n8ciDGSRhpoBNoc81IJjh8UPo1uG0WGD+vO5PbOxzeZ7BCuzxk05GKJHqv7Mt
         Hv7yW4mcUGJc95nPb8D4fJx3dLA2Xz/P4DbZEbbRKGPNbxqtxiQgmrRaRZHBLDU9zMgE
         wt6V/ae13SApm+xdPpTZIH8RgU/tF4LvJcrD0mnB0GmbJ4SWPJaJA3LWycnmsKff0EdJ
         1iRDO8YTZGCBckvpyPbes3HQvkfXlUUPD1S70htqZUw5PzBGRFxl3Ud0of5yr7Pt5pbw
         TeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770348071; x=1770952871;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVj2UxZYs+OgmoKfmy83dBmS2UcHn5JNr1hYSfwf9oc=;
        b=laQ8+IPryM0dd02SDXebrlgDqBhpjmB4CiOM7vi6ZJ3Xk4lDIitOxjdE8WH9LL6C5E
         zMFwCtPmFTcFK0w6NnSI6BYqKpfEwsAh1YQvvbge7bsmFGgUOWd4WcXF5aN/FU3K3mzb
         qC/9zdeAfoaUv7sjRTQ4BwVR1GA7OM3WGCKsYKpJuXBOXjVjaJy9N4Rs5CQtVgtsqLED
         OAkH7XMuvAgwSXOMFfn38oEOCaIVZ3LW83fyKH037WwwbF7LEyaNbJ6IesE87Is8ftIU
         u+oDg/l0u6y5YeTrtRH9yUCznf2q9g71AFjvNJuai2KKwFmHrgML92392flWkfkG1uVZ
         8vSw==
X-Gm-Message-State: AOJu0YwssIQVa9PrbVaqrNJFobR8CCzwx4fo29J8Im2SxxbCo8eSJegf
	wJAuYfCwtB1DxSvBW9UYDE5Ou2kB+HafLpsf7Pj4vjMzlZVHe9ytoETsIF5pyOyj
X-Gm-Gg: AZuq6aKk/2hrIm/rwkgspbe4b1mGJhVdzplyusB3u+imUY48sLmoVNiLMJ3J5Sx0LGX
	64IFTOP0OYCXSzPTUGbGxfcyOmykMtC5KOMtwMENW/WfOq1HZOO6by1UzVQJW8Y/PTFQvwN2pJX
	1lJ2Id7GZRzYHGRn5dQw3z/woeh00HDRfNvLRLM68tDCKVjbDgsE3adSLlDc0DjtDHlnxEwm3ww
	/8SGxMsvcWKixWP6OAWz9TbBJLv/PZivZ9m2QvTWDnvo1IF/6E0c8yF/uJesPb1DEafFq6NQ1js
	DWumVWdT/sj8P1DgXYBeJv3TqwTLlkKitrz9Di7d1PBSx3Jm+qtdDn2cNvjvsVozi3C8ZwRq04n
	R/2H8bf9HV4xFAsidZK+crNlVurrl+kgc+8hAqCLpTgRsxEnS3dMiZf1abDI4kXK7Af9V+FwM9d
	rAfSWXnFOf0+Im/RHhBolYheIBYjr0atY=
X-Received: by 2002:a05:6214:414:b0:7e3:cc6e:3c89 with SMTP id 6a1803df08f44-8953cfa19d9mr20809166d6.56.1770348070960;
        Thu, 05 Feb 2026 19:21:10 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf56a69sm9414296d6.20.2026.02.05.19.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 19:21:10 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 06 Feb 2026 11:20:56 +0800
Subject: [PATCH net v2] net: ti: icssg-prueth: Add optional dependency on
 HSR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-icssg-dep-v2-1-9dae19b19e6d@gmail.com>
X-B4-Tracking: v=1; b=H4sIABdehWkC/22MywrDIBBFfyXMuhYffdCu8h8lCzWjGWg0aJCW4
 L9XXHd57j2cAzImwgzP4YCEhTLF0ECeBrCLDh4ZzY1BcnnjkitGNmfPZtyYebi7s9KgEAjN3xI
 6+vTWCwLuMLVxobzH9O39Ivr1J1UEE8xoq91VqoszavSrpvfZxhWmWusPZybSjKcAAAA=
X-Change-ID: 20260203-icssg-dep-b9f7fc2be11e
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Roger Quadros <rogerq@ti.com>, Mohan Reddy Putluru <pmohan@couthit.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257451-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,ti.com,couthit.com,arndb.de,pengutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,ti.com:email,davemloft.net:email,lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63FD0F9B8B
X-Rspamd-Action: no action

Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
forward offload") introduced support for offloading HSR frame forwarding,
which relies on functions such as is_hsr_master() provided by the HSR
module. Although HSR provides stubs for configurations with HSR
disabled, this driver still requires an optional dependency on HSR.
Otherwise, build failures will occur when icssg-prueth is built-in
while HSR is configured as a module.
  ld.lld: error: undefined symbol: is_hsr_master
  >>> referenced by icssg_prueth.c:710 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:710)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:681 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:681)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:1812 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:1812)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(prueth_netdevice_event) in archive vmlinux.a

  ld.lld: error: undefined symbol: hsr_get_port_ndev
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/etherneteth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:683 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:683)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced 1 more times

Fixes: 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame forward offload")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Mohan Reddy Putluru <pmohan@couthit.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- Switch to the optional dependency as recommended by Jakub.

- Link to v1: https://lore.kernel.org/r/20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index fe5b2926d8ab060d83f5a58d91e749a45c6cea18..ade43c921c71daca930df5e890ca00b3ccf600c4 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on HSR if HSR
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.

---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260203-icssg-dep-b9f7fc2be11e

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


