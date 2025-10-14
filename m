Return-Path: <netdev+bounces-229190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16003BD9051
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2E23AE7D0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B993112B0;
	Tue, 14 Oct 2025 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZm/6l8e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413803112AB
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441237; cv=none; b=TxE+GAwdb5vTXj53AbhAeEuTiOrt7EiMxXkx1S8r5KlooxKpUOs0XhL8Vvi7B538w5jMhwcQPUWxeXD4anBTkJ2nEzW/6SIvPb+ZeoEHxU8cGmS25DOdskQQSbdrwutoJSuwWY7Ii5sX/YI7fWmrZ4/XL5Tg0LAiRTPZkXeayEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441237; c=relaxed/simple;
	bh=Rx/YhkNxvLHTn1Rxzb2qa4X0/4hclpnv8IPkM9Xg0Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XngAyPjnBOke2PM/L2cfmjuD9EWD1nkJj/YIYUfwYSifM9nB9gkaUyu3qEjnmstjyfUPIMHMfxqHOjuIowTilV89Cs8dvRMWIHc6oSusQHEdRM+qZLxokw8yRf+73ZXtY8fAxl9ddmY7UaKRE1wc+ORIqGOQ+8uXRjyoxmBjjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZm/6l8e; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso4776754a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441235; x=1761046035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE4VzJhkO405E1xXiO2HovH6fVbTOd8AlZfv3OpV7tQ=;
        b=fZm/6l8etXCz+IX9EaYFXrINr+/EC5xO/KA/D/goPOt31MUJzDyet/ZxEgiA2sXwqP
         eo9ah2BfbtNGmFHVYg6leGsD6dSKaazLJBV8X5eJ8dZe6pJO8R+b9KzERmuoszWzy7xq
         EWKsaO9BpT57wDBvCdvLbDyqbaCk3dClrxpI/cuqgoIbEj8Z0Ame/e0gD1oBB/g1/rXA
         AGTSaU3PHg/qhnP93TsNC0VyiNpcmZKig5aOxq/I77v3nPd47l6Ec69LwUnTdATpGx1h
         URjqRZnr7Xh1ZPF+sUgVbVsvnhgUon5CCsQYhMKZGoylwSUVSOPJMa45YV1uV+9MHn0n
         Oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441235; x=1761046035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE4VzJhkO405E1xXiO2HovH6fVbTOd8AlZfv3OpV7tQ=;
        b=mNYXvywyfPyKSbW/e20mqB2V4lPj/xdNIsnujvPxefbGmQwJ+RvjylypaVB3pcHsif
         l1wTUn5elDSuxKulZONNxIbnCuUXSD7468iEORTE7iruwc/vuSFLyN38ubiBszhs5Tbh
         seZw8XSJJB4LozhHJpJzLIpPUEO1NPqUgfqwt6fMdkvMY77nB3Nc4odvBUJLiLPrBF/r
         bP2DcKaZVKeWi/0ZgeW+/zR0T+NRmPfC2wlHxxmTc9byJMfaZFd8yurDLnf2Nr8uEDle
         U+L0+VCJF+FCPjYv1Rp+soCCv0JPVQYwREh29wH513ytlRBL9NMjU1EJ33Gw5pRixzUO
         hVgA==
X-Forwarded-Encrypted: i=1; AJvYcCULYSGfvdOZyKxnfGhPyH+Ra1j6ZLr3fw/xw1jno1dBd67xV0ZimKFSR/EwRsdcI/1jP80swd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVCuqiZeL1Qk+ppK0Y/7rJdPV/mTd8MgabDnkas3J2UwWaRHr
	7J4K+bB7M85atfdNZXs155vx/KZ1G90eFHKkviPzgkABxJDPgrHP+3+0
X-Gm-Gg: ASbGncvwywiAMPROD5Pf8xaKGLe9mGALVp6TMldFBlXGwBEhkoQtnP5cGDcsK5Tebzk
	KltHF4hEBIHGlXfYAjb2ZA/ieL3F6TnzmQuKIFMy6/nvllO13YuZ31FrZD0DNqmTNRuplHytV/C
	opJFmsBXNwhOZj9JQZWRBWsR+NvzS3sdAjo9YBwZ2VqdzkltEfi83J0roxNXAFkFSy7Oerli49T
	SVZFpTB4gdon2Z62Gq3h9crqcLs590JuBGG9kRAX2Bd6SEcZokgbjiN6HfdX0RIz768VHrQ9WJs
	86g3pr9oBWh/EjxyBJtgeDwA7jfkTnM/L/vGzmRnKBp9qRwAQ/WR2ZGFjq0Xk38wKXXKLE01ITG
	R/Y24QKvYvZ6wBY7oxgpAY4XHEKzk+Y4oGEdxR4mblUpN7j5H
X-Google-Smtp-Source: AGHT+IFYag3HNohwuOOUkgMrRymk2W/3k72l93HvciN+it3ayDICZ/f/o7hlITPi8oCOkannkiormQ==
X-Received: by 2002:a17:903:246:b0:24c:9309:5883 with SMTP id d9443c01a7336-290273ecb35mr316032095ad.28.1760441235366;
        Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf: use bpf_prog_run_pin_on_cpu_rcu() in bpf_prog_run_clear_cb
Date: Tue, 14 Oct 2025 19:26:40 +0800
Message-ID: <20251014112640.261770-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112640.261770-1-dongml2@chinatelecom.cn>
References: <20251014112640.261770-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the calling of bpf_prog_run_clear_cb() is protected with
rcu_read_lock, so we can replace bpf_prog_run_pin_on_cpu() with
bpf_prog_run_pin_on_cpu_rcu() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 48eb42358543..5ec5b16538f4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -995,7 +995,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	res = bpf_prog_run_pin_on_cpu(prog, skb);
+	res = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 	return res;
 }
 
-- 
2.51.0


