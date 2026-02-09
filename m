Return-Path: <netdev+bounces-257888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK42MKJMiWl46AQAu9opvQ
	(envelope-from <netdev+bounces-257888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:55:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 314FB10B425
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 03:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D54300F5D3
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 02:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEAA2E6CC0;
	Mon,  9 Feb 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6/hgfm8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1A2DAFA9
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605708; cv=none; b=he5loxreptEdHxU2gjsqO6uxmevlWcnPMb2gGGtSJlsD/e3/LUXFZ8EBwQylhfvUGBXcUpXlF8T5b1VGKkLrMgYjYBomo5x29lINgwEMrmiWOlyQmJb+kQZ53HVRRZyG2CFXemAPM7z0QBmmDrgW759/3CU2nxCMDSRPKFy9Peg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605708; c=relaxed/simple;
	bh=KUBiAKiL+fqQFzFhjj6AWfg1RYi9pSV55KrSLt8VK1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NicRxzFrYqVZCSFFaV3kuwYS4lRmNfjAnQmuJ8H5Lxm+RD9Py+e6MqvddulFIhGQYloxg8O9x4eqcRwn2kblNnGa1AiSH4gbGvCVF88jFAH67iWU3pSlJ7j1VVTcaiirXobQM9EGi6Q5CrEmWdgHm5WCPfgQGoANzfNOoHteaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6/hgfm8; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b6b0500e06so3764776eec.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 18:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770605707; x=1771210507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7o01awh73bdpJrLOVF5ADIWN7TCOmY8qkJYCgz/HIS0=;
        b=f6/hgfm8xqqjKxXUckFWhMcVguy/XDbmj1bpNUavaAW7zZrABQk0IYooi+dkzJ7GX7
         qN7uZxQsPvwuaPbEdQyO5J5n0z8sX92v3A2pBdqhFbJrlHdhfuq2VgkH/0lRI7tfHzNF
         Q0yw+StukcGmI0iVLsMaZFrhLomYL3XR9gDK7cdz21kbr1WNwMB0qeNfzxKz4hWZPiTQ
         Tl1q+6JhcfzPCoaWsP4jG6KxH3aSUHZHXTQfISra1RfznQ0GQ/PRjeOhsAG5QFrBLjNS
         MaF6YHjObAAARgAx8PDAzAKFKH9crlK5eBoPp+dqqXR1WfH6Ep42vF7taeHwC+I6hI+n
         +JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770605707; x=1771210507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o01awh73bdpJrLOVF5ADIWN7TCOmY8qkJYCgz/HIS0=;
        b=YeWRFWdVyEfdTKz6qzUAwvlPOEvOJrjTI+Ty8euSlHcE2IkYvOjsu1/08tc9h4RP+5
         zYJoC4QfyVqOXY2Ma9NX2PxzdcVlkOuFBeXYRPmqe3HnUz0MIegYYjusUqAjOSDweW6F
         Ol3uP+vo6xbbsmL3zyH+t9WEqLaobJOSZoXB9XIYiXd0/AnatpG7F1tsrO5Hcp0MHvdz
         hhKKmdiK8Rk0g7cGEEudrAT1QgFcaEuPTqQqbaAOrODg+/2MLxQRkH4Hbk2mP4xFkfXS
         mIyKWNiqz6YXQGHOuiLSWdaspcx7IksnFQM2ygDu7Uo/3Gdmi1iO+aXAXTqof9QTdjWl
         RKgA==
X-Gm-Message-State: AOJu0Yxuqp6gqTltFxlFL3jZv8+qSU+De/mWRHD7+FnWfwvDupZTkVqc
	LHYA+IXiVglZ4U/e/tosEUB0zYzpF7/AK/tGla4qQMeaplDftoaVh4uXm+WJnRVP
X-Gm-Gg: AZuq6aI7mvA3n45117xULBNW9HaN3phYzB5YtA/QqCAQDsWawK7Z7qUfyLg4FclqR0j
	qS71TncRMG2W3lVvKvlHUZzY0/MLWYyDNMGtCVJfCIzYJarePVW5mRvvG3a2Zp8G7SlI9B+e8CH
	p65+P8eIMEgHoFH5SU0sZSOjl+j+mVKArq4Bu9UywGVSytCWh+tdDIkRLkf97Fo6vtUexy0IlPB
	rapW/LLb0qz/gu4ZkZcDsRGXQn9N+0wsQ0p/l6Tyr4MWBXjbqwn3FCE7U9vqcKmfnV2m1DNRk+b
	orI4mbjzEGF895yAyGB5ff6UVzcySw0GuksVOjOrAOP2ipd/rdj6+0+S7T7c9O3Zy3p0cu9bptA
	kxi+qBO8z1ugj9z+52GjMPAaGiAwUQOVESrOxcsxokdhBGFQM20YyrHLHLuUjnpphG3uA9/7+tM
	rSs+PoLlqGhE10dpzZo6+Hr6MKCCmrF0uL1OCVCK4NCAg805CBTDzx0K2JpnHRKJPXn5R/IlDvB
	GS0zEXSkA+JprH7jKRRjgGMJfcPVFg6ICEeLAgj4SY/6gkeUJTpYxUj6nrneJrfGXEu2+0GuL3+
	hNPJteyd
X-Received: by 2002:a05:7300:641a:b0:2ba:6d87:cf68 with SMTP id 5a478bee46e88-2ba6d885c37mr879391eec.16.1770605707155;
        Sun, 08 Feb 2026 18:55:07 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-120.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c89695sm6672671eec.31.2026.02.08.18.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 18:55:06 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: arcnet: remove code depending on nonexistent config option
Date: Sun,  8 Feb 2026 18:54:41 -0800
Message-ID: <20260209025442.50987-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257888-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 314FB10B425
X-Rspamd-Action: no action

The CONFIG_SA1100_CT6001 option has never existed in the kernel. Remove
code in arcdevice.h referring to it. This allows the
arcnet_(in|out)(s|)b macros to be simplified by removing the BUS_ALIGN
macro.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/arcdevice.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index bee60b377d7c..6a5af0943567 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -374,24 +374,17 @@ static inline void arcnet_set_addr(struct net_device *dev, u8 addr)
 
 /* I/O equivalents */
 
-#ifdef CONFIG_SA1100_CT6001
-#define BUS_ALIGN  2  /* 8 bit device on a 16 bit bus - needs padding */
-#else
-#define BUS_ALIGN  1
-#endif
-
 /* addr and offset allow register like names to define the actual IO  address.
- * A configuration option multiplies the offset for alignment.
  */
 #define arcnet_inb(addr, offset)					\
-	inb((addr) + BUS_ALIGN * (offset))
+	inb((addr) + (offset))
 #define arcnet_outb(value, addr, offset)				\
-	outb(value, (addr) + BUS_ALIGN * (offset))
+	outb(value, (addr) + (offset))
 
 #define arcnet_insb(addr, offset, buffer, count)			\
-	insb((addr) + BUS_ALIGN * (offset), buffer, count)
+	insb((addr) + (offset), buffer, count)
 #define arcnet_outsb(addr, offset, buffer, count)			\
-	outsb((addr) + BUS_ALIGN * (offset), buffer, count)
+	outsb((addr) + (offset), buffer, count)
 
 #define arcnet_readb(addr, offset)					\
 	readb((addr) + (offset))
-- 
2.43.0


