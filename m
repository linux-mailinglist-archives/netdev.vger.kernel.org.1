Return-Path: <netdev+bounces-148811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53AF9E32F4
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B62C28543B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA24319004D;
	Wed,  4 Dec 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b6Pa6F09"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867818FDC8
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288906; cv=none; b=olCceRm3lxFpptMyAVbOPiaGAmhZTX82limsTtFdMKL0hQjC1IAs5QyJ4s5u1ytMoprr7hSf40/rnaXpm5zAw6h+jVCMhEHdjc04SCnxTL/06MKq8GJom47rXpdUT5A/mUfZdLcYk7qWuVdNWwK/LhmzPuXHsphX46iHNtVz6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288906; c=relaxed/simple;
	bh=pJkC/sg81thrf+L+DBV2A5EohoZuMx0x87sK8yW3WmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwC+wmJq5KkG7a0RNjo8a8I87rXt0iwZX9YtdYueYj49zG73/jNNsOuI6DU9NqhqtsS9Hz7TGTnWwKXE7ttowHI1CuourtoCzRUYL9GKnqX8m2UfED/MXycX1Dz2Tmh0YLjeHsl5LZp0KFfcl7Ed1GiTnG6O301CFnDAmZ4m9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b6Pa6F09; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D3E0A3F28B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 05:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288903;
	bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=b6Pa6F09cluQnkUQzZZx8ma8BaEhBbv1cHN9CcKbEGyopffc+i2SxVLgYqh4nDv22
	 clW7iuq46Nikl8Ce4EPLhaocWinp0p5rYB00pFjtdKWd75iF6TG3z4qVogEtinG5VM
	 NSQ1ozqVz6B5PYF6zBMG0VMjXStwklZR8N7HnEcRoWRKwVbCjE1UOzVGcOwmFBxnog
	 wQKS1rXwfLB5aoJB29At79iY2lZiwMyCeO9Oq3seqTRXaLAits1ks4RTQPHigf/s27
	 dW0jE0UOxkP0Nxx7DKbxVh1YW3JeWaLHtJpjT2vLEdBy2oBwB1XDxvSXu1/g1o0Ty9
	 2NBT4i1duioiw==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7fc99b41679so5616037a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 21:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288902; x=1733893702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9uM+qY4J1GQbqjmyDa0r1OVtoI70UH7O4H6kctiyohw=;
        b=DzCDS17eAGXefNNmDLEWoUpxrnyKO8Wa65vujSRVzkoQBGbBeiH1PD0KnZGg/B/JW6
         bAdBpbxAzpCXd8unKIsJz97Dx+CB+E0JScEqMCHVZSNfEvLAb0hb9EGRqGqpUumbh5CC
         vINJU5Jw1vYFmhC4lCPE39Mh1jl6MWQnckyIW/gPZm37WoziyrTlZEQpy1SfdW/zbl9A
         nwMX0bYGnQAgO0anPY9G/aGZ5oJJTMtloi366odhEPOptCQVSZi1wK0CAMRRFc70jIh7
         oDk5z2gb6nlbfBB2/K37x5l206IIc/yvE1C7+sR4e/ZsO9rLEvxuhfvSu5isJrOZFj2e
         kbNg==
X-Forwarded-Encrypted: i=1; AJvYcCVFzWyN81B0hP3lyYQy94w8Ap+fHuDglnAXFGvwMdaVuwySGT6Sit8Ah85d43O4G8RW1umgEBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQnihYZCpIfq4+Kmq0lkhf2u12J0lZb638Rz5hqQZneqxciEj
	nyjkKrwNkYpywXus745jjz6FItCr0rxS5dMZwXkJuyKRPebjy2c3XkreYhn8F0cqQnjNPqa/euI
	Yzj5Yau2FS9v3DpjSg9kXIqTNdt3d7fDnCcG6m58NejmWSfFRLPlGR1LAe+RsJysWZPwHEw==
X-Gm-Gg: ASbGncug0h7bmpVu73pm6GeqrugNaLifWiQi5ZuJmRCf87TSPo4NM/yRun3K4BSSz8/
	oERdc71Fru8dK4p2kXtJu4l12MjSlSQ60DGzfFJGn4RbwtUfgGtL/7UNdRE28WCxB+IwYAjqX70
	qn7iaz5jilu2k+63y9Q42+OskCqMmH4/z/rwv4S5er5WHUibdVL6wMlk3eX8scMHr1kPVIbruNP
	5uiZKEEpIIV1G2YE6Brd324dws3yD0HsWVtRSxUP1Z/C7uhbiUpiaPZIn5Fw9W4L7hy
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288073637.17.1733288902454;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtD8y79hadaHZvvNeugnEdk8crgadqfqLkx2GLITOJPtd6W8UtDItN+uiyqRlDo7jPSUc/FA==
X-Received: by 2002:a05:6a20:9144:b0:1e0:d796:b079 with SMTP id adf61e73a8af0-1e1653bb99dmr8288032637.17.1733288902122;
        Tue, 03 Dec 2024 21:08:22 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:21 -0800 (PST)
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
Subject: [PATCH net-next v3 7/7] virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx
Date: Wed,  4 Dec 2024 14:07:24 +0900
Message-ID: <20241204050724.307544-8-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
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
index 5eaa7a2884d5..177705a56812 100644
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


