Return-Path: <netdev+bounces-162195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBB2A26154
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442A81883DC2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2F20E00A;
	Mon,  3 Feb 2025 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ec6S+1SD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632D20C489
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738603305; cv=none; b=r1GM0wcsQC9XVGAK3yroFNbkkc+AxcaER8Pktw7+NDx4k6VsC9scn3v8wJZram3XjH5DVc8u0JajVXfNfXB9wSb4E7Sp4TpbTxbrTW3v6NZCmooOrBVqFE/H6S4Pz3XnlxeeUWk7IGdS2y+4tK5wGxD9k3n2tMvskQIncxTA23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738603305; c=relaxed/simple;
	bh=ciyGHD8tJgE0719gB9W4nr3fJTzCtQVz1SuDDXmPMsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NAaukNgKE+o/3v6ffzFrkxa+oa5/3mcMRyR/Xbj9FDu91vQx1tlJqLKTqxrEdX8GPlV3MCfrdTDsL2Hm8VAUNAwNRv0cn42ZSLAasL+KYTlNgMFCcW0Xquf8fctzr8MPXxGaJiNi72nZ3JPF9paLsh6+ZBSOXZwDekX+mKgKA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ec6S+1SD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738603302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BecmRwgkkfIrY6mFGABFYaqCmEAWYaMsDr4FxuMMJWY=;
	b=ec6S+1SD+GJBFzqUGCRzyEI667/5iDMbev5mJb+KQGdt3O9jQQ2MDy/uVPlstZzhICl7hg
	iGBOTjhHe0jPzDJ/6wSY0Ldbzzdka3LoW/qheGOR1XwRDR2s1FjoUHG3i4HEtA1dOOB9rl
	Gpxgq3qk8OLy9DzT33y1K+cc2MBFuqs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-b-mzfqUsNZmQ3oXSsuX1rA-1; Mon, 03 Feb 2025 12:21:40 -0500
X-MC-Unique: b-mzfqUsNZmQ3oXSsuX1rA-1
X-Mimecast-MFC-AGG-ID: b-mzfqUsNZmQ3oXSsuX1rA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab6936cd142so440369966b.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 09:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738603299; x=1739208099;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BecmRwgkkfIrY6mFGABFYaqCmEAWYaMsDr4FxuMMJWY=;
        b=Gdj04bZKCwv/zrI0bbSIzYOnOrRf1zOPOrNATJ/yEKZBuIms7o7lJCKaM9q38M0OBY
         2biZcCEsu6qJ+C53v59CpICu6d9c57dHD9BFz20qZzyoW7TyEoFGEUifv2ykCkODzsRU
         V4p/MsQckA8fTm3BaGLlZGxjEEICFezxiftSKeCqxsc1qzbwYLOEaJ/YyJieyQol5fLD
         gLeOr/TdwZ66yu9Zjyc6qv/jeG2Gnjho+J4CrmN6H4qeb/o26ZbvvcB5NIvjTy/XIEH7
         93iwzX5aH6ODlWm283upSqGJ2MlSMGn50YkM+zQNE1TtLE6ZuJlzUUgpLo1f6ueOouiY
         ffRA==
X-Gm-Message-State: AOJu0Yzp3mIE4GJMD9urOpsLYXgVEZNxLuefmGjWewkmVZi/jV56cOAz
	ly7RwXbfbCVUI/3uUNumdFi12sTK9HQMQDwSJ1/HmmEH1epyFUbfvVY7p2z4uDSVG38niDdnkU3
	HlLERuXqh/5DcGHZUjW2w6BSaxoh0ZMCMSDkOs9xr/As0VMJAGlvsuwA8WPRoTg==
X-Gm-Gg: ASbGncu3v4I+QFxKu5JzdDRz4oBPKKq7mqfj/9dmRBe0vNNQ1wVLPj05t1fkV+Ltysq
	ONtRl8xGqu1fd0ygtHAAwGQfMcILe3LA76DoNilXqXdwXKW9Uj420/5EVFuPAGmPU1nbno6hx6/
	JHicdrghaX/KHmvBqjH6JG/Dzsav3zP69pFH8RQEvcbzMn7B1kB5s45FwX5y5APw2W+33VDromz
	qNeCm7Kj08DenMEQXZ5E7/TVYJOdch2bghbrpYAZiXuugOLdXxpbdsnlEffzhnu/Fk6m9JvQDxN
	Y8aWH/nq5NKxG+384RoRKlTiUv42WA==
