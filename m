Return-Path: <netdev+bounces-246060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B34CDDE84
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 16:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A8A300ACFB
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2031AA90;
	Thu, 25 Dec 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfmRrSd6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BC1B86C7
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766678144; cv=none; b=kqI4oUlSMg/+tHP+F3mDfEkoxXd5HKP+x+Jeoh6Zvb5V94El6eWjmOH1AaHPW5jVZUB47pcPJSs3A76C4fux4hf87HrIowYTarHdVpjnIWgd66EJp4PlxRBcHZgeSsxJpzLHXG7Xdcm/DEvztZ3b+5eR1w8/dtCVL9UZ9IyMukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766678144; c=relaxed/simple;
	bh=DgG95W0KWoWtUbCoxucc6TeEUsImaF4Yq6XZDFST7nU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sff73BeP+KeMycBY943HAh+yKYCUTFeTcx+gbwbIbA0RSFeERAFqdTsMSg8GvRqF5cqAZpQwLt4RMnK3s4H2GKWjb5J9am1Z4cOZBi+SuKNbLdNmZBcFX6lDN1XXyErz7z0FDo/OTI2HzC1kDDrUSWhq1a/5xatEIIYUxt0mtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfmRrSd6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f2676bb21so89472865ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766678142; x=1767282942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hYaWKXWkYbIN4q4wZN9wEW98pBsJkuu1pUVxbOWJvx0=;
        b=XfmRrSd6C83afEl9dmiyKzl0oIlBpBIn9dUE9Mi853GtLtDhBdx3jwMyTYTY9+rAbk
         RZPUVUGDZmHYVebdO4WK63S+uSJ1K4d59+0vxA8loD98SOh4jAWIZEh2kk+Mkvkvi+vJ
         8IC/L7Loijf3Qbh1cYj2Y6LyqJirBEJbQ9Jr0ct9516yiW/gfs8avib9rAWxYfyKyPuQ
         BN/lsilC1dRPVCNpsvxQfMdBR0QW9f4sYlCA+ApOHKTLNIhvcoLm0AFkFpiwQN13zNhm
         tjP6DYAs/bUBOQGVFxKNs1BXc4QiUWdx+vzeHepripnrwJ1Gd97M24+boPYAYPDG9eSG
         X4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766678142; x=1767282942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYaWKXWkYbIN4q4wZN9wEW98pBsJkuu1pUVxbOWJvx0=;
        b=SBZRaIq4UfnLVx/5mbztMb8VCuQcEd4AK2uzOw82c1sV7h3Ks8q5bR2IZqzaqRvIo+
         /97F9tAVMI/oT98v1WWAaQFEm7cIf4FMgDKN8Wc8F5IiFaLx+frg1wBdkv7/dE34Gm51
         IH/aoRKpJB9a7Vp6Z3TTjYmA1MnKdA3EMb8AW+AVdb+VsLn1Dru1kjMWxvCHBpkKpv6a
         JNTSn3oPLXuvrVx8urby6cUQV0r7ZInpsH3BlQP0a8ldSU4FP8wdIlDAV7xwnRk2ekar
         OO/q+oehvsZba0JQyibIxub2C1fA+AjtQ5vpbQY4GYbHrdjDflIWYQVGFwzQmB/INynP
         7fgA==
X-Forwarded-Encrypted: i=1; AJvYcCUHALaI5nmpzjgjk//4CmyGzXY6EozuxcpVUax39pV3+Ubbsu953YGA8Tu4/Lp7GzsQD0ixu+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLlkpnPJcJBVuuWtXrCYyTs3Tl85PaBYxg33kr/xEA23KsIef
	Gkt4RQsSN/j/1PDPsWkS/FXSj/6/fPUce1zuLznkTlgBd9QuV6/Q5snE
X-Gm-Gg: AY/fxX4JvYmaQjTLOJinnhSm9ukKEGyHCPLYhUcOP9DkCAMNg/sUVlb2v8JvZi6VRsF
	WFFtiQ0CPGZ0i8g9dFn5S3MOEecvrlQbOFlZ87iZ9T1ew0s1Y+013/xQjExrHXttcKzJP39unLU
	o4eQV8uRxSEYugI8LC9CESd/nrpCllk4/EUBcFhufM+38VO0QpcbnFNI0DBGf/nr8IWcJvZyoz4
	nY/G8jx4oAsf61jhs/o11HpfF/JqeJYMxCjVfaJ37QItwB0+SZBpDUJsfm79fy922g2XRUyCGTR
	ebE1dlhl3cXSPvKk4MXfFthL2t6f1kxavtFTpTc58Lr4s1UovY5SJxiK9N8jwoDvcOcQAtZ7Qj3
	JIscVNgCiQH9jL4dNjJAdUymI0yFM54bBhaynm2yPSsvgFaByLVz6cUHcmlURoozAadUXz42QVl
	pC5wYEv0i4pZbd+6XHCG3xEzC8++iLoSXBEfHgjVMeq9+nMzHyIUM5wgo9qJN2Jg==
X-Google-Smtp-Source: AGHT+IFjaNIMrol5SdAN856m9AmK7B5O/amLAW7CnntJVFYaTER95zxgN8oN1gQDiGKwdhTwQiVC5Q==
X-Received: by 2002:a17:902:da48:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2a2f2a4f5acmr169647525ad.50.1766678142511;
        Thu, 25 Dec 2025 07:55:42 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:77e8:13fb:83fb:4ed6? ([2001:ee0:4f4c:210:77e8:13fb:83fb:4ed6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c839b7sm185337805ad.37.2025.12.25.07.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 07:55:42 -0800 (PST)
Message-ID: <dd4d01d7-29a8-43b3-bb5b-f50ea384aadb@gmail.com>
Date: Thu, 25 Dec 2025 22:55:36 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Content-Language: en-US
In-Reply-To: <75e32d60-51b1-4c46-bd43-d17af7440e74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 23:49, Bui Quang Minh wrote:
> On 12/24/25 08:47, Michael S. Tsirkin wrote:
>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>>> Hi Jason,
>>>
>>> I'm wondering why we even need this refill work. Why not simply let 
>>> NAPI retry
>>> the refill on its next run if the refill fails? That would seem much 
>>> simpler.
>>> This refill work complicates maintenance and often introduces a lot of
>>> concurrency issues and races.
>>>
>>> Thanks.
>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>>
>> And if GFP_ATOMIC failed, aggressively retrying might not be a great 
>> idea.
>>
>> Not saying refill work is a great hack, but that is the reason for it.
>
> In case no allocated received buffer and NAPI refill fails, the host 
> will not send any packets. If there is no busy polling loop either, 
> the RX will be stuck. That's also the reason why we need refill work. 
> Is it correct?

I've just looked at mlx5e_napi_poll which is mentioned by Jason. So if 
we want to retry refilling in the next NAPI, we can set a bool (e.g. 
retry_refill) in virtnet_receive, then in virtnet_poll, we don't call 
virtqueue_napi_complete. As a result, our napi poll is still in the 
softirq's poll list, so we don't need a new host packet to trigger 
virtqueue's callback which calls napi_schedule again.
>
> Thanks,
> Quang Minh.
>
>


