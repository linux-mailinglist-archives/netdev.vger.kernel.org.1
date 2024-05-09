Return-Path: <netdev+bounces-94828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E808C0CB9
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E401B21580
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21E127E1F;
	Thu,  9 May 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="c+7BvMsX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650F13C9B7
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715244025; cv=none; b=ciDMrUR9FXcv2ge+Z9K0sKyY0+cmLmLKFprXn7ptDhPEH0Kl3EjundKsQncFEjIaLuqeUP0lnzDGzqaF4FZEkZzEwDZELNQXbtJiy6nnpNbJzXvcajJZPHIXDwj+aFIQeFUvuDz5MfL08qxZhJF7IX5Y+fyck79TOWimQ0lx8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715244025; c=relaxed/simple;
	bh=eBEaOHXGzG6FMKR3rYy4w8XvFWCabDqRvh5mbadmJmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsPXoOB9AUHEMY6ZLC9QpsO3D/6cptxpGj+KFmH9eRjlPciIMiq4Q1wY82Y9/+VWzemgZNkMirM9K31ppOZu/OD6YIvk66N5dB+bzzG87tAgXA8c4KHTdaDWAXgrf2SibuIyg2WolOFQcLVh2vIbHiC49Co9uC+6tYXgvZk8GhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=c+7BvMsX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so6806681fa.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715244021; x=1715848821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lBiU/De9V6QSZ9kRMgdxy9CsMh2q8090xWSEvC+AQ1k=;
        b=c+7BvMsXzsub4kGDZW3InmkxvhPPhYXBvwOcMyfpih/ac9ZhkTQ56GeYKDAp8DeaS3
         vAkOlE9ccZ4EOQMaYE2wtVemRaD+IRekWT9V36npOfBVInD9Ztb6lc+Cxx2uId3oGgSQ
         K0PIiKN48ok851fVcWX1QZvvL6gLnEcp0su5T6iUbNUZeNP5Z50sybBLaTHpJ0Hi5Ukk
         uKACbsf7ELFDZjTlfr1GXfCr3TWYe4RcX5HuqdoI5EVq4d3/bN4tSloQhc2X7Ijq49xg
         vUizM8mcvpTjvpNPT2SWFqSYNTE/X+YJ5YHzK+4N42Uce7r7YQg9fLqXSxgfKGUeGdbG
         vEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715244021; x=1715848821;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBiU/De9V6QSZ9kRMgdxy9CsMh2q8090xWSEvC+AQ1k=;
        b=B1bj04xMyyu0+SO5ZmmpKSXRDXRtP4L/zh1oRmAQORui/+3pa2oy8dbv7t+2XTIQw0
         fUmdnrNhRWyJr/Ywrtkn47HZZ7SZCjeJS0VSy8giHZw9K9xz36GFrG/H0AUn9BfU54Vv
         0AfXeF2VYucUGpRi6LejG8emYyMDuvjpW5oIhOJP0FlNYI88k/HjZds8w1xYLTpknd4h
         nSHkY/QVYc8bOqViJ6u3YVfYZntbFZBPNciuwScXGS6vzXSUv3V8ACk/+p198fUXlwmX
         Y6M18uycCp6J0IbvFXvsT6lV11gr7dWh1VGcOupGyRqENfx1h7EGJu0SYu0Ye0Iu8JSJ
         xfVQ==
X-Gm-Message-State: AOJu0YxJykioawZ80hMkHbeUtwSFSS6ge5JV9CQwszRfdqgDOyV6Xklu
	70cK9VX7X7cgpGVMZNvHNJyEJRo/TdiNXkZxfsMggHD3UHzv4JlVg/pUnvE7xIc=
X-Google-Smtp-Source: AGHT+IGrSuSbGQ9QF0EWcl8ApNGq5qDv6YpGVfoKir7hc2TfwnOHT+h1c6Ptx8wnhLO6yJPrhjWbzw==
X-Received: by 2002:a2e:9815:0:b0:2e0:79c6:d923 with SMTP id 38308e7fff4ca-2e447baa5c6mr29159791fa.42.1715244021366;
        Thu, 09 May 2024 01:40:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f8811100asm51863445e9.30.2024.05.09.01.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:40:21 -0700 (PDT)
Message-ID: <721253ff-5a89-4789-a3e2-a5a092f0564e@openvpn.net>
Date: Thu, 9 May 2024 10:41:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 00/24] Introducing OpenVPN Data Channel
 Offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240507164812.3ac8c7b5@kernel.org>
 <239cdb0d-507f-4cf0-87a1-69ca6429d254@openvpn.net>
 <20240508175327.31bf47a3@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240508175327.31bf47a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 02:53, Jakub Kicinski wrote:
> On Wed, 8 May 2024 11:56:45 +0200 Antonio Quartulli wrote:
>> I see there is one warning to fix due to a typ0 (eventS_wq vs event_wq),
>> but I also get more warnings like this:
>>
>> drivers/net/ovpn/peer.h:119: warning: Function parameter or struct
>> member 'vpn_addrs' not described in 'ovpn_peer'
>>
>> However vpn_addrs is an anonymous struct within struct ovpn_peer.
>> I have already documented all its members using the form:
>>
>> @vpn_addrs.ipv4
>> @vpn_addrs.ipv6
>>
>> Am I expected to document the vpn_addrs as well?
>> Or is this a false positive?
> 
> I think we need to trust the script on what's expected.
> The expectations around documenting anonymous structs may have
> changed recently, I remember fixing this in my code, too.

Alright, I will document those structs too then.

> 
> BTW make sure you use -Wall, people started sending trivial
> patches to fix those :S Would be best not to add new ones.

eheh, rebase -exec is my friend :-)
No warning shall pass!

Thanks a lot,

-- 
Antonio Quartulli
OpenVPN Inc.

