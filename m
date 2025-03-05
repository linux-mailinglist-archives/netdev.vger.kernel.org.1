Return-Path: <netdev+bounces-171962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BCA4FA78
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4541B1891A90
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA480205ACB;
	Wed,  5 Mar 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm84WtU1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8D205504
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167792; cv=none; b=a7ewKlBu6B8kQNVSLTIpRTPJ34gETVnrSIzvV6VxMeGDaZwnSqxi0Q2rTalomlfh0tGqW0OA6OzFDhBFo3Fi/c4qbGI5871bR8eXykE4WiUyS/rYdnSQsdr/LAOqHxw/MlLTudiWCGYUXjlPOPnyXaNN+rRimN0IpgMcYo2AQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167792; c=relaxed/simple;
	bh=imtuAnpaAXGOP6kzkiTdpwhJ9L3ewSs/OCqwVl5NK7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyL7rEL0M5Kc1l3wYHhaN5pLTJX8LhGVjZrAG/s7GA75qXo+pEEicOPsx2x8w4bfmrvSAqkHxe+Of08Y+Yp+kVOhCUQwLXPaRDB4Cb6532bW9mdkhFKmAgecLUe7s7lieaNOei3AonT6jdWcZ+AiC6Jvp+bjHt7Kkju+BXQwlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sm84WtU1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vq2Dveu3Lu0iWioX9TM10BGhlOQ2RzAuJnxk7fM0ty0=;
	b=Sm84WtU1vfKMjtm3CF5PkcE9qg/2rw7tKVCzLNP4uzI+Ka9b7gu1ZPYV/jtmICr0wVdWNE
	b1JbnPO+YBt70wIeiz8H6EyD8du/jcmCQ4sALA2dAFlAzL7p4KodBU08kqTvBDKFOlrXCJ
	/11AuQsawn+UoAnAtOzjK5DoLyraJ0c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-NzjCE7R9OFanvqvA7pD0BA-1; Wed, 05 Mar 2025 04:43:05 -0500
X-MC-Unique: NzjCE7R9OFanvqvA7pD0BA-1
X-Mimecast-MFC-AGG-ID: NzjCE7R9OFanvqvA7pD0BA_1741167784
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abb9b2831b7so71706066b.1
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 01:43:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167783; x=1741772583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq2Dveu3Lu0iWioX9TM10BGhlOQ2RzAuJnxk7fM0ty0=;
        b=QwrcM+ytvppqUs7rMozkIaI3dpAfrL9KLx2h8R8+1sQcwG7VsDYuhoqgvkGg8ogChj
         lH82h4O3mXb0m9euiGfYbPg3RfC1KaVI1EWPVWJZb49oOUyxMILENbJHa2EF6l7SdiNv
         KmnM1ljqPwDaUMpnAAFFIByX1MaJHAkACv/lhElpHFSjGlsg55IGopZgoLKSxyMU2RO7
         XfKHDi/H1n99vPiQeMq5g8K8x17GqAJwmzEEbHhwOcgYhvjBqUyRmsX7eNECLOGsSkX5
         3JkQc7SvnOTE2x1KS7SQ3Cuu7A93AXLNbRghTyg68H8K1QHQW5heBxXHf/HOFmlmKpLP
         ySOA==
X-Forwarded-Encrypted: i=1; AJvYcCWdrQuA+/vdQ0uk5EeU8TPaE9ZG7WIFw9qLcje2o9ZZE/NfnHkcgMdo9xtKMrfM4rMhfrw+wJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1SkjjMNs00lgOgumCc4g60Pif93ZWVlUk2S7+7l8emHl0cs4
	fhPHbLXH+JOZernnKb4Z7vuo0bqZG78Q5Mo/i0Lk6tVFp09xXlPiLtiDfXqUUHVlv5O7azm6KHd
	6DNrrHgJdoqDFQv0xgUmlyolHlhfFktmUgHyaa6e7man79TNUEnI2//YuzBooQg==
