Return-Path: <netdev+bounces-153431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B272A9F7EB5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D404316A869
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3620227597;
	Thu, 19 Dec 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDbWAe/6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF0227572
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623982; cv=none; b=kWZJLvbvcbI1Fsv/d4VTu2uztswcfcjyF1CYC01RVTV+9YMcOQwBmvaZLxw9XNBWW7T9mk0hXfNQTzwGloZ+YENTJZDNUgnFm8f3yuLSjsLKLtW9v8mfGRPqJ2e88nyptRZ3wWtK3lEgVNVuDMf28Bqma7CvYi+IKkv7fmB7PTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623982; c=relaxed/simple;
	bh=PRDlVnJ+lz+v+0flVUNa/0SSx/IXUeQ58RFeJfY+ju0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UUlyl0puP+tMX1TLQ0X5KLtRfKGI504+NhFc4tuds0XIgmKfA/rbNJ1OEOPsNDX5Yb37F7ejYW4z2nhB5XMd/UP8svRCMG3kgwlMwZv/1hHOxRM6LRGhoQaW8JDMv7/o5EBHdSl8dWSzjG241xdR+pBHAGhW58bxcsPUl2bX8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDbWAe/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734623980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeXJ+9eOuBojqjaWbtglakf22ej1EC139vROG4UPeEw=;
	b=PDbWAe/6FXgosLb+m7eqg+jqfbbQpxD2yvRt+huqcdIWdhDn7SfY2HmIyEv9ybeGMJlqj7
	Upum1kDiJoBPYcb8pX/2DWiM77NYqAS4DjBgdj7g6/VWWVBR/5rEdg9KFYvL12KSTVjAfy
	X8GGmPUg03kijbBLlaX8RCUWTCYk8dw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-1JZVfBBDOKasj9b1bXBWLQ-1; Thu, 19 Dec 2024 10:59:38 -0500
X-MC-Unique: 1JZVfBBDOKasj9b1bXBWLQ-1
X-Mimecast-MFC-AGG-ID: 1JZVfBBDOKasj9b1bXBWLQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361b090d23so5989265e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734623977; x=1735228777;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeXJ+9eOuBojqjaWbtglakf22ej1EC139vROG4UPeEw=;
        b=H9+3uS7mddyQTWp7104eiek3+xW2hdHlRh8u/OqEa82aJSA+okbQ+0yN7xDzXjUxEN
         /m2bAPssJP3drf8bYXkNXEPdIoH1esqqxf9SfKECOWGX6vwzRsliCDPziAjJUq/231Fv
         ToS9eGfNxgN9UfqNtUHsF80hh+wd/nwrsJt+IJOrlP4EEB2Rqge826J9qSmIKUDlWz0I
         Ii+fBsgng/eVmQnO5qSPNq7FYiI3eubEboZDU/LiJAJExHL34pqy3IFPS5Y0xbf5ik8T
         jzmXI4eq1ALxZJWX6dxoyzBmUAaif4gryeuSsa/abIx94usp24tL3EyKQArZfBpmnQ8J
         LpWA==
X-Forwarded-Encrypted: i=1; AJvYcCXAkWBHG2SwFoR3jUH+i9JrGOAQmgcvBlMPWYauoJRnEeLa6Z/DYICD7G3wlCkvPACekvgsGO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3VtDWvT29yzZ/sZAh9X+8WptuOuMDtTk6p8tA6eYchMAVtwf
	EOTMnhTdMVwLqFWHe9HZddc1ulR1bcB1wG/co0ZzxE5Pzd3eAPLC6JurOD/HNDUIjRhP+bK6b0y
	Az6+PV2YTvhHYAiS2KuckF4mkgO701whOZkto1zMs8h6iDjv5ll+K4g==
X-Gm-Gg: ASbGncvkSy8UulWrG/i2/rCuDzwxDwrKVsjLp001l1UMLokWvx92ynMqTRTcuu+UUlA
	BeH7WaEQ/7ncQLrW1Cg0mQGgQgetp42oZercsrys1+FAZkDsZzu4TZimDsBmaq/h+uQ5ogzUgRx
	Dha5hE/T3MGIiFxc3mj1x11+ybtsX0LEc+TR2C29wDN2J/23vxqVEoNk7j+bSVz8NXIAOp4qhi/
	7uBW8hSsl9mW+///r5t4WIQDaREILIIZr5l1eFxHay1JejMaQ6wW8tMxCYYSeK1urnIOfJfd38p
	XbTTbuHsRQ==
X-Received: by 2002:a05:6000:1864:b0:386:37bb:dde3 with SMTP id ffacd0b85a97d-38a19adedf8mr3745917f8f.12.1734623977541;
        Thu, 19 Dec 2024 07:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0ky2xcLD6V4+yRb2yLTfIvrXgkf0VGSLARFV0SMp14tUyScPfYSLMsThOQvk82jIqQq4iiA==
X-Received: by 2002:a05:6000:1864:b0:386:37bb:dde3 with SMTP id ffacd0b85a97d-38a19adedf8mr3745900f8f.12.1734623977129;
        Thu, 19 Dec 2024 07:59:37 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c493sm21248875e9.28.2024.12.19.07.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 07:59:36 -0800 (PST)
Message-ID: <514a98db-7bc1-4923-9fa8-d4e1f7cf40a3@redhat.com>
Date: Thu, 19 Dec 2024 16:59:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.13-rc4
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219124011.23689-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20241219124011.23689-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 13:40, Paolo Abeni wrote:
> Hi Linus!
> 
> Happy winter holiday! hopefully nothing too scaring here.

I forgot to mention that, depending on how many important changes we get
over the break, we may skip sending the next PR or two.

My personal estimate is that the next one will be skipped.

Cheers,

Paolo


