Return-Path: <netdev+bounces-159776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C7A16D79
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B503A7EB1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9421E1A39;
	Mon, 20 Jan 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlRkuQ21"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53511E103B;
	Mon, 20 Jan 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380192; cv=none; b=e/ko4EF7+qIgWDSQySnjmNGKj4AlV1kbGImgZKPjfg2FkXAl2I3FGNkpvqsOmUztuoI4eNfWm/lLk5Xjlzu/MOfYD2yjhebYwnggQDls30QxMWbaZZv/doXFnfeNJg8vFCnNB73z1hCWCQZV3Gm/AQCgS0Z+mP9+5/vGp4XIdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380192; c=relaxed/simple;
	bh=yXGEOFfEZ0jP+43nLRn7rdoSQHgU5ToywJv+x3kOVyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WqQ7J7KRjxWLnZztwQnZ6dVUlW6ve17r+y6N+wtAWpdFKo/rIVYkWMwHySm089MdFxvlb/mpLr7GAL0QnjkKm7nexlB9XowuS/McCJiPlKktrvJpOs/9RfOQWXy7j315epHukXkAkATm3t/JPfI5W4N3PRwJUAKwKse0fgP7MY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlRkuQ21; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5439e331cceso2772561e87.1;
        Mon, 20 Jan 2025 05:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737380189; x=1737984989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zch4l4X9MuCbcNAX4Ida9DiTgs8Oh2Jd8KdR3iffvMg=;
        b=XlRkuQ2111ha71eODEMXzeK45LIkm245rCgWBKgWX3d3FNiQPnDr93biP6nathLkbK
         0u7dqkYA1OT9ra4YP7EqUAbyxuGDgejCkN+/qPhnBnxHLDfPMCLqk9NvbN7URqkggeKU
         MEOzmWQ/gDkWjUtlmHfRm9qoF3NLr3QRDJF5OUf61IUAetAwhPzKdKwsyNwCuel6UUww
         hc1bDAAXdAwptudpbweOzH1y6eWLUMnPMkvvjQFOWVHk23C7xDZhAHVSUjxsRtlbOs4j
         8yvi6VZvSz+WmwFVxmLT7mePVP4pJJf1NtS/m39LJywG52wq34BagcS2zPqQsbwof34r
         iljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737380189; x=1737984989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zch4l4X9MuCbcNAX4Ida9DiTgs8Oh2Jd8KdR3iffvMg=;
        b=DBbMUhMUulpKwy449uZ90VlNo7S7EjXmVqmjvxpSnPZtX7D1PVKVJET0jUIdymaFua
         r9M3q9An8PVk6ty83/m9ZOCNYNmCxUSjYxb2UZ41OoQHSFtBQ8Y//4VzGw2r2ovqMIx7
         sh1CRl+D6TqxzU2WFQ1mgUq7v3Q2sX8DLm1DTQYBjlFh6CISZKDg/mTc73jRVljurROG
         GYQn6R6sdtZBrBieQb8kW6iGeYFFn4l0KTK73jM0NQCWSZRoJQ8qMvh/aIYFd5WYJROH
         3PhE6Y4cy9wDcYpTfVX91QY51i3i2P4xc/PoypVau+yF5EDiIVLSEl08jmgCRgQdD1O3
         XjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJgRYMB4gVnz0EZHki/0kGL4ecqjrY23aQMwdCtN6vkhebCz04bjcR177yLTfCCtXU64DRgCkPeF9xGOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Px5YLUQw+7d/BpJlD+y7JHbAC5HM5Y7eDOxKsE2NbqFxsJgH
	bg57IpJrVihTSK9mx4F+I4gaDv8Qvpe/AHTZiIsRRPaNCrnUt3yj
