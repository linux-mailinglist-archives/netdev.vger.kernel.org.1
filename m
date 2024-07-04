Return-Path: <netdev+bounces-109163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D29272F3
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2EE1F24155
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799C1AAE27;
	Thu,  4 Jul 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHLex2lZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F160A1AAE07
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085020; cv=none; b=PbfO7bgPhItSkcnFRz5BWBJq++vhCsDUEpIbCglt/C1ulzhVIejX/2rTMS5Pqy9xU9UMUcXqenGqdPHCXuUb4LSMXbQroaGd50jdfYaA9G+Qu+i/DQCmzEWxqHQwQ7ZOc+5oxVwLJaH1yD9dHO02ZkmVZkQnICeDDUaMds8Elxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085020; c=relaxed/simple;
	bh=dEGTWfoKjFlj5C1nKfElD5GiOMdw2Ju6YoUyK5a8BoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k32oSlz+ebI5jkhbUQizpL4c/4ZHGKZ01KwM8Gq1+kIEpCdg2g2YsvZhTmDsjn2nerW+Aun60ztZnlq0Xb2QiYNeqcwB4EHVFnL2jdouvEU3URBRN4cdOZobV6mE1jYY6O/gZPnKpOirIBYK1FsDoxkAIRqi4kllDpTWeXYt0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHLex2lZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720085017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EREf30CB2yfC93XCiBYFFt0mtS7JECc3ORfxXMovnJM=;
	b=AHLex2lZbkuBQ8qfUtIt1xOAhxr5fJLj2dL0qiW8zTWTordQ7Hd3PuPb8AK8CEUDLjZ989
	umfCjRIh10Sw4U6fN2MMh0hWRMtOS3mEMmmQFIYzwNPpzdXqXHbA/kAgF7CebXXKkk5b+p
	BxSNsa1tmS51gOsPJzFzSUk4CJi2eLY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-T-XH_UD7PuWVAxyyfNtPIw-1; Thu, 04 Jul 2024 05:23:36 -0400
X-MC-Unique: T-XH_UD7PuWVAxyyfNtPIw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec5ee395f4so1088471fa.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 02:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720085014; x=1720689814;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EREf30CB2yfC93XCiBYFFt0mtS7JECc3ORfxXMovnJM=;
        b=iUC8RDgKIipG5F6TzhSmCKJAdNKvznuZyk98dlpb1Hnl3j7OP1y+ANh7unuayzB2tc
         QWtiI1FXNXMmqXOtnJ9fRb2ZRA2EgE5OIG2+XvDGbs1fdrvT2SRR7WsQxUwcB/ZeP96h
         4k0o72PlTrG7axr1bPJzo0f7tuwMnxvwhAsk0v48V96O1Epx9Gl57QGqLfNoxsf3OkQk
         qlzERKxJoXf05jAi25RzsLTjBriqsCOIwPQ/SGHURWyKHWJKhRGn8P7vwqNzD3s0EIP2
         Ifcl+h4iTAjFLMwqnEw4GK/LnU+9Qb9WI8O202zHSSH52LACbcshQuPX3SdBv0yBap2J
         8+HA==
X-Forwarded-Encrypted: i=1; AJvYcCXb2SjTYlOGdXt5+XQejvaogBb7T3YK0ofOH1qn0h6OI+kpp8RkSTVnePZ+A/lBajpxaSUd2vF80eby0/Ne7cEm38BeArx+
X-Gm-Message-State: AOJu0Ywuv0uzk7qncCPl04bfZMVmNHS7I8skBVGEZ/jrU4PlEJ9t0pvh
	2U4bMWeezg2T53HI7TEdC620usM7SuW+ZEziesh1WE8LkZyNzgh0j7YEaR+zZusAQzMgsvOrA7L
	AlDT8aj370okAqnnkL7eeu2Ss0BVvZOl4vwpPF+oiogKcp/AhXqHvSnKI6Y79sg==
X-Received: by 2002:a2e:8183:0:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ee8eea1cadmr6815921fa.4.1720085014357;
        Thu, 04 Jul 2024 02:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvzES1PxTyuPmoljfchYrYs0AYiE0uu2HDh4U2teqfChKHv00AvINQ5JjPeK6CG9Kz4ZmUfg==
X-Received: by 2002:a2e:8183:0:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ee8eea1cadmr6815781fa.4.1720085013921;
        Thu, 04 Jul 2024 02:23:33 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172b:1510:dd78:6ccd:a776:5943])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0b19sm16361675e9.10.2024.07.04.02.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:23:33 -0700 (PDT)
Message-ID: <54d30d951eddf0846b88b7f9f73ce16994550bd7.camel@redhat.com>
Subject: Re: [PATCH net 2/2] net: ioam6: mitigate the two reallocations
 problem
From: Paolo Abeni <pabeni@redhat.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2024 11:23:31 +0200
In-Reply-To: <20240702174451.22735-3-justin.iurman@uliege.be>
References: <20240702174451.22735-1-justin.iurman@uliege.be>
	 <20240702174451.22735-3-justin.iurman@uliege.be>
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

On Tue, 2024-07-02 at 19:44 +0200, Justin Iurman wrote:
> @@ -313,6 +316,10 @@ static int ioam6_output(struct net *net, struct sock=
 *sk, struct sk_buff *skb)
> =20
>  	orig_daddr =3D ipv6_hdr(skb)->daddr;
> =20
> +	local_bh_disable();
> +	dst =3D dst_cache_get(&ilwt->cache);
> +	local_bh_enable();
> +
>  	switch (ilwt->mode) {
>  	case IOAM6_IPTUNNEL_MODE_INLINE:

I now see that the way you coded patch 1/2 makes this one easier.

Still I think it's quite doubtful to make the dst cache access
unconditional.

Given the above I suggest to replace the 2 patches with a single one
moving the whole dst_cache logic before the switch statement.

Also this does not address a functional issue, IMHO it's more a
performance improvement, could as well target net-next with no fixes
tag.

WRT seg6 and rpl tunnels, before any patch, I think we first need
confirmation the problem is present there, too.

Thanks,

Paolo


