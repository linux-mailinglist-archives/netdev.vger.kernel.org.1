Return-Path: <netdev+bounces-117078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA4A94C95F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D46AB240E3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4E166319;
	Fri,  9 Aug 2024 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eej6HULz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE224B34;
	Fri,  9 Aug 2024 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723178707; cv=none; b=Aow203vZm5gk+Q14LqE5s+xZLRM4a9gHeVMeoFfKx69h8g7SrvBskYuDayEpb1Ahm4KrguqsIH4Z98FsY2Qpg06a54qjZxtVWgoYOkHZwUji6uuuMQs4toWJ9HheNc1Xsmm0w+mcpScC1Ly1273wK/6nCUuu1LFDDhGHsax+rgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723178707; c=relaxed/simple;
	bh=vGyKrFbuUJyD09Nd0V19mzOQhUOzkwgITnW3v1ZCt4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7ecpT5m2wcK/UbfIjJuwqd2U+iD2Ms0fNIF+RpawTTpFZYOv7UuIeODL7S1PVwsyp69WDEkty7i3NGgmti3+nCmhK3k7lKkv/GS4flO//SfxMMRGOAOmiLsxEf2luMq7TZF+0kL2+wU1Uugo4c/XMAqxzsXzjGmE0IZPIyq5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eej6HULz; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-710dc3015bfso71428b3a.0;
        Thu, 08 Aug 2024 21:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723178704; x=1723783504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zm2AwoTPtu0FZubejYY6UHmuTkXLWqTdS+acVwuD5Uk=;
        b=Eej6HULzEHVWcB5AZuOVSLinNkpHQA3YdcqQnYROlQvq/TipBq2dkkc8bksTLifLkT
         o24PduTV6OL29xhvwKUKxSEhWO5/ijMczBYhy/61ZUmspvyEtyz7ZKAa4/wL3XDn54Fn
         ehuq0fzY0ihiyObgcR0ViCB8K8jU2YFUYPmmwK3mxhblNzp3BY17jIDKeR7dDlEcQkj7
         SVcRHvISESEMh2KlfM35zy+KkDm3Vx0YMlyh4l6whAF3tbnarPRkrOaFyNyGBjpSwaMX
         P6kP+gGoZzIhG1YI53LQd5lhngEMyYnqSIe8E9zcoWPnGFECy8v+Evl0Ecp3eyNeBCEF
         pyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723178704; x=1723783504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zm2AwoTPtu0FZubejYY6UHmuTkXLWqTdS+acVwuD5Uk=;
        b=rvdddCxoQW+y9/tXFxfw3s6BOzsnp+IJSm5hghnh02kbsHMslkjsGS4nfZJLWM5dlY
         BPPHKXZUfOd9GNH8LGAZEQejlVbEQcmfcq9gGICjVZW61+NmwfyO/mU2gO2dGvk6zfMN
         uD0eQANrGZcS9EJhnlJdwf8+H5krEhc+NyVZyLfEarHSLZHS2tgJp5ubgEf0VzXybgfk
         /bYdhRFEf+YVOZi0b640zYraNRkxFVeoCwHJstD0uD02OFJr/nsOObR9wX3KQjn0c4WW
         qQFBkpSwEensZRf38TaYpfhC/RbHGYEerhkdaXVzdW5yKXAFvaycyIVzgvuRxISCplFD
         6ahA==
X-Forwarded-Encrypted: i=1; AJvYcCVf8zB9pi9rjCVMJUDUfCggyQmSWrrai+XYtxbh6VBRf3SWCSWTtYn1H4zgejXZjLKGZ3ARz0KrK1Gx0Cb2Tyh/E2EysPY9BEqOSbo7
X-Gm-Message-State: AOJu0YzUSGnqvBryVhDWeWEx7Y9NjbmrFvWofqhUjWW3ctqZJ6lkE4dq
	+yDBRrBLR5MKfXKSvh+UL9cvHA4x8Irxr4PwF9XbPAzzRib8yi2gTSRuqQ+b
X-Google-Smtp-Source: AGHT+IFbz6xy0dJtD0UNqVLT8gx9LeFs0tLESpAK1eJPHah7NCz03uufmN0rlJ8U7a9JFqriK2QcXw==
X-Received: by 2002:a05:6a00:b8e:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-710dcd5c457mr659654b3a.7.1723178704500;
        Thu, 08 Aug 2024 21:45:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2fb029sm1871905b3a.191.2024.08.08.21.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 21:45:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nabijaczleweli@nabijaczleweli.xyz,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: sunvnet: use ethtool_sprintf/puts
Date: Thu,  8 Aug 2024 21:44:55 -0700
Message-ID: <20240809044502.4184-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simpler and allows avoiding manual pointer addition.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/sun/sunvnet.c | 35 +++++++++---------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 2f30715e9b67..f26e76b44c60 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -114,37 +114,22 @@ static void vnet_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	struct vnet *vp = (struct vnet *)netdev_priv(dev);
 	struct vnet_port *port;
-	char *p = (char *)buf;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		memcpy(buf, &ethtool_stats_keys, sizeof(ethtool_stats_keys));
-		p += sizeof(ethtool_stats_keys);
+		ethtool_puts(&buf, &ethtool_stats_keys);
 
 		rcu_read_lock();
 		list_for_each_entry_rcu(port, &vp->port_list, list) {
-			snprintf(p, ETH_GSTRING_LEN, "p%u.%s-%pM",
-				 port->q_index, port->switch_port ? "s" : "q",
-				 port->raddr);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.rx_packets",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.tx_packets",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.rx_bytes",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.tx_bytes",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.event_up",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
-			snprintf(p, ETH_GSTRING_LEN, "p%u.event_reset",
-				 port->q_index);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&buf, "p%u.%s-%pM", port->q_index,
+					port->switch_port ? "s" : "q",
+					port->raddr);
+			ethtool_sprintf(&buf, "p%u.rx_packets", port->q_index);
+			ethtool_sprintf(&buf, "p%u.tx_packets", port->q_index);
+			ethtool_sprintf(&buf, "p%u.rx_bytes", port->q_index);
+			ethtool_sprintf(&buf, "p%u.tx_bytes", port->q_index);
+			ethtool_sprintf(&buf, "p%u.event_up", port->q_index);
+			ethtool_sprintf(&buf, "p%u.event_reset", port->q_index);
 		}
 		rcu_read_unlock();
 		break;
-- 
2.46.0


