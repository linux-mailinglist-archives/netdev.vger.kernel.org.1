Return-Path: <netdev+bounces-147823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874DF9DC14D
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DF71618A3
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E77170A15;
	Fri, 29 Nov 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRwAviy9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546115852E;
	Fri, 29 Nov 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871733; cv=none; b=PMLbqV3cGq+qQoK6xIIXOVPY8myizKO12UVZQimInJOYD6lfMnqMNwKlgxfSv7D7vI+ABDdHfJM1T1eeO1QGsjThWVf+pQOJ5b20Bxls1MlXm1CAqC4O6EABME6DZGp885BJvFEezQNzOYIyeFPpbROaijDy7DKOW0kye94BlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871733; c=relaxed/simple;
	bh=KaqlpHEGYnYZ87Z3/IzbVZ2RzQNqZFTf5v2/p2TYLCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iGi8u1uCMa8pQGxS2/BT506dZko4tTcMnygAPBsTXz5tWs3a4MzmJeZUuremJy+QmE6nou0yFWlheFO/6s3tzNbdCedhS4mKHOvH1mBFllOe42FkvgxGjwN4c2ws0+ZqGIScBhXQHaPIBQaHZua7b6lWQNK22MANE/7k0ueecek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRwAviy9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21210eaa803so13902335ad.2;
        Fri, 29 Nov 2024 01:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732871731; x=1733476531; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUcwmQCkeGqB0StakEVOLLLoTkvnDgPEcHpdDrPO958=;
        b=ZRwAviy9U3x+3E7ln2aA9DRpCNanp9zlO3g7Y84aXn43C2Hd57Vlx5UWEkJlxTRTew
         c+IjgKVwURG6Xg0BUouoMQyNzFE/JqN9cFfvs4SqG5LRNAwF89f/yXjXHxPDHtg7M62g
         VY8oBs6PO2BAqDrVfDduwhrSL5XCoj0sBK5XmwdAlC3FiJg2M4yfRLWt9WsS7GBxy83s
         dVsiO95uMlZmjIHQT01iR4IAU8a0qjB75HyjZipn+BQGuQPmPozqDHbtZcGPvrUCR8Wg
         9F2L5feVPetiXE8wmyH2Hno0ZRdg9jTZ018yFHOZ6sUOcWrZr5eY95ouoKoHDDOs0TZd
         P1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871731; x=1733476531;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUcwmQCkeGqB0StakEVOLLLoTkvnDgPEcHpdDrPO958=;
        b=w3sHJ2AKSdySm5HdRNH6uoB8/I2wD+jzXvvDgtrPdJ3JblHCQp5OAdW8iBCHp93LV7
         JpAGIsvgAWDprMtuH7gi9jkSzsIASbmR9BO89sLqikV3KAhnQebBpewb/Pym0VbeXJu6
         B+7M6cbGEsYzdWmZXIipguPjcHNY42+kkUEUyZ70544eGUEi6HsaAc7JajNnnws7KW0z
         PQNfqCrPWTVEuDF+KJ3xvD3fzGyvjX6CRrmIaAQZ96VpX4ydK5yt/c+P9fIJ65nobF3c
         WX0XKEz/uWWgYCDajC84w09cYAHaRJCtineA+mT70N0I97jwraxGW48NwGea2eI9cTTK
         G+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXTEJJRPXOOS0cNDzesajDrM4Uy9eeTQFqc7fzvS49edj2jTkZOyvTMctmhUnNHAAVPcKbBQmK5r9+53sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFjQwOadTLMgByy+n6J42Z8Q1ej9jE1UsHxjw0Vd7A/0vZizI
	CRb4LkfXrw6nwnl3RXfn82FDJlyiDNNjiqGRsmgc/Ixc58AvBiCn
X-Gm-Gg: ASbGncuo6edCnmRm1QV0pMHKbiyqzRW84+08Kxk53uK41CJngAfmcOjRK5AUCINcgL0
	BeoMaZYOo9zRX66UoLCevwyrX2KtDmk8n/dW6ReNaoUTksO8J4thMtcodrULd81tHLsTHVivES4
	ICQJHabeuWhrjgnfodZL1Dk/JyGM8w69cizPzoK38KxqJ0Tk1kcOLEgMU1XrL1viJ5VHbCiM4kF
	hCn9BBhNA0bgxLgdEkVgs6WtXHg8ma1gkMoahY5+5O3hX1NFWzJhPAG5cYBx+eyZaxIVRV/i0ei
	GNzdVCKfdk8dgIYZEpupkCG23iw=
