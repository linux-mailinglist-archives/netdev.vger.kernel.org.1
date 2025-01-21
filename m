Return-Path: <netdev+bounces-160120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFAA18581
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A745C188B90B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EFF1F76D2;
	Tue, 21 Jan 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mW1YJNsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DB1F76A6
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486673; cv=none; b=rcuyRnfgjxp5wkHrfj90nMpZLYOtAz6yCsKkFCrZe/bZbztClPQB+gIBfjmzGE2AgfNe+0oIu61gy3LN+eNiYldNNUyI8+aLvbSPO+GaIkZ2oMtfkMKPjojowEtwZTxTuq8euRKcDXjlpCYu+MzQaE7e5EUbQ+LWQjhwiheVo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486673; c=relaxed/simple;
	bh=QoUuXeDBulZSbVMdrI5zM6Eg9lCr5hgBtBOzJbP8zEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxjbpxDjkofaXxthyGv4uVVTDUNrXqpi7I15rA5ZYfOZhamKoZfrnxSCHwUtC2t/iPJskHMolQlAzshAweWb5LqIu8yqzD0EnhalNBTNr72qSO2Nh5XhBhEGsqcF8s/QmcIl0gSl1vBjxjlmo5fgOAndk6hbyfyATco1Zh26Rd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mW1YJNsK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2efb17478adso10409961a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 11:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486670; x=1738091470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=mW1YJNsKjJg3HwaDbspcfvC0mniLoI8kV23X/hka0pO+ouLoZml9Vs7ap2X1XJHyZv
         fUMQGuk1ERBHcgg5+lBnmOwUNKXzD5EmnjyPV9Kz451uNgEqY3bqpKUhJNrqgxO0288+
         eE9MkHE8xncJh6i0ATwM/HN9Y6Y9pdaBO3eVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486670; x=1738091470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=aQ0sSw1akY64+LduiBJMTxbVPnblhduA9u08sGCYzmQJ2eNsbPne6vywLXtVttAH0v
         bHKIGC/zHff9L0OsoKVNNuCqMPRi8DbqIQtVmKv7KcCU/VqQhCGIwnNXw7z5a9+Ue0+r
         URVV11gDfFuTnDCGEAjL1jijG/UWqbRIVvpr/ZFRmcjadWAtQe0SKVhJECCkYjNcQBMf
         GQiJXEHLwEPlF5JPAqeHKeimzu++zoA0tW7UCX7hhA8jPpXEpaNhyMukhvnMZ1EZ1EjU
         KvWz6xJddlI3d63cQ4no4VtycCUAXUF/EA6apzCE0W5U6/Fq5Bd2DXJOdbgM/u86xZcG
         v4JQ==
X-Gm-Message-State: AOJu0YzbbHdkzzNjhRriOss0ifLYbWv+BC8ixxGcUu2AdY8XQX11L+Bb
	Z7ITf1w2DswRiS+9RYndwnfxOIB5g+OZ6mJZST8DOMVi0SIYARsNqOcCG458hyjuXQqdHDqv2qw
	pZ9g/gmcKEQAdy9OOQ8TK2tS2Zz79lGFQph097hy3JmsrWWlybs8KkDZAqFtLzaXevN614b88ro
	jGFcuQPCFcpMmwEGJBuONYKZo2fsJ/fQoYAQg=
X-Gm-Gg: ASbGnculRhHhPF2DBtf3z6Br5zfYPaBqmzE7NGOQKWdIs/6hfXPl8mtLE9+0NuUcNYc
	+8tzDNFrU6Wsj5yvf1xloYsvq6t6YIjRMacq5nu75YJBhEdVMlLn7YleO7+gC9iOG2O7msnsywZ
	c6t3DehLPfq0p5dS0j0chsk68FYkoz2cCI3Wre1+tOi1u7OsoN9BbB62CWYfn1OCh9ePkk35HfH
	iAl2IKy+evUbnoRh4kW9pCUTNRnBEddNc5ZhxKj8fvFA4z97KsPbwCv8ql9nyaCuyh0m6LVFi3m
	gQ==
X-Google-Smtp-Source: AGHT+IE4irALDUjtpmu8CkVPCmQyuHgMI1XADWpZWozR+u77nlArMTYTrKbNpUm0btjkrguF/oTbgg==
X-Received: by 2002:a17:90b:4c06:b0:2ee:7862:1b10 with SMTP id 98e67ed59e1d1-2f782c701f7mr28198326a91.11.1737486670370;
        Tue, 21 Jan 2025 11:11:10 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 2/4] virtio_net: Prepare for NAPI to queue mapping
Date: Tue, 21 Jan 2025 19:10:42 +0000
Message-Id: <20250121191047.269844-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slight refactor to prepare the code for NAPI to queue mapping. No
functional changes.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 v2:
   - Previously patch 1 in the v1.
   - Added Reviewed-by and Tested-by tags to commit message. No
     functional changes.

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..cff18c66b54a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2802,6 +2803,11 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
+static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+{
+	virtnet_napi_do_enable(vq, napi);
+}
+
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 				   struct virtqueue *vq,
 				   struct napi_struct *napi)
@@ -2817,7 +2823,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
-- 
2.25.1


