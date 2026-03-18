Return-Path: <netdev+bounces-268889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBj7ITtIumkFTwIAu9opvQ
	(envelope-from <netdev+bounces-268889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:37:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E12B67DB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A9A3304C2D3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB516367F2C;
	Wed, 18 Mar 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy4a4+qh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68C25C80E
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815855; cv=none; b=SbfoISM7G2/ihEs9iVCVQCpPhK6hHjOKDjD30v7za7AU62PP6ec4ovWEZYfJEsNjaG1Yr2j1gucc445Q8qevGm3CLw3U+kmxeZfvo0v40xU9NKUBsz7PEPxqxFng9GwYHLaPxFWn8qG86bVfEdAm+DosteE0P4O+VHAq8birO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815855; c=relaxed/simple;
	bh=4O3QCGLvuxp8TyNV8Xtul/S4j8KUMp0uGU1+uJd2FNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qEbIOck+suFYvMruTjZAwh2v/iKDImvGxBtL2qqHPXML/vuaXNux2mza7sd4zY2OEkKNqw1u5aOISh1r9k1YB1PghA3xb7pTLvvhSWaxSmH1Sp7lmXMOgHsRw38mQeLK/g5MfgcjRLsiXpaUvFuHBzZVfZmcDaOt00fQDWN8S40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy4a4+qh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50917e02532so78399881cf.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773815853; x=1774420653; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJIZ4oOL9g078MWbi96VubW95O3IIVBMwuixA0Lt16A=;
        b=Dy4a4+qhPSLMXf5HJ/18hZxtqo+cXxTnxOs/lnFJTAZWLsozkxhHSDvzP2ig6OjvOs
         tgWEGI8IBY2WSkvVV0bNe88oZhFTxOtwd4GkMGvwC9QmWUSahyN6UKO39BVKOnugcQjT
         NgBqgX+2fnAZIoDOsIrk66iZVFdOXNcM6YpZo/FKMqXFXCA0U30zrexZTQykVLuXt02t
         E+H0reQqlVxE5Iw8LZ1ruN4OGVB/cneNdAEGitfVLQjPHsyK/u2PhApOzDk63S8Nd4Vs
         jIJ5yGdUZV0v5pdC4i/94K3I3ODi0mm3WfF/u2MxUUTi0s1S+chy5hjk9ejFvxR3eYny
         PtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815853; x=1774420653;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJIZ4oOL9g078MWbi96VubW95O3IIVBMwuixA0Lt16A=;
        b=cgoaEFeT+SBhZSaLaRxbY3+4FRfj6iE61IpKSM3So51SZhrEHxcBrNnyQlbTXY0EYv
         gieZN29d084gjk2K1vqTLWCs8f5e8KddBST+DOkw2tkgNFdIDJ7fk5YMj1mlQ8jHNjL4
         ShTkrvQ8xFiKTvnmUFXAxLoFsdO157Rn4vUCMhlPYuLDhY+j7UxDKXtZyJzwNhtQSbnc
         oqY25LG15oolJD9k1gniUBNMe3ZP1b4EqeYchdneVb6yqFEpFEFbuNmY4YM98glawJmy
         CeIW8/GxvQEJtRWs6PSBs2WVwMgNL0ttkn3AFrrXVuqIFtzyvmeNSwcEncXZc8+jCxKA
         MkTg==
X-Gm-Message-State: AOJu0Yy9lHtO1yhfKNcLbv7tDXHj36jCop5LrwOS89d8Y5XmuhBoLtFp
	L9hEbQ5jtmOGsT8WDyoFHUpxvR19MGm5Vjo37/RujKhv+Fai1a4Q2fjp
X-Gm-Gg: ATEYQzx3FDtb2HlD8WjgXqrJ78b8Y+iy+dcF3NN/BqNMtR652mJG5TaFBmYx8SyUJb4
	ysgS7PfRUdF6qnIrUPUAH8WAtSMclIbfuXuYzu3a2Emb4i2feMy1NQE+AYtmw79gbA48kFwhZ/W
	kf8JbenYeG+NGQJtSSkUjbbAKweJgowB4SmtoFoV5ydJibes+NgbBQyUaKN+/VIm7ebG79RAbDQ
	HLqtYPka7HIrv42rZMuWNjrbEE6O0Nqbf1E4HnN8EzEXN70TDUuPbeuXtfpXPx75BFS/u9LIpZv
	5nRItad5irf+vqULoDWHTKVAEhuBirkNSu7mRznqsqyd8UqnhbbqdZtUhIkIIoiGJ6McU0nOxF2
	xYCtIYEFl3kbL6kOMfVswWd+y6mhZBX1s8a2kqJkG6Z3Ag5emVB1KHIG67d/ywTDbPsWgyZXJNM
	P20cmYnNc/mo3kO36eiVBx9Jx9aOWHVYxd
X-Received: by 2002:ac8:57c3:0:b0:506:9bea:3229 with SMTP id d75a77b69052e-50b148bc32amr26455801cf.69.1773815853203;
        Tue, 17 Mar 2026 23:37:33 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b135b875esm15235351cf.25.2026.03.17.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:37:32 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net v2 0/2] net: macb: Fix two lock warnings when WOL is
 used
Date: Wed, 18 Mar 2026 14:36:57 +0800
Message-Id: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAlIumkC/0WMQQrDIBRErxL+uha/JiHtqvcoWagxyYcaWw3SE
 rx7RQqd3ZsZ3gHRBrIRrs0BwSaK5LcC4tSAWdW2WEZTYRBc9FwiMqeMZhReTF70oGSJngYo92e
 wM72r6g6b3WEs5Upx9+FT9Qnr9DN1f1NCxhnHrkXeGj33eFucosfZeAdjzvkLK+TWcaUAAAA=
X-Change-ID: 20260311-macb-irq-39b8a3333bd8
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,bootlin.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,microchip.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,tuxon.dev:email]
X-Rspamd-Queue-Id: F24E12B67DB
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
Cc: Théo Lebrun <theo.lebrun@bootlin.com>

---
Changes in v2:

- Add Reviewed-by from Théo Lebrun for patch 1

- Reduce the scope of the RCU lock by using a local variable, as suggested by Théo Lebrun.

- Fix minor typos in the patch 2 subject and commit log

- Link to v1: https://lore.kernel.org/r/20260315-macb-irq-v1-0-0154104cbf61@gmail.com

---
Kevin Hao (2):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::ip_ptr with RCU lock

 drivers/net/ethernet/cadence/macb_main.c | 37 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 14 deletions(-)
---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260311-macb-irq-39b8a3333bd8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


