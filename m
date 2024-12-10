Return-Path: <netdev+bounces-150744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EDE9EB61E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D857F1659AF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75FF1B5ED1;
	Tue, 10 Dec 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwFIjOZS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3119D06E
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847706; cv=none; b=CT/iNKW0Z6KkUA0KbrH+D7Cc5StUP6md1PM7chnKgeHbT+SnOJowlqU3jzNrZH2j9sgywGOaNjnGKC6uOWu2v0YSl9YU3RSLDS7C2feUDCQJ2W4428HHGeZAQIy8QXWhCYzSqHZwyvuTa4c7OBmHuvz8pRue8Wjnj/tUqBWY14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847706; c=relaxed/simple;
	bh=1GJr7m5lhUjHH4LxIb/mBj0xuJ+rt8EbwdW42bKqO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH2FtE3RMcV1zgBmM1Sax3p+zhn4HNhr/ulTy6AOjrKqC/d0pPCUS2SE1BqjJ7j/L0SM6/SJUzTz6CAItQSoLiXpttW7gDqkoe7a6rwAozRelUCZLlINp72S1o5tJpj3zybA7euzGTPkpXh2s9mYKXulmzeLF2pwUgf6vH4fqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwFIjOZS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733847703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UEbdRsLdGGMLOAM2mP+36JGhQtFVf0AvLPpVIUSRH+I=;
	b=OwFIjOZSA8aopepa426DdfTKgy9IpNdtwuEP+E3Oy5ayI0hlvaqxFZdHzcGMjbVR/D1a8e
	hkmUCJ2NiONd++PLwkKErepIqWZ0xFaVm4t4j5w1j5SQdLbYVpEQ2z/90lxS/7eY5Uddt8
	g28avyTxn2civFv3owjAbjlrjzlH9TE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-v2radKyoO_WnQBj4i2gyHQ-1; Tue, 10 Dec 2024 11:21:42 -0500
X-MC-Unique: v2radKyoO_WnQBj4i2gyHQ-1
X-Mimecast-MFC-AGG-ID: v2radKyoO_WnQBj4i2gyHQ
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6e59d6638so94671285a.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847702; x=1734452502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEbdRsLdGGMLOAM2mP+36JGhQtFVf0AvLPpVIUSRH+I=;
        b=nKXlX9+c0gkgLmjbzDnTCtcC8cbZCzngIEjyaotz052jt34fu4x7J0mlw4hz7lHrzz
         ls+6db8FYIMXhdkotdwenBq1M4fK3YZutqCOdiwINeXeMvusYZ2f+wv+paEW0bJeOiMJ
         x5kUmo2pFrqgmJNNeyuxCbOY0B1sW1nzt30L3mQhzsEyV4RibRm7ymjwokuMynz/0N7t
         SUxrqxcYbegJfPdCd7rnCScMZAY2FyxqHu6+ir9LEenFCIHmDtWgz10RIcZAkvs0/TWX
         jRCALyNeB/UaRjFfpeJwQ2VUJXwKuGjAa2XnvZTMHLFCqsj3frz2lz300xwYtURDDMhQ
         nQQw==
X-Gm-Message-State: AOJu0YzKVrOO9b3mYPihRMPe5XtPheDj70DnSyvyKrtkpLfNgrC3smP6
	7H3oEOgk0g2FhZQ1UEWdHsA24jZNpZ1m2xHuB8IUSHFVGjMRByav5ktnq5m6xmgqwcXEMAckgD1
	Ol+Q71hSRqMRp8XkuHNb9ejT5SIy0+D+Aj8uW3xJVzOLRaZqDa4Tvrg==
X-Gm-Gg: ASbGncudvbCIRwaOEnJIjPCUndM453rGtORwroTGH9ghu3vksyv/rIIvWn0qE5bWDpr
	//JY82pB+v5c6QJpXUuaBugG+XF65IXCiQlRM6aXha3qYEkI6pk5907d3C7DmgZvWmLkhbiLe6i
	D3584I8+cxJArX0KuxHZBTxwxUqbY/KGfLbNjpzAjSvurnPrZ3Lv9AGitDday/QqgM5p2iJ/eoL
	BEvDUtWRrHxI+PTB/IXHoQIbZdiNwNl1bSDFy0lpNNNaf/gjTnlpRKrZqAXUURsoXSx+vdITPkP
	STo+XTWOiYWMaLsbu099fQQ9lisAow==
X-Received: by 2002:a05:620a:4103:b0:7b6:d6e5:ac6e with SMTP id af79cd13be357-7b6d6e5af4bmr1250649685a.4.1733847702106;
        Tue, 10 Dec 2024 08:21:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrFi0+IAyTn3oKMyw6QCwjc4NR+kETlHuGp1v6w11ypy1UvRUzqCdSdcp4IO6pAcJqjstbMQ==
X-Received: by 2002:a05:620a:4103:b0:7b6:d6e5:ac6e with SMTP id af79cd13be357-7b6d6e5af4bmr1250645385a.4.1733847701686;
        Tue, 10 Dec 2024 08:21:41 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d8aea5ffsm175713785a.12.2024.12.10.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:21:41 -0800 (PST)
Date: Tue, 10 Dec 2024 17:21:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] vsock/test: Use NSEC_PER_SEC
Message-ID: <xob4ybc3qfgmveslb2ocj5ikyepwcrpl5pfb536wiqib3hzn6e@co4fz3zbdes2>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-1-c31e8c875797@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241206-test-vsock-leaks-v1-1-c31e8c875797@rbox.co>

On Fri, Dec 06, 2024 at 07:34:51PM +0100, Michal Luczaj wrote:
>Replace 1000000000ULL with NSEC_PER_SEC.
>
>No functional change intended.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 48f17641ca504316d1199926149c9bd62eb2921d..38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -22,6 +22,7 @@
> #include <signal.h>
> #include <sys/ioctl.h>
> #include <linux/sockios.h>
>+#include <linux/time64.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -559,7 +560,7 @@ static time_t current_nsec(void)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	return (ts.tv_sec * 1000000000ULL) + ts.tv_nsec;
>+	return (ts.tv_sec * NSEC_PER_SEC) + ts.tv_nsec;
> }
>
> #define RCVTIMEO_TIMEOUT_SEC 1
>@@ -599,7 +600,7 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
> 	}
>
> 	read_overhead_ns = current_nsec() - read_enter_ns -
>-			1000000000ULL * RCVTIMEO_TIMEOUT_SEC;
>+			   NSEC_PER_SEC * RCVTIMEO_TIMEOUT_SEC;
>
> 	if (read_overhead_ns > READ_OVERHEAD_NSEC) {
> 		fprintf(stderr,
>
>-- 
>2.47.1
>


