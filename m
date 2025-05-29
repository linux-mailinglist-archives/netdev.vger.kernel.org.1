Return-Path: <netdev+bounces-194150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F8AAC7923
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 08:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422BE189836D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DB2566E7;
	Thu, 29 May 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPf7xsKz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6520E021
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500888; cv=none; b=a1oGj/5evjAhs92g+SuI4uLi8gaoxS+s1WH1JQq9ZFNjMj5y7f19ndDAXdMvd2bY6kaV3zvXY1WDmP7SBmzPbGLrWDOWewjlEyTuFyRCPdw0188oxx7MIZnmKsD8//OvBLbAxKc880OCgjigjxweZwtSbId8b1yjiodIsnf5p5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500888; c=relaxed/simple;
	bh=uo6zWtMJAmsChlsFAzrq8E9fCgS8gXBxbYq/eth/kWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfvPa0+OThfqR9wYvztVzQKSfGz3nN9h4rLRzyaQzl+bHriyXZSD0gX/komFG/ZF6HVDanQKehn4q4jLOnROB4+G+N/5nJTSHC+eOYb/2eoztYr4Gp9LimLQXbx4UhKCmuG9xRiR/HxcBprYus/UnhZ+dBV4oY8YX73F1Mn+Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPf7xsKz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748500885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
	b=UPf7xsKzYABpkxeUyDePSTbs6E9MnkX2E0KJ5mjhVZxqOftdxPBMkMczr0yoA+dbMZwJj7
	NlnsaEwoLhUp3ZsdEJWGrjAg2j3WEVvENMHjKibWKiWK6dhNvZvEay6vVGQVl7Q76kQaHF
	izTqssu8Sp2P8ZKPPNmJcF6DiNReRsE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-mTFjvOhAPrqjfW4Brb_7xw-1; Thu, 29 May 2025 02:41:23 -0400
X-MC-Unique: mTFjvOhAPrqjfW4Brb_7xw-1
X-Mimecast-MFC-AGG-ID: mTFjvOhAPrqjfW4Brb_7xw_1748500882
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso344633f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 23:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748500882; x=1749105682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
        b=htYW83A7J40kYokMi1vMoQOJEC5+WuDzk3TY5b3Z9KRR2TOSxliGrc+8RkUvAFRx9d
         ivGJW3c+ATPRVL0c+drL0bYyzDT90tScXOVbUQrsO77qL6KiKCcT1iPCpdgMicUOkHnC
         kf80EVilglD1ivocuUOWGyJV/MZd2pXvLsznBZJFWMIIeuoS2iYFQ/9tb8A5oTJIohTy
         cBbmtq0kPohTEvWPhOBfS2YdNyXeebU0s16Z/CAlahXHIjIUrw+idku+EJAtMogEtvVK
         nPLoWIYto5S9BvwAMdQl79evPl+ZnnkEErRgg1XspsX2ch/wubg8Ap8so/FHXDafatne
         TeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7lRXRrVfLRNG+JEp6/A/k2iETd7QDhUzcOPcYnWjC4VeVWazeVJbgQAoP/ZmLPqMDxXbHjLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4s34Kg0Ztg7o8FYUBVwC90k9nQ6rDPXa6UZR1FYJ1BWdE3R7
	oClhQXXd9gZPxUoNGHtFKij7dlHG6S/haAmM+fyCqVQpWvwtuIJODx0CJBx+s145Fzxyqk5LfWD
	Y0HgXx7D12vprkdAfSCDjO7amwyzH7dngbSCuoaiijjNQJ6c7kxk7OKlkcA==
X-Gm-Gg: ASbGnctfU3naQABYW/tY634xGvkQa1b4NjZEh1CsVGJ+b3R2znxPaP3nd7LcdNVPlsS
	MQ2364GBjqvO5pGpRblXbVJM67DV2eAZWxVWPQxGvWzEZBzNw+rQyXvyq09KUedHNDgdlf5YF6d
	KK0LUSoqI5OUTq8ngMULgIOVM3vgS8yxcouZAnymsBKaCr2EB2NeMFYW9w3we7bMuU5LUy3uP4n
	N4xhcDFvdnBoxrPiAB4bvPLy8JXrCbrOc/uDDcmSJvA50uOzFuzPiRpEr/LTi2VPDl4FAQPATaZ
	9f1svtf5U4sI/VPQ8F2XC64Ki/MbhCqUwMKz89jgKx2Rn/8sW4kNWnJtXZA=
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603438f8f.15.1748500881772;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WDum86fTnMvRYqch6MR+ztEYQ2eZPtIMANK31N5JRpHf3kQXQ5zQS9pHaQJE0QCeX7DRPw==
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603408f8f.15.1748500881399;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971efsm1015064f8f.62.2025.05.28.23.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:41:20 -0700 (PDT)
Message-ID: <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
Date: Thu, 29 May 2025 08:41:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v6] net: mana: Add handler for hardware servicing
 events
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 11:42 PM, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.


