Return-Path: <netdev+bounces-214533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE32B2A09E
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447F61B20D36
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB632E2283;
	Mon, 18 Aug 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eemp00oN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3D2E2287;
	Mon, 18 Aug 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516817; cv=none; b=O/BQ5/TGsLm8cK9ypNwSR2wdMpKJtThVwzbIhEHffdJkRwIQ5XjcdZ0N0fNAnAM3ZbiSHHim8BuuptrUSxhnf4AjckaVBu+Ms1DzhTe6KxPbi8mTmxAgbe/ueny/cmPpYyKTJlc9xxNu6houarCW8kIrNCEX+hK6jlRAsdBVsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516817; c=relaxed/simple;
	bh=xIbtY/GZcuyna3xahbU3yP0WNDvLCRfwL4pyva/pN58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvlCKWmNao1D9nc9WuagkvlAXGDZzEYGSNrhGk/pXauKtnwIPirv0LLKeLKssurahi07yeu18Uh2D89egiMU/8oE46bnJpDojLhjp6u4U9GdmEEWfUJDjTJ+PR6aoZ1MxaqbKLijbSh3nP5NJhRSkk4GzU8tSSXtl7EbNY93uPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eemp00oN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso20077855e9.3;
        Mon, 18 Aug 2025 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755516814; x=1756121614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osl2DDNbnjlmzdbtXzLGvTOs9Gay2kvLfiPN9N6P+7g=;
        b=eemp00oNVjchoVKwmerUREtlKrvOv4MTqmxaq6lXD5sTAntDtLpAu80EU7nEoSMMnC
         tYa57NBE6F9JwN45ravDXMB+j2A3ws0WhPsUTkefHRJ5Q/gp6v30UzG9aZiSqt0SsiMc
         ZTWzqxNIur9ZfFjYmlBJfSIN3ZMe2sn+kPTBFg302VeyR9N/49otse0OfNQr3zgHNzkt
         xDKEgcAwFOqCPMoGXNCN9ivDzQdcsF/63hoS182AQvrjVbQBk+RwyosjQU220YfyvuK5
         lvew2ObqTzQR/j/eKFUy7rtA60FdrF/jmIMvLQtMaJOD5awrxbf4Ia7D0Naity7hOTI2
         mBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516814; x=1756121614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=osl2DDNbnjlmzdbtXzLGvTOs9Gay2kvLfiPN9N6P+7g=;
        b=tgd4QNnRRW3s4zfJK5jJywphgH51Sx/5L0lUeOPrOOXaWfEf6D29Z4zyILcWRslEIT
         PNuwVjlLLvGFgIGYrKcICnjiteuos2wRcifwVyzIWVtJSs7vxpzK58k/CegwQNxDv5nO
         hc4eIv5NYYpnH25Q+eMMLTcE4o1mUbxPDnZQ3Z1mF2jvzixEel6HXvz3+begZDZQ67cY
         DDJ/dYK9gHZeAr/TEol3ru4HaQ6YqOluYx7g7CR/hMa0irvLcDyEed3xeiNNx/A21WnC
         iESh1bmjkqaKulAJl3fMAwUZMc3/iolxHWbqKRSRGEUXsT8z8cB6qrwSk9WWQnXfsTxB
         SJLw==
X-Forwarded-Encrypted: i=1; AJvYcCXGkrz4ueKxnewUyxMupQAj/VHpIK7aSttlwu1nxmYMiuYVK0HC3+VtFdrrAo99U+0GAwra2iD+@vger.kernel.org, AJvYcCXntFScKLHV5AKHlWU4vWkN2P+exkH04dna5HG9wwsUc//knZPpVMX+IWoSgkkQ3FQruJfYkgKqU2LSFmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlE/i978o57AT6Sx5VCcn3Tt3oamUYiykNp2zxxxAZuyMF0J4
	wGaJEoSGFfC3aOg6WoP8HNQ1esNonjqE8NHAj0YGaKcR2lPrv252s3FG
X-Gm-Gg: ASbGncsQ1/y0eE0RwKTqXxyOT4pjhIj7UoKf5aOQhOzMJMvsREIotc5/Yr74i6H5gqD
	oCRwD+n1SiNo3X56FpgXl89fO/WwLLXQM/gSteamrNX7V37dKzQwQyAmnVozhuWqlB8LVNMEaDz
	57OxaU+SC9X5GDWdQy77E7oC2VyJAIGiP4WnT5NpbL4OB1T+tucfx5IPuKqZyESKJ6hbwuYNYAd
	kzCGkMOUqY+XgzTZc2zoUPsfGcKS4B0fdDNx5DI2wMkgLJLwTE5RQz5PJukNVMEs/rJ56EDghIC
	NrciuaMgtgEySGM5mUvGVwLegInC99bRJnsE93Co/AOL1xPvMcwQqU4gF6F/N2U2T74+6xHIdQn
	ar7HiM2sHOlsQ6fgd8OgeqNkrsV5wAvYt8Q==
X-Google-Smtp-Source: AGHT+IG3722MgpHrCjYdrulVDf8hszbbpDPFDZNSqn9tHGrFmK690pqAjTDn9sTdA5K7jdEnj830yw==
X-Received: by 2002:a05:600c:1ca1:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-45a27bd35dfmr68530385e9.3.1755516813667;
        Mon, 18 Aug 2025 04:33:33 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2231a67asm126861595e9.11.2025.08.18.04.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:33:33 -0700 (PDT)
Message-ID: <52b8d235-d7ab-46a3-b624-5909b638f1b7@gmail.com>
Date: Mon, 18 Aug 2025 13:33:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/5] net: gro: remove is_ipv6 from napi_gro_cb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-2-richardbgobert@gmail.com>
 <willemdebruijn.kernel.2d92c3db94507@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2d92c3db94507@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Remove is_ipv6 from napi_gro_cb and use sk->sk_family instead.
>> This frees up space for another ip_fixedid bit that will be added
>> in the next commit.
>>
>> udp_sock_create always creates either a AP_INET or a AF_INET6 socket,
>> so using sk->sk_family is reliable.
> 
> In general, IPv6 socket can accept IPv4 packets. See also
> cfg->ipv6_v6only in udp_sock_create6.
> 
> Not sure about fou, but are we sure that such AF_INET6 sockets
> cannot receive flows with !is_ipv6.
>  

FOU sets cfg->ipv6_v6only for IPv6 sockets in parse_nl_config.
I'll clarify this in v2.

>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>


