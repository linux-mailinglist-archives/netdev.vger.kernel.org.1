Return-Path: <netdev+bounces-221344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3CB503D0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 19:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBE044798A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C53705A8;
	Tue,  9 Sep 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="PqwfAM1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0F35FC2F
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437230; cv=none; b=da3I3SN3Ue1G5JBLLMqXtGvsvAN2oxokLWeHCC3dHawKz/xm5uTSquHawtsXrcp9ZmBv5NNCMPBgscZ63e+d3TbWIZTp6RzVJTwGpMQlR3sXX5BHGMiYKOwDU0/mR/ePKEP7ZLzTOgiKwS+ihW2XDCAk7KM33expWULhx5mWonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437230; c=relaxed/simple;
	bh=i9ei76HZWXEGFxtJrVdE8n0QQk9q0CIQwkPYsw8lY9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlJQ75xcLFp19p71oaFuwDzWtv43WUvIpsbOFOzqb1H2ufaAedDYjSjnvHVoZJFK2CzeFyqNSCOQRBmfIr7fTw5ezsXE0GqkgI9pl3Iq0TCP6Zy5hsvj85upzj8rRjwIAyPZuBhE2qcRWlrj2tEcRKDRZn/9saG+yR4kt7q7EBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=PqwfAM1N; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b47174b335bso583635a12.2
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437227; x=1758042027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntPkdum4JIas65l2vIjgWtP7aF/9GTTAGBMQDfY89wY=;
        b=PqwfAM1NWp9oA4UyykJC0oUnvQ/T99Z4CSxP18cC5vM0ZKsWbGieaZBiuCLGvHU9N0
         +CcP+gXZZcRaBwPSQ+92gnvdX9A8gnLvlGNm3/XF5IQiZJLTqB0e8UKtu/RM1u4hp7Mg
         wqV2X2TB5pbpe8Ijng1ietwperHhdwxcQl0vVIkPADq300i6Ah0/MtcPHujmPFJ8P5Sv
         hVBVZ0k8xY9KHc+uB7imkq5AZnVLmltK/IcCk6U3b+ErBNSLhFgcLYXDY6u0fySYMiMl
         7JJEYEfK0K1qUVyJoYyDwn84+iMmmtrpuUOl5W0tpRXdxFTlVMbCi7NuZ/GEHOouf4r9
         XC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437227; x=1758042027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntPkdum4JIas65l2vIjgWtP7aF/9GTTAGBMQDfY89wY=;
        b=kq+0H5wXZ3IfoG4Z8Q3XnDwRPMjEBRBcHPf5KcTaIXj5QiLpnQrpEX8RAjP1+Fb2F/
         a6XlcCto+p31gecpqaUSFtIfqTC2NykrtFB/nafO33kwpRB2uoUzQBUiN76OMYGcHHJ+
         em6bgzHt7d3/2V46bi6QMtbuVKjOSAx4KpRX6Fxd/vpgLQ6I7zPDBl8bn0gwHROoSTK4
         cQF/+6ge9C0KdDmL3Z6lGRDRtVF9nMlzBfuQ7HaGaoFNJzSvkEf292/p50/gJU4qjA6u
         JZ9y+3+P+3ubXi2TYDkJhDmQ+1x6ouo4nM9e4IcuuMfMTBvxgPBQpXwZxc6UpTjrY/KU
         WgdA==
X-Forwarded-Encrypted: i=1; AJvYcCUEwHHSNmSeZPZApjl2H36Hg/zcOyfp0xVulb8NYDymoPv51rmYdiprmZqrK70jPqTyivUiYfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9PbFmG6x8xkwVNVA+bJyXFkHSDCetub4AkIyP3Xxdy9y/K79
	tr/XHEmN8IsXY9HgnfNnwrxIE4slw6IHT/OsRUEcpo2BK5Cgg1woZnzov+NlX83rKLU=
