Return-Path: <netdev+bounces-123249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C21964495
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E08AB210D8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E09D1957F4;
	Thu, 29 Aug 2024 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXrvQv/4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D618C35B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934802; cv=none; b=MI4NITlSGJwMgEGlybZRSLhUTXvg93y3srfQlxBrp+dQ+0QpMo2DaefsqAF34UP2s5UjXjZ+0j7ShoINKnx54bLn8uj7A30DemkURPeH2A5l17LZ7AeKAKGKyHyyt8qV/8w6fj7ojQL0bAMJqCwxBtNRxwc205hMhU7Dn3nqytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934802; c=relaxed/simple;
	bh=EcAhnCfMYdSXlmNlommpCdA4tVwrlwjRudKqztdv2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhCGdL/Bg/yQ8qyqTWaOJzYI6MVJv/c7mQwMdafWm8yc92a1EGcM35UOzTAgJOKdhIUrsqd74+theDbPSf/RQ0n8PLcCjfbQW75F2mAOF3SU8BoWGfezxu+syNfSlooVMelPEyH+AnbtbqRE08uRlrNJeRFnq7XEks0YSbDghAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXrvQv/4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724934799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4r8mPnSNtJ1ADg7xoeNSb8EXicSerPJ5Mj0MvPbcOgA=;
	b=OXrvQv/4rDK2EvbHRjcnxU3DXySHJCtbvYRXtfBBy7Y83ZpukbzC/Laj6B6RiGBlGj89ht
	89/2/eUJLLZpzYAYuHnIQ0nEUGWtCax+w7YzFaEHHfT211UKKxnTbeMM4IdElBnNSEBmTP
	i44kUnE7bQnq4M0E/e764UApiW/+uHc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-8Uzo6c1PNZmUwiiHayhTzg-1; Thu, 29 Aug 2024 08:33:17 -0400
X-MC-Unique: 8Uzo6c1PNZmUwiiHayhTzg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a86690270dcso54721766b.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 05:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934796; x=1725539596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r8mPnSNtJ1ADg7xoeNSb8EXicSerPJ5Mj0MvPbcOgA=;
        b=PN9+3ToJecq5HQvdo+hwCPBbNK4XOc8y9TrA0Xl0eOWnPwgKspVeS2XJgjVBPme7hu
         PKI6OCUrPl100Hd43JlQZTrW4pnvGM6PX1JzgyqzO3/uKnd1ZqtkUTXbTmURd5vZapye
         Rt0hezuusJWSKTM6l2PzzQ9cLyezjeD5rhKP86i30x8a1UAFGC/2zf90kc2Z6ECXi7dB
         hzins7JhWtaedm6EdRWugapej8luoq2e1xZufyi4J19hOrm8avUKcd9GXTczILCGsgjb
         j8DMs3S4Ft1ffmZnMP+KO0ZYiMU6hndBXQAnVEovHNruh3TJO+hPVM6gZQt0AZYK4thO
         KDCg==
X-Forwarded-Encrypted: i=1; AJvYcCXs0kjycTkhvebN68BJBJdNdiaZXBHRKAMKdPekYwLkdfrX+yPfEEXIW9jDkz2axS8tqFuclKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiUu9ET2lH4vvfliAkJxDMZvS/VliA7xVpVzoohCugczgdgJd8
	949VVCHFv0k71r+F//+BtM/q5k7p6XSj2VsZd+z4HOvlL1wMRzS0BhiRBeQys03ODPIEiIuOiM+
	QeYhKmZjse3tTUW5krq8znPVS9aAcRXLKajKLw+B53AWi1jlmUEVKHg==
X-Received: by 2002:a17:906:f589:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a897fa77ef7mr195703366b.51.1724934796387;
        Thu, 29 Aug 2024 05:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/JxqSYvZUsly+VKW9p0GbBwk8Ss46rzovAiRElrugRH0yhB2zK0/lvCUzjRHB8flUdXeiqg==
X-Received: by 2002:a17:906:f589:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a897fa77ef7mr195696066b.51.1724934795491;
        Thu, 29 Aug 2024 05:33:15 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.99.36])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989195e8csm74386366b.105.2024.08.29.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:33:14 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:33:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Luigi Leonardi <luigi.leonardi@outlook.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marco.pinn95@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <22bjrcsjxzwpr23i4i3sx6lf5kkxdz6zjie67jhykcpqn5qmgw@jec7qktcmblu>
References: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
 <DU2P194MB21741755B3D4CC5FE4A55F4E9A962@DU2P194MB2174.EURP194.PROD.OUTLOOK.COM>
 <20240829081906-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240829081906-mutt-send-email-mst@kernel.org>

On Thu, Aug 29, 2024 at 08:19:31AM GMT, Michael S. Tsirkin wrote:
>On Thu, Aug 29, 2024 at 01:00:37PM +0200, Luigi Leonardi wrote:
>> Hi All,
>>
>> It has been a while since the last email and this patch has not been merged yet.
>> This is just a gentle ping :)
>>
>> Thanks,
>> Luigi
>
>
>ok I can queue it for next. Next time pls remember to CC all
>maintainers. Thanks!

Thank for queueing it!

BTW, it looks like the virtio-vsock driver is listed in
"VIRTIO AND VHOST VSOCK DRIVER" but not listed under
"VIRTIO CORE AND NET DRIVERS", so running get_maintainer.pl I have this
list:

$ ./scripts/get_maintainer.pl -f net/vmw_vsock/virtio_transport.c
Stefan Hajnoczi <stefanha@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
Stefano Garzarella <sgarzare@redhat.com> (maintainer:VIRTIO AND VHOST VSOCK DRIVER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
kvm@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
virtualization@lists.linux.dev (open list:VIRTIO AND VHOST VSOCK DRIVER)
netdev@vger.kernel.org (open list:VIRTIO AND VHOST VSOCK DRIVER)
linux-kernel@vger.kernel.org (open list)

Should we add net/vmw_vsock/virtio_transport.c and related files also 
under "VIRTIO CORE AND NET DRIVERS" ?

Thanks,
Stefano

>
>
>> >Hi Michael,
>> >this series is marked as "Not Applicable" for the net-next tree:
>> >https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/
>>
>> >Actually this is more about the virtio-vsock driver, so can you queue
>> >this on your tree?
>>
>> >Thanks,
>> >Stefano
>


