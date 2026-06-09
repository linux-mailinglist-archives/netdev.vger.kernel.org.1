Return-Path: <netdev+bounces-296932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2osInu+J2rF1QIAu9opvQ
	(envelope-from <netdev+bounces-296932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:19:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EF65D1F8
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:19:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y+Ne68ze;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296932-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296932-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C216130CDA3F
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2C33AD91;
	Tue,  9 Jun 2026 07:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141252D97BB
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:16:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989366; cv=none; b=T9b6j+sOHJWxOKUEy5NCucuR2ATqP116ENS+ZVpFyqXSYjaT/4g07jBKQs2pMXbB64dEox9Lpmjn2GUuR7RfTGrMBNpzTJpx7593gwB+JdK7nNh+t593gpDMCW1AbYXgQROYFIgsbthSpt7Ru0B2TQru8C2iylDkke6aws6PYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989366; c=relaxed/simple;
	bh=hh8plpyDLmp7qYUu71tv3I6n+HRBSPfE+afzPnmPQiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcKTKKs5EMiloPuKKXFxyfdjdFZLItLxgd2mXJdK4YLsmuHMDZPuZigMx3hxVLz8yDmUdoK8XvoJblyxi9mX1gzqy9HHnU8oV+lqeiOq6s415A68SGhK/vvmZGzRlfrD9VM4kMMc1NumaaaxyD5PNFcFeLQprBki/7z3IGl9rfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+Ne68ze; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-372b4330deeso1533741a91.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780989364; x=1781594164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+WMj06VweuHxnnE2/mbYxrsGIb7CGFY2jdVSiz7USM=;
        b=Y+Ne68zeZu6b3jU4TF2p0IPS0aG+wg8ZFMfWS7/3HIoDgev5xmm5TN0mp5pR+WAO3X
         dNY6YiTfgrVIyWZpefkDUb1L8IioQoPwobHfUxF9I1UecXg3MKYVb8JEUUsxcj9tqJkl
         XgH9rWrddDnFhNdS9HsFYKkFlhFkpIab+4fNKZu5C6GjF1NJ7dQPjnvVYDDWEXP2aKXg
         /GYLawvL4PiIOkX/A+RZ24AU4BYfcV78+6OzkXF5+iNx48tWEW8ufEXPQiuPonYlOGgb
         RTP7q2LXyIalJnNm5MjtBcac/km0rzsfLMK28tpeoTzFEDfOGk6vh57Kr+nnkplkYcfx
         YJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989364; x=1781594164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+WMj06VweuHxnnE2/mbYxrsGIb7CGFY2jdVSiz7USM=;
        b=V6XSWIhuoSEL7L3sHdyKfL9HkhNgaqRwzoKL7M+rHMBBPGHrFy1NFnAYe9jhaTyxaq
         vk/5keKR2RRowQE6cdRgzKsPy41UWq3KaTb748W4md517DNhHNQrRtUdVgjs8gSw0Z+5
         oak4UMr7CR2rxADja2KLspam247VnMBQ2T2JxAxaURRDjMpGzzfQMm9R5a/BAqeHt9Oi
         EvuCLdfuMoxt8EMcEPJJHMsAKoutjb6e8zgigx5RSDbV2k2KK83KwfWAq6nQdhTBNwPb
         Sct4tVdsgBN3G2TTaLYJtwn7vAFTlBCmpI4u4Ge8ZloDLAM/l7DHn/BFDrpZ+pSWVYVe
         uWqA==
X-Forwarded-Encrypted: i=1; AFNElJ+AHv1BwA9ScGiWr8BrEZ/znkJsIWINXKkZtX9oqOJPGoICoQk55v+KMjB17hpbjbc1J/zKYsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5k8mRX+o9Y1obOm3KdWMhn2wjTC8GSISfzwn1ArdQ3TCCcwj
	87hnfQ7tSQon5ATe0zXxWdnkGRBv3hgTR2hepjAIE0Pf6JoDmZJbnZvk
X-Gm-Gg: Acq92OHBeyp067K+sUA4YNss7Jkp2Rer2HVm9g8/9kHlNvlZ0UPegfg4W4gcFvWI2yv
	NYqAWRlCcZaqOkFCAdeDfhn0vtkKHiqYw5/cwBmxqxky2WkG7Sk98VO1imTWySJJp2dipFIpgB0
	hPtzHUtla8tsc5ex9WkZRET0tmm/79FyP24EpJpMAIJTxjaHyJzRAAoTte9utYSBmzD2AMBQXyx
	iZvxX4MMWvUt281dTu+PA/fJZCcWDZSxUD7y0340K8ak/FX7sSSh5shntu5xAB6SqJ/8C5IlmVi
	jCI1ecwGR/1ayDw1ULeK2D0V8ZZ5hPxZpuwnP3+7hnZvaJOjYs4F4K7XSowDcs9kb1yJl5gY13e
	7dA8EAXPN3JPWWz3QYOf7RG0YtFcKtObDnw5deHUUGFXkb6eq1lh5TD1ddoL4IgXgSJrfltoYbu
	Zf6gWznUD6qo6O+59YZilmt6+ZDcQYCsWU/nQUfzs3RBjp7EUy8giWDg==
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id 98e67ed59e1d1-370eee03facmr18953062a91.8.1780989364319;
        Tue, 09 Jun 2026 00:16:04 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:37c9:44fa:729b:6aaa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d1fec5asm18109501a91.10.2026.06.09.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:16:03 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net v2] net: wwan: t7xx: check skb_clone in control TX
Date: Tue,  9 Jun 2026 15:15:56 +0800
Message-ID: <20260609071556.5-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296932-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:chandrashekar.devegowda@intel.com,m:haijun.liu@mediatek.com,m:ricardo.martinez@linux.intel.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027EF65D1F8

t7xx_port_ctrl_tx() clones each skb fragment before passing it to the
port transmit path. The clone is used immediately to set cloned->len, so
an skb_clone() failure results in a NULL pointer dereference.

Return -ENOMEM if skb_clone() fails.

Fixes: 36bd28c1cb0d ("wwan: core: Support slicing in port TX flow of WWAN subsystem")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Add Fixes tag.
- Return -ENOMEM consistently on skb_clone() failure.

 drivers/net/wwan/t7xx/t7xx_port_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 7fc569565..01844d067 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -106,6 +106,8 @@ static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
 
 	while (cur) {
 		cloned = skb_clone(cur, GFP_KERNEL);
+		if (!cloned)
+			return -ENOMEM;
 		cloned->len = skb_headlen(cur);
 		ret = t7xx_port_send_skb(port, cloned, 0, 0);
 		if (ret) {
-- 
2.51.0

