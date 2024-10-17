Return-Path: <netdev+bounces-136617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D089A257A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA4128341B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F491DE4CB;
	Thu, 17 Oct 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3Y2aQjM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076F1DE2AD
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176450; cv=none; b=nJ8cvNwEznBMv3044QhXvNXCRfT+U43r/vNLJnCIqPjylN13FSw+Xce7L1/osyp5DdUWFIaoBDJk13f+0GHFCL/Q8CReZph2CXgYE0oT8lOMgPVGXzmqDoVJuBxecgXU2w8jn+6e5d/Efnys1XfruOOxJo86oc1sd9xAqd2yGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176450; c=relaxed/simple;
	bh=0leTP5OXAUaKPJCy+G4/PrHXTjS88HZH/ihoHn42EWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ptus9cSGmcLOcumF2dbaoACbMk88f7Td/AJsjom9MYywZUMVYbqBlFq4bADeCeBC1b1EUCWeJvb7HMdPRQZttNFYM4vZ2CS2JlI+0nMY309smhuGY5ggdGYYzYRK+YWlaYPBen7SsyXZ6SWm0cNz7mi6nPrwbhie4lCmMtlCte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3Y2aQjM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729176446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6lboUGx7ijrgViMjC0XLNeJKa/Wh0MpL+jwO9wWqSXs=;
	b=Y3Y2aQjMGXnLSzbsAYCVcypNqtNSHm8PqVbolZ/Ha1D0VOETfZv86JHSMD/qk89Q0r+zSP
	BvcWzLh0tyke4gOkU3lNEiHoNFzd91X+FkjaumVZnmUOp96ZmYtz92Z41q8r4Z1cZ88dFV
	UILW1Z8ZFKhsx9MX86iJR6j+pLgsmtU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-lDiKTDm9NL-6jxPJsDFc6A-1; Thu, 17 Oct 2024 10:47:23 -0400
X-MC-Unique: lDiKTDm9NL-6jxPJsDFc6A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a04210851so54715266b.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176442; x=1729781242;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lboUGx7ijrgViMjC0XLNeJKa/Wh0MpL+jwO9wWqSXs=;
        b=t342+UdtffmW5oTFbU8+MW6vvRkelxaeP/uOom4xJ+02QCZdbxCzqB4sCSLynNnYBF
         KhHdI52WU//Lygj+2fMN2MqaH2Z2SsbmBmB7X6HggavOPP8fbkgYc9/8JYeOQYoGZzkV
         f6P3I44cLVYU11PyinZA2BXcCvlAgGgeNGHlutho+nYAmi8f8YRJGCL8OCpHy9xIqcCB
         34od0sw7PSs5IKom/SSlRXPIxtspVcFKSmjxXTLlqkOXEEZPVXnfPFPg0GoOOA2HQCyF
         i/MokpjaxoziNcIwdFWUwXfBR8+j4ff0M/bNIwpQ5rZu9pyCm2M1PjiU6IhC8B4kiiue
         cFFA==
X-Forwarded-Encrypted: i=1; AJvYcCXub4JVx7Rneo96i4QUwZm/7FAmZXvmPO66algKnXXjluFXXCHn12v9Rk0wlLCqpEML2luQxAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZqLvJmmN+mmZoH7beOUxkSBWyKmx3kY3K4h3YAXZ6wCdMltMQ
	nRgT9DldJ5iC3AxWJgAa1jLt/SNEmBt/n/X1HjwuqhEWUVoU6MdbmczAFXuXPKHkJ8vRo2o27Bx
	mdnvgfy9JArZctSV8+wSgiMx0XsmFYEg5jS7L9B8W54kfQZAAIkLq3w==
X-Received: by 2002:a17:907:c8a8:b0:a99:4b56:cf76 with SMTP id a640c23a62f3a-a9a34dfea2dmr616932766b.47.1729176441873;
        Thu, 17 Oct 2024 07:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8DECNp/sdfcg5mOuDiFFJpXOew2nxBeb2a4vk2UQksCP7zCheHttds1hjqhqehXa9AZoKZQ==
X-Received: by 2002:a17:907:c8a8:b0:a99:4b56:cf76 with SMTP id a640c23a62f3a-a9a34dfea2dmr616930466b.47.1729176441473;
        Thu, 17 Oct 2024 07:47:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c5c0sm303480666b.202.2024.10.17.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:47:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DC19F160AB52; Thu, 17 Oct 2024 16:47:19 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Jussi Maki
 <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Hangbin Liu
 <liuhangbin@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net-next 2/3] bonding: use correct return value
In-Reply-To: <20241017020638.6905-3-liuhangbin@gmail.com>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 17 Oct 2024 16:47:19 +0200
Message-ID: <878qumzszs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> When a slave already has an XDP program loaded, the correct return value
> should be -EEXIST instead of -EOPNOTSUPP.
>
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f0f76b6ac8be..6887a867fe8b 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		if (dev_xdp_prog_count(slave_dev) > 0) {
>  			SLAVE_NL_ERR(dev, slave_dev, extack,
>  				     "Slave has XDP program loaded, please unload before enslaving");
> -			err = -EOPNOTSUPP;
> +			err = -EEXIST;

Hmm, this has been UAPI since kernel 5.15, so can we really change it
now? What's the purpose of changing it, anyway?

-Toke


