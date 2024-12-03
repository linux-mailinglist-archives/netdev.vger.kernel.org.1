Return-Path: <netdev+bounces-148387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D769E143B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E7DB2693C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4931C6F56;
	Tue,  3 Dec 2024 07:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="og5pTrpR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2F1B85EB
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211068; cv=none; b=oN2QLdQ0JuRZIbj4OEk8eVlwqhAm3ZXF/5A2UgwrMJVAXmrUvhEweSgJFN1fFl9szOoWVBlhgwtKtAXqPcrOinmZcO1nczpR8l+t8Bfp3EHDKgvDhTUqHeKFDXI3ZhhTUartAdwfhY0SJ/KQ4xgIHx2SiOboBenVBE7+/A6deUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211068; c=relaxed/simple;
	bh=ONGQeGV/Lo+dvZaz/MxmBnTpy+k0yha3gjPk1y+HOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwFfo9Hj8+PTWK/qskzIPO4vH2n+Je2GlQx+rwQW7IIetVEFVMcWuoyyVq8+/mWCEpwr6Hu+0Tdij42YkOdZrk47vjksJDpHu28yQAq+iIs4cEO0z2BozaUQ3kAbx0YkTZ/u6cs7jf0z7nlEy5Rjqz7lMRe9qNVZNLgE9ZtuU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=og5pTrpR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F3A443FD8B
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211065;
	bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=og5pTrpRvLJr0XSW2GAPqyptSvzFiPq9P25nRwiD6RklmYc4qDy4rvVU9T3KAfj/x
	 Kof18ZoRu2x9ict/CHI2zJFFgFlnisNZJDC5EBmFIvzAp3IyH/I6AnGj6wQFPR8q1w
	 zbXemcHYEdDkJS1yXV2fTgikPPjukJndYPlIPy866fkR8/bemteoziajT0nGS1brC+
	 Ih4il8+C72+0fyb+YPTyc5qnsfMHHI4OkkyFX3QeTY3HbQ1wShBkEjDA58NiYyloHw
	 ng8xxkWAkYp3nJ7RNl8RLA7S/ixHNBID+0F0F7RXLwqWJMomQZt58oZk2zSkT7n41Y
	 fhH5R9zpnNlbA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21567f825d2so25688965ad.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 23:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211063; x=1733815863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
        b=CNBy5h8Y68vO7WMeTKmpybPGeJ39vu9vfi1o/njGlezDlzLESXmGfYhoRpmKLwBAr4
         5QSae56UbErI+6m4IGY0YUD7sidnb7Dxl3n1X8vQ/qk79J5qD41IZaAiFJ6kQ1+iCzFf
         LCjXiryL3/WKVkerhm7TMtd8CkXDYPS+oJ8ssjEK9zpkoWMVDG596qWYHItuiBcYYXak
         5zFPn/G19OzSWAzUd6sqZkQVEdag95/R73Pze3wdr/SJIqax+sI/xduiUHkjdP8fo06J
         7m/Fnjl3WfbnVaWyPHDnq+Sy0VZg629KN3gw7XntQf/+ppJeGoguBLUhDuHmCFYFRRlD
         2rhA==
X-Forwarded-Encrypted: i=1; AJvYcCU4ukNGaXPuA3OYJg8S2iPVGkHfxsegO1FVICexL0uDYQAGiYjr+T1qSpzq9EnWjkI6w63PqP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgGLD0QrfGwdZqqA3FrVbhNoqqb+47JiLsSoMI15AH3tUFgwl
	Y1wJeMpuH/1dhVFC7uIpYwjMCMMWyWLGGtRFdE58vxW3asPC3c+0rtLt3UHJHAfGAQ5n0d4ihtu
	cYcDWxulgvcAEfL1aMXiqpCQU5cs4m2rL24eyU8+HYSLbD2IpQhfDpwcdIyKSylcq81+lPQ==
X-Gm-Gg: ASbGnctKR8MjPHPk07TKtqdn27FuzIUNXSrueR15CX4yP3PDqFiC9tB6RJRsJFP0gJm
	uMNswVKh13TrHsB5gEk8o/9VplR8L8UDuLD9evO6P/v1WqBBiEstzp8Nl9fY3Kbs1mmaUEC0f/s
	3UQ96ag9J0HT3fmU3DC3m2D36bKmJgHcLwYxMHi46/HtQf9E6orCLBMJku7meEMsgKhOT5Peej0
	+l/DNlAHVk9Z/jqnvtgMJKTxSwP3KPfD7gN2c4TLN91Rm7UmvhSKKMDKRTO4kyJTGp2
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893655ad.53.1733211063422;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeKLM2ys5e0Q3udqn6af/fNUMQYdUmFkZT/mCzd4RS2FR0h2mYZFsi+zEkr90jaY94M2UwGw==
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893465ad.53.1733211063136;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:02 -0800 (PST)
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
Subject: [PATCH net-next v2 3/5] virtio_net: add missing netdev_tx_reset_queue() to virtnet_tx_resize()
Date: Tue,  3 Dec 2024 16:30:23 +0900
Message-ID: <20241203073025.67065-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
be reset.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df9bfe31aa6d..0103d7990e44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3399,6 +3399,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, &flushed);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	virtnet_tx_resume(vi, sq);
 
-- 
2.43.0


