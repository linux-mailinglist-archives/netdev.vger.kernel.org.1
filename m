Return-Path: <netdev+bounces-188641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA25AAE04C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6220116C474
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9A2874E9;
	Wed,  7 May 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1o3vvCn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701A28981E
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623356; cv=none; b=otdRawZmdSKFqsqlZX1KNvmqvUR/jbmOsmxpXbH55Jbm3QnJUdskUWumaXOQQtc0We8N/6FvCPF7LF7MbCXSAasCeSYrd0Gqts2ddaX+1iqLbPlbB5kq+3CtnsS2trSXdtp/Om+3ehZZTVEh1oWJMyMenkMZ/PBXY+uZtwZyS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623356; c=relaxed/simple;
	bh=PCMX2Cr+uQWKx3vKDgl51jkFcRXqKV/9DGQU2RgRS9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0Kl6sWk4MQv9f7r4VAWtzdmg7aHUxS7Vq6y0AXEJCHwFXuUXyns9m5v1giUr202vtTIK7HaeMWdLSRYb1yZce7hOZ4zHdLJknde6BZqy3Pn6sK65wTTL4H15i2TErI/aDBDCRt7aJijN40iEjWGCmlCEGHZQqwL1EFm6tOeipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1o3vvCn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746623353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAtnwiXcU1op8DM9QOzo0SnMVizQr1PVYLn+9+GejxY=;
	b=M1o3vvCno5QdcRM5uhRCZd8spQNizlH3oCfLFbsn5ng+lNzupVkRLMNGmQEnCbc5uRRt6e
	E12LbNKHpNfe9k+BKSEDYx4mdHIuwIjo+Dm2B4pFVKVDyKS2Ju4biVTVKGsISnFUjspwB8
	kfasLJty4WvlVU6i8jvwG+niI7lRxVw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Ypz4BEyYN3GJJrIxi78k1w-1; Wed, 07 May 2025 09:09:12 -0400
X-MC-Unique: Ypz4BEyYN3GJJrIxi78k1w-1
X-Mimecast-MFC-AGG-ID: Ypz4BEyYN3GJJrIxi78k1w_1746623351
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acbbb00099eso589216366b.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 06:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623350; x=1747228150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAtnwiXcU1op8DM9QOzo0SnMVizQr1PVYLn+9+GejxY=;
        b=M5hOPlOEzqrGbPxbJCRNB2cS7+ng8w6+zzW5zcksb1SDLuRinpLowyH8Yjk0xJj7Xn
         ozh6lXV1VKS4oOacJv40Otw5Tgt5TW09xt1GqpvEYBPk39DNiVDT6OdRjeChwJY53aFq
         kgrczHEX+ZCnZ6Jy1SfT6CosddYEgtyHjIFmMCgeExi7OLsVEAjbZt/nNf4vdRb48+EL
         SxwCTBnVSghqoAsfexf/AxgRq2BooMiCbk0NgS38Rb3muaLeTwiim1gO2NufGEPSeYfO
         vylVeh5WUL+Vkvwl5O2wOc0fyoNLLjv3FTJEuEmCDM7p+VjHS4eUHhQqLIV0Uq2tozdb
         h46g==
X-Forwarded-Encrypted: i=1; AJvYcCV8rty1MjUi67yUJo88g7f4QP1YfrbnPmnBYxyXDvgKBJKlx7eO6gg1tsn2RXO2xOSXfaf+3pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLC9hM3vKAyPhd1WlOW1OyFq8VBj5zdoP+hMKkScNDhgd90WYQ
	qV8itx45qsj3h/YedcD6JlJXcg5WT4/EDJeF9ms0OOHAR5y/jcEJOHRkGwkp1Ijk2uMCAM311gS
	Y4DfFW7NDXCPTLk/Kxg0FO+Wjq8iovBXw/EFuVzQN5if2iSLB99TP5LU4nWHpKg==
X-Gm-Gg: ASbGncv/h8/pZoWTsir2RC/63CUSFMlQcLh3sgTKBtdZ1hf7ovfn5g7/X94jY/LWeb8
	z1FA1xZ9hUiBdxWZn0D6LKaWNqDp1dWlgUPklz4jkdCJzbrWWaUKmvcHSdajrPTpWloFBuYyo4h
	SJkWS4pPIQbEzDsCFgpFEGBY05zHpaBYDWdgmFFTddZhB8p5BLPEzjiUN4xzDiuNbECEQ4ujp6P
	JSFDFPNYgkQD5pAds+mFuaWij+Ad+NKCHKR+blkrDyBylAASoOPo3nGqzenM+uaGzL11OnXhHMe
	KQGF4zUah5s0jVsV
