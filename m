Return-Path: <netdev+bounces-176677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03053A6B497
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 07:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF7E462633
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 06:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED61EDA09;
	Fri, 21 Mar 2025 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="MwHkEHTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93F1EBFFC
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539742; cv=none; b=ZyG+LJnYvphUTGMB45dIgQ+eFwj6kGEB+8vAya0wgpt1ckz9mVNJ6lIZD6upM+bAyo9Y0UHk06fa42vAwg2rj8BtHnPvbVCUp1b7UkJzffJj02onHWj7+sRrFif5YAp1MrRe7U0cF7E0gcIKyZhfchgukpRBDJy4HQF88hzJt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539742; c=relaxed/simple;
	bh=JjapcMVDGbOLgMkpCmBgvZCv2tls7EkMlHjM4nzx7nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG2aukyeSvOWxY3yQzfkB33zmbAIJaHp943lwReiW7cyyPg4rY/C4fdQPWFyU7FUCZ8xQ1wRqCWZtVbLmo4YS0mXZualt5gatlwPkWotY1j59XN2Ws0NBzXxVu+DhABJzHgn9u/a3glxqDOmiyMm2fcfOrdKEEiAeR170CxAIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=MwHkEHTi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso30843405ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539741; x=1743144541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/ZmhDXoFm25C2TQibSTkJHDcTfVUeG1ViV6OOg3xRE=;
        b=MwHkEHTiKDEeNOyho//Cj5YIGbXiWDHlEToCwMMiDc2SD8naWH/fH4SDgNS5AAY8T+
         P/EyId5Hfo3xy8SErJuDVF9ZgtnNknJFku/xi3AjbFigt3TL4i9LVxHtUnQMOvMLgcIt
         lVgwWpwOh1TQq6S4mNPb9r5HrW7JrH125qjS0mSw2tmIPUZF6bT76P30avhXsTrd03/g
         NRqryO0lzBfd1DoT0FwkqwvAPxwUpwCJltSw0y49QUkwQsThND73sOTRXoBOjC1zDkbm
         bH7/fuXin9V7nGY6t0we4DqpW5j6+gPP6fuPm2fFuQz+b9V87rXrHc1w6RxaH42UUbH8
         lRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539741; x=1743144541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/ZmhDXoFm25C2TQibSTkJHDcTfVUeG1ViV6OOg3xRE=;
        b=BykGLbywo9EP1LuJwuj+3/KYSZ7X18asQaLt/Oszr1zgu0Qw/zrBfB7wd9gqoFAud5
         te8Fmj5Qg3ni2JQdzuRvJTTrVkGOyMxgqAmSIWTOxv5+HyP5lDZ3y/fJnM6W+AEO/6gP
         wcpaWxqnPoh48Qb5RmctgnShyJgQrea5Q3DYWitWuk5QqwR5ylMSO8hp6W95ZXfiY1jC
         wVp1z1ji8A0IZoBHz1Cczni6jx5fyU7tJxDBEocPMpa8IY3h/L9ak1vhffco5XXTZ5G3
         SiJILyDlBRMB1TCffaxoXCbUip7E+qry/eS+GMDQJU7u4QtIAxpZy420e4AJsBX6DYyN
         vtNw==
X-Forwarded-Encrypted: i=1; AJvYcCVlE9/1vRH2UGqViYZQe/D2mH7wrdF1dEkjbI2X0HoswejFpJmjbeKfp8Sxm1cZjAIOC83ApHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXofuuCelaQD2mUQBhFYbEpa46vq4ta9NRyMbAOEKAK0usOE4
	sGy8PYT2Qhz/SoAxyhUhejZgpvysW77pQ8n1s4l/0Bl3T8fRL2oK2YTY0Xgo1xM=
X-Gm-Gg: ASbGnct5u22CGVB1daFnNR1dkKXBFfhB1eqEJuSeHt/zBAzjm5B//AZB4jRUgJdTHBo
	ieLqERw5IHeQA42T0a1KHSzfu/yZcQeFLlt69UqBqWiiHqjE/OnaKi0aWM316jqHkF9bzDVPZgp
	dBSDKToP97puD8yJzY03qKENRNJn+OzYrclPWpGTCld6T1GtKYWX8+p0xsErr6lvE2tgUKopUrr
	t/kOjsh4mHMHkX1SXJJIB1UHP0+EEcehSa/Xe1oiKXz+K2EhF9RWXiIyQLNFbGfWM7AsSlJFXrO
	eQzLKhPwhi4ZX2Hvcio7pxz8ps25dCh5lQIDVM2VPVgaXhH3
X-Google-Smtp-Source: AGHT+IFY57i8l2zIDhAAWUOoYbKyLPQPPGn+mWn2Fuj0WlYT5jMKi+NUy5SRU1dEXrfFRpylN+S9vg==
X-Received: by 2002:a17:903:22c4:b0:224:2715:bf44 with SMTP id d9443c01a7336-22780c7b0d9mr33833585ad.19.1742539740663;
        Thu, 20 Mar 2025 23:49:00 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22780f3977fsm9212645ad.14.2025.03.20.23.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:49:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 15:48:32 +0900
Subject: [PATCH net-next v2 1/4] virtio_net: Split struct
 virtio_net_rss_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-virtio-v2-1-33afb8f4640b@daynix.com>
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

struct virtio_net_rss_config was less useful in actual code because of a
flexible array placed in the middle. Add new structures that split it
into two to avoid having a flexible array in the middle.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index ac9174717ef1..963540deae66 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -327,6 +327,19 @@ struct virtio_net_rss_config {
 	__u8 hash_key_data[/* hash_key_length */];
 };
 
+struct virtio_net_rss_config_hdr {
+	__le32 hash_types;
+	__le16 indirection_table_mask;
+	__le16 unclassified_queue;
+	__le16 indirection_table[/* 1 + indirection_table_mask */];
+};
+
+struct virtio_net_rss_config_trailer {
+	__le16 max_tx_vq;
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
 /*

-- 
2.48.1


