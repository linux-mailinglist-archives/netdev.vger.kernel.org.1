Return-Path: <netdev+bounces-73722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30F585E035
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535931F22F79
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EBD7FBA2;
	Wed, 21 Feb 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhBpRPBp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C97FBA0
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526934; cv=none; b=iD+xvW2OrE1eOyK/PrInh7FF8cbUBoL07nsrozWGblJLV5+7MqSwSV5GIV1QJX19QBZSkFioC6iHYZWaT6ZVKnPhqhA5EhKHWHS6z3kxf2TR0pnDMv3+U0RSniPZdQfb+0kDhxpctOGJW+nH37zplVhWkjM5rF5Xz06MxVcF+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526934; c=relaxed/simple;
	bh=gOTD+KKWRxWSAwHO+4bRhi73I30/f1TI2Yd+ByEZBe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MVLSVW3Z7rZrQvK3hF1XVbDHBZ/YsFF5hxdTDfJ4r0zfSmbhAGQIdCjhazptz7DCUPy24yD+WqOvnlTxvxIV3fgPnMpNvKmiVyHBevozZL9BM4IUpyDom58Z0vkOkIKedCmO5DiyyLW+IgRxfXP9IiPiSbR/ZGy6CQku2yXfkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhBpRPBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708526932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOTD+KKWRxWSAwHO+4bRhi73I30/f1TI2Yd+ByEZBe0=;
	b=IhBpRPBpvS2g1wIbdzTC9q5yztNuu/8XyLFH/IkxQZKlIlzAeTExKodS/NYFKoFgP7NMzN
	bnO0XG+jYU1gCnntoquRkCtLCc8fI9KF7MWIy4/OZzWkRYVNcsDu0EM5uYktg6vyUuAo37
	PjAJphS+NBmewI7LpBCBmmI1UL8l13g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-CDl7OQugOZKBqGE5y0zXVg-1; Wed, 21 Feb 2024 09:48:50 -0500
X-MC-Unique: CDl7OQugOZKBqGE5y0zXVg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3ed504b0a9so159862366b.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 06:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526930; x=1709131730;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOTD+KKWRxWSAwHO+4bRhi73I30/f1TI2Yd+ByEZBe0=;
        b=bwiYwyc7Brz7axt8Z5JfHcsYWpikwWScDA5RfFO436Xg3mG7rOaeRh/ax7e2MU0D7c
         gsx4NPfUSrLw2WHPOEi+ZKsVXmMRiJUlNvrFc/fNGCqhtd5a4M+qBTsYJdp7/OreAGzk
         IhBe64Be8BD8AiOeUHrLwtj5hwROIu1cmVRjXqX1W/wZ5e38XaBiSkwvcJPnxR0hHap4
         fEGyMlKEfAIc3R2OKc4RxB+UiErrGi5BdHGKM5fZWEIOCH7tFt3lUkkXqe4t2gW+tKUX
         jctIYIuLakLM9MchtoryAPZF6jWEmhjCscQ5OSupgtpxeeCtqxJxbXqIt9OptcPcYV0B
         Gr6w==
X-Forwarded-Encrypted: i=1; AJvYcCWpdX8HJiODgzAsPfIDPeI3FB5DO9rXH2FLvBWWqtb8ZZM0UhCi2nNf8ibGT/W9sCV0eJ29Mhx0ttzzTGU7wzS+nwOnGnXo
X-Gm-Message-State: AOJu0Yyjg/cZHoGtkxAoF+ZhGVvFlFdIPurx1S/aN4nKcezNRJ0Cm4Be
	N1AKcp1eZCQCuAlKQtGnBln39gGjIfL0rOWmFYYjJcWgLoX6yf7o6zlzsSBHSdyoIDTukWqwX3U
	+0FUlK/QTKM7XYBp+vg60xP4QAZE894cArvFTvcNKxjIAoAciUHPJJg==
X-Received: by 2002:a17:906:c9c6:b0:a3e:272e:7b98 with SMTP id hk6-20020a170906c9c600b00a3e272e7b98mr7573919ejb.40.1708526929761;
        Wed, 21 Feb 2024 06:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG82Opb+cFDAfYT6H0h3uOKz3esKxcunes5mY2+eJEBxnlbQm9TjvlUm8DfSoW7K+viDtxo0g==
X-Received: by 2002:a17:906:c9c6:b0:a3e:272e:7b98 with SMTP id hk6-20020a170906c9c600b00a3e272e7b98mr7573909ejb.40.1708526929477;
        Wed, 21 Feb 2024 06:48:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a3f2bf468b9sm852539ejc.173.2024.02.21.06.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:48:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B401310F6582; Wed, 21 Feb 2024 15:48:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
In-Reply-To: <20240220210342.40267-3-toke@redhat.com>
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 21 Feb 2024 15:48:48 +0100
Message-ID: <87sf1lzxdb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> The cookie is a random 128-bit value, which means the probability that
> we will get accidental collisions (which would lead to recycling the
> wrong page values and reading garbage) is on the order of 2^-128. This
> is in the "won't happen before the heat death of the universe" range, so
> this marking is safe for the intended usage.

Alright, got a second opinion on this from someone better at security
than me; I'll go try out some different ideas :)

pw-bot: changes-requested


