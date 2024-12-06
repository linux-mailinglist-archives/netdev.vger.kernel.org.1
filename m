Return-Path: <netdev+bounces-149553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6199E6326
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2790F1883D09
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32211865E2;
	Fri,  6 Dec 2024 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rgB1jWUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E26156236
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447531; cv=none; b=e2vXzaadXA0oss+tVwrDTgcwnPeY7uioWCALh5ddWhdGKA1qxf8lWX4P+7Z3Tuzh+UyIU8dwPqQ1KWlTJXjpgYMl9cw72R/2Cs5TdzB5CWsTycNTRW01/pzk6BZ+uKOs5JXkFdv7tD/xsEYUIQxinBRt9vnK9Phq+DjjJDrSw6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447531; c=relaxed/simple;
	bh=6hQW/GNmPuXyiRMQuoJ6EZUo9ki9tFcrjiw8b7LwAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPZDgXjxPreF66ikK5ACVKos0tp//FTtvNvVa8GmKoB0Zf0MD5j9jKiXB4Jk1HBYu51SQopoCpMv3zpi7FmxJ0vvVlOiNYKy7idfym8gELvgAsYjufaNT1LvtRVnm6LQ4tg5RxogJLjBvsl4mPpSJGJ3UWc/pqfD1Cy6aUgSwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rgB1jWUd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A12753F767
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447528;
	bh=gPawsTtuEBPD/KPKBNzHBHV5THR/q5cTrBGd8UniWNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=rgB1jWUdz9oWqyzNLwjxgaL/yyEMQNUW0WXxGV77IDk6tyO8oJ985gGsHzjCETp1H
	 zWhguCVwJlc8V3RcIZ+FjGOuWLjbB3SUGsIpDEZENhepu1gON9cR/9EWuYyymJxIjU
	 nN55ZeRSo9Hcj318+dU5KuO/m9aFiZ+BPGUdhATKqe8rmk+aooShCY19+WEQ3R9I0a
	 FmpBxTIKkth/eEhj6gdc00uPctb8haQf4G3PePHMfAN1v6FQ/AjpRfu/YS7pi0Kjq+
	 SaUVAHqBz6uSLBL4/PrhzMBLwIy5FQ8HaclFfSYnymnhA+3akXq5IH9h+R0ZUouoHW
	 CjZ374EvabUgA==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-215e2f27b23so14149075ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 17:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447527; x=1734052327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPawsTtuEBPD/KPKBNzHBHV5THR/q5cTrBGd8UniWNk=;
        b=tABGkgUxaYE+Wh10u7bRH6w1S5YqtVc0eRDQjPWP1tCzS7BOq6G1Omgjryzjc9RSau
         SzltKxkpL9UU4qXcwJ9Wk5tHFg7XOd45YPHAGFs6/QTi927RpxsBIXnyJ8zfEuCluz1i
         xsBiO5CfyBh89WTR/GKzdqXSYwdQt6IdODF54cwqV22TWA8a8zr5E62sx8mDbmxIB75q
         Trf+kcFmqx+VWvgCZoVS1q8ffswzYG7W+uy18/UUsqDLM+M+Gg66e0qxrnPTa5vedvD+
         kOvfV5ErI3wIv4FYCEMawB2VAIZOk3gL0gQ1fenIEM8NXLwTCbxXz1glmMI1eksEFmYi
         IZsA==
X-Forwarded-Encrypted: i=1; AJvYcCVUq8T8yqotjeRmt/9l5LQs7oGBpr2/EL0uKXrSgQzIM5ciJsJfcUsdoT8Evy747BqQF8pq+wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAih7wpOFI2aiEhLAIQHRfDwj+t+ziReaKXsglWRyq96V6gDtY
	rKfCFcW9QpCd9m/kb8F015DQnqfAIISALc8hOWXs6SQDCvHdP1ydsMuu+sCn3IS6BfAOf/Qs5ba
	gvt7/rdzEKtqlutZ8DHI4rFeN2vlFLdbB7PdISrdn1YJckyKrOfWM62R5hAaeJbnvfwnWUQ==
X-Gm-Gg: ASbGncuw2nWxUgLb3NLjHgPtVMm0218F1ZD5bkYq1I0XmbqCDwRBeGTuewSvDm/r2PH
	zECQ4TFqOjfPdyGzGrsw3qhSVyjTUBH9X4EyNeGZ1v6x3hb1Y6DAHjgg9jIpew/H057TEqswGza
	M5g+f2NUWJv0sIrh1ynDKZfDBC35oRc5h5tRZGwAFtRzu0UDyxEcWmL+gL0tx+xyNKtD2ZNdtrm
	kAqpfxvhJDXvuek2ikJjIzZJVq2jWzRufk9OwTvmX3fPFZ/OP0=
X-Received: by 2002:a17:902:d4cb:b0:215:827e:649c with SMTP id d9443c01a7336-21614da98bemr12028145ad.37.1733447526978;
        Thu, 05 Dec 2024 17:12:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3hKgEtavuk/lPGuhbmEd6DMI7J2o7R7dxsGfXdXbPYpoB50i9XnBvW0RBnmyBI3MXmGOMsQ==
X-Received: by 2002:a17:902:d4cb:b0:215:827e:649c with SMTP id d9443c01a7336-21614da98bemr12027965ad.37.1733447526722;
        Thu, 05 Dec 2024 17:12:06 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:12:06 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 6/6] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
Date: Fri,  6 Dec 2024 10:10:47 +0900
Message-ID: <20241206011047.923923-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_sq_bind_xsk_pool() flushes tx skbs and then resets tx queue, so
DQL counters need to be reset when flushing has actually occurred, Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_resize()
to handle this.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5cf4b2b20431..7646ddd9bef7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5740,7 +5740,8 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf,
+			      virtnet_sq_free_unused_buf_done);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
-- 
2.43.0


