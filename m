Return-Path: <netdev+bounces-229187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A1BD9039
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC68D18A4CAA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14CD30FF31;
	Tue, 14 Oct 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa28oB77"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7330C628
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441219; cv=none; b=sJPK4ty0RSPzLG1vgcBgXDcTIxt0/t7rA9HKMrIOlM61YSjIKkdeJ6OqgWYhFaTjPjHcfpyt9+ipWbdw11CW0QYy44X8rlZ45d8EWsUVX1N8FN8xC/jtLz3yVDfLeK7IUouXN9saAFZc3lger8BVCXBVsy3923RCCfSOAuerzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441219; c=relaxed/simple;
	bh=9UBTPaJM795jgL9QFzpBm8/hFhK0/nTuD4q5tVTvhPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBwUzF4wRtuAGcPqEP+GZZI/ngn+SqD7Q25VJutjBneqopUDmhWcO+LyvtgRBFS/BUvoZPIbaOUyn1TOHCZew93yZQfzivSIX+avfZFzMD1gRS0c0iRN0OUdpJRcrs32w2MUgiqz7zMZsObP7YW3fnkPkL44yW7WfZz0msquE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa28oB77; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b57bffc0248so3690626a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441217; x=1761046017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUUWsY7ufR6oqn2huC+LiTtkNemBc7wwNq571Svxhxg=;
        b=Fa28oB775qTKKYLCutJH9HB1NJGHWdnuHe8YyZEzlnCGkAtNn82UtCSnR2bpes+Y2p
         qce5MNCf/qhajwosxaXhIujakgaD1Kx3eVqAjX0kKVc8wrb0epRpBh8i6xkd2wQcJFkT
         ppUBAzEGdfgOhST6vKBb4/Y6j6/2p8gHzCufzRMwFpE4B+PaLsEVC6GZMwhrzdqz/ufG
         e36eKh0FZCOxnqx5gRIaiJLgR4wytTJU3e8U7G1jfCthQac7geQYJdXfi9C6juJFvx+N
         Vy07JN9+NheSS/d5FpAuLFkSw5bRx1Zdinb4jF3gHu1UE7/LGNIRhSAEDGaPb4mYDGIQ
         FwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441217; x=1761046017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUUWsY7ufR6oqn2huC+LiTtkNemBc7wwNq571Svxhxg=;
        b=JU58x1hXxNUz8+okfEesYY2fJOwP+FecoDHXquir/Z0wpWzbXaChgGx6XzFaiY2ByD
         G4UOB2Nauma0XkgvqzVfPJQNyRUUgh6Ic5aygl6Jg/7cYgKWkvlu4n/eQHGbxg4coVpG
         pQOHGaIWw5a4BoI1ojcaGiCp9xCkQIVWaKw1A5m9ScfFRGz3dSKHt5I3fzw0NReOk1EC
         D/kS5pwzCqvTWmn6+C2tub93TuBMC7M6Sfkc5gnCiQdRgrY7p+6frqUK/pIC1LouG9KE
         iOD1TNbJ3gUjJIpTNW58pik/+527shQHKQ838LkQgnNYMrjs6nA/hOtPWyFrx3mhQzOX
         sLMw==
X-Forwarded-Encrypted: i=1; AJvYcCV+8KpIudlLF+s43nP8J2BE1prJd8Wqan45Z2SNl4xZK+4CzdDDJqCfdiCZHtfWW76stSaQRPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwM6IrtCv8HhbWkE4tYbZzqqQdYv6eFhyzZitLBqIInYhbvYZ3
	1CjA6CNCu760E30o+O3SBrW15G7bQ2EGsahBcFoP65L5oRjy8dfYTg1U
X-Gm-Gg: ASbGncvHGfNI1CvF/Pss/9Iu64CiF8MQ8ts3coVQyYXWZ2jq1p4ani6qEVKmv3Z70iB
	/vcczpQUSPBLbjpj0PG0tKa1UMma82WjQsY8MSV1lSVOPKPTIShigDMuu9v2zH7BOSn8/MMmQrr
	CMD1Npcp5Se4hkWrl7amn6NeKqCb1JTgCnMsn1BgzxwGWX8gRHMiV/3icPddpxtLyJYWUFEV8bn
	Y97AADExXYYcn7PUB3ux9b8fSvTKjPHxD08AN2lYJZ/l+MubsDp3TCSXLOcIYn78nqG7kPixkA/
	iN2K27i2zDVG2s2ZW0xOkufDRzggmDBHr3NPRj9+Bpu+l5XQxj6/r3+y43O1DdNmyugRR3jhskr
	/3a/8tHdjkH/glSRPszsl6sXLDvFtyOgJyFvYNGUX/WWCZfKHj+BD
X-Google-Smtp-Source: AGHT+IHwj+Dz4L8DnGND7olSFpVsnMTn5Lw/TEHpx72gcX3uQG8ce7dMeM/FZb/y/sUkqHY1JHLYcw==
X-Received: by 2002:a17:902:f788:b0:274:506d:7fcc with SMTP id d9443c01a7336-28ec9c0c7e1mr394581375ad.6.1760441217252;
        Tue, 14 Oct 2025 04:26:57 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:56 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/4] rcu: factor out migrate_enable_rcu and migrate_disable_rcu
Date: Tue, 14 Oct 2025 19:26:37 +0800
Message-ID: <20251014112640.261770-2-dongml2@chinatelecom.cn>
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

Factor out migrate_enable_rcu/migrate_disable_rcu from
rcu_read_lock_dont_migrate/rcu_read_unlock_migrate.

These functions will be used in the following patches.

It's a little weird to define them in rcupdate.h. Maybe we should move
them to sched.h?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/rcupdate.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c5b30054cd01..43626ccc07e2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -988,18 +988,32 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 	preempt_enable_notrace();
 }
 
-static __always_inline void rcu_read_lock_dont_migrate(void)
+/* This can only be used with rcu_read_lock held */
+static inline void migrate_enable_rcu(void)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		migrate_enable();
+}
+
+/* This can only be used with rcu_read_lock held */
+static inline void migrate_disable_rcu(void)
 {
+	WARN_ON_ONCE(!rcu_read_lock_held());
 	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
 		migrate_disable();
+}
+
+static __always_inline void rcu_read_lock_dont_migrate(void)
+{
 	rcu_read_lock();
+	migrate_disable_rcu();
 }
 
 static inline void rcu_read_unlock_migrate(void)
 {
+	migrate_enable_rcu();
 	rcu_read_unlock();
-	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
-		migrate_enable();
 }
 
 /**
-- 
2.51.0


