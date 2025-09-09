Return-Path: <netdev+bounces-221220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF01B4FCAA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7A71BC77ED
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6E33EAF1;
	Tue,  9 Sep 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGQ1gNTm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE430DD01
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424174; cv=none; b=OWGaHWbRgNo53s1Oycs/q4tS+zOIUjw8fwV9/uZj5NzPEy57kjrzIP6bVamGO7p5A7AmZF5zycKySpeca1NgpgF/jPU9sK7fWC6+0qJsSjeucbgejFYwUg/ycIAE4GI7Xv/C6LxUl1JVUdCyntv4/4vFcKd2bwZtTWLXOUeVVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424174; c=relaxed/simple;
	bh=kAoIWg0eouVwlZINqB9hM9ZgDWPys75E8dPDrrUOVRI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bcc7fXKgxBda+cDQI48i2HW26bT32qIZi+lQNVuRSzhE+ZE6CF55sAneX25Oj/nBWTC7Ifxi7AdFUK0eEn8AFgN7DDANF7UuFmIW5pLhWARcDSumw8Qwe3yhWVIvcu6McTbXrOo6UAxGfFAZXpWgYMpMVltz17Wf713In3ymSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGQ1gNTm; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b5e5f80723so121450741cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757424172; x=1758028972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uchVPC5V5AnCU++0LQSE31dfyzhx8FL2wjNsKVYAXlI=;
        b=XGQ1gNTmJSgz5hjFPrtuVBGnqeKdf1jj/8mf/pZNeqdhyJkwTnWjQEnqraShpxMxti
         CU6WcZm1JHOrnR3D0MTiTAriv9nU1GeFNJDODjehxQNuzMwpevMhw0Zff5VURVLXM2dv
         5c9LKOSP1QfwHX9DgylFmNR5nYunILLJaANmrr387Lb84helrD1k3uK3NszUBAzT8oWT
         qKKRIVELjQXlqwK64Md4qW9tjMuYBGZUrd3U9HyBJ73/uXZo8phM1oMkN8p7bxDVylka
         tU9ldJnU9FbIaYZdYylBhFCA8xad0mdklE4HKWvs02u1Ls3WkAGFj/YH1pYERjm9UJkJ
         2rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424172; x=1758028972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uchVPC5V5AnCU++0LQSE31dfyzhx8FL2wjNsKVYAXlI=;
        b=Zv6Y9ClI1ypEjCuuT6eUYC/b11WTB/6tWuHAixtLXkjyC/87qlPuLdEhEJl5u39Q8M
         If/2lHpoZgoBzoVLlPMI2ntkxQ0uwrG2ety9zc3nb8pD1vaIeGX0neaRVMsYiCK8Iy6R
         wvKkQ+lL+9X8wBcUv3VV8qYFb/uIOjde+1wymP9VsgNyz9nADcq/rzcx4oUH7wOCmsZK
         wdqsa9BI+FSqRZGXIsM7L8itQGTpqoDrdnFOz6tyUa6/7CU84Y2SzJbuN9Jz69fBBwNu
         mjXi1WNeIAkmGsz1jXIH/H7WzRH1eIxbltMLrKnpDSkElIMPvd4deSusSi3zndhXzjsO
         CUuw==
X-Forwarded-Encrypted: i=1; AJvYcCXZpzICSBBGr7Rn0ntgxGrosTFuFeUZzBGDJ8hRZteE7L6jbUe/m0kcZgF7a6lwAfLEHgfsopw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNG25X08XZkX3ldC22bUwYe2hdkOu7010GnKD3KpiS/kbsn+u
	2LsYry/2X/Hfb3qBrWS//Pv8zjW52xEYjYr+vEkLieXJuVFJkcJsQAwXCc+DpjZN/cq4jmPiT5D
	80XHgqHoBmXr08A==
X-Google-Smtp-Source: AGHT+IGYpVQiEzn9QHE1zn1hAW5xwDjdaQLoTNKxPgWkv7gyao/+uTsXb3LQmW5bD0GeIq3wlXcgPuI+F3/c5w==
X-Received: from qtz5.prod.google.com ([2002:ac8:5945:0:b0:4b0:a157:1d5b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4b14:b0:4b0:da5c:de57 with SMTP id d75a77b69052e-4b5f844d1fbmr103893091cf.54.1757424171653;
 Tue, 09 Sep 2025 06:22:51 -0700 (PDT)
Date: Tue,  9 Sep 2025 13:22:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909132243.1327024-1-edumazet@google.com>
Subject: [PATCH] nbd: restrict sockets to TCP and UDP
From: Eric Dumazet <edumazet@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"

Recently, syzbot started to abuse NBD with all kinds of sockets.

Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
made sure the socket supported a shutdown() method.

Explicitely accept TCP and UNIX stream sockets.

Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
Reported-by: syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/CANn89iJ+76eE3A_8S_zTpSyW5hvPRn6V57458hCZGY5hbH_bFA@mail.gmail.com/T/#m081036e8747cd7e2626c1da5d78c8b9d1e55b154
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Cc: nbd@other.debian.org
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0cef71e73e67fecd16de4dec1c75da7..87b0b78249da3325023949585f4daf40486c9692 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	if (!sock)
 		return NULL;
 
+	if (!sk_is_tcp(sock->sk) &&
+	    !sk_is_stream_unix(sock->sk)) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
+		*err = -EINVAL;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
-- 
2.51.0.384.g4c02a37b29-goog


