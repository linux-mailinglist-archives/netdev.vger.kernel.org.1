Return-Path: <netdev+bounces-164694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39EAA2EBD0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118BA1885265
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE81F543F;
	Mon, 10 Feb 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2vwLeOF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C81F3B9E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188093; cv=none; b=X3lXjKajTRKkF+shGVaAEvBGWu5biZfudG/RgOnAx2QPS9gb4qdIzt2n2mVqnl+1CEX8Pqa/gAYvAz/iVnmfPptC0meqrkkhLAiZFdZlU43UjZnbHTyFhtr61qdhV6CtNWPBHFmMm6G37x/HSHs9gmt3A38Oj1mPG1xKdVaG0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188093; c=relaxed/simple;
	bh=d/DnoVtSkV/Nkf8oyOpZiRm12klhEJ7Wo4KRtp9gtVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9XFrvqNAUQtIocdrww6GgDydhBXgaPr9xsiH0bgJWC5je7Ma3FqL+IJpmSNN9g/7I5F2TyihCdFjVO18pW6lX5KrdCmR/BccDdhNYTy3Cdspdo/WCCEKC0I+2A+dtuAzrN5wRrvDfulrN1OPQmxuaPnY8uj6jZ0xu0G9K9u3t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2vwLeOF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739188089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V96jX69C9DLp/pa7eUqKAsyCn0HykOC/OsS7VPjv/yE=;
	b=P2vwLeOFeMbfUhPZ3pd0htceHd2zhil/+5K0SeUIpWJVw6TNCMl+UBN2mYHTA81I6ab1BB
	3RlSeXPgKNejodL6vW2VoNj2lNHV8haEMFKqHzkKSOw8hjBld/yQXry6viNaopsA9M5DVp
	UEpg8NzlQf3NNwvcWQx+JRC/a420bZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-7P7z9fA7Nv-dKGsdJWaenA-1; Mon, 10 Feb 2025 06:48:07 -0500
X-MC-Unique: 7P7z9fA7Nv-dKGsdJWaenA-1
X-Mimecast-MFC-AGG-ID: 7P7z9fA7Nv-dKGsdJWaenA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso4238665e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 03:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188087; x=1739792887;
        h=in-reply-to:content-disposition:mime-version:references:ifrom
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V96jX69C9DLp/pa7eUqKAsyCn0HykOC/OsS7VPjv/yE=;
        b=ESaBfs5HClWk2xcnOnvhVytOXF9p5H0fff6MpHtH1nsQQMzfZWZkB1dX2C5e+PJsiA
         NiS/VgqIi65j5KmNoBo+Uy89PBSOI9GKEx7MzmLes9pH1uxpvGAq5Eg/TI5ObcUey4/i
         O6Opw5uqiaNqZ3Yybo4S48DVSdj5RPvfjXb73x70tDy/7ps3+TdbDPa5CH1vvbyQHVhT
         rOO2iVWbglkawRBXXWeINHLUhofUR+TlaMsqVZ82rY9DcFdoPPw7jWClpY4RyOi9UJXp
         7GmXZ1nXQBU2tOLACvp77h+H7I7/FnqQ/+GqjwEEj8Q/6VqOMON5MB/DY6G2/biKKmqv
         4vMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFvuHcIhseButMifVa+Amtl+YSYcOCjES9JPHhLGFFTDAeYq3xKMAbF0NpALJzjGulAALyx/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0E1vDAl6f0WqtaJuiUOoyWw9sjBCyMr7osaa9Ydb9rat1/+ln
	k0mcD6kpOhGajQ6gouXk6EM9XvShsrwMPqkX77R4mj5yb7wCCGAhbu7DZUiaSjB/mzi0MZwc9C8
	TGj2YUj4HvJYDoBgXrhRaozOmC3Dp4MHObfLICqrTnSEw0sGN9oMmeQ==
X-Gm-Gg: ASbGncu2eYZjEGbZO459AQ72psvz0ZU1NtWhvTG8Y6eukgH92MRx05LWKJTnMFpujC2
	aVYcWaTgMHqLdq0vthw0QcAXfW79+p3XouOE7zDHoqDaJa/v1goI6qJXETbTTTMllOxvKO7FYAh
	gzgoJXtVwsZIqr/P4i3YoP6iVogqcOn88yzucOoExiK1GpBozYraOKgLUEWdzMASEbvLahLa2Lo
	J0pf5jt1w/OYwdc2lcCes8bIJBanxmm6OrmWMimw1h62tdSUzzvyKql2AYKtVZ77V2UdbFNjTEY
	6IwuxJNk
X-Received: by 2002:a05:600c:1da7:b0:439:34e2:455f with SMTP id 5b1f17b1804b1-43934e24665mr67131475e9.12.1739188086695;
        Mon, 10 Feb 2025 03:48:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGN3KR5R07uNE78CVdV7zyw1euIY35SEs9+TXB0gKXhyKCy8SuRwCQFSKXWIpDT0SeS4gsMg==
X-Received: by 2002:a05:600c:1da7:b0:439:34e2:455f with SMTP id 5b1f17b1804b1-43934e24665mr67131065e9.12.1739188086265;
        Mon, 10 Feb 2025 03:48:06 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4392fc0856csm76891455e9.34.2025.02.10.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:48:05 -0800 (PST)
Date: Mon, 10 Feb 2025 12:48:03 +0100
From: leonardi@redhat.com
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during
 s2r
Message-ID: <rnri3i5jues4rjgtb36purbjmct56u4m5e6swaqb3smevtlozw@ki7gdlbdbmve>
iFrom: Luigi Leonardi <leonardi@redhat.com>
References: <20250207052033.2222629-1-junnan01.wu@samsung.com>
 <CGME20250207051946epcas5p295a3f6455ad1dbd9658ed1bcf131ced5@epcas5p2.samsung.com>
 <20250207052033.2222629-2-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207052033.2222629-2-junnan01.wu@samsung.com>

Like for the other patch, some maintainers have not been CCd.

On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>From: Ying Gao <ying01.gao@samsung.com>
>
>If suspend is executed during vsock communication and the
>socket is reset, the original socket will be unusable after resume.
>
>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>only when the function is invoked by virtio_vsock_remove,
>all vsock connections will be reset.
>
The second part of the commit message is not that clear, do you mind 
rephrasing it?

>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
Missing Co-developed-by?
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>


>---
> net/vmw_vsock/virtio_transport.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 9eefd0fba92b..9df609581755 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 	struct sk_buff *skb;
>
> 	/* Reset all connected sockets when the VQs disappear */
>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>-					virtio_vsock_reset_sock);
I would add a comment explaining why you are adding this check.
>+	if (!vdev->priv) {
>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>+						virtio_vsock_reset_sock);
>+	}
>
> 	/* Stop all work handlers to make sure no one is accessing the device,
> 	 * so we can safely call virtio_reset_device().
>-- 
>2.34.1
>

I am not familiar with freeze/resume, but I don't see any problems with 
this patch.

Thank you,
Luigi


