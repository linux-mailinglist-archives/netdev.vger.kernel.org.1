Return-Path: <netdev+bounces-126442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A6971291
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65DD283C40
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A11D1B1D64;
	Mon,  9 Sep 2024 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NZdHu4/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41961B150A
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871834; cv=none; b=OlSzf5XJNM21xSNJW5m8SvaUxquGeCdElFIj2KChagWAEfhRpUT1GCzRBsyRW74cy8T4gINhJJ1W/p4F+Fa9BZQE+3OJNoidsQW/e5CH1cCXWXIMaXeATwa3SuvC9tMHWDdEgws4Yo+wQg5Mk9Zhpz3KwsnEPNO+X4eJqh3OHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871834; c=relaxed/simple;
	bh=8MYgPMsjnl52OhtBEJmySmN/911r8RiEdYEi9Jq0+T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOreM50mU+GvpDu1/w0885Osu1OiTBfSZN6F5YyfHjYOdbL1sO/pPBx5lvCg35j0cOTKMcIQ3GoRsyo/P/oBCudKzblvujE0thI3qb5GCXY/2xXy3BSO08Sv+4J/wof+VK1dFCNr0ei6ApYt+n25Gxpw789o6VJk1kzPoE4/ZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NZdHu4/y; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so7812192a12.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725871830; x=1726476630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehf60IrIU01rqUWzHgc/nJXdmmN/TXesL4gXknKQf6I=;
        b=NZdHu4/yJ0g0ucVkTkg5Dj2mYnhuAJBJNStFI8yNNTscUnjGc8dnfYBQSaalm0f93/
         41s9q7cdEXw6gFIMlSsVM+HaZOvEZdyxSCVFLU/CBEtTR5ayd8AZ2VGFeX5l6mdBJivY
         DaeKciHaFnWeFJmGcGtrjJW5mnTy6WWYzUUqVQbrfqZosE3VeeAinUc4pJad+DbAexYj
         Wa+GkZ1Ra7FtIBaab4KcGixiZOMDdnDsNtb+cRjDJ3k7DDNKMya9qEoYvPzk70TivDbR
         biL0u5mlGJCdKn6DM9Ya4sG7e2LBE9HsS8jmPH10B2IGv9hr2P+OgIC6sHmy4ZiFD90b
         O8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871830; x=1726476630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ehf60IrIU01rqUWzHgc/nJXdmmN/TXesL4gXknKQf6I=;
        b=My/wM6sPw31w4+Fjdv5xe1TVjgZB6K3N7WbCK7y2k7MaLWewe+tcfcCMwGo9dl/TkX
         fXuCWYqQOrKx87K2VeV7hE3GtAvaxalI2nRAuVjSQ3mzfj300Ollb/3bG7OdD9xSPihs
         Wb/wmsgU31ZzDjsHyvuVDpMGoFkVnQUvlbbn+pkHM/k97RIsRfbfGlEs3ore1LIaaX46
         4YSD3KKReY0wDpx9Lt0AW2wboMY6Jj5Xm/jKVDmk5M9GHHJOmiIjdD52SN+r1LO6XNp4
         8LjgPnaL3I1dyj3i9s74s/+mUED9I8xQip9pkyXmMj6fSutUUoDK6cuJxtyBHeE1VKwq
         CnOw==
X-Gm-Message-State: AOJu0YxgfwwAA6ZkVnIVcplgdChtD8vPU4CY9kxCJbTD3I5Bm0yQg42C
	/hfolA8CjVnLZhsrhyF9YStRts4Qlris6yvuqTvBKpfA+rPDEMTm6OlS/DWY1O4=
X-Google-Smtp-Source: AGHT+IFfFifVuDoC8ZpLZK8GbkHgIQ6Eq8QdAsqZZeVwfpcJiFPwxiW7FgdUdc1ubXXAiM9m4UNaWw==
X-Received: by 2002:a17:907:1c22:b0:a8d:cef:bdd with SMTP id a640c23a62f3a-a8d0cef18a5mr917433966b.10.1725871830117;
        Mon, 09 Sep 2024 01:50:30 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:105f:6dd9:35c9:a9e8? ([2001:67c:2fbc:1:105f:6dd9:35c9:a9e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd51f84sm2701149a12.41.2024.09.09.01.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:50:29 -0700 (PDT)
Message-ID: <a9470269-799e-4449-ad62-f6550bc8704a@openvpn.net>
Date: Mon, 9 Sep 2024 10:52:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 19/25] ovpn: add support for peer floating
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-20-antonio@openvpn.net> <ZtmAFX2ryse1p5jr@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtmAFX2ryse1p5jr@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2024 11:55, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:59 +0200, Antonio Quartulli wrote:
>> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
> [...]
>> +
>> +	netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__,
>> +		   peer->id, &ss);
>> +	ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
>> +				 local_ip);
>> +
>> +	spin_lock_bh(&peer->ovpn->peers->lock_by_transp_addr);
> 
> ovpn->peers in only set in MP mode, is there something preventing us
> getting here in P2P mode? I think we need a mode==MP check around the
> rehash.  (I just took a look at other uses of ovpn->peers and there
> are obvious mode == MP checks before all of them except this one)
> 
> I guess this would only happen in P2P mode if the server changes IP,
> so it doesn't really occur in practice?

Good point. Technically this is still possible (a server may change IP 
or we may be connected against another P2P host that changes IP), 
therefore we should not prevent float from working properly in P2P.

I will fix this in the next version.

Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.

