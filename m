Return-Path: <netdev+bounces-242170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C589C8CF09
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 07:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3EC3AE674
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3595314B64;
	Thu, 27 Nov 2025 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRs7XW13";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hw6jYxpx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903F313E1B
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764225641; cv=none; b=C6VCJo/Sp2AB7h94AeKGX3in6kNFIk6mruQ0G1yD2/r5MAud0bOE4yiPjw8OxspBIUbM2+MVHUtBtteDZyuElA1ZXB7NpE0TyuhM6YXOTKbdIQRXWvKKAGNVLpGkIuMoEY3mLuQfPA5KRX/hDX3wPZzQ0LNPwa4EFXm8BcgVIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764225641; c=relaxed/simple;
	bh=p4zBspV0umYpwlxraVSt9LbhsuCRfZnCfl2fUmVODfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1ue6/YRQFUT5MURbZubAxiZu0AJ5soQhJvu3V0X7tlw8ByVc3wyR2Q05j+k+D5tvUQ6fHXuW+0FkUI7f3f1IJt79IqTiuthldB6VEcRlR8qb5qWNxdiYAhLi3YVv47t2//EVsjNb6/+QDa0PixBpKQ7rajdEKkbzVu3f5N7ReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRs7XW13; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hw6jYxpx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764225638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kFZFceCxodv+sVrwXshrWOSA01PvSJh54J0xHtV2LxM=;
	b=TRs7XW13eC58qfJksEUlVhEjIW1ZuQMPCThb1IvL6dFy1iIsihkt2MdhzndUs3pS56Qp8s
	S64COeVqtzTFZCNvL7an3Tfl4gm5+fxTfnRJCdLdHcrsJAPZTjR4ninld3ZcVR+/H5lIss
	WgmdXq1ROfpDujq7ZqptuYpNHPw1AvU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-038iJJyBO6ue72NJ78J4Gg-1; Thu, 27 Nov 2025 01:40:37 -0500
X-MC-Unique: 038iJJyBO6ue72NJ78J4Gg-1
X-Mimecast-MFC-AGG-ID: 038iJJyBO6ue72NJ78J4Gg_1764225636
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477212937eeso2793115e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 22:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764225636; x=1764830436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFZFceCxodv+sVrwXshrWOSA01PvSJh54J0xHtV2LxM=;
        b=hw6jYxpxwPKIFKJGvab+MkvyWyCbd827Ljgf6Dmmt8Hn0CT7rL62onmKBUd1VdHnAo
         YI3iylFQxACvau8rTBkosao51et2ddJBigJo1nTvpDc//3olZ3rQ801CGtD0TKVs/tb9
         eX05AFNGoP3FLX/gpXgPkH2LHie0hflArld1mja6rZGRMmKGZo0fs+9ikG6g+14KXqd+
         k5B29FvaR3vNimVFKMlOkk5bl8VMCJTDk42l6HNaWhQczgcHAly+X+FeRGpPhf+zxFiZ
         fkHQfI+81lEFGXyWG2WJmpgIdmCO3kSAIu8tB/E049IYipx3Yp3iKsFc/cXhCx5iXHLl
         Me6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764225636; x=1764830436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFZFceCxodv+sVrwXshrWOSA01PvSJh54J0xHtV2LxM=;
        b=dneGiRU2dtlbcY/42NBDImMRHjfJ6Rq9aXpWwNKo+tUH09rbS7x3hwyZk27mALlYER
         a3JrRmC0IP8xMPUa4IBWWFZ3iksZqTZEfg10nq4R48+fRsQGOFYzASPM8nZpp01hupp3
         bmIIwjebedxv7EweLugjhcuM25ppjsYNjlXLOftGaoYE2kU7LVwCd7MsjTURrArkUWwA
         Dwk2ps26VwVDOQxVrieN3Rfqps1bPuSbmtw/iRKh4lJS5Jp6rS/DRNYQEzhN3f67qYnf
         x8WUnW6JMU3r9BEQRc1S8IsXfSvgwx66mUP3kWJaKCSaHRf5Ju8RwU4MGJZ5hMJMHBp3
         qUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhwkPL9Fc9FsweN5re1M5Je+hIogkju1dzdIyt133lafa9en6uAgtlYT8Al99pGQKhC+jeASA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgmWa1/bYV6Ogme2KMq0K595lbViIaH/+InOFca5sJ4LfLwyq
	AfFkAVy+OoBKRtpZ7GpbNArpw8dio0IUJE07sYwCbTft9aznEuwmPcEGyZkG0HntK7nTy25LuK4
	SK6a0GWjrGFf75Yz3JWgeDbyqFzdZo34FEZveIxvUhRaK7FEuYdk0rxgcBg==
X-Gm-Gg: ASbGncu5KXMGKHkz9N1Oggxs7ht+BnHV/x+hlH9YcqdvPUFG0QbVk9gmGSp2hf6RGPQ
	p+SZvejAAgEdESZixtJ4htoyy+2D8KLbTcOPgmKhXkAEe6U08LP3FLUhKfUWyeZePrc18iMlnml
	wwHpNkEdXidS6nDmEdM8e2r2HsoWonVE8n23FnzxWxq6cOFeM2nKK4bcjzPtrv73mts1RRPwn+g
	k9YKdV6x5o0kG5jqechn84H9jTqqfpKZPzjLGk+A7j9nxTfbPeoY2W1ZNRiODLdFVwNuebaJ+3u
	i0vD5kSu/LX3vQ/mZNkD3QZd3TY9MdWM133x9891cG/hZzgaWmOEbXOtFrM97iF1ylA9/BKev+k
	jZpQ8hbHvpWa111XaN015zX2i/zn1hw==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-477c1142268mr180867305e9.20.1764225635775;
        Wed, 26 Nov 2025 22:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmaKJl3GPl1IrG9e+lyxemKaHO0wPm9ET8yhjMSTC9B7Xozmw3CvG5GdadD3czzW5PwSFbkA==
X-Received: by 2002:a05:600c:3543:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-477c1142268mr180867165e9.20.1764225635290;
        Wed, 26 Nov 2025 22:40:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c44dcsm78642495e9.11.2025.11.26.22.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 22:40:34 -0800 (PST)
Date: Thu, 27 Nov 2025 01:40:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v6 2/3] vhost/test: add test specific macro for features
Message-ID: <23ca04512a800ee8b3594482492e536020931340.1764225384.git.mst@redhat.com>
References: <cover.1764225384.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1764225384.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

test just uses vhost features with no change,
but people tend to copy/paste code, so let's
add our own define.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 42c955a5b211..94cd09f36f59 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -28,6 +28,8 @@
  */
 #define VHOST_TEST_PKT_WEIGHT 256
 
+#define VHOST_TEST_FEATURES VHOST_FEATURES
+
 enum {
 	VHOST_TEST_VQ = 0,
 	VHOST_TEST_VQ_MAX = 1,
@@ -328,14 +330,14 @@ static long vhost_test_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return vhost_test_set_backend(n, backend.index, backend.fd);
 	case VHOST_GET_FEATURES:
-		features = VHOST_FEATURES;
+		features = VHOST_TEST_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES:
 		if (copy_from_user(&features, featurep, sizeof features))
 			return -EFAULT;
-		if (features & ~VHOST_FEATURES)
+		if (features & ~VHOST_TEST_FEATURES)
 			return -EOPNOTSUPP;
 		return vhost_test_set_features(n, features);
 	case VHOST_RESET_OWNER:
-- 
MST


