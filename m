Return-Path: <netdev+bounces-216587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FFEB349E6
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1785E0A6E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90A3054E5;
	Mon, 25 Aug 2025 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjRDqp1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0419D081
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145675; cv=none; b=cQrq5JSfK+G9uIuRvo+Qf0OPTVQivdtxfe0g1I491EjE3GdnUdlAXFuraqPwE+HdVMcihcRmFA0dYAh+DpvmtchJLQH5rc3WRencpOCr3rJjhOxO1skWcwn1YZp/dloIFa349SOfn5eYeWwQ+4r9LJHxhpquVRq+ROjvGpxGfkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145675; c=relaxed/simple;
	bh=lo/FzvNSsqs5NLDyLyXIwLyuV/L8gWBXyOglEgdIKPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohEy50n6tcyqqtKakt029plwt+yufs8YHx2qcvLL+Vi78+ePIkgUgZzyqVdr42zgoCM9poJhouxCDFPDq2ZdUrJYvZpSnm57Qbg0z1OCWzi+OhWAT14W0seUvFQABaaqjQJRwJ2M/SFBvpznpDajkpVQnz5hXxJE6RamESUz9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjRDqp1F; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2506294a12.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756145674; x=1756750474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAFoHyVgq2HUAD7RWWp9UDhVcM4xKJ5zbmqMMLeA/pQ=;
        b=wjRDqp1FwNFID2xLwNP1x4+4W1P8fb2eUq7Ge6dJQbQH7eSKdEbDWXBuBLY9wa4Ssn
         4urfBr9GvTjvWvpoaMeTcmw5ud79sVHXpdV+gXdAUfCGoqGv6iHDg8DGyRtnfe3u6K9E
         0E5TvvCdpTgFUrbeCxGGIL6LmuzxNRSV3no1Q1a+lH2kIUV3VBrBZJg/OdjeldjUxklt
         YXKuBa3khzNMWxdUXgRLwWzPvOlLZe0kOovjRq5JgdNFOYP8UAIyAwJrNbXiANYKch7G
         79sq/63qkwgmOk83Hy9uS+UXjJZBHVVqzhaXK/UW7y0+n70ToA5Qp0H+YR58Uhv/c/fj
         bx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145674; x=1756750474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAFoHyVgq2HUAD7RWWp9UDhVcM4xKJ5zbmqMMLeA/pQ=;
        b=gBtc+EYx8/wCQrHU/Cm54tNm/XnG9mEygt1Cvnu7RSqW5fMU394dMdZQTAYDXxnLSg
         xN/3HfpF3U7lQ6x/TPyh+cnSKjShjLdv0I/b1OF+suGPPTZJST5gP9LaJ2pevaVbVl09
         hJ05+H9xinCRRy62e3sJBKg0DJNd4fSyLLTUMaXDiOL6U5TkkuhQik8yeLO5LXzwTH76
         obkZC3BaBd/7dOvH+aKfNRJqf+raWtsBvGVUtRmJ3OHob5D7DNLU2hUnVh1kiYzy+glR
         KQ5NGgTEPLsHIS9taeK08q/ZNn9SkxmYMV8G4v9Jcoipi0CgzmeHAGaLG3dWkg37UUcv
         JVYg==
X-Forwarded-Encrypted: i=1; AJvYcCVERPlL5hnpQzquTvkMRj2p1jzDfwlR8CJXDLHUS7MDggN1r7v1Z/Kg/fdEtSqu8R91U4RIHBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknDJlnKwfPpKKYxCjqcTtppIsu2XmAg0ndiIDd9um+UPxJbYo
	ZC9wrvKlcZ/YIMAwCytxQZ6nrDNKLg2g0Plwt8FHr7pvHDn9t7KVdK8j8lxYQfqWUBptKD0QBmA
	azr+WiZmNLotSBSGKkydQOcUFX4L6z2iMkTxCagte
X-Gm-Gg: ASbGncuK9eeuh388WMHIlVXlJaOHcTkfguNvrSWBzsVRvwraD3/NmiKHu6VA2hLrde2
	PNrrgqzqNkUkvvaBnDioZChW6mtZM6nD6tpb/JTI8APTIyhKjbc2RZX7JfEb5bcZ2WDmHxvl0o8
	F80amz0w+LLtpPTL1yf7zRfFgwwE5iD+KRRRtRmtBLMexElpFZcSxBHeoC5180plRiuUyiAbFVg
	CxVgwx7ri1E2S6IBaCfnFjrKrc7f6/bjNhGdPxFGd2tn/FheYDDCUIvSX0z6K05VWZ12Bsb6cwn
	Y2dft6seZA==
X-Google-Smtp-Source: AGHT+IHPu68CwRCjZ41894GQEu6BBpcEd8YLYguot9ikozfDjHlSNI8+epIUq6PnyLRDG8S4OWQKVU/inq6FDLD3d5o=
X-Received: by 2002:a17:902:e5c7:b0:240:640a:c576 with SMTP id
 d9443c01a7336-2462ee02b9bmr163107475ad.15.1756145673571; Mon, 25 Aug 2025
 11:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com> <20250822221846.744252-3-kuniyu@google.com>
 <daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev>
In-Reply-To: <daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 11:14:22 -0700
X-Gm-Features: Ac12FXya6QTDIvmjcvPKpIwhAGAC-AYrfstj6UjLLP9c1VkVfILW5kwD5Dbn1VQ
Message-ID: <CAAVpQUDUULCrcTP4AQ31B5bfo-+dtw3H8CQGq9_SQ7d28xXSvA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 2/8] bpf: Add a bpf hook in __inet_accept().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/22/25 3:17 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > index ae83ecda3983..ab613abdfaa4 100644
> > --- a/net/ipv4/af_inet.c
> > +++ b/net/ipv4/af_inet.c
> > @@ -763,6 +763,8 @@ void __inet_accept(struct socket *sock, struct sock=
et *newsock, struct sock *new
> >               kmem_cache_charge(newsk, gfp);
> >       }
> >
> > +     BPF_CGROUP_RUN_PROG_INET_SOCK_ACCEPT(newsk);
> > +
> >       if (mem_cgroup_sk_enabled(newsk)) {
> >               int amt;
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 233de8677382..80df246d4741 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1133,6 +1133,7 @@ enum bpf_attach_type {
> >       BPF_NETKIT_PEER,
> >       BPF_TRACE_KPROBE_SESSION,
> >       BPF_TRACE_UPROBE_SESSION,
> > +     BPF_CGROUP_INET_SOCK_ACCEPT,
>
> Instead of adding another hook, can the SK_BPF_MEMCG_SOCK_ISOLATED bit be
> inherited from the listener?

Since e876ecc67db80 and d752a4986532c , we defer memcg allocation to
accept() because the child socket could be created during irq context with
unrelated cgroup.  This had another reason; if the listener was created in =
the
root cgroup and passed to a process under cgroup, child sockets would never
have sk_memcg if sk_memcg was inherited.

So, the child's memcg is not always the same one with the listener's, and
we cannot rely on the listener's sk_memcg.

