Return-Path: <netdev+bounces-141474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA09BB11F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DF3B22C47
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D11B0F0B;
	Mon,  4 Nov 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdk9a0B2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7E19E990
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730716257; cv=none; b=V/2UKlSVe5lGGtWX+SnJBFD2dg70h8Rcp401CW5FaNJ9q/Y137mreNF7y5as2HoAxXnq7i1rvz1AdGVzuqU1jP49887DFff4drG4za++4emRc9Al/4UZiB2yJjlpidHucvM7woo6p7pVaRMJ7MzHG27kO0z5vu/EM27sr8uJ0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730716257; c=relaxed/simple;
	bh=I395zEKb8Bev9f/3HX43LehcL9J13vNgFXO6d9YNxC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWUCChOEPoKqQT/9s9zEbghTGLDaz1su1iNoUAC+XtjgRio1LUldVyt/P5K3X0/vvWg1x30PX5Qs5NGhK7EAlowGo09dEjUIjWsDfnTR2IRWWPKo7Fxvwc8ksEIMA2mc29+7drlGw+ZBC40c/n6YP75tQ+0iavu+hwwangr1aIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdk9a0B2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730716254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3eJy5WNiwFRVMqcxFsMidLua/jpD3sD4ZFQw/Wge0zg=;
	b=Mdk9a0B2kPS95Q94l99y/Rkwix8XdwaydL+r3tK+YDRhOnKeKtGEd8k/jjJHUZr97tPdYy
	7p7bZ3/OeY/zytmHIajcFB2DYAwQlOYPjWW8PaNoLoNWQFHJpBqhCNhFoiAygY/NhQZXXj
	IUn9dPqzkvAD7uDHcUX/a11w5nPzwC4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Nb_U09IoMw2iyaXEXGUIUA-1; Mon, 04 Nov 2024 05:30:53 -0500
X-MC-Unique: Nb_U09IoMw2iyaXEXGUIUA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a2593e9e9so271245266b.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 02:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730716252; x=1731321052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eJy5WNiwFRVMqcxFsMidLua/jpD3sD4ZFQw/Wge0zg=;
        b=ktUZ8dmDk2EYKwH2XpJhjVuHnYbwxnUqq9ciginwAfBpfE7RhG+msV/6pX9KhhT6z6
         rXXwfA1ySFTvydukAEUBPV5GQZPbfVoMrm1ctStVJWpswUUXa5VaQmQSpWEGrXhfCTtO
         Xmn5lKmIl+RbDnA3OP79M8rcRCmPyLzAQ9EA1h36Wq84XG2cjd4Q2kWHSsXoRo9YyHNd
         goKSUN18GK5IuQbqlnksXRSVfxT6dwSsXVVsC4XnwLJv8jnhkQjKRIQeyWRr0MkhXgfA
         WEB6W6kqhZI6Dpi6YvTXJo/DBZTSKMBVOa+4InDKUTXLJKs7H6wY20eOLdjV/9NVmTkd
         z/zg==
X-Forwarded-Encrypted: i=1; AJvYcCU20mfDdJciU7BA3BKj0i2/S2fpVUI+9CkNMvJanGKr1buOFmd4jypC0hR9zOGtJV580zWszvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq5+5qKK32wrvOS4yf85pQyiqER2mU+tpyQ/X6occ692Ved2d
	OnDlb8cO3r6pGvOeFHr9Xg8lGw9vf09WwnckNKV7gSL1PHoOOphOOLYh3rIji0rrZT5dYWHbX7C
	2mw17VPVCMi9V7n/pGJNCs+Ufgxda8J37a7t0TxfrQKyG/V2ITW4PGQ==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr1193849266b.0.1730716252202;
        Mon, 04 Nov 2024 02:30:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoQpPCpx3YecoTHWC0P3yZ07ffXbK9Wd1bdfoDP5+ZNFBDPgR51GTmMRuTd96DXek9PCnDWQ==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr1193845366b.0.1730716251575;
        Mon, 04 Nov 2024 02:30:51 -0800 (PST)
Received: from sgarzare-redhat ([193.207.102.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c53d6sm536943466b.68.2024.11.04.02.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:30:50 -0800 (PST)
Date: Mon, 4 Nov 2024 11:30:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v4 2/2] vsock/test: fix parameter types in
 SO_VM_SOCKETS_* calls
Message-ID: <m3yaa3o6gknyk27w6enfyp4xs76yn6dyawxaolafvf3r6fffa4@rjbfmbxmc26f>
References: <20241029144954.285279-1-kshk@linux.ibm.com>
 <20241029144954.285279-3-kshk@linux.ibm.com>
 <7o2b3ggh7ojcoiyh5dcgu5y6436tqjarvmvavxmbm2id3fggdu@46rhdjnyqdpr>
 <9accb7aa-d440-40dd-aee9-10b334b0a087@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9accb7aa-d440-40dd-aee9-10b334b0a087@linux.ibm.com>

On Thu, Oct 31, 2024 at 11:04:06AM -0500, Konstantin Shkolnyy wrote:
>On 10/31/2024 09:16, Stefano Garzarella wrote:
>>On Tue, Oct 29, 2024 at 09:49:54AM -0500, Konstantin Shkolnyy wrote:
>>>Change parameters of SO_VM_SOCKETS_* to uint64_t so that they are always
>>
>>In include/uapi/linux/vm_sockets.h we talk about "unsigned long long",
>>but in the kernel code we use u64. IIUC "unsigned long long" should 
>>be u64 on every architecture, at least till we will have some 
>>128-bit cpu, right?
>
>I'm not sure what "unsigned long long" would be on a 128-bit machine.
>
>>What about using `unsigned long long` as documented in the vm_sockets.h?
>
>I use uint64_t because the kernel uses u64. I think, this way the code
>isn't vulnerable to potential variability of "unsigned long long".

IMHO the test should look more at UAPI than implementation.
Since we document to use "unsigned long long" I think we should use that 
in the test to check that our implementation behaves well with what we 
suggest the user to do.

>If we change to "unsigned long long" should we also change the kernel
>to "unsigned long long"?
>

For now, it should not change much to use u64 or unsigned long long, but 
I agree that it would be better to change it. I would do it in a 
separate series, though.

Thanks,
Stefano


