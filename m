Return-Path: <netdev+bounces-190638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8E4AB7FB2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6057116CB01
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5028689F;
	Thu, 15 May 2025 08:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QY4/CpmX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F812CD96
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296276; cv=none; b=a2Fei52DbMbwEsInS+m8dlCgbVQXDAs84+TntnmfKpi62mpUz+wts5upcIEVyG4JQTSfv0WJejiZ7m36Q9XK6SfRsKdVv0MwwMtToGnkQH9PEOKLSXk2n2nv/NsVgYxBUWDSu8qqvgqe/iSRFx75WSCNBmQPIJgCbHomAklr8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296276; c=relaxed/simple;
	bh=hFI16IcEibTtzPjWil4RMX0FyQWqasrEVbdYfXZ/6Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nI2yqrI6hKKs89VAXCIeRLA9hk0jjfeeQGY7izY9HI8muu7vS9j/jTEwbesEcJgIujLuVdQVc0wapaJMzQsBBTvwDBSW5xeWLWpWmETj/dF+0wd9bYrBjKJ8Xw96/Z334SyhsoKZFyvEE17W3lXgEbp6NdWcYBpeinsL/5iO0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QY4/CpmX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747296274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZnZ930PYjxtmz3mlM23ZtpwvM2PpRU0aXUuxlDGVc8=;
	b=QY4/CpmXte9xD1Q/WHlA8l9fuIwvKeqpFOioMLg4nQFY2tNeJM/ufuNywE1ewLm6FGvdUM
	UidjOUyk67AxJ4vGf7KkWwhpoZj1e2aoYdFBn8fIj856jtt7KhyIulX5o8IZxea091ifcG
	7ayAUUFL6PUZXHKkzsbd/9L/FvzHofo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-MCYRZYXIM-a_yJx6igRGyQ-1; Thu, 15 May 2025 04:04:33 -0400
X-MC-Unique: MCYRZYXIM-a_yJx6igRGyQ-1
X-Mimecast-MFC-AGG-ID: MCYRZYXIM-a_yJx6igRGyQ_1747296272
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso5016335e9.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 01:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747296272; x=1747901072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZnZ930PYjxtmz3mlM23ZtpwvM2PpRU0aXUuxlDGVc8=;
        b=WhSE1bNR6S4i4SXy/o2xu8Bq7yplB/CQ9rU13QTPAxEHRVYh3EsRH+TShqa5bzv56y
         /93/4fGYzxar1ir0LR+UXLx8fOnsLi0eRSLl/z6fRFT1nHxQyet4JJmUQua9VzqIhenQ
         RbHLvz0vNjHUh5TAtexNhmkcfocR6ikbJoYuXAczTESKC+dMcCoBKuZ8TUCNP/t4Xoda
         mmj/DaOw5JDLJytEEeER7weq2F6fm2DBXFqNpgv/eDRcxyb2CiAjrj6bvzwixl+8ctym
         unFcL2ha/YZqeAjJZNCQ703c3kYSRlx029bG9ZOiOhFRirObjOAgwUZkGaHc8gqv6etT
         ZrFA==
X-Forwarded-Encrypted: i=1; AJvYcCX4O8ud137R7N1XUZq4R6WV+x8ovwCYvutoFcdH4Qrg3CDj/oB7JhJfGRzm/+8j3Tmg4JN4hRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LETXrRbNjUHqoqE/YCjLcVgcG48PbOXwT6Q2f5yBWc217Ocd
	54aV6nU/GSjoplcTdMtqf2G+Ps2+ANLvMq03P4ZKFn9BU1npjSMsOxbpwyBkwuTU39CgT7KDZG3
	Llha/nmaeiSWS6ADs4F8+z6h/KBOH/1tnkgfepZWv6CbMV7KIENC1MQ==
X-Gm-Gg: ASbGncsSuAhprLvDhNxbhfPXNXgfLZb07nNfZM3cKDAs/8/7n6cvEnfYSkfTyexDcUV
	t5CowvwtceNBzPt5IjuHAm5c/TsL6QipwY6lNQNKAvsz03lrfK0JwFhgxv03tk5Bu2cfCirrWa1
	ADDniMKovDN8VChU52hslTEVjiXsJ7hMtDDtwMNjIEpxYR9ugoYbh4uLFAusGdxLJy8js0Lg7N5
	w8Y68u71dD/nv3y+yS93KwlT+M9dlJPrRt6hdfSAuemHy2LFeO1sMIVI1k8MrcVzHQ2++lPEnPO
	GjlaYEBp33GHi3OwZkaT97bG5IoThKkbpBMUqAh3pP40P3dXQIW0NGSL4qI=
X-Received: by 2002:a05:600c:1910:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-442f2107910mr65299335e9.17.1747296271652;
        Thu, 15 May 2025 01:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbb5QWq3rrKQDxAI9WDSnTqkDsUuGBTfT23Ixh3TjemUWpIa7C9OKvWJU6E2gkZjfOBK0QPw==
X-Received: by 2002:a05:600c:1910:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-442f2107910mr65298925e9.17.1747296271240;
        Thu, 15 May 2025 01:04:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35573f32bsm776505f8f.17.2025.05.15.01.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:04:30 -0700 (PDT)
Message-ID: <936046df-5ed9-49e5-906f-dec64a63f531@redhat.com>
Date: Thu, 15 May 2025 10:04:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 0/5] DUALPI2 patch
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
>   Please find the DualPI2 patch v14.
[...]
> 
> For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

A couple of process notes I should have mentioned earlier. The cover
letter should be more descriptive WRT the actual series contents and
goal, beyond the changelog itself.

Each patch should contain individual changelog, to help the reviewers.
At this point you don't need to add individual changelog for past
revisions, but for any eventual later one.

Not worth to repost just for the above, but if a new revision will be
needed, please take care.

/P


