Return-Path: <netdev+bounces-245542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E7CD0BF2
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CB3130F66B5
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53B35E527;
	Fri, 19 Dec 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbPajm/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9335CBDD
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159513; cv=none; b=CSFJVHAjbSm3uytweQw6ubyYsKxnlYFNN9dYDbV8bQJY5lR1IHd8XdxUKniej0t6GXsyeQjpKdNuBBVgMt1t/jed4AHYKs3tq0qsl7rd93RYaneDXM9ZTJOv5Jc/xLM7IDpnSkjxeXycbkbxDrSyPXNGV77DYhUDVHTvrL6N63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159513; c=relaxed/simple;
	bh=H1DGvNKavVFSaMlR7k6trOQD4lVqVB0vpDde4vwQGHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7stGYsEcFgxksw5FwxvqUdaMSuH/Rii937kHaDK+pLrkgi9kZJrUOXcdyinyzQ84CqbeBnD/OsNBFtV1+P5FUfFMxKkoRzL+sWd1hwePLoZHthDCUXphoNezcryLcPeL4ccH89FZjl1tKb2bcc+QfyXSbCeedszwpJ4Nk2DO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbPajm/x; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c730af8d69so1342040a34.1
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766159510; x=1766764310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7rvgR3BHjJsiVCaqAbiFlB2IFLuSzLeMku7n757ahs=;
        b=VbPajm/xVh4kIHDYmd+8iOFdIQa8Waa0LbTnOWUE4zGi4rbnm9GCNNkG1JpW0SKk4R
         bM9tB7a8J90MMdMIhOi8H7MVNDh0BjhU0huOXgwtwUedOef6AJTgfR7gshTkAU68l6M+
         KjyUBlX3C+rNdz4vJPZOLepdnNz08eCowkcvPDDWRYslvURq0zYqzm9sjHRSCZzGVDIY
         gRMfdqXqulL+jnnHNHKPvmleW097zOHAlFrC8oclMq9HlR0GFJzbLioBQCk7nYLcNGIM
         oHtpsiAwwN6groRO+oCbDU2Y+MowxWTvgR6kc/uk0vcdIMoOOtXC83kverekvf6zqB/k
         6cbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159510; x=1766764310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7rvgR3BHjJsiVCaqAbiFlB2IFLuSzLeMku7n757ahs=;
        b=jr5z5x2vzFe+8/4f5jk2VzCLId+3uQ/Q43gk0svPQNlAskKun9GBk3+ks9Z9hghjs/
         QRfA7ZETfopJfDKPY96bu4Dc/quET081pKwVj/CZ+tNFwth9G8f6PFUxeoxt90ZNzbDZ
         6xHyJCl4iWqRYTPP6iyolkW7spSHyZc6wnIDSJi+eVIk6c6ve3oe6zCjonNZr4uFE2ek
         YztZX22hNKrZ8FSko1ssqzzO6Goz+lg5aEYL6n7cSQ0yZGkxlmNKc+PAnmy+Q9HJaax2
         zrO96TZjuns5nJXDXk3W3klnVjEL1KEi7o+edwX/Ejzrrq4TBWEGUCTfK8fPKCfzAqdb
         FyNQ==
X-Gm-Message-State: AOJu0YxdGhIunac3d6B/o6J3F8l8rnDYL1meoaHkBjOH1luScmM2brox
	Oov2IY+Y5Tdcl2pVyDmpmh8oDbAq8V2qrdhjWWhDYsVIQ67hsAHStJ6P
X-Gm-Gg: AY/fxX4sHOVsqat+cWWgQokl3yKaeB2YwX6ntIvNvN8//aGt4aVZYwktMZiHMjSmBBW
	DfMqIICSVnZcfsHoX6nGcNdsBWd6hgBf3JPfV9t0BYF+pvakXNTvXiYP3Y8/5gbtg8AWDwaJzZg
	uh/meDV8Y/yd3J1tuzqpuOCYecPhFzwdWxPP+hGqtKXpVxXmZUoSfgok+IOcUDbvRRHGVNuhZch
	neDNv1QZLMx4gFr3vqHJZKutu3fuRLo3vzo1I4ddeBdf1xV7b+AdWC4x7WEuPQH6UeE7eXZHAbX
	Ne6UWqXRenjfRiJOprtUz+h894YSUv4XJKpMYpMwXesnVlsPP9VVS4C2eYrr8+d4S3GhVf1tNjt
	oPg3vul8xcQwJ8x+55cvKw90A8pPETel6/F60wJ1OcCPkbF9QmPBbpy/rtMYsQaMG9hxBrC26al
	L5sY7qxRdAuedBCFPfmu6+U4NwCE6dnGcbdwFnZ6wc5WFOuSsX+COLs3Vg+C4iy8zl77aj0/FAq
	mk=
X-Google-Smtp-Source: AGHT+IGxFY3tfqqGfgJVdwGc/vPdanLzBV40RdPc8BmZ6UNg9XtCVHM9Rf4nvTrlnrW+kkmbF9rlpQ==
X-Received: by 2002:a05:6830:2e05:b0:79c:f9ff:43e with SMTP id 46e09a7af769-7cc66adcd8bmr1753958a34.28.1766159510450;
        Fri, 19 Dec 2025 07:51:50 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:29f4:6cbb:646:9589? ([2601:282:1e02:1040:29f4:6cbb:646:9589])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7cc66645494sm1936347a34.0.2025.12.19.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 07:51:50 -0800 (PST)
Message-ID: <9c979662-cdd9-4733-911d-b1071b7c2912@gmail.com>
Date: Fri, 19 Dec 2025 08:51:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
 <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <9a3f7b60-37e3-470e-b9f7-8cda5ddccb59@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 7:51 AM, Fernando Fernandez Mancera wrote:
> It would probably require some work on the test but I think it could
> benefit from using two different network namespaces. Currently it is
> using PEER_NS and the default. I think avoiding the default one is
> beneficial for everyone as it ensures the state is clean and that the
> test won't interrupt the system connectivity.
> 
> Other tests already do that, e.g some tests in fib_tests.sh use ns1 and
> ns2 namespaces.
> 
> What do you all think?

agreed.


