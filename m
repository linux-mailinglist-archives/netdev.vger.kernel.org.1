Return-Path: <netdev+bounces-267900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hddOBNObtmlAEQEAu9opvQ
	(envelope-from <netdev+bounces-267900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 12:45:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A52908B6
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CAFB301C6F7
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 11:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64EE26A0B9;
	Sun, 15 Mar 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2xNnlg5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53675189B84
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575118; cv=none; b=Tc1V9Ss3iOxsMy+ub1eqP3LV/QBB4DR816Q6nit2UVx4j9ob41i55tpIGXXFPpVJAjZKkw+Nvo7cWNsx9AlL1FNwL/iULHIoeoJcb9cmHsSCS+IlQ3UoRqaqp/uPS7EH78NXsxVJP0ISG4h606QZax4eEwu6e5QfEQ9IARwc8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575118; c=relaxed/simple;
	bh=ekePeo7xFC4JcJRPKdRTzFotIT38WWC5cJ1Esdr9dfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AZuihEyy6ul60zcEMT7OITsXZOt+bLbGztjgrdhBtw6wmIkK8rx5cxrpH4Z07llMcG+O109W9mLHjU6ZIZXMC7i46wvvhwnOKxuobPuasxNnHXhTNVqxBN4sOLV8TmFguLEHXvjPDeGV/89OLOfz8s8fTUwyFt6NiBks1BQaORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2xNnlg5; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a0ece9f14so45902876d6.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773575116; x=1774179916; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6uDVHudfcd1lMVGOAwbARh4Bs+Hb4RWQ4xLnldj9Zw0=;
        b=O2xNnlg5i/SUl6LOrcYsfVoBQr9+SLht2lg5DB2B2Zwv4725H2ZjyGsU2PaKu595ef
         PYl+Rf8GmgM+qoOlhUECTFZQRB36YNC2YWnIodCJNfuCdAng+CagrMEpiMQutwHCd8FH
         t/p93Wqfg1PTH8YifIDHPF4MZJswU2vyrv5dSbwgEzEAKDkAIPfJ8cZ8xDHgurE8mb2L
         OKbv95HEEZMrLPnL5EbbFKDP61Nka30uZH4trHuRtl2pG5m1lb1uSSyXiG2e9jPGngIw
         6+WxRGn/ZghpeNKbJOdBjFtCNoVREik32aAkF70GT2KZlCRpblMqY3YNOCqbknb/ACR3
         4U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773575116; x=1774179916;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uDVHudfcd1lMVGOAwbARh4Bs+Hb4RWQ4xLnldj9Zw0=;
        b=i1pu24nkkhVJyj5w7mCv88rULagU5Y1ReWPeFKscHk6N2BEfKmVBZ9K8/0PkqQDpQN
         yB4v4dnH750ql/iVj8r8yPembEvvmRhDsh3t12pcvMkO39jo9idgXC2yPmcqw8Ay+zz8
         IWhK+YpsAKtVPQ4ucUXIo5ArRNnI54G1PBslztQkDeHr8v/OifcXQezX5TGStx3G5ksw
         +4/V3br/lwRjTzBZr9oLEIjzcn5i87ZpQ/Ob8wZQ+EpELm2V/d+9t2hmKE7x3pVSF7O9
         qTbmf/RThvbvwdyZ+gaikiCBkmSulYczMl687Rp3Ty8yppGUp7VrE3ivQ45ISSOYIfjy
         zfrw==
X-Gm-Message-State: AOJu0Yzmt5KY8hY+I6a+mN7zipcvsCp4La51cI3R+QcxzIR71py8HBR1
	MypF2PnMz8c593U4Yy6ldp7grOczf1kxIUMFkMG7ULc+jh7buO6KplR5
X-Gm-Gg: ATEYQzyONOX7yN8AUsmDYIpsdzf1AJ+knosZqVrt5fndj0rJTTDpgQLnOa+w1T5ASfx
	KcSWV/7EbQ99dYTTRXFFznMqognciQSjZa7UX3Lgq4yrADT8CievsgQXx+uG7jqsPHE7HnvAlo8
	InKv210ZEwHIkDtpJ0AdN8Y03DHzBCp2MTaOm45eBwRR5VM9/HY2BnFPb9imEKdrLZAaoh+1qhF
	E1A/01peroDSUZNPSYmoxp2fA8ytvD6LrH7wDoF2eSKW1jYbskUk8MF/4UxFQoFatAt+eek5JBz
	N0W8eh4SH3R7bOinLOEBXU2MVad6G108ZrrIpLwEPPyFBrw2fPokhdsKYjq/lVzRpJrqdHRbZxW
	ANmfPbI5Abwsm05ZEUTOfCWCKaHZz+UU2yRfcD9BPH8wPS5757aHo5aV5KvDqKnUkWmZxEDzrY0
	Ud2yQhAB2tRSWcSt38i9AsW8qoRon8N9LgzTVHA21e5Kg=
X-Received: by 2002:a05:6214:509b:b0:89a:b0c:7268 with SMTP id 6a1803df08f44-89a8201b511mr126210196d6.54.1773575116135;
        Sun, 15 Mar 2026 04:45:16 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65ce339dsm98261896d6.26.2026.03.15.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:45:15 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: macb: Fix two lock warnings when WOL is used
Date: Sun, 15 Mar 2026 19:44:26 +0800
Message-Id: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqbtmkC/x2MSwqAIBQAryJvneAHwrpKtPDzqrfISiMC8e5Js
 xsYpkDGRJhhZAUSPpTpiE1kx8BvNq7IKTQHJVQvtJR8t95xShfXgzNWN1ww0PIz4ULvv5og4g1
 zrR+DcvpiXwAAAA==
X-Change-ID: 20260311-macb-irq-39b8a3333bd8
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, Kevin Hao <haokexin@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,microchip.com:email,tuxon.dev:email]
X-Rspamd-Queue-Id: 706A52908B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch series addresses two lock warnings that occur when using WOL as a
wakeup source on my AMD ZynqMP board.

---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: Harini Katakam <harini.katakam@amd.com>

---
Kevin Hao (2):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::in_ptr with RCU lock

 drivers/net/ethernet/cadence/macb_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)
---
base-commit: 6ba8fb373522ad9ee3e828c8e77d8bd1acf3dc33
change-id: 20260311-macb-irq-39b8a3333bd8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


