Return-Path: <netdev+bounces-190165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C241AB5663
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457F37A91DA
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE7298CD2;
	Tue, 13 May 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPUf4DXB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B05256C82
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143875; cv=none; b=anGYJSSYOldcZ+9eXzuQFEfdICKn8Ki/zzJrq8cz3fj5OV0Hf0kqvgqPjcyiZTnFtdw3NS3BOMEuKFNeDixLLz7DnXaCQIw2cnmmkcnbXteediNWJdUrbuxDl7ZT+Y731L99Ud4neYVqqbhJqxpl1v3sl4IZKpkBmuOsdLBgjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143875; c=relaxed/simple;
	bh=e4eJ1305I+EgHcEaP7lZEmnVbMFKKOUHcQqiW/2DwFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqfFsIZhYCoppJhWd3iiv876++tvZVvFefmKLRPDYx02eFSe82Kzc7RMTiDCFUKxereAsFMIbtSqg5RRgYK4ssaRBqq0qzEHxE5A3zJcAwUULn5QOjVLkNA4QWblUYZIlei3SJsX3vP+VcZZiqWqjhQs4YeQpfL5RT9J6JcBCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPUf4DXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747143873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jguUTZh5JvRuhjXFBXsB5gTRN4crP6ONtuEb+MxDCd0=;
	b=ZPUf4DXBVOWcr2iIAKf3IPRQUtoRfceIt4lULHS1OQZUip4YIoaz5UArdIUCOIY8BH5DVE
	Q3Q1o4lSr7vdqFu+XDZWBCylFjzFZdr4yZAi+ORBwDUdifQu875LZ8TGptgN7ZV8LT7C6e
	kHdCEg/cEqhQSCEouF9L1csxo2+2NE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-RR-kpTHdN3eIE7ANCXUmSw-1; Tue, 13 May 2025 09:44:32 -0400
X-MC-Unique: RR-kpTHdN3eIE7ANCXUmSw-1
X-Mimecast-MFC-AGG-ID: RR-kpTHdN3eIE7ANCXUmSw_1747143871
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a1c86b62e8so2019306f8f.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 06:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747143871; x=1747748671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jguUTZh5JvRuhjXFBXsB5gTRN4crP6ONtuEb+MxDCd0=;
        b=NDQIJ/yMD6C3dZerdMo3h+jpn2BwdK1q/jnfIKcsnC/k1rVOPpQzwPhwoAUIje55yy
         DduT1xL3/duQLg7a6TovedzUP+Z7ShHncq9MjMaf39HgC9GP2d0QeykfezkW7MgMZt7T
         cKIfF47qC6ehgymjGrCROQ/eF7llK5OvqQvcgK2fdMsMp0bmXbXQZa0x876ejkX2ha4c
         gIvt58JuHe06V6kaNEK57lxWUAv9fsYJWVJCLcDsaA22M18TL0MGBpf1FxbsBRq+SwV4
         16r4G/8KpZCT9uAIoCJEWy03/ujopwf61j9IAAZdAMx/gG86hzWU3uKLR1MUGmW7Ol0V
         KAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg8J0mSBTX2o1QpXwK+22TKDcOugDkeRMyDmkmMLmr1aActTKwOb2RzOJqRsFKcp1JwOPJWsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+Ov6n4WGdIJKFjUUYPv9lnEExtMyz+lN/gE4OnRTrNGWWplS
	Yv7TrJNFQu5buY3rI5jcyE8xZPmuwUir7WJS1L64yRF5dpI5eGo1Kt8UXScD2dbrVQ49kyv4o/4
	mUoVFNzPxVQ3MpavAcHSgtK+GjrgZfhBdStc9oAnorNx0qeOpguTuBQ==
X-Gm-Gg: ASbGncu6ZsEQT0LY12epnlPRv+Jx6Bdc5Nc+FoliAMr8ileTu6sba33gszwczFSHccv
	4gQ5MPFGI9w4C0PIRtWksEK+Fx5K7KkM88WAJjBpkM82zvYmG6nr9DsU+oWgxhy1YjqSKpJEC97
	fNja5tjRfBxJPYam6lbO6ymhlSrSAuYfBTs3Hc8ogVJd9/N4ReMS6G9fMtcb7mIPXR+CCZSzdmr
	8cj8EYDYGex6zn5X0Y8sShTHBaksBbIbbliBvfSsBlx/qbAph50TrF21OW/EHkHLqu5GNaeJ+zt
	1UhUOKmT54Iygt0=
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id ffacd0b85a97d-3a206b2e7cbmr6897534f8f.28.1747143870777;
        Tue, 13 May 2025 06:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJPvRc2d/tScX3zj2Zy4dIA1+zH01wyvfnGBVZQ5VJgZ3BSnWeMNjMYPwqRM4uUjlqx7Agqg==
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id ffacd0b85a97d-3a206b2e7cbmr6897501f8f.28.1747143870216;
        Tue, 13 May 2025 06:44:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ee95asm16433764f8f.11.2025.05.13.06.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:44:29 -0700 (PDT)
Date: Tue, 13 May 2025 15:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ
 tests
Message-ID: <2lh2s2nnhiyqjlwl3xgkh3ujjipaggi3isjgrhgi27s62exh7m@bwyn34knronr>
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
 <2d2a92d2-1844-49de-a869-4caf2677b099@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2d2a92d2-1844-49de-a869-4caf2677b099@redhat.com>

On Tue, May 13, 2025 at 10:46:35AM +0200, Paolo Abeni wrote:
>On 5/7/25 5:14 PM, Konstantin Shkolnyy wrote:
>> These tests:
>>     "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>>     "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
>> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>>
>> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
>> have been received by the other side. However, sometimes there is a delay
>> in updating this "unsent bytes" counter, and the test fails even though
>> the counter properly goes to 0 several milliseconds later.
>>
>> The delay occurs in the kernel because the used buffer notification
>> callback virtio_vsock_tx_done(), called upon receipt of the data by the
>> other side, doesn't update the counter itself. It delegates that to
>> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
>> more than the test expects.
>>
>> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>
>Could you please provide a suitable fixes tag?
>
>No need to repost, just reply here.

I always get confused whether to use Fixes tags for tests, but I saw 
this patch target `net`, so it makes sense. BTW IMHO it can go 
eventually through net-next, which is the target tree I usually use for 
new tests but also test fixes.

In any case, the tag should be this one:

Fixes: 18ee44ce97c1 ("test/vsock: add ioctl unsent bytes test")

Thanks,
Stefano


