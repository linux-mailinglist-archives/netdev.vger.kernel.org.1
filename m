Return-Path: <netdev+bounces-250271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85991D26408
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A4743061198
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2889E3D2FEA;
	Thu, 15 Jan 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8GoXRFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF13BFE36
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497165; cv=none; b=MMUeskxTrs9n0JZPsEaXVNkgSPKAAgHVqen2UHxn2DpK8AX8/zBbw91XFLxPXaNtinNOhG5qJdjpqIHYw5FbDqwDEtNbCq8XSnLk6+oFnwli/QJCGFb+1zZ4Povz7NoOC3NwNgyqag3IUcxD6oBwg+Eqt3EPyznWMfSffmaXhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497165; c=relaxed/simple;
	bh=axdc3q5KY7YeHULab/TvgzOYs0oof9ugiogriyYfhIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaubF7J/3Nrs6XiR/8BpN2AKBgjqka6kWSvluqtt5HsexPJr3ZCWNZyfhtXxgRXSmC1ueHT5DCjLd0lXLO3GF+3VfnsskMOWDdqSugDvogxkuJZvCngBWcYTxz2L2irBGco3ZXdS1VsV9uh4L1ZG9XhQMvEizZts3qiYJnRIzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8GoXRFc; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47edffe5540so12301775e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768497160; x=1769101960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiBEtLY6CE0u/w5HMF7IyfpDPmY7qzN3np9POU+8r/k=;
        b=A8GoXRFc0IJMW1qfOfJrOBj1JHhZwXvCopVi2+PE2DOaFTMuDMnBiAw+2k0Qtxm+hs
         LgdgjOe7NnSX7UaF8b7r4PfW15tcwfenWHlJ7akUcMP7Evmb2nyvPmhrYTLKAaP/DS9d
         o2UqH7xu88UmohiLg90AcDD97OgiExglCL4W44+PajXj7dUvM39oUJn+f+nN9pJyVIiw
         jq2aONOfPO73F4MWAC9MrzLv+DmU0STcN5G9FGhOc8U8A7SQuiNaSbnHgRnrkcIU4cm6
         O88JXvbq1HxOS5z7yJqidF2evKknMKxlYrkoQbvbL+v/aV3JMwrMxGuXWX/hviJc+hMn
         ELig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497160; x=1769101960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiBEtLY6CE0u/w5HMF7IyfpDPmY7qzN3np9POU+8r/k=;
        b=mUtM3x1r1hmD6AS3LxBYuQUQE+VjVSOVeL9HXLeFL1J9fEhbQ1ve6dTmEqge+HKm+W
         zn0Jhk8VmYmv/r78q7ACFLpmbpaDuP2JvarvXDsmtQ9w4TBFSrItf0JB7kXQdBROGW5A
         VFwJgeS6g/I9uSg0aso/JiWdAXLfXAuxJ37dnr8IeTQp+o2Qu/UhpDniDZOQB209COOT
         NxwHGyaZRx+CxPKArnpxAuFm/CXx7kbfZo8+wkhs4NU//qNE9Sr0K9m67iOp4VQwWlU6
         gJUzyc01aUo/GR/M/ugRqrr0zxy3hpEvdY27mZpOrF2HAZpTXJscyNyqF2Hy0W6FZw/s
         voNg==
X-Gm-Message-State: AOJu0Ywt1rcBHK8ypJbn6drwGiX2T81fbKkvXuHrBRhVX1kHnqBce2Be
	yHkin4JALSTA/l39djm1hJueIB8Nk7tlt/ilaIAdsc4ag2cOuIynJMkVEl5sTM1x
X-Gm-Gg: AY/fxX7UMW16v4447knjDS7gtRtR8poLzbpB9HBeW/aKF1QH5n0QkjJc/2pCkcjt//A
	q2JGBiaiPmM3W2+F4DOx+Q1AiecDKhYYePoScdqQRmLaZEQlq81Mn/aUPBWeMuOW8QlGPd2lbcF
	geNi2zQg3NYqfeaZSO+Au++a0MEN6Q2N0KypzhMGeFfadSNA9EY9Sn3hSYXeiewNoX6ybNmD4te
	uMKuGg9xOY97Zs61eWHddGaNoadMiyrqpRKJ5YemnPFULEjsvwC8zVqJhov3xgQaJTtpVpsKEyP
	J2CPl92rTfV4SmkBO+KNynL+XzLmqkLsIOVu/EbiNMpDD/z5RsLi86OLHUKm6zBdgLGZlV3rkat
	8RPza9JV2ez3UPvRkjTutceokHp2dVshBCQXs/j/qXzL6BnqKwCTdoyXQH8jQGz56aQVKgI1g2U
	dzrkBtbA6Nsnrr7e2a3nWCCf6b800XixxvqpCRk22Gvn7G0qGjd4NSOoZB2/NCRDSauB9A2vwmu
	+liv+ZMInvHBtUTTrQ2seneRodZ
X-Received: by 2002:a05:600c:3ba8:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-4801e2fddcbmr5854765e9.8.1768497160083;
        Thu, 15 Jan 2026 09:12:40 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:39 -0800 (PST)
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
Subject: [PATCH net-next v9 9/9] io_uring/zcrx: document area chunking parameter
Date: Thu, 15 Jan 2026 17:12:02 +0000
Message-ID: <d1de61db1536727c1cad049c09decff22e8b6dd7.1768493907.git.asml.silence@gmail.com>
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

struct io_uring_zcrx_ifq_reg::rx_buf_len is used as a hint specifying
the kernel what buffer size it should use. Document the API and
limitations.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/networking/iou-zcrx.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networking/iou-zcrx.rst
index 54a72e172bdc..7f3f4b2e6cf2 100644
--- a/Documentation/networking/iou-zcrx.rst
+++ b/Documentation/networking/iou-zcrx.rst
@@ -196,6 +196,26 @@ Return buffers back to the kernel to be used again::
   rqe->len = cqe->res;
   IO_URING_WRITE_ONCE(*refill_ring.ktail, ++refill_ring.rq_tail);
 
+Area chunking
+-------------
+
+zcrx splits the memory area into fixed-length physically contiguous chunks.
+This limits the maximum buffer size returned in a single io_uring CQE. Users
+can provide a hint to the kernel to use larger chunks by setting the
+``rx_buf_len`` field of ``struct io_uring_zcrx_ifq_reg`` to the desired length
+during registration. If this field is set to zero, the kernel defaults to
+the system page size.
+
+To use larger sizes, the memory area must be backed by physically contiguous
+ranges whose sizes are multiples of ``rx_buf_len``. It also requires kernel
+and hardware support. If registration fails, users are generally expected to
+fall back to defaults by setting ``rx_buf_len`` to zero.
+
+Larger chunks don't give any additional guarantees about buffer sizes returned
+in CQEs, and they can vary depending on many factors like traffic pattern,
+hardware offload, etc. It doesn't require any application changes beyond zcrx
+registration.
+
 Testing
 =======
 
-- 
2.52.0


