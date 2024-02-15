Return-Path: <netdev+bounces-72126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC8856A88
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D11C244F3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D913666B;
	Thu, 15 Feb 2024 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP27NZ/D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DC134CD2
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016810; cv=none; b=hj0zmMNaBYqERyz+EXqEiWPdU90Hqazyus6lQz29JLRJV0h9EGxC3ES7JT22bIOW2H10mnm/m8sp4voyOBFTzLRSvRQJ1gtZh9iDjn2n55Nk0BdQf/0WmlmQeNdIIaopMWMotx9nj096+v8+E+JlgQa10U3Pd9N5EjfLQ6qBLZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016810; c=relaxed/simple;
	bh=Oohyt/Kae1e5gRYIF9NLQ7YLqCxNFhcjgVEBij6/e6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pgb0q2kZ0WIfxam/qhN4Ac+Q33klGkZXKPtMpRxsy6kmtMwwxqn/wajYilACdSXWI49rU94uI5HxevkBd7MQQhXArDndtCKpkjBU4NE8FdrIe20w7TJNPxsXqpX4AEskCpd1cYjQ3DVX1MBbvS5VC/UKNDfS7JU6WaDYX6bES2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP27NZ/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708016807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oohyt/Kae1e5gRYIF9NLQ7YLqCxNFhcjgVEBij6/e6o=;
	b=IP27NZ/DWxquhK9vM5tg2JtZQunqHygRTmgY5wVlS6enqTQpREX4aZzOQ2lj9Ngq8lP3yP
	ATsEvlU8Le+u7GJPJRCXDodH4frT1IYOWik7THwIESBjRc3tRW3FDn7GiZ2ph3CbDA5ynh
	17BIOu8g0zYqOa/2gfis5+JtU9SzzFQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-0MYJllunOSOyg-5jH5ztBA-1; Thu, 15 Feb 2024 12:06:46 -0500
X-MC-Unique: 0MYJllunOSOyg-5jH5ztBA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a27eddc1c27so68013566b.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708016805; x=1708621605;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oohyt/Kae1e5gRYIF9NLQ7YLqCxNFhcjgVEBij6/e6o=;
        b=vgCRoj4bGupz+yIlrMBZr+D625W43X8Jg4JzeXwenmubPrt84vcdpM8d8eYyKnkAbC
         olGXdzQ6Hj8kHdYNQW+t0Rskr1yDRXuwd07pSEh+xabTq3ETUI1ASEVx0KH3LHJ6Wcm3
         eiC/eaSqsAbtvcxOrR4tWHHNOEoQE2RF01VUIcAbHk+yeAPpSjwLoD4JHLwr2ahepn8E
         cavNbPplgQeIWKZINKhq90aCKcGApeT8+kaiGN5Te/dCWb53dGYpG230hfajk/q6p6ND
         x6oF9cm1EQunxlSRwSl6ZT0rimCFmEFQOOUWAYHnBGbayoMg9xbsRhouiyExloRqVqPA
         GitQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAapB3sWqbzR4flwNL2aJAddV9/XXaYDnvsL32yO76yNiBPXVymjb2JSHWyDoyiCHpof02kPl/nHe2f9sYh7b7sgvfcJk0
X-Gm-Message-State: AOJu0YxqFQxegjgXyGIfsAIB/LyC1Ua+FhDwmSANJZBZ2ZDALv2G6j+t
	smqoUE2HLaajoqm+hi4QjnINGhHeJPM7U/mB4dBYiAiXg6yXqOPXstD6buUAeAUMs83J1fUw5pK
	x6U+PaH0kT7VoxwfBHKssJTiGEIX2LjZKV06Rn4Odt5zNQCQccTxKWg==
X-Received: by 2002:a17:906:37d6:b0:a3c:1402:e042 with SMTP id o22-20020a17090637d600b00a3c1402e042mr1675587ejc.37.1708016804937;
        Thu, 15 Feb 2024 09:06:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFnRGJwsFRzPcE9ndm5F3JneRXTWoFUDIFbUsJ0lF1cvTV9AY1qVnp1Uxgqqubhtq4y8Owjw==
X-Received: by 2002:a17:906:37d6:b0:a3c:1402:e042 with SMTP id o22-20020a17090637d600b00a3c1402e042mr1675564ejc.37.1708016804663;
        Thu, 15 Feb 2024 09:06:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id mb24-20020a170906eb1800b00a3d65399a4esm756254ejb.177.2024.02.15.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:06:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C20F510F59FE; Thu, 15 Feb 2024 18:06:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <4a1ef449-5189-4788-ae51-3d1c4a09d3a2@intel.com>
References: <20240215132634.474055-1-toke@redhat.com>
 <4a1ef449-5189-4788-ae51-3d1c4a09d3a2@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 18:06:42 +0100
Message-ID: <87mss1d5ct.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Thu, 15 Feb 2024 14:26:29 +0100
>
>> Now that we have a system-wide page pool, we can use that for the live
>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>> avoid the cost of creating a separate page pool instance for each
>> syscall invocation. See the individual patches for more details.
>
> Tested xdp-trafficgen on my development tree[0], no regressions from the
> net-next with my patch which increases live frames PP size.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Great, thanks for taking it for a spin! :)

-Toke


