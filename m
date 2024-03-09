Return-Path: <netdev+bounces-78971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989978771FF
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 16:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39362B20FC7
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7D446B3;
	Sat,  9 Mar 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrLTnH+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319844391
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709998921; cv=none; b=GDSGFtqZVbvCPWZl428l26xLdJybPO1N9FU19qUfSYZmHm2s7pdOryq5pbT5oW72HucKrSqNBB3OsCKPyKBd6OUFTZip6PxbAfMZ6iAqN5qVU9W7aaffsAeVcJpaEzdQqABB2nOx9t5ym5/3vpqrHhg4U6AMYWU7u55LmqHASs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709998921; c=relaxed/simple;
	bh=lgwpTNi1M3yVskswaglSg5hLDE71jPPK741kQGr7/SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGbdrhuHuq03oemai5pxxwrZgb5bJJdprrY5oOM7UwfcdI8CMTV/YDKgE0MutKUDon6gDSB/wBL+f+5B4sChyNf6JVIgx3opUtIDF3TxyzbZdIy7kgQG4eV7EPKdw+s/hB2K9smdEUkWrDwlkJdhgwC8qn0q+kb/VKtM4Hn1Vbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mrLTnH+h; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5682df7917eso8060a12.0
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709998918; x=1710603718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkDsUMSZYlTGnFq8L8u1MCZSuc7DRjwYv05YSVPzzQs=;
        b=mrLTnH+h/N6GRDiJvOJL72/FEFTtqWG/1a+jry6zxfXlDRsOZ+xrBxpkoUT1RxXHy6
         V7kIuUP0iXn+dFs4geLRYH/J6SlPL4BXNPvw1BvHg/M/SNGvU99xsvxi/QymhEgtxj7p
         4Q41RyntcpusFYdX/CBCDO1RoO/EPrnpRFYfrGh4oWCYiqNkdBl+tQ0DcZg5vdNjpBK+
         9S8gpIgwMzVKUE/W82e3E6c25ogxUgFOZGxNoxp8rq3pcoUg7lKdZ9Wqaa1Qo72l0kKD
         49gkk8Ezc7CcBFiKqQNga+TnIWmPO4Qceo6xJIuCrPF6yn0gRxcqXSUisUtr357M7UHZ
         bW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709998918; x=1710603718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkDsUMSZYlTGnFq8L8u1MCZSuc7DRjwYv05YSVPzzQs=;
        b=tddVC2wzDXQ9TH0Yo9bd3DeXcv6QxQQZquH4MfF6w6mONZMcsnWI07mrhq1eTTA7LQ
         yIdgZ4wP48Mpvwnc8zr1fxg84Zatg1IkMwnnON3EQqnzCJKiuDOaHqQMELg5MTNK72wF
         y7O8AEzl90I93ZaTMd3kF9DMt8V/C3C+6d7fnGvXXKK4f3xeTjc1vvSm/RNnAXe4kZq2
         AmpJm57BOSVhLwPmrtiqTgrCPzsmhtZfd5hXjAmp1k0cl0j5Ox4p5JpzpCZ9OLSq3KaK
         jwBqbzMAaNZjBCuKN1AXQQfmhbWJqAeBiHN7S4sJMyAybZ0Qdu2bp8PCMvAR1EmDgQ5Z
         il+w==
X-Forwarded-Encrypted: i=1; AJvYcCXz9eTvkCg7ZBpwR31Mg4F2wv8zQNxJ00K/PIM/OIe3hE/F15e2OkLIlPOJ9/7dGlyv2frFEW8iZ4mHejLRb1TqAn2lsJ/m
X-Gm-Message-State: AOJu0Yz8pJXEimeAic6bU3U8agC+oEwijFKmBNu+YcjlZmo9XmfpQDre
	6bAgQ78hT7b/0EOQpsPITLxSjw1WUB/y6tB/QqMbq2KTJOBMKChOhDZiiUa+jcQG2QqGX+dglt3
	jA1PtMvZdx8Km37OAecPuTg3p+RDbsWE8fJBE
X-Google-Smtp-Source: AGHT+IFPsTXjqJ8K9UyJJZ2xhpe/CdWpMxGY3SffBXmKELvxZlkX7xMtkQZqbztu95EV/lRThefqSgEfRLV/1omhcSI=
X-Received: by 2002:a05:6402:1b06:b0:568:3c0c:1755 with SMTP id
 by6-20020a0564021b0600b005683c0c1755mr84512edb.6.1709998917765; Sat, 09 Mar
 2024 07:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com> <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
In-Reply-To: <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 Mar 2024 16:41:46 +0100
Message-ID: <CANn89iK5+wqYdqMt_Rg3+jO+Xf4n4yO4kOK0kzNdqh99qgL3iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru, 
	shuah@kernel.org, idosch@nvidia.com, razor@blackwall.org, amcohen@nvidia.com, 
	petrm@nvidia.com, jbenc@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	gavinl@nvidia.com, liujian56@huawei.com, horms@kernel.org, 
	linyunsheng@huawei.com, therbert@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 4:35=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are
> relevant only to tcp flows, and as such they're used to determine whether
> the packets can be merged later in tcp_gro_receive.
>
> These checks are not relevant to UDP packets.

I do not think this claim is true.

Incoming packets  ->  GRO -> GSO -> forwarded packets

The {GRO,GSO} step must be transparent, GRO is not LRO.

