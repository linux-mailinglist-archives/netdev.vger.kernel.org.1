Return-Path: <netdev+bounces-239886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E943AC6D8E5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 630102DFC0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD7330330;
	Wed, 19 Nov 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etaf/TxA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zyo8kNn4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9F330328
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542793; cv=none; b=Kkll7pUA+KxqYILv3Bglj52nt6wOsS+eNcOMrQ6FbxCVyfUgXBgorZpOcYa2ijOu88EWIVc61CIblp/LzrtXJsbusz5SBW9veGHQeJkudRgeYhPVQ9NFIUcip6UiDDDnxgeKoeXvSgoNyvaoDnj0ivlyVhU/OcNDCSxwrBi/YlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542793; c=relaxed/simple;
	bh=i1693rEdZnEUTq7gkhWUtOag4Lmw65+RK7BMIxs3Z70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwSrifhLZFO7FMlIbaWHcRe+9xCn4HiuoE7/Rd8PndXAm+12GyEjxQqa5jSm1FUXuns4FCsZe+Y5hTvZn4xy8EE68nAC4jV4Za3YqMTaOyztiqvpI3g/xSVi5kZuQW+m2Uvfuelpg/7oax1VYF84v/KpMgK+ZIr194AN9vBGqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etaf/TxA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zyo8kNn4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763542790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3WPbMcePNR8HXtNguNBECxedLcgNvkopoYvEpCiwCI=;
	b=etaf/TxAzeEdLewXk3+cpcNc0mDEPE/aE13gyosGGerKnIaHRO5+KuCN76w+pJebt1ykCT
	aWMFHd6y2FmVzNmJUAPRrr4UKhgzm9InForfmH5X91Z9mBvTriaf0z+34K9bN4NcfMClKc
	6U2UT1tCj2Lf5+0e8yCGTaVupwJZ8Lk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-tWreSnPNNj6MbcH3sVx1tQ-1; Wed, 19 Nov 2025 03:59:48 -0500
X-MC-Unique: tWreSnPNNj6MbcH3sVx1tQ-1
X-Mimecast-MFC-AGG-ID: tWreSnPNNj6MbcH3sVx1tQ_1763542787
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106a388cfso41202315e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763542787; x=1764147587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3WPbMcePNR8HXtNguNBECxedLcgNvkopoYvEpCiwCI=;
        b=Zyo8kNn4o466mVAF2RfmrREkN3dMCTmWFyNIqGlV/IY7gmrNkBaqzltvyggHEbZYbk
         Je4g+4PNquwtpvCCY5KYSmHztJByE/slEIZvBiSjlNG79g2rHJvAhbl5aP52LBEwRF2k
         Gndg7w9cvxR1vh2Bz9vMz8yQWOA+KxMr13Mq5uDGpK0KYXTSZfUaPfKNxoydBu9Jj0HQ
         XXOmC8F+KEIRlX1HBdj/RawIN9A+W6eHCRAo4dYIbhH5ANaZPd/7fWWgFHE6y2tJQlyP
         puizdJj6t1G7JXl6/2ln2Rv7Mcged0c+90Ia+TcgOTOQzw8HEKovgAFLJVl5QTHXSHu0
         UW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763542787; x=1764147587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3WPbMcePNR8HXtNguNBECxedLcgNvkopoYvEpCiwCI=;
        b=bYfq5+Ur/6cROApXmADqFOzK3FDtZLUBtJrfXjHehP9fbP5c8+URfli9ktXwYwhYTB
         l43ajQzVm1KL4GHUgJDw1e0Uvh8OBjLEYhV5VSqG4EkYaLmV/vzA/YtNALn6ad9pF6to
         3Uv8lO4ovfFj9YCYzekMjQEnbBOFw7/Puvh7fTAbey8vmM4JpTu5ViAvQGxZZrEq4oja
         w07KlBE6y0Q3SPdxV4OBnU64/z5FPFoiU2szvZTrFGqoIq0IGnf/CG/cxETsxkRoz+Py
         RIxYogbliJZ0LxJ8k2tKoxDf2//Eq/Zo/1O/kwCLSNICH8Pv2YFFCYx9FUQJiAD2YjkA
         nqFg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7W7FEA5WPj0Pw2rg+/ogcg2gAt/9VNKc7rqqM8yo9pI9tfKJvYbHhkIq3HanqwREaBDZ7WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqR+WVfKtGZpJqYbuK6B5ptPgRkulase5bep7z/q8y4VkXdDC0
	AT2e5ARYtDbbCYw2lrU8nXXEaTczpEPhmVXkQWIu4Yt3EHx8ibejaDiXB72ZZrHWcsg3jMlwvGp
	S4GGsIFR9d4ep/3Fp9ZWqSQwQwa5Pvl2cJ80kUxW7rKcxGtIagobXpbO7ew==
