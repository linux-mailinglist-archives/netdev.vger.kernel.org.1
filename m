Return-Path: <netdev+bounces-141959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AC9BCC93
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32508B22304
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F71D432F;
	Tue,  5 Nov 2024 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdXZIWJ6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A941D3195
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809169; cv=none; b=MFy5Q4cc3CNcK9wcHKz6djEVEFG/5kCd8j7rhkP5deE1NNbbi2SiEVQR8mlzSQsEUTSUPXnyBtcX+id3UBW7utnQgvU7v5CqVSBpqApbEsjos2MQnFJFyIH+32r+03uBOK5TXqaW8lEXc3PLIB0tLmi6o8zMvBrJJV1LMf/BNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809169; c=relaxed/simple;
	bh=6IG5qt5nHWJYXp4MqtybUW2xYTN5iIV2GsWYgAVZAn8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qRjLPP27SDVHg1NIPURxz/4ECgAAG6EqQ2B5g5ahfKZbIbnqeldA4gTR54+hUfCNMd6FWBOTT7IsVZoaffX/6LtRyc+W1q2LLZO31najCXbpGDa7y9U5EA63/0tBqsdHvA97x6zJXyE1HjsnMCDdiGXJtmHpL/+8mHwlHU9gAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdXZIWJ6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730809166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTshQDzbKVlwtPcJp5CHmi3syN7nyTyXK9J4EoOSWYU=;
	b=RdXZIWJ6HcPCWUval8ny2H4sSOijmJlPp8l/6RIvqa7UheutOPKdB0qesNX0rxQJ8eVveB
	Sn3MV7co7U9jSnF3I/cQlwiG1pWse2n4sNTDIS78X4UBBw+gP5HqJepgcXFF5LpQZIdzB4
	li33il3oRS0A6xVao1PwDGx08VC0SM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-GmDrdBJ8MyWDC5Is6YUPPw-1; Tue, 05 Nov 2024 07:19:25 -0500
X-MC-Unique: GmDrdBJ8MyWDC5Is6YUPPw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so38033955e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730809164; x=1731413964;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTshQDzbKVlwtPcJp5CHmi3syN7nyTyXK9J4EoOSWYU=;
        b=peyvDDYSKEUbSOjA8ZcTL0HLqvgZWSq64wDnYqx3UhjkTIUJjVt9cEGyQhIysdCVqP
         HGhwhEWhzw3qp8z39k4eHNJly/G6YHTo28omMt+PxOKC/SDUPB3nCHZCYG4KZ2AhpsD8
         +C4wiCqqEokcK7UVzPJhOlJxx6q53ZORM0Zjvr+vYPGHfxe81gQdEiXu9ldAzBOvvx2j
         6JYamSL2eFmXA+5AZ+MKjvonE/uqEws1Sd54/QT6suTEHN5mXC22B0lsah7cPBBNEtTv
         3f0O36yocDj3Y96AeqEWNA5NeiagZO2Zm7n0qU+jbee3f6NDgPorH2O2xFUnUIKC/kY3
         7Psg==
X-Gm-Message-State: AOJu0YwE7aMWgQakTZ8ItXctBF7+bg26RMSND+TM7Q6jJ4zedWkfThym
	7kSjxDfKOBnsh+X4BEqPXtqGLuaMccTd4dRg9k2Ys0icR+VYAJdYuNzBh61pFE6cTic7DFTbNHU
	3DHyrzYlWO+7G5pyV7IpKEjigHsSqoHG/qwmA3hpdrXc7soXO7Ts72EE4PRCk/cSyAHpAgAdOpV
	y6NeELjnWX3Re1qjcxTqsDEQfZxBdqlZdkm0BawQ==
X-Received: by 2002:a05:600c:1ca7:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-4327b8011aamr190518225e9.31.1730809164263;
        Tue, 05 Nov 2024 04:19:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTjp6lmTEdV7esbsrTypFUxd7EBoTqoWOxGLxTzTG0HSwiKyMfRgXAVZiH0HKVnkEEHzsiXQ==
X-Received: by 2002:a05:600c:1ca7:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-4327b8011aamr190517905e9.31.1730809163811;
        Tue, 05 Nov 2024 04:19:23 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6b5sm16200983f8f.88.2024.11.05.04.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:19:23 -0800 (PST)
Message-ID: <453af1dc-b778-40c8-8ffc-5dc97d7572d0@redhat.com>
Date: Tue, 5 Nov 2024 13:19:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ipv6: release nexthop on device removal
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <cover.1730364250.git.pabeni@redhat.com>
 <85ee0558e07d23de03fca1d2444a8d3edb75e912.1730364250.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <85ee0558e07d23de03fca1d2444a8d3edb75e912.1730364250.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 09:53, Paolo Abeni wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index d7ce5cf2017a..ef55f330dcda 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -187,6 +187,7 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
>  						   GFP_ATOMIC);
>  				handled = true;
>  			}
> +

Please do not include unrelated whitespace chang... wait! I'm talking to
myself... in any case a v2 is needed.

/P


