Return-Path: <netdev+bounces-157672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE2A0B2DD
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B0F188339C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610F23ED7B;
	Mon, 13 Jan 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ql5keZY+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737423A592
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760674; cv=none; b=S/Xjh+/3Zt03LhSpAjplhF4oSzMUDpBaJ8PoiyC7Cytcx+ZYGrpRaApF4UuroWy/XDvuN9SaT4OTvZi2cd3kyHa/ViQteu4j7hMGvrDWyl48Zden6fpXBuURsZEQyxemPIyp7ZM4yw6ZyIyMfL0SPg37WUkYYApEHTDprempoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760674; c=relaxed/simple;
	bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx2IDmrVJ/xqR23ZHpSTyiwXD89hRX2ErTZlaVKxg1cRZ26GMR+9zxCM+xqjyjUSdq6ifMsNXnU+OtVyH2tVG88AxGaerQKtwBZaOFkB/M1YBGifeCH7lwKaE3PvUcREpgpPj9majhBSEXibtKm3IssAIe7xlv41rRU3+9TiMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ql5keZY+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43618283d48so28507375e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760670; x=1737365470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=Ql5keZY+SzHcsFa8R1qjFe+TEQ4K0gweioMkxoOStsB2CipITF56Umt/fE0I74o+Ql
         d4iFy6a0JuwqjUENlK1JB2GBAqR7pRtx87ofanYYisilPPsNLcBk5MVia+INQkz2h0UY
         l1ibwX1KyRkWVkLBu24j9NoCK+aELziBct44CMPZt2YVjP30QP3dLGhd10Nt0rgsX6zg
         FXlXReXeQoc5CJhxFPaNOY0FdCe6q2PgU+HwxoKfELwKC2x7L4jkSz4F/utap58pyoXx
         Ifo/aqdhwIkCsHF3kngJRSNUQKTMYV/nmIBldOw0QE+KxSrAbjFQ53/tjXc4MWYxaj/i
         4Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760670; x=1737365470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=ImEe0CaqSY1CKfpeXmz3s/vaUsnOT/MaVPtSp95FZhqZVPvk7gIS7VCgQNrj35XJ7G
         R8ByM9h46Uve2hmxKQlxvPydoWYK0fRSg6thG1oQI0B7EcpM1uEo6cZ2Sfxq1fPkGazF
         NOR3ELfmYS/NDpEJDLWcw+fBBiGYCr0l+YZjZc5qTgFz/adDOZc0OJ7yFlOo5BXihQQF
         NIzDABK8hogNA4xSPN7e/i1Ae1DCfCw9CanA8Zq19WT+Sy8MazVqZovafRFY6QOPMu/U
         t6i3surUYNERPPmziJR5SyCTVOrmtY8qLbFGZl+d0wVDSIbzmT0xlfDnFgAh+FEZFVXM
         Wz2A==
X-Gm-Message-State: AOJu0YyFAv6LGpMRNJ3NhptBaojddrBzyKBcrkgmHPNKkzINQDjLtCId
	/iyZvFGQd2P6zPopPVFi/2ZvusvDXS9N6JIoI4Azube85J66FuzBzY4rdxJZTJI=
X-Gm-Gg: ASbGnctAQymFMOqAIGeMdgKdPeGT/8W3JnnM8QhTULpwL4nUp+t3CY+QDvwCEagQySE
	94EA2ElEiZN87DjW1CYAMZS/7JgLYWMlM5m6PxytkB4H2XVUUUJMLjVesPRDNlyD3DGe+p47ydB
	Q4WXp5mWzD3TbWuzN+PNKxsFKVExKZSSS2KuMQ6f8S1pD9Wy8By2dWoKM+ZRk2HqtuTzsqkVaXB
	BlweyRcaXaDFke0iFHF+PeMbDxbVmUm0uGzQHVWmDiw2oBClBVTn8OnxhuwpJz+4hMc
X-Google-Smtp-Source: AGHT+IHaZNNWdfXzEkINU3Ay61NEmNgkluy5Uj/9ks3EwF8JkI4JxwA65gJEofvmzjC0OPPLttkV8g==
X-Received: by 2002:a05:600c:3584:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-436e26f4ef4mr179523445e9.29.1736760668343;
        Mon, 13 Jan 2025 01:31:08 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:23 +0100
Subject: [PATCH net-next v18 04/25] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-4-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2GHbREMM6Paj4kn0ckQZmn8B5a/BY30U8yc
 BenOWGxE72JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhgAKCRALcOU6oDjV
 h3ytB/wIBB7z8zn4vrFXyxvL6cymX4oy9APrdm4rDzwS4rbigDGJyPTkiLtsK8EEDqarQQGo2zs
 F/kugBLuBKQA6p0ANT2B/QF/1xY71TSrOoCnEKcs7z+OJM4vJkv2fRLpuZH/iyjqg/Dd4M+gJZn
 tkkSlOwYb2Y1Hy8pBXhj4AxGhguCMLF81GNi+dKdI2pdtnwzn5j57HVCPGg/iwKDN9IAnJvGnIe
 i0iC6AipVsi4ZK0BqUbIqB4Ln0o2OOQHQxzBhHrxiLSzkvKLu8U4GYgoWVFkXfVdEgcjS+EgK67
 8HC+2MVwQz77F2oWl42b0bmA5LGaUjfY8cdK6TM7AboPDBbW
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index d3eebab7fa528cb648141021ab513c3ed687e698..97fcf284c06654a6581be592e45f77f0f78f566f 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


