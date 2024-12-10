Return-Path: <netdev+bounces-150625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF29EB02A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E7B282C9E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23B19CC3E;
	Tue, 10 Dec 2024 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3cHeWtT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209EC18A6B2
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831341; cv=none; b=MF4QLM41+tWzjUQ5Rjka4T6Q2oc8oQAG0OnzQsxH7AA4eprztXqnDiF/S+X5tMf9jLJXwkQRPWhRv/qlDXkcRZseBK5Wk/nFQJNavOdJb1pcIJAqs17ut7X98ZELkumh9pPiLDIo6IkKHZr2riK3W8VCNNYgKBQsJxNRJG4Ph3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831341; c=relaxed/simple;
	bh=mnokr91jtRicVi/lT5Dde/9KYPASFFdvuoZsxEWoERY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msT5W+hv3vz+QnfA1xrCuRNfkV+q5mWMe9X+/5i8H3zEr+cELWqURaJZXAInAZRcFMen1/bJne+lCRDsIEhJH8X8ZDoBpL7W5CK4XLyOdbyEthsMQQuHcZLc/NdVASMaUBswtXgriCGYR5/rAGz1XH/d8brRgMQmeGXerbA4FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3cHeWtT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733831339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0RgRQ8Fwdzfi4KX0sMMRWjuOA83qaL8ga9F3mmIUgo=;
	b=X3cHeWtTcSsv1MNMI/WIRhXuFugk8xtwPvTYmg3HxbkNKlVgYlaQcf4kN8GeZ5V1zn32b6
	aEf7/dl6FcB3nIbNQ+VYRbJ4m/8RqhFhWCj2/bt5CCH1tPpgy/aFeKRZ2Ulfdr1+0S/0jU
	DgUmEWwHIXX/XP3GUEz5Pdjj7ZE2E9U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-bXZaXhZ4MRmstZ7voLZ9QA-1; Tue, 10 Dec 2024 06:48:57 -0500
X-MC-Unique: bXZaXhZ4MRmstZ7voLZ9QA-1
X-Mimecast-MFC-AGG-ID: bXZaXhZ4MRmstZ7voLZ9QA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8fa87c9b6so70232336d6.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831337; x=1734436137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0RgRQ8Fwdzfi4KX0sMMRWjuOA83qaL8ga9F3mmIUgo=;
        b=dR/hH1LYp+dNcj6FU2pUgHH0OnDsakvQcnSN1Ffekswsk4eVdjxoVHAPkg2WtIVU+Q
         gAOqYaE7i2RYE46sK181TV7fEYAC3zKR+yzET22Z7QO4PAsSwa1snGx5HztNF3LVjZ+n
         6SSPdnBrURcbJo868etmVpY5OQFMHKGCIlLjMniSXjeT3HZ0SCfJ5Km8jkKMylnpIVJA
         f9T7XAFTmjzsxZkT9cJf7p+hAuQc9/vuPVK7CdHdJXGJwyt49bbGRMZMdHlKfOxoV6+3
         bF4ZpyA+4ng4oLhu09EbhdxoDdhJahVIXaYPPFN6OGnhhK/+g9jeex4BSITA47ZKoKY1
         v0QA==
X-Forwarded-Encrypted: i=1; AJvYcCUtyabL6IbYwnG/3FTRviuqsEn/1VF/KnHUTp1XjqXgkXgpBncMCH53S82Pk+8LdEzx9zrrPEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsu+qM5cXitQKm+tfEB2a3hcmeSNEaereMMFPUjS2JwNLLMyp
	Q8wep6EdH3eOk2xO4xqGho7itq5fo0+wrXsCDhmv2QqanF/NUkOudJSjhnbJelpoaFJDTERPy7n
	j2Xb8VxhDu6tQTDm1tCzP/YIsdxPrBcfzMTl4cPZ7Uoo9YXreWblPyA==
X-Gm-Gg: ASbGncukFrN9EKNfNiZovIAxFZ40XcdGpG1jcQl417K6aiM9USbh8QqC0BOsCLnrR+9
	yM3hRJeFxbTnxqKLs0ry6ciJjDwK6yKsW0UHpA844nJUOwNyHH22S7zrPB+pt1HLil3PBu3Bhuw
	QlK/W+6fRQBgXAt0GL33hd85GaT3z7W0knftwYVq+qYPWnEC2KoJhzVi2l4Yru6kdAyqvWLoM3D
	ai4BhAMuD0jqg+M28IBQrPHczg5XRw4A7pw8XX82aLxlrL7K9HA58Gwzl69iSmid7qVRfQm6RRP
	grCzW4IrAc4dCGOFEuozdoccnw==
X-Received: by 2002:a05:6214:29cc:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6d91e36338amr81907516d6.28.1733831337171;
        Tue, 10 Dec 2024 03:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEVQLuWoavfZC581NsArXEejUDFPngwoK44v/L2+NsCF03rGrITKGAd92SgJUPcsYi/lowhQ==
X-Received: by 2002:a05:6214:29cc:b0:6d8:8f14:2f5d with SMTP id 6a1803df08f44-6d91e36338amr81907276d6.28.1733831336905;
        Tue, 10 Dec 2024 03:48:56 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f5af294asm39620056d6.48.2024.12.10.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:48:56 -0800 (PST)
Message-ID: <f5076560-07c1-4fc8-93f8-df19b3568927@redhat.com>
Date: Tue, 10 Dec 2024 12:48:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 04/15] af_unix: Remove redundant SEND_SHUTDOWN
 check in unix_stream_sendmsg().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241206052607.1197-1-kuniyu@amazon.com>
 <20241206052607.1197-5-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206052607.1197-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 06:25, Kuniyuki Iwashima wrote:
> sock_alloc_send_pskb() in the following while loop checks if
> SEND_SHUTDOWN is set to sk->sk_shutdown.
> 
> Let's remove the redundant check in unix_stream_sendmsg().

If socket error is != 0, the user shutsdown for write and than does a
(stream) sendmsg, AFAICS prior to this patch it will get a piper error,
but now it will get the socket error.

I'm unsure if we should preserve the old behavior, weird applications
could rely on that ?!? usually there are more weird applications around
that what I suspect.

At least the behavior change should be noted. If it does not impact too
much the series and drop reasons addition, perhaps just drop this
cleanup? (Assuming my initial statement is correct).

Thanks!

Paolo


