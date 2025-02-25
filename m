Return-Path: <netdev+bounces-169271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC7AA432CF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7ABD189E4CA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D11632E6;
	Tue, 25 Feb 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SeVNVpXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48197081B
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449119; cv=none; b=e+kF6T60z7rCnIUYA+O6RAOp7yaI977r1NvE9KetPbalF/BlBSqf272kFLo3xH1+WSP63FI71dwKGJkvI8/TrL3jBK6M2Ez2xcTOSFU7fWs00cgi2+9+rqJUt7j3uFCri4MQC7iXPUxvgyt1USIH1GDBbKnbb1ysSFVhEawBKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449119; c=relaxed/simple;
	bh=sqHw+hydx5+J+3nTg7GiF/z4kDtuYCJJCVEcYQMUN3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9xgwTaZA1Q9M+hkkfvQIm0hG0265fOvreuIjz2GbMr8BmEwHHSIq4HbY4q1/Z7GK2QY7TZhxthn6eVB7nLDPxUyIhwhcLujay6555w/oE0m+S7M3dwd6U/AMAjGW1tJ6x90sAKp6jVCOubuRBJQ8lMp3JuW0stvaiDFC+ETAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SeVNVpXz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f4dd756eso105245225ad.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449116; x=1741053916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jTrPXbJae2NFrVRDORH6UMqB3L+3yI0Uf5GqI0AUQw=;
        b=SeVNVpXzBVmWL24GcetM5Sq9Fmxm4MTy37KknoKqfo5uz6UzqUGpwtSyIm/7WLmRsg
         QhDzFre74qNDcOkHjyAfLiVs0BO5XF/gn0zjMmxaWMINkhXwgAd+j35CUtA/CUj6CWxR
         GGWZ5dTw0Hn7mHgDI1+QxSJ657/ymjj2DpgwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449116; x=1741053916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jTrPXbJae2NFrVRDORH6UMqB3L+3yI0Uf5GqI0AUQw=;
        b=jINXRmetZce10ziODdtFBduInknHDMCW9CknUyI72S3Zd6qkN6voP2nLqDd0ozvhD+
         YhCrcsuCM+jNV/aInEpDFF2pGUo/RKHJOp1LlUZQbDg7mcvpptp/meGdMPfftL37RWJt
         GoKg4emavhDyLk4FBWjpJ94ftNTFXYfJA+QNIQfh1Zz9wR4sJoo6pq4EtQApDmfXN8kS
         WOCAsqj5V4TRZeLGDd64stv6bx3+xCo/sESbqCjMOL31Gvs6deBMkDOGBTge5hH4vFA1
         3p8bUgNpDzvo6j24nzLfvxg4pqJG1JmIDUXTXzWfFy8wvbK3sWbSfN6jd0tLl7XAKTJi
         /YDw==
X-Gm-Message-State: AOJu0YygNqg+s2Cx9f6qaBWM0CqTBCQmwBomO++iVjd0XrUgJyX9CQ99
	Z9xQ/lEWEvqUsbycuDeSvj0uz7fX1ljOh2UCthjP8raDlfrL/on3eQcFvNDccVWpQTZGEUoVaxY
	RrvM2yjlhLGYpyKkqZ1sDT/eHCCieLc/w5bdW0At0YKaSqTfN2X96DsOqQ1qdwfx1IVscLGxwum
	HzkfyTVFpba0B7FqtRmjfBVO3yFNQV31R08QFnsA==
X-Gm-Gg: ASbGncujxms+m81jhaM7vwCw/ahOAt/ijFC8rZMpF9z2h2fCZ/+j16Psat6BNMrBZ5Q
	Z67rE90drjxtPV4txD5C5NwdZRUEKTdJRgc1KmRvQuShkJ/IPweVfTVuLkcFrZ1x+J8isLwhuTI
	X/e0TMPGQLwjEmjxZR6/LvU3W0wroi2ryVPLYnqaItIactMPznKHptAVyR5TTDlTiQiSG8Jld1F
	L4qjFylJPen3tChVO7NR2Np7OlXUoLqDWaXSOTF4aH2BBQdSqmmhz55io4S0c+f2Zf0Wi9Vw0Ds
	2Yv0OjIRuXwDPASRbLTJmntBxPKXgX/e0Q==
X-Google-Smtp-Source: AGHT+IGbedvJQbC1f3rBktTR2fDXpQeCE8dIxMRlL1M+qlTRLacNZdzhniWMjgESJ1sAs0pz8D4XNA==
X-Received: by 2002:a17:90b:4a41:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2fe68cf3fc4mr2493123a91.24.1740449116365;
        Mon, 24 Feb 2025 18:05:16 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:16 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 4/4] virtio-net: Use persistent NAPI config
Date: Tue, 25 Feb 2025 02:04:51 +0000
Message-ID: <20250225020455.212895-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use persistent NAPI config so that NAPI IDs are not renumbered as queue
counts change.

$ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
Current hardware settings:
Combined:       4

$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Now adjust the queue count, note that the NAPI IDs are not renumbered:

$ sudo ethtool -L ens4 combined 1
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'}]

$ sudo ethtool -L ens4 combined 8
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
 [...]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 13bb4a563073..186030693eeb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6454,8 +6454,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
-		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
-				      napi_weight);
+		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
+				      i);
+		vi->rq[i].napi.weight = napi_weight;
 		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
-- 
2.45.2


