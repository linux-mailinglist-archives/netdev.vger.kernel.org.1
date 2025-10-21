Return-Path: <netdev+bounces-231307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601AABF7357
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019D719C1D84
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6B340A65;
	Tue, 21 Oct 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTkqkhAb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315DE340A6F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058626; cv=none; b=PgBAWsqjsVQziQ/lE1axnwkQ4u7rnvlRpo+yB1+Zrzvv6JF0I6vXe/Y60d7PSP8Q6faZwCXkHrmiTlL5N7Jv9IuZQPwCxXPSowXJgm9T35kMft1bGx37zKLcvIgb9Mtn+3GO/cK2Csk29b7QLyST/9dzjBHsyo7oe5h++Nca3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058626; c=relaxed/simple;
	bh=3zLiBpGpx3N7y1mDFocEIkcoo3BHMmz6kvCLUvGCdoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAMaRmu6KqsBz3KgJitqiR4LNADQlV/eoAcOXVDsqpqNXOgFpL8YmyFm3gQPLS7XS3AbJQIgJJBFwfQMpRzBk9RWRS0dSnU8erZ0euBHpisPc+qFivoI229QsN3y81IYVBq+NiPEBSEHXvO/kuAuEv1HUvwG8YQTEidrR8OK9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTkqkhAb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ON6jaTzp8OadpSErRLgvJU/FcjQ+VbZlFjItkP49EIg=;
	b=RTkqkhAbKB9aEAecAEm42ldIkqWsovZpMMTDKSI+TV9L3U6tl4lf9kSGRiJQxBqcCoJp/I
	7pS7/5hTRxC0kHOcZIUTlK79oXlBIzJ+BKTb6TDoLJOZbLVKOx8aO+DqqNaJSdyYVW9/BG
	HcXLL/htwKlaUdE908RxgonkfKxQTT4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ye5Gg2RRNUGRzflpjzSfJQ-1; Tue, 21 Oct 2025 10:57:01 -0400
X-MC-Unique: ye5Gg2RRNUGRzflpjzSfJQ-1
X-Mimecast-MFC-AGG-ID: ye5Gg2RRNUGRzflpjzSfJQ_1761058620
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47107fcb257so78655415e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058620; x=1761663420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON6jaTzp8OadpSErRLgvJU/FcjQ+VbZlFjItkP49EIg=;
        b=hkyi23l2UZHFfl+rOjn3fhQzfZTlnk8cws1BpkJcWLkl9Jwzxy6FwEUljbFN9N9f9h
         aCqixpcAmljs9XkB0AAd8xStThzK+HnZ7XWjh1nsze2GaBTcfIxmQCQsD/8Gazzb7cjU
         gBr+9t2SbeqdTORdghOw+RIRnknQt+aVExaTApJ6CWjzdQz1gLCL/0j2hOKldvv6j2bR
         DfDa4in1eRFow9h8AuzZ59jyhq7D16tYi0qbcVdULPeehCZALZ3Iae5f7o3dI6KjEMBK
         gnn/SU6xBOxoEIy2UhorW1QCAYFLCninn3ET494Tc4l5BUsUzxNqUGfrx+Ox97IqoPTp
         CJng==
X-Forwarded-Encrypted: i=1; AJvYcCX02y29hkT/C3E4T+1Pt/5om5A6cMdnppSefO6JRGUClqpKDOvHG96wOAz9z8gK2dT27Xec52c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHvNueTeblkRhknK7fcqg5M09eUtlHd1c7PQXp89YiO71WLTp
	viu2thx/jFo4ejcE+eKVY/Gm5SkvTS2bMb0LtrkcRR9jTIAnzU+uJJNbjhNNGiW1kuLqpnxCSdw
	0OTgTgXJoLKyWH8doGzumPlyr/VgUSHpEaZgD8nu3RaatrUnfQAa9+RiLiQ==
X-Gm-Gg: ASbGncs6CuDyTTf2+SdB68HzCPP+b2uZ0mexs1cEP0cgfo1Txm/aGSo+ezkLL6YOChH
	R8MvfOSclT69qEeN2m/PQ+NG1BtlJji+vLPrYhFxW4kmw76iXV1aLWDb0Te7vkVxtzM2nSJb98X
	EMbqvB/E1TZh9kLyPvJeK/6UeRq5HT4/ZhvySQe+74l9jeRU4d72CuJXM7DUXIsZh0Xr+gzCGs4
	qaJJKFXKQ+Djw47isx9J3eBI/oMkh9ZjCX/U9/cWIQNewpjB80RWXwfBaz2YsGAFBvCG4+t7Km1
	jzpYSQOO4Ity66rCKWWAc2B4uGP+vH3gvkYjCUArcFOLtDc8FZPtLr/gXXlX8mWw1uVa
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr147850995e9.32.1761058620008;
        Tue, 21 Oct 2025 07:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhlH9J/gDJ2/ok4e+k1pdgybvyjWEgAIxCOLewvwxsR9SE4iH4+h2twWM4wXk1Rh2Mp/BOKg==
X-Received: by 2002:a05:600c:470d:b0:471:12c2:2025 with SMTP id 5b1f17b1804b1-471179140abmr147850765e9.32.1761058619536;
        Tue, 21 Oct 2025 07:56:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm339012145e9.3.2025.10.21.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:56:59 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:56:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 2/2] vhost: use checked versions of VIRTIO_BIT
Message-ID: <5423d46e5c6f8a4204f8fe1bcea8bf1e21c10f39.1761058528.git.mst@redhat.com>
References: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This adds compile-time checked versions of VIRTIO_BIT that set bits in
low and high qword, respectively.  Will prevent confusion when people
set bits in the wrong qword.

Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c             | 4 ++--
 include/linux/virtio_features.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index afabc5cf31a6..e208bb0ca7da 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -76,8 +76,8 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_ARRAY_SIZE] = {
 	(1ULL << VIRTIO_F_ACCESS_PLATFORM) |
 	(1ULL << VIRTIO_F_RING_RESET) |
 	(1ULL << VIRTIO_F_IN_ORDER),
-	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
-	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+	VIRTIO_BIT_HI(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
+	VIRTIO_BIT_HI(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
 };
 
 enum {
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index 9c99014196ea..2eaee0b7c2df 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -8,6 +8,14 @@
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
 #define VIRTIO_U64(b)		((b) >> 6)
 
+/* Get a given feature bit in a given u64 entry. */
+#define VIRTIO_BIT_U64(bit, entry) \
+	(BUILD_BUG_ON_ZERO(const_true(VIRTIO_U64(bit) != (qword))) + \
+	 BIT_ULL((bit) - 64 * (entry)))
+
+#define VIRTIO_BIT_LO(b) VIRTIO_BIT_U64(b, 0)
+#define VIRTIO_BIT_HI(b) VIRTIO_BIT_U64(b, 1)
+
 #define VIRTIO_FEATURES_ARRAY_SIZE VIRTIO_U64(VIRTIO_FEATURES_BITS)
 
 #define VIRTIO_DECLARE_FEATURES(name)			\
-- 
MST


