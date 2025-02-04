Return-Path: <netdev+bounces-162474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339AA27003
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67401881AE5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3082C20C007;
	Tue,  4 Feb 2025 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9rLamfL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1993820969D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667560; cv=none; b=Jqpug6urLTnvzTLxYoZVP9BZHmnLc2yMVCXYDeFbWtebxhl5wgmjyE6yn3xytuF4XVTfULYQHtn+pohXaKNc7H63Plnr8Ok5L+hC0Tprstz4gnogRpWgNzym/mwPUeusDv1Gf4tHob2d88ebKO1fL5RqVWAc8qfndSYzNqIvmO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667560; c=relaxed/simple;
	bh=1/713bN1D8cUTwz4gjzXDUB0uMBKEzC0B4M22LuuSzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTmdiKx4TnwbLJZtN98TKMNGEsqq+DWDOUMamTiSyvlCW5DOjXSeApYxobw/f0zHFyRZ46jri6kei+vL6xFOJA4Fm9s+bFUxsCeqyFNAkthA33FLPA6DRPVYq2IXHfyeNK2KANorLd0qKndKTcxP/IpRygiKjJ3FIHEHAyyX9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9rLamfL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738667556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQ3PkXkywNKtr2C3RWWqSpKemWRzvU4xaOraOKwYJnE=;
	b=a9rLamfLCcHhm+PuhORzY06M/pslFoRHj2dX5BCwXodHGAWOJoG+xv5x9x7rEe727oBguG
	d1vDEM1VVF2TK9npeZe6kDHurCS5jTYToWhObF8w79vgXyQafNUXCYsE/8lkgRx5QJxLuB
	bRZ0hlv2tFAWoZCSuXCK8euURCahyxk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-zfRM3AMwOK-pbbAqA87amw-1; Tue, 04 Feb 2025 06:12:35 -0500
X-MC-Unique: zfRM3AMwOK-pbbAqA87amw-1
X-Mimecast-MFC-AGG-ID: zfRM3AMwOK-pbbAqA87amw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38c24cd6823so2757543f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 03:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738667554; x=1739272354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ3PkXkywNKtr2C3RWWqSpKemWRzvU4xaOraOKwYJnE=;
        b=woowoPH7ipgkWy1LEQ3ocD2auI1OaqtQjGeaCdGm3TpjfiFhe6GqSZxu9gbxBtdIGX
         wABjN4sjGXv1qrBremyTjYzT244UH3g4RqZOuEgEN8HmI7LkxVm2wDheNKl2mIb61nuq
         zcf4WUYifYf/s2OJ+k1LT7wJ9PBg7ZPtLbSe1G/739Ug0FQNnjUffi5EcsK6uxuQ1tBo
         IkKT7ySl74oxbmfYxWrHjZg+Pn4L4T7FnWIhb5nEK4nIwAOhjP+plJCi7uOJXHy6GBph
         gHV1TDjawHs7l+W0ZLoTvkOoQ+eQEUdc3MlV/dCwpJaShkiPNOCBZVcYapF35ud+EN5Y
         l0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBmFnkoMsk4rO4lAgVM+ohRBARiU4QZ2Dbi4MCY8jUq2AJhhEZS/vhb3pGxbu8JGQ1paUfcxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDQiylp3nORLykrEfii0LblY0mniU3djI26VFPSGDduVEgqXR
	2JQp9SfjMnL0Zp1+jwp2Htnl0XKu1NnB90VWfVqI8YZr55UYbGA8KInBIpykpNEKxk1OF05iTXd
	oeVfTtbbI5weXH/AJ/Rovh0iHW3snuMezw7XY23tI0z822sOjPpKMGA==
X-Gm-Gg: ASbGncsc9f/QSYe3qFd4WK/aBgW0iQ95fLczD3GAexyBU3e14Gb/L6E5BFD5E9empiq
	WDdpAX11RY/trPbC/Aexbqx71FW8tW+UIReOcTysr6aNZyFqWel7R2XO+9ROoMcfIytStWrehaQ
	yxe+L/APbxzCyA09U5vZwwWGV9jzB10IbmXHqhDSspXo7tq84jmD3ilMxFujtSYcnmwBY8k3RNz
	h7VVArD7qYZGll8dOgxnl0biuSrTrkKpW8OgXs8eebB9kbUuVJmo4VHa2wDcB3Ew26Z49sbxo30
	lF7oassMgmNiRA9Y/hEsXVLnOeWJ/zIWDQI=
X-Received: by 2002:a05:6000:1a86:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-38da540575dmr1951798f8f.25.1738667554420;
        Tue, 04 Feb 2025 03:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrrGo+monwgvf+7AuszM0f9IWAHfFpNFGC8MBZ2jHxt8uvQhWqSNJyq2P9OQGfeWLNK/iSZg==
X-Received: by 2002:a05:6000:1a86:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-38da540575dmr1951780f8f.25.1738667554036;
        Tue, 04 Feb 2025 03:12:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38db085ab80sm411156f8f.26.2025.02.04.03.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 03:12:33 -0800 (PST)
Message-ID: <716751b5-6907-4fbb-bb07-0223f5761299@redhat.com>
Date: Tue, 4 Feb 2025 12:12:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] rxrpc: Fix the rxrpc_connection attend queue
 handling
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20250203110307.7265-1-dhowells@redhat.com>
 <20250203110307.7265-3-dhowells@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203110307.7265-3-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 12:03 PM, David Howells wrote:
> The rxrpc_connection attend queue is never used because conn::attend_link
> is never initialised and so is always NULL'd out and thus always appears to
> be busy.  This requires the following fix:
> 
>  (1) Fix this the attend queue problem by initialising conn::attend_link.
> 
> And, consequently, two further fixes for things masked by the above bug:
> 
>  (2) Fix rxrpc_input_conn_event() to handle being invoked with a NULL
>      sk_buff pointer - something that can now happen with the above change.
> 
>  (3) Fix the RXRPC_SKB_MARK_SERVICE_CONN_SECURED message to carry a pointer
>      to the connection and a ref on it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: netdev@vger.kernel.org

A couple of minor nits: I think this deserves a 'Fixes' tag, and
possibly split into separate patches to address the reported problems
individually.

Thanks,

Paolo