X-Received: by 2002:a17:906:7316:b0:ab7:a50:c250 with SMTP id a640c23a62f3a-ab70a50c3c8mr1047885566b.35.1738603298944;
        Mon, 03 Feb 2025 09:21:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJLABppt7COsJiHtQsoFZMxksV1azWdOfUakTZXhjY8bG5dtFQzJPXLv/j3/m4jevXyiJ/Rw==
X-Received: by 2002:a17:906:7316:b0:ab7:a50:c250 with SMTP id a640c23a62f3a-ab70a50c3c8mr1047883266b.35.1738603298573;
        Mon, 03 Feb 2025 09:21:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724a9f90sm7841623a12.62.2025.02.03.09.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:21:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 664F6180BB70; Mon, 03 Feb 2025 18:21:36 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 03 Feb 2025 18:21:24 +0100
Subject: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
X-B4-Tracking: v=1; b=H4sIABP7oGcC/x3MQQqAIBBA0avErBNUEqOrRITkWLPIYowQors3t
 PyL9x8oyIQFhuYBxpsKHVnCtA0sW8grKorSYLV12theZbwi3oV2dSLvc4iRlUtL6HzQvXEeRJ6
 Miep/HUGAoHrB9L4fsh0T/W8AAAA=
X-Change-ID: 20250128-netdevsim-perm_addr-5fca47a08157
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Network management daemons that match on the device permanent address
currently have no virtual interface types to test against.
NetworkManager, in particular, has carried an out of tree patch to set
the permanent address on netdevsim devices to use in its CI for this
purpose.

To support this use case, add a debugfs file for netdevsim to set the
permanent address to an arbitrary value.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/netdevsim/netdev.c    | 44 +++++++++++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdceecbadf27f7090c030aa5bd240c18a..3a7fcc32901c754eadf7d6ea43cd0ddc29586cf9 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -782,6 +782,47 @@ static const struct file_operations nsim_qreset_fops = {
 	.owner = THIS_MODULE,
 };
 
+static ssize_t
+nsim_permaddr_write(struct file *file, const char __user *data,
+		    size_t count, loff_t *ppos)
+{
+	struct netdevsim *ns = file->private_data;
+	u8 eth_addr[ETH_ALEN];
+	char buf[32];
+	ssize_t ret;
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(buf, data, count))
+		return -EFAULT;
+	buf[count] = '\0';
+
+	ret = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+		     &eth_addr[0], &eth_addr[1], &eth_addr[2],
+		     &eth_addr[3], &eth_addr[4], &eth_addr[5]);
+	if (ret != 6)
+		return -EINVAL;
+
+	rtnl_lock();
+	if (netif_running(ns->netdev)) {
+		ret = -EBUSY;
+		goto exit_unlock;
+	}
+
+	memcpy(ns->netdev->perm_addr, eth_addr, sizeof(eth_addr));
+
+	ret = count;
+exit_unlock:
+	rtnl_unlock();
+	return ret;
+}
+
+static const struct file_operations nsim_permaddr_fops = {
+	.open = simple_open,
+	.write = nsim_permaddr_write,
+	.owner = THIS_MODULE,
+};
+
 static ssize_t
 nsim_pp_hold_read(struct file *file, char __user *data,
 		  size_t count, loff_t *ppos)
@@ -997,6 +1038,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
 					 nsim_dev_port->ddir, ns,
 					 &nsim_qreset_fops);
+	ns->permaddr_dfs = debugfs_create_file("perm_addr", 0200,
+					       nsim_dev_port->ddir, ns,
+					       &nsim_permaddr_fops);
 
 	return ns;
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index dcf073bc4802e7f7f8c14a2b8d94d24cd31f1f7b..fffec5dbf80759240a323f7c3630c79c5c68faec 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -140,6 +140,7 @@ struct netdevsim {
 	struct page *page;
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
+	struct dentry *permaddr_dfs;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;

---
base-commit: 0ad9617c78acbc71373fb341a6f75d4012b01d69
change-id: 20250128-netdevsim-perm_addr-5fca47a08157


