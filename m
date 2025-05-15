Return-Path: <netdev+bounces-190691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2029AB849E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542ED1BC1D4A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BDA298C2F;
	Thu, 15 May 2025 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gYXOFKNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB202989BA
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307676; cv=none; b=b/dKX2+16QbUtcmnoZlmysfC3FgGCtIoS7ck9H09NMeepui0yBQQyDA1+HBezk5+tZa2witPbCmYOO6mqkMDzGWVtF8e23ktE8zS7nzlvcaK/hLAb5+Tndjo7A+PiGkkIPEjoEM7QeDsBhJBgSgdn99ZmcBem2yKCk97ODz/yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307676; c=relaxed/simple;
	bh=zoFd6yM2jO4l5buq2BxdCOcGr33b+h3WWROBWfiOUHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gihapu1FGcy2CmD+f3QlTsAc+voqwYjLRWQtbpZNHP+g1Zmi4stc4A6syZgQzEHN5xID9tj7+Ib0/HoLsOwgdmiUGW3HUVLhBWRoX7cmFY+Az3riSGt3VQY/rwM4+GAl7amKZDaOccMhyVCi+BI+zTNaE64cOyv5SDu3iqAfQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gYXOFKNm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso7574245e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307672; x=1747912472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPGy+GjHeYV+uwN6tyXbPz06AQDovozMZ+Px2Wp1mjQ=;
        b=gYXOFKNmfal9p05gUr7MKGd4Kc8H2THiYjreOzUnWKsxvwyad399USbQQTJeBn2D6t
         miakzZD0O02ofZeM58GKa++8gAnGKjImNBi1OG7bY/o6BwBPiGwEUAYWUOLv1wCLr6F9
         SoCNLHBr22qJHTmg/cKhaJ0ghs+8lhoV4KZwpguQG/YDYQCq2hLvZrWt3LmqIPXk5eG8
         8NVzf0ecfVlQGfqo5X3ovSYPBqV8j66Nn34h5hm0qbDWIZ/CYcsheLk8iI/3JMjqPndB
         oHUSPuGGNyVKHUyJC2bhcputFKlMx0TzV8x3KYfI1JAJe636LHkU48LLx4cFor5jc/Fy
         gn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307672; x=1747912472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPGy+GjHeYV+uwN6tyXbPz06AQDovozMZ+Px2Wp1mjQ=;
        b=wLv41c5HboAK01UyIaUSaOjFu6xVqNT4yXvVY270DNJkxQMBLWTPUWqAMrr0Brqxg6
         VuUKz60CFbIbaf0AxXguWjSZUnDrXx/9jTOj1zQ3JVaIV0MwS3HN43uYDseUc83wOe0z
         idokcApvPLgHPgWF3Q4FgVVo6b0KUNNHb/x3l+vSnTH/AwbDDZrjqTCrRk++c1oHuWnE
         RQtb1bsbeDYBZtTrAXKIE2mM97gTOq7UgQAqJebnkPRp+ueiBcoYrnTwA4LxMGC6P3xB
         R9BNaIPW49BK7F413vl66RgJiBSwBOG2MYWydgkrV81j3cASCHiReCyew5YQlfDvwIQY
         eiHg==
X-Gm-Message-State: AOJu0YxpXWSNuU43C3lGT5xHrX/VIrckXFkYNxd2ejVncwE6+HxUdwWb
	fW/9AcirefMBxU5krFIiEeaMmuTUoKQusCS8oQgYyiNVzL8roYDTdkpgK4O0KeIresg1OihMVIb
	o6Ezcqlm9GCvBrk8FefwYf057t0u9tGuuk1BBfXk5vaC5zWKO580/JzU2C6iu
X-Gm-Gg: ASbGncuSFnM6hTkJAJvesQQCaCzU3TD5+SjfA7zBw9G3Vk9+zc8Tx9nG3FwfQ3w5LVr
	kcrTHw/s/Tziet6xpz8V+bHZ9LM7evWp10eXBBaWF5YCul1cjKahsn6WiIEnehgqCpYOWRsZD6Z
	4V04DRTY0FnAEmicmm7NToTXX8BeW9xyujRlFTnER2p83PSgmEYotqPLRgCipe1PStzV/lfrMp1
	oALNZ0Q5J40STfDzU/2gHyjcWMVzDJYkwZZokO9VfX2LQgOmat1mIui6hvfsJa1HRSSgknrxjoo
	5uhVKoh/8zkPaxkbWe+ODp8l3DiTod4FRoKMuwq7sy0gSqV88Xo65Q7Cgx+NfM72bkOEjiqnjtY
	=
X-Google-Smtp-Source: AGHT+IE+x39KILGGktrk896qf0+d3nxcdk1EyB25AIC+pY777ASs2QrI5loXDoBXnqbtFajXnU3taQ==
X-Received: by 2002:a05:600c:1da9:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-442f971a7c1mr18641515e9.33.1747307672254;
        Thu, 15 May 2025 04:14:32 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 08/10] ovpn: drop useless reg_state check in keepalive worker
Date: Thu, 15 May 2025 13:13:53 +0200
Message-ID: <20250515111355.15327-9-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The keepalive worker is cancelled before calling
unregister_netdevice_queue(), therefore it will never
hit a situation where the reg_state can be different
than NETDEV_REGISTERED.

For this reason, checking reg_state is useless and the
condition can be removed.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index a37f89fffb02..24eb9d81429e 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1353,8 +1353,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 	}
 
 	/* prevent rearming if the interface is being destroyed */
-	if (next_run > 0 &&
-	    READ_ONCE(ovpn->dev->reg_state) == NETREG_REGISTERED) {
+	if (next_run > 0) {
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
 			   next_run, now, next_run - now);
-- 
2.49.0