X-Gm-Gg: ASbGncvG3/C/T/QqbEooKDfCPyyNIE8xMu5872BpWKgIpGwF7ARhHN7uVD2eMyZcRC6
	bQ9WwPY/BD+Ti7LqzSwJ50aKU27iwa8wm8onH7DhwPbJkRY1noQhd99P7zEgbUFK6DqtpYDub3n
	sXnj2lmXKLNu7nv79UVzpPL3Y5BpBec8dsFxY0+1H7LYJGzwK7LlXKEDOn6FwXg26Rwhnh2j7Yg
	SDpSNQQtWwcZKgQAXWdIUVorxNZuEv0UJ7SWfFuj5WMk2JGxKtteXOf6NWLsaXpk6H3q9+z9XtG
	e+1iO+5Y
X-Google-Smtp-Source: AGHT+IE2tnsHwDqKUybIhRlgq7wQzlLG4yfkzZGFi91L9aafO0eBpi+cuT6S9ZOU6LdLPetKOtSv/Q==
X-Received: by 2002:a05:6512:2213:b0:53e:3a79:1ad2 with SMTP id 2adb3069b0e04-5439c265cdcmr3822191e87.40.1737380188538;
        Mon, 20 Jan 2025 05:36:28 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af66c36sm1329401e87.160.2025.01.20.05.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:36:27 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50KDaOs0029244;
	Mon, 20 Jan 2025 16:36:25 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50KDaMuK029243;
	Mon, 20 Jan 2025 16:36:22 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Peter Delevoryas <peter@pjd.dev>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH] net/ncsi: use dev_set_mac_address() for Get MC MAC Address handling
Date: Mon, 20 Jan 2025 16:35:36 +0300
Message-Id: <20250120133536.29184-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy of the rationale from 790071347a0a1a89e618eedcd51c687ea783aeb3:

Change ndo_set_mac_address to dev_set_mac_address because
dev_set_mac_address provides a way to notify network layer about MAC
change. In other case, services may not aware about MAC change and keep
using old one which set from network adapter driver.

As example, DHCP client from systemd do not update MAC address without
notification from net subsystem which leads to the problem with acquiring
the right address from DHCP server.

Since dev_set_mac_address requires RTNL lock the operation can not be
performed directly in the response handler, see
9e2bbab94b88295dcc57c7580393c9ee08d7314d.

The way of selecting the first suitable MAC address from the list is
changed, instead of having the driver check it this patch just assumes
any valid MAC should be good.

Fixes: b8291cf3d118 ("net/ncsi: Add NC-SI 1.2 Get MC MAC Address command")
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---

Peter, this is compile-tested only as I do not have a suitable
hardware setup to try it on. Please also pick
https://patchwork.kernel.org/project/netdevbpf/patch/20250116152900.8656-1-fercerpav@gmail.com/
if you happen to be able to test this before that fix is merged.


 net/ncsi/ncsi-rsp.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 14bd66909ca4..4a8ce2949fae 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1089,14 +1089,12 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_gmcma_pkt *rsp;
-	struct sockaddr saddr;
-	int ret = -1;
 	int i;
 
 	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
-	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
 	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
@@ -1108,20 +1106,20 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 			    rsp->addresses[i][4], rsp->addresses[i][5]);
 	}
 
+	saddr->sa_family = ndev->type;
 	for (i = 0; i < rsp->address_count; i++) {
-		memcpy(saddr.sa_data, &rsp->addresses[i], ETH_ALEN);
-		ret = ndev->netdev_ops->ndo_set_mac_address(ndev, &saddr);
-		if (ret < 0) {
+		if (!is_valid_ether_addr(rsp->addresses[i])) {
 			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
-				    saddr.sa_data);
+				    rsp->addresses[i]);
 			continue;
 		}
-		netdev_warn(ndev, "NCSI: Set MAC address to %pM\n", saddr.sa_data);
+		memcpy(saddr->sa_data, rsp->addresses[i], ETH_ALEN);
+		netdev_warn(ndev, "NCSI: Will set MAC address to %pM\n", saddr->sa_data);
 		break;
 	}
 
-	ndp->gma_flag = ret == 0;
-	return ret;
+	ndp->gma_flag = 1;
+	return 0;
 }
 
 static struct ncsi_rsp_handler {
-- 
2.34.1


