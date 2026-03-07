Return-Path: <netdev+bounces-265032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uANGOsyYq2mzegEAu9opvQ
	(envelope-from <netdev+bounces-265032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:17:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134CA229CEC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B45263023168
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FE72F6904;
	Sat,  7 Mar 2026 03:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfihkT+e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509A27E06C
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772853449; cv=none; b=OMQO9uPHmb1O4u1WiB9V72jX6CR9YMCTcu0B2k3ijh4EaBV8RaLhLmupsy2ZEIICqTjZg1uafni/J4cAiARe8BexaQ29m+LAxwp9D0J84Eetq34pNmY4zx6xNgzY9fV26oJzJraXNQhfiWCaTQs5q4f3vVXKWSGEbRe9OJtYhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772853449; c=relaxed/simple;
	bh=UYb3xSmHRKqGAgoxfnF+Iup9HgHsTfD0s/jrcmNWumo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqiu10HpO6jkPR7Zfs3QPo7+1bqFM3OmmsxGaLeNvgDbkd4lUq50KiSuN9qKWkN1pF0380HaxY2udpFeuQYkNI8N4GfqFjuq3jN6m/iE2qCqPeek6rXYpzBVPLPYPwu1yKupcEXKhYdd+n+mp/6BpJfcqooORini6a5O0rdVNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfihkT+e; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82985f42664so1577594b3a.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 19:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772853447; x=1773458247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+nlGD3d1zfxFFLnu2zrOtcZTWJSFh3QG728/Xxkrnk=;
        b=gfihkT+eJTH49sgE2tQ/Gn+/CGZZrWs43yQhPrQAkIKisQB6Gl4ZMfCiScq9AD5i7t
         4sKZVKGZ3V739zXPq95kYV9ypFssJPoYu7OIfBKQpaeDBtRMqCs8pCw8DR2dFKfNK96b
         Fv2FYIqWMrntaH5WMKaz6aJwfgpeq4+81JqAVN7ZWDL005fiiWFovxshvujv2n1wLPkQ
         JRfYbfqAv5gWi1EVJlSkJi9RSrWxf/FIjLpTYV1TAPtPdnG/1yM0wYFEw07GQQ8WRx3r
         MKEq7GjgqH0D6A2rM/SDDw0SwMA+cpn38ka/JfwbxLdT45pX2zbKFU+V7p4SxkTRfNiC
         /MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772853447; x=1773458247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+nlGD3d1zfxFFLnu2zrOtcZTWJSFh3QG728/Xxkrnk=;
        b=dBZtE0m7gANAXop/WLAdg4Vn7W3V9dMBg1Ar7iblngCG12wtcnDBz3aeXmaVSY8zFP
         S46vbvZwgw120fsTCxBCQROnnuDOaf+yFibxeftL062IYowIZcmXuRiHXnRA9DMQB7LF
         neuD+Kbjyb3xuOZsKznlyLqivgC5686UOL9hRN4im7z1GpJ2xyDargREMSgR7qAiEpPv
         sUcfCO9lPGtNEqh1CsFl4cFcpPjgFiPa3xbQKhueSTo0fKBSC0n+QWQiQbAOQys8dvEI
         ilFM67USnp0eXOO8JdqagfuF2Oi9r40N94jvqDoj5GYlhcXqT7pbeDYpAYkUUQfu7F8U
         jfqQ==
X-Gm-Message-State: AOJu0Yyy4nysv8/3CAI+zmBMCe+gk7alLZEzROi9v6AY+xNErmY8GXsC
	iME8g8WLi+Ip6Shuyga/zuWN8M3KXFeFPrIizVLpMwsVmrrYUemZ+ncltHCzKRaiM6A=
X-Gm-Gg: ATEYQzySTzYJJe8MPnWiehKYsrmbIGnVIKEcYo2KiF8slPjKUEz+J5dpUIDKZo8zWvh
	KNS9ab/SMBjk4m6GdXNKkTZX1W6J0ev3RJa86BuN2s3BvQEBOmKDuub+T6ppqQWuG5MnQLzeRGm
	/Ag36LcWNy1XoF59bLDgCfc3demUM1WTPlKQ5XfJH8kagMuBBfhJLnHouMG3p0WZp1Rr3lvTM9v
	B8xubH7zuV+Y0KKVGkqkeaPLee2qzx7bsvXllRxLbIsyNnEavtCmwK6m5eW+b+T+I4iznArSEHF
	Kl6hZgrRd+k/6ucXuE0sIXHza1Au/lJNdky2RPfD93tyetpza9SIwKkeK4GzDxv7kt7LD5rD1ns
	QIuBYHPTNiYjqGL/xO4IDNZEDseLHOPM3oFlbBT0z+Asrd3+8Scn5aei4OEmySIBCf0iChddIK6
	P8ILwe/IbTfLEZpI6KKo3efQ99Un4QrUoHfcnJVQ3HBVzeyyZrkq2yQlI=
X-Received: by 2002:a05:6a00:3c8a:b0:822:1dbc:e75d with SMTP id d2e1a72fcca58-829a2d65577mr4040105b3a.1.1772853447109;
        Fri, 06 Mar 2026 19:17:27 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d372esm3214165b3a.61.2026.03.06.19.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 19:17:26 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: mvneta: support EPROBE_DEFER when reading MAC address
Date: Fri,  6 Mar 2026 19:17:09 -0800
Message-ID: <20260307031709.640141-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 134CA229CEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265032-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

If nvmem loads after the ethernet driver, mac address assignments will
not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
case so we need to handle that to avoid eth_hw_addr_random.

Add extra goto section to just free stats as they are allocated right
above.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: free stats on probe defer.
 drivers/net/ethernet/marvell/mvneta.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d627858d2802..5bdf5020ec69 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5620,6 +5620,8 @@ static int mvneta_probe(struct platform_device *pdev)
 	}

 	err = of_get_ethdev_address(dn, dev);
+	if (err == -EPROBE_DEFER)
+		goto err_free_stats;
 	if (!err) {
 		mac_from = "device tree";
 	} else {
@@ -5755,6 +5757,7 @@ static int mvneta_probe(struct platform_device *pdev)
 				       1 << pp->id);
 		mvneta_bm_put(pp->bm_priv);
 	}
+err_free_stats:
 	free_percpu(pp->stats);
 err_free_ports:
 	free_percpu(pp->ports);
--
2.53.0


