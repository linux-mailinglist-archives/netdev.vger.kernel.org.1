Return-Path: <netdev+bounces-250264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C0D2649C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9105E3039665
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE43BF31D;
	Thu, 15 Jan 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpSyJ0Nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4C3BC4DB
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497148; cv=none; b=rWoiPzj1SspLpMkd+mZR7fISYomVmlAxPgOntGX6tHR3iwkVzVVBSHEG+56ypqRL4FFBxjmUpfZtu4a+Sq/H6gssfe3mMTVVgVrmfMsnK7o/sqtAcPGnDESiRmGtudoJ3m89IKMGenlt8bY8fsU53IncU+ddQdCXBiArin0qdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497148; c=relaxed/simple;
	bh=LSh5hLuiJCxDRwJ+BQ+Xc7tCZE16QA/b770rYhc+vp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCQgd/HdbiAdNLoUdAavGf9CetrnQluUAqq1dwOI4VSu+khhM4IWP6JdogwVcsYEnTGHHDBJ1RoBYXQntl2Qmfy2YK61zyD1Isl2B60GE2qws9/1QWgsgZtQ0E+82QidC8KghILL5DgzgX6h+IOO6IH2xYlK+gxUWDIKfGPJMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpSyJ0Nx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so9446105e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497144; x=1769101944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=BpSyJ0NxtpRPZ6abZNisiXXoEYNXasXggd9O3OKVrGnHSKsViorbq/MWM0H+4+vazG
         wTWa6BJKsVkIsYVo4yw5n1V36rolO6khYXu1on9DSEl6H8AJa8Y7Z4y+Hr7EnSyAbAJL
         DtY/5SZojfLmswHJCdLMrYeVy16h5gtGQFlxzRL2Zfsd2Gh15s7MO/hW57pZ5JtvIdbB
         QsYiSaDzlLIQW0Vbt6yqGYOi1Tutq0LhPaSWhlPyAOp9WghftsjiYCqKgjEsBWG0k6oB
         BbZEJGFMCKC46d5tVENMJ26vXugK9oIXgKOBZgW8fSv6KqwRyAHOkGrBH/EbNo6QQyaj
         5NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497144; x=1769101944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BopLoWIhKj7xpDJExutQghL/d96/x+rVfP3p1ohtywE=;
        b=Q6uTii2tIPmY/FIIJaecT7XNp6N5YWN37LtzKw6KnfJQlB2KnCJ197VZ5ys7LxUDzz
         6aQ4mpSzJczllN8jBxMlBdOybesiQmJQfV/YWH0c/LH6xVafIby/CBb2w/Num0F0694S
         KCsB4YPhoyWbE9HUP3jPp0hKgQPqMs0uc/tK9YYw/EOJvMK4HT1Qag6DKxyuU0F/mHUl
         Zh9x7gX3TKBQYDJNOS0MUkcZ8VZ3KgtFEzwAe4uzuZJqOlAMdgNceoW96tlubVF0ktQJ
         HkDOD3GMaA+95chpJTBdmRevxcq4+NDoWg0uUppHv6HS03yO8u+qxIrYWsXvSSnQ9i4p
         eF1w==
X-Gm-Message-State: AOJu0Yw7nMVqjjgdzHNIStHA+cnn/0mZP/A3PfNPB3HqNK/H+nAz2zvn
	vG1cNx/lDV46PG/zyeY6jtdrkHVe2LoFskR2KGOis4EMxJEOY32dCa9g42MYQA==
X-Gm-Gg: AY/fxX4iOlfNucTNahfY8tyoKPpbuuE8aShC9YrxmDU/785nHuqpHzntahznKn4wCP8
	rO90a+ISOzKMRewJZjKe+PCCjQgA8vJtBRCacXbPuW75mKlvCAbYNkAjQZmYAnewhCgj1S6tXtP
	eSOpVPFhH0EJpfa7MwMCZf+A6a3yynkFXozWH1rgukvXCSMIM5FUifjZzKZ9v0OCjULBhmv8jPN
	RSjryV3GSAwE1HRPPsZQ4gLiY2btkiB+JYQBjn1bnAi1W4uszmnlTfpm7aMmxHEmKTrFOQl5abQ
	oP/kXFp9ht6c0gFIY+fNEVs6jMfoYT6/pyiOlm2qtNoN7XFTKJc99rt7XOeXtk4LVCjKTWGwOcq
	jziSCJo26JLAXcOPeOk2vbut1J9F7L+0Yc30wYP8vyv1vezgk4AVpb2xWIQ5CuEARSBZsBl7maJ
	PRTVCiKvO4S/mB7ggBw0rOcw4Kj+RSGWKiHZkOW2QY1Ohg+WxHhsAIaUJDMB+fAyE2fADA+MN+o
	d4y68+bzy3aqBHnvw==
X-Received: by 2002:a05:600d:640f:20b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-4801e7d2a3cmr1460515e9.17.1768497144306;
        Thu, 15 Jan 2026 09:12:24 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:23 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 1/9] net: memzero mp params when closing a queue
Date: Thu, 15 Jan 2026 17:11:54 +0000
Message-ID: <7073bb4b696f5593c1f2e0b9451f0120ca624182.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768493907.git.asml.silence@gmail.com>
References: <cover.1768493907.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of resetting memory provider parameters one by one in
__net_mp_{open,close}_rxq, memzero the entire structure. It'll be used
to extend the structure.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 net/core/netdev_rx_queue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index c7d9341b7630..a0083f176a9c 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -139,10 +139,9 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 
 	rxq->mp_params = *p;
 	ret = netdev_rx_queue_restart(dev, rxq_idx);
-	if (ret) {
-		rxq->mp_params.mp_ops = NULL;
-		rxq->mp_params.mp_priv = NULL;
-	}
+	if (ret)
+		memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
+
 	return ret;
 }
 
@@ -179,8 +178,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
 		return;
 
-	rxq->mp_params.mp_ops = NULL;
-	rxq->mp_params.mp_priv = NULL;
+	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	err = netdev_rx_queue_restart(dev, ifq_idx);
 	WARN_ON(err && err != -ENETDOWN);
 }
-- 
2.52.0


