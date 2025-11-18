Return-Path: <netdev+bounces-239638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A90C6ABE8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EC024F0EB8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8E36CDF4;
	Tue, 18 Nov 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKysXBoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE636404E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484254; cv=none; b=shNLlijOsxlXhhNzJbfmelvU9YhIacUPgwqYel5zEXqX3a4swi2gIX8gFW0rODxXjuol6cLDXkdZfZpTi06oP16rua4H+oCc/cHyW0dJEehjPjXU3NmBqDoKix714j+imHTMYmQlxQ7bXVj66B8cMJz4xZksB1ANzIiyNUPG4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484254; c=relaxed/simple;
	bh=0FQ386+g3fJmb2sXgWLF41NLQyulgHxdCvrCfZwHMVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coHCpceg5zv247xha0BUJ6lC0XrEqtjXPXjJuaOFvrDo4ohha4iuKiRgECEaYekgXLdLUQhcPIRPc1DhZFNVsucZ+10Y+5awNY2VMOOy/3OyuATxv8BfGwItE8Zft/oDEIBvr0LZeMZ6PB75N+rsyweQoipEId+ljk0Rr+mgyh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKysXBoI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso4831039a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763484251; x=1764089051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwmtgOlhlWBYCrE1LogTIJtjLPIo0fBin+YkiTpkdPg=;
        b=jKysXBoI1WRTMhaLZDwrtq0Wpm5XQ2PIVtl9tzmMDuTnSV9p8vvzW0QKbdGs6Megso
         EvzdNxbkovVieJuVGsCiDcoGOuH8H/pRoBO8zBul6KXeQVLlQjgXAn3j2tKzo8xHXsKx
         5H83/sXJvD38OJA99hVOFgRMPrzXGRwJLakri4MQJlpXpsOYbW/JUY3uWOa7lhMWrlHv
         u17RcsXEHkGv5jOyH98f19uDmoY5ifJQJnEzdISYmVlIiG8qUDByC6LC0TkEKgQ6eZcj
         iU+CfAC6n/zS9vSvTXmjm2Nv/p+ZZmU8vawJT6S5RM6Z9pHoBQnsWBf9TSGPNTpK8/np
         8J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763484251; x=1764089051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwmtgOlhlWBYCrE1LogTIJtjLPIo0fBin+YkiTpkdPg=;
        b=edyHPm0s8HgCbLphisReN9D5eie3iIrJ4TNOk6CGHWIlrH7U93hhaf0B6AZAfoFWm1
         O9hh/hoqKpm7pRHVHwoKWUm2/+lP511D9K89zaEWlmCOQHTpDHrLE+6J+/HLmS/FBbyW
         MVdUreFRhRMxEQ+OyppjaD+rmzckRJoegGuKbgqEA9qvjM74U+roeYo6XChiDyHTM+hY
         /SmYjE8oOYVs2XohLIK6o33z2WxzuJbtEXt4IhunxQVGPZohnMR0r1ie8PcdBERyv2R1
         OiJsp6dNKxQfiqGFTIV0GP5SYB3b4+4YHSAcKOBABqguE6I7a4kM6yYRdl4BAZzUQ5kQ
         4fFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/B+s63UCNZyW7DmBLmqNHSM8rw+o/ieUn30fA6xq/kbLQWhFVd5eVdPqfOOo2IGMArbAKslU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kQ2Eptrjae6nf+udj3X8/njy2C6BD2mvV0XiUvf4Qqju6owH
	ylOZN+5dfmH8YZAqQlNYTyP7srH85tz24Uph67NcvoeSTAJFxMCKr2GQ
X-Gm-Gg: ASbGnctTVpmtz+A/qLHT8ke0OCWXu+cdiKQVPNtymaC3TPf5hhwOAm9xYNpRMVcPnmG
	TW+VUHVOjd33hYZkuAkvZBftvye5xiqB9HQ+7NcnEWCPjEf+A3n8O1gYP239Lq+r66op3W71s2E
	iRQ3oaC+dKQXNT6hiWw7REufGoDpxlf31mvCjRsdDWg4gqgEOfP9cuxCVJ/XzRkQ1hdThN5Gkbr
	GVpGdI6CClPlJkVnwXU8zt4Db3JF6HVPxV5s0U6/qc9+/y11LxwTFc4r2PqTdSwxOSWZ6kvJ4lN
	GDei0fUiidCLA3R6THOiyT9xxo7lh4Qt25rmQLar7AvZFqB7/pFZF0Xv/2GGzlabrpSC9IbsiGJ
	oRt7AwzBnexWAaj7cpy/U5RuxT2iR2NFNZkjzFB3LKf351G0B4u0qcBalMHvhkEmEZpz9j/A4x0
	JkReVrfVxWTUZjVm7Yf+UJmAhyFEx1IOyI6GVfHgpYeTdyDDts6WbG8w==
X-Google-Smtp-Source: AGHT+IGP4POJh+nQC68ptxHo+oArpwmANuGeak47u/8AJD4JE1aggtVetdUtI5VFttSw6IUoTGKYcw==
X-Received: by 2002:a17:90b:4b49:b0:340:f009:ca89 with SMTP id 98e67ed59e1d1-343fa62fabemr18013927a91.22.1763484250931;
        Tue, 18 Nov 2025 08:44:10 -0800 (PST)
