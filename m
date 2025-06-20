Return-Path: <netdev+bounces-199837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9DBAE1FFF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F10B7A2981
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9F28937B;
	Fri, 20 Jun 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="U/oWL/C8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B11DD543
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436413; cv=none; b=fMtXF8MrRSMSZAhd9+JyM8VWfmOUMynUKtfyiqNz95xldUXsnXJmzn1UM1Pmuj+EDSlAg2lZ/x10qXYP/CjbRZvmUDkOYko0lEV1fqGWfik0ICZWZw3EAw3oPpo0O6TF7mT47Ina2IocJbobPBgWEg3zv0WD+0QoELXs6ZJ2Gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436413; c=relaxed/simple;
	bh=HYTOWjDukRZ7ZHMgKqBNidaHm/7rDrH6ltFndm5/Ihw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGCkw8b4zuTCwOPz4KAJYz7oJY1pSbR64ZlIw+FLciSh0YbNL2CrhLiCkS5IBEEoOO4VSFh9yxRIrQ58eOf25ewbGUM2+AitMVVz2BsxPM/FLs39AuDpp2eojfqwfFj4kpIAUenLwHMtM73I1dNO6mXFIdNEy4G2tcRv11mH/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=U/oWL/C8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso290138f8f.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750436410; x=1751041210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NXttrKxk2yS2jYMSNejp1cO8JOMwcunJDEmJOmX01c0=;
        b=U/oWL/C8bFbaZLtCilyhwAR7bWSQUhENpYQF3XRmkDDRRUuw0lJ0gHkAXx9FSTJUU3
         GtjBTiq4wxqQY7iCEhKkHh9sMHPcZ0JrufWCH4PiJXhJ0EZ3UirFj1HjZq3VkbB4yvuh
         Li8ZHgbIEi/I26ZdL7779ftTJsLOORTfe5Hbz4xbFVxWPsYEjv8/+VoiHnAH3HwF72Hg
         g9Fu3J1LdaPBUuKkMzbl1ck8GrB7c96T53CqxB1HTjaYeUbTzCCxU5rpRyIzrkLzNIi0
         cXU3PtNmgQepYldUgf5v0L6RO16ijWESdawAxJcBRR9W2Csq0P4ty+DwHuo8HCGgGWY9
         rHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750436410; x=1751041210;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXttrKxk2yS2jYMSNejp1cO8JOMwcunJDEmJOmX01c0=;
        b=pDP4YJtiBVFUtV4Z2ANICCr/G0eytDv8NUiGuLlkPuBizr8AsDEnYKklHrUk0KgNai
         MRILQMkA2CJKFn3/JdawaiAFZ70s3xh4ZwTXjvhiFasPj86Qfi2lolEHhy+oUskinyC0
         OA2Ceo+DAWF6/Nt/hpxSMUVLGQCGDdXD6+ZyK3UuiyZjKtyrYi2YMXxDnUhqkN/+9erz
         LuON8r/qjfd8Lc9nfdNVn5K84Easz8mzjFXim4ts4KAWYZbMMJnBK0HJQaXHC837N66N
         J44nMr1JVCS2FQLf2Wt3dtseKPxAqzetwc1GQLm+3VJ3wfd8MHCZLDGxj8bTYWfbG0Xn
         cCnw==
X-Forwarded-Encrypted: i=1; AJvYcCXW1SrC/vOM0/ioiBVoTPfrPcESRGEwieupMyT7L8+FbjVV4/D5cQQ7On/tcdF73njdX+EJMBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9poUpVg6LrCN6RC5SPGg7FzfRoz8ZNXgY+d/Sg5GvHlf+Eti6
	WPYBJwFmEsteC/yHUSfoVw6uxrvjVjqS6PfNfLqdmit+WoUZVUaJu+doCCAzR3Z/1CI=
X-Gm-Gg: ASbGncv6zUvE7vcuz2dqViGNDgpdkZjsju9ajUu3b5jUVvwuKUmLy9CiecnERz7qrBt
	S7zHYjcdlhodPFDqXCni6twVgCmLHN+B73SsBogUgXYgMLyyd6qTJb+Bcq8qNWwzWqZK48WuxHf
	aTJZE8hVaQ46bG7e5fiKa586vKDpI2LNBWo1Rwv+h+ajKjG5l2trfkUzTjDhfyY36OZES7fRylE
	gWIcg0FNGQJvBuZcbKKnosZHhpEaomI1IvRrjA4wAsMUEv9GzTkxgMHGxM3cLsilIZbZEr27Mys
	LaMIw5NQUtg8g76NL6zX46bomA9DFBPgfX79S7pn4HyTNbjMQUiwizcv10pdSQZcaRLKr7UxOc/
	7bI7w0SEbWLPySz7TOP1iHpXC5T1QPJKOtfrc
X-Google-Smtp-Source: AGHT+IGkowJ8P5bwuL7sCxZqqQhRiSiWE7pYlaRQ/m3YEL+PQGhAmp5M2JGhffVe+AMarzUPpEXkKQ==
X-Received: by 2002:a05:600c:3143:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-453658bac2cmr14871855e9.3.1750436410004;
        Fri, 20 Jun 2025 09:20:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:607e:36cd:ae85:b10? ([2a01:e0a:b41:c160:607e:36cd:ae85:b10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm30442825e9.6.2025.06.20.09.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 09:20:09 -0700 (PDT)
Message-ID: <ed8f88e7-103a-403b-83ed-c40153e9bef0@6wind.com>
Date: Fri, 20 Jun 2025 18:20:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: When routed to VRF, NF _output_ hook is run unexpectedly
To: Eugene Crosser <crosser@average.org>, netdev@vger.kernel.org
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <f55f7161-7ddc-46d1-844e-0f6e92b06dda@average.org>
 <2211ec87-b794-4d74-9d3d-0c54f166efde@6wind.com>
 <7a4c2457-0eb5-43bc-9fb0-400a7ce045f2@average.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <7a4c2457-0eb5-43bc-9fb0-400a7ce045f2@average.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/06/2025 à 18:04, Eugene Crosser a écrit :
> Thanks Nicolas,
> 
> On 20/06/2025 16:56, Nicolas Dichtel wrote:
> 
>>> It is possible, and very useful, to implement "two-stage routing" by
>>> installing a route that points to a VRF device:
>>>
>>>     ip link add vrfNNN type vrf table NNN
>>>     ...
>>>     ip route add xxxxx/yy dev vrfNNN
>>>
>>> however this causes surprising behaviour with relation to netfilter
>>> hooks. Namely, packets taking such path traverse _output_ nftables
>>> chain, with conntracking information reset. So, for example, even
>>> when "notrack" has been set in the prerouting chain, conntrack entries
>>> will still be created. Script attached below demonstrates this behaviour.
>> You can have a look to this commit to better understand this:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c9c296adfae9
> 
> I've seen this commit.
> My point is that the packets are _not locally generated_ in this case,
> so it seems wrong to pass them to the _output_ hook, doesn't it?
They are, from the POV of the vrf. The first route sends packets to the vrf
device, which acts like a loopback.


Regards,
Nicolas

