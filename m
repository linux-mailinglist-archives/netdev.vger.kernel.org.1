Return-Path: <netdev+bounces-232499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A118C06064
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C42189E1CA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3C319615;
	Fri, 24 Oct 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZrSJioZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE3319600
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305147; cv=none; b=fyB+frtUvqe+eYIVf0JCEE187aPh/PU6WaJSGZyObavDzYwOd5/uRQjYO50uF/sMMa7/BpwB8F40n4KjGyqQlYnAHRI1bR6ah7nYoucMfwwFZeMhFzCbIN2UgG7HGfvTBrjU5idWoD59kaW5T4w/SafW5Y7Ia/eFF+bPrqDfNhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305147; c=relaxed/simple;
	bh=FunUh/QrCrIMTTN3QJHZHIUDliX59uyhIs7My4y9jUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnnga56PlgzkpnHWrjUlAmKRmbHhkU2QPDKGz1y21qTEMvHFb6u7TpEur3p1lWDQlGfX9KZg5sQ2cZNEFPOXdzCwFoj8Bcnr1UPp9NSwLeK8wKh3gvkJy8gXBDYzuOgcF7CeGUMR9hcLrTZIlyerPOGvBetXFhRh7JwaL1i4/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZrSJioZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e896e91368so24154781cf.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761305144; x=1761909944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAj7wvKv/P01OtVKn8wBd0lHp2FdjGQoEdeLNw8Ys4w=;
        b=fZrSJioZ7pTYU49Q6pkHeHEJdvjs4g3ZOc/Y5TbFXHnhXB2cT+EgXHnfxI/Jt2sELV
         YvqWII+QU/gCjI2TbPpoChvheEh5LLffk805EnCr1cVedWvoWN7XsETXn4npMJLYrot0
         U6bzA+QJsJ/f7lEAMpRXDxY/W6mlFNr8LXJpF+UzErWwgBrDZPiRzbDDknfpsBp9vJXn
         0tZ4YtkDYrrWa7Xe5JlsLuveNjHucfLR+eJ627wS7+KC9RuLrm2dVNbD1J5lSE7+ie9A
         Xf0EuRAeaT8Wgi6F/Y+WONZ4UAWRP6u1M4Xm09iFM6KN1wwCV+QwjVovIrJt+88B7Zzz
         X7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305144; x=1761909944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAj7wvKv/P01OtVKn8wBd0lHp2FdjGQoEdeLNw8Ys4w=;
        b=Q0xN/mGtm6kGRFUarcm30kMevTdjodG9aOjRa1pamlxoK9WBSkqX4tCwVseRcOmepy
         ZMNvOv2Hykel0xoqkb2uXdgHmqAZMMUntPUnT/QJB2b2Dn3Bgl1CFdBJFiL3EqhZfiRt
         eeDs7e9YQqbUD7IMERJJYshM9F144ogSacF4x4giRdv8p+Vd45IUYWNrMimmd/Mq3TR7
         iHRSGmOlomKQhX6KneHFSdO80Fo1iyOVMluw8ePK0cm9U2Cp8eRSf+6Zs2DvR0dyomp+
         Cc5uVITTlt1UeKHwAUgjcBWRpB5he83WQoVT+KchgtoFqkcvkQt+izCVrS9AMriB44lk
         y7IQ==
X-Gm-Message-State: AOJu0YxfQKa4Olwn8y5Fg6BAaiTsG85k2rlbQ0T8uhs3KHVfht9uRNBv
	L0jl7+ZGDHacBv5uU67UkMUyKG4SFJS1xLaQz02LCTjJP/mO/p0DqLNc3uyvc9Z3b3CdJxRsHbD
	+iCIt/Z8aFBcqp1qyGQ6AyEhwHWjaG3C76h1ji1TE
X-Gm-Gg: ASbGncvVXFqJvsnXzOUnDq2J24m9oSMzlByPunLF1ntZkvsFrafrd7FFX1Pj8gqNdjr
	T7o9XgIDuqVJLIppyxAWEEVu87+6HdhxlHlYBq7MPWnI+Wm64nMs0WeORgDH7uAEYvEnVda3KW6
	YGFPE9neahCDLx4hEIkQoVaUQuqDYeKk7HgNPWF7PJEgN+bqNCXCdTEoa3XqWVJljSYGeRO4YvT
	A0UwlpJFa2EqiwUqIdWxKhdgIOIGg0R8IDVRtF6i7wa8qZmnuuspNoHhFgou8jas4T41w==
X-Google-Smtp-Source: AGHT+IG7xGIWc2ateplUKpE2qGJyL1m13yxRZCyBquZ+lND6E1YCSitJO+U7+W4nK8YLcGWqNlciVvFOjuvdhDW+Poo=
X-Received: by 2002:a05:622a:1b87:b0:4e8:9081:a19a with SMTP id
 d75a77b69052e-4eb8153df64mr70737251cf.40.1761305143953; Fri, 24 Oct 2025
 04:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1761301212-34487-1-git-send-email-liyonglong@chinatelecom.cn>
In-Reply-To: <1761301212-34487-1-git-send-email-liyonglong@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 04:25:32 -0700
X-Gm-Features: AS18NWDWjqhvGHKLM662n5hdP4aqO7vUmSjwU_6eK3IlRlI-edra8_BrLNkOZGU
Message-ID: <CANn89i+khPeMERP6nVi21M=NH4v8sy3zASqAnZDs9FuryFsJtA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] add drop reason when do fragment
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, kuba@kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 3:20=E2=80=AFAM Yonglong Li <liyonglong@chinateleco=
m.cn> wrote:
>
> Add two new drop reasons FRAG_FAILED, FRAG_OUTPUT_FAILED.
> And use drop reasons to trace do fragment.
>
>
> Reasons show up as:
>
> perf record -e skb:kfree_skb -a; perf script
>
>   swapper 0 [005] 154.086537: skb:kfree_skb: ... location=3Dip6_fragment =
reason: PKT_TOO_BIG
>   swapper 0 [005] 154.086540: skb:kfree_skb: ... location=3Dip6_fragment =
reason: PKT_TOO_BIG
>   swapper 0 [005] 154.086544: skb:kfree_skb: ... location=3Dip6_fragment =
reason: PKT_TOO_BIG
>
> Yonglong Li (2):
>   net: ip: add drop reasons when handling ip fragments
>   net: ipv6: use drop reasons in ip6_fragment
>
>  include/net/dropreason-core.h |  6 ++++++
>  net/ipv4/ip_output.c          | 17 ++++++++++++-----
>  net/ipv6/ip6_output.c         | 16 ++++++++++++----
>  3 files changed, 30 insertions(+), 9 deletions(-)
>

Network maintainers are flooded with patches to review.

We want you to wait 24 hours before sending a new version.

Please take the time to read : Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).

