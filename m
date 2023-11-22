Return-Path: <netdev+bounces-50272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891D7F52CB
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6491C20AF0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4B1CF8C;
	Wed, 22 Nov 2023 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZYU6+Fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453B1BD
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:44:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so4125e9.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700689497; x=1701294297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXiWhRqFrWoSNtAFmkHRO3t9Ruwff9Gl/eAaWgquIiw=;
        b=MZYU6+FwDpBJ6xo/We22FfLNh9FSQ9OoFhPVwTcojSXrT4Ftp9AqlcnWAfNmpcIr9K
         V9jZa0+1o205wL1nn/7di5gW7qfzBgaK7kfvFbvKVh5WyWizYTjVcBO/mMAczdYCdGuc
         1nKdjyS7RvhOij8CAByT3z39g1PfqZD9SM9q96esBHOWV05EJmW69iOnUSz6B7eLtlwX
         P3E+wMiSzcK91KwTHnBXYcXwue+qaXf14m8M8fQQin74OtQURnHfN6z78jU74naoOSPQ
         yllW3hBiopQWAJ0YfBOBUrVXzsuC32qIA4B6/iZzza4HJzPSskHO4yMRKtxJ3NVZ6N1E
         fZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700689497; x=1701294297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXiWhRqFrWoSNtAFmkHRO3t9Ruwff9Gl/eAaWgquIiw=;
        b=pDx4YByGB4p0IvTvnyWq2je5YTzXEgGoRim84THv3OewMNvoHFNa7js5Z2gCCqi0Xx
         SDkn26wRx3C5U77D4Idg38iSrbI9GlaL3PxJlKzlOzrACbFnC+v/mSt22/hd2DS22dn7
         BrK00FEXzFmK9w34Pl2t31tAPY6Q5uhKH0q0Xl0wHNzTR8dGaMhX/pC4HkyeyxzctZ0y
         cAwg5BALBvM/LHaU4yeswOW/WkkaoiF9pjj0IY8EYXiwImiJ8nJijJ8fLKqjxXS7Ssc8
         GWYsaY9D0zNDskyjeiwCtucbnvqjalSI+8DSRW64LBxfnKpLq4NTShD2vXBxyXjQ9PjI
         52eA==
X-Gm-Message-State: AOJu0Yyea96ukQXIkNDzXa/3A9vsHQwtcg5XW+aliCLWS9HojztBTp9y
	R1xOcL+uUIelqvWcNNICApAxew==
X-Google-Smtp-Source: AGHT+IHbmV0ARllAULEuHSS994ZoR2ChYITmiV4ts7e154PIRGXVJrabc+eOugs8EXU30EkDHD1E1w==
X-Received: by 2002:a05:600c:4e0a:b0:40a:4c7d:f300 with SMTP id b10-20020a05600c4e0a00b0040a4c7df300mr204704wmq.6.1700689496992;
        Wed, 22 Nov 2023 13:44:56 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:309f:a860:c565:1fc7])
        by smtp.gmail.com with ESMTPSA id k27-20020a5d525b000000b0032ddf2804ccsm375746wrc.83.2023.11.22.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:44:54 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
Date: Wed, 22 Nov 2023 22:44:47 +0100
Message-ID: <20231122214447.675768-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller discovered that if tls_sw_splice_eof() is executed as part of
sendfile() when the plaintext/ciphertext sk_msg are empty, the send path
gets confused because the empty ciphertext buffer does not have enough
space for the encryption overhead. This causes tls_push_record() to go on
the `split = true` path (which is only supposed to be used when interacting
with an attached BPF program), and then get further confused and hit the
tls_merge_open_record() path, which then assumes that there must be at
least one populated buffer element, leading to a NULL deref.

It is possible to have empty plaintext/ciphertext buffers if we previously
bailed from tls_sw_sendmsg_locked() via the tls_trim_both_msgs() path.
tls_sw_push_pending_record() already handles this case correctly; let's do
the same check in tls_sw_splice_eof().

Fixes: df720d288dbb ("tls/sw: Use splice_eof() to flush")
Cc: stable@vger.kernel.org
Reported-by: syzbot+40d43509a099ea756317@syzkaller.appspotmail.com
Signed-off-by: Jann Horn <jannh@google.com>
---
Note: syzkaller did not find a reliable reproducer for this; I wrote
my own reproducer that reliably hits the crash on an unpatched kernel,
and I've verified that the crash goes away with the patch applied.

 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a78e8e722409..316f76187962 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1232,11 +1232,14 @@ void tls_sw_splice_eof(struct socket *sock)
 	lock_sock(sk);
 
 retry:
+	/* same checks as in tls_sw_push_pending_record() */
 	rec = ctx->open_rec;
 	if (!rec)
 		goto unlock;
 
 	msg_pl = &rec->msg_plaintext;
+	if (msg_pl->sg.size == 0)
+		goto unlock;
 
 	/* Check the BPF advisor and perform transmission. */
 	ret = bpf_exec_tx_verdict(msg_pl, sk, false, TLS_RECORD_TYPE_DATA,

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.43.0.rc1.413.gea7ed67945-goog


