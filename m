Return-Path: <netdev+bounces-98891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A218D3072
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBFD1F27D58
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6816FF26;
	Wed, 29 May 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8kXc8yD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238616F28C
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969903; cv=none; b=eZZaa0W76V4wtakeBDDAjnAAs/tM74JOyD4LxLvAJEnYOeEmuf45mST4JZbuFl8kqTR6eVQFh3anl01WUlZUNj5CvpqmC97z+ZRWiz3Cb574LqZjQe+rr/UTk6aIXYxQlow94cMvdqE/ED6noHHDhAHoCEc60hv2V/yfkz+7L4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969903; c=relaxed/simple;
	bh=mxwFgX0ee/RsDjwK9KZLEjg+gxWKY3iC6TRaX0vb9Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQM8Qyvvid9aJXcn3pQ2pFy3nMW2IgM+gWOlCaZI2v4LhpbgLO3XoIBgCi3Ww4mJD7fds+MmIhRUggIP2L32KFUi6N0gEIPXcnZaU61m51idAuKkd1rYOnnHds9cy7YqjCt7HB9SYXAeBaWwmvoKjfEv9k1hc5B/Z3oQVk/f7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8kXc8yD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716969900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0znsjLSE1yLPWNM3y+n583dNDLRUtm6D9bl9xtR23U=;
	b=Y8kXc8yDY+h+exZ3efbea5OGD2SLaLaylGnVlEfvBTZUbkj523aEt/3JIGMParuooeUi0v
	HK/T+FjM0o52koIxd98wvQJzCYwmJE5J2Vjae/23kLY+3aXQwZSkfSqa4XELDsqlF3qgUT
	5gNKgVCaqwWedBeiUJZWZrlh1Uh3wGE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-zK6H2zNTNryt8U-tWK2jwg-1; Wed, 29 May 2024 04:04:58 -0400
X-MC-Unique: zK6H2zNTNryt8U-tWK2jwg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a62c4ffecefso89816066b.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 01:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716969897; x=1717574697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0znsjLSE1yLPWNM3y+n583dNDLRUtm6D9bl9xtR23U=;
        b=rNObfZKsDJ61QKxYsRoOBjcXK0qcozQxlf6JiN4tawZjK7e7bX3NPMre4r97rms0mD
         4m5XdFKEoCVHmYW72VcyB6O/xSpysyVkyC9xslw2i0Mgufh7M9FVKC8htmsTSzh3XRfK
         0kAR6F/vepiyQcQO56c0ofpO4JLJr7f3Usmh2sIopCWeN7+JZ50U4RbY7cUXCHHVXIau
         BGKlrvHEvc6mBkWZeSsFeQ7/0MOSbNCHm9NU6slaWsz/UxWUh10mNOxZGMHVY5+Gt11D
         noFZpHkFiu3qIy5EhI+ACMQwyHDVsCHh8t5KjTHPr0HM6MxMn+OicVIbS6uTDDPtwQGL
         q/8g==
X-Forwarded-Encrypted: i=1; AJvYcCXdzHriDPuKGjWeF6h9t3KwBcZi60P8FcZ7vlKUr+GdyouWpft8oSX1yx1FD90nzZENRG6HkWHGukDWc3zpa9drOIieZPMT
X-Gm-Message-State: AOJu0Yy+3GZeRMMCpBJnNAzgfoRTdeUK+8jUzxijXZUPRMbynK8WsLC2
	0BLRx05jAsJ+/j61PdWJuqAU/pEGftKcR+MzmLKBgyZ7NBQw7lNgaVSPCi+91Sb9+Y5y/8XuCtF
	Lm8C0tOh7EtOmtUtZ5MNx6eRrnHlnlalLhhCxJEgtJmfARqFL2H83Tw==
X-Received: by 2002:a17:906:1991:b0:a5a:5496:3c76 with SMTP id a640c23a62f3a-a6264192fe8mr965920666b.6.1716969897466;
        Wed, 29 May 2024 01:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3oZ6DAlLfDM/y03ogAch7fcEovR9jFh0/fcAMsdrO8YhuD4/gBBFarrhWDhn7bgaFEHpEA==
