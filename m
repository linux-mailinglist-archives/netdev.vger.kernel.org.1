Return-Path: <netdev+bounces-146600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E939D4860
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C20B22AA7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083491C9EA4;
	Thu, 21 Nov 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld4yVYJ6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D513A879
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732175427; cv=none; b=HdKNVnulf+kSrTLQK6m2FybtgwH55NcWG2gPxc9HNt7DBGaFetEGMxAS8fBWXIm5+RL38vr3xJNqcnt5lWGJzfHPkoqiUpz/FW/Sqa6z4SpyottdFdT1BWbaOq1ygcHF+YbnuQBW24Ks/7G3pjhk2+aYniZSIVqaUF0kyxk4nUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732175427; c=relaxed/simple;
	bh=wM1iOQ6QD63YeR1jXPE90LoDUMaLyTJ5BbHjBNMp3YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJ+pVqj08aoEzLiRH5cD1AFVNuGyiM9xqohbCpws1BaEOWg9W4VygOwqaIn1S9Wo9DrpBi2831mZkkPiEmbY0j5QyQmP5X86k+fWNlKuQ7kG8UpbFnftM4c8Cj47HTxWpvwB/YQz0aaaeK1pS/jNWguLwsztiUtEe3EdCoxP2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld4yVYJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732175424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0S+T9jzGoJUnwkGSTavJ+CCZs4lI12ayfbKOcBesSfA=;
	b=Ld4yVYJ6YAdFJLyHDDWnwGiCzDDqEe2Prlf0FQBZAugoFIejfySKpUq0L2ZaixnMmjyGGO
	0DgT2NtMag9AOtGEm7zFcTq3H6kqy/MiotqtrSxAmVVKTykJtZNYy5GUHC/42EYonAca7a
	qb+nDKW2PN7suZStRWqIPP4JfF/TjuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-mG8MUQ-gOC-ycxOAMQq1sw-1; Thu, 21 Nov 2024 02:50:22 -0500
X-MC-Unique: mG8MUQ-gOC-ycxOAMQq1sw-1
X-Mimecast-MFC-AGG-ID: mG8MUQ-gOC-ycxOAMQq1sw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so3945085e9.1
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 23:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732175421; x=1732780221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0S+T9jzGoJUnwkGSTavJ+CCZs4lI12ayfbKOcBesSfA=;
        b=TBI1TOgKANDmFls2CkoOS8uZFDtD6w7uqOtMaMvjvACGYnzEfOQ3i88+6IhzJLKpPD
         9+MiaaS+zJqBNf0kO+8eyIA35q962Tv1nKb/FXrQnY+hX3GNTLCnXqoxDnxHw7KDdwEF
         44GS/OGTwMSgO5LeBc16tcv78+Kmu+QwHo5xQk9yVQ2SszSAuYzx7GbegodYx2rvT5n+
         5DZhP/ms4jEW0+gXKqtAVpdyo34IiE3L5bXsgduqrDvi3MrfyvJwFodon33ZP6gST8yC
         yxWG0yKm1d0dTU6FcIb1Rk+qSy4l7ezNPTcJCOC5phuemfNB15AUfUREmK6TzwzpXXnk
         8POQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVBz9Z8PzbXVqT0haEk7dDilVFfQYymFZTMpytqiD4QH5ayvCUFFhl0DjrvPp+Y5bot6mKqSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKtJbPiJUqrVHerrh2zdhLfFPfWd0ueDeOzaL58Gm6L//zcZU
	TnpPPCdc3Kv/o3MCxklK+5CuE7LUID0T/1/L6iDIVgrZXjM525DtS+x8T7dTFPU3snO0HJVy1dF
	vKb4ueCXChhmrUYOVyAKygjpdQgldMNFK5u9n+5bjdBG7TP95TQYhrg==
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-4334f01f731mr44704305e9.26.1732175421284;
        Wed, 20 Nov 2024 23:50:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhYF/d2fapOg1q5yG0D1rBPToLlrBhF2TIDsM+dmIvzhgUy6ZfNWGyrQrrlZIRDBN2+NP6UA==
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-4334f01f731mr44704215e9.26.1732175421004;
        Wed, 20 Nov 2024 23:50:21 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910e77sm4075444f8f.59.2024.11.20.23.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 23:50:19 -0800 (PST)
Message-ID: <1c5d7ea9-ba80-483b-aa30-02ed7fb110d9@redhat.com>
Date: Thu, 21 Nov 2024 08:50:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] octeontx2-pf: remove redundant assignment to
 variable target
To: Colin Ian King <colin.i.king@gmail.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241119175236.2433366-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119175236.2433366-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 18:52, Colin Ian King wrote:
> The variable target is being assigned a value that is never read, it
> is being re-assigned a new value in both paths of a following if
> statement. The assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle



