Return-Path: <netdev+bounces-189880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC5AB4476
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3F73BC0D2
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4929826D;
	Mon, 12 May 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UL2uAYR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24586297A51
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077025; cv=none; b=ER0DBYlu/cT0lvap1KrKTossV4nuaFTUib1BnpCUvPFhLeeXVCMX6c42Qdp/OuDbkVqW4dlkPKlMGC/DycEdZIF9A19NaQ39ghw9oIBYWxecqvJuYQEokGSu+71u7ttCIiHPF43nlW6wwr65f8kZeIQ7fcFTNckZZ9gUzGw3pyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077025; c=relaxed/simple;
	bh=wSSePSSFWXHCvtu8SYuUqUMJvmE4cuWdk3lZOY2BEX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joPrkwGGAZtMi1raeOsIt/y8MVDc49CfoIryh5DL3fX61xP3SYH7IRq939N4IyDPznPDw/Nijlgly8Mgrc+T7wXF0kgUQoSm4IKcJpoDIi0p3D4dT3Ae+Oye3G4yf5H1OHhPJvVqHKZ7vRToz1kOa9pw0VFc2ebUKklO+YzPzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UL2uAYR6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso2452a12.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077020; x=1747681820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5AiAQRzff+Fnpyk4hqCxjXcsP8Fivam44x9/hbBNxI=;
        b=UL2uAYR6kWxnby54S21H9f1T14bilUeyORYK6ItNKSfCejnj+2WYdXjYq9spkP2kGS
         XHxbXrrC8NdjhkoV/4PmBaAOaeZpx15GACX1DJ5IO14SOtpp9CbSUs2BoGZXrIujFPCo
         14qj6nWSebG5CcavfO5nSyGLGaZ3MfTNXDDI/s4MxOEthZovpGZswug3mMmIbuWnkQ1S
         eiNE56ui3n5xvxmJFBBKp6tlLLxlF/nXwsJsvMiD27koPlRsela5KdBLYuLZu/zMzvS1
         5jRVP0JtiSX039C12LhLonV/LfPmNmxhIWoAyE2569peNiV7aNEtVvPRhj7j0Hr4cWOI
         jS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077020; x=1747681820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5AiAQRzff+Fnpyk4hqCxjXcsP8Fivam44x9/hbBNxI=;
        b=NVIYd6vdE/JxwO8lhklJsHRJgvm9l8HT8+xd9ufby9IJFE+mtsqM89WXT6DI0tWbl5
         jksF2TYBgwsKId3Q7587eT3t/kVbDJjMNsfp/P5EpbCUKa473fzJ0JVfZzkQCm/NdVaR
         hVUZaBFcZWiKJXIGn5+LumhYPwNgOaJMs3+NaOL3vwNBsACyAWUgo4kEyVoki2n56RsB
         ylQbmC6EkByAXaWSrn6tGMVTGAoAReB6A/xPP/JPk2IsygU4F9IfhFNZouJ2xRLt1RjS
         D0ej18Duaq2t5f52hEUy+68KEp8h/93aYg/LIPM/neY4EZT56nRx8S3I8Ug2P9DUs0uR
         /ZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfyJBU146xZ5CYAajIL7adEoz0ijIzcGuuZqsG8hqgVHMEI48gA5Fsib4Cj12V/o80w/PWLFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHAqLiHnQNVPOQZIT9jhjnHmuV3yOtI1L7tDmKUHpvvIpXEHF
	sfzLFFQX5qiuB/tEd4u5snIh5hTmgSyRFGZnf2LO7gFA+M+rD+9CmjqwD1uWKPaiY5NPDQO0ng5
	1ZljpOLVaFyVlL8UdSOFLzaeXAq81nXTS6sJWd7DT
X-Gm-Gg: ASbGnctcAPSiuHiZqNACQDpMqZMQJlpjYsQq50tT6kT1D5EDWJIZu9pxm3l3co82H8t
	kkRgrzUpY/Nfgh8FsuedMJa4fQhnWLOHH69Ubud84dNCVMGREZcvuJigILh/11IB3cTkrmj9MpF
	0zI6jNTO7sSnm/99mUUMYKCTTJGXMlsqTLkwdd1N1HYanhCcDpzcoqwpG/vZ1Wk10=
