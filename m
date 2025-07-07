Return-Path: <netdev+bounces-204624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C719AFB7EE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D25189661D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF57213E6A;
	Mon,  7 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Sch40BaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19020F09C
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903472; cv=none; b=dheqXpANGfxMIgHijJtIBUACAJgX7kvffaDw1XEvfDQjuXuiMaKrqXcxVlpwOvlyNpAsbwtpPbnyZYgZTz/1QgdyzcLfmi458wdm6KsCiO/2vXsqe6hLdfxpzJ677MYeAVhPmxvUoIF3oEdRjOw/bA6YJOKTMxAKtSi4VpXh7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903472; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8qG4aAqXxsWOfYDE2CqvinRxa20MSpN9RuZS3aOMILOR8dRREGv1LzOGHaYzeAFO6oH4cZDKuwlcM3WktidUIrhTNw/BrATyXa+2uHIQ9ceo0XcqIfiZRQBGOU8o9x/4jcjJ3tQpSHlRH0iJYFrOts2HIOvkFsUuCKHWyB29OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Sch40BaE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234b122f2feso2429395ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903469; x=1752508269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=Sch40BaEb0m2KjjqP4ADpF/x3U/tXXdK2akmCvI1DMvBhNZbiNijEt0r4UwHfFCjbG
         zvNZ8ZsFvpf+TZpvnBWzioe6vLTUh7dMdoT+scIVc2jnosfVRAf4ELRCBkOJiKJr4O2d
         dh/exuphSVbnmSloQtv/wkL1vJKSNTr3VDv/wEDKJdqxhVn7H3eH37X7ZOo2WBdJ4ItV
         Vb7+GQwfHQU4SBGEXtTwzqivuxsW9g9Ds/Po7F5QdDh9qKjiM9nGcxqvLoPEXSUd1bKr
         5QhPrQpkxcG1VaPINpaqIZF3EpLHK4xGjneF9Q6Jx03lPIupNa/7xhLDiI9NuwTL7Wjm
         Godg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903469; x=1752508269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=p0c7YHU26ZH4dd53FeStOjzn0Yj4S1JxJWQ3XUxuJin79aiS6RTvRQI+up5/i/pIc8
         Wa+sUOSsc8k2I/oFy0xTotQBcDMugcndV5Ber0ttI0ZZYIr+Xa/Bp6IrFnnWiLkD3kXg
         sclYMulDhok7lHlT3ElKrGOxl0rm5ml3Z9mQAtWk3Mm6zgGj+UPX+U3pV2TYx0wX8i+T
         lyQFzB6n+nNhJ3HhynKuxPqNm1g9wBE69F6opuvLPwq37Zq9mOudS8dpb1L4WrfA6Ssg
         gTwCAesy6WQd0GJtPFK98pM/AI0ODMtgTOy8655ZsNGROE99fKvvHCCPoLyno4gVu6sV
         kQsg==
X-Gm-Message-State: AOJu0Yyub8vVaTFIVz1Vo+Unsy08Nd6atTLJW/gEHqWzmnymyrjX86+n
	lABz/KX5Vzc+4qtJKSgNTNXORkZKwnJNQL+EdAdV3A6tE+Qa+v6c4ML4EVPdpZmHYAkBXSNEn1P
	D9jVT
X-Gm-Gg: ASbGncsciA/ead4kfC73oHLbA5Hj9xYTxg6jGdByGQcagbiUPLxvFimKAirnEAi2xuq
	h0NY01uZ1e1apBpxUTewELuQ0w5K2RYIlE0y27aWe7Mzifk9WBCKGh3Pg8hLdmB3gx/rI0HWI2i
	hRUj+ljC8sVfjY2NYJHLRxbXRpP8vyr7ZV0Q8TmZFXQ3813AocTnvFrTyDGoYGwvSFg6I0a3lKx
	w612AAQPUAkPNyvQsAye4Vx726iXNtBuhMpIQK8IZQwgKYezWIE3pWN24Jufda5ssWkU3E94xmH
	Y6xdHexS/ypEbXP9gMl3kWdDQ/bCdLPhU6Pf6dnbfV6QlZmURuc=
X-Google-Smtp-Source: AGHT+IEKJQWYjeVFC45y9IaBfVRiscP79Th9ZakF0kjOzTliYluReOqGTKGsiqTBpr3rI+Ij32xa/g==
X-Received: by 2002:a17:902:d4c2:b0:234:9fee:afe0 with SMTP id d9443c01a7336-23c873f58e1mr70940865ad.14.1751903469237;
        Mon, 07 Jul 2025 08:51:09 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:08 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v4 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Mon,  7 Jul 2025 08:50:49 -0700
Message-ID: <20250707155102.672692-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


