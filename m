Return-Path: <netdev+bounces-100601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAFC8FB4C4
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25531F228CE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EEE16419;
	Tue,  4 Jun 2024 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POnDmal4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957515E83
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509925; cv=none; b=Xm/JqogP7uRA3Ixw2ZRJJ+wBWocsROmmhzyuK/SXEW45u0Uzfe7BRWChgvVQ+PShppzXHI5TO1vPjIZTlybfyTrRe06S+u4xZMLiCSv3i37mjg/bTA/DXOmOrzWCBrRimcX1MmSw4fPtkdsGxm2Nw6uvZQpenxOSGhQgtEf4MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509925; c=relaxed/simple;
	bh=1S8mGHYMiZ8q0CuVhz5+KV5LmOzGz37Z9f92ilpXG48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GGN5wA5xayFSgZoHSBDGwILn+HcoFKGpELDfhLcN2l9us1qK11YVpwwLwydMfyWKIt+tz/SJmTgWLV4l5DyK3VKNh4XE9fsUTMGs9Zd44BiDDppbphJJXtbRVzG9IGCei9zUv7MF0UAXkRYCFcvwq0ZuZfFm/xxEmVpJeG+J8WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POnDmal4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1S8mGHYMiZ8q0CuVhz5+KV5LmOzGz37Z9f92ilpXG48=;
	b=POnDmal4UyIn9niqhzebgDnVt/g8jmJRA8rq/6jr4tTNwHG2UAhOsndRHs7NW0uLIjN/vX
	KpxqTJXjCP/eduaGZwuY7SdGK9TPuzTWIwzqKvR1gWdn8z3ct8A33/aJQWOfywMcpFNOQa
	zbjypMNGEG0zwkSy41mrF8bF8VkjJWE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-h8T02hz9PLGTdixUoV9JwA-1; Tue, 04 Jun 2024 10:05:07 -0400
X-MC-Unique: h8T02hz9PLGTdixUoV9JwA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ea91c7c801so5057671fa.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 07:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509902; x=1718114702;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1S8mGHYMiZ8q0CuVhz5+KV5LmOzGz37Z9f92ilpXG48=;
        b=B9VIpqm5EZMwmDEhqYJK+JAa1HWWp3jXbDWq8QApRHC7Ith6DrOVvVdcVOlTMeuehp
         GKKaBmYWtBpNdMu0L2IeGIHk9QO5BG5VLqzE7FWMaD/MSg2R20gg24lbAwxf8Y2IglM5
         42YihqQMc9GIXdu3MZjUE98eUohTo5Xh6+hJGeLjWq08egiClXuB1QzALM0yd1LXFUdA
         vtsVTQrJeNzh13WDP6DWnAbZn1jXdPzXKosJA87iV//H4qk7zX9GIglLXoOFBJBO59/o
         KlaTT+6EWk5WPwiVEUQG1s1zQZEqvdhYYxSJvJHPiH5SwTfyaHcAdk5Y8mtYweDEeLU5
         jxQg==
X-Forwarded-Encrypted: i=1; AJvYcCWSIH82RV6Pg+71CeZ4gJ+CLkvZmM2/2sTEU9PmaTQ7jqqZZKH9ph4iLc8ks5sCEspOzjaDz0oASbq5qBztXsq4nzjpjTLB
X-Gm-Message-State: AOJu0Yz8JTeO8/9PSmdrW/q0TBwYExDqkTpW0wCjIYBbc0bfekFe4iXp
	sItBZ0qwck2wrBffj4PPd4YQ+ayUfKUAgKXL4yOYTdpftmmpdeZnRBg40V50g7vMKFebp6QpncT
	fwhkJtbO69caxjNFyZBqk+aCwEHfootr6QhNUcbtIk0Pl3qndjiuGiA==
X-Received: by 2002:ac2:4313:0:b0:516:c241:a912 with SMTP id 2adb3069b0e04-52b895545a7mr6713761e87.1.1717509902487;
        Tue, 04 Jun 2024 07:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+ZxE2oGUMMT3hZsp8qQSSlm8sUtMNkLi3Xw7nPUZENv6QGoM2qhoGXX5FmlZ9bfFMabf2cQ==
X-Received: by 2002:ac2:4313:0:b0:516:c241:a912 with SMTP id 2adb3069b0e04-52b895545a7mr6713743e87.1.1717509902044;
        Tue, 04 Jun 2024 07:05:02 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b74:3a10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d9c68sm11571443f8f.56.2024.06.04.07.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:05:01 -0700 (PDT)
Message-ID: <d5e4c3093a68f38657b8061bcbf51396e1d23bab.camel@redhat.com>
Subject: Re: [PATCH net] net/smc: avoid overwriting when adjusting sock
 bufsizes
From: Paolo Abeni <pabeni@redhat.com>
To: Wen Gu <guwen@linux.alibaba.com>, gbayer@linux.ibm.com, 
 wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, 
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 04 Jun 2024 16:04:59 +0200
In-Reply-To: <20240531085417.43104-1-guwen@linux.alibaba.com>
References: <20240531085417.43104-1-guwen@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 16:54 +0800, Wen Gu wrote:
> When copying smc settings to clcsock, avoid setting clcsock's sk_sndbuf
> to sysctl_tcp_wmem[1], since this may overwrite the value set by
> tcp_sndbuf_expand() in TCP connection establishment.
>=20
> And the other setting sk_{snd|rcv}buf to sysctl value in
> smc_adjust_sock_bufsizes() can also be omitted since the initialization
> of smc sock and clcsock has set sk_{snd|rcv}buf to smc.sysctl_{w|r}mem
> or ipv4_sysctl_tcp_{w|r}mem[1].
>=20
> Fixes: 30c3c4a4497c ("net/smc: Use correct buffer sizes when switching be=
tween TCP and SMC")
> Link: https://lore.kernel.org/r/5eaf3858-e7fd-4db8-83e8-3d7a3e0e9ae2@linu=
x.alibaba.com
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> FYI,
> The detailed motivation and testing can be found in the link above.

My understanding is that there is an open question here if this is the
expected and desired behavior.

@Wenjia, @Jan: could you please have a look?

Thanks!

Paolo


