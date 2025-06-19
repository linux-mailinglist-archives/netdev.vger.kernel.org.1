Return-Path: <netdev+bounces-199501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F0AE08E6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCF41882A25
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2440D21ABB0;
	Thu, 19 Jun 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g10h/nbK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0791B3923
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343828; cv=none; b=ae1snS7bCurA8SInMTgFj7sZyHEDSSAIu2IChzq+URvCpUp12alUh5MRhX+673ozgHGe1j5tldrj1gbIf9Vvfig94XOCzDxnB3gQRGSDmY5t4bHz++QM9VJykY9aLWJY0D1817yzKazs7/nWcymyopPl/YzW7Hpu7MZL/ssmn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343828; c=relaxed/simple;
	bh=ekC1gZofIY8iWEncWwUpRLgaSYwrvCy+9gyoPA6v7RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+s/9ivjZW0088xMG5mHNp9iiRjtHXPkqhTtifGH0Rwb3us48KtVQntTZMzmuD8OnLfzCxbHEOvBA8UtEHI4miC8o1OsoofwEwy4bhYJj0jZHU+OdVL5lqlH4n7HFoq48BmAaU8GDOWboV8a/d5yFZarxVdAPWBe75ar+lB/mXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g10h/nbK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750343825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5bKhap090gI4gk0Sc0KZPGQExHq1xc+XHOz6xNuPw4=;
	b=g10h/nbKPdFTjqEiUKCtoLb9mI69IWgfszsD7MRl04sau5T3nvhR6ti4mgWfyIIwZMznqN
	2Mad9hIZpZwGzV4ZcBGqV5z4RqJZAmDNzkIs9Q8vGP+s0d1BYJiNMztO4d5jxNqJJm/s9w
	U/ceQHLGHBlMQcjgHJ5rI5o2V82iRLw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-5kLOhoggM4iqdkLhP684Mw-1; Thu, 19 Jun 2025 10:37:04 -0400
X-MC-Unique: 5kLOhoggM4iqdkLhP684Mw-1
X-Mimecast-MFC-AGG-ID: 5kLOhoggM4iqdkLhP684Mw_1750343823
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso5337395e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750343823; x=1750948623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5bKhap090gI4gk0Sc0KZPGQExHq1xc+XHOz6xNuPw4=;
        b=KZzen7Kr3VLA9gxEaxW+BHlPmZQ8UYEDcGwcbukKaiP4fMmcoIfuz9WRjl2HHeqVCk
         yGflVEAhGc693hCsdomWmYuyTvfkNaIA7qzA9oq0XuHyy0ytUj75UDGbvmxFXkDNbTiN
         R3Wb2ryO823gYqysi8uBNn0ZsJh2i5SwPKqHHUXMn00+BXZi1RCIl2E1+gCKCBoLtk97
         eg9EnbPFXUcLHJkK6DEeX+85gbO/XypgnLztalErfvDRoY/4r9TKH15w3YLG0/wXsiJR
         xlh84oH3hWXczAPO3DX3WeoMLVTRHCQNTR+SdMYhQrtElRNYZyJWmt9gL36XRxToWmVE
         s3vA==
X-Gm-Message-State: AOJu0YwoX70SlZixe1SlnmoIwZgiAAkNoVqrQOuqcqwFViKtbtSIpcxn
	XAf8lKrel2ilXaM3L8Z+OMDQrEMHqTTGeBC0Ih5fQRIXE97cGSFKT/XK6GhplEU5XhAxKaH/LR3
	2QooIMom+fW+Gqzw1eSS4sgntFuTZJKFW8a3MRAsCB8TUFj6GYbikxB1hbg==
X-Gm-Gg: ASbGnctIH7oKMOtIksMKH8D1NpRcnie9W62nDfx+xLOc/VnwNFl6IJ++cxd9nHMkR3f
	oVryqmOaAyd56yz2hiRO85x0M+/iWiYp6fiZU3yh9VfIhhbVld7kY0ok7uqGky2ftrKpvZKJo7W
	Uc5uk524PFr3Z4nTSu7gQNEPtGKpBjfZily3gV4zVuSCV0HQtV5QgEemeHNCwmj6pzCKjcADL+I
	XSE8FIvEppEDkaeHqG5TxhDAx9F7pd6OnNReLOL/gphrWVcV0QyYwV2/2NaRbu23cjOXuvylFiq
	teIeDCSKjrMbL0QYJkSHP6jL57Km2A==
X-Received: by 2002:a05:600c:828e:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-4533cb52d92mr181973835e9.23.1750343822661;
        Thu, 19 Jun 2025 07:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE49fTAJBQKqUknCpFSAOF28Fof061CUYxGiN2fbdKc8jmCSRPIHZ6tsmNArMxl6kSaH4PUXQ==
X-Received: by 2002:a05:600c:828e:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-4533cb52d92mr181973615e9.23.1750343822202;
        Thu, 19 Jun 2025 07:37:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a53f79sm19450122f8f.4.2025.06.19.07.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:36:59 -0700 (PDT)
Message-ID: <691c3a35-45da-47f7-88fe-5679805fa6e9@redhat.com>
Date: Thu, 19 Jun 2025 16:36:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/8] virtio: introduce extended features
To: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <2d17ac04283e0751c6a8e8dbda509dcc1237490f.1750176076.git.pabeni@redhat.com>
 <20250618191440.0361c343@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250618191440.0361c343@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 4:14 AM, Jakub Kicinski wrote:
> On Tue, 17 Jun 2025 18:12:08 +0200 Paolo Abeni wrote:
>> -	u64 features;
>> +	VIRTIO_DECLARE_FEATURES(features);
> 
> FWIW this makes kdoc upset. There is a list of regexps in
> scripts/kernel-doc.pl which make it understand the declaration macros.
> I think VIRTIO_DECLARE_FEATURES() needs to be added to that list.

I guess the preferred course of action is sharing a v5 including a
scripts/kernel-doc.pl patch, right?

Also I'll include a stable reference on a public git tree, so that this
could be pulled both into the net-next and virtio tree.

Thanks,

Paolo


