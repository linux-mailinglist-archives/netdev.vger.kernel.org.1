Return-Path: <netdev+bounces-164333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A23A2D650
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 14:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D249188C211
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04932475E2;
	Sat,  8 Feb 2025 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkfnq99V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D181AF0CB
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739021397; cv=none; b=CC5lstqYpbjuXB9W70xFUYFapTsEFiEGSa/NRP8SvaqTwKT7Sf5JLYzhm1nEASp9iz4C6oJntTOf7Lfn3TfvweKEgCyl9oVPXnWFqS7azs8FNqa9DSr0LiNfqMsmTm22aZAK8KAFDejNBSjlGEo4EdG4gyo3ZCa/CLsrnzAr6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739021397; c=relaxed/simple;
	bh=EKDxFScrz3YxFz9WKWySf8SdXWcCK92cilNVebTi5kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJ0ZPP9mzuAW1WYwZoNs/pkTQn1GXgK04/yq79H5td3h7pHapXvp7NBRq1OVEFChKGfFDM15FDDI4HMx5KxDe9DDA+ZGSbmesABNyTdBd1Ljh1p2Atphm+SmH5yxfCGHhwUxAdAxGItRrvIMx2/h5Sd77wy2LZdx520ZuOiEAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkfnq99V; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso5119864a12.0
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 05:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739021394; x=1739626194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5RtnC138U0BoYb1FL9UElO6QLAScmnjJ6a0xWKkqDB0=;
        b=Nkfnq99VqlBp8IyZZewCBSrx/Z5eP70xE7tjr46wD9Qb1UZbZiH8GTi78MXAkZefZg
         GpucdTw1vwNcYA33HbC+TG7tPoTuUp70vrM1PciP3HwTnOqldZ46XNEtJty9J/k//EHO
         CCj8vrvrdE3aw2UlYh1vFoiSZjK5mWvvkyJANjIaq1lOydZjnMZ8a7NlQFHGEPBnE3Gs
         YTgshlMMUtsAJcEZq9Iawz2Ttdg2ypjrORmyk6uumLv5w4vXe81kMd/pvh6hTHmhG4HB
         Xj4jC23EkXaftJKorRXXdzgUOVqxSqiFYaRrZaATWNqQ2ntCyWElTvBRzE1PzvJRDsnE
         Gxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739021394; x=1739626194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RtnC138U0BoYb1FL9UElO6QLAScmnjJ6a0xWKkqDB0=;
        b=Md+3CbZtHLWMNJjwCr8LZzgNpIQGN/goHIeZMkwcByFs2+I3Skz3enA/77ns9TwY3n
         ZE5UYxMKTp9ed8IRC3563wDdv+XOx00yojDwu5id6fpBGw8KJJCwemx+itN8NESS5O9L
         D75EVIJL1A3f3jbsBeYAHr+cb9kM6P44LU6QyPKcg5ffUImPJnHbH3zojozruQ/03Mgw
         CAKOIp4AdiHNTKEIQVcv+ajETCI+X/Y8ASlrH4o2mOkl0zCioy3wYt68jFVWmJsfT1dO
         h6kNAza0pIiJEeYcEAnmdmB5Rl+LXJxa5m6+VBwZoaipTOnhy5pA6iioM7fme2s5M4Yf
         sCjw==
X-Forwarded-Encrypted: i=1; AJvYcCVdDxw1hjm/u7dGP7vdMKLXoHfcq8ek/iRbJtly9QKrih85k//QfVOu2MDsBlQWlao/fiGpcas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzorZOD0V7V9HeKIDFd/gLQjBwHYIbubdJj5PaEQQQjetlSrMYF
	OxPqnWrh932lMPDGpBzuH45hRnvKJ1fWLjTdQM+mSL92UhEVDSHI
X-Gm-Gg: ASbGncuhhv/LmatO7m2s5aHvSj6kRRVDxN4ATV4aVAylKfJ7EgqJ9jec2SgiX+8ujnR
	e3V7+VBgmuHVTPhhC5aU/m95Gd6z2b6aUx04ptwJ4ivj0s94MpTXqrmIqAHsXGN8sTShZzPTQuT
	Jpq7g52rxqAChC7eEjkivOWqkwyPe159ZMmGyp9q59xn0Q0kStjh+pT1bpSwhttj5/hLMtZ9Ns+
	r35Uay+Nlwfii2pLX1LekzmZUglFW8xuJZdeQRmeuXYPEm7MtUdSJPypEdHYjx+yA03B4g1Ugw1
	GnWSqCXMgPZXXWxn8+KU5WoSfA==
X-Google-Smtp-Source: AGHT+IEsIUzKaNYNkdOlMDBB5GAJOdUXz6VuXPBewwPwg+4sWYsnp9f7ORFDOt7jDSAjbDZ31IqxZQ==
X-Received: by 2002:a05:6402:e97:b0:5dc:c943:7b6 with SMTP id 4fb4d7f45d1cf-5de4504024emr8668396a12.3.1739021394396;
        Sat, 08 Feb 2025 05:29:54 -0800 (PST)
Received: from [192.168.8.100] ([148.252.133.220])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de3e49c372sm3474804a12.3.2025.02.08.05.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Feb 2025 05:29:53 -0800 (PST)
Message-ID: <39739559-6d28-429e-a1d6-430fe0f2490a@gmail.com>
Date: Sat, 8 Feb 2025 13:29:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 00/10] io_uring zero copy rx
To: Jakub Kicinski <kuba@kernel.org>, patchwork-bot+netdevbpf@kernel.org
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org,
 dsahern@kernel.org, almasrymina@google.com, stfomichev@gmail.com,
 jdamato@fastly.com, pctammela@mojatatu.com
References: <20250204215622.695511-1-dw@davidwei.uk>
 <173889003753.1718886.8005844111195907451.git-patchwork-notify@kernel.org>
 <20250206170742.044536a1@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250206170742.044536a1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/25 01:07, Jakub Kicinski wrote:
> On Fri, 07 Feb 2025 01:00:37 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
>> This series was applied to netdev/net-next.git
> 
> off of v6.14-rc1 so 71f0dd5a3293d75 should pull in cleanly

Thanks Jakub, from here we'll merge the rest of the patches through
io_uring as planned.

-- 
Pavel Begunkov


