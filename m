Return-Path: <netdev+bounces-162881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B9A2844B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7B1884C0E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E99221D8E;
	Wed,  5 Feb 2025 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QH5FA/9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58282288F6
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736561; cv=none; b=pNwxU1TsiUYTg7XmCtWkSYInUUtFF4IPCIO53trJ1o0wfEMh+4X6u9eRFZSBm5qsLroOODnl8Ruv8rAaYn/oXuCYAcC0/WrT2W3OxQvB4ZvsDTi0/9ZstUtosdFQfpoOae8v4uZ8u1OqdNSSoxfpSQgsW9bY93dNmWqfB9pGIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736561; c=relaxed/simple;
	bh=k8AT/7ba0LLNdr42q8vL3zcMMHDDU7sY3oym4vZIyT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyxwjLhNFm2czTjeuHcYmJmkygQncWW9U4c61BjJqBPokYRK56nDU85Ln111LItTh4pY5e0Lo7NxuZAy2s7nqaVkO91X/jHKMnphjT4XC99QGJAhh25v8VfX0qa3/xs8AfcgyLBrvKq4tru4AQqd2vVHHrjNmKnOw+3uZdjDEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QH5FA/9x; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9d627b5fbso1765188a91.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 22:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736559; x=1739341359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beCLR6fS0dAzFFFSsVjnikGsGyHpeeQQjgoShxHI8aw=;
        b=QH5FA/9xqt072asZe5B9//N3mO6mhAz+QH/YNmvtldGolQMWlwGYejVvjtBamDcLp4
         S6ABuX9ImmCgHuvcGRlduNyYiPZ5Ydnv6kd6W5Xq2yUVlIAWtvQq4XMXWF2cYZKvo3Eh
         uQkU7w1C8VpdJCvld8Kou4rkgUbYgYJyzSFpeAY/X27K75fn9vbOUNeoAUzsny0D10r+
         WRZlVSmQDZy/9RoLIlECHt55nk1Oec1qM4I5MNXLkY53o6IqSX4rCU/evEQaT3gYolQ4
         SiiiPIVmcVpAqx99LvEIWfjK5BM+ZbyGdNS5WxbeS2mtKWsc7Kqone2ve8NCNXQzmyMz
         QR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736559; x=1739341359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beCLR6fS0dAzFFFSsVjnikGsGyHpeeQQjgoShxHI8aw=;
        b=GhvWD4o2Y4TLepM/Dfc0rPtAz0A2ygj69/lNx2r1CNMErsV7MHveMlB7Pcod8Up9yP
         8u/qR6kRGhYVmZi7uGubYTqBlfs36ubrAib1/ocuxBQqu5/BlETpbhpgeArXUONiJP5N
         iBPU0IFz1WNjPH530tUzerh5MEmdxY6IFpWPImngpNPa8Hv4gM2QXmDwRZlGfrNvSRxo
         xbFm9BgLpBsv+pdvB8nF7w5a4H6UgBrBHp/o6NY1aDQziibpTvINEGxuM1DGasYYefg+
         D1VKP0fAs2cRJhbuyMuy/+Rof72+a14ZjRggo138lajJUsS1BznvFXsaUyqT9QVh6KYa
         jxvg==
X-Forwarded-Encrypted: i=1; AJvYcCXZCsLIB5U9gB49aPvHAfo9Ng9oRVGS0cJJsZXWzcZakwIVgahaskMeUKS6zuSM5WjGeZ+/xv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzql4L4EPEiZed9uacdmbEL3JoXlsin6zAzgdZ5EnOmQuZ76SAS
	Aca0PiBUwCafi3Pii94HBFypS2emQEB7C2iOYT+iDoKcaHHhJtOM7SQu9yq1/Vk=
X-Gm-Gg: ASbGncv1NjIjVleh6ti3P6xYg2zXLZy3+1rM25tbXlrNer+B/+ObVbA8a6qrljao7uz
	IboFRQBli1FbPHVxiJ1tn0ZkWpamaXj/DTZLzJOBJMJBpqnRrTfdolciaa2dDt0cO0jI02XNsXZ
	r7O+dt4lrF2ueY6o8vzWM5cBgoybmlcNjceqWMcFS7MOzxEOfAnO7B8TcoCRgmAU1VwYUSF6boQ
	3s0rRiTu88jzVGXncP+62veUVDsfYALRNwXhVt1kyuFkjwogwul6gxG5QlbrErjG5rDL5fhNtH9
	zczpiuDiLwOTL6kT6Ac=
X-Google-Smtp-Source: AGHT+IEkltYiingUuvZ5OPE7k95CCEI+ZGRFDs15kcTYl15oURn0Qzmrf04BT6IAVXnOElwIy1y3oQ==
X-Received: by 2002:a17:90b:3c52:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2f9e079b0efmr2575681a91.20.1738736559002;
        Tue, 04 Feb 2025 22:22:39 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de330462bsm106232865ad.204.2025.02.04.22.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:23 +0900
Subject: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
future changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
 static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
 {
-	return tun->flags & TUN_VNET_BE ? false :
+	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		 (tun->flags & TUN_VNET_BE)) &&
 		virtio_legacy_is_little_endian();
 }
 
@@ -309,6 +309,9 @@ static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be = !!(tun->flags & TUN_VNET_BE);
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (put_user(be, argp))
 		return -EFAULT;
 
@@ -319,6 +322,9 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be;
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (get_user(be, argp))
 		return -EFAULT;
 
@@ -329,22 +335,6 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 
 	return 0;
 }
-#else
-static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
-{
-	return virtio_legacy_is_little_endian();
-}
-
-static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-
-static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_TUN_VNET_CROSS_LE */
 
 static inline bool tun_is_little_endian(struct tun_struct *tun)
 {

-- 
2.48.1