X-Gm-Gg: ASbGncsf8R5k8A8JbuZsBuHooYnxnClT4T/I8u8GEZPtnyuuh+BVR1hzehq9CRqBdE9
	vLt1H+einJzwvMFqyxGxC66OocuoCZUbzgxU4DjDmuwnjHwtFWhLV7P0StfbSI/+QwcAHegHibX
	f8b62DqorCSxPutorXS9jAxafjfMytPebI2Ok5oSCMYh2wb9GQaUWSsoYWb6Pi0HNYw9vTfftmY
	Qilbpo9mIASeHqynoOexwKl0cxJjmdNsKErW5IGBY6zuU5HzBdDNzPWhI2HGTZ9mgH8V27nTuB6
	vBR8V3pL2znEMKD+2NV9u7gfQSoQ8VN8rj25U8BLr1Lox+qMwG34h/0RFHOAaa4A
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr209685466b.28.1741167783281;
        Wed, 05 Mar 2025 01:43:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5B6S50i1HDHEaJU/jj+bI1k8KZTn2nF4k4C13v/0HHoQCH0wJ+1c900aMe64d5Ks6YGak+w==
X-Received: by 2002:a17:906:c148:b0:ac1:f247:69f5 with SMTP id a640c23a62f3a-ac20f0139aemr209681866b.28.1741167782581;
        Wed, 05 Mar 2025 01:43:02 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac21dd2c297sm28756566b.110.2025.03.05.01.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:43:02 -0800 (PST)
Date: Wed, 5 Mar 2025 10:42:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <cmkkkyzyo34pspkewbuthotojte4fcjrzqivjxxgi4agpw7bck@ddofpz3g77z7>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>

On Tue, Mar 04, 2025 at 04:06:02PM -0800, Bobby Eshleman wrote:
>On Thu, Jan 16, 2020 at 06:24:25PM +0100, Stefano Garzarella wrote:
>> RFC -> v1:
>>  * added 'netns' module param to vsock.ko to enable the
>>    network namespace support (disabled by default)
>>  * added 'vsock_net_eq()' to check the "net" assigned to a socket
>>    only when 'netns' support is enabled
>>
>> RFC: https://patchwork.ozlabs.org/cover/1202235/
>>
>> Now that we have multi-transport upstream, I started to take a look to
>> support network namespace in vsock.
>>
>> As we partially discussed in the multi-transport proposal [1], it could
>> be nice to support network namespace in vsock to reach the following
>> goals:
>> - isolate host applications from guest applications using the same ports
>>   with CID_ANY
>> - assign the same CID of VMs running in different network namespaces
>> - partition VMs between VMMs or at finer granularity
>>
>> This new feature is disabled by default, because it changes vsock's
>> behavior with network namespaces and could break existing applications.
>> It can be enabled with the new 'netns' module parameter of vsock.ko.
>>
>> This implementation provides the following behavior:
>> - packets received from the host (received by G2H transports) are
>>   assigned to the default netns (init_net)
>> - packets received from the guest (received by H2G - vhost-vsock) are
>>   assigned to the netns of the process that opens /dev/vhost-vsock
>>   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
>>     - for vmci I need some suggestions, because I don't know how to do
>>       and test the same in the vmci driver, for now vmci uses the
>>       init_net
>> - loopback packets are exchanged only in the same netns
>
>
>Hey Stefano,
>
>I recently picked up this series and am hoping to help update it / get
>it merged to address a known use case. I have some questions and
>thoughts (in other parts of this thread) and would love some
>suggestions!

Great!

>
>I already have a local branch with this updated with skbs and using
>/dev/vhost-vsock-netns to opt-in the VM as per the discussion in this
>thread.
>
>One question: what is the behavior we expect from guest namespaces?  In
>v2, you mentioned prototyping a /dev/vsock ioctl() to define the
>namespace for the virtio-vsock device. This would mean only one
>namespace could use vsock in the guest? Do we want to make sure that our
>design makes it possible to support multiple namespaces in the future if
>the use case arrives?

Yes, I guess it makes sense that multiple namespaces can communicate 
with the host and then use the virtio-vsock device!

IIRC, the main use case here was also nested VMs. So a netns could be 
used to isolate a nested VM in L1 and it may not need to talk to L0, so 
the software in the L1 netns can use vsock, but only to talk to L2.

>
>More questions/comments in other parts of this thread.

Sure, I'm happy to help with this effort with discussions/reviews!

Stefano