X-Received: by 2002:a17:906:1991:b0:a5a:5496:3c76 with SMTP id a640c23a62f3a-a6264192fe8mr965918366b.6.1716969896946;
        Wed, 29 May 2024 01:04:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6333fdb2b5sm181142966b.211.2024.05.29.01.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:04:56 -0700 (PDT)
Date: Wed, 29 May 2024 10:04:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>
Cc: Alexander Graf <agraf@csgraf.de>, 
	Dorjoy Chowdhury <dorjoychy111@gmail.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, stefanha@redhat.com
Subject: Re: How to implement message forwarding from one CID to another in
 vhost driver
Message-ID: <l5oxnxkg7owmwuadknttnnl2an37wt3u5kgfjb5563f7llbgwj@bvwfv5d7wrq4>
References: <CAFfO_h7iNYc3jrDvnAxTyaGWMxM9YK29DAGYux9s1ve32tuEBw@mail.gmail.com>
 <3a62a9d1-5864-4f00-bcf0-2c64552ee90c@csgraf.de>
 <6wn6ikteeanqmds2i7ar4wvhgj42pxpo2ejwbzz5t2i5cw3kov@omiadvu6dv6n>
 <5b3b1b08-1dc2-4110-98d4-c3bb5f090437@amazon.com>
 <554ae947-f06e-4b69-b274-47e8a78ae962@amazon.com>
 <14e68dd8-b2fa-496f-8dfc-a883ad8434f5@redhat.com>
 <c5wziphzhyoqb2mwzd2rstpotjqr3zky6hrgysohwsum4wvgi7@qmboatooyddd>
 <CABgObfasyA7U5Fg5r0gGoFAw73nwGJnWBYmG8vqf0hC2E8SPFw@mail.gmail.com>
 <sejux5gvpakaopre6mk3fyudi2f56hiuxuevfzay3oohg773kd@5odm3x3fryuq>
 <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb-KrmJzr4YBtuN3+_HLm3S1hmjO7uEy0+AxSDeWE3uWg@mail.gmail.com>

On Tue, May 28, 2024 at 06:38:24PM GMT, Paolo Bonzini wrote:
>On Tue, May 28, 2024 at 5:53 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, May 28, 2024 at 05:49:32PM GMT, Paolo Bonzini wrote:
>> >On Tue, May 28, 2024 at 5:41 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> >I think it's either that or implementing virtio-vsock in userspace
>> >> >(https://lore.kernel.org/qemu-devel/30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com/,
>> >> >search for "To connect host<->guest").
>> >>
>> >> For in this case AF_VSOCK can't be used in the host, right?
>> >> So it's similar to vhost-user-vsock.
>> >
>> >Not sure if I understand but in this case QEMU knows which CIDs are
>> >forwarded to the host (either listen on vsock and connect to the host,
>> >or vice versa), so there is no kernel and no VMADDR_FLAG_TO_HOST
>> >involved.
>>
>> I meant that the application in the host that wants to connect to the
>> guest cannot use AF_VSOCK in the host, but must use the one where QEMU
>> is listening (e.g. AF_INET, AF_UNIX), right?
>>
>> I think one of Alex's requirements was that the application in the host
>> continue to use AF_VSOCK as in their environment.
>
>Can the host use VMADDR_CID_LOCAL for host-to-host communication?

Yep!

>If
>so, the proposed "-object vsock-forward" syntax can connect to it and
>it should work as long as the application on the host does not assume
>that it is on CID 3.

Right, good point!
We can also support something similar in vhost-user-vsock, where instead 
of using AF_UNIX and firecracker's hybrid vsock, we can redirect 
everything to VMADDR_CID_LOCAL.

Alex what do you think? That would simplify things a lot to do.
The only difference is that the application in the host has to talk to 
VMADDR_CID_LOCAL (1).

Stefano


