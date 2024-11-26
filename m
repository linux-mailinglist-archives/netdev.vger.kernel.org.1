Return-Path: <netdev+bounces-147338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DFB9D931D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B6FB21EEB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0D195FEF;
	Tue, 26 Nov 2024 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEnQHXIb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605128FF
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732608855; cv=none; b=pN4ran1OruLhqfjYc4Zrmi15y3i3/JA5sQA6IZSv5FTCTYZZEJUxIRA8tFZROlxgAz4TbD4VIJIP4JceOkukbREBA59F3XcZ/4nbqvS2U9wB10UQvclxRVKQHAP5vY0azGmvzxRFc1/njq/LWUx4Ry7dO5FenunGpgNRxpXYImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732608855; c=relaxed/simple;
	bh=ZQeVCrg2gM4bUqbiWZ2pSlGdT0JunQW/z1akXWflPLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQEKaLUIOJXeTtZ+zz/KXwedIOBaKqyicQdyxzX7R2BuoBjndngetkp+OK+2ECoP+gBygEcNZ7uIsXBO0ZXWOiqbpQIcE33V5F6OOzZQpQami9pMIIKCk/4ves2fIek+n5f7Pag/eHzforfnIAicvCMLAEnrmKNMLwoTP3RGt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JEnQHXIb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732608852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6PYffdD3H7r/cAfrPT7BHSkeySn0bQnqTYRV8e9/iuM=;
	b=JEnQHXIbu6f2Oe124/0L15noFAxqoK0OChNQiVXbzXqLwqIFlPTRyfqcOT+ZX20jdoazBF
	bu1/WkwSZkjTsrZZ4SEEXGwhCThhkbdHG/hWH2eWll8bcUxFB0ONlubJcZFos+V5ckJ9p1
	dXOhhaysy65re2vU9RnhO06DPnFpyuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-X1XUjm2qMcaWANaoXvOiLg-1; Tue, 26 Nov 2024 03:14:10 -0500
X-MC-Unique: X1XUjm2qMcaWANaoXvOiLg-1
X-Mimecast-MFC-AGG-ID: X1XUjm2qMcaWANaoXvOiLg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso20811095e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732608849; x=1733213649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PYffdD3H7r/cAfrPT7BHSkeySn0bQnqTYRV8e9/iuM=;
        b=h4fneDSK4DI1/kOn9UDvEN3MO0pj3wq4k/OycEqpBvEVigSDssM7wQ6rkaJOkGCrAW
         JmAI7oQw9/FM0GQTOrg19kE8lmZ/sU/nwMmBqWX0aiYpcU/JORwpM6N3Z4IRx8hc9HSC
         aCCLnqi+U2Se4dLcazdfw4GNrWvhuPwG6QtN/OefQHdzRCMWzgVtiyxl+pxj+cg5a5Xv
         w18BJY5GZP+MfXb/ai8YkcS7cltTNyr402+ZEm1B71o/wZybu+oAG1uKY2sbM+yL3Z7l
         G7daqlkV41IxHGvZLrSHxjEw9kO4OFQNCy6ZUsOF6QD8J4X0n2Jv/J70fVdx52Me8TWT
         pYHg==
X-Forwarded-Encrypted: i=1; AJvYcCUt5aaFn9zOrAVqmstQkgTJU+/ZP+1VH0viCsLw9Uh9dSjGMAvj1wVknPRVF3Vbn3GhlHXHJ88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNMpZnW7ur/jjavQuJxbiWne61Xjo8CDOTbqmLdYEAQLovnc7+
	pRa2rVKXtzh6DPAlwYwNGGOZYeynNbk+jOYZiT8kzPjudofrT0AiT98GZ6UIxrRdy4VwqwScIKU
	KW6gFkARZfVZ8zM/Dsvb8Jd99dXq/Qz5T+gqrzJFIcwBKdY4epvNxhA==
X-Gm-Gg: ASbGncvz9aQnoKeE7kApzZ3omvCojgBLpbROLlRW58V3oFjWKBB6XFW+ZwBIG+y96Ka
	fDmC+0l/GkHPHF+VyuKP/zr27xZUpOiZS3dKfCcglycRFrJXd+3a61hKTGjlEB9VuEF5QlSah+I
	INi5Lc0faw8Zhkv9wQBv2BP4mOdfRiv716qIUZikqT7bJdcP+Ft8IRzmU6Jbo84FjwHavcDZYx1
	/f6VGFi1Htv65QCv2Tw9nwGxLbmW2hJrEwhrV3/OqnEJb+UH3erxSpxmzAO31njU97aib/iLJW7
X-Received: by 2002:a05:600c:4704:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-433ce48fd61mr143495095e9.26.1732608849603;
        Tue, 26 Nov 2024 00:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFDdTAUpDazICddTRcs7eSMYzBASIkdqWlmSDX50+bGNPsf6siZEZlwNs8sfrhDaZNnrQelA==
X-Received: by 2002:a05:600c:4704:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-433ce48fd61mr143494855e9.26.1732608849260;
        Tue, 26 Nov 2024 00:14:09 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349cc29406sm89394485e9.0.2024.11.26.00.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:14:08 -0800 (PST)
Message-ID: <1c980fea-75c5-4e11-b769-b6d6967ed681@redhat.com>
Date: Tue, 26 Nov 2024 09:14:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rust: net::phy scope ThisModule usage in the
 module_phy_driver macro
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
References: <20241113174438.327414-3-sergeantsagara@protonmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241113174438.327414-3-sergeantsagara@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/24 18:45, Rahul Rameshbabu wrote:
> Similar to the use of $crate::Module, ThisModule should be referred to as
> $crate::ThisModule in the macro evaluation. The reason the macro previously
> did not cause any errors is because all the users of the macro would use
> kernel::prelude::*, bringing ThisModule into scope.
> 
> Fixes: 2fe11d5ab35d ("rust: net::phy add module_phy_driver macro")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> ---
> 
> Notes:
>     How I came up with this change:
>     
>     I was working on my own rust bindings and rust driver when I compared my
>     macro_rule to the one used for module_phy_driver. I noticed, if I made a
>     driver that does not use kernel::prelude::*, that the ThisModule type
>     identifier used in the macro would cause an error without being scoped in
>     the macro_rule. I believe the correct implementation for the macro is one
>     where the types used are correctly expanded with needed scopes.

As noted by Jakub, since this apparently does not address a problem
existing in the current tree, but cleans-up the implementation for
future usage, I suggest to target the net-next without a fixes tag.

Note that net-next is currently closed for the merge window and will
re-open around Dec 2.

Thanks,

Paolo


