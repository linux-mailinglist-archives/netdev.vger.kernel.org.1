Return-Path: <netdev+bounces-249834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D17DFD1ECCF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B46A306B69D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F8395DBE;
	Wed, 14 Jan 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPJx42uT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSpaNHzN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACEB396B91
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394049; cv=none; b=Rm76uz9d2hZSeZCc+CmZX7HN+ZavLAN4uwF1+poODJ8iHAPe6y6AQ/Mnkco1VDwDx5UruNHoM/CgKc7iUWgVqnpiT2yfE6eYkC2EtBOSc0Ur/kGJBYeFnlV+1lXL3qaklvZXdBUGsGx5oa5pve2kmqUh8LMpRDtOqBQN4l44IFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394049; c=relaxed/simple;
	bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqfEBzPI/7ZBoreIRfo2lypbXmSdELZjwJ3N7ecXGjOqJJSV8lRryZEdr7nlce4EYUHF3pO/3HiUIGv4kh2bMId5hWyQ7YK98R18c67YvZa5VHvfDfDMzu3c/oZHOw0FJv71D/N332FuIGSLU/giwZuXbmpFy6sZ8295gWGTMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPJx42uT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSpaNHzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768394044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
	b=JPJx42uThPXuskKWIRjPpvNeOgssICiLXh6+Pm3ZPmLdl/WAPQaQB5mjzsBqvu1Qs8i91d
	kC0cTU1/IjbainsJDAz/7Aq6OtIXWSSz/UyT8eF8u+jLC/H9tlf36Z0wFPu2RKQ+atPoi3
	Y9w4cIg0r+G9VcbncxIaK2rMuDZcUwY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-nIO79Sh8Msyiquvw7TySEg-1; Wed, 14 Jan 2026 07:34:01 -0500
X-MC-Unique: nIO79Sh8Msyiquvw7TySEg-1
X-Mimecast-MFC-AGG-ID: nIO79Sh8Msyiquvw7TySEg_1768394040
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64b756e2fd1so11010787a12.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 04:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768394040; x=1768998840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
        b=DSpaNHzNpQceUo5GheE+FhqYVER3m7XNQqPyIoXD4vGDnaNxqb9fV4eEFK4bJGUujt
         shBYvBrNR12f+Ekw2bxvaCxyIbvGZxY3TG6yTQyyJs2sIOVkGOZRVPzvwx6QXzxq1eqG
         gNeIUJzWv3Rtnj6VJhd9fK8wZa2/puMZfWOL0TMMdPaIZe/9xvi01yL/mCYKapOqdSso
         mX5jnnVM3aSdOF5lWTIMhxsS8BsPk4hoOkvXMhSLlhJU/pkoZqVBrhBzxzLnLY5/69Nr
         Gme7VKqwxeVNWE/Jb6qV0fd7yQdLehUrg3AAUL0h/YP+57H4uo+0nSPeodXQzkxnMH/x
         dLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768394040; x=1768998840;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bd6vtXKrmS6WjvXJ/4SZe+JXxr4BUxm9h6I4D8SJur8=;
        b=gV9UZ5pgNSANZ0Dq5Kji+Vz9twAiZC0XJ+KEHF+2v9guDz3xQ0e5M5WagGejxr/qHY
         ljuqvcI5ataSIlDqDUs7QVfF2L6m8VgKJbBmSifFg630vbHI/lifDxc6RdOAu6NPdZpH
         K8UIuRxO0HGip7AxjNouygY2GXWpamWD5b8cGgvyi5bXSB0zojKbIuXZ0LsEs98SOr82
         cDONK2qglyjF4XLfrgqcyXckXknc5fVgRpSAuGTOa3l6ldcEKw6L0cm3f/ZgjCgRKGwB
         4IZQoCdPofO/ipUnB389qIHniOrJiUN3fygL+G63abEFwmNE3uBdZLYCGTZ5oyzSa9/0
         z1Gw==
X-Forwarded-Encrypted: i=1; AJvYcCX94ShduaCoGLjz3OKNWFsR7GgS1dkQuZTJwmVPsSIKHFVz4xLhkFinmp8mBfCUy3D/hhZKWOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCu2EhNYp/2qS8fQD1Tdd9Cnxh1WAebMrh5pMVq9WGp7i2dKZ
	ANmrVYF4t1WKzY0MJ0aP/vRxdJ2VScp4vN8Grq/wKeW4l5GEta3IxVhxGOy114/B540REDN09AP
	W7LaQQJ59ChoXl2KVcga/1soSR7Risc3t3btx9loHXkdfpKyyoS1M1YVwsQ==
X-Gm-Gg: AY/fxX7I8wBKKQKdzCGyVM4kepr0oSF4VQq9WTcYpYdp7h3mfBeaEtZOy9ZKiZJ7YVm
	bwA70sITsfEaYh4F5oy5BaaNRpEFiwzvpWqST4upC0zFoGjwY7CeUA+CXopeOgR4qJwRU+HdbtU
	KkloRKKOQ+7jhPOFZGccMDY19NomE1GECF+KFOOY6AvAJfSLdORcpqRT7vYVCiuCpGzDo8ssg/t
	Mbd5PzbPBVisa4VVpPHLRUscVeTAa2ACIrjKBd7sUnLWCnmhKudb8GgsZiZoFnGbGIGztMI5H5P
	rSqVpL8KsXX3UGcmoIg667DZOHReTiPnpAogaJPGKv+MCFu4USOEc3L2Jm3c6Z/8gUOQYj/TUCd
	i7fLyVnKHIniUyntrbGiPNFoBiNU+8DwTdw==
X-Received: by 2002:a05:6402:1d51:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-653ee1692eemr1683450a12.15.1768394039746;
        Wed, 14 Jan 2026 04:33:59 -0800 (PST)
X-Received: by 2002:a05:6402:1d51:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-653ee1692eemr1683429a12.15.1768394039373;
        Wed, 14 Jan 2026 04:33:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d51c5sm22896574a12.14.2026.01.14.04.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:33:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 647BA408B93; Wed, 14 Jan 2026 13:33:56 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org, Jesper Dangaard Brouer
 <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
In-Reply-To: <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk>
 <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk>
 <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Jan 2026 13:33:56 +0100
Message-ID: <87zf6gz83v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com> writes:

> On Wed, Jan 14, 2026 at 8:39=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>
>> Yeah, this has been discussed as well :)
>>
>> See:
>> https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.h=
tml
>>
>> Which has since evolved a bit to these series:
>>
>> https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2=
-0-a21e679b5afa@cloudflare.com
>>
>> https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls=
-v1-0-1047878ed1b0@cloudflare.com
>>
>> (Also, please don't top-post on the mailing lists)
>>
>> -Toke
>>
>
> Thanks for the pointers. It is really great to see this series. One
> question: Would adding queue_index to the packet traits KV store be
> a useful follow-up once the core infrastructure lands?

Possibly? Depends on where things land, I suppose. I'd advise following
the discussion on the list until it does :)

-Toke


