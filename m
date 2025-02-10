Return-Path: <netdev+bounces-164673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA28A2EA8D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512CD3AB9E5
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0771E379B;
	Mon, 10 Feb 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxpeVWpS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6514D29B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185368; cv=none; b=YrGC0lLd2nhgxqqWiD0BQ1NlYjNFdWb9KW/Kct0WH215B8ljnHlpnoAQN4Tr6QsqZ+TzEfuWyl7vRv4p5Gqcuyrpd2COjOp/cBWVbd1fQEcvz+0cJFBczEXSq0zh9spctPvImDyTA8A1xpirYTE5U6TOn1/SD2QupRz8j2Qt2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185368; c=relaxed/simple;
	bh=LvOQH9ItK5kpkHdcctmHoeElePYbHQ6SeuUkBY4RotA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjZqJ26gvWJzj91nZi9WCWR1Sn4ntDMdk9bPPIqzwY0rL8x08tOzrX9K3tDmVJ2GBaeYvH73r6Rw/wvF5Pixtdq5NUV258AXpIDvapomuIAPP9ZYRtlrWCqymwemXjUpAImit9kMLh5nPGysBUQqtSrf7Yp9Y0F3cRp6jDxCq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxpeVWpS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739185365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swYAcnuiVW6RK8Ul+P0fcMd3U5CHMNqoVkyi4ViV2Rw=;
	b=fxpeVWpS5qxB+o+gZJBtGz4WMrxypHZG3EHezx95xV71VjZxEDgzRfLd846jrTH9sPQQU6
	Z92jXE/UYYNgLg09YeTsV54vT4n2puoxKEbPWrVNx6qjMXrWtUUwPvIqt6Zcv9hSo8XE1L
	tF0B9MUe660O62wcrWpqVQVpSG2YBFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-vR1ual_UPI6wx5mcOmA2_Q-1; Mon, 10 Feb 2025 06:02:44 -0500
X-MC-Unique: vR1ual_UPI6wx5mcOmA2_Q-1
X-Mimecast-MFC-AGG-ID: vR1ual_UPI6wx5mcOmA2_Q
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dcd8ddc5eso1829612f8f.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 03:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185363; x=1739790163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swYAcnuiVW6RK8Ul+P0fcMd3U5CHMNqoVkyi4ViV2Rw=;
        b=JA/gaKl/WqOpQOuMnCy0idTg/arhKDesfufo6uCz82YUuoa57VU+8CQRr0aYwvSuts
         g6jjItrBU4qQXwlVbHD5ir+ej7cHYHsMsRY96ZH3O8mODo3hMYjdX4M0wPDlIvYZ7eEt
         TFu0LbsafBLMem+Ov2ArjbpDcuYwHPbQm1q/37sjG8iW5Xwfee0b3c2a0pYdDzM7yzK5
         KjL3qOhaIbwkgR1XI66Am8zM5W0ewRMF2sjW4ywofPbEZN/q+98S14D34A9cdmQC+ouJ
         VSWo0TykgYVT3AwOlKRO2Ga9/cqmtwiNgEz7b+Z3Eb6U2BAzID7k+4JJ8tXP0xzZ2XnD
         cbZA==
X-Forwarded-Encrypted: i=1; AJvYcCVkddyf/Ecgbeh9tbM4jsBc/DmfhlMwQAR5wsG5rFMMvZ7/wyNI52VOw1n+PMrvwHuUcAKnN3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0Bg0n2sxImXnTEL8Qk5WdxiZ7hmJdlSUbu9ExS2Xcwrcrl8/
	XFFMmOTMNvQCUMj3/tw8LANMYuexkURevGpC9oEStSRIFQGZd1d9L/U76fZM8+tOQQ3hw9HkAQ0
	xeGzN1xmLq7DWfiHVCFyGxk+BMygIDuAz5RNLcKcpiWbohV9BldZ+TJldwVaRww==
