Return-Path: <netdev+bounces-242367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A3C8FC1D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 18:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4DF3AC115
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42F2F3625;
	Thu, 27 Nov 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0jYaSac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228682F3601
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265667; cv=none; b=RsYsGnXX+pAVIEUIOaI1TmB9AAFMt7J4cebd6VVK4fVKFs4vdyh9SUQLtBJhgMi+EDPCGs4O4/JN3lBYMwCo05WM00r1zul6/whmE70FJJS69PAm9zWQIwDHdM4Lk7Ls+p2H3mqVOCRdXwF5fJP/fN0C24Cq8YPklo1i3udIHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265667; c=relaxed/simple;
	bh=BRI81MYuXb7h8xyD8XLP96rM8Y/COrnSldLvFnFiQlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ld+M8CuyrtPmr6A7fJHqbPn2s4qDSG1Yfw54MjZf5UVqhNZ3FTAi15h5vPKkRPfGbuMf8cCbqujGI4MSceLkmzywlEvglkb7eDpZVKMZB3kNTwPnpK4u0X4fly1NzE8b24uwRduHDhw5OqiwaTx31M5TUEjTh/jsVS21mX+HhFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0jYaSac; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29568d93e87so10685825ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764265665; x=1764870465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRI81MYuXb7h8xyD8XLP96rM8Y/COrnSldLvFnFiQlg=;
        b=F0jYaSacv9Wwc3reFEH83i4RcNwDcldXqFr4PIQ6HhaltnZhDhWw6Y5FmvrwukO/D0
         1fUNLubZ/RC0I6Hfb/H5711FkrDBqxN2FMtpG0ay6VMMwlHFr5xCHqfUKL8u9Mj5JgVy
         bv3HqvYvL2Me+M3XnpwkhPYlDnB0bialuZlBbyzs7Xcaor3j8xwbSLwzNShdoIXMW2Vj
         pb//UTCjol9NfPB2PM0aV3dP7zvmyDu5YGKvyHI43S084ItDclo7Zs1b4pS5ERoDns8p
         8boRltxeRXFg7zMEOqhdp+p9ahfxSivosGFbozvZ9rr3dHNqjZ+14vEcXfJhW7wKLm2Y
         fd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764265665; x=1764870465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRI81MYuXb7h8xyD8XLP96rM8Y/COrnSldLvFnFiQlg=;
        b=vUGF7Bc3qMmHBB7cmI2p/wnX69j6WkH+QGuVbbMv+KLr9wTvIvjZI5U6Iv9VwTpc2y
         z1MLk35r+jljb0roFwG2zKpqA05x6EdaJUHbuJ02exWZgR/C6r2MJtMDPGfRQEgjLzIu
         uJiYrobCQEFHmgNJ+69hPJ8nlBBY7z/28ZNkJ1UhKZbe1l+0KB7yQLdYd3O7S33mg0PU
         yR4lUWa5vUcj1QK/Ee0LVBM3vRM8uegbwQNZYYh56pBVHMaI+U9vEXKwXoGpeEG7yY5F
         31a+EnxrVv67mNA5NDSStA0inM+6MZ3iTq7i51MVhgunJ44TeYUeSjWRzcGAhU+B3DDF
         uEZw==
X-Forwarded-Encrypted: i=1; AJvYcCXRrAwPlobQ0f1ZEfCdDKVCNgASSvuX8HbF59hLLRaclH+72XxXjDDKo4VclSaOptXEjEXeABg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNskws+bmnj5KZWBpyq8uFfJaaUgKjk4CHGBSuQrVAU2SLXBC7
	2w0ERCosUsF6NaU2IF6iD/uRuV1TLd3ZlxaBc4mrwz9ielg163f4LTvA
X-Gm-Gg: ASbGnctNKRpDTl+AFVEn7/Htx0Z9sfvCTmcKiiXi+uDQ9hPAVL5L4aJtM3jaIOHPrOk
	yzYafKwO2otyvP4CYoiEUDEEe6yO2UHYC7DZXVbhxGNV8zYbs2WdMQOhabwWeSZiuChNi+rodjy
	FbQ83z9zKvKUnnLqy7j9omQWneiRzv4uShPC+LrJBRkb7FdyW/R6Kl5X6CIeoAb0bL5cnQWLKXv
	exYsZTRRVFAJwQcHwXfQt73rBqIJm7WncUSViTiNwFBjU/b0icaGRnrTFhy7ZBjEeX4CZ+R4PEy
	juRCcJA9Dex1fgxSJ4dnjB6Plb6XW2+RWo331n++I/Fx/sUQ93MGzGGLZGlHJpvpwlZh1ihm5lr
	1OOkgo1XmJRpIm7yYQEYKzFu1zqYiAxEvLUqSJQDnGgWRpDObpxQ7hOszWTgvgBX1AZ07hT51tw
	2F98q4ce4jBlAvAGQ/kSEdYoeQsjnGtqP+RyixCGQj7sWBGaLDxwYhUZLL6Tx4l7y3Y2Slmw==
X-Google-Smtp-Source: AGHT+IFQMns4p7mYuQDAf8KkttHI4Vx6NTBg4hreeujJapPT/8zqqg74Cep/q2QlnjNERCvMI0q1AQ==
X-Received: by 2002:a17:903:2ecb:b0:26d:58d6:3fb2 with SMTP id d9443c01a7336-29baae4ee0cmr142565705ad.12.1764265665311;
        Thu, 27 Nov 2025 09:47:45 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:de47:e88:2ad3:8735? ([2001:ee0:4f4c:210:de47:e88:2ad3:8735])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40a5ffsm23791225ad.18.2025.11.27.09.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 09:47:44 -0800 (PST)
Message-ID: <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
Date: Fri, 28 Nov 2025 00:47:36 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I think the the requeue in refill_work is not the problem here. In
virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
use "even if the work re-queues itself". AFAICS, cancel_work_sync()
will disable work -> flush work -> enable again. So if the work requeue
itself in flush work, the requeue will fail because the work is already
disabled.

I think what triggers the deadlock here is a bug in
virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
__virtnet_rx_resume() which calls napi_enable() and may schedule
refill. It schedules the refill work right after napi_enable the first
receive queue. The correct way must be napi_enable all receive queues
before scheduling refill work.

The fix is like this (there are quite duplicated code, I will clean up
and send patches later if it is correct)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..892aa0805d1b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3482,20 +3482,25 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
  static void virtnet_rx_resume_all(struct virtnet_info *vi)
  {
      int i;
+    bool schedule_refill = false;
+
+    for (i = 0; i < vi->max_queue_pairs; i++)
+        __virtnet_rx_resume(vi, &vi->rq[i], false);

      enable_delayed_refill(vi);
-    for (i = 0; i < vi->max_queue_pairs; i++) {
-        if (i < vi->curr_queue_pairs)
-            __virtnet_rx_resume(vi, &vi->rq[i], true);
-        else
-            __virtnet_rx_resume(vi, &vi->rq[i], false);
-    }
+
+    for (i = 0; i < vi->curr_queue_pairs; i++)
+        if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+            schedule_refill = true;
+
+    if (schedule_refill)
+        schedule_delayed_work(&vi->refill, 0);
  }

  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
  {
-    enable_delayed_refill(vi);
      __virtnet_rx_resume(vi, rq, true);
+    enable_delayed_refill(vi);
  }

  static int virtnet_rx_resize(struct virtnet_info *vi,

I also move the enable_delayed_refill() after we __virtnet_rx_resume()
to ensure no refill is scheduled before napi_enable().

What do you think?

Thanks,
Quang Minh


