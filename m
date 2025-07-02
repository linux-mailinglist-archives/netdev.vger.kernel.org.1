Return-Path: <netdev+bounces-203371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1E1AF5A69
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DE41C22D5C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB062857E2;
	Wed,  2 Jul 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWjV0Gld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97119277CA6
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464962; cv=none; b=sQfwWWSKrONdnBat4rAZ5Y6GXhAyrKkZMN4S21JxgkjEru9gEfoRn0w0zPyfLdzHrlJieMKOOONXJimXCU2TNBhnk5wywo1S/lWyvcKrJ9iDGweParN3zIACn+OjOW7+Q1PxAWI/2nMIHVomtjLUbd4p/tHWehZEXzDsIJon+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464962; c=relaxed/simple;
	bh=au8lDoPnHHAjIaSnJ99Ta7vYDcZpfeKmxV6mR/w0U/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJdNUPCAM9pE4vAgWTnFAxAcBlyEUSSRUClxtFsCct4NZPJjbAb1upAEJGNOj/HUmrf9xI3Mk4ZHGcTpVZRwf32cVB6xfJvpliic6Mb9d+3TbQG1KoP+HHEwq6Nz7e5wq4f1sX3BIpSYQuLBRzwIFyy69t39ctgirXHQtcsWLZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWjV0Gld; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a585dc5f4aso79452561cf.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751464959; x=1752069759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDsxmFPSdS4IlYHnsA2Um+LGtK/4VYhWhmhj+jKqT6U=;
        b=dWjV0Gldu4Cyqla30dtsPn/XR8fgc1Z4kJJkYmuGXCLl7wosxuKVM7YpboqFWgc2hx
         DduMcKrpfT5i/dyKp2KQ8i+Ap0bQd7DW+JqAI3unKNcxrikojcmAjLDc3f1ZsbpsHqPO
         j9tTho+K6qLiFW4tqj67bV+ydclUPxMXpai2T7XbkTgmTksEAgDp1YDGc5MzZz5wbdb7
         QDW6T+auj/n6zgvgRJS0oP8QKKOxsTKkU1gfOMYBN8irvnOAtlnvKXB4gGC/7CQUZ3D2
         M4QCiUgpqnVshXacL/hUFGMLBKzPDC+7+8WuWS5Xm2nriEb9hgvE/Cwz385fRVtt2Bgk
         CoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751464959; x=1752069759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDsxmFPSdS4IlYHnsA2Um+LGtK/4VYhWhmhj+jKqT6U=;
        b=lrvknTvTx5VaYbwmePTLNK051LkOC3BjFLMWOydR3B9e3jwBInmVgMDTt+vYqXzRuP
         WNjFJLqtq2puYEaaO3IinJYfzqo8Ly2WW/PioTqR8ujSFQ00Ss1FvFrF5+2O1HcFEnfF
         V9fkTmKsxIuiDUG+n5joPLLDPOx5Z+31ZlQ+MDWpaawcOGS8rFoiS0/m+tFwHVJCOQKb
         RzQeL83YmPbz0CiWA+Jrxn6ExjyqTMIww86KkG0QuCBVJ68rU3CtObRwp89gjIRA0Rfl
         2c7zv93fr+3cRy3mWRBK+WNj5aBEBazQu5oHLkH4wxsfi4MIFBiaO8UhOqu46l9nwwHQ
         zGXA==
X-Gm-Message-State: AOJu0YwUtAuMl98jhsrox87+aiH13w+OL3qkM8UX9dEZBJr2cY+K90d9
	qBvA+LeqkMVLlD3oD5uKRCQBGOCkJlaQtsArWXyiNUMi8uF43Qp1n0redY6X39g4UM3m9ZRiwVN
	4St8LGDmuZYDKrSD7/gBSp1gRCJdrS1iusRPZiWkZx+I3FAn9iDeKZxfscv4=
X-Gm-Gg: ASbGncuyYvBH8Jqyjjzcx3ykql6uVGqiz8GWTaMynSb9uREd0YaAJMlWTJA+N0u4Xkk
	OgTLsoTdoo1hJ5D9IpJYc9VQC8YFvklVtY1S6ZfZ32An0ZLbAx16WHQZYxt+A2Pjlc8jBGqVRuX
	ckdeizujuVoro5C1nhPFcAfvOHspdPLAIprQtxUkOBLA==
X-Google-Smtp-Source: AGHT+IFbF9G6vh3MukO6aBJpYKW/hcKdIcWaNoMxfXYUo16gF6b9Evfx/JNl1SrWK1BIXK+jeyYf2F/GkWqpIYJIhE0=
X-Received: by 2002:a05:622a:11c5:b0:4a7:f9ab:7899 with SMTP id
 d75a77b69052e-4a976a53c98mr49828831cf.35.1751464959071; Wed, 02 Jul 2025
 07:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702110039.15038-1-jiayuan.chen@linux.dev>
 <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev> <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
In-Reply-To: <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Jul 2025 07:02:27 -0700
X-Gm-Features: Ac12FXwMIS3lW_uVU7P4nhYxGHAR81RWZmByuPLVEv6OHHFXnWu1Z9-FbDLxxPo
Message-ID: <CANn89iJD6ZYCBBT_qsgm_HJ5Xrups1evzp9ej=UYGP5sv6oG_A@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:59=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Jul 2, 2025 at 6:42=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
> >
> > July 2, 2025 at 19:00, "Jiayuan Chen" <jiayuan.chen@linux.dev> wrote:
> >
> >
> > >
> > > The calculation for the remaining space, 'copy =3D size_goal - skb->l=
en',
> > >
> > > was prone to an integer promotion bug that prevented copy from ever b=
eing
> > >
> > > negative.
> > >
> > > The variable types involved are:
> > >
> > > copy: ssize_t (long)
> > >
> > > size_goal: int
> > >
> > > skb->len: unsigned int
> > >
> > > Due to C's type promotion rules, the signed size_goal is converted to=
 an
> > >
> > > unsigned int to match skb->len before the subtraction. The result is =
an
> > >
> > > unsigned int.
> > >
> > > When this unsigned int result is then assigned to the s64 copy variab=
le,
> > >
> > > it is zero-extended, preserving its non-negative value. Consequently,
> > >
> > > copy is always >=3D 0.
> > >
> >
> > To better explain this problem, consider the following example:
> > '''
> > #include <sys/types.h>
> > #include <stdio.h>
> > int size_goal =3D 536;
> > unsigned int skblen =3D 1131;
> >
> > void main() {
> >         ssize_t copy =3D 0;
> >         copy =3D size_goal - skblen;
> >         printf("wrong: %zd\n", copy);
> >
> >         copy =3D size_goal - (ssize_t)skblen;
> >         printf("correct: %zd\n", copy);
> >         return;
> > }
> > '''
> > Output:
> > '''
> > wrong: 4294966701
> > correct: -595
> > '''
>
> Can you explain how one skb could have more bytes (skb->len) than size_go=
al ?
>
> If we are under this condition, we already have a prior bug ?
>
> Please describe how you caught this issue.

Also, not sure why copy variable had to be changed from "int" to "ssize_t"

A nicer patch (without a cast) would be to make it an "int" again/

