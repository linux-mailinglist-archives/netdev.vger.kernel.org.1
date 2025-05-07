Return-Path: <netdev+bounces-188770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27789AAE990
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D85D3AAD0C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F5F187FE4;
	Wed,  7 May 2025 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="T48B62Fd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141820E6
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643557; cv=none; b=S0vsfZPgc3cft9HQNxDjUNmooozM8lB1uHGXWecSxiAmVzPOufXbXsrmAN6Gusdr1LpWbUWd1S73VPqF9saPrxBskoUgIJDhYwjkhANLXLniMXJH70A6BnUdegmxvQfpgUH3aMcrbdpJAV8XYM0nI1MSuZa/YBN7bJ/sg1GpgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643557; c=relaxed/simple;
	bh=VIXRPu/FVcRTJFWoETKORYSEpBnDyMt+fHPdXw4uznM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsmpTDE+UDbEjjz+/h5MUW3A6a7tMKUOP3QuJr5a+K8Z1GfuY0UzqCcDkB9L7uRq9py+RUmsMZ7I0N8ddpDTL+9XoNpo0LcMMae1Yz0QgwDxcPEBfFp0yunkP7WVwjGlBoD/h0qMmsvgAQk+TJK0AHBXCdwYrqfKYKThjjvSPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=T48B62Fd; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v5yG4a2d0fGuR21h46QJjUGkT5Ehkv1tDaDSidyRBCg=; t=1746643555; x=1747507555; 
	b=T48B62FdDCEcbhCU6cbHcjWqWxqou1GuMJfwfQqQyGcszsaf4hF812D2oG+jO296+8BTM0yHyzd
	zjeb7QnF8E04P/J0YEBct/8OCNn1QAzoMZULzVpiGvy/av/vN7drkUtOuWGmbyzdKvRq7zUcuwFOz
	qphAOgqhOdp0tJ+bcf56YPkyrSvhLycsQW8WWEFbfLK9q4rPH7LORXokunQwDbvMRz+YP3S/C+2jg
	8VB+FMYnhakaJNAs6W/ET/hu62DXV2o9onk4kXX3Xse0bwQp/p3iUJcj4Wz2tvLsJuho0Eg/IX72Q
	2Zt9fyvFJ964fi7aMCPv7MMdqrhtzxsPqjEQ==;
Received: from mail-oo1-f46.google.com ([209.85.161.46]:60680)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uCjmC-0004Ap-Ro
	for netdev@vger.kernel.org; Wed, 07 May 2025 11:45:53 -0700
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6065251725bso134413eaf.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 11:45:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YxzD5h4tFllIjNGHYxCEFNvvm3vcZBgvo+1z3mHTMn+Q6V0GzlL
	1ygeTMWZdC82U/dl80s7XxkGvWA3w5W+vyGRNqD1drYpzgVeiuUhkMZJDJxsVNWrsMUZbV1e6Xl
	uMTiNavGFe+vlEzz+uNRu4Tl3jiQ=
X-Google-Smtp-Source: AGHT+IFChzdDXUoYohq2hj5IUyv1aYbsI5wqah55C6o9nrF98NLde1a9fGFNWgUxDUm2Qxe8uIUAZR52hUq7IwOR2Iw=
X-Received: by 2002:a05:6820:907:b0:604:18c9:79e4 with SMTP id
 006d021491bc7-6083397a0b8mr381246eaf.3.1746643552293; Wed, 07 May 2025
 11:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-8-ouster@cs.stanford.edu> <39fd697c-bff1-4d09-8979-c2a43a749c25@redhat.com>
In-Reply-To: <39fd697c-bff1-4d09-8979-c2a43a749c25@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 7 May 2025 11:45:16 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxB1NSKMUz6Z-KQG5kf_aY4e1i19RpYyRSprG0fRoW6pQ@mail.gmail.com>
X-Gm-Features: ATxdqUFbUBJk-BoRHTaW714M8d2Eyd4LvBoXRcXOPRGqLBfDMMBdpSYmRsz41Y0
Message-ID: <CAGXJAmxB1NSKMUz6Z-KQG5kf_aY4e1i19RpYyRSprG0fRoW6pQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 07/15] net: homa: create homa_interest.h and homa_interest.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 72f97ea9660f372cf635c7c250d627db

On Tue, May 6, 2025 at 6:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:
> > +/**
> > + * homa_interest_init_shared() - Initialize an interest and queue it u=
p on a socket.
>
> What is an 'interest'? An event like input avail or unblocking output
> possible? If so, 'event' could be a possible/more idiomatic name.

I've revised the class header for struct homa_interest to be more
helpful (I hope). Here's the new version:

/**
 * struct homa_interest - Holds info that allows applications to wait for
 * incoming RPC messages. An interest can be either private, in which case
 * the application is waiting for a single specific RPC response and the
 * interest is referenced by an rpc->private_interest, or shared, in which
 * case the application is waiting for any incoming message that isn't
 * private and the interest is present on hsk->interests.
 */

> > + * @interest:  Interest to initialize
> > + * @hsk:       Socket on which the interests should be queued. Must be=
 locked
> > + *             by caller.
> > + */
> > +void homa_interest_init_shared(struct homa_interest *interest,
> > +                            struct homa_sock *hsk)
> > +     __must_hold(&hsk->lock)
> > +{
> > +     interest->rpc =3D NULL;
> > +     atomic_set(&interest->ready, 0);
> > +     interest->core =3D raw_smp_processor_id();
>
> I don't see this 'core' field used later on in this series. If so,
> please avoid introducing it until it's really used.

Yep, that field is not needed in this patch series (it will be needed
when additional Homa functionality is upstreamed). I've arranged for
it not to appear in future revisions of the patch. Do you know if
there are any tools available that can identify code and declarations
that are no longer relevant when functionality is removed from a
system? I've been doing this by hand, but as you have noticed it's a
pretty error-prone process.

-John-

