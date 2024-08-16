Return-Path: <netdev+bounces-119188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D75954887
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20792838C5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA2198851;
	Fri, 16 Aug 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SU91oVt8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3F19FA91
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810357; cv=none; b=Vt3apFVbEvvvsBekEDylMi/vk0d0zs6ABlJZFlqleSY3k8vw3X9rjzCjZhgygvxs9PjWjSe+JJAq2sHzRUCtKTnlZp/iinbLML8BuhgeTQHC7ipB3i70n9WNSY7dokrRMhfZ1jlCsAA0VYXidnJNqifJa80l9caB7mWAAM40AU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810357; c=relaxed/simple;
	bh=Z3OsITij8iRw6MzDOPs42DX7dRqZPmILJxzzjwe7+v4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AcSuEx/wbWOzaOGSt50HdA1CLED1VhV35zmIuOn+wWsiBa90l6pXm3RkgBEXyCBySJr0EMZI3s4esIKixTq2q5GGd9STzIKqMq5qNFbRtKEug8rWad6kR4zI6n7EZWmv/ni+im24HClyHEvE4H69RbcBV6z/MiVNvLvxL7NnHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SU91oVt8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723810354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3OsITij8iRw6MzDOPs42DX7dRqZPmILJxzzjwe7+v4=;
	b=SU91oVt8aF1DuG87Pm39/zT8xa+vOET5z67D+SnlZVA6bRkOGZJDI+Gb6ubYeTGY4za0ld
	6qxLiSO2IqvRnO5MaO5aFva6NtRg/oi+xO8g19Bz6iDvg1HF8xCfiiEiXvBgeMjFHwMuUH
	hY/lD8IFK97Dcob+dDl+O9gnggTQ6RQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-z6OnamZlN7mN_Fbs7dD0AQ-1; Fri, 16 Aug 2024 08:12:31 -0400
X-MC-Unique: z6OnamZlN7mN_Fbs7dD0AQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718d9d9267so717939f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 05:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723810350; x=1724415150;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3OsITij8iRw6MzDOPs42DX7dRqZPmILJxzzjwe7+v4=;
        b=Kcz18mGUAGA/SkM1VfuBrfiDvG+up2IxKepTiBXbHvpHkVjCfGQ7SIdtvghMKweVzb
         tJKR9EyYp8gjFvQwz3wbRoPTh4IlRRKGNPsrk1ebz7FG9GFcV18KMesX85Nl77+0dGRL
         MhJ6dKrZdaF9uV8tRR7pO7qud8UMLYr2Fe2l6Dv27WiHeGdZ+2pSXMpYirIsLHh8mGML
         gS0uJDReG9ki4JEgqzCVwI7Im24Slcbhwhj7mPwkjZPXdUKL97igrTPeAfi8/YPqqBJ8
         YIppJ1aoU44rInQHqjJoYm3g1LL5zMe1YoNdgv1AtS4QKuLFe4O8ievqXJT7/pKtzyL8
         NcEg==
X-Forwarded-Encrypted: i=1; AJvYcCWIG5c3A2WN+l+HEI99kqTEYOWK297WDTdXVXaQl76IkQ40/ZYWW4/SdNXMpiFOpRWUWFxJ1lmSX1ROgActUnnsU7/X+q5a
X-Gm-Message-State: AOJu0Yx4NqNdQIANt+VpgoCfTe5xj2o3YtkHxCvgiu09jEcH2175Z3vU
	4NFJf2wTmkQ0Ec4Z7XbgoMsg7JbFBd5EJSLsC7uPs8NXAusnOcMyOPR1u5r/RYV9kmyoYsVYMo4
	Q1Y3LuHLJfiA0/yJKoh5XWSq29RJ/6J0Oc11DBkgeCTjbHJtalI81yg==
X-Received: by 2002:adf:e8c7:0:b0:371:8cd6:b2c2 with SMTP id ffacd0b85a97d-371946a4994mr1919316f8f.48.1723810350220;
        Fri, 16 Aug 2024 05:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPv25zqL6yUa6mNOIfdfg0gGN8v8qDRyWWiB7xsYgqkngqJeE4m8do+bUdWU8iQnOmAlJJYQ==
X-Received: by 2002:adf:e8c7:0:b0:371:8cd6:b2c2 with SMTP id ffacd0b85a97d-371946a4994mr1919285f8f.48.1723810349673;
        Fri, 16 Aug 2024 05:12:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896df5sm3520919f8f.69.2024.08.16.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:12:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D41CB14AE0A8; Fri, 16 Aug 2024 14:12:28 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: bpf-next experiment
In-Reply-To: <CAADnVQKNULb55aFOt1Di53Crf64TvF6p7upvUxLwSbrgMw=puw@mail.gmail.com>
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
 <87bk1ucctj.fsf@toke.dk>
 <CAADnVQKNULb55aFOt1Di53Crf64TvF6p7upvUxLwSbrgMw=puw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 16 Aug 2024 14:12:28 +0200
Message-ID: <87wmkgbr9v.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Aug 15, 2024 at 12:15=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > 2. Non-networking bpf commits land in bpf-next/master branch.
>> > It will form bpf-next PR during the merge window.
>> >
>> > 3. Networking related commits (like XDP) land in bpf-next/net branch.
>> > They will be PR-ed to net-next and ffwded from net-next
>> > as we do today. All these patches will get to mainline
>> > via net-next PR.
>>
>> So from a submitter PoV, someone submitting an XDP-related patch (say),
>> should base this off of bpf-next/net, and tag it as bpf-next in the
>> subject? Or should it also be tagged as bpf-next/net?
>
> This part we're still figuring out.
> There are few considerations...
> it's certainly easier for bpf CI when the patch set
> is tagged with [PATCH bpf-next/net] then CI won't try
> to find the branch,
> but it will take a long time to teach all contributors
> to tag things differently,
> so CI would need to get smart anyway and would need
> to apply to /master, run tests, apply to /net, run tests too.
> Currently when there is no tag CI attempts to apply to bpf.git,
> if it fails, it tries to apply to bpf-next/master and only
> then reports back "merge conflict".
> It will do this for bpf, bpf-next/master, bpf-next/net now.
>
> Sometimes devs think that the patch is a fix, so they
> tag it with [PATCH bpf], but it might not be,
> and after review we apply it to bpf-next instead.
>
> So tree/branch to base patches off and tag don't
> matter that much.
> So I hope, in practice, we won't need to teach all
> developers about new tag and about new branch.
> We certainly won't be asking to resubmit if patches
> are not tagged one way or the other,
> but if you want to help CI and tell maintainers
> your preferences then certainly start using
> [PATCH bpf-next] and [PATCH bpf-next/net] when necessary.
> Or don't :) and instead help us make CI smarter :)

Alright, sounds good, thanks for clarifying! And exciting change in
general :)

-Toke


