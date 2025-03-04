Return-Path: <netdev+bounces-171664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0244A4E0D5
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467D617BD82
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C082066F3;
	Tue,  4 Mar 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaremDqS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF222063F3
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098238; cv=none; b=pLxsI0eD373q/sWSWB+dIlJ5CHNEUAQQ0HY5PdEei7KWmQJ7UQbyXTA9mgibceUg10//nTynBgINtcZS0+/YFpeGIOF3XgBIKIOYFnN/jc22963A4aqfuRAW24CW8Sgciqq4y4CUsrMVwpDYPZwqzAN4pmIrfCiIOAvCzs57M88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098238; c=relaxed/simple;
	bh=YToWRXI3ojp5Qpx1iSipk79vN6Czw/zLodfp8xVJwD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nm92hspqssL6xoqU4o1VkBkFTv1V6MmMqx746Rr3EDtZqY6g5iLHKCPH1zSvyFYfcaOJJXEQYtTmRgywdROf2+Yw6PdOrT7b67FDHfOFxhUBC5iTtvq4ToEW1ozcBDgBfIP9X2l2n1Eil+FvuT6cgeS7orelJ6Hfz1wjhiL5m64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaremDqS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741098236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7Jl6RqLE4ySPh0n2/0y55XdmikJ9fMRlsEGtfokKwE=;
	b=YaremDqSP+N9Wl1S4+ndYVYhhdtys1MLavK4Nyii017faBf/Oy09SeFfLiWAKQgD94yVXP
	+B/2XRN8shxK1K5HeqwLQXUIILZsuh2uQPHuTHcthZbRD3k6iMbvT9lTvShNRGggj0p/O7
	2ciXS3M6kVCOusOyctX6+XXG8kkUBEM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-JF9x1v40OvOTU-kgoW-rQg-1; Tue, 04 Mar 2025 09:23:45 -0500
X-MC-Unique: JF9x1v40OvOTU-kgoW-rQg-1
X-Mimecast-MFC-AGG-ID: JF9x1v40OvOTU-kgoW-rQg_1741098224
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so28971055e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 06:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741098223; x=1741703023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Jl6RqLE4ySPh0n2/0y55XdmikJ9fMRlsEGtfokKwE=;
        b=vssy8ydAoSwYjLzWUAq8Nc4Cp8QwPQeoXq8t3Sq8L9E4e2WAD/GGh5pHo0aVhZ1Dvh
         ziNrosUQjVObYC2eC1xvvE3cdQy9/t3KGBwbACnzusuJxJsRQbZObwroy1+2jsYoPUqh
         oJetdh23iibKDlO7o9RvpZV1dwjlfmIw+HjXFj3FZqlAskPGOeV8AL6sG9mEQPVR4tOn
         Y4hmUyPg0i8ZKmu6ZljbzGZ5g2ovQXxGRPWXWhl8ZK4/Je0yP+3wnrNcBUU1j3bn6LZ6
         QLQrCCoEGsm4YKFxCBM2O0sCRz8GSWQ3yCHEP4H8Na5prDYdV0/7JDGknHXc6iIDr2i7
         7X5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLlOhZ3wLUg4J1eEkk8jhHHdXpg0sGuaYgimFFzn3dKS8xYz1dEd/605HU5RjMNV92x4SjDCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLM2Okj6HbWAGOSF3cDYufyBr8SPVRQfDweAwsHPlr354T7kC
	JP3fxUzlzCQOwmwf14IvNzD+KiX7yTNRUVJ6R8jIZovLBhnpboHbd4kOTD0azeuvV3HXiJQqIMc
	LCNjVvPjqRFcaCSUph5O4AUz07ExlixPlOFHijw7a2OJORTcaX+idSA==
X-Gm-Gg: ASbGncuQCRGoZnbefGttEg+xBEhD/N/pOCrAp3IlgJTHnQMTkVswaX0SsY/vgrV66WC
	mSIkIOi3q3AAgYPSlEdz0T6ghbJRSsn7nnKOE7tBh6KoT8vCnvApIxSSDFJOQ7jXa3glsGlGLD/
	QeProMbSB+13X2xugWusW2MxEITqdL72jVrFRqNQtvLEvbokCCWqDTMrcHfqP+v2xwIODJTkqH4
	XbEtUkXxCEf+5yf+boQfh97zzl2T/KobJO4rNv3kNF6znk4+n4vk0aNySVrO+ybTZd32LKfS/T7
	AkdXastmiv1RLLn66Whf346HKM2/dX4IS+2a93bmRMoENw==
X-Received: by 2002:a05:600c:4793:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bcae04e19mr29901195e9.1.1741098223608;
        Tue, 04 Mar 2025 06:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF52Rx16VjlDS72aosnmdGbcCI7vGQKO/XsIiTckVodJ9P2N/4wxflyj/DJe6Sib08YfVkUAQ==
X-Received: by 2002:a05:600c:4793:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bcae04e19mr29900945e9.1.1741098223266;
        Tue, 04 Mar 2025 06:23:43 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75ebsm199915175e9.3.2025.03.04.06.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:23:42 -0800 (PST)
Message-ID: <278118b1-eae8-401a-8501-e0a777852fcf@redhat.com>
Date: Tue, 4 Mar 2025 15:23:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] netconsole: add task name to extra data
 fields
To: Breno Leitao <leitao@debian.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-5-21c86ae8fc0d@debian.org>
 <20250225101910.GM1615191@kernel.org>
 <20250225-doberman-of-scientific-champagne-640c69@leitao>
 <d0e43d0a-621d-46ee-8cb7-1e5c41e76b8c@redhat.com>
 <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250225-bright-jasmine-butterfly-aa1bb0@leitao>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 2:11 PM, Breno Leitao wrote:
> Ack. I will remove the check then, and check if the UDP stack has been
> initialized before calling netpoll helpers.
> 
> What is the best way to make sure taht the UDP stack has been
> initialized?

[brosers!] Sorry for the latency. My statement was intended as a
negative example: "adding such check would be as misleading as checking
if the UDP stack has been before calling netpoll helpers". The UDP stack
is always initialized when called from netpoll, due to the relevant
"init" order.

/P


