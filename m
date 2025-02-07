Return-Path: <netdev+bounces-163819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2372A2BB0D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0099918896F3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06490194A67;
	Fri,  7 Feb 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="Qzdq5QMF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB342343B4
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908670; cv=none; b=bOrmtmRp8KWNbvKci9UbpUE+/NE5kjtKGGm3OiW2IKHziJpSlNdF/xUFg6BZn3cq6EWeaWGdLtJx/AlFfmSjOPsdN1iW7g9OEIlsGOEA2ajtc0gS0HTi3Gn4oquOG61gRj+nC+72iR7h9MiQJNBZVcdizZSEf/Z7Lr5wVsjqY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908670; c=relaxed/simple;
	bh=cdUkce1+zju76xB2ulgsqkhH2BtZWQUF+tczDHuY9Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jRVyp7OvXElU41pKOhWUwO1DAit6CRN8LiOojWKXvdiJqSwGpWINNpbBk/a+u8BsTboWUIKQSmUf+y65toVU61YWbdLuBlSenFuwo0e2Q4QiKXSs/c2Dypgg4RD+R/VQP7EYNzhuW47zgBajt4mRt/x8qGz8Jr66m5Wt6TnpUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=Qzdq5QMF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165448243fso42213295ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 22:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908669; x=1739513469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8e6Q2IF1AlrwVhf0WEzy1BrH8KeyaluzZCG0JrRNn4=;
        b=Qzdq5QMFTDdclgtr7jpZ1OdQsvw37EwK69Zy1SuCQG+t9cohiUx8Nne7KfQU5/YDBV
         d0kz2bs7JP1y+I1fNGFYIBvhTv0Zo4RQayKiYxSTNHBFDTGKBp2LKi2q5qcmr809QspU
         Mo9+2+0Q+iZgV8qRKLYSUGn+bHWCUckSzEL1HkL1KTAGMZrbw0ZqPoi5ZtqhfW0ewwk4
         GeBuwTr2KO8kY6cMMO0XlAmaeaYRCWLxYBOvBcq+5vbxrc/BBq7FppCE01xFeWLoM+ye
         co3rtAN9iuL5PhTrX0oSltdAlDVpZxUSCkWAOmVO0OhNq3soAzQT6yma3G3WvtRlUVYn
         caxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908669; x=1739513469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8e6Q2IF1AlrwVhf0WEzy1BrH8KeyaluzZCG0JrRNn4=;
        b=Q/Y/tELB6NMGvnlRNm/ZFMzvEBPL3aP2FdmQCkcG80IwP0Ybm9yRc6D2VesjYbtWKA
         o0qNb7cv1fijKuiB2/7SjsMrfnmT4A7bvzsoAK3qfQLvSEMV/+QJRgv8RYmjqIsJXL2t
         tFo48HM51tCfRZhlOH/P4TwLAenSjabDs9x1vRU/x0cb0Mla4p7FO7EhaXLtBGkyUPzB
         igUFZMnZT6kq44QNInUtkjAxwTBto35Ilr5tvTVEpbjhxOcvACNwf80E3JOe5AZ99uF/
         C7EHbizcpe0wnLSHgK9hjOQrL76yd7mmxXVJ5zyi5059WoIPpeiBp+YHzxcZg5ABKnua
         qWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvTBnKrleim4AyeQaiJLgEnTZ4dcuboPZuo9Y8GOMAhF/UwhuWUZngA1+u624+bmBsdWHJ21M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczRwdZDaU5tkfLw+t2JkpyvqHqB+1GpdqXJHJaBD4ohtIciCB
	Bqfeq6/gHNVkOkrE+C3Uty3ter1/pcdWt6rRyQ/kcnPGEuY9Oyqafh0jbqxeLtk=
X-Gm-Gg: ASbGncvyGiLrrEHJUlESF9fEkLYkJ+u1fe3yF49GVZCMLPjG7pOXgXVJWlIhyj5rld7
	ItuuvJhq7caCXzEvy7zLh3d0wfmAWfIwuBR4gEh7KuY8/YA4vZqwLC0imwP/RWQsW07C+gFnLFr
	KgMYpaWkuSYZCtwsFZFwsiYzCILcb4H/TCDMVrcffyBdmsHZMTkHawxllvTkjKOmbr5LDLL6JWP
	3jiO7vry+9cbtvRsrTI9jJeZPpg9UfU04gTvYFQOga3mRaIO+DpDPl08HLQ/fqFaMEEuS1OH90/
	vwbZXPeHqMTgRC8jlow=
X-Google-Smtp-Source: AGHT+IHsiQFjzXezkiITWyryKLHFxWaOkXCA3VROnOenVsONjd60T0L0zqwo9kfDi5iWVlXHr3UF2g==
X-Received: by 2002:a17:903:19cd:b0:216:73f0:ef63 with SMTP id d9443c01a7336-21f4e7ae7cfmr37137465ad.49.1738908668736;
        Thu, 06 Feb 2025 22:11:08 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683d729sm22605005ad.124.2025.02.06.22.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:08 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 07 Feb 2025 15:10:51 +0900
Subject: [PATCH net-next v6 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-tun-v6-1-fb49cf8b103e@daynix.com>
References: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
In-Reply-To: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
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
 drivers/net/tun.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..4b189cbd28e63ec6325073d9a7678f4210bff3e1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -298,17 +298,21 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
 	return tfile->napi_frags_enabled;
 }
 
-#ifdef CONFIG_TUN_VNET_CROSS_LE
 static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
 {
-	return tun->flags & TUN_VNET_BE ? false :
-		virtio_legacy_is_little_endian();
+	bool be = IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
+		  (tun->flags & TUN_VNET_BE);
+
+	return !be && virtio_legacy_is_little_endian();
 }
 
 static long tun_get_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be = !!(tun->flags & TUN_VNET_BE);
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (put_user(be, argp))
 		return -EFAULT;
 
@@ -319,6 +323,9 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 {
 	int be;
 
+	if (!IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE))
+		return -EINVAL;
+
 	if (get_user(be, argp))
 		return -EFAULT;
 
@@ -329,22 +336,6 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
 
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


