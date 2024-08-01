Return-Path: <netdev+bounces-114984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D4944D82
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C111C24105
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481E1A3BC2;
	Thu,  1 Aug 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh7WS+Oo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE6184549
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520490; cv=none; b=C1eLEAFUnj2cbQj40Xopypg3EweIYsC4dysZXD+X9f3G27qhxI4OCkcMWzbNdRUDucCDbHxtVkVu3OUcf4eBxR41CaJ7hRRowBhn0xWflx2oqlApBbG/JOUqIboGuqIWgRgyKXaIQzzNvSl8dYLqvn001l7N6SPlX1ZyM9bf0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520490; c=relaxed/simple;
	bh=IPqMQmrx1o4+5JAej12udIXwU9ZskyAekdwuNHiC5xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKw7glxPjQizBwbBq4p90wYt7WjJmvUIzPlMzN3DYVeQ3pHEnHlFizEmbz2SNqGZqYskCUctUt4UU7qMLKVsqz8lexKzbo8c/KN5PZPZfmVGlc+tTMGDxWcFgKe4wt/ieNxE1uXnFKRA69/qAjQDpPj+yyI0e2z2k+Y2O7hRomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dh7WS+Oo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722520488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZURuYWxniX4LIaWq38giCOp7/XoDP7loQAsH838DezA=;
	b=Dh7WS+OoDOFmcbB9+tlvA1zv4MoGplQ9cEFrGaHhyiOLYzSc4/4bKcfS1gRDFBtPEC2Kl7
	S54dZAWyKl+WdFfrmJ56lNZFAvtHgY3O/foHsQc9Ps9ozjaE7hzFyNKZkc2WVg1B8sqSzQ
	LFgjw5zFnaiUNSQUYufJ8BECvsY1yB0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-mRhqPas3NnGxJ2IY0LFliA-1; Thu, 01 Aug 2024 09:54:47 -0400
X-MC-Unique: mRhqPas3NnGxJ2IY0LFliA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef298e35e1so5022541fa.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520485; x=1723125285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZURuYWxniX4LIaWq38giCOp7/XoDP7loQAsH838DezA=;
        b=RiB2S1645lurnph+4hMperaNz5HPFa8Jv0+r6hXzBd1yGjehTWw7VM7sfLDBtLu7Py
         FNd1QvprhCZgu9uCmzuwM2t24rjoqxbep9FICZtoHA5oHjGwYAbewAJvAYY2UCOhpRmi
         e9xmuAcpJnvu5QDC0+X1G+tPZGp5T2FqlWM+uj/fB/QTa3NEQEOWjM2vpAhHOITlbDpB
         CxRpAhP4wdvdwU2Fxv/EcLmWsPNEgpcZWvFDoOsfPEyoSQKD97F29u1YLnsiwxYTWZAM
         lGzDicVtkRR0Qmdn2U/4F/hTNRBBrDdU4J21O1uhert9Chi9RgtIGGKMrDQnp0IwXwAQ
         Nuyw==
X-Gm-Message-State: AOJu0YwIgYnxMuIMWC0oDOd/LR/RYRPmFB4XICCIfBpM0K5mAdoZWft8
	DdZQhAA6b9v3BSNCh6gxfT4uJCNTpykjAUeRVnVJK4EPzXdhNFBItUMt0e2xoy058TTJnTdb4P6
	H1uG9i1n2u8eQb16lt9j0ei2D7GLbmJI9Dd7WbyPjUBuU1IS/Ps4HMw==
X-Received: by 2002:a05:651c:104a:b0:2f0:198e:cf8b with SMTP id 38308e7fff4ca-2f15aafbcf0mr1567261fa.4.1722520485302;
        Thu, 01 Aug 2024 06:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQSjeSndcAwinsbF3OMmg2hwmlAVK5gF10xPBSFfaovksq4NG528fJ37qQL3IXgEIpcxW46g==
X-Received: by 2002:a05:651c:104a:b0:2f0:198e:cf8b with SMTP id 38308e7fff4ca-2f15aafbcf0mr1567101fa.4.1722520484717;
        Thu, 01 Aug 2024 06:54:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b5fbb25sm59563075e9.0.2024.08.01.06.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 06:54:44 -0700 (PDT)
Message-ID: <62ae3755-f51d-4953-928f-ff2faf7cea72@redhat.com>
Date: Thu, 1 Aug 2024 15:54:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: eliminate ndisc_ops_is_useropt()
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 =?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kgLyDlkInol6Toi7HmmI4=?=
 <yoshfuji@linux-ipv6.org>
References: <20240730003010.156977-1-maze@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240730003010.156977-1-maze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 02:30, Maciej Żenczykowski wrote:
> as it doesn't seem to offer anything of value.
> 
> There's only 1 trivial user:
>    int lowpan_ndisc_is_useropt(u8 nd_opt_type) {
>      return nd_opt_type == ND_OPT_6CO;
>    }
> 
> but there's no harm to always treating that as
> a useropt...

AFAICS there will be an user-visible difference, as the user-space could 
start receiving "unexpected" notification for such opt even when the 
kernel is built with CONFIG_6LOWPAN=n.

The user-space should ignore unknown/unexpected notification,so it 
should be safe, but I'm a bit unsettled by the many 'should' ;)

Cheers,

Paolo


