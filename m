Return-Path: <netdev+bounces-149773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892179E75DA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE4188830B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D3722577D;
	Fri,  6 Dec 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUvWm7Fx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCD21C17C
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502246; cv=none; b=a0hUQ0dNG8+k1VRRWykDWq/1DTBdhwOroaLXkCS6C0yufc5HLbhcrk/tOs1SgSJKHqZcjgu95mV6Q8rkNr2dmx4aUcErKGx+Qkf+28yJ4CDDoFxYrC4z4geVhqig7PlPil8Q2oLVkFWnPt8EMxr7PoCCpSvv6qdngi+bfmv5HMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502246; c=relaxed/simple;
	bh=LylyRC7S8aID9KJ/4Zw5GxKlPlJIl8jylkHYmoQ5d5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onEW4RaGrJrPPx4zRaoAAF0+CO6+kWzg2Ibx0YVjYBdx9Bfj/TkAk8cT8LwsETdayJiPvauGm12pcRY1pnbfMlny+35amLIluPTZtnft8MNBiN7EPg9x7DaWLQ+HY/lu7b6NNoe9OpOYj+EVEcGNGq94bZwvLGfonXfO1Wzt57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUvWm7Fx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733502243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0Pkm5wpVBFTjSdlapc+PISm+Z7NDJRJ/aKzGbKMUDc=;
	b=iUvWm7FxynMC41OvRv4qgB/73KdSAsE99KvCPX8PSWWrUdVV/CIib6xtHmz9bs4+aYB1Tm
	LUrx//T0nmUOsOmGbxUWkfhKb9YnHG19T2cTw8mMZbc9HzZLUawWV0Al9KFEIXZ8I+T+KS
	E7kf4Sz/+rlAk5hdFSVuh/TcIXlw4q4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-JDqrAY9IO4uQM5QNdCxQrQ-1; Fri, 06 Dec 2024 11:24:02 -0500
X-MC-Unique: JDqrAY9IO4uQM5QNdCxQrQ-1
X-Mimecast-MFC-AGG-ID: JDqrAY9IO4uQM5QNdCxQrQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a104896cso5437145e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 08:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502241; x=1734107041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0Pkm5wpVBFTjSdlapc+PISm+Z7NDJRJ/aKzGbKMUDc=;
        b=PPv3TIh0wb+Wt1Sg31S++sPmrqjHjwRUIzX4Nz6nKxkVm/WQTe+Ki4ww6yEiD643gc
         Cybih0ggzMLhjhj7AiQmSbm56hb+x0iQYMWn7kZeVhkkIOQz6b7G+kbJK4QOKBbsW506
         CuPaG4Y6tKpkQny4Xxcd6+OrgBesSLYq3/mT6Wl9o6CtpZEN1pMqzn/quq6cKF7s0uqt
         COBu4BToaPb+JUosuI73VKyvwKs/zbcEFjuzzxrUjFKHY6lDIp1pnbZ6TTfVexMYWgwa
         UTlF6BUfk+QxjWaBHc9spdhrp7gJfQFuJoTxkXN1tvHdCbPrTQPwTo4P+motNu5LnRn4
         VESQ==
X-Gm-Message-State: AOJu0YxjMeGL09fDY7z83GdlX3IIFKde9UND6gEyXvGyqOiKfLXpeuJK
	u9klyO6EqUEIVWc3jd0EwX5ixiOVlhEHWtPuJvu2Jl7vk5Bkgu+C1N4dMnE48dsf1RDEDG+IWCV
	6cKIoW2L0KCU+aZ/HBzlbLkeF2K8Z5EFIo6W3gr5HXN5Skb3MNNf7zQ==
X-Gm-Gg: ASbGncsHtLeZxl/BD2drAqCMuDoVQE05QTwVUDoHn2x4oQ1w7jhKl7azRRFrH9zd6KJ
	jHDC8tVFX0sR8Jw9iJR/cNWUYu695QRAdXt53Cb5+aojR6p/xYe3QpUpqK2flqfK0PpmG6U4QYy
	MWngVwACYXS9jvGpq3dXhwFGZvn0e+qNbRTscCE+Ru+TZGQ6owvFy7juAFYcCPt1ja67oWOroHX
	myp72Y7dssHkdbvrTOQCO7ejUFkJluNG8E9vId/FDkUGNvajy0zrCKjlD0xRxN2dy7OAGR0DmPO
X-Received: by 2002:a05:600c:1c1f:b0:431:4e82:ffa6 with SMTP id 5b1f17b1804b1-434ddecb272mr30715405e9.24.1733502241195;
        Fri, 06 Dec 2024 08:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO+8GjrDukh2BZL4IDQT0hYg/kEnJ5YpyBqy6xKA/QsHN+AOg+gwpgSESvslRXrxmIfz4zVg==
X-Received: by 2002:a05:600c:1c1f:b0:431:4e82:ffa6 with SMTP id 5b1f17b1804b1-434ddecb272mr30715165e9.24.1733502240828;
        Fri, 06 Dec 2024 08:24:00 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d2738sm62361955e9.4.2024.12.06.08.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 08:24:00 -0800 (PST)
Message-ID: <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
Date: Fri, 6 Dec 2024 17:23:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Philo Lu <lulie@linux.alibaba.com>,
 Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
 <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/6/24 17:01, Eric Dumazet wrote:
> On Fri, Dec 6, 2024 at 4:57 PM Eric Dumazet <edumazet@google.com> wrote:
>> On Fri, Dec 6, 2024 at 4:50 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> After the blamed commit below, udp_rehash() is supposed to be called
>>> with both local and remote addresses set.
>>>
>>> Currently that is already the case for IPv6 sockets, but for IPv4 the
>>> destination address is updated after rehashing.
>>>
>>> Address the issue moving the destination address and port initialization
>>> before rehashing.
>>>
>>> Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> Nice catch, thanks !
>>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> BTW, it seems that udp_lib_rehash() does the udp_rehash4()
> only if the hash2 has changed.

Oh, you are right, that requires a separate fix.

@Philo: could you please have a look at that? basically you need to
check separately for hash2 and hash4 changes.

Thanks!

Paolo


