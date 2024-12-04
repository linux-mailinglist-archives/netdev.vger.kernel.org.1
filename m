Return-Path: <netdev+bounces-148930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2A9E37DF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397882809A6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34233187555;
	Wed,  4 Dec 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB7E5aLB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04E1AC88B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309419; cv=none; b=mSjEfWCo90bW5H2xUeVN44odW7LkcJhzqiMQqG+jvPKL7ak8FVPLaWy5GNYfjlHhZUO6+WJwS8H4PqJHxXmz+8e8r2bfj65sO/07esrq8fVxyuF0532hDGZzspcqU1imrMvZap53VEK6/8ISQzNQsC4wAZvCs+JfmGEOlq1TK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309419; c=relaxed/simple;
	bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WTgivnopc5LLOP1/sCMpJg/h+ESCljecSKz95xElMNn10EfOVk/0LLraAwPsx+Yb8I6JlhpKsJycUAxj5Qx4Pe3cORxlpM+CMIvAq1SZGY+X1zqC4+Wd6WNMsiIH9K23AB0lu9G7nI+sX1s024tIaH+jWbCQ3IeP4WgRIPDu79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB7E5aLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733309416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
	b=KB7E5aLBHCgKZ3EpzCB0MaC385AS7BbH7BQDPDAcssAqALFvp96GjBXUYSXq6WMa1bdQOA
	JfjldVgQaXsYWP7Yb7hvkPzv9vj6VY/W3DBCDZk3fFdEIb1bwulnXH+XzbXJ3mv45ta2dM
	+6jWQ/5w/deqLhY4Qg/Xf0BlJ2gAXpg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-3ziiAD2yPx2Wn9OqqLJohw-1; Wed, 04 Dec 2024 05:50:15 -0500
X-MC-Unique: 3ziiAD2yPx2Wn9OqqLJohw-1
X-Mimecast-MFC-AGG-ID: 3ziiAD2yPx2Wn9OqqLJohw
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ff13df3759so46533031fa.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 02:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309414; x=1733914214;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
        b=k2t63G52SyK4E8CmTBbzEQmKrP3Zu8CwFCa+75xZD8oLBbKd/wRi//pVHua5gDStNM
         xxQq4Xf6xkPRX4g1Ogp0zpQBKynJTqLlHjX77lLfMwmSo35z6ovN443lw0icaHf5cIRM
         tuLKA0o2wXDf0+ihjQjTBB57qvaSljHiz3lWNsZxcD9B/+fLJhlbJ3yTwmSYVRYhIUu/
         h1vyHWHMhuFJ2oQGjF+RujCi14M94IzhMdxzdvHw7krhK6O5mnL6LYP+hWDzdidetjQd
         /qoWPe5QhbvOfquQVtveRJIrU2vNrH21GOP7sPPoeN/BP2KCZ/v5VysH4VLIG6Sj0vSX
         wH7A==
X-Forwarded-Encrypted: i=1; AJvYcCWcwqz7eAVDixrbtjOHV+Ka2KsqdcCmBqJRRVTGpYEgv4GpLDkRUpdaIxSGutwaSuY+CpYSLI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjc6MRrwGppMaAkp9x+3eLUt+SggJsellotU8/kayDBEHT0XOE
	hmWHF27DLzt91waMpzy2GVvKV1urWhaLlRrPmpEwjWLZGwozpAvrNF8u8aqoDdI6Jin/8aWYv6e
	6MR7LVQ9EM5XxL2ha7ZzGTgORKXddzk9snI4+lCqBGk61mRBrQOiMDw==
X-Gm-Gg: ASbGncsEiRFjpPLW31w5wc/QFEdKckGk6UdhETY4RJXDOIM8FUlDIsbkyO/pEoOxIko
	IjRn5v5BjFIjNmLyU61IzFvRm11jJNYxD83VSnPEdfNoQvPYx+NXGTCNDb90W4j8QuSE8qr5Wl8
	MgHRfTWIZRnNsgACzr7NbpnbQGc/kWRHGC5MfwX9Kx5OJrZg5N6tqK/B2E65YMA9+9ICUvO1mU/
	F7YMdfH8eTc4Ql54f8goAaAHkN74Lg4hLJOwqLmomc9OXo=
X-Received: by 2002:a2e:a58e:0:b0:2ff:d7e8:bbbc with SMTP id 38308e7fff4ca-30009ce0bacmr53657441fa.27.1733309413919;
        Wed, 04 Dec 2024 02:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfxB9/ZapzifOSM+BxHGW3corqQgL/f1b34L8O3QJCLkSmKjBpOXgMxOQShubXYhGxcR45sA==
X-Received: by 2002:a2e:a58e:0:b0:2ff:d7e8:bbbc with SMTP id 38308e7fff4ca-30009ce0bacmr53657081fa.27.1733309413497;
        Wed, 04 Dec 2024 02:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599973202sm712069266b.198.2024.12.04.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:50:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F2BBA16BD10E; Wed, 04 Dec 2024 11:50:11 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/10] page_pool: make
 page_pool_put_page_bulk() handle array of netmems
In-Reply-To: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:50:11 +0100
Message-ID: <87r06nafj0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back. Moreover, data pointers
> assume every frag is placed in the host memory, making this function
> non-universal.
> Make page_pool_put_page_bulk() handle array of netmems. Pass frag
> netmems directly and use virt_to_netmem() when freeing xdpf->data,
> so that the PP core will then get the compound netmem and take care
> of the rest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


