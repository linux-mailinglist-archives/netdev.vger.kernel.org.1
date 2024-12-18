Return-Path: <netdev+bounces-153108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7DA9F6CB6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03561653A0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312441F8EF6;
	Wed, 18 Dec 2024 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yqlg1oxz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589091AA1DC
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544532; cv=none; b=S+mT1J9p5CUIpr6VqQCyXcwLp8h6Ki2DbjDOnhdaaUgdTPFVr9CfRGZUd5p6YaLSIXmLnQSMEJvBxG1KJ8E77O1p3H1tKAgTj5b9logHzqaj1hYcc9vKAzPuGy18wpmIV+dfsQ7V+8TIpMPbt8DI5/7S5Cld4zzwvvC2FfBDF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544532; c=relaxed/simple;
	bh=KfCWc2hLmhWZun6Q8BhuvMTVKxNXItdSW6AQm4Xaytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2Ek5ut6AgQcjZUrGzkI2FGhOwGqgHQ92oI7BHdTS6TS8RN43CpiB9PUpZOaQi6PhKR02RA2k0UPSEe6S0HSPcM5xJmqho7iPXO/uRhoYQbebd6v1WRHS5zkjoI9jtud2m6VGSA9uq9IvBnJmM6umcHOnklMx5tqB7lqTIrhg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yqlg1oxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734544529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ey2TjhiZ0o08EE5RJ7j3SJIuEHs8562zoKulVbx4bCw=;
	b=Yqlg1oxzIdZOBcJecZ92y2UV6ycMaTiD8vwe8jya/cJydqePUuLgs/h+5ikEsqns7Yfrlf
	VQCXpyOZYS05aGMpBvITRvbAXWooDHXNIsZcKSrk/zkcpeN5P67dRglstNkYJdJkYMqRV1
	NbbyMFNIk7MqEu5tC+kUs9/1pV5UA+0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-WSzoJqt0NiedwuozKgy11g-1; Wed, 18 Dec 2024 12:55:27 -0500
X-MC-Unique: WSzoJqt0NiedwuozKgy11g-1
X-Mimecast-MFC-AGG-ID: WSzoJqt0NiedwuozKgy11g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436328fcfeeso41760695e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 09:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544526; x=1735149326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ey2TjhiZ0o08EE5RJ7j3SJIuEHs8562zoKulVbx4bCw=;
        b=k3I/DIX21xkpLCbE+3mYmE8qCTdhdUyhXn8/snxp7kl123U9wernx3DbtfVSFe4r/F
         qb5pRFXgkRpvMxICYoAUjZ1z0Ub8Ov2DmyDttMmgN249gx/95a8Nlkl8x4SLb2UojgSZ
         MHetN5mEs/BEwdxDEAPRpkHpDmL7aLGKU/Lp+NddONpp1LVjDfG/YOf1lWfkd9n2m0Jj
         YhtxB2yc/BbEZ1zewOlLOztUnvb3tvPq37PjXija72WfI7iam/K8aODSLDeI6Ghciyl7
         jE87CmN74WvJ2Bik6HI6W+WFTPNBxZhFyD1xZAVL9ziX3xoHXmrTebDoTo7eVyfKerHw
         4XRw==
X-Gm-Message-State: AOJu0YwcACzvN89nbW8U9/rDW/9jS9vQhumqB+oL+E/cjXuH229N7uSF
	bPUDhwIb3haKHZTNP3J+4oOduBRKK4VbsAkerKAMVWyFlfVHIKLmNlkuWy7O+yTouhkpBhhgTOM
	hsMYdA2HH0ZUQBH8iqhSbS9PtlCT2JRDqVUOVZje+UaxMdtr2jeQCkRcURTahQbM6
X-Gm-Gg: ASbGncs7Mcss+GI8s8KKkNrfxUhJViQZlz99WwFdD6HWOMo4UI1TivF1MiZGKjaalQG
	9Ie6D1P/v/sD6sDANZZ64vcdhNYFjWgQIzMNhuQxT1aT3MYR+1NWn74jPjTYL9L0pOdQH8rzknQ
	yr2T2J5zGc+GKUmMS81XuKVJCuQxFfB7OybKYUyZi1Sai7128YuwP9pDA8Z8km66qfODiuL8ZuH
	8WZuv97ctQE7geEGWfRxg6V98o6kKRD+2BI8gV1I7/ADd4Aa8eV6MDRDvfKfdZY9VxE2XvezJxZ
	XnN6BAapo6YJuYvm3tXqNl35UVgOh5cs
X-Received: by 2002:a05:6000:4021:b0:385:e1f5:476f with SMTP id ffacd0b85a97d-388e4d8ff3dmr3655790f8f.39.1734544525993;
        Wed, 18 Dec 2024 09:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuXx2fa088vj3FShDwzVSyE8OGNpHHHwbF03gb3nzTH5D6RPbt279ql9rOX3hEC/jHinWtlg==
X-Received: by 2002:a05:6000:4021:b0:385:e1f5:476f with SMTP id ffacd0b85a97d-388e4d8ff3dmr3655724f8f.39.1734544524650;
        Wed, 18 Dec 2024 09:55:24 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b190a0sm26867595e9.28.2024.12.18.09.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:55:23 -0800 (PST)
Date: Wed, 18 Dec 2024 18:55:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/7] vsock/test: Adapt
 send_byte()/recv_byte() to handle MSG_ZEROCOPY
Message-ID: <zfefs2bpzzssles47arkxu7ectqelyyuy4rahfkeksvcxc7m4f@b6owwwenivua>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>

On Wed, Dec 18, 2024 at 03:32:37PM +0100, Michal Luczaj wrote:
>For a zercopy send(), buffer (always byte 'A') needs to be preserved (thus
>it can not be on the stack) or the data recv()ed check in recv_byte() might
>fail.
>
>While there, change the printf format to 0x%02x so the '\0' bytes can be
>seen.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 81b9a31059d8173a47ea87324da50e7aedd7308a..7058dc614c25f546fc3219d6b9ade2dcef21a9bd 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -401,7 +401,7 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>  */
> void send_byte(int fd, int expected_ret, int flags)
> {
>-	const uint8_t byte = 'A';
>+	static const uint8_t byte = 'A';
>
> 	send_buf(fd, &byte, sizeof(byte), flags, expected_ret);
> }
>@@ -420,7 +420,7 @@ void recv_byte(int fd, int expected_ret, int flags)
> 	recv_buf(fd, &byte, sizeof(byte), flags, expected_ret);
>
> 	if (byte != 'A') {
>-		fprintf(stderr, "unexpected byte read %c\n", byte);
>+		fprintf(stderr, "unexpected byte read 0x%02x\n", byte);
> 		exit(EXIT_FAILURE);
> 	}
> }
>
>-- 
>2.47.1
>


