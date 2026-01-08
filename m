Return-Path: <netdev+bounces-248051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA0FD03173
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 694523008C9A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B223D6F04;
	Thu,  8 Jan 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPCTZvdo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvUulcFY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1AA3B95ED
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767871818; cv=none; b=R0deiMSKy25olP3sDf7ml9YMfU2cqZmWQXctevV14TKZH0DloDrvUBjA+5siRwDypOTuMZoC2t33Mkx0el6lQJvoa6CRCkrfpUnzbq/71CCI4jmAQwulfNa4BuZsL/rQDcfCV5WG0JBUdLJEhD8i/FbKZRjkDpVfVa66iGJjm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767871818; c=relaxed/simple;
	bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itKfbl7dicfZDk/N4WTeaIMyg4Xkt+wxuaZziWD4cEE5MdYQpM20sugAyd4ME4yLteypiQDGdFMXY3mhr+DAZc56x/JQfsVXGgyoN0pGF3dno7CkiEZRglAUfz0RffWcrpLPhB8pj1e4R61z+L7w5rcd+U5mXrKUNPv4tQPHP6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPCTZvdo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvUulcFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767871813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
	b=DPCTZvdov3DqYirgNUUY3VESECkPjIALLG3eKSxGPr70RDzc3dmSEYpGnQ5Qat763in9AA
	nMHOu9QR4ZLPXbZCSNPXd0V7ZFvKeqAA5fsiG7uxYn9J05LcfZKFzNoZ9meBh2O39eh5LC
	vUpQlhKeWnE2RRQmiEBkwWqjFLPKrIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Sd8u5_5gPw6IXkIv-nKyng-1; Thu, 08 Jan 2026 06:30:12 -0500
X-MC-Unique: Sd8u5_5gPw6IXkIv-nKyng-1
X-Mimecast-MFC-AGG-ID: Sd8u5_5gPw6IXkIv-nKyng_1767871811
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so29278465e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 03:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767871811; x=1768476611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
        b=NvUulcFYEyQKiFLBIYwMzw5ER+dvIu0ObvZ7I4fllxnm1FBtZVC3lCa5JCEe1+x8Ty
         c8XxJHC+v0Aa3xbgJkzOokK33E2K0S1E/49N2hhiuTBBjp09Qg6PWskgLCq05EDItzfu
         o3/n9Akr51bAvOJshlYdRyq8jfo+fsRQ0LA8dUkKnnxHuE3Lhkw7A4xixNk8XpCxqpK2
         34VXRGiaDj8KYZikY+0XtHL/w4ynHWpxwVUDMoIOmlZZFB7QBC6ZOTOZFlC0pHzUPNQ8
         QZFYxEdZfzccpOMuRnlXf8wdHINIIecbG8wuh71IzgJAlym74exwqsoD3/sNULL5QBDM
         YxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871811; x=1768476611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pa9x4JglsrY6GFCnO9O1vnPBicor/gXV2BFxa9ZW0QM=;
        b=HT2gXFmQ8117oVzLitQCAIsSRU1npUiIVdfRjyBWKUWtofzZQEF0UOi+RuBwYqi9he
         f76CH/Kv3WVLICCzIjBz2EAF3vwAo0e/oCgCfYptYG2J7C40Gc2ulWjcCCNgtmdf4ciY
         mUsimu9Yn3RF80hulsT2AteLFDa4IhDBDnUqZgmoyN1hIeyJSZP/XfdUE9ew8QKaZu8o
         sMS0kWWb3qSpSeFdk1E+Se8C0aDc6GfJTmcJNkq1u8P/EURE6ME3tI0t3VEQ36wQ8dSm
         7J69WFexHSDdGrhwRBWFe3LuXHDYxYlXBpbFfHg3aG7seBX5hA6opkDL/Z9MtbUqwy8v
         JQzw==
X-Gm-Message-State: AOJu0YziJEfD7ibzxTM1h18bUOJO3wTduOiW18KeysIFi/3SXqG+8/Xg
	PU+dljXCsamWFKZc4Y/G3A9h4nwe5DUzyzUgxNdT07tDra2MdYJL9LRrSjxDckBa9XXZYSZ3Bke
	V46pXW5LBfrcs8Md9HG6EM5zQQ5qjJr3U3aBg9MHzM1x5vj2cN6mYNv1xBw==
X-Gm-Gg: AY/fxX6eYNFaJO1gFFp5JsKFjDvTEJl/BTSoOWqYp1vxGWwA2UnVQU39MqcCQzaa8ry
	/9lYojiorh8Q4X22or9ZyR0Yuhko6hxlh5VFYZeeFkRKtxR3gfK+0bmXeNwPhrDyVr9KCJa4zqG
	qewWCN+Xf0bLy+pnnx0SYCXF6bN/B1TsBA9toziMZpN0KRzSp9Y26sLg3Fg0h9iOiQ5HMjKe/mK
	J8n1ifHJmMmHIBkv4TJuR+mWLTgz6rEr1bA/AzD785kRpXaKmwqTtqOaLPNW7G+NONKanxm8DJM
	hfQqQCfusqBPuJ0x6YJ4Rci42FMFWbfoiODgdS5ikKVgcX9mkCXf7IT46Gli6ensRaT4BwL6YPd
	l3wwFa8au09ZjkYdj
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr68555265e9.21.1767871811260;
        Thu, 08 Jan 2026 03:30:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8+bmvV/WNN6KWlnzqQVw+P6bUXizWXcjIaBg1pO0qOtQk1LqtVJ34EAenyZ8H+/3EN9Zvfw==
X-Received: by 2002:a05:600c:c4a8:b0:477:54cd:2030 with SMTP id 5b1f17b1804b1-47d84b32788mr68554925e9.21.1767871810799;
        Thu, 08 Jan 2026 03:30:10 -0800 (PST)
Received: from sgarzare-redhat ([193.207.178.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff1e9sm16625689f8f.41.2026.01.08.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:30:10 -0800 (PST)
Date: Thu, 8 Jan 2026 12:29:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: add a final full barrier after run
 all tests
Message-ID: <aV-VIKJiHeT6t_df@sgarzare-redhat>
References: <20251223162210.43976-1-sgarzare@redhat.com>
 <9bde9e8e-3ae2-4199-b416-ae3fdaf090f5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9bde9e8e-3ae2-4199-b416-ae3fdaf090f5@redhat.com>

On Tue, Dec 30, 2025 at 12:08:44PM +0100, Paolo Abeni wrote:
>On 12/23/25 5:22 PM, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> If the last test fails, the other side still completes correctly,
>> which could lead to false positives.
>>
>> Let's add a final barrier that ensures that the last test has finished
>> correctly on both sides, but also that the two sides agree on the
>> number of tests to be performed.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Net-next is currently closed; still this looks material suitable for
>'net', with a proper Fixes tag.
>
>Please repost for net if you agree.

Sure, I'll repost for `net`.

Thanks,
Stefano


