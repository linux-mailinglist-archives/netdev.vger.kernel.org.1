Return-Path: <netdev+bounces-239635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8121C6ABAC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13C214E4BAC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777528312D;
	Tue, 18 Nov 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BqiA1ABp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680D283FE2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484079; cv=none; b=VHFFxbvLau5MTXGlB6YAOAaxjotzW5XkLj/T4dME1EHj7iCD0gvobbx97ko+iBgJd7SZuek4iZLF3P/IidlDlSjDJ9RIkPRirq4IkUQ5pkATX9FtD9Arqsu79CBPfyHeSXSiXT71P5v2weyqlUiz7vlGMFPamQK/OLz9KyHGHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484079; c=relaxed/simple;
	bh=5+HBPVFt80Bkwmphf73wMBibz+F2YYcuMzAfNsY8sww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyK9ly4empg7Rzz2dMSOny0twBcx98GiDURyllGtEozwkj/ITdx0LBgli6HNPnZFDZAk9FZLwj3utAB4e+fwfjjhblbQpzi7jEf0ydY6y+iL8fevixy3C9dmyuKsL/+9MQdG/fUYrMMiLe/CizQuNw/mqVHrHpaBHdTIRNQNs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BqiA1ABp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c844066fso542993f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1763484075; x=1764088875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CTJRAiTO1WZXqYNvixxfjEj3jVIt9TraZbDwZNPArzI=;
        b=BqiA1ABpQAIUF3L2GXuMkrPOrx5YS+b3HmfnSoi3FDRXmQXqAxQg7oS9GG1syv3IVM
         SUv5h9M7x5pF6Z7rjTMuNJ44sbKEm3HEzgI9BWTWcZvtcuQi4RSHBuF0wxvhynwYI4pD
         FeR0erVM5jFkqJa6FjTIeDJ2HlXFINk3npTWspQGbPMmOstPbTHFLGnhk1ss1NgCf71h
         J2Y1eSB+rp2/DeiC/HuRACYnMAzm06Y+yVY9XP7DM15SQrneh2LfO1SYeNEz3bF+pxWD
         Epi1sLDVziV6Zf2OkXzgggY+Mcydgz2ZPoCZZyU1xJQrarmPe1xva5nKW/8Ieweuj97W
         fZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763484075; x=1764088875;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTJRAiTO1WZXqYNvixxfjEj3jVIt9TraZbDwZNPArzI=;
        b=OsIDXezZMGkb1nXHITHlhZoqLHg/KMAPMi/yXGXWnXzoePgHuY+KwZ1iexraKswGti
         DzRuU3t/aKfFtvxfSkBQTbJGZkmVHm87Tkg/C90QsAnrYcGvwe2b4Xk9VU9vqGQ+I4Wy
         m73FEuBPucH4jUXOZh28F7M3YAUeDgWCxP7Rdr2xaTtY5oapWWNpPu5LJqDjgRiBF67R
         PYfaQ5OQEZ73QPtOQlrQZA4t73HMPLBwXysxlGBtgr/pB60bbQxVJSw7sri/j8IuVZ6f
         U5mGFEIoVzEaZi3X/7lDhHD+0OeVEfF1TNQHLf9QCm5tQLK/9LZ1EGGLknNEWNvYVUDC
         LFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoH/SekaIggONHyV7ugFzMnihfm/0Ky5hqgQTgXnzwLDBjtk8ny7VMj93zMPETf/M36LcwdzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyym+DRJaTyfPn/KAgtTwDdn2V2YPSmeU+oG2lIZVZDAxaFt/vh
	qSSa9ocMlkgBBBJqLYyMnKwkpgwdmo6yDrcn/pIRINrnCkiJ4dhXVXoi8Lyw9I/p+Jg=
X-Gm-Gg: ASbGncvkctJ8ucbCJepN/KO2xjddjVes5U1xSX56TTe9JFIU+wJzwVz5FVFqljnhw0R
	+WfN6e3i1GwllTnyoHYRbg9dxqKBfLBbJMvikF+TxmIDKVn52PE6qEEtpfHytP+rPnIht8n/00l
	hx0p9rVQf1wfoWDgDuHJ9kpDhj26MUvZPN7skOsFMIaoIuSxWLJTPC23plHEe3d4IXdGbVUQyjM
	gfzrkF3F1mCH812QUmhXKon3+Cs7oTCGq1/5TvMIs4+8vVFcmiYOSUcQxxIw5xQQjKkQjM089oQ
	6rytSfmh0o3lFmDrKGoQVKY7g8oTujci/PC881/rdKzoIyRHSVVHbUDjknoEl/HHQOhANcBCgkE
	RO3ATf+QWvUuNOJD8DuQ3tk74uQ4N7HilynMfy5F56D59WfdLYQbN4jpuCLbbNyIpPUH4X9W83i
	hWRfFwxeKzXwjrhDvaLmlUW1SPVfMjjNLMRt3RGB8gPF7+dM7XS5kxJRP/JDZB54c=
X-Google-Smtp-Source: AGHT+IF97JafIlq54OLhTw/p092fe5r1/7KihkvqfT6Tt6ooPb5n9KJCROQf36JWFffjJUMuDkZXnQ==
X-Received: by 2002:a05:600c:1c16:b0:477:a033:9a35 with SMTP id 5b1f17b1804b1-477a9c50cb1mr20037485e9.4.1763484075475;
        Tue, 18 Nov 2025 08:41:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b12asm32897630f8f.10.2025.11.18.08.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 08:41:14 -0800 (PST)
Message-ID: <c73cfca0-a43f-463a-a96d-7da3ede8fde0@6wind.com>
Date: Tue, 18 Nov 2025 17:41:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] net/ipv6: allow device-only routes via the multipath API
To: David Ahern <dsahern@kernel.org>, azey <me@azey.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
 <7a4ebf5d-1815-44b6-bf77-bc7b32f39984@kernel.org>
 <a4be64fb-d30e-43e3-b326-71efa7817683@6wind.com>
 <19a969f919b.facf84276222.4894043454892645830@azey.net>
 <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <e5e7b1cd-b733-40d5-9e78-b27a1a352cec@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 18/11/2025 à 17:04, David Ahern a écrit :
> On 11/18/25 4:00 AM, azey wrote:
>> On 2025-11-18 10:05:55, +0100 Nicolas Dichtel wrote:
>>> If I remember well, it was to avoid merging connected routes to ECMP routes.
>>> For example, fe80:: but also if two interfaces have an address in the same
>>> prefix. With the current code, the last route will always be used. With this
>>> patch, packets will be distributed across the two interfaces, right?
>>> If yes, it may cause regression on some setups.
>>
>> Thanks! Yes, with this patch routes with the same destination and metric automatically
>> become multipath. From my testing, for link-locals this shouldn't make a difference
>> as the interface must always be specified with % anyway.
>>
>> For non-LL addresses, this could indeed cause a regression in obscure setups. In my
Having an address in the same prefix on two interfaces is not an "obscure setups".

>> opinion though, I feel that it is very unlikely anyone who has two routes with the
>> same prefix and metric (which AFAIK, isn't really a supported configuration without
>> ECMP anyway) relies on this quirk. The most plausible setup relying on this I can
>> think of would be a server with two interfaces on the same L2 segment, and a
>> firewall somewhere that only allows the source address of one interface through.
>>
>> IMO, setups like that are more of a misconfiguration than a "practical use case"
>> that'd make this a real regression, but I'd completely understand if it'd be enough
>> to block this.
> 
> There is really no reason to take a risk of a regression. If someone
> wants ecmp with device only nexthops, then use the new nexthop infra to
> do it.
+1

