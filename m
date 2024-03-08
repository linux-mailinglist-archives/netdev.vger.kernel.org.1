Return-Path: <netdev+bounces-78662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F178760DE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428F6284680
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2252F79;
	Fri,  8 Mar 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyiubk5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D52EACE
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889816; cv=none; b=PS+GkqxRlQ9f85qAH8FpOah//7W/JKu6eAKG3lrQ+Sivt5S7jLK7HyEuQT2Q+MuuAevj2EeEJw9+VwSvB9TB8msaAI9Bjaj7ZWAcFxaalE02Pum/NImKw1RXCSvyb1doFz8fIrb7bfwoOBiJrb1m50jVV7dhyLFzsK+Smkat5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889816; c=relaxed/simple;
	bh=BLfLBotghxVWtoLRFRUPVIXYAebp/0X/BggmnPDgDQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIjfZmuhknSK7VPFonL1PDx55N/05RU1YoF9Z1zsaqCNLYRjMyHU+NnPAMnNmf+JegyDIYiGq4NBMGlFyL8eBGbrzpA2algXgEjn7cWAZeaIrKe+M5sgwOX2esIOegc14yWIWrwvq34e8ZqTfcDyOnahswpBt5cHbW/Pb4gyVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyiubk5Y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so6743a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 01:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709889813; x=1710494613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLfLBotghxVWtoLRFRUPVIXYAebp/0X/BggmnPDgDQs=;
        b=vyiubk5Y69HjxkklBqvBZX550FMslVdeKMlniogPwQ7Fe4NXPEOU0egLiua3akcMNP
         CYK6AL6ml0FcUSwfMvOvIMAm2ZbZGY8V5hurrErGwC+XXFSnexrN9DYtxUCUrl0jENw3
         lvUUsTptf9s+CVopIF/Z4DN6lxAxr2lLAhbJTbqZwdLAdujuUmmXiVYjjlvnirOHf0gB
         PdX/k8gE5Y+Hjk5ivhdjyM5Fw9Sygoa+uBHqJBtvXHIdmZaKDijL9IA+WjAFGvk54f+s
         Tdpw1lw2rLkGFiujLCzkFMPmchFpernk5oYuyAqXzveH/JQdHwPzSIOzwIoM4/fsoa6A
         Ij7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709889813; x=1710494613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLfLBotghxVWtoLRFRUPVIXYAebp/0X/BggmnPDgDQs=;
        b=XSkTp60cNIPT+kNr9nkjpzKL1EeIH3CY1UPXZqKHT9/FqihsD8wnJr3XWwA3zMfl//
         8/afLOr5PYuN0/2HfDasp6Y7Sdf9FKOqonR2eCL9Z+8EwVpxLbmgC8tkdY+iiw3jaqfR
         kyqwlNs0Ycp0L+NhBYLZXRf813x+kSRNXnSmK1aAtD1+MgoaKtr6vxWbKqmXn+pbQvpW
         xMHm0tGsggbeH8pl4sJTE4KxM4XRiXqmjtKRgealmuHQ9c3Q8GfpBKGL5aB7kiEIKo8S
         BcC3FoUch5e9HSgO7Yt/U6QF3i65E16c07NgnwYqU8gNt+NV8O3INw5YD0K3NBES0XnH
         v/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUFW6BRuPuuwet9TGOvY7oNWCOWbOAuWGVSnFThBYhHaaIWJ9Lq0/d9CI5bt9AYjXE79cR75Xu5cS5nhc4nNh3hgtEK1QTc
X-Gm-Message-State: AOJu0YwjVMcLhKmTX1rGOBZ6xkBA93w1oJQ6GiUpfEph6a9wb5vBIEjG
	cNu4yYsBeH/RBouz/qE9nEN8IO/r4cOA+p1gUiu/OsMN+adkRLxgoHxiVsmdf6/uqF7NTXZG1KF
	27ClE8KW4Y9577PZuwuhvoWp2RmN4yHfA7ZqDGj4aEchoSiiU2mcB
X-Google-Smtp-Source: AGHT+IH6czIi3utJKKVj3TJUq9W3dW6SorPIfpYMWpaJ0oJltEhlUuxH6M72xPHQ5+YaZDnTvjfImCU6y2xl7VBtvZg=
X-Received: by 2002:a05:6402:5202:b0:567:eb05:6d08 with SMTP id
 s2-20020a056402520200b00567eb056d08mr440836edd.6.1709889812581; Fri, 08 Mar
 2024 01:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307220016.3147666-1-edumazet@google.com> <d149f4511c39f39fa6dc8e7c7324962434ae82e9.camel@redhat.com>
 <77f54006d8127bc76c8fb81c7cfa8df1723e317e.camel@redhat.com>
In-Reply-To: <77f54006d8127bc76c8fb81c7cfa8df1723e317e.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 10:23:21 +0100
Message-ID: <CANn89iJzpFRgiNatNgS_U9D975DED2L0ieG=o6qb2qz2YB=rWg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early demux
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Martin KaFai Lau <kafai@fb.com>, Joe Stringer <joe@wand.net.nz>, 
	Alexei Starovoitov <ast@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
> Please ignore this last part, too late I noticed we need 'sock_pfree'
> to let inet_steal_sock() work as expected.

Yes, this is skb_sk_is_prefetched() part.

