Return-Path: <netdev+bounces-157265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E18A09C62
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4463F16B510
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A8217F26;
	Fri, 10 Jan 2025 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fIpWSx1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9921578A
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540782; cv=none; b=NLXjmrygogDXq3WWHYs4pEvP7wX4mnW4Yf2Ht79Wn/+iVvyPFIiugNf1RsvNJZ7uXY1h9ut4eVG5JKeyvixu6nA/CmHjPhO4RR/JD99LZ3VCgp7t2wR40fXAkhbL6Yymk87Wsg7tqmPUfdJQNETTD5puUb8yCPmrKKTLSz1zPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540782; c=relaxed/simple;
	bh=L//1ItUL/phY7fZdnQAHFMdHc+JAiSoz2Yj9uNn6Lyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqCl8bpCd67GFfG474ZfpT5hTjDKSJh7+fUJJYJt4RRiAlWhucTEX1/o57EaWEA5S51pghJwUh7M2yfj0vpuGHPE54Lj6QL5OLFMD0WNkz07RKIl30yDolP3l/oObyOnfDPdJNXuuymz6kMsKAV9xtBeHWgUrlVYvdBvpTqAa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fIpWSx1T; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21661be2c2dso40446085ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540780; x=1737145580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYBtxkIddVIdjfELPff+6zSxWcfnw5xo+urXkFqVelo=;
        b=fIpWSx1TcEHg+cMQTbr3vp2AsUt+f89yhfUWQDiExFbfNnVE+KyA+ink+4flsQysJ2
         wEUIDSJAbxWpFNBU+0yio3GyiQ3tHDKx963dnxYrONmqehce9qd2IsBq6nPLLsEoW/EY
         6+VwzmQIXRtrNTjXlBj5n9wi+mt5biBFc2o7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540780; x=1737145580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYBtxkIddVIdjfELPff+6zSxWcfnw5xo+urXkFqVelo=;
        b=Runcoa7dJPtZthDDav4syOEPx4Ygd5ZRBo5z7qaUg5O2zRjcmf+rAuwN9YoFCmn7W3
         BpbTwmkpJxI7il90NL21XGeuvp9KxmAzgwrPTmtfA0vjYBg7uhG4fXCNaVKUwvoolgOf
         ZaKC2PgA8W6HU9vOLfoMOHL7PdVmpmu9On6umFLS5GLVAp0N9fp5d0jKpL6mpwcE/rLH
         ORMG8DKcpSNrpK8VwjAoekVAvNoC8t7PghLhGP5CAyNBfz6GPnfqB6XkpPmQ9PsFDyLU
         I/DMRiYLIZiSg0qEyoJSuFufuqkIgcg24ZuGHoQTVdZ27GJHNYLd9Qu0JwK3IwZEDZWw
         GS2w==
X-Gm-Message-State: AOJu0YzSqQZ0jFVg6E1coAV6kPpjz5zfGLbtIxSEEIK5J6OwKgCBpx1E
	50MSd9mtPqunrCRjKvMaNjT39B7AouQTu4SKnG3EYfmH+RUOVtTS9pGtdrlp1x9VfzNFauI00Ar
	7HTmi1Mb1Go0irn2fYgt+5Lj5ZrlRaN6JRnkh4M5B2vrqR07t27S2FNgst9Y/0zbfpodc+rFz6A
	xTtGK3jCub7t8q62QBlgLHN0ZN+BjiDePUP0w=
X-Gm-Gg: ASbGncvb45mGMo5NkmE2dghDTpChz1UhF+jPgMGjv5l5QJ9rhr7/3ebmvJO5vB41nqu
	syplocuVZQMEHsf0Eiv7oPIFe1ehSb3UTrpb9rEUiqfEsPc/LtYtlwxlin8DBf8r6ZMmZs5nhir
	iZQ7io7nDFhmyC5W6jUrPzYkp7OsIvmts8DVM+aZux8VMHiSF4hcwIyOSRtkzvYj/MAJ8Y4Ax/v
	GfTpi4E36DAQWRF4Q+aAvpqeXv/8D6bpfj+VfiICyimY23amSX3xrbfrMIPAh4G
X-Google-Smtp-Source: AGHT+IE/1wk47T+YBogVHpi2dklAZot8YbzIIrliuB0Q46BizHw8aPtqwioCvHXYsjt1ulmmZpPd0w==
X-Received: by 2002:a17:902:ea08:b0:215:9894:5679 with SMTP id d9443c01a7336-21a83da498emr183024235ad.0.1736540779765;
        Fri, 10 Jan 2025 12:26:19 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:18 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/3] virtio_net: Prepare for NAPI to queue mapping
Date: Fri, 10 Jan 2025 20:26:02 +0000
Message-Id: <20250110202605.429475-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
References: <20250110202605.429475-1-jdamato@fastly.com>
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
---
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


