Return-Path: <netdev+bounces-72398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7F2857E5D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E89AB228E6
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1684C12C55F;
	Fri, 16 Feb 2024 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgPIHn++"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80E12C547
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092047; cv=none; b=DEJ0JhBGjitHELuG2xXqLF4QjWGkH58tFNSQJrkZvo8p8PyQHrrHEm0lhXkkRHvcCuS0PqIv7DuqjlpUIPd9NCVQxL9Ijzqs6EP8Os2bB29J1SvrY4kMACJ5+j/DcL+cDFQjrvNJsMEKjiUNdlWS0rvu/8DH+lgKGynO3Dx++iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092047; c=relaxed/simple;
	bh=21ncnwEnUoXv+hRqMt7TP45+3FncijYHN5SkzR1tt8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lDp/KgnK/Wf9RlCqaF8Sg4cuRivOmYFmzZsqbMCSQMH8XFTt7tSo1HyuAqUMlyxRJMseFrx1bY2nXbvDQeX73yK9lOCqK/XyiqUPhOh5ctBooDyiPMlBMwj9m0qsgBWaOc4Q+PEPY7HmDtB3S9DhElzL1r3VoplCWvGeAVRHcCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgPIHn++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708092043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21ncnwEnUoXv+hRqMt7TP45+3FncijYHN5SkzR1tt8g=;
	b=VgPIHn++YfpHdQqR6DSBLjZ3CekDZh2RNoLshGN0xqJhXShEzg0hlqhOVxUnpLUC516r93
	LY+hVozaiwbJaqhMMwTB0qiHNTI7F7c5Jk45Va/Eej+t/nBNVYEtHi4KX17cZnR4vyHMSA
	5mnmYpV0IBumGEmqo5RDzdliltfdUQ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-rxU_7OG7N7OhUEXJj28jow-1; Fri, 16 Feb 2024 09:00:42 -0500
X-MC-Unique: rxU_7OG7N7OhUEXJj28jow-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-55926c118e5so1738441a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 06:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092040; x=1708696840;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21ncnwEnUoXv+hRqMt7TP45+3FncijYHN5SkzR1tt8g=;
        b=g+xS4AtwEskw0lUbtAZNMIg8cN0Fg19ZI4ROtiUr6VpsgEJVKjGntxW9j0n4wH8Yx6
         itV3hW5bj7Ar3N6Qt+p0Sek5edfEXqi23HIMDbBR4/GJysGt0PAearAF7vwmf4FRWvsa
         BoBlLlk5J86KBIKwaTy9U/z4GN1bLK+E1LHWFK2Z+DCvN5ii61wGB9RRleXaskmjlEFZ
         EOUSlBuTYy5w0zXdmUuqF3awXFeo506V6BBKeatEZ9bRO9ATLdjrTh5G3wn1xOfM+YzI
         oN31mlK8rIcqDHFuWFJ/fxM3gb9jlZ4Ccqx++RAC5gpe7bULR8RZMSgOyZYF4d3XRfKq
         JUPg==
X-Forwarded-Encrypted: i=1; AJvYcCWi4g3+IW2FmCQF5/i2v7ioVieT+Ejm9gygXo49Jhis9a/rZzg19LL7+fM2nv+3hYHmmY4HwMz6OncHJHvsQ5iJzE+N21SM
X-Gm-Message-State: AOJu0YyfE3g7JwTc4qh7rIegw5dq4H4Bu/6bTD1xGxcKyqPVsNswpI0p
	HZSm+Yk+gfeAgcqqkuZxb051dkyEhRtOtACCNMcqA983D5qoRJ+xznE2+ElZG/gXzDKdvOaDmK+
	1cqqrauq8RW+cy0czcsN0XZrYlyQIAPiRpt8Jl9KyvdhLSmqDgBaKkw==
X-Received: by 2002:aa7:d39a:0:b0:560:4f1c:99c0 with SMTP id x26-20020aa7d39a000000b005604f1c99c0mr3754060edq.13.1708092040733;
        Fri, 16 Feb 2024 06:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH9qLErIx9BTiLXdRzSFEVfAu/4I+PSZLkGaxAafzAUsaGy/sW9sX57lS2R3vwbol5SzyQFA==
X-Received: by 2002:aa7:d39a:0:b0:560:4f1c:99c0 with SMTP id x26-20020aa7d39a000000b005604f1c99c0mr3754022edq.13.1708092040363;
        Fri, 16 Feb 2024 06:00:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b2-20020a0564021f0200b00563b96523c5sm1346763edb.80.2024.02.16.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:00:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8734310F5BE9; Fri, 16 Feb 2024 15:00:39 +0100 (CET)
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
In-Reply-To: <a33c3cb6-a58c-440a-b296-7e062fa8f967@intel.com>
References: <20240215132634.474055-1-toke@redhat.com>
 <4a1ef449-5189-4788-ae51-3d1c4a09d3a2@intel.com> <87mss1d5ct.fsf@toke.dk>
 <a33c3cb6-a58c-440a-b296-7e062fa8f967@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Feb 2024 15:00:39 +0100
Message-ID: <87h6i8cxvc.fsf@toke.dk>
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
> Date: Thu, 15 Feb 2024 18:06:42 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> Date: Thu, 15 Feb 2024 14:26:29 +0100
>>>
>>>> Now that we have a system-wide page pool, we can use that for the live
>>>> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
>>>> avoid the cost of creating a separate page pool instance for each
>>>> syscall invocation. See the individual patches for more details.
>>>
>>> Tested xdp-trafficgen on my development tree[0], no regressions from the
>>> net-next with my patch which increases live frames PP size.
>>>
>>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>=20
>> Great, thanks for taking it for a spin! :)
>
> BTW, you remove the usage of page_pool->slow.init_callback, maybe we
> could remove it completely?

Ohh, you're right. Totally forgot that this was something I introduced
for this use case :D

I'll send a follow-up to get rid of it after this lands.

-Toke


