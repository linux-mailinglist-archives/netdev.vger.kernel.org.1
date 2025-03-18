Return-Path: <netdev+bounces-175658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C87DA67083
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE9D16EDE2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF52080CD;
	Tue, 18 Mar 2025 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="VYE+pb0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB4207DE3
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291829; cv=none; b=L99M/UJmK4ZvcJ5W9ztHDOvncgyaDH7qlqUsfq6kVxc/B+9WW4CljGgFb7GHFvCuGuzdKey9EtQdLgkM0LgITFr09ak7jsRD40XYkpGaJebp+fDqbYbrhXPetQy7g1jgr1SanEHX0jDhQKVpe9vrWLOApXN9rW2uS1pICwB6pkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291829; c=relaxed/simple;
	bh=y7xGmXz1+joLuyF7rRKoRaRnhcPRU8zLLhDGbCzRvUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WM7QrC9cCE9M4BAMZpmUIEXY/ufnC3X6K9dA/9mzccksXDilLuHDFtGI7/Ui+m5FzYF/kG2JPV3jocdWf2VYikvupCKG9hvTj4bEG/N01jQxX/g6okziz3zVOy9UqitN2Q1Zq8KTk7xBRImR4K3pDs0LHlY9lD+10ILMlluo4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=VYE+pb0g; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22435603572so85599545ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291824; x=1742896624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFcdkuZXdG0nFv0JVqG4IlwwkUXBEREwH0bBsZlwErc=;
        b=VYE+pb0gott8bXBnveB/YaMuIqCVjTM4+OzTRmcJq0mgofuKNn80ebEBJlfl7zHSgV
         NpHP2SOLr1JyDyASJM15U8mkOXoYK474ks600F9F705p82n/M+o/mnWq2/Q/tH3FbGvr
         XNrqWVoPnvQIjTmjCwXj5h2M2no3fRzO6k9UU1N/RS7LB7sliMaBmXKBwJFQS5md9ORd
         FU++dJ8QPuOXZ2ZCtjTHhe22SslJ2FtRhJUhFEFZ4604vzWhMl3poInMW1GIAG88l9hC
         XmYwNMGUpbagKnWD3lIqKa67e7iZvjaKmmK8ink/xVVkbOZHQfwihFUptCIAwVt9LyNx
         HX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291824; x=1742896624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFcdkuZXdG0nFv0JVqG4IlwwkUXBEREwH0bBsZlwErc=;
        b=qQnXHN+THVDezY2kE/OWRILP/CTD2yRtBrn8MS9UhLwiwfrIdyvLMxos3Hog8r2Dqe
         48KAd19/6rJmfe351WgYFTlhYxuoeYcCqIFrfrZYImwB1jo6hOPrlRkoizKEx3vfIHPQ
         EAvjgfnKn3hbuLmT7d8zygh5JodJ0WEegd+qRvULC/MOB2RSGiMLX2oqA4T+FY7rl4Cv
         HvD06mDoItZly4GIfom1S5Jn6zlhdH+xG3SWcicudUNP8mGKmHESyoej0SzR6TS8bxrh
         jM+mXSI5utclmSeaIlOLaIaiP03wgefNmm2ChednhSmaRptyR+TLfrWw94Gahk7AYqDB
         wI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO4bCEbOY27V+cxFaZn66RI2/4CLzQ3lBUlUkKZHoHNofAtn6QllM7vbRfRCEaYWUpOl64rZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBes1KNs5T+wEMIh24/fZp3PvOsCoceDYboPeLy8V2ddDbLyWM
	7p4b+1ftx7rSIFf50wF0w4sC1GTn3n16RcvDYBfHHmaB6bOwaxh2rqIxtNfbxuo=
X-Gm-Gg: ASbGncvHIRRof4q/PuB8Z5dXNMzWkFLDmrRl3tAywVgWsjzoZ5+N33Ms8vbF9Kb0vXL
	xgbuN/huzUc7TLRTMbLbuZqi8vW9cy4G/gweqTz8U0bRWwRK7o/QiCLXCwMnjBcDN/YusEEXM0E
	PK6JDVPqsoVwd5+yynU6ja4UPRG/GUq3tsiuj4WWxia85L28/Okz8x9H9/RAO9CRpG943bhFU0y
	Q8qyeuACBV5Ex8X2SrCYfXnMuyg0Nyv7fiRyxXQzx+CP5LCH9EnrLwZwKN/pqY8zPTmcdAN/sc7
	gv66uzDwoVI9xUumua82iqnwYVsuaj8HWm183ejOSatqF6yA
X-Google-Smtp-Source: AGHT+IEDg7sBznXHtheXcTwTR0qQJ5XZCTzq1W3+7+Ny1lJUvohFaD6bIzC8LuHltfp6YLS3zy5cUg==
X-Received: by 2002:a05:6a00:2d95:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-7372236edfbmr23606104b3a.8.1742291824189;
        Tue, 18 Mar 2025 02:57:04 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-737115781f3sm9150521b3a.76.2025.03.18.02.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:57:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 18 Mar 2025 18:56:51 +0900
Subject: [PATCH net-next 1/4] virtio_net: Split struct
 virtio_net_rss_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-virtio-v1-1-344caf336ddd@daynix.com>
References: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
In-Reply-To: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

struct virtio_net_rss_config was less useful in actual code because of a
flexible array placed in the middle. Add new structures that split it
into two to avoid having a flexible array in the middle.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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


