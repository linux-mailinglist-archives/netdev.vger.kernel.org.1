Return-Path: <netdev+bounces-237626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9ECC4DDCA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 13:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB49D18C06E0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7093AA194;
	Tue, 11 Nov 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZwCK1es";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mPwuRNGr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E683AA19E
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864622; cv=none; b=pHElTDvJBzVOfdXGawMh7OIJBAizRZgq9+UQakIx+mAWMcAE7o1hkMw++BrjxtWjZRrcXmrOMDKtxLDHikrs3OerrCgWhqs+xTYcsCsK7wonFrPLqfeI+Ksom7QIWQny/3XuGTbUK9S7EBCS6DSRvrVbdbqIQ0IozUlER+KecJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864622; c=relaxed/simple;
	bh=5dqdNo3mNkTyuVVJxOfXWQlM4vdL2fXY/f6lg8rt8x8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/MZHF9xsIkB6JJ4B6ApAzys+uq29NAXXp80eG5zOF78enWyREZQf2tAkBJ1J50r7JHSFP62GAZX0lbn1bO/aI803z21dFDDcfILzBqcdytaTRrX84p2TM9WU/MUuw2cuPVoapiISGP3JaQJLxwzcVKwqMnsBL5PZs6iC6L1Iug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZwCK1es; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mPwuRNGr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762864619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJil3CsSx+8fOj31OoVJWOQNTlYu8I58IHhwpqoKvHs=;
	b=TZwCK1esLLli0aDh7V2YSGTPgz0m4hTSIZoK4lnwbj8By0MYbmbK+3JmrxdU/EJgmv55VI
	W+EVoLXV1ux6tcniMc9G+ZsZpPNTtuifS5rtuDACfJCmkDprtBwXmclMmmaSiMWLRchWFs
	FQywiFLLWNk8K+msvj7nkg9Sm+pQvGk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660--DJa_-hwP3KkXRIhxLCJdw-1; Tue, 11 Nov 2025 07:36:57 -0500
X-MC-Unique: -DJa_-hwP3KkXRIhxLCJdw-1
X-Mimecast-MFC-AGG-ID: -DJa_-hwP3KkXRIhxLCJdw_1762864616
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6409849320cso858518a12.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762864616; x=1763469416; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJil3CsSx+8fOj31OoVJWOQNTlYu8I58IHhwpqoKvHs=;
        b=mPwuRNGraz2FloDjjZW58TFYOKa2vusLMVu2/EYH0Gymc8KlQT2pYKbbk4XC2Y428e
         lpLqp24A1/XZXJd6sOCvVp9gJgywdeDaC8f7CymMHBRegn/MrFQFC3iByhmlm8eptHu+
         ja0MhL4V+xcCybVrQa8TJ8n/mJ4xFESUQ58iNhPQQancjm9MzaHgWqTvfwTRYDIQjzxJ
         tiE6jNRCe+4Qlh8dRwYbzJ3ExmvXZsSdH4CCQ5ZmdfSnCWMLkaWIFt0SGyejFTEVb9pY
         G63DQnBVg8LM6ccu1aHLaiLxN/8uZEf7Caslm38yROvZlluqj3oPK12z3COQUfhTL9Kh
         qASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864616; x=1763469416;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJil3CsSx+8fOj31OoVJWOQNTlYu8I58IHhwpqoKvHs=;
        b=A9YPW3ZG/XNlFhk21XYMI9jVqJQ1uQlCD+373rdB+qOutg8z/ZjMRBCx+LDdLco5IL
         wcQuIYKhIE72qd2Y+9H9V6PiMYIbv5WD/l1oAK9BsHNY0Q4J+hKG3FUwdVOSOOe+JY1T
         0nc2qfd+LwW6tUR21jHJZjuSYkzpM4UTLh2FIQKVjKEsDuBui413qlhxwu5AvkxJdnYR
         QrV15F9FS//ofAnd9rxLj3THZpIJk8KQ9UD7D59kdHgsfpUF1thGEYWg7iWvrkobebqx
         Q7eecpbRXXIbz7sPmQ1QhsioDOgsUvp5IBgdiaHI1zgfO5r0jUWzxhUiSXmcYo5KblFp
         TAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXlIe2de4tZJf9BFTOvQMXuEUz3ty5UCZrVl8nBWIV36D/Cv96JJwvm86dwp8R08UcbF66I8Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZ5Tl7MLXfF6wPVGkYv+QdTK8Eb/RJMMznxmjnHresz9CEkOK
	DN8yuFDFUKAj5u0T7/0xyPUYzbGyYgA9OB7sB8KD3D4FHCV7PGme2zsfEVuP9D4Tysm3wEVe+C+
	gbMPkVA9U9cZI8oWyX9O3UNka1d3ibM6mQyT1Twj1VtJrkdsUot8rROJQ2g==
