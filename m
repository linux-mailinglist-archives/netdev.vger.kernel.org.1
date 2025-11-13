Return-Path: <netdev+bounces-238294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBEBC57131
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EE8D344FB0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960D334C17;
	Thu, 13 Nov 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ3gJ3CK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39E332ED9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031589; cv=none; b=L3hhsuSvbKT43cuXuymSLuwkejzMXq8TSYyDTLKGepAIFSH5OeQoKYDqNmfKknW3f9OQPM1JtHKOFL3/TDEvAWoaEKZxtqEjNSvFUwGXI9dbSwgYyd0Ium+dSOyQitGFpt8qflDtsRAlVkLIkPUUVLSUhRV6WZ9jL1PoNfIxMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031589; c=relaxed/simple;
	bh=ugZFlfc+l2S+0zWCSf1PxybsJPWJGmiF5NzWiKPgTzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCDsXlfjErXt0zMpA07WT8GZZX/r0I0ijRyK880WAUMdRCVaB9hJoMmjyxH0sMcyIfsORmp2y+TkGgpp3AqgjSeRU83rXIDnfia4qGt0NPqnu2jamFnVmiSsNKpBjAKXzop7+Vq0WTF6Zkyjwe1NICu2cmS+o4cHixMIB6DJuAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ3gJ3CK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47778704516so3197995e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031586; x=1763636386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEJC7gRTebDUaxwAOnQ9BV9gIzheu37nMO4ePUyMYEM=;
        b=iQ3gJ3CK+EvoGocot/Chl1ETCyQHG6GXKwpS32/w52vYJtH8PF+c+cxZV/V6Y1PWxe
         qQBxxItLa7wBBe1zZ9JtuCwAePN8hF0IEfGpf7mwgZHswAUr5F5z5W2+oHO8d/5u8Kqn
         ZcpzG3QzVsMaDloGTcuam0H7i2Vx7Tf3pNPAOErn3+NNfXOeDcu5CkOla0vCNq6j0eRq
         kb7ALrEYpAPxkYAqzmZhzie7mwW91sUlFc0t5W5GEqiI2Wu+s3s92KmvLriUjGRIAv08
         Sp/gVpLYzBsC4LCG1dy2lrfz5a117+bAMyb8ZQCcKJw3j3+ZsX69A4qprDhlEiWVh4NE
         qEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031586; x=1763636386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEJC7gRTebDUaxwAOnQ9BV9gIzheu37nMO4ePUyMYEM=;
        b=laN6IUG48csLqGOeDTnHOmKezxXBvmkCmAm44FtANgIVbIc8IV1uiauV2iK1y8v4ch
         LSdJNCoUERxFgqGAvaBtwZ02fQRyl5yq631mYhLzzHmLhz1iVU2xFgNXiMgwmmpPUz8E
         69cIJieDsSxwA/r1zkW9rgocaJ34WHeQZ054oVZGnq3EJTyT9kJJKv48q4dcRpVnSAfA
         /H0ElUKL1pIzbdQyFY6/QKg9w1FEsfQ+OoBgfCxOHCWZQcQB94jr3+PgXhYZLX/Hc2tP
         yxMvcmq8enHJOw1i4cef396krMBSkJuN4dm6SQ4gQFNCIBDg1yPaoi/RLFeA3bOXDYKJ
         wukw==
X-Forwarded-Encrypted: i=1; AJvYcCWsl7G5NSJU7oXvQNtJM0Mxu3bldI5Mp7cMWvl/+cJeDEwVCf5PXoVpeoZYzOj50VrTeivZhW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLttib7rJ451TEvHgtlHGb+SDTiQQ1wXBF4kUuxu+5o10xdEa
	DkkHDOZ7/GdrFZmmzTPtMPx3kT2zMupLVo7HQFDiTleFwQPFNR5ezSJN
X-Gm-Gg: ASbGnctgrKoxWbrGaQtweHPfXPoi41JrRftBnH5RDaOm3+av7zU8KaxYgjh+COdhirZ
	CkqT/i8PoklcwUNt9k5IsPVEU8kdJoTMWlzCSkOJrgcyKbPQxUEVoAH9bmSsP5ga0gb97lUuEzA
	A+ZDQGSmC3Ht1LCoGXhYbVOn8XQKAhId7z9Ozl9jHS8WWVvRrTRMrzXrqkQDF9FXdX32wvRAit5
	yazW0D6aU9eDBVnupQmR4uEWg49r1TNa8rZ/plbgb2LtNPv0K9eZqEzO2K2sxvwlqVkMglmV2we
	O77v+AIRoCorm7uno7w/IWXUyKZgeOI7q9BEDLz2e85lJ2JRrNLYuPNdokzNJKIBWckmAeYU2bQ
	iRB+s+mHmhoDBDzlQaIjxt9DDXQsTVqCxbg57zbe/jwDZmUa6A17xu3Zn3uG1h9GJvfxceFEzMD
	CcYPoZOon+6VAqdmaCjXC2
X-Google-Smtp-Source: AGHT+IFCpVKEMNGa1TiGFz1du/mkrAjFihX7xaQjFh0qLSpjr6GgH+cPEzn+8D8uBc5acStTR7O0cA==
X-Received: by 2002:a05:600c:4694:b0:477:7f4a:44ae with SMTP id 5b1f17b1804b1-477870bf2fdmr57386475e9.39.1763031586191;
        Thu, 13 Nov 2025 02:59:46 -0800 (PST)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b513sm3255195f8f.30.2025.11.13.02.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:59:45 -0800 (PST)
Message-ID: <60c0b805-92e9-48c0-a4dc-5ea071728b3d@gmail.com>
Date: Thu, 13 Nov 2025 12:59:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 William Tu <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk> <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
 <87ms4rjjm0.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <87ms4rjjm0.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 18:33, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <ttoukan.linux@gmail.com> writes:
> 
>> On 12/11/2025 12:54, Toke Høiland-Jørgensen wrote:
>>> Tariq Toukan <tariqt@nvidia.com> writes:
>>>
>>>> Hi,
>>>>
>>>> This series significantly improves the latency of channel configuration
>>>> operations, like interface up (create channels), interface down (destroy
>>>> channels), and channels reconfiguration (create new set, destroy old
>>>> one).
>>>
>>> On the topic of improving ifup/ifdown times, I noticed at some point
>>> that mlx5 will call synchronize_net() once for every queue when they are
>>> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
>>> that to amortise the sync latency over the full interface bringdown? :)
>>>
>>> -Toke
>>>
>>>
>>
>> Correct!
>> This can be improved and I actually have WIP patches for this, as I'm
>> revisiting this code area recently.
> 
> Excellent! We ran into some issues with this a while back, so would be
> great to see this improved.
> 
> -Toke
> 

Can you elaborate on the test case and issues encountered?
To make sure I'm addressing them.

