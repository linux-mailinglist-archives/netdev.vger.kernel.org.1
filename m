Return-Path: <netdev+bounces-71671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5E854A6B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509A528E9D3
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0CD54789;
	Wed, 14 Feb 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GisxKNhP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EC5810D
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916998; cv=none; b=nXM6oTazT4Mj+4swkEpHa3nA2Jc21kmB5/n/au82eieXcxh7SziZN5+3JmibXksVR761xIFF8M6M+a60xs1YbHJKFKouAQUVqF++WTFNUGN7pJqL6a1UGKCW7CYFIMsMGcb12/T1kJXrK7Re17CLVtuBP9XGJdOJjTZcoQg22nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916998; c=relaxed/simple;
	bh=HNraHWOZNH+3RvOHMr8xVWNpbzsIA2kUslt7E3CDhMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKtKHbNhYWndt+IB48FRcr68RLKTQNWhmbsneMwbp7pTLK9mq1DO6vOLrrNUpiuDrbBuz20oFFe/l/8L17+9KtcipVva8dA7koa1xafXuyc3rZEknolW7Dt4qlunWBrugnheISn05rBLZtNLQEAp7b0xzdW577StNM3fToXCRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GisxKNhP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707916995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Un0QKPb4jdgmT6FE6UlUFtmk4ArcRKmDsqNoetoVwlY=;
	b=GisxKNhP3Qz0BQ+j5yL7OyEi+0bPPMu4gwbCIjEe32LFPwloGewmOkjCK2Uf2RP2J/t0C5
	i0tHT7/+lINTdkwNk9cApkUAHe+ZnlENQYKhbr7jENJ1QUOAmWjlN5snuZvbEF3GgJHg00
	5ya0/RgoMzrbDDPI6cBHnsSCns+4PJw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-mtaO_p68NiGwpcELSI3lSg-1; Wed, 14 Feb 2024 08:23:12 -0500
X-MC-Unique: mtaO_p68NiGwpcELSI3lSg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3120029877so85259666b.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 05:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707916991; x=1708521791;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Un0QKPb4jdgmT6FE6UlUFtmk4ArcRKmDsqNoetoVwlY=;
        b=QXZIneK1lYRNjAIjp7ks+TWRzj/g6mrGqYbLibtkM62DSbSVibLYePdKRzYas/FDuy
         yVsEHtp+rbrmPtQeK4TiPSVPlyC6lHX6sBucc5xhYiY9U0ACJItQNBH2/aE2CyTFIAvR
         EhXcofXgXiENM9VdW1AId7XF7eB1U8ivK4WvpLYnZxK7J57AawKxmVvVZt+aE8jV38gn
         EknVk1EqK9XPwqzxPC4zy3vhif8xI3UgtVblY0zdAYylu7Uz5BtvhcVs6pZUa3abYU8z
         mc0xdxClGOBdOkW8u8R8BwJ8Qyp0l4nwySeeTe+hGZ96XOnzKEjdF3Mn/rEq8lw8uxwP
         6SFg==
X-Forwarded-Encrypted: i=1; AJvYcCVEPosMgbkqjIiMh2mIEMMy+MZcXJXIT6/CySQJHXBFmHDSowT6XPUvps7vNcNtWTrdbVUjDPqS2yMt3SF1LV4IXutIGonP
X-Gm-Message-State: AOJu0YwDVtAx7PjFz7srbPMcO3kSxU3PQS2X1vtd+JQ9Wr8KSCj43nyH
	k6VY2tvxIvw5D/JnZpmp21Zpy1vCSLUFiL8EtdgMTWYTBewb6uAQFshiEn9e0DOx46xyTjPVFeM
	pZi66zJ4OqpLZr3J84CGrnmcf4e3sWCYdx4J7+xtp3chvDFEJc43jzg==
X-Received: by 2002:a17:907:1c21:b0:a38:4dc0:22f9 with SMTP id nc33-20020a1709071c2100b00a384dc022f9mr2087115ejc.4.1707916991520;
        Wed, 14 Feb 2024 05:23:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUhTw8vtSivb9TAW8WtFvo5Bbn9Fb0HKGxLEpjNn3TOAQbWkbLicACvPPyh0Yr8VXL4hnFdA==
X-Received: by 2002:a17:907:1c21:b0:a38:4dc0:22f9 with SMTP id nc33-20020a1709071c2100b00a384dc022f9mr2087084ejc.4.1707916991244;
        Wed, 14 Feb 2024 05:23:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJvTxkvTi0OXr5SaNbOUPzhxfQOPqwn/LpyjeMzsPLDnKlESlwBRPektcJBfeTqOcDiQ7e926ctL+/fbSs+5dpK21ZdHKQ636Z30RmG3xV3ARui46TRgI7sNiNgtW8OVLQifX5p+mRwvoOAf3dZHwSgOwIhEHY7oOzllNrH/D9um8I88Hlpdnyif/eJMpalFqlGUVJ2gKIhm9oL3c7HWlry/hBoXWwBhYsZn74B7AC+8nKxVRYt6AdXJQCekrGQ9d9ahUNw2sBn23TMUBBv1zvBJtktINDzjvKpUTL6Ua/BKIyl4TNM0dQElTDXmfeu5YUa6lFZubUcF9iWyb1ocAIZs73MaGj9iUhfQEUdZYBjffjNKF5Zaqhp/SQ6iEEpcjAaj7PzisOvVa7mK8VKwd6+lyMk0VZHOBa7fIg8BLQJUFkE5sA5R7x5Bc3nNeaNjcqx3rTe+bz+OxCHyINSh838yT1athVjzr4OP761FLASiMdbICdG5O3cdjOQQ16H5OVo1XODbYgoSePmj662vu9PrL85k+e8RkdyJ40FnklYXbF6OoHpvRCJ5nvM+L4/7AOFsES0axm7KsRHYpF2x0T4G/teZ2rzlMdGF5n6ob1rm6jsUv6dAUII3eM+cSy2AAEOhKzlaUgyU1V6mVpuCXopUz6IR6Dv4fvAakmqwlKEEN9u0YiMnvEmdXKE5MQdnQ=
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id cw9-20020a170907160900b00a3d559c6113sm439165ejd.204.2024.02.14.05.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:23:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9728310F57A4; Wed, 14 Feb 2024 14:23:10 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jesper Dangaard
 Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, =?utf-8?B?QmrDtnJuIFQ=?=
 =?utf-8?B?w7ZwZWw=?=
 <bjorn@kernel.org>, "David S. Miller" <davem@davemloft.net>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Hao
 Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jonathan
 Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240214121921.VJJ2bCBE@linutronix.de>
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Feb 2024 14:23:10 +0100
Message-ID: <87y1bndvsx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-02-13 21:50:51 [+0100], Jesper Dangaard Brouer wrote:
>> I generally like the idea around bpf_xdp_storage.
>> 
>> I only skimmed the code, but noticed some extra if-statements (for
>> !NULL). I don't think they will make a difference, but I know Toke want
>> me to test it...
>
> I've been looking at the assembly for the return value of
> bpf_redirect_info() and there is a NULL pointer check. I hoped it was
> obvious to be nun-NULL because it is a static struct.
>
> Should this become a problem I could add
> "__attribute__((returns_nonnull))" to the declaration of the function
> which will optimize the NULL check away.

If we know the function will never return NULL (I was wondering about
that, actually), why have the check in the C code at all? Couldn't we just
omit it entirely instead of relying on the compiler to optimise it out?

-Toke