X-Gm-Gg: ASbGncsNL9mohtBaMGOgJOL06vNMtrsBT1u3bgz5p56mr3Zz2LPbuXgxSUhv11udrxN
	ipYV8GeaxM5NH0AmQ7RR3TZkIouGWMlN+/jW9xnZIyqzqqUGy/qIpVDjVb6aWgjG4u3JpF7yufg
	+3N+JJpR9RbggnDPPXsP6leX3+b2Fwns/CmiN2VAHQUWkITolWTk7C9FxBT6Rt4TXjYV7EEFa0y
	5Q5YWtOEiR970y8AWk8pNeraXKIqJtpY2X2XrubCkpMZjuD7XzN5CR3lo95NxskhvFp+HWntcjJ
	NkPps60DKlFCH2YYG87pCx2/38ksTdbOfF9eBjPkl0R1eBUXUZXWf5DrHEvAmjcvuZocHhJhCEx
	baWuy2pwaTERn9DbPdKDOV7XJ+Q==
X-Received: by 2002:a05:6402:5189:b0:641:6b44:75de with SMTP id 4fb4d7f45d1cf-642e275ace8mr2893719a12.5.1762864615765;
        Tue, 11 Nov 2025 04:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfkAwSb/V5JIwU5moExHjbeMcWwrXGoX+mdVUHDtdTxf3WoXuBjDbonnmfpi475Ak1gHNtpA==
X-Received: by 2002:a05:6402:5189:b0:641:6b44:75de with SMTP id 4fb4d7f45d1cf-642e275ace8mr2893656a12.5.1762864615046;
        Tue, 11 Nov 2025 04:36:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm13449948a12.13.2025.11.11.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:36:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 83146329590; Tue, 11 Nov 2025 13:36:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
In-Reply-To: <20251111024500.GA79866@system.software.com>
References: <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251108022458.GA65163@system.software.com>
 <20251107183712.36228f2a@kernel.org>
 <20251110010926.GA70011@system.software.com>
 <20251111014052.GA51630@system.software.com>
 <20251110175650.78902c74@kernel.org>
 <20251111021741.GB51630@system.software.com>
 <20251111024500.GA79866@system.software.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Nov 2025 13:36:51 +0100
Message-ID: <87346kn3to.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Byungchul Park <byungchul@sk.com> writes:

> On Tue, Nov 11, 2025 at 11:17:41AM +0900, Byungchul Park wrote:
>> On Mon, Nov 10, 2025 at 05:56:50PM -0800, Jakub Kicinski wrote:
>> > On Tue, 11 Nov 2025 10:40:52 +0900 Byungchul Park wrote:
>> > > > > I understand the end goal. I don't understand why patch 1 is a step
>> > > > > in that direction, and you seem incapable of explaining it. So please
>> > > > > either follow my suggestion on how to proceed with patch 2 without
>> > > >
>> > > > struct page and struct netmem_desc should keep difference information.
>> > > > Even though they are sharing some fields at the moment, it should
>> > > > eventually be decoupled, which I'm working on now.
>> > >
>> > > I'm removing the shared space between struct page and struct net_iov so
>> > > as to make struct page look its own way to be shrinked and let struct
>> > > net_iov be independent.
>> > >
>> > > Introduing a new shared space for page type is non-sense.  Still not
>> > > clear to you?
>> > 
>> > I've spent enough time reasoning with out and suggesting alternatives.
>> 
>> I'm not trying to be arguing but trying my best to understand you and
>> want to adopt your opinion.  However, it's not about objection but I
>> really don't understand what you meant.  Can anyone explain what he
>> meant who understood?
>
> If no objection against Jakub's opinion, I will resend with his
> alternaltive applied.

No objection from me :)

-Toke


