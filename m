Return-Path: <netdev+bounces-248890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3580DD10B72
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFA453079EF1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBAC3101A7;
	Mon, 12 Jan 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D3CQ3Mxy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3673101BD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199639; cv=none; b=pJeXKwEkMg11kCjA6NIwNUfihqWxkgeMEYc/E7+AZ4VMCuF3CIl1XE4Qv8vBCGMXfFV7TYbZ6dMZK/816tPct4kXEa3H7bbGl5xXRsJekODn1dAHvtNWtAe0As5AO1NXeX9TzNFXxArAlGKj6ctAvEfALisywACnsCBTsATC4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199639; c=relaxed/simple;
	bh=RWuTHL2vG6VXYYw+aleWdAzTOjFVPPbKCGWiPi4YKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8L9LuGtUAoOITuuYSAZqi8eALpi6y4mH3G84aQqFIBEH+bpObzstiSGSWCYr0y3BYrhrW2KN7y9KVjI6gke0pei2C4Ugspr5zHYQqDkam0nB+YxFA0XXiusZGWMantgD1LHXjjDOFde+8JSAcOAwnp4tz5XxuxMamgXXa7gz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=D3CQ3Mxy; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-3e82f723a23so93645fac.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199636; x=1768804436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=UeZeMsoNuf7NPu9AzbuBq4H7DjW9ShlyO0DqQWwvjX7M4BQe43NLvYNuK9LLy9BB6F
         gk87qDu1oG0o34ycOTvP70K01P0QUA6JncPM72cIOOGegqgol6AQAA6MTHb9CTlL3pwW
         Fy5GDzuqhP4PdRA5y1hwQ8wg/4TDzopH/By98T4c+h5hCqpXImp3ZJOdSAw9MqBLl9ct
         zgeRhDRMv9p4MolpRIn0ulcrSSxF9PKg1VSECFX0EdYevVg4Zt69tAGB7h1Ez70ARrxh
         XuGOoczfNohTJ6+GZf8RbJCw+pCI6eQyQ9iHW3ckbS7YuYgZIU8cb2ZaSedtbRKErPXv
         0P4g==
X-Forwarded-Encrypted: i=1; AJvYcCWsRqVaN8Ivm6orD1Mq+jq+zY5/igd+uZXuzmOYqeLYDCfBz/4UbDm6QowM+NsMeJ9RE/52I9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdyov2FwjZr6jwIBFTregtAxF+oORgPPzJrnH7LIOGQei1VWi
	TFR77diP49+DDSaZZI3Yv55ERbev1muJYyk5ZAV+RQYoAjHAFEn9oL/ox+IVaKmZP9HIbkl0TYP
	YKv0+AVSkI3f/nBDzIQBREw00sOtpvpqeIyGZGDHK/OWFK99HY+9/Ri+5VK+nC22cJF8PfMCLGO
	3uSBVE9v0ZjsSwHP0+RnIbAnKQgKbHSuVx+KXJYOGJRD76WCGH+5Iz0Tb8k1dfe5VKEkHSiKUZE
	Zx2t0cR4YCC9+2wEvbo9nUYdg2yzDA=
X-Gm-Gg: AY/fxX51jTGhtZVouoihWMjekbRzKxoxMmlRZNDcvf/UAYftrdZCFq3EPiaC4jm8wKZ
	heuL9ZTkwgMAoZgEtq7wP+/sOrdpdmM5BxTVhL6LpaXfFbtmlIM0B8LPbhKELjX1Fi9pzo6c83E
	8d3px/+J+M8nghqrYIN8r5q9K62oGHFzvTghok1JUgcplIEHBOkjp/kZYniVLecYVmEXk57REus
	/CFm1C9yfYP5kKrelelhl4KpBCl4i7m+CCwX1kLe5DUIleiT2XthvKh6Z/wD0vYbsQEBJhNobp1
	hwL3rUXCGzwBCszOnPWHUvwM5lgJt2j9QQIp4nCH3//hUe6IsjYRAN3xrpV+8veO7qJNyLuK3RI
	ZiCJak4mnraqb7WtqcJGQRx1xU+2Ip96YXy4Qjex17Qo8GICkof5FtPuJDvYtc3jzWU9kCalNYi
	LniLFu7qM/HLehJsSyzsP+f/0vXML05Gq6qXqGjJ8QxcVrprfMniDeImjo8ea7ZdSh
