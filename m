Return-Path: <netdev+bounces-69235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C184A772
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF001F2A75A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EDE4F212;
	Mon,  5 Feb 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JafixgZw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF004BA96
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162582; cv=none; b=UrmL9J+zOW8kmunlllMZIHxnZH7mwBQg+zGSpcffvVAtaSMhEHSwQEhZQAZhaODPAWtl1UBihEKs8F3eAgO9jERtieBkuYCiUXUte97Sky1ETWYJ6SrCXsRWejgkPy+yk1D4ntRzBHcYwoYmDooFvBMRIASNeg3fd2/0uo/DQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162582; c=relaxed/simple;
	bh=XtlAVK6YDcvQ+pR0/3RJq86cSBgtfjV822+OPR5KgHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrZ6Or16y8TaN1wZhYYh34XRLFfZsI1IWCVyv1GCHB74ohUlSDZ2kfcWMc3PRf90NdZ0ONHNmTGir284erOEOwORDqpA4jpkWoUbC4X1HwS5B8jGYPdR7vj1RpCoUvQPM8HpQjGwyruE2OHWOj5fLyPjl+38IXbTE7cif+quDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JafixgZw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnjll7ttqP5qOfWrHmrZxBvwGo00AeSiiRX6JPIK/sM=;
	b=JafixgZw0qxczemwQgpapEYs6Vl6XneM1pD/+RU384TdrD5Wu8BkgE6J2q2+mZ7cnMPqHS
	faixfNlqofxWPU3W9Zh01RdKgaBP+jCORpOgl2ipA1srAX/5yxdm9cZx08isqQHGEvpSOR
	DKAtOD5wNtfpZNvkow3HZIHLJGj8RlQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-vq7P0IwNNXuNZOw0OedIZQ-1; Mon, 05 Feb 2024 14:49:38 -0500
X-MC-Unique: vq7P0IwNNXuNZOw0OedIZQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55926c118e5so3286163a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162577; x=1707767377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnjll7ttqP5qOfWrHmrZxBvwGo00AeSiiRX6JPIK/sM=;
        b=PwvS+gHBBtME/9YuLsI+X27QU7way/vdk2RkFrWCjoeqflUPCZXMNp2bi7c8RRvHvf
         6JZpz1GyEUgCXgvS6InvZoyReEFvCYcsHnYMQOlj1i/Tvt/wgiQl3wX2mlOT2P67MnUN
         231u5uJuiX+7dj3G+PHa6GaqJNZalS/BAf/8YjfdP5X0BWPxKK7YRygshWi284Eh6Nsz
         5DUsxs8LfnC5Xj8aqt2kcjimd3y7rvXt7fdZ7d4YjUcFj6Z2dCw7L0tENmqIRFDJUssu
         QymwGJSh0OxHQzRJHz60gYU95i1GUHDNJ6MN5l3FElvmmFeMYQ2fyWCgmQJ/sOaXYoE4
         h3eA==
X-Forwarded-Encrypted: i=1; AJvYcCXD5Rut9PlgR8Ax8NxGc9HKoG5vPSs7Inx+djufnh3jnmC6NCKZgfIFu+C1EE31KbzwqaPLVivykvtTUXOiAh7mkLY2gShU
X-Gm-Message-State: AOJu0YyDNChkKu94u3IXXZQHXJnxbZULCLBZTKTxexaTTiiIOi83aM9b
	kozGw5YuR4Kkl7c1WxUzoXeKh6Lr7quWk9fCrtPDUVzwN64BpY9tGEeiqHLT3DHV+xsAR1etYAR
	m97XCrkcJZEp547sAf4g5IOu2+GPV3le9c3fGbBK9kn0ICZAesbIHVAB8ialxLCMwLAh6tkKJ5m
	B6v4xxtLU2ZJIwpS7McbunUYIF8C+a
X-Received: by 2002:a05:6402:70c:b0:55f:f5d2:ef27 with SMTP id w12-20020a056402070c00b0055ff5d2ef27mr26676edx.41.1707162577425;
        Mon, 05 Feb 2024 11:49:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBlSYwIisgeeQLdSLhQ5yBMT9FQ2Ei+kgu73drD6ctuVLS3E+BlVQEjgFpzoHQ+6IW9efo8m2HvcdOR1MzrqA=
X-Received: by 2002:a05:6402:70c:b0:55f:f5d2:ef27 with SMTP id
 w12-20020a056402070c00b0055ff5d2ef27mr26660edx.41.1707162577159; Mon, 05 Feb
 2024 11:49:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
 <20240112131554.10352-1-n.zhandarovich@fintech.ru> <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
 <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com> <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
In-Reply-To: <64dbd05c-4939-49ba-a8d5-807fe3ff2987@fintech.ru>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 5 Feb 2024 14:49:26 -0500
Message-ID: <CAK-6q+gEjqCrnFkpKSuQiuhpx9zyuWr6y0tQpJOLquoz2pnmzw@mail.gmail.com>
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Zhang Shurong <zhang_shurong@foxmail.com>, alex.aring@gmail.com, 
	stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harperchen1110@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 18, 2024 at 8:00=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
...
>
> I was curious whether a smaller change would suffice since I might be
> too green to see the full picture here.
>
> In all honesty I am failing to see how exactly it happens that cb->secen
> =3D=3D 1 and cb->secen_override =3D=3D 0 (which is exactly what occurs du=
ring
> this error repro) at the start of mac802154_set_header_security().
> Since there is a check in mac802154_set_header_security()
>
>         if (!params.enabled && cb->secen_override && cb->secen)
>
> maybe we take off 'cb->secen_override' part of the condition? That way
> we catch the case when security is supposedly enabled without parameters
> being available (not enabled) and return with error. Or is this approach
> too lazy?

I need to see the full patch for this. In my opinion there are two patches =
here:

1. fix uninit values
2. return an error with some mismatched security parameters. (I think
this is where your approach comes in place)

The 1. case is what syzbot is complaining about and in my opinion easy
to fix at [0] to init some more default values of "struct dgram_sock"
[1].

Then 2. can be fixed afterwards.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n474
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n435


