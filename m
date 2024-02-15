Return-Path: <netdev+bounces-72041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8651985644F
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94411C21CE5
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C6D130E52;
	Thu, 15 Feb 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf+WyE67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31534130E4A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003608; cv=none; b=CWlA3AX1BuSnV5Xy/HUOpj1QTDwhBO4uUntkyL0BGUXmGynsjiTNj9B2OeamRZgW0F186t4FrcNvdBLsYuVbFo+Hzd/aUnWfj4Y6FZfwCe7Orwn/V5NUnL/cHBgfB8JAam/di83CdpHz/xJJVdJrsNFWa7kxu1z/gmjqxKJOgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003608; c=relaxed/simple;
	bh=QDdsa22JRBCbPcK2RkRXKRkISSPXJi+h0sYd5xj90HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s25yCuwU9msc+X4uqPQCFKwtc61culGWhc4JX2QP/4GQf7xC/sAslTg6gsnys7pvoQqmUL+NOu3aQ4ZZlUu6Sm/9y1qeADCm2efNX3dVTwdtajdy4C+v0a25+DhOeCePkxRbwqNRQCME3wT2Z4U+pvDrvyHuD2y4/6jTiy1WDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zf+WyE67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708003606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlLpS5Tb/Pfs7J4bWfeg5Rka0NiuA94LlXE1OEm0A9I=;
	b=Zf+WyE67yfa/wW4r1qpq6r3qQ8UAyQ78cdsBoccED6REAue5Nbh4/9G3xI/qRjR5XhoB15
	A/RnGVHAzraRQo/eTK9GPqYrVLHesuBw8CQDEsMBr0/tjjUTaSV8OicuFrP8Y7G/RKOBU5
	PwQTw1L7MP1OEYu39ZeIUrRt4hh3QZI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-GBJqLRGoNoOZNOtMM25B4Q-1; Thu, 15 Feb 2024 08:26:44 -0500
X-MC-Unique: GBJqLRGoNoOZNOtMM25B4Q-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51156c3208cso656595e87.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003603; x=1708608403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlLpS5Tb/Pfs7J4bWfeg5Rka0NiuA94LlXE1OEm0A9I=;
        b=w2y8C163gwPtoKrtoZIvkX2XAY1Kf+0E9N5ra4CotV+n7gYToxhXzQ5hW1v7hfuD2g
         luUMcaBS3qROQ+gna8brAySBXiX1hCTeSS/joA+7xzWg57ifeKZz0uJ/kkjCE9KRfVP8
         wfsdvZGTPer8w+8PzgoxQdy/JcAfqK9cfb17GY3ANReKL+2l8Ts6yybLYpobzBaGepUy
         6X/NJKn2k6txFeJ5qbcWXCjX9HbtS13+4qM2x58WV6AKsp8w2YPkdoCUxlXAOOSD2c2+
         XM44cTlQOdhyTfgZMZ9Zvnz0YnKvkhKn7sXN7YTb4qXQ50KCVcU5twiHYZsFcDqpKMja
         p+ug==
X-Forwarded-Encrypted: i=1; AJvYcCVAFJjvv5O2eQTBzWUGeg89tyx0OxlPDE6FqtqemM1nGVhnYCAjS7F9fcRIfDKdpWyMzcGNwTKxlJEom4Uzo0BYeO4VBdJM
X-Gm-Message-State: AOJu0YwAf3J683No7aEyC7RJ2D61gt7ZrtKqo/g5nVA9YD7RHEERwuHc
	KKhOuk5b4iSOsw2eO2ydWy+kLjBmxIbP6Zk/AZ6u9chjtqUId1Vnqq2EpNbcbIYTG4icOS3b5vu
	4wgxY6LVQ/G0F5lHOjtypWoLorAzVmq6bpMGD97BRZlUat2KoJQgqew==
X-Received: by 2002:a05:6512:3da8:b0:512:888a:e6d2 with SMTP id k40-20020a0565123da800b00512888ae6d2mr1396921lfv.62.1708003603078;
        Thu, 15 Feb 2024 05:26:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdud5K3pG6VPBPAz6cjIUmZme+rRP4ncVLG9wjgux0pk9gbYuydcHQNbSP50Ifr+PB1VIhEw==
X-Received: by 2002:a05:6512:3da8:b0:512:888a:e6d2 with SMTP id k40-20020a0565123da800b00512888ae6d2mr1396889lfv.62.1708003602686;
        Thu, 15 Feb 2024 05:26:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id um10-20020a170906cf8a00b00a3d599f47c2sm555581ejb.18.2024.02.15.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A329910F59BD; Thu, 15 Feb 2024 14:26:38 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] bpf: test_run: Fix cacheline alignment of live XDP frame data structures
Date: Thu, 15 Feb 2024 14:26:32 +0100
Message-ID: <20240215132634.474055-4-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215132634.474055-1-toke@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The live XDP frame code in BPF_PROG_RUN suffered from suboptimal cache
line placement due to the forced cache line alignment of struct
xdp_rxq_info. Rearrange things so we don't waste a whole cache line on
padding, and also add explicit alignment to the data_hard_start field in
the start-of-page data structure we use for the data pages.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c742869a0612..d153a3b3528f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -108,12 +108,12 @@ struct xdp_page_head {
 		/* ::data_hard_start starts here */
 		DECLARE_FLEX_ARRAY(struct xdp_frame, frame);
 		DECLARE_FLEX_ARRAY(u8, data);
-	};
+	} ____cacheline_aligned;
 };
 
 struct xdp_test_data {
-	struct xdp_buff *orig_ctx;
 	struct xdp_rxq_info rxq;
+	struct xdp_buff *orig_ctx;
 	struct net_device *dev;
 	struct xdp_frame **frames;
 	struct sk_buff **skbs;
-- 
2.43.0