X-Google-Smtp-Source: AGHT+IGWw8U+k36LYgdYkk6iGWuAwpG8wzSjetjI3XuEQo04K1yAeH6VmoQ0uiHD6viuJT3SSGuL6kp3RfNR
X-Received: by 2002:a05:6870:638d:b0:3d4:8f66:d05c with SMTP id 586e51a60fabf-3ffc08dab9fmr7155967fac.2.1768199636611;
        Sun, 11 Jan 2026 22:33:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa50f6a30sm2040507fac.19.2026.01.11.22.33.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b9f3eaae4bso157451485a.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 22:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199635; x=1768804435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=D3CQ3Mxye8QpcUZIhbG6wp4M0lYb2Ja3TYS0hWlLWGWeK2VuosaF3kOgrH50w+ZkQh
         iyVDyjmFecWmrkQmvkG6jLxDoL37g8RN4ABjXZ8dLd62Fi6y5Mzmn/h0TMf3q1bwnidQ
         FQ0F7LALUuOj2ExAkvj1yowUDV4gzpBbFLWfI=
X-Forwarded-Encrypted: i=1; AJvYcCUng6kv6qWk2k7VU1fjwZuVskYndX2hNoRG4DBa0MJGhSx/Bh2rONK15FmlZXoY7iwjfOo16iw=@vger.kernel.org
X-Received: by 2002:a05:620a:2886:b0:878:7b3e:7bbf with SMTP id af79cd13be357-8c38937a047mr1725531685a.3.1768199634868;
        Sun, 11 Jan 2026 22:33:54 -0800 (PST)
X-Received: by 2002:a05:620a:2886:b0:878:7b3e:7bbf with SMTP id af79cd13be357-8c38937a047mr1725529485a.3.1768199634468;
        Sun, 11 Jan 2026 22:33:54 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:53 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 2/3] net: netdevice: Add operation ndo_sk_get_lower_dev
Date: Mon, 12 Jan 2026 06:30:38 +0000
Message-ID: <20260112063039.2968980-3-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7]

ndo_sk_get_lower_dev returns the lower netdev that corresponds to
a given socket.
Additionally, we implement a helper netdev_sk_get_lowest_dev() to get
the lowest one in chain.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/linux/netdevice.h |  4 ++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3a3e77a18df..c9f2a88a6c83 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1435,6 +1435,8 @@ struct net_device_ops {
 	struct net_device*	(*ndo_get_xmit_slave)(struct net_device *dev,
 						      struct sk_buff *skb,
 						      bool all_slaves);
+	struct net_device*	(*ndo_sk_get_lower_dev)(struct net_device *dev,
+							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_set_features)(struct net_device *dev,
@@ -2914,6 +2916,8 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index c0dc524548ee..ad2be47b48a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8169,6 +8169,39 @@ struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 }
 EXPORT_SYMBOL(netdev_get_xmit_slave);
 
+static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
+						  struct sock *sk)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!ops->ndo_sk_get_lower_dev)
+		return NULL;
+	return ops->ndo_sk_get_lower_dev(dev, sk);
+}
+
+/**
+ * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
+ * @dev: device
+ * @sk: the socket
+ *
+ * %NULL is returned if no lower device is found.
+ */
+
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk)
+{
+	struct net_device *lower;
+
+	lower = netdev_sk_get_lower_dev(dev, sk);
+	while (lower) {
+		dev = lower;
+		lower = netdev_sk_get_lower_dev(dev, sk);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
 	struct netdev_adjacent *iter;
-- 
2.43.7


