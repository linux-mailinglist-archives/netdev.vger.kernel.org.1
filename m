Return-Path: <netdev+bounces-167742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67EA3BFBA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9718D169582
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF221E00BE;
	Wed, 19 Feb 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="gWEoe6AY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AD1DFE36
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971279; cv=none; b=pr60uAik2+N8Mdpa2kjEUFgx9Q4pTWMbLL6OQwGyjk6cNoq4OfIMoEJHDZar+yF+88PSZrB8CwUtJz2+YNQb0NZRp4ioHiayf/NIXJQ/WYCIM/m+xiSbd9WTBt3fs/kUMijaxOKlgQnquF4t5Q/rmvEP8hysQTE1k9n7FcAgDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971279; c=relaxed/simple;
	bh=Ficnt9p1XoQNXuUvqH9vuTMR3Kc5HjcrIAtQm1cqV38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R355Qe1FYWhqkNTpxUQH8v5xwjMa2TdVbpPHE0upeVCo5zC48Hhd7PW2kQAix0tYN/+Kx2Z6AimPJEzEvpBWqWzgLdPwyN3m+hEyevUiDkTeK7HxbtwXFiR6XkQ4HITZPQOi0Q8u9xVvRm87l++v/HNFULyTdwPOjrGoiYEKocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=gWEoe6AY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399509058dso2498065e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 05:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1739971275; x=1740576075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EtzElTgy1YZbJruKey1VM89hhHEr6p8Axm5LWok8UW8=;
        b=gWEoe6AYcyyBFIlQHde9C+QN9zIAsdyLcI2pf79/ppLerLJBecl37uiQeHX3vww2XS
         35iOW+emmC/e89s4Mgl409my2BPTDkJ5er8Qqp6e4OqPheT8yjaJCpnbJ0V0H0O/tVBN
         f8ZPdO7MazBivCW8mfVsjS28MLiLM1sieBGaPFHKw+LdDnlIEWJ4OCHlEPZ9huooYsB3
         pDtA+2e+aeY2VWcIK3ltgDCm4NSRgXs4pHSzdtDAKvtat0B6m0lyDZkwhcrnrYQtowOq
         0+vKeuqEB+8R/xi4fzUaOgXRAG8oGm1srSPxR6onyxqMLCwP68l7G5U+GXLb6uzNDE5w
         LNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739971275; x=1740576075;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtzElTgy1YZbJruKey1VM89hhHEr6p8Axm5LWok8UW8=;
        b=ShH1ECu4zVPYMTG2Ftscp1YBuWcDBvIY8UsviJokj2F5MIbOD+l3nS668djZ4541md
         6zJ2B4tMZ4l6pHt4vKifufyNIeo14qmwm2jCQYYxBhTkT9NTW2d313DJWShUahMm2Kh+
         dVLe1QBFIYNXOloGRMk8egFMz4g1juNJMajbQt0Kv9xPgN8M7dTPXEsaR6uj07ID0IgS
         mZWJ8NHY0oKvuDYQYonZ92MV3KB5Cfrp78mpauN97OUvOrFefhURlF69ron3q/p7AVr8
         MA1MCdM3Gy4J78RP6WlMMHcbqvnIiiZGVFj181wsWWjcMHu8fvahnou5KcSTCgWqWTaX
         o1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ntLOY42UwXYfyHjZviHTuwB8TS8BR+V2sdylNwstWc9qZCdlK3Zap5htqVcQUKtWdc4XiBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbqRDLyb1l2d5+7Cr0zHasIbNGUMvE1/6mZpS5uyBuW8zfoX2v
	kGaVYikQBvvOj98USkwB6vbcodItiJowgpx781pxxwtBXZ/Q+fqVjgovvgxVG9A=
X-Gm-Gg: ASbGncsnY4XJwrRQZTCkBeYAkwX7y1MLH+gLAzUBnsLOY9oGKnQeHw69vvdtS7ocvz3
	KgnhYBEEhZTpZmPr8dYVfRqmdEy9xP9kKE0lIhaHUoL5JztILPlwk1eJQQKQvQW4IACoPtDlTnh
	KDyfsWH+VRTTuJUTwH8FdqP3vDxP+REr5Lz5UOKiedHIg+ZW/OyAz375kbVIEP3wJxbGZQmkuCx
	97lKJOmV7Sa/Cqanxm4tFCqKPHbCuc3KkpeYEwWCc8d0/raDAgrfpa7QFe6e8tHk3+ngnX+VeIJ
	YFhbeNRvZ1PA/tbQRroC5yUM/iXPQJZrq0lcCdmwlFNknSEmKj1ZZQvZrqsFO6UzaRo5
X-Google-Smtp-Source: AGHT+IH7JbLA3QwIdrnJWRDvE76PDfm27fjBYanEkPfVM7oHClwgTVSyiYbx45MDUjE/Z1yhdqGVUQ==
X-Received: by 2002:a05:600c:3b0e:b0:439:930a:58a6 with SMTP id 5b1f17b1804b1-439930a5ac6mr24348705e9.8.1739971275239;
        Wed, 19 Feb 2025 05:21:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:eba1:dfab:1772:232d? ([2a01:e0a:b41:c160:eba1:dfab:1772:232d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43994f0c10csm46603855e9.26.2025.02.19.05.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:21:14 -0800 (PST)
Message-ID: <f476b0c9-06c5-4c24-a77b-a2de548fe745@6wind.com>
Date: Wed, 19 Feb 2025 14:21:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 1/2] net: advertise 'netns local' property via
 netlink
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20250218171334.3593873-1-nicolas.dichtel@6wind.com>
 <20250218171334.3593873-2-nicolas.dichtel@6wind.com>
 <e542b4f8-176d-4c2a-bb93-6c7380a5a16b@lunn.ch>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <e542b4f8-176d-4c2a-bb93-6c7380a5a16b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 19/02/2025 à 14:08, Andrew Lunn a écrit :
> On Tue, Feb 18, 2025 at 06:12:35PM +0100, Nicolas Dichtel wrote:
>> Since the below commit, there is no way to see if the netns_local property
>> is set on a device. Let's add a netlink attribute to advertise it.
>>
>> CC: stable@vger.kernel.org
>> Fixes: 05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local")
> 
> So you would like this backported. The patch Subject is then wrong and
> indicate it is for net. Please see:
Erf, I forgot to remove this CC. Jakub prefers to have this series in net-next,
I'm ok with that.
I wanted to keep the link to that patch, but I can reword the commit log to
avoid this Fixes tag.

Thanks,
Nicolas

