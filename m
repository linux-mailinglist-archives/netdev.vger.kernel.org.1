Return-Path: <netdev+bounces-166424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0732CA35F5E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E6716ADFB
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4A3594C;
	Fri, 14 Feb 2025 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMwxk8/P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE37265626
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540096; cv=none; b=Ei7Tjr3gJcjkpAL6Ol3V2K8Eh7kG6irltwaJjg2DaRYLKW7ipkFtsCnprisqrbjk4R7RXsXd1ttIY6wMuV5+/HKS2Aj16CJhzSm05xyArk66YB0XpXfD5H2e3/AgXZE5alBBjnnMiSJ3AgwB+dCV6ehxklbNszE+l5iJJYW/98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540096; c=relaxed/simple;
	bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flX3fZmagN3GVGBVPgkLwlHMJ2wTupK6I3yEKUzVvOyBs+Sz7PMAVVzF/25/t1dvpNJzDJO+KhKRA+NjAsXDa7kidOlu0JCXiZlI3mDehrGjqYGY3kINzza6HP0yB9a/q5sqRcUFrEUjUzOWpYRXkhwiY49APSx8yaRux1YZFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMwxk8/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739540093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
	b=TMwxk8/PWl3VwTKftJRLP1A4KcVqukr9XjdzEBTOaJWQnn07OSqbKgshjyMks0vBbsx4LY
	Y3B9Q3o/+1eoGvR9XwSfc+zk3gi+0a6XqDjL+3KbH7+EGK/Ho6faNj/NRtpbIXe/YgeOAf
	raaCOXTcYn8IueVlVepZPqWhzwNv7Ss=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-qxwX74m8Oam4kZwyAby4GA-1; Fri, 14 Feb 2025 08:34:48 -0500
X-MC-Unique: qxwX74m8Oam4kZwyAby4GA-1
X-Mimecast-MFC-AGG-ID: qxwX74m8Oam4kZwyAby4GA_1739540087
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so359976f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 05:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739540087; x=1740144887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rIrvF0Jv/axJissqScQNVkSpcTz+uHX2dYGRedQ3fQ=;
        b=Z49R5MlDgq6SlCxR8yB7gqyBSGplVCOuwLssIZ9xsuXCPCYNQPZyFr+GAReb6zyUhX
         YVrmJbbWH1hr1CY3zPGjAM+gMR2/tiCkubFdu8EtRsHnoimbkxgnedsZT4q4hQ0YdLqc
         qCtqMYETarrUXYusw75H+EDDxFQtJmkrxPT8Y+rf3fIuB9s9udBwdhwyDtuNzGuuRIFu
         Bz+yCRQcBaVt+yUrvr6RUdC4NqRpNpElbBCtKg5FKl8Fvfh8m+/J/5t/SR6nbvFpyhIm
         bnNG/GJq843Wq300/nmCJ12CHuGghYT2SrF99t85f+SFs0ujmZ8n9rLtABJ5sFP9ltKr
         xh5w==
X-Forwarded-Encrypted: i=1; AJvYcCW5QIbZO7qZE9LAhA/JFhtQVD2T3dEJoV4h5hBBbslv0/8X7csZ6ZKthr+w2stMb1IklDVA+E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJwxbxmDZGP12At3lBVZxZv1DCXmq1cyxN0LIRXlSWMFAPmRY
	Vvg64AiQVw2C4szCj44L1H5g6i3L5FfAWKhZB9inXJmi9Omwzxv7MadrgM7BNC7j177OcJY9uDh
	GVnh7b5/GpODDIgh4oGMIi524j2IoJUiATkxIG2SEOu6FN67c+6tjLw==
X-Gm-Gg: ASbGncs5njpf1rIKPFCwK1W/aCyjPWuxd6g037AI6JOeNFLJwrq+qC0gklU1/YyIvfp
	UEz+qc7eFe7JPfqFTvRzJgCtQ3q+TSWGY62hMHcOatn7yHXchFzBL0kMv9X6yRRo5xCc53H4g+c
	PaTle1gnCODNLXiYEPA0EXx7L1HShvJxkzZnloQEjykvMxWqFDk+dQVxxyii/QU0MPT4V25Yb0O
	wUf7lof52oVED0CDiEOvYW/PN51xXDTwW7gYiztopOsSLjGs1h2Bd8OsTqsuVuaPIY7TyX7Hj/f
	dwiZiO0KzwhFpA9pn5p/i4j2ourda/o1VRrq95EWxB0SFVnI9b1D9A==
X-Received: by 2002:a5d:4ad2:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-38f24e1bfd4mr7382219f8f.0.1739540087270;
        Fri, 14 Feb 2025 05:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBDfyv1SdJm7R5cH01+wLfhjW4AOVc7JnS47asJmAAjRGNm0ow+MsDNI0LRQYW/dCz7cuhNA==
X-Received: by 2002:a5d:4ad2:0:b0:38d:e3da:8b4f with SMTP id ffacd0b85a97d-38f24e1bfd4mr7382167f8f.0.1739540086611;
        Fri, 14 Feb 2025 05:34:46 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b43d4sm4600179f8f.4.2025.02.14.05.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:34:46 -0800 (PST)
Date: Fri, 14 Feb 2025 14:34:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, 
	ying123.xu@samsung.com
Subject: Re: [Patch net v3] vsock/virtio: fix variables initialization during
 resuming
Message-ID: <7zof7x3scn2jlszxwynyaw3i5lcwfo5j3yrgw2sraq6pw545h5@zwoqaewlq2m4>
References: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
 <CGME20250214012219epcas5p2840feb4b4539929f37c171375e2f646b@epcas5p2.samsung.com>
 <20250214012200.1883896-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250214012200.1883896-1-junnan01.wu@samsung.com>

On Fri, Feb 14, 2025 at 09:22:00AM +0800, Junnan Wu wrote:
>When executing suspend to ram twice in a row,
>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
>Then after virtqueue_get_buf and `rx_buf_nr` decreased
>in function virtio_transport_rx_work,
>the condition to fill rx buffer
>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
>
>It is because that `rx_buf_nr` and `rx_buf_max_nr`
>are initialized only in virtio_vsock_probe(),
>but they should be reset whenever virtqueues are recreated,
>like after a suspend/resume.
>
>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
>virtio_vsock_vqs_init(), so we are sure that they are properly
>initialized, every time we initialize the virtqueues, either when we
>load the driver or after a suspend/resume.
>
>To prevent erroneous atomic load operations on the `queued_replies`
>in the virtio_transport_send_pkt_work() function
>which may disrupt the scheduling of vsock->rx_work
>when transmitting reply-required socket packets,
>this atomic variable must undergo synchronized initialization
>alongside the preceding two variables after a suspend/resume.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Link: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/
>Co-developed-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>---
> net/vmw_vsock/virtio_transport.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


