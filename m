Return-Path: <netdev+bounces-159279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3AA14F78
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842FF1683C3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180A1FF1DB;
	Fri, 17 Jan 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1YpcHP5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683251FF1BC
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117825; cv=none; b=YuOug/Ew6FmgB2OeC4xns9gcX42O/TuqDIVmBPGO+PeXw8UJJBCFQ6xQKt887h+7SCpyWHncxK1CgpC4MaUVep/S4Ptg85zLH++78wZbyEEgTj5MofrVRvEvyJEDBchozHl5uivUiojxegV9Kwc5OivsM2Lkk6lc+07EQrVyf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117825; c=relaxed/simple;
	bh=cd54XL3aliFy0NpAyf3XBTHTvds4Rpx46S1hRQhFiU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bIS9YLx61l+FrjvX+4qO1Jb0NUFFjkAQhVz31U1MHW/IOmUX14YfINn4XJt797J3Irf36/CLV+EsfaLCzw43Ozn0tcu8Kv4vf7XMvb7dLbyAVeJXcMOKmPADqP6hvdOG82VfAU2fC9YddA4JHaGkoWlUl/uEODMwHKOMMxFDJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1YpcHP5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737117822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cob0lF5N6/+utp7g7nFV/A1Rwu4ms+yA3+XLT1WVBjE=;
	b=R1YpcHP59Zkfxwk2NTHVo3YYLHinmPxt3nsYP6GrMtlkPJkQaUJYOqBzwFrl+BjhUgG4dA
	v49cLvZxLcafQ3CoibRIRl4q3SayMWAjppYswwYN/8ZrtYBWomLm2IHdZ9aK5Dxfoc57xD
	asK9wSctrRb2GinHARjEQAJU2RhAB2E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-NQBw8Sb0M_m2HtiDSJqryQ-1; Fri, 17 Jan 2025 07:43:40 -0500
X-MC-Unique: NQBw8Sb0M_m2HtiDSJqryQ-1
X-Mimecast-MFC-AGG-ID: NQBw8Sb0M_m2HtiDSJqryQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa67f03ca86so194063866b.2
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117819; x=1737722619;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cob0lF5N6/+utp7g7nFV/A1Rwu4ms+yA3+XLT1WVBjE=;
        b=wAqyno19kq5YAoU2gk5XhgFRhNlhcEKkfOpG4zTcN/EmSa2gTCIRupvN2MupLxs9Ps
         Y1jt39pMlTOvZezafmF+SmeD9AABio80tdzxBvgpHFUyuGJxf032j8AMFlzKADLqb5pi
         wfjtigwZorvnWU/rjrXNJx8D+ZP7EvJCIaDCopevZuw25zMRnElTew8skemGPigWk5dC
         /zGeL/BrNrfNYlfS6S1DKbHpOtPxa3vSaj3997ucvVpmtPOgtGRhPuvd2Pr7AA3b6vpL
         f6AnlrYRpZhO0AwK/worak6e3r+/jJxTHyuWqXDTAQ4PEWfod8G2PpB3eu1EGGmYC5xo
         3g3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOkoIFyMGmMlY3lW+w74ZSEl7t9pxAiRcahFk71dzzYHoSlRMxmsoW2nBMXcFs8QUswGt3INE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJGKaVdnR7t7e43pHpDwNtpaEG5XyMrEJBJOZn7sGSRF8hV/T
	5a5xyt7adAk3ZZ+Qg5M/X2kbOqDUt0wFkEQkTaLhg37tU+7T5Kiw1eoRKq1aj8J8uL7MdQq/BqR
	F6/tMW8v5R3yIoP+aDRqU+fJiEiGwGdcJN7zywRIMclErH/v8XS/9/A==
X-Gm-Gg: ASbGncuHpCQRg9QIrQyAjcxppB8uC1jWh1LxZPsRyqtzDpWc1XlbE99pHDPvUGFYcuR
	kXiuViP2v1Hz9gcL9TU6ITSk+goFwVr2/i8Mw7fOXLIaioBxBoiEQ7+T2+GEhm13BLgxA9F70JC
	CG9ATSvRv9OmXWH+NHopoG/Bp29OODUdyBV7Xy502YASi/17r0GLARgTmR9KEuBd5jj+NUsoxtF
	EZprROZ/RhCVRik2axH9p7EUttfrdAhEE3P2Hj4zwyFILb/gZIwWcTwdxu+rPoSHIt3uyx7y0TU
	d2Ip6IC18J8FHko3zJY=
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5db7db078c2mr5461818a12.24.1737117819432;
        Fri, 17 Jan 2025 04:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExD7igQimPr+aQ0ED+vHaFPU0l3YZshIqVzmzRJdN8CGUD9UBkdkZfSFMOOMOsnPZQQHv4Sw==
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5db7db078c2mr5461773a12.24.1737117818999;
        Fri, 17 Jan 2025 04:43:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edc8b7sm1400986a12.76.2025.01.17.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:43:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BFCCD17E7866; Fri, 17 Jan 2025 13:43:36 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/8] net: gro: decouple GRO from the NAPI layer
In-Reply-To: <20250115151901.2063909-2-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-2-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:43:36 +0100
Message-ID: <87ikqdobk7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> In fact, these two are not tied closely to each other. The only
> requirements to GRO are to use it in the BH context and have some
> sane limits on the packet batches, e.g. NAPI has a limit of its
> budget (64/8/etc.).
> Move purely GRO fields into a new tagged group, &gro_node. Embed it
> into &napi_struct and adjust all the references. napi_id doesn't
> really belong to GRO, but:
>
> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>    (u32 napi_id + another 4-byte padding).
> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>    into two functions or add an `if`, as this would be less efficient,
>    but we need it to be NAPI-independent. The current approach doesn't
>    change anything for NAPI-backed GROs; for standalone ones (which
>    are less important currently), the embedded napi_id will be just
>    zero =3D> no-op.
>
> Three Ethernet drivers use napi_gro_flush() not really meant to be
> exported, so move it to <net/gro.h> and add that include there.
> napi_gro_receive() is used in more than 100 drivers, keep it
> in <linux/netdevice.h>.
> This does not make GRO ready to use outside of the NAPI context
> yet.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