X-Gm-Gg: ASbGncucQeWbH6vJsWOuk9TfeHfJv18VVXr7KhxIuYjf05G4IWL5CPVzS1qVESFRKlr
	cgu4KROOnhttynt0IdxRrgQXqtyzINlM58JpGx9MgPFNEUZg2p3h6qXv7Ff4uyPWehFviJyDhQC
	/ECO3+Ja+FRYGeVi/vvsxw+ZXwx5kT2zSTDN6EDovkbpxX+IgwfN/k9jb19MPWQzIAHy5XG32my
	C/Aqz39WczUSzaYpsrWYWgpCQ8R0O2kj+tA8Tai53GKeEGIIW23wcwwsuwe84/0qQm/atcMrss1
	rnBzq65tfiZgnxGk5X5Yp+GlHIeFGD3eLZxOLo/yfXdv6YMTw56YwhdYuaArr3NFr5hxTjAQxZa
	aDKkGVbBIdBQ5o196JVC75JsWnuMSFX+2i2k=
X-Google-Smtp-Source: AGHT+IEQmlU7EzM4zglr0GOpZvMozjjX/W2WHFTus6ChRNLVwg4aNDOe25tOH1775VMpAunjMzwSTQ==
X-Received: by 2002:a05:6a21:6da1:b0:252:3a33:660f with SMTP id adf61e73a8af0-2534441f65amr9965270637.4.1757437226661;
        Tue, 09 Sep 2025 10:00:26 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:26 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 03/14] bpf: Hold socket lock in socket map iterator
Date: Tue,  9 Sep 2025 09:59:57 -0700
Message-ID: <20250909170011.239356-4-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to socket hash iterators, decouple reading from processing to
enable bpf_iter_run_prog to run while holding the socket lock and take
a reference to the current socket to ensure that it isn't freed outside
of the RCU read-side critical section.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 9d972069665b..f33bfce96b9e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -723,30 +723,39 @@ static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
 	if (unlikely(info->index >= info->map->max_entries))
 		return NULL;
 
+	rcu_read_lock();
 	info->sk = __sock_map_lookup_elem(info->map, info->index);
+	if (info->sk)
+		sock_hold(info->sk);
+	rcu_read_unlock();
 
 	/* can't return sk directly, since that might be NULL */
 	return info;
 }
 
+static void sock_map_seq_put_elem(struct sock_map_seq_info *info)
+{
+	if (info->sk) {
+		sock_put(info->sk);
+		info->sk = NULL;
+	}
+}
+
 static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 
 	if (*pos == 0)
 		++*pos;
 
-	/* pairs with sock_map_seq_stop */
-	rcu_read_lock();
 	return sock_map_seq_lookup_elem(info);
 }
 
 static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-	__must_hold(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 
+	sock_map_seq_put_elem(info);
 	++*pos;
 	++info->index;
 
@@ -754,12 +763,12 @@ static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static int sock_map_seq_show(struct seq_file *seq, void *v)
-	__must_hold(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 	struct bpf_iter__sockmap ctx = {};
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
+	int ret;
 
 	meta.seq = seq;
 	prog = bpf_iter_get_info(&meta, !v);
@@ -773,17 +782,23 @@ static int sock_map_seq_show(struct seq_file *seq, void *v)
 		ctx.sk = info->sk;
 	}
 
-	return bpf_iter_run_prog(prog, &ctx);
+	if (ctx.sk)
+		lock_sock(ctx.sk);
+	ret = bpf_iter_run_prog(prog, &ctx);
+	if (ctx.sk)
+		release_sock(ctx.sk);
+
+	return ret;
 }
 
 static void sock_map_seq_stop(struct seq_file *seq, void *v)
-	__releases(rcu)
 {
+	struct sock_map_seq_info *info = seq->private;
+
 	if (!v)
 		(void)sock_map_seq_show(seq, NULL);
 
-	/* pairs with sock_map_seq_start */
-	rcu_read_unlock();
+	sock_map_seq_put_elem(info);
 }
 
 static const struct seq_operations sock_map_seq_ops = {
-- 
2.43.0