Received: from COB-LTR7HP24-497.domain.name ([223.185.135.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513f162sm13544843a91.8.2025.11.18.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 08:44:10 -0800 (PST)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	aleksander.lobakin@intel.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [RFT net-next v4 2/2] virtio-net: Implement ndO_write_rx_mode callback
Date: Tue, 18 Nov 2025 22:13:33 +0530
Message-Id: <20251118164333.24842-3-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ndo_write_rx_mode callback for virtio-net

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 drivers/net/virtio_net.c | 56 +++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cfa006b88688..20494ed5a0f6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -460,9 +460,6 @@ struct virtnet_info {
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
-	/* Work struct for setting rx mode */
-	struct work_struct rx_mode_work;
-
 	/* OK to queue work setting RX mode? */
 	bool rx_mode_work_enabled;
 
@@ -3857,18 +3854,17 @@ static int virtnet_close(struct net_device *dev)
 	return 0;
 }
 
-static void virtnet_rx_mode_work(struct work_struct *work)
+static void virtnet_write_rx_mode(struct net_device *dev)
 {
-	struct virtnet_info *vi =
-		container_of(work, struct virtnet_info, rx_mode_work);
+	struct virtnet_info *vi = netif_rx_mode_get_priv_ptr(dev);
 	u8 *promisc_allmulti  __free(kfree) = NULL;
-	struct net_device *dev = vi->dev;
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
-	struct netdev_hw_addr *ha;
+	char *ha_addr;
 	int uc_count;
 	int mc_count;
 	void *buf;
+	int idx;
 	int i;
 
 	/* We can't dynamically set ndo_set_rx_mode, so return gracefully */
@@ -3881,9 +3877,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		return;
 	}
 
-	rtnl_lock();
-
-	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	*promisc_allmulti = netif_rx_mode_get_bit(dev,
+						  NETIF_RX_MODE_PROM_EN);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3891,7 +3886,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	*promisc_allmulti = netif_rx_mode_get_bit(dev,
+						  NETIF_RX_MODE_ALLMULTI_EN);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
@@ -3899,27 +3895,24 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
 			 *promisc_allmulti ? "en" : "dis");
 
-	netif_addr_lock_bh(dev);
+	uc_count = netif_rx_mode_get_uc_count(dev);
+	mc_count = netif_rx_mode_get_mc_count(dev);
 
-	uc_count = netdev_uc_count(dev);
-	mc_count = netdev_mc_count(dev);
 	/* MAC filter - use one buffer for both lists */
 	buf = kzalloc(((uc_count + mc_count) * ETH_ALEN) +
 		      (2 * sizeof(mac_data->entries)), GFP_ATOMIC);
 	mac_data = buf;
-	if (!buf) {
-		netif_addr_unlock_bh(dev);
-		rtnl_unlock();
+	if (!buf)
 		return;
-	}
 
 	sg_init_table(sg, 2);
 
 	/* Store the unicast list and count in the front of the buffer */
 	mac_data->entries = cpu_to_virtio32(vi->vdev, uc_count);
 	i = 0;
-	netdev_for_each_uc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
+
+	netif_rx_mode_for_each_uc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[0], mac_data,
 		   sizeof(mac_data->entries) + (uc_count * ETH_ALEN));
@@ -3929,10 +3922,8 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	mac_data->entries = cpu_to_virtio32(vi->vdev, mc_count);
 	i = 0;
-	netdev_for_each_mc_addr(ha, dev)
-		memcpy(&mac_data->macs[i++][0], ha->addr, ETH_ALEN);
-
-	netif_addr_unlock_bh(dev);
+	netif_rx_mode_for_each_mc_addr(dev, ha_addr, idx)
+		memcpy(&mac_data->macs[i++][0], ha_addr, ETH_ALEN);
 
 	sg_set_buf(&sg[1], mac_data,
 		   sizeof(mac_data->entries) + (mc_count * ETH_ALEN));
@@ -3941,17 +3932,18 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 				  VIRTIO_NET_CTRL_MAC_TABLE_SET, sg))
 		dev_warn(&dev->dev, "Failed to set MAC filter table.\n");
 
-	rtnl_unlock();
-
 	kfree(buf);
 }
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	char cfg_disabled;
+
+	cfg_disabled = !vi->rx_mode_work_enabled;
+	netif_rx_mode_set_bit(dev, NETIF_RX_MODE_SET_DIS, cfg_disabled);
 
-	if (vi->rx_mode_work_enabled)
-		schedule_work(&vi->rx_mode_work);
+	netif_rx_mode_set_priv_ptr(dev, vi);
 }
 
 static int virtnet_vlan_rx_add_vid(struct net_device *dev,
@@ -5767,7 +5759,7 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
 	if (netif_running(vi->dev)) {
 		rtnl_lock();
@@ -6270,6 +6262,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_validate_addr   = eth_validate_addr,
 	.ndo_set_mac_address = virtnet_set_mac_address,
 	.ndo_set_rx_mode     = virtnet_set_rx_mode,
+	.ndo_write_rx_mode   = virtnet_write_rx_mode,
 	.ndo_get_stats64     = virtnet_stats,
 	.ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
@@ -6891,7 +6884,6 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
-	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
 	spin_lock_init(&vi->refill_lock);
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
@@ -7196,7 +7188,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vi->config_work);
 	disable_rx_mode_work(vi);
-	flush_work(&vi->rx_mode_work);
+	netif_rx_mode_flush_work(vi->dev);
 
 	virtnet_free_irq_moder(vi);
 
-- 
2.34.1


