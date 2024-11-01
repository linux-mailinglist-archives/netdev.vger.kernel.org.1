Return-Path: <netdev+bounces-141017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB2C9B91D4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB1C1C24C46
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03091EB2E;
	Fri,  1 Nov 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzrYi3js"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B5179A7
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467097; cv=none; b=iS2KbS1hN7E6TyNDKNqJxJVTD6moExDC1SjeC9wSsO7cFtzB1iImmduL4r0XV9waHbPon3tkYzHX70o373zqBJ2J3LAAEqsZZVNSG4HWqVxH+ITVqmzKOyaDN+Iy0MCNFP9FWdk3yHBXXPoysAwB3m1JEuGDn87agQGNyEMMWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467097; c=relaxed/simple;
	bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rs+ZdoAmdzHDnpFfBqGKVLziX6dFpTVgzcmW/aIfera3NdpKi9dRNXU+g8yBFAVQFY20HRzg/mS9lanl/QseWPflbtWY9xTecxB0ZwoblgNvJsJ1K1IOOzT3HWQpbzH4kzq5wew7SRZTC0+n7JzyPcAo9RaZT6Eq7cmSruCGGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzrYi3js; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730467094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
	b=RzrYi3jsuXPwoegKawnGebXaqjAggeMb+dbftmhh+1U8jfFb3rQLWzLTwmOHhQjazOm5F+
	5A6yTDuAMLU8eTLLPbw0etWkmkwBdrZrVXZUG7QZD4+XJU2u/WqK3IE3cBPynUY1o4tmGb
	MkYofFn85d5B78o7brLoOSoVHnxTXcQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-hnhZPSUeMwuEogxh6Z41sg-1; Fri, 01 Nov 2024 09:18:13 -0400
X-MC-Unique: hnhZPSUeMwuEogxh6Z41sg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539e0fa6f3dso1650325e87.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467092; x=1731071892;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
        b=GyFg7UPHD/nB84MIJt4JcyuNENDBwQSxIncQPyp+PGrQNh0TXimJfOtSFsHrmLVa6B
         nh7idJo1tHoJQSR8DARE9h7k2Ei8+BhnV8uJTheAvkR9RQNabbXX33lp70ArVYJump5+
         lJu9IoyLYJTDLbmMEmheejf3Wl9dU5bou/1MUu7tmG0GJGH7fIOqSS1R+0TIPVcTzAOa
         daOoa9ITwuIz5XBysG8vpAX+Yodp4XzKIAxgW/fpuH+EZXzkK8FUsGByXSbVHJW/IleM
         /QhVOzWorc3zvhT4sNpD9N6NN5m0LSJHbZXiubm4JZFbt9wy9BhUDVl8/PUjv2yBwnXP
         Psow==
X-Forwarded-Encrypted: i=1; AJvYcCVuOIvebcrY+YeDTsIcCZ8sHjaX7pghpL3XzPEWYmGwfnoz6/zLRKqUgH5pKGnowMzX8ZhuoxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsZw5omTjEeF+JKTYIIy5mzkMx5Xr98ogD+R6HoNRqH/t0GG2
	+aCu+kNC3pAu7tSV3JgnEwcWvb6Bz4MA53IdG6O7sjb5x2Qm8ihO+YTiShngFW/5EnwPad0cjGM
	nVDTHSzOhv/vPCkPCc+RynlDIuQWF3YFpK53MvozWDdjy2qPj1vLWWg==
X-Received: by 2002:a05:6512:2243:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53d65e0a8d4mr3212617e87.41.1730467091610;
        Fri, 01 Nov 2024 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJNVGRmbx39lG0hrP6GbSN+xYWdg5dI0TkiCnLiw1oNape2uMbIqGq3hW8ch9y34gU6zJIuQ==
X-Received: by 2002:a05:6512:2243:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53d65e0a8d4mr3212579e87.41.1730467091191;
        Fri, 01 Nov 2024 06:18:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56681a03sm177661866b.197.2024.11.01.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:18:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A10EE164B96A; Fri, 01 Nov 2024 14:18:04 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/18] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <20241030165201.442301-13-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-13-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:18:04 +0100
Message-ID: <87frob9joz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> There's __xdp_build_skb_from_frame() already, so just convert it to take
> &xdp_buff instead, while making the original one a wrapper.

This does not seem to be what the patch actually does? :)

-Toke


