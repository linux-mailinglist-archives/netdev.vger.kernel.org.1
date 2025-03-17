Return-Path: <netdev+bounces-175267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D7A64B47
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35434169CDD
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5C239567;
	Mon, 17 Mar 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="JhDTdWnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E312356AA
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209109; cv=none; b=TtO2Mtg/fN2e8oCVT7Ox1BcTOdrDRc2vxT6znwL3pFKSLFjp43z2qoKSARepOvG9xO1QKrKV45J6XesRplyHsplTzYRrLWqRPL+XJ88GbrrxM/MiS9AmsIvNTjflXJBIX/6NNvIPeU78Xpq38Wu8SWpXO+MNGeYmR7TBdgZvbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209109; c=relaxed/simple;
	bh=uj6BiB0IqVm8+xs3f9Zn6aCjK6f7zlPp0hv2djTMvTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=YDvdrcApE6xgw9atv9SFXr9HaNdv4rnx8h/G9L2YfeBZhskVqzVt+Uzwtwl4B2yYkSAPxZsRNblHmoXSHBPfIrJsRmy2Gg+91u8MyIjyJkezRRU/UA9FokGBK/5WNgVItM6ZkGYCNuWv1NsGQx0NlWVU/bFUA3YsZIHTxGvb4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=JhDTdWnk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-226185948ffso11408205ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742209107; x=1742813907; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=JhDTdWnkWTengsPMPkeyo1QZCS6FfZIqiLpH6pIyZPbEP94MvsL4E8m7EPQp7W3sB/
         l0rB2Z0KtyhrUIkHAql6I24dqGU6BIo5lz4bBFKbV/S/ITj3fWlRSb5KuTjbMdCj6Yk1
         J98azBh0ZwLCy9hYuStfeVXLWAyAl6ankKLy3PlwmZv+tf64MZ2a+NBBAJZtZ7xrnmyY
         uFuwOe2CKnZ3aUiAGEnE4rmN1sV8iMrZmpYlP60F/KjumYzWFF3Or2tcO81+Cn94ueVU
         xeTiP2nYrx3B+Z8BNWPCyI5G9t9YdLbrc9sqnPFD5Ej/+jzoqRwdWm7itDmZ6ST3Rlfw
         exiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209107; x=1742813907;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFouu/EN4lEKQm+2Nyv7q163Sd7hDT7Qc+wcMAoVrxU=;
        b=Pz8FfOZSuLZXa9duaZc/t9i5q15zqLSiWcbrZZ9LaZqIlyKsmoN6WGG5zDTYPK6vk0
         mi3HGTkrqUguTMQiHyM86Zkb3DXEM1LuwtUuyFg1JuEWP8O1Mn3Nsy1w1pUUZmX4CSXa
         amSP1Ey4rKGPXSwIUMms/PSQSnDB9ea7usMJE3ML1F8kzQufnHzFWiWRuzGfWUvYlmA6
         Ymkqixmjm4GlI36h4o5n7UOOXEKdbOkQI3epApIW9IGTv4UxafpJyU5nrbHzpOGUEi6N
         JRvIZbDBKGLrALTE9/kG1m9WAhcRvSunFaOBI3sHUd6v/RVGsZcETaa0LhJZLsBsP7ad
         8vvA==
X-Forwarded-Encrypted: i=1; AJvYcCVvpe82G5uoKiKYsorOr4QSYHJgmXmIC/dp8AfJg2Ebyh/5NDfidB032Fvm7YAsHTFekWYFWVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DQhBL+4cXbhH/46wPWRXGJmFEvwFbrLjvMKhiea+IYmAzRZC
	t/fkZLiqc44yxjCEBFYkdZrZ8uPiwLAwM0zcT+sbyt4FtMOzWP8h2nQIcCW+CDI=
X-Gm-Gg: ASbGncumxZsfUytUDva+wB2+E8ymR2W1kcPhplPyLrWoaOdQBmCXAXlfC684v+kidBs
	6ZLfd+9YGoLmS/okuHULPgf0S0J/VQnbokJxgtQnsvrwm5R7FHfHv8/oeCHm2ZPcqdVXORUbSx5
	76ey34tCe4WmSnGKoSdibFeDDkUleW/pLaArio6k9g0j5PmoSLFrKrgkokOCeaNDKWO57qPIfDo
	zJk/a4WcKY+NfooZdTbW4ev12ec5obbMIirFn4wiENHTQxb35A3EEtOzAGXdvnnD87bj1xQlgp2
	JV0P9lgGtBHru99BSFjX4tC+6Jra9t1U1a42pLlZapgvHe3P
X-Google-Smtp-Source: AGHT+IHGq79Rsv/kZfRVhSkItW1GnSGSGi4cX7skmUfl1fStmFO3ltKgY+5Iw+7Yo4D17wVag2aDMg==
X-Received: by 2002:a17:902:d542:b0:223:58ff:c722 with SMTP id d9443c01a7336-225e0a75b3fmr179867305ad.28.1742209107158;
        Mon, 17 Mar 2025 03:58:27 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68aa906sm72547105ad.88.2025.03.17.03.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:58:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 17 Mar 2025 19:57:53 +0900
Subject: [PATCH net-next v11 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-rss-v11-3-4cacca92f31f@daynix.com>
References: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
In-Reply-To: <20250317-rss-v11-0-4cacca92f31f@daynix.com>
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
2.48.1


