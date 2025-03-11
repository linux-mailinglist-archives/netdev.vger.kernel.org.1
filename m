Return-Path: <netdev+bounces-173969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A30A5CB01
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC8B189CD37
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666F25FA33;
	Tue, 11 Mar 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLYXdqe0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF18260378
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711114; cv=none; b=AY+xCCaYE7AY1uH6Hf2En1XhyN97l2yBOWqq6rmh1aA8tlrzjdSvA3sKdR2TMUod3IeCna0akNYX2vn2QvDQ7H1PTF1f/x+69HC1A4v9EJZPZCZFV8A9cMXUb7wv5qMQKhGhGkwOiYGjTlB/iYatis6cGE4yi6T7Rl71bStGouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711114; c=relaxed/simple;
	bh=D5rx9+r45ClO+mejUwb0pGj9stkPAgCLtxItwi0XoLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJUdr1s238pyjvazDitIQehxN8hsQWnfaim4W4c6chLRbEtPba8aD3i7U5d0nKPw7CgwTT2bh79FlG+YKNkqItV8AtF8GWl6nshOBLKW3+s/8xNpx8t+Rp1a8kzWk/Ht31B+ADQmwA4Xef7WPFJfI1aFxA+DHs+x89de7O7oNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLYXdqe0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741711112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGxrIsD3g8N8X/R0b8cIdpik24wuVRncDpmaS/+eRiw=;
	b=fLYXdqe0uujHTXlXMtZe3darscSkBtpSPiF41fc3Gjfwh+zBrTDpaYoyOEAcapYoHKV/A5
	FWxNFMNsCyioQXIZ5urCcM8EfjpSglAwi/eQBWn4L27vkyLxKGBzF3LL4KKuvcrYj9RBXZ
	/wHCfGkUETanwd9IUqLk1V8JLJhj61Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-7cBf5ME-OTCaVxBoOJ2k-w-1; Tue, 11 Mar 2025 12:38:30 -0400
X-MC-Unique: 7cBf5ME-OTCaVxBoOJ2k-w-1
X-Mimecast-MFC-AGG-ID: 7cBf5ME-OTCaVxBoOJ2k-w_1741711109
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so17756155e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711109; x=1742315909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGxrIsD3g8N8X/R0b8cIdpik24wuVRncDpmaS/+eRiw=;
        b=pDJhfSKmcVoFXf+9l2hdISn0DWc+dWoSSdSrvbg9vuhjJcYw1HoAnRxckOfeilO3Xp
         lCbKqMjFpl92WzcakzkOUIjoUNyEXlIPL0/EcOoM/c+Pn/66IRKuY5+FawshDxdj9zsr
         8eWf2MFR/biFsbgAE3o48HEo3kFzCDsVxp7m9bq96CRdpEaZhhPuj3fvIP2nFXGDMVZd
         gNltEFvr7toXgOrfE1U8AoOOWwb50kNFCwEZ8Kmt8tGka+iBBlugosXb23vta2lqyaWj
         Vuy5SJLvAf/EtXGJ+S+wsEuhIU7OrJhIoZHHwV9nIh/3sW0ObmWpvnk9DfoXIu7teWe9
         AQmA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Rn6qmD8ldyMrS2BGF+2CDAufHhdmYZ8LAGHpxti2V/Wkw5PLZSDmtglBsZJ4ZCl+FXGuVxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkgBgHCGkwy5cQOiTvJ0UNO3WkD0DT1K6GIZ6MGrwb89d+wEP
	MOpBEi0MJqFKxw5HjNbzaP5cG7EHh40fyLKpwC9nNwPbx2yPzOSCkQGnDNJ2O9IPar4yoFAxsGB
	f3eRLWZszp25hhzLe+jJEprrLug6wTZ5JO3ue6HArF4+vU2eGQNnQKg==
X-Gm-Gg: ASbGnctsL67oY/Tw+6Dszq5tnLfqI7f2JhB/ST3VhJ15vMXbnKFp/PsVAqTaWAX8cq4
	XR8kN6ri/Yw1uaQlp9duB5v8WhI/4ftyFW+mjhFrTFJKVTn5WsdZPH29eG27+N+MbmkR3LptgBa
	ItmKbfce8PpcDmAfYDBmW6jhrOT9TGz/3lbq43kknr3SgVzEOh8OD4qdRUEiD5esxbmH1pC/0zX
	ofzzYNMohMMx0afoYvMYIUBz6K8sM39B5QodLO40PcUKYUzhE9yTPUqbAe/d5hGJC439usxDKbb
	d2wi4a+3lOin+qIb4lbLopeWMoL/69mknIyfy5Yg6AC5KQ==
X-Received: by 2002:a05:600c:350f:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-43cf3e4da0bmr100598395e9.31.1741711109210;
        Tue, 11 Mar 2025 09:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNDzvlNOcfBJb5Yz1mXAnVcVX6WHQzdEidsmYPg97wRQhdWZ0araIinBGLkPWXTmQritaHow==
X-Received: by 2002:a05:600c:350f:b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-43cf3e4da0bmr100598265e9.31.1741711108872;
        Tue, 11 Mar 2025 09:38:28 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d03dfeef6sm29119685e9.8.2025.03.11.09.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:38:28 -0700 (PDT)
Message-ID: <7a4c78fa-1eeb-4fa9-9360-269821ff5fdb@redhat.com>
Date: Tue, 11 Mar 2025 17:38:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 kuniyu@amazon.com
References: <cover.1741632298.git.pabeni@redhat.com>
 <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
 <67cfa0c7382ef_28a0b3294dd@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67cfa0c7382ef_28a0b3294dd@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:32 AM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> Most UDP tunnels bind a socket to a local port, with ANY address, no
>> peer and no interface index specified.
>> Additionally it's quite common to have a single tunnel device per
>> namespace.
>>
>> Track in each namespace the UDP tunnel socket respecting the above.
>> When only a single one is present, store a reference in the netns.
>>
>> When such reference is not NULL, UDP tunnel GRO lookup just need to
>> match the incoming packet destination port vs the socket local port.
>>
>> The tunnel socket never sets the reuse[port] flag[s]. When bound to no
>> address and interface, no other socket can exist in the same netns
>> matching the specified local port.
> 
> What about packets with a non-local daddr (e.g., forwarding)?

I'm unsure if I understand the question. Such incoming packets at the
GRO stage will match the given tunnel socket, either by full socket
lookup or by dport only selection.

If the GSO packet will be forwarded, it will segmented an xmit time.

Possibly you mean something entirely different?!?

Thanks!

Paolo


