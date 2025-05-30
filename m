Return-Path: <netdev+bounces-194310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7332AC8776
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 06:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C703ACFEE
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD121129A;
	Fri, 30 May 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="br4sWy7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C720E711
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580641; cv=none; b=Bir0vXipJkQKtKwzPea8Hi5kpfZgXWtyP4FRcRZS2K7aoTemMEwJUSbhPmz9srUE1bWqPSFmeft+uvdluPjWiWzsrqLKpqXg8OrY0LzLi7ZRIe6c3/DN6EhdnXHn9iP3ob1l3j8jb6y14BHs6AB1bVPgmaPhhgbHq9Zj4HwNtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580641; c=relaxed/simple;
	bh=z6KshIl6HGgt4ZleKE35r87QcaFqdHr3p/xqcA1UR5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rL9PK3QmEexJt7L+F7c6mfYjGEU9M4UCk+JKRFCoaSIRE6OkpO2w/+9knnEzF8HITgugj9chwSRXy1jEsMhxhdC5BVZCQj70A4CQRa9ol8TL8jJGxK4wxMqTZCnsdmqxZVQmuTztVxKsOlYT6922dJvov3jGGCqgNfyMqJWyHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=br4sWy7K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2353a2bc210so1343825ad.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 21:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580639; x=1749185439; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NOE/sRdLPMAnoL0j8jc6LLcC7i1+AiTcrUdSGiZf/w=;
        b=br4sWy7KqNVoAgmcfCZJRLKTceBgSCS3Ojitq6wElltSfRuLU1olzE7rjNrzZ37fMG
         M9JdZpXgGc3qHrXSVASAuFp8aPiCuwnqde3PWJW2Q7iEnwY8LaQATGX9XcHJQ2pbSdlo
         1Lry4qaLIhiFZUtFSjRUpQvhH5Fvi+TNQNo5ABN6uhXH916k67P6jgKZnGzUZtgpJBtn
         +DZKsITiQOcROBxpM1cCjX11Ag0B0jyNRKxb1zlmb61dHNfWEw3sKdU/waD414CmZVqe
         YNmnpKlnH2MQp1Kq8z7GKWGuWk32hLhaoxbHjm+E8Y7Db9kuKYt8fzwXbH4KrXIJWWPv
         sOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580639; x=1749185439;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NOE/sRdLPMAnoL0j8jc6LLcC7i1+AiTcrUdSGiZf/w=;
        b=fdOfuOKN6R1q+Z4Y+6NxXgyh7cfskBK0O+niMDs8tfjPEs/TUH5Cwf7bgtZy3VkaUc
         XrYu5yOOsEEYN0/V44hcmR1L1YyJxVKpoFp8zrVQA+lCBCLDAx3dkPzCD4wNhBc5fEbN
         TJ99O3TyIxhfKNkCa0VChbXrLOcQgOT5rF8C4nmhE7hjSZRKXnJiMZhi8WfxMHWY6RNl
         F8wA0JoShAZfQggghR+rwrMUTTPrQ0IqeoqmdqG+GUqBW5Mc5X0dq4D0PG/55mrfTotM
         /4GeGohh4dwJ/SbkjNNUS0Au0oWRm0qNUCu703MtXAgbJbRzXhIokvYa0Odf+UFeS9N4
         JEHw==
X-Forwarded-Encrypted: i=1; AJvYcCVTPkH+z92tRM7xf3yvpQVNsCs+tCo+oE84nVos6DocBcVg1iflRImzEh8cHlxavg1t/Jl8JWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINqwzXytNm/TtP7YrfnYiaaoAr2XYZH03tirZgX2Qab7EMwiF
	fY1LLJFqJn/DWzZ8cKy5dBATn3Xr7JFH9QG+u046MaMozK/ZipypE2AdGKG19Csecy0=
X-Gm-Gg: ASbGncvPmYfQ8cI/t+YHvquu9y+/8oDCwiLFwQjmKrv5DzJRw/dLVl04stT8Nwmbp5o
	X2x6FmshAO838ccuXpyVAk7/RLXVDc21DfCPUNblCT+fFb4VSeY9GikqJ2ugM1GBmlK/l1nXqNV
	C/F6I0PynqK0HzbiMWMMi338mlUqRhFOr3Lw4Xn4mLyoL3EVve2pyQaDPvu+vSc8Rjcnkb2idaF
	P4e4pE0Wdki+Xv+Gktwoxxu3GlM+b9J8L8eoqzLlTfdXfY/eW+KSKF5xbllUpLqYDSTIkGbpW4x
	W8+uVFaMt5KyjnhUYds+IJe3pWOzNVEA5061LY+aiMxFmN8f9BqP
X-Google-Smtp-Source: AGHT+IEeXcvMFrg0nyBJT3UCjMm5zR9avBrulDbs9crdoWtGa6Ob/x7/c2QyfE4WnvmKLh1jLX4/8w==
X-Received: by 2002:a17:903:2f89:b0:234:eb6:a35b with SMTP id d9443c01a7336-235396e2b3amr13431015ad.44.1748580639345;
        Thu, 29 May 2025 21:50:39 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cf9181sm20055655ad.187.2025.05.29.21.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:07 +0900
Subject: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-3-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

This clarifies a steering eBPF program takes precedence over the other
steering algorithms.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |  7 +++++++
 drivers/net/tun.c                   | 28 +++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  9 +++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..9133ab9ed3f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return txq;
 }
 
-static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				  u16 *ret)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 prog_ret;
+
+	prog = rcu_dereference(tun->steering_prog);
+	if (!prog)
+		return false;
 
 	numqueues = READ_ONCE(tun->numqueues);
-	if (!numqueues)
-		return 0;
+	if (!numqueues) {
+		*ret = 0;
+		return true;
+	}
 
-	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
+		return false;
 
-	return ret % numqueues;
+	*ret = (u16)prog_ret % numqueues;
+	return true;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
-		ret = tun_ebpf_select_queue(tun, skb);
-	else
+	if (!tun_ebpf_select_queue(tun, skb, &ret))
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..980de74724fc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -115,4 +115,13 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
+ *
+ * A steering eBPF program may return this value to fall back to the steering
+ * algorithm that should have been used if the program was not set. This allows
+ * selectively overriding the steering decision.
+ */
+#define TUN_STEERINGEBPF_FALLBACK -1
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.49.0


