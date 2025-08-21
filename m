Return-Path: <netdev+bounces-215599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85184B2F6F4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4181B1C2443F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058230E833;
	Thu, 21 Aug 2025 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3hbGI+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D030F531;
	Thu, 21 Aug 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776628; cv=none; b=sLTqTyz+WhMUrXfmFe+/rrOACYgSfZxppsgh7JfFOO4Gvl++1cupoh+MIKQbw2ZKHho/PAYm3w6qrc5FKCyX/eG3aWkHUesIV6PToAZJJ3E5BDOitbzVPGwfZm9/q+6KrBkEM3UdGF2o4+kWtGlti3M4Op077Mthsc7nLmzFcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776628; c=relaxed/simple;
	bh=R3Scx1nCm7qXdEeR72YI5W2/n/X1yCm0pDtCDNCqSJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CG/aJsHCK3Hzg6sZ1reX37Duz7xCtjedvwF992Nr2M0SrufraNndVcgOXyVZEgn5qEwktJNmI96J3UTfBI7A53ycnSFy2yQPatOcCjNqqV7MgHdIWjeCRGXTNT/Gz4f3iwADUP/Qaf6926/ooo90HUCbFGUaYeBP9V0IboTkASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3hbGI+b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so777936b3a.3;
        Thu, 21 Aug 2025 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755776625; x=1756381425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8SdXJDP9EOWPMR/erbb4MQMr6TAUsa/gMSJnaqvBaM=;
        b=M3hbGI+bZyo/3KqL7E4qr+BbOPl/m2sv+140ItqMmkkJbG3qw8Bm0hADgXvTO4Nzdv
         hq8fKesE9Mx6cu7AviaIZ4so3YfDwM3O5tGO5C7VsSiWZhCXPB6sJtU91YCbqHnxasAS
         BnodHSytcbkeAgp8fJxT7hXtGnYgF0/Y9EXHSsB92LzpY+iwUM96ppLze12aqLgV7Aqo
         8x7kioN/89v5NcvMjf7g+EEY7FIcZm6TIUNz+qK3p6QW96gXSQVG4O3EyE87YPfiTtoW
         Dq1eb+NxEYD6vfqXHV6kyxVPZKY/Ouct9ohgYHmdSwyIVwz2Zj+27jVygN+CSezneJIa
         OBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755776625; x=1756381425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8SdXJDP9EOWPMR/erbb4MQMr6TAUsa/gMSJnaqvBaM=;
        b=ERh/4GG9KQlu67aVHxQJA0FpvQL8kJ4yHs/mxCLBoGqIgILDAKpSjdGWIWxyT1Fi9r
         vNabN49g7KDUxhlUepcLh48qtuoUqKK+i1HZAgR0cEB9SG/EAfQ/gnWqYE3tYngT+VGW
         VGL76STbseW2rzbOfjqksYgPwPalYnP1QIUft5P1mzNhP9sQ4oshbadLAapp+/ngntGV
         vOBNx6TVuzZArOqtEBgNTIXiv1I36Ns9qXjeELD0XfcevuoUi0KegyG4PeSFiIIJ407U
         wXYEX/wqByqSmuF/v/6ADVVtDBoje2P5UTN31ZkgoLjKb6mTUS0fmKyCcT+Xp3lwKV8g
         0WWw==
X-Forwarded-Encrypted: i=1; AJvYcCU2pNpm/4SoSbYrI5uiSro/sCS4+5JllhHc+iiUp+FoHPyVvD8aDphwbhFIRnN/WF/wS4m5eha5IKWEF3E=@vger.kernel.org, AJvYcCWbAVGs5KW6OdO6hPjV/C8BNH7Jznp0CVRIwg8sGaM1Pvapsenk5+TwJLOF4mkx+7mDeOOZ6omZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHH0vtIB9pGuomvrP48gtLZ2dJvl1rYVYYn7TT/3ficA2/f/ZH
	QGFJ5HWNG+V8o3WHYzhjH+2rqo7DGC0CChYn2FyupY8LAEnTHg7kICAq
X-Gm-Gg: ASbGnctKQRXKlUp8SbCj74RuTmevgzljTFW/+McMeC5VTwtqFIbZF8QHs/nebNQu5FS
	BP4E+EujWU9Eo+tZWo3/dMyqV4y11GkKQoShzviyvgnTPQkW2XA2jVFIDMGAsWvI+jJ9d40hzJz
	l+JjdfnaCF+iNRCdUKHh7ncpaM7oirb/KefoqbWnpx/AQllPoHKoBUyeGg8w8jpoRuEzmirxak4
	Wua8eRUwZs/5qRSQm7I3ojJdpzPHjTHCazaKihbSLSk8x8/u9d+fVc+LdOuY/xkRbmzlTVzj+zG
	6wkZCBbHNDInoEJ22p0NJlujzM1txFevhFndGrhSj928kT3fp1d42tYkN0ZK7wOUc85BRt1FAxC
	6Js7S7r18Y26ex9tHDdNr+ZQz
X-Google-Smtp-Source: AGHT+IG0qPXrimBqxKsTPgNOg7cjXvEK1Tg1fEhT9QgLA9n/DxXnbIC5Aibc3t7h6VGnDQWi710POQ==
X-Received: by 2002:a05:6a20:7f96:b0:23d:ab68:1b7c with SMTP id adf61e73a8af0-24330a98906mr2887985637.46.1755776625394;
        Thu, 21 Aug 2025 04:43:45 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm8072679b3a.0.2025.08.21.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:43:45 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dlink: fix multicast stats being counted incorrectly
Date: Thu, 21 Aug 2025 20:42:53 +0900
Message-ID: <20250821114254.3384-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`McstFramesRcvdOk` counts the number of received multicast packets, and
it reports the value correctly.

However, reading `McstFramesRcvdOk` clears the register to zero. As a
result, the driver was reporting only the packets since the last read,
instead of the accumulated total.

Fix this by updating the multicast statistics accumulatively instaed of
instantaneously.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index cc60ee454bf9..6bbf6e5584e5 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -1099,7 +1099,7 @@ get_stats (struct net_device *dev)
 	dev->stats.rx_bytes += dr32(OctetRcvOk);
 	dev->stats.tx_bytes += dr32(OctetXmtOk);
 
-	dev->stats.multicast = dr32(McstFramesRcvdOk);
+	dev->stats.multicast += dr32(McstFramesRcvdOk);
 	dev->stats.collisions += dr32(SingleColFrames)
 			     +  dr32(MultiColFrames);
 
-- 
2.50.1


