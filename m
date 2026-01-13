Return-Path: <netdev+bounces-249495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6629DD19F90
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369133058A20
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE03D3939B7;
	Tue, 13 Jan 2026 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8gLRKCT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrmS9Uxv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB2F2C15AC
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318946; cv=none; b=BqKdnAYVifjGJ3lQr1xE2htJbgON03tBMJx8XFuYA4djiUR0kKu6wpUESLTkb01CW8d/t7zrVxr7HmN6WMXIaLONhBY1u1KVaF949WOWCMLYHKH3pDPr5AOmsGE/X0vVplVaqEgO3N5IbXYrPP/ErYnn4e0TgS3SdXwnH/ZORBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318946; c=relaxed/simple;
	bh=z0ktrf9THh1+HjKG5G+Ar30QQHeNINGUrFDEbpyqHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNqF8zk3O4mjBbmmLK1PtePtmnT1ML3V2IhFhmS0N3lwozuFq1Umfbq2YOFQj/Er1ZN5BMvPRjeXnxMOBg4VjG77Imyh85QfAzPTdkHm/sXClcsNI30Cz9SKtdO1mjYGII0HRFox4W3/WhdkRGzUM9UXEWcG1uPKBanZ25Gp9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8gLRKCT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrmS9Uxv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768318941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
	b=L8gLRKCTG8A0pIxbSDq8d59kJSAo/YnbYJejOdZv1HnjvR46WaXGxvXUXepr1A4I55P6jP
	O4x6xBmB7dz7JhvvT9OnP4WGkTlBawTlnNBNc2VnSijYykSWOcgsgTWLBkdQEylO56eA8H
	LIzKQvteKdnfUkc+FgIKHIopz7gaBTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-aB4BTDP6ODu36WBtGaZOdg-1; Tue, 13 Jan 2026 10:42:17 -0500
X-MC-Unique: aB4BTDP6ODu36WBtGaZOdg-1
X-Mimecast-MFC-AGG-ID: aB4BTDP6ODu36WBtGaZOdg_1768318936
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso3045925e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768318935; x=1768923735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=JrmS9UxvNExe9f0SxaMLZoIqNBf7wtmAt8LITJYbNiw8wcDm6muI6r2os8ZOKn0Ca6
         6WO9MVzG9DOZulAg4srR9tXLbN3f9YohQoXAZ9nBFl8dVw20k1mSwxkOX8w0dTQMliaC
         sOypnMmVoneA9NqPRZEPqV4c3JRZ+QQpTqFsh3Ve7qzdbEvI0ubsOpaDN6KWOxd1mKfa
         k0+ns9Tv3H9VxsrLEMWAUjj5fJt4fdvlxq/kUgGWGhzMPjPS4qxw3rNwXYBqtiGEFRt5
         7o39St8tnHHvicCO5whiI7kF/E/yOR5la0T2nmv3ZTyZhdr4B9mZZNQj7KcyVnk6qM6V
         5NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318935; x=1768923735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=oVxnbMa7TkOT6KVInkvfpwcuMfOezC0j5bWOUB2rLmFZOjJfnvPWIIEQjiJrBYphsQ
         AI4WlS3ppy34y0IN0/KA3AhQBTF3cBrpj/Gr2NhtheVbMkrMM3f//5SWeCsiNwp7Aexy
         4pmn4xMSSgj3yX1bFKCSK1igZ/xBebjIr6ddvwXI9E9EtaEqMYeRgjcUjvt0Q+CM2Z/f
         SRggskatZ5q8E4QGEMzilS602UjOibEFBOIgdbUrGKEtnFjX/bwW0jWBayD5F0HOtB7Z
         hxIl8Bhl/VG/OuGWoPMcrKGiIqDWhj3PWMj6chsn6CAfbLmtFMgmhQymEf/INsBcruYy
         uy0g==
X-Forwarded-Encrypted: i=1; AJvYcCXd1FzHq3a6VPzIzFxUKa0lAJ8FR8Lt/Z24+/QxneqLTtrhdVqKH980RBgpR1PtMdPQlepXuUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHAdrLk9hU8BfQZdmaKr5Ad5vOZDZkCfOzRL2Zy26h0F6RqmV
	QkMWwnbZiZXcLiz1L+9evxts3H3yGAxuP1ZLmPxozqQPwsuWplMhgWgWNj68OMpuOR1hx/X/02e
	hVgmB0ztTS49DunDMlMJVQOiS0PKzSHnMeMXIM9Il5ih3LGyUf8g4F2Y8JA==
X-Gm-Gg: AY/fxX4NJdhAYIV/fWVfGVAqcgcC16q/hPrKxFEh6CJJEpiNM/F18C+j/HCRWo98dWS
	zeqKWqWTIngo9LFreJGCz0bj9uirCAPUe8vAPIaqb5duXlI8B6EolTGyVKJDJunURZzKzzgOTgv
	0RxJ2k5uNO3Q2kzDlQkQKLH/qW9KSAfkZx9Hgk+vKCzZkbCCIAVMEspWL0NoYEnKxg6JpbQANR5
	PQ33RLwGb0x6o67N4r2zYmFE1UpAz5VK8fEIcc32DTr0XXwN2N/LanYUrFkncTd/vGXfUhT0joT
	3CIpYx88/ArPdmb9BRZYl3tGHOYAYv3KmeddhQhvC8acGzP3ddAqRM9+bU5+vlTKb4I9mAtpHXP
	8lpU3EtieD1Vg8eR9aga6WinFKLRlTeBDHLLqqNklOHT9W1dYPb5RxOV9t9rF4Q==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241263005e9.32.1768318935381;
        Tue, 13 Jan 2026 07:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4paz0040d/vitY+T5rv1eo5WHxtcQ4X4vPvSUCFKLot5Wf40qNTKU1VjGBirJbB8u4247Wg==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241262525e9.32.1768318934958;
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm45281481f8f.17.2026.01.13.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Date: Tue, 13 Jan 2026 16:42:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 04/12] selftests/vsock: increase timeout to
 1200
Message-ID: <aWZnnHxzaV9pgwzb@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:13PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Increase the timeout from 300s to 1200s. On a modern bare metal server
>my last run showed the new set of tests taking ~400s. Multiply by an
>(arbitrary) factor of three to account for slower/nested runners.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/settings | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
>index 694d70710ff0..79b65bdf05db 100644
>--- a/tools/testing/selftests/vsock/settings
>+++ b/tools/testing/selftests/vsock/settings
>@@ -1 +1 @@
>-timeout=300
>+timeout=1200
>
>-- 
>2.47.3
>