X-Gm-Gg: ASbGncsuDWy0WP+cDV0WBsL6lKblITHPm9tQihOJw6164wGsTx3LBKdONqjVsaPZoJS
	lRTxLWxiKxY8LdSYfYrBvok7KZZi2dUwfcfLAWz5Co3lD/yGdqmwstriM2eXJlk/fL4GcvAn0CP
	YhV044PCuzPzK81eqhmTNFDJZ2p4AxffiamLYxUEBt8/pdRKl+1Aq1nWGO4JdAhxpmG20DXlKRD
	BtLSiv2aWT+TjwIPtayCwWUI7Gkk0A4fbb2phzYvO0+PugahOAVl9zZOXQ5nRXVRoGlDnt9c0rE
	FSu7+Wuq
X-Received: by 2002:a05:6000:2ac:b0:38d:e02d:5f42 with SMTP id ffacd0b85a97d-38de02d609bmr1377010f8f.6.1739185362710;
        Mon, 10 Feb 2025 03:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVcih5C2q2EoxQo6V3rYfBXB/mX6hEY2CIHU/jm3irE77jPqNtIp7mAAXfge1kKv0X5WGlbw==
X-Received: by 2002:a05:6000:2ac:b0:38d:e02d:5f42 with SMTP id ffacd0b85a97d-38de02d609bmr1376986f8f.6.1739185362281;
        Mon, 10 Feb 2025 03:02:42 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43939db5eeasm31376925e9.0.2025.02.10.03.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:02:41 -0800 (PST)
Date: Mon, 10 Feb 2025 12:02:38 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, mindong.zhao@samsung.com, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Subject: Re: [PATCH 1/2] vsock/virtio: Move rx_buf_nr and rx_buf_max_nr
 initialization position
Message-ID: <eebvrzx7zjbc326ycs3coskq5cajaoxcblp3wvcxfqaics2a2z@342wvb6zexs6>
References: <CGME20250207051943epcas5p4b831a4f975232d67f5849c3a2ddbcb59@epcas5p4.samsung.com>
 <20250207052033.2222629-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207052033.2222629-1-junnan01.wu@samsung.com>

Hi Junnan, Ying

Thank you for the contribution!

A few minor comments on the process:

I think this series is missing a cover letter, not all the maintainers 
have been CCd, and you should add the tag net (because it's a fix) to 
the subject. (e.g. [PATCH net 1/2]).
Here you can find some useful information[1].

[1]https://www.kernel.org/doc/html/latest/process/submitting-patches.html

On Fri, Feb 07, 2025 at 01:20:32PM +0800, Junnan Wu wrote:
>From: Ying Gao <ying01.gao@samsung.com>
>
>In function virtio_vsock_probe, it initializes the variables
>"rx_buf_nr" and "rx_buf_max_nr",
>but in function virtio_vsock_restore it doesn't.
>
>Move the initizalition position into function virtio_vsock_vqs_start.
>
>Once executing s2r twice in a row without
I guess "s2r" is "suspend to resume" but is not that clear to me.

>initializing rx_buf_nr and rx_buf_max_nr,
>the rx_buf_max_nr increased to three times vq->num_free,
>at this time, in function virtio_transport_rx_work,
>the conditions to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) can't be met.
>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>

Maybe you need a "Co-Developed-by"?

>---
> net/vmw_vsock/virtio_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index b58c3818f284..9eefd0fba92b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -688,6 +688,8 @@ static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
> 	mutex_unlock(&vsock->tx_lock);
>
> 	mutex_lock(&vsock->rx_lock);
>+	vsock->rx_buf_nr = 0;
>+	vsock->rx_buf_max_nr = 0;
> 	virtio_vsock_rx_fill(vsock);
> 	vsock->rx_run = true;
> 	mutex_unlock(&vsock->rx_lock);
>@@ -779,8 +781,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->vdev = vdev;
>
>-	vsock->rx_buf_nr = 0;
>-	vsock->rx_buf_max_nr = 0;
> 	atomic_set(&vsock->queued_replies, 0);
>
> 	mutex_init(&vsock->tx_lock);
>-- 
>2.34.1
>

Code LGTM.

Thank you,
Luigi