X-Gm-Gg: ASbGncuNv+e/VgWrEN89UNlvab7cHnW8yTiHwnfmPS5XpXrR3drEH13YIHqh00QqSRa
	izksga5kwJRR7NRazogCJdL/HwtjljEK/NaEJOU46uYJLKoTMWYV8YgvfJP0skeU7CZ4FRebugl
	Uu106kATQReZ1HBIBdfVtsFBLee3E+U+WkZKh5j6sMgSxWR9JYiBu2tdmxnJqr1wd88c5JU9BZk
	BtRC3BwY32NIMwdI0OwuvK9MIG2VgesfUXL80wuFfotcMTLgBGag3HoFi86v3vcOjVlrPdLPUfR
	Kv0KHZ6hZSqyoCLxr8mQxsCIoNMNVdXqlMeMZGMGtKPVHtPtr6zUJu9pkbk2Sl6z2h13d9Kgbqn
	7CelhrkXORVbE
X-Received: by 2002:a05:6000:1884:b0:42b:39ae:d07b with SMTP id ffacd0b85a97d-42b595adf13mr20593870f8f.50.1763542787480;
        Wed, 19 Nov 2025 00:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErpPvWS7HVFZMTpifiGCAObNjvANnWgb/g8cXuKLIEGeuAHgQFH0UqkqEWQyB4QOH96Bc8NA==
X-Received: by 2002:a05:6000:1884:b0:42b:39ae:d07b with SMTP id ffacd0b85a97d-42b595adf13mr20593842f8f.50.1763542787025;
        Wed, 19 Nov 2025 00:59:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b617sm36254438f8f.31.2025.11.19.00.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 00:59:46 -0800 (PST)
Message-ID: <9e1011a8-70bd-468d-96b2-a306039b97f9@redhat.com>
Date: Wed, 19 Nov 2025 09:59:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251117132802.2083206-1-edumazet@google.com>
 <20251117132802.2083206-3-edumazet@google.com>
 <c1a44dde-376c-4140-8f51-aeac0a49c0da@redhat.com>
 <CANn89iLGXY0qhvNNZWVppq+u0kccD5QCVAEqZ_0GyZGGeWL=Yg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iLGXY0qhvNNZWVppq+u0kccD5QCVAEqZ_0GyZGGeWL=Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 10:22 PM, Eric Dumazet wrote:
> I would perhaps use 8 senders, and force all receivers on one cpu (cpu
> 4 in the following run)
> 
> for i in {1..8}
> do
>  netperf -H host -T,4 -l 100 &
> done
> 
> This would I think show what can happen when receivers can not keep up.

Thanks for the suggestion. I should have understood the receiver needs
to be under stress in the relevant scenario.

With the above setup, on vanilla kernel, the rcvbuf I see is:

min 2134391 max 33554432 avg 12085941

with multiple connections hitting tcp_rmem[2]

with the patched kernel:

min 1192472 max 33554432 avg 4247351

there is a single outlier hitting tcp_rmem[2], and in that case the
connection observes for some samples a rtt just above tcp_rtt_threshold
sysctl/tcp_rcvbuf_low_rtt.

FWIW I guess you can add:

Tested-by: Paolo Abeni <pabeni@redhat.com>

Thanks,

Paolo


