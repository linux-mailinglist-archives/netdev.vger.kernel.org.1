Return-Path: <netdev+bounces-84954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482A898C76
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76A11F22E5C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9CF1CA8B;
	Thu,  4 Apr 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfWjl6Ck"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66A1C6BC
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249171; cv=none; b=X2+07pxR7gGv7OZPx+cEmkzyRDjygSRF+6qyiFQ8hXUChgllHg8YI4YguS4/Cuyat+YLbGv95gzT+Xzjj4YDXf6pGcic7Z8RSeDxNR0BgCuETjulG8ONA22EzhicOLJZxlOyRykUwx4nnpY+qL8/hzDI7S8nlI5TlOd7qmGlcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249171; c=relaxed/simple;
	bh=8f8/Z25ptY92lZe9oxyinhpST1NbjRYGzEP3V8/zzyA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mu7NB1TDmJ72yPjrwrnJsCEZ2ZjDx2aoHUhFdsNZfKtLN0OhdEVSQXPiAD2uLB9cCR+d6fyp76ZUf5DfDAulsWMozvPEXMp/slzTK5UIutJABpAcqK7XbPEJwjGtrRk6rNf1TEzCeHuks3Pypl5m2c/Nx049KmEfSE+falxm4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfWjl6Ck; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78bd232b170so121385585a.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712249168; x=1712853968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yBbvESACqSTfvxJP2t+JVpZjtbTx5JUD8l03I3THaBQ=;
        b=kfWjl6CknXE4osOhkujJZ3sdyaZcAioc8Zx7aQEn0teO4qbCBp2a8kttKB/z+7j9Id
         mTA6OhoC1VDNiuJQ0K+s0S3nxv9iDnBIeC3S+vnO/AFVlefT4vodmepQYY1VxOzUiIi9
         COQYAw03KRycmMLaV/BsGVKus+vXfXh4IVopOxYwXtCcE9BUcjmHdcxcfMyUmFraVGB/
         d33yoGJSH4QyUP2ABFQLIf7XvvGnVLRKcyCkfpY7iJfAaAZpMVUDmGgy74NxCMI0jKdF
         7xcLiCj/kHzSI1viosAmkRlV+4c8G5GvxqqCQdCZqPlLIUsyYKhNjsmkNCgvJktVKm/U
         89ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249168; x=1712853968;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBbvESACqSTfvxJP2t+JVpZjtbTx5JUD8l03I3THaBQ=;
        b=apAZCkDn6hGVZDPIeDZj5NzxGOPRBv2BiapUEw6fhiHft06DsmfuZ9GdgKCxlocE0M
         fpoQg1Cx1Oe/oXxTVupbm0a6KplgR7aOLhAjHLA7SutMvX9A+gOMAPVvAo89VjgsXucI
         76ffr0IJr/Kf6QiCcDpc/YLQbRVR7NAW+GoIYxeiYuycrhurMLsf4r43wdDXomeANISF
         65L6KaKXLup1T33960wAJGIqF5Mw9tquWq9UAcpOC0OAdcPJ4JEJQLl5O0e137cwPXoV
         rbcnBYLEjgHf3M+PlsjvGZ4tWXNHu4Z92pX4kjzTO71gcT6DkFztzdtmVJujO1ifcGCr
         woAA==
X-Gm-Message-State: AOJu0YwY7oKdfqwyXhMwPSFMT4Bx4FIGPGcvQvzVNQkSl+Gf6siE/WUF
	3Z8E6jtYMmcO9BgVWYZCIu/xN1rDKo3Ijlli5L4I5iaM5z2uhNhrna8k+P0QFQwwgRk/niz0j3W
	2jH71npqJgg==
X-Google-Smtp-Source: AGHT+IFfPM4udu2THrfOvZoPrSyji8qLJ1+Tyy0RrQdVzLj/tX4x8y7lMia4PfVq7SQsk8WMjOBDsA+JGdEMjQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:28c4:b0:78b:e8b0:f158 with SMTP
 id l4-20020a05620a28c400b0078be8b0f158mr621qkp.5.1712249168111; Thu, 04 Apr
 2024 09:46:08 -0700 (PDT)
Date: Thu,  4 Apr 2024 16:46:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404164604.3055832-1-edumazet@google.com>
Subject: [PATCH net-next] net: dqs: use sysfs_emit() in favor of sprintf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

Commit 6025b9135f7a ("net: dqs: add NIC stall detector based on BQL")
added three sysfs files.

Use the recommended sysfs_emit() helper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e3d7a8cfa20b7d1052f2b6c54b7a9810c55f91fc..ff3ee45be64a6a91d1abdcac5cd04b4bdd03e39c 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1419,7 +1419,7 @@ static ssize_t bql_show_stall_thrs(struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
-	return sprintf(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
+	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(dql->stall_thrs));
 }
 
 static ssize_t bql_set_stall_thrs(struct netdev_queue *queue,
@@ -1451,7 +1451,7 @@ static struct netdev_queue_attribute bql_stall_thrs_attribute __ro_after_init =
 
 static ssize_t bql_show_stall_max(struct netdev_queue *queue, char *buf)
 {
-	return sprintf(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
+	return sysfs_emit(buf, "%u\n", READ_ONCE(queue->dql.stall_max));
 }
 
 static ssize_t bql_set_stall_max(struct netdev_queue *queue,
@@ -1468,7 +1468,7 @@ static ssize_t bql_show_stall_cnt(struct netdev_queue *queue, char *buf)
 {
 	struct dql *dql = &queue->dql;
 
-	return sprintf(buf, "%lu\n", dql->stall_cnt);
+	return sysfs_emit(buf, "%lu\n", dql->stall_cnt);
 }
 
 static struct netdev_queue_attribute bql_stall_cnt_attribute __ro_after_init =
-- 
2.44.0.478.gd926399ef9-goog


