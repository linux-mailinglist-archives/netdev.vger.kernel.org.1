Return-Path: <netdev+bounces-176680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B55A6B49F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E736348592A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD441EC016;
	Fri, 21 Mar 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rNASNJcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C81EF0BA
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539759; cv=none; b=WwbzBgb9YrdfKEJ7g89WShFDGsmOiLNzCRfSpTGGNlnuFWyYPNatpTG7y4HkySlpGhZ8yQcGrslRhXOPW8amUg5BKglUujFIo5LXUkdc4PZvJT6QvImLfuGSBRC60KCLalDRoZJCPZy9P6900+dz9K9bsFUKr4it6/gGi4A11IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539759; c=relaxed/simple;
	bh=9CUrz9dhvu15FJYjSA2vyaWutvF8gNFVLxLx3NxqRDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1/WF2JhXy9K5E/HeRrDpXqrcbbmi5eWkYiwco+WOcUEY1avDs2mpWLfXprArWeeOZadVDz6mMmxtrE1OxQMVQnr2xKzOUZp4Mc9FasyNjkHyoNYUWQKf9p8qx2VIe8j+U/qUL5t7sVtiPkDGa4xQ6D9msKVoQH9qWMwtpvD0GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rNASNJcQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso39241955ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539757; x=1743144557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50SxeWFRe74DdNLvKUCrTVWbecxWk/tvvWU0un1oLD8=;
        b=rNASNJcQKx1LXxq9KSlD5IcbqCzOKA1fC0dbCdndUZ+60VAcRVfzcOP7xYAqgeTols
         rhAvFaIUg6rvuagZFAmkOwvNvedCQrPrc46SZXMkpkaPqgiiYLHldc53DHUwQDptESZN
         h01kFl0hMTU8kWJv4/vUdnqWhwgTRzlJqhBWmeNjxMiOobKVvEjR3iOfvBq9fL0/XdTv
         KnMpZ7AUo+Fq4X9ghxZg22Ttssgz3ZwCKfFihT6gbIh1tAN2SYQ2dWfkvLlfNOvDdsaT
         uagFyzMqOwZ++bswBrPHwpWStP3HeTRCC0Nhy6Vf93qfdOgaVcXUDohKkF7mtzui0OMw
         sr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539757; x=1743144557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50SxeWFRe74DdNLvKUCrTVWbecxWk/tvvWU0un1oLD8=;
        b=V2fqPxwisEL6JnEMIGJhF6Y5b6FPYXTr/wOHFHkheiTnLjQ6kue9Nztu61NU1HHhAX
         4btMFG40Q0iUqoIONCLjAzSkTWInynlFPZYZh+a8+/ZDoW7G3UPRmMEFe+RrBK0KiF0u
         dkH6dmMQFMdXzoGRQafYHFG0/Pe57PLKJgljLPe8p7cl9iHOy1e3sDQCZsyFzZ9I3exN
         1l3wpYe/ed1PK0kB9+DKeVh/VkdzjBFb2/jQq8nKF0H0juOttw4qXXjBm6gwvDUtV7X/
         mf1UfkOoNwfQOr4DwFUJF/n+6mORNcpN1CL1okRbjJP9GF8k21+vrMYPp0QBLzb8fgOn
         wN/g==
X-Forwarded-Encrypted: i=1; AJvYcCXYZKR/MuMC4vZe2/ITppLQQ0cbgxtjwe5hcObMWtpaCk05avaXfwwyoGHu5F6x7B2cO6lI5Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG57EshSpZyWXfRRcsH4SOZvOp286tO/vrw3qHh+40M56cdHVc
	nqDR3sfy+Xyu57WxD1ulBb4Z7PC+kQLsBGUpF0w3qIg9ZYOPpg8wrfDCnzWNikc=
X-Gm-Gg: ASbGncvfaNOmpT3QTSRSRFjnP0RVH3fEn+9bMxaBN8t6Rf1EDaYgDWXmbf2/nShHyFW
	Wf5MAPYheivjiG5DDEiXStiz7TQNwLyBZVxSs+g6SqmawqWajHqFjDp4Jb+pcB4M7uprs+WT0M/
	I8ua+9XEdnIgQljsW6Hj/QXPaGgX1EmxbMpdAUblYAY9tUaDv/pLiEQ00DfZ9fRHPh2usKNXla9
	cE17K/eJCYZL/cGEViZHr15ag/+bGh6qv+uv9e0rriciqgM80oIxLr1fDO1fphDpopsXYwsrE2z
	76FmLVGGNqEe6CnDDq48jTu2Rbseq7/4HWRe6gKL0QvcTSVG
X-Google-Smtp-Source: AGHT+IF0uHlKSVlfre+IRVuMyIVROaUprT3kAYWQuGSmWoRdQtDg0pKD8EXS5S828nJMT0659WKQDA==
X-Received: by 2002:a17:903:19e6:b0:223:397f:46be with SMTP id d9443c01a7336-22780e19bbfmr36357865ad.47.1742539757618;
        Thu, 20 Mar 2025 23:49:17 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f807533sm1080930a91.49.2025.03.20.23.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:35 +0900
Subject: [PATCH net-next v2 4/4] virtio_net: Allocate rss_hdr with devres
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-4-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

virtnet_probe() lacks the code to free rss_hdr in its error path.
Allocate rss_hdr with devres so that it will be automatically freed.

Fixes: 86a48a00efdf ("virtio_net: Support dynamic rss indirection table size")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 570f77534dfb..6efec9c50b25 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3580,7 +3580,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (vi->has_rss && !netif_is_rxfh_configured(dev)) {
 		old_rss_hdr = vi->rss_hdr;
 		old_rss_trailer = vi->rss_trailer;
-		vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+		vi->rss_hdr = devm_kzalloc(&dev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 		if (!vi->rss_hdr) {
 			vi->rss_hdr = old_rss_hdr;
 			return -ENOMEM;
@@ -3591,7 +3591,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 		if (!virtnet_commit_rss_command(vi)) {
 			/* restore ctrl_rss if commit_rss_command failed */
-			kfree(vi->rss_hdr);
+			devm_kfree(&dev->dev, vi->rss_hdr);
 			vi->rss_hdr = old_rss_hdr;
 			vi->rss_trailer = old_rss_trailer;
 
@@ -3599,7 +3599,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 				 queue_pairs);
 			return -EINVAL;
 		}
-		kfree(old_rss_hdr);
+		devm_kfree(&dev->dev, old_rss_hdr);
 		goto succ;
 	}
 
@@ -6702,7 +6702,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
 	}
-	vi->rss_hdr = kzalloc(virtnet_rss_hdr_size(vi), GFP_KERNEL);
+	vi->rss_hdr = devm_kzalloc(&vdev->dev, virtnet_rss_hdr_size(vi), GFP_KERNEL);
 	if (!vi->rss_hdr) {
 		err = -ENOMEM;
 		goto free;
@@ -6985,8 +6985,6 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	remove_vq_common(vi);
 
-	kfree(vi->rss_hdr);
-
 	free_netdev(vi->dev);
 }
 

-- 
2.48.1


