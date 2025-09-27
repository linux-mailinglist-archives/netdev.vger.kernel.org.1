Return-Path: <netdev+bounces-226894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E51BA5F17
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F60168451
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C52BE041;
	Sat, 27 Sep 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYvpyuUF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30013B284
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758976184; cv=none; b=E5v1Hb/ph+MK6/Z4JEXNIejf6MSGaSIiYJS6FShJDoj9PUXv42xpA5jbpLuMJWMzPdLMtF9ZS9Xn1wy9JkcVF/et7bg3aMVzrM1VdbHgD2r/YzXe88+dEFuhgLk1lBC6MSrdXMibPhX3ull+ZZKee6oj5zD+mkMjBY3qsrDbxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758976184; c=relaxed/simple;
	bh=8/mfn+l6yMck2ssfb36rZsznF0V+As3XlEaLgTKq8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MHgIv6HMQ92zcEaMObdFFN4XioqzOX72jjwP7++xbxpVg52QUVfTEno2vB+uelD/JjcFjsCFmoeBZ8tsagCiT6JPCWlvgpa+NBMA+5bpVCf3z6/mrgBjNpfJ5eIUTjZ7pDhwK9vIiIS4BRGA7gBSqy1kkqD/0VQ4xFdcTuj2OyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYvpyuUF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758976180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DUxaVKtW+jmtZoD1iTuQ/I8y8JP+Ut6bd3xSwcm4XoM=;
	b=QYvpyuUFttH+E3IbK9RAa5MkS5Kbot02ftzWx66xx7b3ESmMsF9LkyEO80IElTmXVpMDnc
	S+qC/RyZtDtm7c/hZWlHtTexU/2LYfSbBAueABWxeRfM0Ppc2fIsWfuPuDeXz45vS4KS1y
	6wLMKhiPjKgR3IGJ8Rw/RpUEEIHEL/g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-2dWmOK5kO3KF_Ih4nsUtSQ-1; Sat, 27 Sep 2025 08:29:39 -0400
X-MC-Unique: 2dWmOK5kO3KF_Ih4nsUtSQ-1
X-Mimecast-MFC-AGG-ID: 2dWmOK5kO3KF_Ih4nsUtSQ_1758976178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so20238025e9.2
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 05:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758976178; x=1759580978;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUxaVKtW+jmtZoD1iTuQ/I8y8JP+Ut6bd3xSwcm4XoM=;
        b=MYPcMKK9YsoSkEpac5odfdcCZ6ltW9RPZ7XklbvioOyqUWNKr/sbpsp6xjNx+8cdnX
         b2m/6n+Q45dyU9VvFYttpOr1/iXJMK+qvQjvCtAEFuP0x7aITFWdXx/lO5+rfO7dhxLT
         zPLryRVlShp/HOUqOaF5ry7f+Mm36x9wRHOmrPkkbvWStULg+v6ILsBLc3JT2A45E90z
         GmimcTRck7v/aZ5WAaTjsv0gggNmrUt0jUtgQVLLAYHaf/kvw/ZMjj/YzrnA86FZtgYs
         ZlmmmI0ATfaX+hqXNib0ZQnJ2yS8IQ/XMEYC9zqW/EBN1czFGnt7ln+KF0TzFbsfP7zj
         tQDA==
X-Forwarded-Encrypted: i=1; AJvYcCVeUSZb0xEyJXj4o+4T5sjAHIK5OeTH1ddmfCUUbJZeQwoj+IuUCBzXRwHsrH7GTa6J2mZ2bo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsbwWL4srDNNFPu2FtuYM2p2lISGEkSNa/gNwUyVnCLpwILPm
	qKwMOdiagZp6N8pP4JnEJcSZJZRibLMCqtxavwdVI9wx2kj964wbfAmj6fA58NlnAWZqLhCL2dC
	BX19Z+FfqMRcDi9UVgRRMmwoCa0uEvM435lPPPA0Sp+eJV60srEY7W+nhLzywHykC/A==
X-Gm-Gg: ASbGncu/Mee2fUYXNhBXYfAxbPLFrw5LQhqYQPMt5KYHjtTvtLBVOFFKNIIK4zRuDNh
	Xz4nahpohFaXu47oaBWfiGMnGTarccgZYM4I+j9iGJ88IdPOYFrrNEvraDSEa70U97vqlxPTiv7
	/xDCud4RWHTpkbnjuw0Y4eq3NWSfDXOzJIoXpzeuvqISyssCIENYIn/E5fLef7JJ7kBYfPPCnq6
	c1VxPM7grrgin6HPmT528An2+6J+GqvolOeh3zYtTHGeqLofo+dTs/dkt53oAxkR1DGIMSdo06P
	GieSR2EkuhKkiSDT96ig0eqfI0Om4mHSlFk=
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr95445755e9.0.1758976177716;
        Sat, 27 Sep 2025 05:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEagI+nikv0aK5TJvkBxM8RtXzOb8DG45eGaOv2UMs7Rcf6pJhnXJUfURdRo12z2XArJNGUDA==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr95445515e9.0.1758976176996;
        Sat, 27 Sep 2025 05:29:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9eabbsm117919275e9.3.2025.09.27.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:29:36 -0700 (PDT)
Date: Sat, 27 Sep 2025 08:29:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next] ptr_ring: __ptr_ring_zero_tail micro optimization
Message-ID: <bcd630c7edc628e20d4f8e037341f26c90ab4365.1758976026.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

__ptr_ring_zero_tail currently does the - 1 operation twice:
- during initialization of head
- at each loop iteration

Let's just do it in one place, all we need to do
is adjust the loop condition. this is better:
- a slightly clearer logic with less duplication
- uses prefix -- we don't need to save the old value
- one less - 1 operation - for example, when ring is empty
  we now don't do - 1 at all, existing code does it once

Text size shrinks from 15081 to 15050 bytes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/ptr_ring.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 4d014b6c4206..ba90c0e6ce70 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -248,15 +248,15 @@ static inline bool ptr_ring_empty_bh(struct ptr_ring *r)
  */
 static inline void __ptr_ring_zero_tail(struct ptr_ring *r, int consumer_head)
 {
-	int head = consumer_head - 1;
+	int head = consumer_head;
 
 	/* Zero out entries in the reverse order: this way we touch the
 	 * cache line that producer might currently be reading the last;
 	 * producer won't make progress and touch other cache lines
 	 * besides the first one until we write out all entries.
 	 */
-	while (likely(head >= r->consumer_tail))
-		r->queue[head--] = NULL;
+	while (likely(head > r->consumer_tail))
+		r->queue[--head] = NULL;
 
 	r->consumer_tail = consumer_head;
 }
-- 
MST


