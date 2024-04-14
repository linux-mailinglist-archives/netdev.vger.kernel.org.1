Return-Path: <netdev+bounces-87735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5298A44F7
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2EB1F21128
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 19:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45404136660;
	Sun, 14 Apr 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5zh40Zj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E344384
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713124377; cv=none; b=RCTuYsuWAJ5vAl4etkQIFrud0mcBoRVqvq6iwJUg3iziPqcslPlJ3K/nC4UnqFTwiw6+myjnVY9ETDQqAUBRh0KQ6hJHmvqd9kErQBHQEmt0rydRwcnmm6H4OKQJHvQqrAsKAI2g+jbJSYrn29voyrh0s4KlvJHrhoKFJlIdVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713124377; c=relaxed/simple;
	bh=QuRmtuyfolKt+vUhXl7x9sOGSnYKVciAbPW7hLrW1Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XISHYZltKh7oMeCsdrHdf+jANU8ejcN00Z9chZxBn7XSnSa+WPnXP6CkKUK37iMRP1u4mzlh6vfDcSC5qPfcXaQR8yZlKuU1asHf6bJx7m+tTyxTXvcUzLN6CfOVzA+puxj0WYQiapFttpeEy5j6CDa65ZYUPHS77uIfDoHFREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5zh40Zj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a7e19c440dso496885a91.3
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 12:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713124375; x=1713729175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sr4FP5sZpVqL77IPYzDVBxqo9NC/TYNBhRfBFOwzmNs=;
        b=B5zh40ZjYNhvE7IrHXqYlxkewf1JNmhMi6nlJuYNB+9FG48/PuNFTe6H6/HpJPy3q1
         gOsEEGj6c8yWesHnaIVZuRRGYFz8r1Rnme1/YMGEzjC4hc9n5ip6q9VRpRcPTK/kLih9
         yNml5aZBFD0YBYZgMr1vC9rZqAf8GUFVpjOfn6/pWF9OW0+CCbbtmjV94xX7siEEiEAC
         NutmQSahdzf31rNwa2hNd00igUbjR3uLno2apCjSzMgl5zhmHE88eiUJjycflqt8Uq3N
         8ylPaHn67ru6hXc3bSmP9cqYzSqjjQ2knphhRVD3MwrTM5hB6MEUaP8yJd2Yvij/5wcz
         vhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713124375; x=1713729175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr4FP5sZpVqL77IPYzDVBxqo9NC/TYNBhRfBFOwzmNs=;
        b=k19Y09iqR08un+DR5gjUeVf+3IuFESi3M8PEkExfpTwVhy37Ql4S8xAFteQxSDxMhL
         nnQrRNy1s04p9oxi5DGTM9RII3zY2iHkLBeWu7U/2jaR0+i9VyrUOj4QStryJee6bXts
         wgdR3pzDINWGpqvc9524KuuC0Ks1xoybY1MWBYUOKe4jMK3aMOIMeH+lfmhjLCW8TgHo
         j/C/BLoP7JrnQdCIm7j3+5Gn6kLocrdUa5v/3UtEKZZGSRtpbDrc2pZlN1W9oxGnNlDF
         HjCc6yzncxzqwoO4BB5qDl6eE1VCRlRme+4T6OKBAMD9d0LBLmcDKpN4nMBwGWtqJaBC
         ivZA==
X-Gm-Message-State: AOJu0YyAlgnviQfuEA41M1Ij+SOkGZLI1BKnZerjqKM/QScxv9eGXhmF
	j4VJrSiu22DepdDGp1ILZBoo0NruAfUT0Q6Xz7plOzBIgINpI+n3Stytwqxnn7vIzw==
X-Google-Smtp-Source: AGHT+IGdgR4UV3yvWSKC7XN27wSF3TSa5BndPBATRY7jV3VvvRJr9kKXJobDANT/A+ID9+7johna3g==
X-Received: by 2002:a17:902:7616:b0:1dd:bf6a:2b97 with SMTP id k22-20020a170902761600b001ddbf6a2b97mr6531106pll.60.1713124375122;
        Sun, 14 Apr 2024 12:52:55 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id t15-20020a170902e84f00b001e2a0d33fbbsm6378445plg.219.2024.04.14.12.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 12:52:54 -0700 (PDT)
From: Yick Xie <yick.xie@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net
Subject: [PATCH net] udp: don't be set unconnected if only UDP cmsg
Date: Mon, 15 Apr 2024 03:52:13 +0800
Message-Id: <20240414195213.106209-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
"connected" should not be set to 0. Otherwise it stops
the connected socket from using the cached route.

Signed-off-by: Yick Xie <yick.xie@gmail.com>
---
 net/ipv4/udp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02bf011d4a6..420905be5f30 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1123,16 +1123,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (msg->msg_controllen) {
 		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip_cmsg_send(sk, msg, &ipc,
 					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
 		if (unlikely(err < 0)) {
 			kfree(ipc.opt);
 			return err;
 		}
 		if (ipc.opt)
 			free = 1;
-		connected = 0;
 	}
 	if (!ipc.opt) {
 		struct ip_options_rcu *inet_opt;
-- 
2.34.1


