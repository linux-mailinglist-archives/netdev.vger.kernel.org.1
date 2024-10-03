Return-Path: <netdev+bounces-131533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8873D98EC7C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3199FB23923
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1460149C69;
	Thu,  3 Oct 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0myPQTQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2512C552
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949052; cv=none; b=TnZYKOiCCIWjJ6TMLX5eeiWcqTRZ9/QuXeCcRN6/G++uAGjfDIKA4jkQvnmmskJertHoomcsSz5yYUWukCaVfcsZFJp25hfbC6SEbhyLNpmukTx1PKD4pU5hwwTgzAeCH8lX+/lXNYB2sUt/PXtMtN0SOqlZCwr0IZhF5hI+0Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949052; c=relaxed/simple;
	bh=LnLn3TXq7HUeThgKc9tyAyYeYfpK3xWdJiN3uL7GNGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmUWapsdrtKaNEsmrB6FWt3cClTabIK4erATN+ax32Yq/WApl6v1AMr7xrpPxvrzdfT0lSOz4n5wm51BqdWBYWols7Ql63OXL2JUNL1IjFSTsk9DYdCk1KCcOr195zwqi6SRSQLo6tP+tFo3KufXC72f1iGIL712JEhCtyHkRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0myPQTQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727949050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/RuQVfSp4B/jhWvYNQEIFzwdmMTh0ClVMBMD7H3uxA=;
	b=I0myPQTQwooZi3lrTC10OTd6KPGS68jq3NUfJHusrbD0i2KikOmAHj8O//lk7gWQ/O4UQT
	mnd1hbspBRKfgucFN9HgZbMt/AzLcGjJ5zeHJMDT38fvBpVvngZTP7pCyyXoScebACqHGn
	g9+FX8fLxRQGeqSy9QznhWS8y9gUX3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-iGfiDbF4M-6-rX5W_UU9Rw-1; Thu, 03 Oct 2024 05:50:45 -0400
X-MC-Unique: iGfiDbF4M-6-rX5W_UU9Rw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42f310f0ed2so6185005e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 02:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949044; x=1728553844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/RuQVfSp4B/jhWvYNQEIFzwdmMTh0ClVMBMD7H3uxA=;
        b=pOe0yN/LhDqxQ5ZUmjq8z4JUyYRZz1DXQk8WVJSaL5fsDnajGTIVWrxqnOWjCYPPm2
         SC0hQ4s2Om/DnCI3MWopvxPpQo42u9Ig3emeTmFc0qPfeQ7sn6e7GzyutKsJNM6m4Y42
         pR7RkAJBGVBH1J/j5ryt9EVEUrS8urQSDG2g/vyGlhwXjhu3dnNr5VbpWamC7ontBDQN
         WpHkVCEy81+xJSIwlZPQjAJvm+Y/o9YC6B39iulJRKIj+tjOu/xui6pumppmrUd6FQ+g
         7TkaNEXnre2tF+Zdt53QUZDCmBmwwrumDCCk1DVB7TCn69BPlGvT4NGL8Sb/7G9uZpt+
         vV9w==
X-Forwarded-Encrypted: i=1; AJvYcCXf2SQOE7i32zKf61MsD0d5LhSfTh9Wk7pr93KgFBuxRjyAzI782tY3q6XPKjcD53wxbrhA1zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOxVGKAfs+olj/bmqZHkM7bR/N4wvt6mawgWdHv2KsTvFBcZP
	bdbjIAUNDLBqGj6hDcPeHKoplCgKoHNZyyJuAI/5ve9qeaNaWTzOF209SYYlRnpy1UDTpnWA5Pv
	e/PKmI1U4DxlWVzOiDKXyQMDJzQG4sYvjr2Tod3EJzoqZN9hA5TXLiQ==
X-Received: by 2002:a05:600c:ccf:b0:42c:c401:6d6f with SMTP id 5b1f17b1804b1-42f777c3179mr62631915e9.16.1727949044358;
        Thu, 03 Oct 2024 02:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Rb4vcbokhJiJ3XMyfAYK8mwmSDCGAb/etwlWLB9WeYZgxjagPgRTCmkzmXfKn1c9Rrjnmw==
X-Received: by 2002:a05:600c:ccf:b0:42c:c401:6d6f with SMTP id 5b1f17b1804b1-42f777c3179mr62631625e9.16.1727949043967;
        Thu, 03 Oct 2024 02:50:43 -0700 (PDT)
Received: from [192.168.88.248] (146-241-47-72.dyn.eolo.it. [146.241.47.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082e6f35sm886502f8f.113.2024.10.03.02.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 02:50:43 -0700 (PDT)
Message-ID: <79a8e6f0-ff81-4b12-bfb8-f615069b1faa@redhat.com>
Date: Thu, 3 Oct 2024 11:50:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] octeon_ep: Add SKB allocation failures handling in
 __octep_oq_process_rx()
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Veerasenareddy Burru <vburru@marvell.com>
Cc: Sathesh Edara <sedara@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Simon Horman <horms@kernel.org>
References: <20240930053328.9618-1-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240930053328.9618-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 07:33, Aleksandr Mishin wrote:
> build_skb() returns NULL in case of a memory allocation failure so handle
> it inside __octep_oq_process_rx() to avoid NULL pointer dereference.
> 
> __octep_oq_process_rx() is called during NAPI polling by the driver. If
> skb allocation fails, keep on pulling packets out of the Rx DMA queue: we
> shouldn't break the polling immediately and thus falsely indicate to the
> octep_napi_poll() that the Rx pressure is going down. As there is no
> associated skb in this case, don't process the packets and don't push them
> up the network stack - they are skipped.
> 
> The common code with skb and some index manipulations is extracted to make
> the fix more readable and avoid code duplication. Also helper function is
> implemented to unmmap/flush all the fragment buffers used by the dropped
> packet. 'alloc_failures' counter is incremented to mark the skb allocation
> error in driver statistics.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> A similar situation is present in the __octep_vf_oq_process_rx() of the
> Octeon VF driver. First we want to try the fix on __octep_oq_process_rx().
> 
> Compile tested only.

@Marvel folks: it would be great if you could test this patch and report 
here, otherwise this is going to be merged with build test only...

Thanks,

Paolo