X-Google-Smtp-Source: AGHT+IF9d2ojpg7Jhyc7ajdo+FaCJ9zRYOLGCTGSJVFkffaKronYolhITsWDHjFSdXN+lSk9ynSsMg==
X-Received: by 2002:a17:902:e949:b0:20b:775f:506d with SMTP id d9443c01a7336-215018568dcmr141201435ad.34.1732871731348;
        Fri, 29 Nov 2024 01:15:31 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215475446e0sm5636125ad.92.2024.11.29.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:15:30 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 29 Nov 2024 17:12:56 +0800
Subject: [PATCH] Revert "net/ncsi: change from ndo_set_mac_address to
 dev_set_mac_address"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJeFSWcC/x2NQQqDMBAAvyJ77oJZqka/UnoIyabdg1F2QymIf
 zd4HBhmDjBWYYOlO0D5JyZbaeAeHcRvKB9GSY2Beno6RzPuW5WCTWWtWKIJGldcQ8SQkuLkiDL
 5eaTBQ4vsyln+9+D1Ps8LBCu133AAAAA=
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Patrick Williams <patrick@stwcx.xyz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732871728; l=3556;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=RuK+WbLgsjHtZ+l4K6wvPZvX+fDp3WNk9HOtKfGMKfU=;
 b=yH8EY9Qu2NPBZZvUmGOSfCB9tx1OahEnESLVkTIzFHdupqIm5Fu0wuIXTJKzd/UJcAbFqZnpi
 lJ8DuRCvejyAL36WpaRQASwkiHiEBHatUNJzlv3FS/Iyl8cCXZjeltx
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Potin Lai <potin.lai@quantatw.com>

This reverts commit 790071347a0a1a89e618eedcd51c687ea783aeb3.

We are seeing kernel panic when enabling two NCSI interfaces at same
time. It looks like mutex lock is being used in softirq caused the
issue.

Kernel panic log:
```
[  224.323380] 8021q: adding VLAN 0 to HW filter on device eth0
[  224.337533] ftgmac100 1e670000.ethernet eth0: NCSI: Handler for packet type 0x82 returned -19
[  224.358372] BUG: scheduling while atomic: systemd-network/697/0x00000100
[  224.373274] Modules linked in:
[  224.373817] 8021q: adding VLAN 0 to HW filter on device eth1
[  224.380063] CPU: 0 PID: 697 Comm: systemd-network Tainted: G        W          6.6.62-8ea1fc6-dirty-cbd80d0-gcbd80d04d13c #1
[  224.380081] Hardware name: Generic DT based system
[  224.380096]  unwind_backtrace from show_stack+0x18/0x1c
[  224.439407]  show_stack from dump_stack_lvl+0x40/0x4c
[  224.450573]  dump_stack_lvl from __schedule_bug+0x5c/0x70
[  224.462492]  __schedule_bug from __schedule+0x884/0x968
[  224.474026]  __schedule from schedule+0x58/0xa8
[  224.484026]  schedule from schedule_preempt_disabled+0x14/0x18
[  224.496906]  schedule_preempt_disabled from __mutex_lock.constprop.0+0x350/0x76c
[  224.513235]  __mutex_lock.constprop.0 from ncsi_rsp_handler_oem_gma+0x104/0x1a0
[  224.529367]  ncsi_rsp_handler_oem_gma from ncsi_rcv_rsp+0x120/0x2cc
[  224.543195]  ncsi_rcv_rsp from __netif_receive_skb_one_core+0x60/0x84
[  224.557413]  __netif_receive_skb_one_core from netif_receive_skb+0x38/0x148
[  224.572779]  netif_receive_skb from ftgmac100_poll+0x358/0x444
[  224.585656]  ftgmac100_poll from __napi_poll.constprop.0+0x34/0x1d0
[  224.599490]  __napi_poll.constprop.0 from net_rx_action+0x350/0x43c
[  224.613325]  net_rx_action from handle_softirqs+0x114/0x32c
[  224.625624]  handle_softirqs from irq_exit+0x88/0xb8
[  224.636575]  irq_exit from call_with_stack+0x18/0x20
[  224.647530]  call_with_stack from __irq_usr+0x78/0xa0
[  224.658675] Exception stack(0xe075dfb0 to 0xe075dff8)
[  224.669799] dfa0:                                     00000000 00000000 00000000 00000020
[  224.687843] dfc0: 00000069 aefde3e0 00000000 00000000 00000000 00000000 00000000 aefde4e4
[  224.705887] dfe0: 01010101 aefddf20 a6b4331c a6b43618 600f0010 ffffffff
[  224.721100] ------------[ cut here ]------------
```

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c..0cd7b916d3f8 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -629,6 +629,7 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
+	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
@@ -655,9 +656,7 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	rtnl_lock();
-	ret = dev_set_mac_address(ndev, &saddr, NULL);
-	rtnl_unlock();
+	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
 

---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241129-potin-revert-ncsi-set-mac-addr-7122f2896258

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


