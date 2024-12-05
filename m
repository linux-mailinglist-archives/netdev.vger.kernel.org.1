Return-Path: <netdev+bounces-149267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA6A9E4FA2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA899282858
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910E31D2F42;
	Thu,  5 Dec 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="IaJC//xj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE941B3949
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387167; cv=none; b=OHMSglLKCamMvj3nw/lCOd/IpYB55DBP29nbblLwa9Go9d3PBasFWy1e77iRzCZJuqok+o5yqpAxNH66o3cfk9jFYuoFYFwDpnF3HLLJwZBqI6XxmrXC+rWfHEJEUE+95wyVx6y1ZeBdavPKoJuTVc5xvyPqXHr6BSa7QImcJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387167; c=relaxed/simple;
	bh=g+dsGzmhIEtKtom1xMsvK1cbgN7B1wnWOYkkvoWC5G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqEK5fWO8tFBTB7IrISxEfKrS5RhglEL/dOQRepErXSruEyXxGmpqd9CZV3SpveimZU4T3xMIfnRL71yxbOMYT2Cyzz2F8i5qRkV1H2Xmbc0aNff1Jd/jTKKhnfLshyljRwf/+zLjn7lO1YxnQV66aX8clyTTZQxEWXAa5qGILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=IaJC//xj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349c376d4fso919385e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 00:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1733387163; x=1733991963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=80rN6htbfdAyYrQay6wDN+mpgAyzyG9/4NrD4mR4Hfs=;
        b=IaJC//xjPYDQal5b9XrkN2y0vIOB9srVw3WVfTAfZuNSrgFBxjq6uk5NkSANvhPk/G
         WKn7J7w/LOnCxAqpmCaiTRY3C+NMZ2aRrsP5FZmk1rCSmAokTCjXQSDAVC4SKQklH9Ym
         c8SbN2YjSipIDbXCK/TNKl1AJzKodT9NdAT+Lr8j9nsFDELJit2Bs7xOl/D8XJKYRMu8
         Q6ehGlHLHIJoZbUds0UiURbmmMrhUi+47h+bxNFmB61kAofMVBN29pybiquVUPT6eMEq
         XzFezgqEwqlUeP580EM6v7df57IqilMJ2o1PwNowmihBdBGxgb3MJC90F2RNqC+V3Tpb
         4WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387163; x=1733991963;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80rN6htbfdAyYrQay6wDN+mpgAyzyG9/4NrD4mR4Hfs=;
        b=B2ojD9WdIU8sGgLbdVo+55y5UMm1pV+EfPKbb6Gud/TVrFHL/qdMmON7voeRkkoUq2
         XuG5WFtHhW/djjAd+pE31KrSPUn8TKB67QaD3mFY57J11a1GhPCPg/yfSwt53ZMXidnj
         IOSEWkjjMJ6FleZ8jsxuNa67/puGiesAePxaZXDU5c91teEQ68cz+2OHXXONzLpjACIQ
         ETd73TeCgolshl+vbXqm3b7KnwtElusLqyBIvRmhDf45f6YiU8qCMuzlD+ucIwMreCsD
         864KEdCFVqlUufMxdafWwI4k7Ki8DayleWNaRH2/DzI8W+yZAhSbKvT5T41plOV6tlHZ
         JSzw==
X-Forwarded-Encrypted: i=1; AJvYcCU+J3IvGnTT7XV+ewYo1aUDYanhmdQlKNdPBboIVjuYIkp42cm31WSQIpCw0uXWQpxHG49fidk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TENvUbS0PLt7GcLL3pfrOgKx2RWgnQF1dRvZfBg0uSw9OlLV
	BIywU+M+6Yv9slKGT6ohQXD0zw5VVq6kpT4td1bc5Uic9AaHMuoUsjvOY1Fo0b4=
X-Gm-Gg: ASbGnctE2m6Aylpf+6+lkhM/wmeOQgt7dGLM0e30lzXWVZfH9WIggqxlfHIwGGhSBPW
	30o59fQ6YbtDTrSaPtb8wbM5XSu6RhUA/KshSf0rKMNJTji96gwy3orZhhgNaiCbQwr9f5ogK6l
	bEnOXVoVoyZaG2KdjRQ6/22P3A1WQfBKuhTXan1lUOIddAEool/IYyn0cp5A6Zm2c2fSag7kfRi
	9sMZDzKZLMp6zHNRbwcxqCzOupovfmEsnEXtgpdO+1dlXHspgmI4xqJ3GqYxgeXd2Sqp5EASvxl
	3v5aqgqTXZCPHARDZVf2dm/vivg=
X-Google-Smtp-Source: AGHT+IFMoILfg558KtMeak793FzBDcG7YvmZRvoa7JVrR4+9XMEk01ZfRZT8eA+Gso3h3T3HoP9ohQ==
X-Received: by 2002:a05:6000:4008:b0:385:f72a:a3b1 with SMTP id ffacd0b85a97d-385fd3ce97emr2887008f8f.4.1733387163508;
        Thu, 05 Dec 2024 00:26:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:e1e8:fcfa:52b1:f56f? ([2a01:e0a:b41:c160:e1e8:fcfa:52b1:f56f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4008sm1278682f8f.22.2024.12.05.00.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:26:02 -0800 (PST)
Message-ID: <617a5875-30ff-418e-998a-bef3c55924c1@6wind.com>
Date: Thu, 5 Dec 2024 09:26:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH iproute2-next, v3 2/2] iproute2: add 'ip monitor mcaddr'
 support
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, roopa@cumulusnetworks.com,
 jiri@resnulli.us, stephen@networkplumber.org, jimictw@google.com,
 prohr@google.com, liuhangbin@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20241204140208.2701268-1-yuyanghuang@google.com>
 <20241204140208.2701268-2-yuyanghuang@google.com>
 <7057e5e0-c42b-4ae5-a709-61c6938a0316@6wind.com>
 <CADXeF1GSgVfBZo+BmkRzCT06dSEU2CEU0Pxy=3fYbJrZipoytQ@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CADXeF1GSgVfBZo+BmkRzCT06dSEU2CEU0Pxy=3fYbJrZipoytQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/12/2024 à 15:48, Yuyang Huang a écrit :
> Thanks for the review feedback.
> 
>> Note that 'ip maddr' (see 'man ip-maddress') already exists. Using 'mcaddr' for
>> 'ip monitor' is confusing.
> 
> Please allow me to confirm the suggestion, would it be less confusing
> if I use 'ip monitor maddr' here, or should I use a completely
> different name?
It's not the same API (netlink vs /proc) but the same objects at the end. It
seems better to me to have the same name. It enables updating the netlink API
later to get the same info as the one get in /proc.


Regards,
Nicolas

