Return-Path: <netdev+bounces-190689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B24AB849C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C2E4A774E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DA298989;
	Thu, 15 May 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MTwuELyy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55164298268
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307675; cv=none; b=ie14fSgMMizCvXVovbXLD2PFz8Jmz6Nn8Fiu+8fjkDcs14ilhGyTKygQqkisLdxBKqC+cRuHa3C9BefRC0620R/m6gaJtSx4jp10p6T+82aBa7YSrXb+/S7eTGdjkCCU0zzIQkC5N3jS/SiWab0WjyY+1DNsu98RtsGTAKArcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307675; c=relaxed/simple;
	bh=PCBLj5/vghBWe1oxYE5nkmdHeaU+Jd+D+Nm4NbFFeMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WN6IvUAqQjHYux/NB73v8CF8YVknTgIdwHCbPAEDc3kWKVUK4EgGEPonwUukbkCilkU9dvhkjO8W4BwVqVJiDxMkX7tdy63tLL/6GEYqtcEyP0vac+esLmvy0SHpRTVznoBLFskGyf78kDFGWuasR5iramCPuWHa20ZUcLyasIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MTwuELyy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d0618746bso6196555e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307670; x=1747912470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr1egVLFounoOrksGtPh/tmI8fjS1xTz8jiRmOOc3MM=;
        b=MTwuELyybr01rz0kJeJ4zzq3XyFe8c4vevzI8fS9cTB618gAZ+JLwYSbb6oa6JmAJI
         cWRg1DPiFAWIp99Dimcqly1JjoyU9QPoGBkaG1ijzDA6N7jPmVsAU18xqKYoth7oaXyH
         QJq9jR1wByPfqu7oaAFf/uv+hUfBeXwWPO0qp8U5I4bMy9jGVBnWk7PkjGxj3urDptk8
         QDjF0inldQVSWp6aTqOy2h3IHgDwgeLd7CDiu4YU+eCuwwq66zsTJTzDnws/xZoxHngh
         K0RFGkAkGLqYQwJMcAoHagSOVZN329o3CpGyMXmaim6YgtOSdLLJ2XlIBbRklQMci8E2
         Fe3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307670; x=1747912470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jr1egVLFounoOrksGtPh/tmI8fjS1xTz8jiRmOOc3MM=;
        b=Q407iVfiiNqMvLRpwdOC3cWKpmm99ycnwEcl/8bgZGgUUtEC8ydhwB/2T+No32uHoj
         2uJSkwJY4kQ0JQtPazwdKc1DR9lCgsRTkTjOzWIo56rbhx501H/nxZgEilY2syxUej4K
         lVfScPaHOkEiTGGNiTuFr/lrgiHKGoX1Fl/uqsHF1nmclT9l20grBYAI/XdBrP2Fq8rK
         bmqAHdizwroesxwvasee2OrQyBFCdcpV7BUEO0MESrmyB8W/eTOiJTZz7rmOqOuXbsme
         /hwC8VG29JRf2C0vz8o4RAi5V0841sOHToZZOGLetYn+idbG4uY5RkAUD22myMjVN9xg
         bBGw==
X-Gm-Message-State: AOJu0YxsSud+AvyS13Amv+tw/aIv/68hvS1js04y9ogxXi/V33VS2mcM
	p0DEP92S0M74wVL8txib0xuSQqYqFaIWPCL0grx3UuTkK+4/3zFKO+L+BgqBzr/7Pvbn+8aImJi
	1RhhDizsPMDkpXUzQuEGXHQpybBL6xCNfmUXq8nbur3lZoE7y98sN0d6EX3cD
X-Gm-Gg: ASbGncurfFc4teAFW++D1H6F6boc2i5Fhb7uGOGMIZaPN2+er/hq94WkjKvirZ8iN8U
	arlKFTcLjO3/IQxc7y0/MEDyPFBoaQL7OVfu6udJwXuOJ8fku8qYGynTj74gik1Zhj58nKL7C9J
	9o9fNLGPrdY7jMgP3x7WosEGffu4Sl1oMqQH/VGjXPCSpXtN68EyuyTNRw0AGTspTyFKpEbJARl
	QRic0WtM7lz/unE2PBRnE4GUsrw0kOG6W09knEjEIYInEI2J/9LBKRgOT9dkisE7ck1lNvltWrO
	s+uH3BtD2PZayCf2Oz6jMxfcOFKyZ+pm9v4UrLr6LQRPNaDoQBVoxBBxVNxV7NEQdvobfwMF85Y
	=
X-Google-Smtp-Source: AGHT+IFZtrY5BLOQf1VYMCDLJ3hoWKFjQZ1EdF9emAYGOg0afYcOu1olnSOFQqnZtIZU7a/FequNKg==
X-Received: by 2002:a05:600c:4e4f:b0:43d:94:cfe6 with SMTP id 5b1f17b1804b1-442f96ece5cmr22508135e9.16.1747307670343;
        Thu, 15 May 2025 04:14:30 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 06/10] ovpn: fix ndo_start_xmit return value on error
Date: Thu, 15 May 2025 13:13:51 +0200
Message-ID: <20250515111355.15327-7-antonio@openvpn.net>
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

ndo_start_xmit is basically expected to always return NETDEV_TX_OK.
However, in case of error, it was currently returning NET_XMIT_DROP,
which is not a valid netdev_tx_t return value, leading to
misinterpretation.

Change ndo_start_xmit to always return NETDEV_TX_OK to signal back
to the caller that the packet was handled (even if dropped).

Effects of this bug can be seen when sending IPv6 packets having
no peer to forward them to:

  $ ip netns exec ovpn-server oping -c20 fd00:abcd:220:201::1
  PING fd00:abcd:220:201::1 (fd00:abcd:220:201::1) 56 bytes of data.00:abcd:220:201 :1
  ping_send failed: No buffer space available
  ping_sendto: No buffer space available
  ping_send failed: No buffer space available
  ping_sendto: No buffer space available
  ...

Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/management routines")
Reported-by: Gert Doering <gert@greenie.muc.de>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/5
Tested-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Gert Doering <gert@greenie.muc.de>
Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31591.html
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 7e4b89484c9d..43f428ac112e 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -410,7 +410,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_dstats_tx_dropped(ovpn->dev);
 	skb_tx_error(skb);
 	kfree_skb_list(skb);
-	return NET_XMIT_DROP;
+	return NETDEV_TX_OK;
 }
 
 /**
-- 
2.49.0


