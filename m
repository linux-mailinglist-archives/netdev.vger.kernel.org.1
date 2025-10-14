Return-Path: <netdev+bounces-229188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E2BD9048
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4347C192551D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36FF3101C1;
	Tue, 14 Oct 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi+GOJLa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04530F545
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441226; cv=none; b=uVhyFXAPLRdGN6TP1ya/jGlJV9e5j3md9zASetlDsuGYUXdh6vI5UgCqo1waGPpPEhArjhJIg2je7HlkXNlP3pOiXiJ5PoUpTgFKlDEmwh9xntuceY00tHvuyq08UtJpDJVBAN3+iS5LARNEaYYwgfYkj04XGcPfoqDgCkixX0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441226; c=relaxed/simple;
	bh=T1Nmm/R6LFBiTFjOpeGfSLW0d5l/K2N7bsDjPiEWPmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opAkia9kKsGGFs9wkS3Hl41ueyG5Rlj6Y2cJKtRtyKltDuKX4xc1ytI4Kh5kalsXkxY4D0YAXo4pPG9g5iiC6f0/PevvHMT+jdDuzROwWsDW/98+1AfsZbFXYqgmcwH0fKJtpiPQlhHV7tnumIp6Gwohj4j7DqMfNmigAzo+4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi+GOJLa; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b67684e2904so2964399a12.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441223; x=1761046023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q3iRfExEJqSXZ9Zc1Icg4TjF6EtAHQb2pCdXlTokh4=;
        b=Zi+GOJLaSWqNICUjGYoVC6y93s4bW9axrH/dehEFEQGplsW2aYB30xT8OWdZlqTDbc
         64ZoCrnWHzrl7bhLdPPfC4PG7DkCIJQnXy2aQFR02K2ZMSj3m6sq9G/5s3iG8Ea1jvxO
         ICqhYT1H8smExYECw1vXUxFfWPuRMVqnDUftDBZuMDA6NlVmtkUQQIdcvLBf4AvvcdKy
         vioJ+4zKYqJtAlZYiXw2/BeE1ANXEO+4blwEpSOkiT8LU2pERusPaXob4ScEgZjH1yKY
         LiMcc0hmEUuv1n2PlZnAqhhcgkDr1vvtGiUSgC0S6Vfzlxz/KEmL0zK2GfHQVh7N3sHi
         xrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441223; x=1761046023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q3iRfExEJqSXZ9Zc1Icg4TjF6EtAHQb2pCdXlTokh4=;
        b=Z1L26pzknQ9DK7j+oEEvCEaISkS64m3UD3VukfUZLXWMdBUR2LWypscHk4ALwU25et
         d7X23efNQmI/cDTisgF4yTbMK5Dm3vae+oZ482N468I6Nl5+YoiCiw3y2oJ2W5TBWKul
         icsrNF95YL9/DIdXFy4p3SGt6e3mQK9tpVpFCAxcBC+PQN5UJ2kdbAPDDQEl9KzjW5S3
         ALVetK0ZFqZgwiQaRgVXexrACl1Ce/avnebeW0XrivxxOs3mTK+fq92NNLh0KTYoWUph
         2CrJ8aDDAkPxowWJpOqlltAKw1WPDLo2ejEUS8F7N5Myeu8z6vSUxJRZbf0RfC4sg8T9
         NHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUymGcrQ+RMtUo3Af5SOa6k+LR4vlEtti6kHZquVJ1aKHM6vsjs4xlS5RfPTDkUWMGb8iDCzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKsUHC1orS4zbL5Mz6t5GGzJTnLLulc6eALRJ1543KSMh3HW9
	IZT6g3x5+veWMnps2UFsnDibizFX0mX2uh885d56AsCQ2FK24PP+MBU8
X-Gm-Gg: ASbGnctaaaKK9nd7Zeybjcbkl3lMqNu+k8w21kfX2iOQNnp2//KveahhOaTDVEjUrRC
	fPe6y/Za+SRIipxkyKT0KsOnTqxE1DwGcPRQISeSnD/d+mCJJHZjPzEQqIUafT3nBxDIuPA0gv8
	qvRGZpn2vbvNP7bLqBkK06EZcFP2zJMnNWo6QvkHsy1wD4uNpaIwmAglAqCHx+bfTDcIupcjmyx
	Fdz1XksNbw3K/QbpTHRy6K1Is2v0Pl7Ly+sgxl2IibJnZjvMaUyCa2BQtRv7If/6dWg+sCz8fAz
	CqYct5ChahUsByiij/WxDxh95Axb4fn6srinlbMPWKUSM1NH4n6IQ1RcFRTha2Aq2CuwQV95zJe
	1q4bLtP+yLXfkmE7jYWtUMqhTpOH10Y3z9pSWfTdvrA==
X-Google-Smtp-Source: AGHT+IESAHoQT5qoaRUX6Sg1Z4sRZoIKiFEVF1CVFjtoN9V7EZsWdw8UMx2i81q1k2h2feHx/dvUDQ==
X-Received: by 2002:a17:902:e550:b0:268:15f:8358 with SMTP id d9443c01a7336-29027402ca0mr302264415ad.42.1760441223089;
        Tue, 14 Oct 2025 04:27:03 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:02 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/4] bpf: introduce bpf_prog_run_pin_on_cpu_rcu()
Date: Tue, 14 Oct 2025 19:26:38 +0800
Message-ID: <20251014112640.261770-3-dongml2@chinatelecom.cn>
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

Introduce bpf_prog_run_pin_on_cpu_rcu(), which will be called with
rcu_read_lock. migrate_disable_rcu and migrate_enable_rcu are used to get
better performance when CONFIG_PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/filter.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..48eb42358543 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -747,6 +747,18 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 	return ret;
 }
 
+/* The same as bpf_prog_run_pin_on_cpu, except rcu_read_lock should be held */
+static inline u32 bpf_prog_run_pin_on_cpu_rcu(const struct bpf_prog *prog,
+					      const void *ctx)
+{
+	u32 ret;
+
+	migrate_disable_rcu();
+	ret = bpf_prog_run(prog, ctx);
+	migrate_enable_rcu();
+	return ret;
+}
+
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
 struct bpf_skb_data_end {
-- 
2.51.0


