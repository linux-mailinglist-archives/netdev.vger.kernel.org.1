Return-Path: <netdev+bounces-130767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF798B733
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6D4B23DB8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93EF19E7D0;
	Tue,  1 Oct 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvQbLgct"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391E19ABD1
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771907; cv=none; b=VxKP0PS0iTzFd1yB1D6ryKKyPDf7NT0pVFc2M/T8yZ3Qh6LomwYrjFUrmwmuQ8xCo5+h2iKK2oSfAA+IQEQ3UDAIodv8ON7xFITGhaY4AF2idOPSfMYJCoitjtE/ddQJVNCsLdXKq2VNLkn5wV5Nns1BFKxSwu4BhIgcA3CJgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771907; c=relaxed/simple;
	bh=wgQgC9RCRJnIcZveGXttN0x3tBTsFRv2m9x2WqocIZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlqksKXC4YqOxPnoVHd4Hj4AGjb8e2MctxsPUY716lt9sEhp6JU53me1Spc5g1p7WMrnwpwfme+aF1d8h3jxMjio6i+7MnVY9qwS1JJelhd5SPaGq2L7QzDjI3ZuPDXcNud0gvuBwqpyxR+vRhSYq5+/w/54x+fww2yBZfFaoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvQbLgct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727771904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyfxFy3IhKen6jD/dEYL0rKxgj34Sx/xNCwG5QfH/EQ=;
	b=VvQbLgctA8+XPYL7+5Ne12z9wOH1niqjRwgavFvkmS0fZxRjEE0d/wQmRcp/Erugmy29vL
	yKwErqVTmlX1mMw23m4rgLYKqdMy8Puv88vpdW6FjTV6NagReu1tOtsTLMsjXMtRL2ntdG
	TVRTlH78bZWZ6UGVgJAPjtiSp0lyqu0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-HgamiIIhPBudxMmBir77lA-1; Tue, 01 Oct 2024 04:38:22 -0400
X-MC-Unique: HgamiIIhPBudxMmBir77lA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb89fbb8cso29868905e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 01:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771902; x=1728376702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyfxFy3IhKen6jD/dEYL0rKxgj34Sx/xNCwG5QfH/EQ=;
        b=cQLxjv8XJYRHIXQOxAxEQzYXS99lkfvJ9XHdXSM3qrYwYy7py+QQjxhw5i9QJHa2dk
         NyfXN5faHj342i/7Zhtcg1xODEI94ofcx+E5DUpZoCx3ZJOqVM38GgXjk8UeoywVTXET
         3FWHuSqU1MxuC1eymApd4MCnuR3I25IFn1poB3SpjOtA7RS+wr3KduuSaegRzOENUlqv
         OeabR6YWifIKLLH8vgctBW7hl+0rNhEEk9EkhNDq2DuSIofYYjtDGUcb8lGaAwdyLjV4
         JSebiZd0B7Wp32tkI/UCmh5Phm1weevBT89f5FCEAnCUVCMKEXT/Dua3xf7+goCb7XDN
         NEDA==
X-Gm-Message-State: AOJu0YxC9RozsV81Y1WESBOU1APQEu0BnlGgSZwLmW3Ai2hk8SegMyYe
	yzEUCZqU2J5yV4QhUPZJ6W64I9uQoic1+T+oGdH29OvFPyHveVxjBV0LAPpfkX2UuiJJq9bTewD
	rDoxOmkMl+VKzDJ27FYa/8gMT6qRWvqfF2rlIWkXjEL8AtG2CERP9pA==
X-Received: by 2002:a05:600c:1d2a:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f58434112mr117674585e9.10.1727771901679;
        Tue, 01 Oct 2024 01:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSzGtY5AylcVmjPvCEOT5PJIwerGUumQV3fFEyTmnyEwtuxaT/BvGiQ3qbwzLqZZMnpncCQA==
X-Received: by 2002:a05:600c:1d2a:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f58434112mr117674395e9.10.1727771901255;
        Tue, 01 Oct 2024 01:38:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57d31283sm127176205e9.0.2024.10.01.01.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:38:20 -0700 (PDT)
Message-ID: <cf62e640-571d-4011-8d96-a37c17eb0fba@redhat.com>
Date: Tue, 1 Oct 2024 10:38:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: Add error pointer check in otx2_flows.c
To: Dipendra Khadka <kdipendra88@gmail.com>, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com,
 bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923063323.1935-1-kdipendra88@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923063323.1935-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/23/24 08:33, Dipendra Khadka wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

The commit message should include a 'Fixes' tag pointing to the commit 
introducing the issue.

Also please include some actual wording in the commit message itself 
describing the issue and the fix.

As Simon noted on the previous submission, please read carefully the 
process description under:

https://www.kernel.org/doc/html/latest/process/

and especially:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Thanks,

Paolo