X-Google-Smtp-Source: AGHT+IH0X7OXY2c2wm3vHcfj6eREiCHt0sfaqRAvXgUgcOFWWbKYOjtzsyI4MgBbRRSFkgBiNpZNXPI800gGZwDDcdg=
X-Received: by 2002:aa7:d94d:0:b0:5fc:e6a6:6a34 with SMTP id
 4fb4d7f45d1cf-5ff356e3dcbmr11772a12.6.1747077020206; Mon, 12 May 2025
 12:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509115126.63190-1-byungchul@sk.com> <20250509115126.63190-20-byungchul@sk.com>
 <CAHS8izMoS4wwmc363TFJU_XCtOX9vOv5ZQwD_k2oHx40D8hAPA@mail.gmail.com>
 <aB5FUKRV86Tg92b6@casper.infradead.org> <CAHS8izMJx=+229iLt7GphUwioeAK5=CL0Fxi7TVywS2D+c-PKw@mail.gmail.com>
 <aB5b_FmBlcqQk09l@casper.infradead.org>
In-Reply-To: <aB5b_FmBlcqQk09l@casper.infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 12 May 2025 12:10:05 -0700
X-Gm-Features: AX0GCFvoPJJcQzET5ZShS86HbjuJ2f-9-4APyukZLguKBpnLzWbvE5OAdk4p78Q
Message-ID: <CAHS8izOL_L3fjB1YutDm8xvp1hboyO9_ng0pOVESUqDew9N96w@mail.gmail.com>
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct page
To: Matthew Wilcox <willy@infradead.org>
Cc: Byungchul Park <byungchul@sk.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch, 
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:48=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 09, 2025 at 12:04:37PM -0700, Mina Almasry wrote:
> > Right, all I'm saying is that if it's at all possible to keep net_iov
> > something that can be extended with fields unrelated to struct page,
> > lets do that. net_iov already has fields that should not belong in
> > struct page like net_iov_owner and I think more will be added.
>
> Sure, that's fine.
>

Excellent!

> > I'm thinking netmem_desc can be the fields that are shared between
> > struct net_iov and struct page (but both can have more specific to the
> > different memory types). As you say, for now netmem_desc can currently
> > overlap fields in struct page and struct net_iov, and a follow up
> > change can replace it with something that gets kmalloced and (I
> > guess?) there is a pointer in struct page or struct net_iov that
> > refers to the netmem_desc that contains the shared fields.
>
> I'm sure I've pointed you at
> https://kernelnewbies.org/MatthewWilcox/Memdescs before.
>

I've gone through that again. Some of it is a bit over my head
(sorry), but this page does say that page->compound_head will have a
link to memdesc:

https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

That's an approach that sounds fine to me. We can have net_iov follow
that pattern if necessary (have in it a field that points to the
memdesc).

> But I wouldn't expect to have net_iov contain a pointer to netmem_desc,
> rather it would embed a netmem_desc.  Unless there's a good reason to
> separate them.
>

net_iov embedding netmem_desc sounds fine as well to me.

> Actually, I'd hope to do away with net_iov entirely.  Networking should
> handle memory-on-PCI-devices the same way everybody else does (as
> hotplugged memory) rather than with its own special structures.
>

Doing away with net_iov entirely is a different conversation. From the
devmem TCP side, you're much more of an expert than me but my
experience is that the GPU devices we initially net_iovs for, dmabuf
is the standard way of sharing memory, and the dma-buf importer just
gets a scatterlist, and has to either work with the scatterlist
directly or create descriptors (like net_iov) to handle chunks of the
scatterlist.

I think we discussed this before and you said to me you have long term
plans to get rid of scatterlists. Once that is done we may be able to
do away with the dma-buf use case for net_iovs, but the conversation
about migrating scatterlists to something new is well over my head and
probably needs discussion with the dma-buf maintainers.

Note also that the users of net_iov have expanded and io_uring has a
dependency on it as well.

The good news (I think) is that Byungchul's effort does not require
the removal of net_iov. From looking at this patchset I think what
he's trying to do is very compatible with net_iovs with minor
modifications.

--=20
Thanks,
Mina

