Return-Path: <netdev+bounces-290954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IX9OKfnEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:32:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C785BB853
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F3153008502
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79FC376BD0;
	Fri, 22 May 2026 23:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW8AsF5h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263F357CFB
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492771; cv=none; b=fzdcNT+tvo2F5qo+Z16T33bZayQCDloA5YOPXX3JmZEsgZ9NUPYvgWfxmGDvYpnwa8l8PkY86zxu7xIwBnKRhauqSdVdxziWTYSvSbT/tUNnTVaOEWdCs5g39bCaW0Yyf4jussRZMabZdt33EjVdoFpJHrARmXJWUnNCNlCQzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492771; c=relaxed/simple;
	bh=RhWk27no261zgrPb2qaAzrbxOAl+m90ohq+kZl11ZSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sA4nTeC81sqMaCuu+WUfRn4fc3Nvdap5HmR1HRVZYUXtnWwyPePkIoKd3Fttla8rZ7SEPkEE5TKid941nqeiT6gI5xZwnqWAi14SpWgxCMJgkn8J3p2LiZAcahYkR2GtbVH2X1oXwrT2Dwqhyb+G1c67gKjfVy4v+nLX1vN6oqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rW8AsF5h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-835c98b659eso6694034b3a.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779492770; x=1780097570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adQgf6FXrvyMq9qi8wtHfF6qENbe2mC1D7JJ4mg4sqY=;
        b=rW8AsF5hkA9IptU+8pDUHrnsEKu72XcJwPQuFqlJhRboF1LrXF5/8CmHS1WNXzkRTX
         xmBdskIAK4hyDjzHBkhsEQAYhkPZc8Rey0BmrIo7pneQe353SgD5jsvPsZCU835H41hz
         u69mUfeNak/mzsLj6kTiFADxFnDwIZfkHNG4FoDZhgIA5Jlllddq2UamZtRHfn7f47xw
         7Fipqb21Hs9RdXTl/hSXwYZMM1wSoyagT8hqT8xwNKjVAxd/mlanOx/B8eIjW6Ciyui+
         pP/wm8CiHhB9PsIzK2K3CPWOTziId12wZ/fI0Q8yBjxLdhoChpPmiZbpTgVW6i3MARqP
         nAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492770; x=1780097570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adQgf6FXrvyMq9qi8wtHfF6qENbe2mC1D7JJ4mg4sqY=;
        b=sDgdzM5F156hHpZwWMMjt6CgNFxNmAM4n3IR8nsNNS3zeIGnuJ/A+odQhY+5WFTl6L
         FIDltq+f7bk8ogZ/cQuAhoEuXze5MKLOhnBpEmL3ZGs+WBQNraoifA5Za39kXMcrWi58
         FMrZxCqza+xUFFwnx/RYZeaTAZUuleqOYtUfO9XHzc4cXK4AYpeyYPdgRNqvqWHJPAyF
         jE3Dfx7Wf7ZQgD+TXh9fBzn6oTwpIvtMN+4ZMbD87Y8M0lIChH5hqXl5tGy3t6Pi4aaz
         JlFHDM3aYnmWnPHqXyHtrDT4xNK5zozknNw3+Ki6Gg6okIrOfyeaaQeMZ/dqScmporSX
         4Q0w==
X-Gm-Message-State: AOJu0YzBeNbVwcmVJN6z73pJBvXqMk0KR/kHqg5yI+tk6Cq70kwJOElO
	z9c3Xs5l4MswyfrP7WK7JbhyppFwoqdxBswjIRGiopEXxyMvzbQOxBi+9hnEhN1/
X-Gm-Gg: Acq92OFwxkq2kn5NV1C+8qJU9JcUs9wW9khX1wxFx7AnZOh9IvCbGKDBs5u/7Jf+LrX
	T1ASBV85nvqthTUwPWezWbpy6gTFo/Ljy2kIgetyWoscc+SRUcTiwbGjhIhuVWfnZSujho/I7fY
	dRdp/dBCgdJHP588Oi/BHwl1ybZUEky6ooAMfI7E+7lydrno49fwctBDRbzTvEiSFbc3sBYtVUC
	DXPoMej0PrFw4zz/JJT4RtlYkv7NYWNGeNit86V3L2GNzoKMMEbIl0LuPG7rF0WliV1UfF6fC2W
	9RU5Zd7XHFcEujWh3YmozGSZW0CCAmaWqFTxV+PEjdDLeLnM4vZpt9PzawhROADbKaDHR9tpCTM
	Z3HCPkp8ADe2E45joHNAhhJ8sfnsFahQvv0EOWQX1/EVQhAaS5sXKmD+nAG5ViU/q294Tqdb0Jw
	4G8t/y+5ag1EoGN4lmaZJ2egueNafQDyMi5qkSOTOrl2FJiWxj7A3xuDApqvb6QBSuPIBMuIVF4
	yAGMsygwZuLSQhTR/+sEvVpGJ7yidk0s4A=
X-Received: by 2002:a05:6a00:e8e:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-8415f36c1dbmr5156455b3a.34.1779492769798;
        Fri, 22 May 2026 16:32:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fc6e8esm2831148b3a.47.2026.05.22.16.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:32:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: fec_mpc52xx_phy: Add missing MODULE_DESCRIPTION()
Date: Fri, 22 May 2026 16:32:31 -0700
Message-ID: <20260522233231.45609-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290954-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 61C785BB853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes error during modpost:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/fec_mpc52xx_phy.o

Assisted-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index d48a1c4d0431..fcead59b0c96 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -150,4 +150,5 @@ struct platform_driver mpc52xx_fec_mdio_driver = {
 /* let fec driver call it, since this has to be registered before it */
 EXPORT_SYMBOL_GPL(mpc52xx_fec_mdio_driver);
 
+MODULE_DESCRIPTION("MPC52xx FEC MDIO driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.54.0


