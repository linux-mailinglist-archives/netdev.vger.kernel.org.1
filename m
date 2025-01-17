Return-Path: <netdev+bounces-159294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A35A14FCC
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5CC3A905D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C61FF7AD;
	Fri, 17 Jan 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LproePKH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D71FF7DF
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118728; cv=none; b=pJazShsjQeDjVM6xP6Jgh8AYOWgBQLcOSWdmyeZNVXfv5Lz+j8OQyZWsQyAR1tiNI5b9bNoxNhrbBV7TsU99bscRx4dv6c+K+RSdzQIR5cg9YTUzcozj+aF1Mc+VLykno8gfiMkOJ5tgufkDEfzaUvrphzrJtujIqEWw301FJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118728; c=relaxed/simple;
	bh=PlR6BI0pnwGwhH26X/m5utIA1jO/eGa1YHXFOyu++WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mg8ygCsgwIQDZJRbktBJqr96EF8E5ZwSP/KQg8ZNSWpnN2tbVZusm0JEu3YlVogo5omk8TjMmDB0mzeewwWvVgKqb3pZg7qrhuv+yBRiaa+Q8Se6T1GLtBxGZFc6b9OWpDybrXFK+0fBQRini5i+1IJBbnrodJJk+JZEU+NKB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LproePKH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlR6BI0pnwGwhH26X/m5utIA1jO/eGa1YHXFOyu++WE=;
	b=LproePKHCr8qiG3W1OdyD8m/zsaHpk7xnzqPOvYyp9coN5uTe5q6HuFZHUL8KTxVQ8qkx+
	mUDc61R9OYfaSjindiRUm68ufHRoc2bS3HoMRyI73kYm1nxQw62h54TvwHd7WdW/RT/sjU
	bVhLJ+dWlB6Whn++TyBBPwHXRYQObsQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-m31Pdu1RN7KpwZHFH_RKoQ-1; Fri, 17 Jan 2025 07:58:45 -0500
X-MC-Unique: m31Pdu1RN7KpwZHFH_RKoQ-1
X-Mimecast-MFC-AGG-ID: m31Pdu1RN7KpwZHFH_RKoQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa67f18cb95so208550266b.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118724; x=1737723524;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlR6BI0pnwGwhH26X/m5utIA1jO/eGa1YHXFOyu++WE=;
        b=GSQKXHq+X+7Iefl262x+ux0oweIz5sBgy2+vOoa48zhKH85iLfIhsuFo4wZqSgVWRj
         QEE22taohbnygzH5msWw0LJ0dYdlzFQLOYkvvwcV0z8JXcoOgVZK2zVUH4y+52WECbkH
         gIvhvEixM8OV6/hECSrOecqdoQuLX3dPjIBj1qkcDb5zpISsUH2go0oFkPemKVJ/fOuB
         /vPqJX2rSv1iTodg43iSKlPvLBlkg2/zTlKudw7uaFy0GULwkBzxGwOgRdkrSRJSPqNX
         Xr7Z+j8F6agVu9orY06722KyUXozgwMxKeRdptbbaydb9Fo4yN04isIRbfAf0ehr5ix8
         BRYw==
X-Forwarded-Encrypted: i=1; AJvYcCUXST/w9J6xREfLAK97h189YJEAchNtuatedMOGD8rPgsCcq7kdVHrWb64uBzdADHpxG1dCQWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjAvUphk8+4kITJnJ6r+YS3ChodXhMs0PDMEbhgc7DBxPA8n9f
	esMmg9zwCjfX8KqRVRDlWmAb6NJgKFiM/CH8j2c4Noe/AJBJ/6gzBmx8wQ9u6PrWBh3Y+BF4Dqj
	KRXAm5eJ+wHKVFJYntVAyc/V05da5AsK8gVvFXGkP8Rh6WtOwAXaayg==
X-Gm-Gg: ASbGncuOFAHMY9ibt4meiXX6ozOJVk4Jm9GlGeVcP1F5pJm+/i78Vzy/yDB5mrxxuNn
	Cw4Izh0LfDMHm7BnvdL+cmYa2UCAVkHOhpEHyQJqUCPH5t3IRFSEpFU5uX1/KTejV4l+IScnjof
	E7WAVWXDiibmRQXNimI03hw8VKUyQD63n0M0LzlNr7wt9rSFIotmMS+8YTRvSF2x0ju4i+LK3M6
	aAYqP4NyZ+WWoctWhUszXjCPG199Ki2xlwiK6DkgzzHg415kJz/BXiPCjO6u2djhmOLSSBt84FD
	vmKnUA==
X-Received: by 2002:a17:907:7ba9:b0:ab2:c0c8:383f with SMTP id a640c23a62f3a-ab38b0b684fmr250595966b.1.1737118723742;
        Fri, 17 Jan 2025 04:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGolLPypoV7vv1FU38Hl5hboOPUMjKRFS7YTrKUY9FAV3KoHCbQhbcHSkkSusXoVKy1aDv2tA==
X-Received: by 2002:a17:907:7ba9:b0:ab2:c0c8:383f with SMTP id a640c23a62f3a-ab38b0b684fmr250593166b.1.1737118723388;
        Fri, 17 Jan 2025 04:58:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce11eesm167839466b.38.2025.01.17.04.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:58:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 35A4C17E7875; Fri, 17 Jan 2025 13:58:42 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 7/8] veth: use napi_skb_cache_get_bulk()
 instead of xdp_alloc_skb_bulk()
In-Reply-To: <20250115151901.2063909-8-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-8-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:58:42 +0100
Message-ID: <871px1oav1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Now that we can bulk-allocate skbs from the NAPI cache, use that
> function to do that in veth as well instead of direct allocation from
> the kmem caches. veth uses NAPI and GRO, so this is both context-safe
> and beneficial.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