X-Received: by 2002:a05:6402:2808:b0:5fb:f708:2641 with SMTP id 4fb4d7f45d1cf-5fbf7086b00mr1553389a12.27.1746623336761;
        Wed, 07 May 2025 06:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwA872SvBWeTpMMj+/e7mYjU25+jDDfjv4mDrfoJ39gjkjiqHaiiL4tGqlCQGwX9860akxCA==
X-Received: by 2002:a05:6402:35c4:b0:5f4:9017:c6a1 with SMTP id 4fb4d7f45d1cf-5fbe9f46c84mr3009014a12.25.1746623324960;
        Wed, 07 May 2025 06:08:44 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.183.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b914b4sm9371316a12.51.2025.05.07.06.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:08:43 -0700 (PDT)
Date: Wed, 7 May 2025 15:08:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH net] vsock/test: Fix occasional failure in SIOCOUTQ tests
Message-ID: <sqee4iqviojcht4s42dke3mnsq4f4si6oislu77bm3nqwlowim@oz6voimaqw4m>
References: <20250507114833.2503676-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250507114833.2503676-1-kshk@linux.ibm.com>

On Wed, May 07, 2025 at 06:48:33AM -0500, Konstantin Shkolnyy wrote:
>These tests:
>    "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>    "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
>output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>
>They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
>have been received by the other side. However, sometimes there is a delay
>in updating this "unsent bytes" counter, and the test fails even though
>the counter properly goes to 0 several milliseconds later.
>
>The delay occurs in the kernel because the used buffer notification
>callback virtio_vsock_tx_done(), called upon receipt of the data by the
>other side, doesn't update the counter itself. It delegates that to
>a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
>more than the test expects.
>
>Change the test to try SIOCOUTQ several times with small delays in between.
>
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_test.c | 26 ++++++++++++++++----------
> 1 file changed, 16 insertions(+), 10 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72..143f1cba2d18 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1264,21 +1264,27 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> 	control_expectln("RECEIVED");
>
>-	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>-	if (ret < 0) {
>-		if (errno == EOPNOTSUPP) {
>-			fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>-		} else {
>+	/* SIOCOUTQ isn't guaranteed to instantly track sent data */
>+	for (int i = 0; i < 10; i++) {
>+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		if (ret == 0 && sock_bytes_unsent == 0)
>+			goto success;
>+
>+		if (ret < 0) {
>+			if (errno == EOPNOTSUPP) {
>+				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+				goto success;
>+			}
> 			perror("ioctl");
> 			exit(EXIT_FAILURE);
> 		}
>-	} else if (ret == 0 && sock_bytes_unsent != 0) {
>-		fprintf(stderr,
>-			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>-			sock_bytes_unsent);
>-		exit(EXIT_FAILURE);
>+		usleep(10 * 1000);
> 	}
>
>+	fprintf(stderr, "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>+		sock_bytes_unsent);
>+	exit(EXIT_FAILURE);
>+success:
> 	close(fd);

I worked on something similar but I didn't yet send it.

I like the delay you put, but I prefer to use the timeout stuff we have
to retry, like I did here:

@@ -1264,20 +1270,25 @@ static void test_unsent_bytes_client(const struct test_opts *op
ts, int type)
         send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
         control_expectln("RECEIVED");

-       ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
-       if (ret < 0) {
-               if (errno == EOPNOTSUPP) {
-                       fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
-               } else {
-                       perror("ioctl");
-                       exit(EXIT_FAILURE);
+       /* Although we have a control message, we are not sure that the vsock
+        * transport has sent us notification that the buffer has been copied
+        * and cleared, so in some cases we may still see unsent bytes.
+        * Better to do a few iterations to be sure.
+        */
+       timeout_begin(TIMEOUT);
+       do {
+               ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
+               if (ret < 0) {
+                       if (errno == EOPNOTSUPP) {
+                               fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
+                               break;
+                       } else {
+                               perror("ioctl");
+                               exit(EXIT_FAILURE);
+                       }
                 }
-       } else if (ret == 0 && sock_bytes_unsent != 0) {
-               fprintf(stderr,
-                       "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
-                       sock_bytes_unsent);
-               exit(EXIT_FAILURE);
-       }
+       } while (sock_bytes_unsent != 0);
+       timeout_end();


What about combining the two?

Thanks,
Stefano


