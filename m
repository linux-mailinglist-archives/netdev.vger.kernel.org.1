Return-Path: <netdev+bounces-142548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3C9BF93E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1915D1F224F6
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6020E33A;
	Wed,  6 Nov 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VWerLxFZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398220D4F1
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931990; cv=none; b=qplveRICM8uGeD+clmRQNYvqjxSl+dm5PuJtKdRdj6FQ5m3b3MSXugQf2RQ8De2GfGjhD3tjNHqUlH7CR1OdidcyKvRPRf1kCoqRUYSaEbUCB3i5XVRnUT7fvoseyh50xkgXi8o7gKJxZz1XUXcXMfD1cuvQdtebDOZn1CgXekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931990; c=relaxed/simple;
	bh=992mL4nu9YkF8+FFrpmymEGtYiWtLoYnRcBQBHxN1gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erm7ViumgtyOFbAyH1QMu8m6YDVLR87pWpsQoQZjz8BhH6fgSKVapSqzQ7SyHy4yPmlEG5RX5adDsjXCKYzxyuiVuAd0JfYyQnCtuKQUdJDXBC5qmgu/+NulG1Qs2y6ZwDZvJSrn7oTGqJ4Lrioe1DDiCv/N00C3eabO3eNJYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VWerLxFZ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71850708dc9so296819a34.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 14:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730931988; x=1731536788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWrBsyggpZaGrTIso39oj3Q+5T3iMLnbjMhz4XNdMpI=;
        b=VWerLxFZIoK4t5z6Dn/w89a0j/i96azcBHLiuzf3ZO3pz2I8J8NnCUkOrCKDaF2iTO
         gCmYjT5AVrnTjraS7fdsQojrRDu2rzqXdx7SHR6t8gtm1N859w9FKOns36e6ihagsadH
         9LWkvF0RGyYT5ICbNGZOuk8vNbuCtN9rbQtxjtVvERxC41w/aXcoRXjKXEOK5q3JfDSO
         WQQfELOPeKJM1cirr6kcil8F2U1NYO1QU9vf3YQ13KoM+Xhwgmt0RKEFdu8ohRHPasSD
         m6krx4+tsW0I1o1z+zVt86Mv/E9uIp0DD2h6321efqDZmzJKwjv81WALGmw9VOELY516
         dfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931988; x=1731536788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWrBsyggpZaGrTIso39oj3Q+5T3iMLnbjMhz4XNdMpI=;
        b=gyEV2eUAa0n9i9LN0Qbnc9gEDuKcqGQIpqN48CD5U1r/8UuWOwLpsYZ1NAzmSL4v5G
         4/20IzjVjCwfo5qwZz9LsBTMlXwTA+dDeJPyQPDMdL7HWIwW7iR1Y3Vkr4fV9tackDpa
         UHaduBci7aZYaK3o1tO9y6mnhrpSC0bhc2zTDXUo7EFdh9FphUIjyw3IHE49JrHRsVm5
         ud3Cbwp+zHGfIrUr74K4OOYgpymtE49OKibfN4yQn6KBcAfuqtIxk51JkCyQPNAbaIjK
         LgNlfBjGogUapxk0elfthmX4PriKeL/+KJ1BRr8hWY4GOUlcrPQA6X4iL5Bj+vYOVnpc
         oBQA==
X-Forwarded-Encrypted: i=1; AJvYcCX0k3ZYZb9ZA+iwZ2WVXta97Z1EJGzIhC2Qv7vF57nZZzUAUo59WpoiGCtgne3TkeXobcOeZNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfzSgGVn5jEQCy43M53y4JOc5OI1wuc0UU9RKEDcHIElX7rLp
	1AVBh+RV+6Nn/FnmZxTZKxQslSeoOf2IisFIIPe3+UNtMv0xhFKF4r4IgXqqprM=
X-Google-Smtp-Source: AGHT+IFoo5hLK6lAdsyo3xBYfefR9VHgDBvYV+6gr6X2lyb5TjyxhOM6zzGvdMhgspnPSqspWJTH3w==
X-Received: by 2002:a05:6830:2817:b0:718:ce7:9b62 with SMTP id 46e09a7af769-71867e668cdmr43546733a34.0.1730931987931;
        Wed, 06 Nov 2024 14:26:27 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acf6c46sm2536585a.127.2024.11.06.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:26:27 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	cong.wang@bytedance.com,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf-next 8/8] bpf, sockmap: Fix sk_msg_reset_curr
Date: Wed,  6 Nov 2024 22:25:20 +0000
Message-Id: <20241106222520.527076-9-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106222520.527076-1-zijianzhang@bytedance.com>
References: <20241106222520.527076-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Found in the test_txmsg_pull in test_sockmap,
```
txmsg_cork = 512; // corking is importrant here
opt->iov_length = 3;
opt->iov_count = 1;
opt->rate = 512; // sendmsg will be invoked 512 times
```
The first sendmsg will send an sk_msg with size 3, and bpf_msg_pull_data
will be invoked the first time. sk_msg_reset_curr will reset the copybreak
from 3 to 0. In the second sendmsg, since we are in the stage of corking,
psock->cork will be reused in func sk_msg_alloc. msg->sg.copybreak is 0
now, the second msg will overwrite the first msg. As a result, we could
not pass the data integrity test.

The same problem happens in push and pop test. Thus, fix sk_msg_reset_curr
to restore the correct copybreak.

Fixes: bb9aefde5bba ("bpf: sockmap, updating the sg structure should also update curr")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 net/core/filter.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index fba445b96de8..00491ac4598f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2619,18 +2619,16 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 
 static void sk_msg_reset_curr(struct sk_msg *msg)
 {
-	u32 i = msg->sg.start;
-	u32 len = 0;
-
-	do {
-		len += sk_msg_elem(msg, i)->length;
-		sk_msg_iter_var_next(i);
-		if (len >= msg->sg.size)
-			break;
-	} while (i != msg->sg.end);
+	if (!msg->sg.size) {
+		msg->sg.curr = msg->sg.start;
+		msg->sg.copybreak = 0;
+	} else {
+		u32 i = msg->sg.end;
 
-	msg->sg.curr = i;
-	msg->sg.copybreak = 0;
+		sk_msg_iter_var_prev(i);
+		msg->sg.curr = i;
+		msg->sg.copybreak = msg->sg.data[i].length;
+	}
 }
 
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
-- 
2.20.1


