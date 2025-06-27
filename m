Return-Path: <netdev+bounces-201887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA8DAEB5A6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311A63BF670
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF32BEC2F;
	Fri, 27 Jun 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Psf/xmMb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B829552F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022085; cv=none; b=bSlQydDUZRNcbCQVjD5aMngpDNopzJz/Yx5Z2qfCY0XCqoKAG6N1GW6QRpe3HCKnrEhubsvxIg6BKULB/ZuYPILJvPCa6p9gwEkytYnGY3TUPL50SbFc8iI5OP0VERfhUJkx6m6AWBZCsl1cuTQTtSXFPexQBKbLE7pkCb6013M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022085; c=relaxed/simple;
	bh=ZbJdgOIbkGwBeQnmkTbzv066EyMDgSE02LiXwxp50sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrcFkLwC8EWR3BDK5eDvbs9Vx3g/QexbjIAiiMyePKoP68KBU5VK98zP9e3n7mZPaZk0E1qtBDUB5BWIq1PnGp0EdVDHpXa0N+jRQTWmyyvVqouT6/w/Q+FeKx/lRoiPNuTP35fBSCCL8i+O6bTPZfKJjL0vCyLrVvqemfBxgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Psf/xmMb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751022081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbJdgOIbkGwBeQnmkTbzv066EyMDgSE02LiXwxp50sQ=;
	b=Psf/xmMbBHgShJ6toEH8rd5591TixXJEO2AjVEsV2vcf7AQqMcwA+AtPYx/fw9kvSvb17H
	vjcYim9rL4Lzft1gdOjg5i+1mR2L+uRHtLYrmcY9z9k7KXIDMf4/AWbbPJRAHSVHk7m2+M
	ZUUO6bdsfrlQ9ApyfPU5XU+GN+pwUFE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-fIYr3Bj0Mv69EHj4pl5qNQ-1; Fri, 27 Jun 2025 07:01:20 -0400
X-MC-Unique: fIYr3Bj0Mv69EHj4pl5qNQ-1
X-Mimecast-MFC-AGG-ID: fIYr3Bj0Mv69EHj4pl5qNQ_1751022079
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ff810877aaso25082726d6.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751022079; x=1751626879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbJdgOIbkGwBeQnmkTbzv066EyMDgSE02LiXwxp50sQ=;
        b=qDtzBL4OOQg/qPQk8M6YZy/fZflRyisPnFhApNJVdajWyqI+L5qTJdzL3cHnWVK+AG
         zQeFqhsffRxwX1vdHf8x4avQKsje52Ib2KUVSeSdfEJckKAf3C+eLbh2JDU7KmG2qt8p
         E/0+2It4kWI8JB569XkAtQ39vH5W0FNJs58SFMr417EFXi7VTWEMec6z6MkT6uO+4YVL
         1o8CPuiCQ68DyFWp1wDX44GVtZUVo12f0zQ194/vYnEb4bxOSzHRsK/nP0aHQJlgLBZi
         FSwucrs/98zxqS6CfaXJeTGW4nKUeI0hkZMHxPZpJlV9yrKzD+2d+hjszR3rXHV5vudX
         fa1w==
X-Forwarded-Encrypted: i=1; AJvYcCURS80mqwxdY1JyFzGd6/LPgFWH4G2lccgeD1ntv9dwHrOtdXWkrcS/lnNrpyA8TW5wZqvdPZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6kb6ts0Qh8RRoMqS5bKc8wuBEJG2AXu8DzreZKti+VIK7pMQF
	7AhNs12aAQlmE2atkHjURZddiTdAAukzTsCK8OUECpePYR+FauO7yOKE9funVreXNU/b6sKIZdX
	XY5d1WhAqLj3u0mO8xQRBN1ZYWMoIplyW5VPPC0enCWXySImOy/krM3+PqQ==
X-Gm-Gg: ASbGnctQlT2rPcVUGhzaSd4oJ+YotYl6YVKKXNikJ2mFYjEPaMBUAfcIkcAS1d1szkX
	bh1z/BH1FMso32csuVP280bGjW3Jxu4yMns43hYwnwI3FAib/yX0PTXZry4VEymL2Ya2eVrdL3D
	erjcKV0TvXfR/jN/qKO+7Jeg/jYdaUxKCgvCM+HdAS6IuJCcZkwHyCzJhmLc8JOCgaGfc9FIfez
	7sxHeoHbqS4LxZtPBNR1Y/UkiPwhf6Ouop79zBUq3wqLsaeMk7UY6wmjJtJOj3BPhPVzqbSjwxX
	CTtzzYqSaqauwboPYAMizz35AWZh
X-Received: by 2002:a05:6214:76b:b0:6fd:d33:bf30 with SMTP id 6a1803df08f44-700033b6fcamr44379896d6.44.1751022078488;
        Fri, 27 Jun 2025 04:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI8TS4H6eRA0UouWBKDumbd4mbbqZxeye6OCeaKrfLx9sLYI9IeIKljRoNoP6GNozp6MQ7gA==
X-Received: by 2002:a05:6214:76b:b0:6fd:d33:bf30 with SMTP id 6a1803df08f44-700033b6fcamr44378836d6.44.1751022077610;
        Fri, 27 Jun 2025 04:01:17 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.181.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3f2dsm17994826d6.78.2025.06.27.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 04:01:17 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:01:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Xuewei Niu <niuxuewei97@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "fupan.lfp@antgroup.com" <fupan.lfp@antgroup.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, KY Srinivasan <kys@microsoft.com>, 
	"leonardi@redhat.com" <leonardi@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "niuxuewei.nxw@antgroup.com" <niuxuewei.nxw@antgroup.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 1/3] vsock: Add support for
 SIOCINQ ioctl
Message-ID: <ubgfre6nd4543iu5yybkmnd2ihbzfb6257u7jjfz4xqk4nhfdu@43yfocr4z4st>
References: <wgyxcpcsnpsta65q4n7pekw2hbedrbzqgtevkzqaqkjrqfjlyo@6jod5pw75lyf>
 <20250626050219.1847316-1-niuxuewei.nxw@antgroup.com>
 <BL1PR21MB3115D30477067C46F5AC86C3BF45A@BL1PR21MB3115.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <BL1PR21MB3115D30477067C46F5AC86C3BF45A@BL1PR21MB3115.namprd21.prod.outlook.com>

On Fri, Jun 27, 2025 at 08:50:46AM +0000, Dexuan Cui wrote:
>> From: Xuewei Niu <niuxuewei97@gmail.com>
>> Sent: Wednesday, June 25, 2025 10:02 PM
>> > ...
>> > Maybe when you have it tested, post it here as proper patch, and Xuewei
>> > can include it in the next version of this series (of course with you as
>> > author, etc.). In this way will be easy to test/merge, since they are
>> > related.
>> >
>> > @Xuewei @Dexuan Is it okay for you?
>>
>> Yeah, sounds good to me!
>>
>> Thanks,
>> Xuewei
>
>Hi Xuewei, Stefano, I posted the patch here:
>https://lore.kernel.org/virtualization/1751013889-4951-1-git-send-email-decui@microsoft.com/T/#u

Great, thanks!

>
>Xuewei, please help to re-post this patch with the next version of your patchset.
>Feel free to add your Signed-off-by, if you need.
>
>Thanks,
>Dexuan
>


