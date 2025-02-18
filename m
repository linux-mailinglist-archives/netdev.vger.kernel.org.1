Return-Path: <netdev+bounces-167512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7061A3A87F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7702163AEF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D821B9ED;
	Tue, 18 Feb 2025 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVyxnEKw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190F21B9C6
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909693; cv=none; b=A7eaTu/D4rqOdRiFXk7GWqrwNQb1NivVy4PQIGMFw/O0z5ynF0ppoW8lAXEKLkLlcxN9w4NdX6D6kaPV4m2kK3ZoEP5Lj2cTVD8d889oojm8gFEAkNpFErlVvxDy+0SJS9MNTJSnOQ9YWRnaY8y+gVKvBTuJpEh8RaAlElhj/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909693; c=relaxed/simple;
	bh=Xc/kJEBoZwhxwkP0//By7fRo9s/ooChZIIAU+xOEC+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6T3EjevGcCp2E9g6HZ/CHF6+ZB11nhDtYVQLHUTc8Vp1oMXv4m7qZDi72ExQUC/+1gvXhtP2iHR7Raa4rbqTrxcsdU7fZPfKYnLPtW/cLuJlA9ps4vAYcTBbfDuj79f/zvwIHviUa+YR5V25eBB6ECBjllwPbxWoWtuzaoY1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVyxnEKw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739909690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xc/kJEBoZwhxwkP0//By7fRo9s/ooChZIIAU+xOEC+Y=;
	b=CVyxnEKwMQUvJ6/f33IpHOBedDoKHlpbC3f0/30Ao5KqY+m7kWOj1oVVfdzMXXXTfkTy1e
	w7o2iII8t8CkNwc0C0kXqqmMWttVwI3GBg3uvM6/EJ1Qy2Q2aVfYWektcXgYBRxkYfX17R
	1uRrZFgW/Fnw4pDj/X3O+5DstxrlYmQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-7152R-ZYPACHJecvv25jww-1; Tue, 18 Feb 2025 15:14:47 -0500
X-MC-Unique: 7152R-ZYPACHJecvv25jww-1
X-Mimecast-MFC-AGG-ID: 7152R-ZYPACHJecvv25jww_1739909686
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab76f438dddso692826666b.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739909686; x=1740514486;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xc/kJEBoZwhxwkP0//By7fRo9s/ooChZIIAU+xOEC+Y=;
        b=VYKWHfRWnjuI1OEW2zxdbEyxeO9CF8jlnIY6yH/ZnJsP5w8Yf2cmUHqQHKN+8NkfH7
         uobmwFQG0IujNdVfaGk9Sp8Y7SRGYSzaUXQfnt39OulQq894O88qd6yRNL8mYZgjPPqr
         r2/keWGE131v7ae7pTXmK3PpFnocBGvVZ+9n1HQCGFiS2O4RPLrlgt/zLSxbDLTUc4BL
         n16zAuElwBW2NgrXnptWP/Xo0n5AMoGqWJHy7b0k2e8dJvjkjZ6fFANJuL3x0vFuZTvg
         m/VgSJbW8Y5s290EKNylfsojI8i39eLWicOSkUtjLFBzAE6/0iL4nEKidd0ZlD6B2es6
         oNeg==
X-Forwarded-Encrypted: i=1; AJvYcCWPRJ6o/zxzMlmOzd0nQ52s4ZHGNTzS7gMu19st69ERpJYDe1e48tFr2FuJDhyoQEfywBJeW3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0urkCFpBuWCFu8RcUlREAD+XqGtGkqMlssEZU7x8bG7+q1OD
	etx4lgJsMGx4HK7h23sqOWkqBL8rQG2yMpf+AciIMlEBhdvBMpd5l+J31nHqS8C8zVGxvgfWYBR
	POZ96cgdQ5TI+P5oSqPbyLIs5dRxTlsTvh//8NChrKpV2wKCPvu+6CA==
X-Gm-Gg: ASbGncuPJ38AmZh7ktixTn0cA4FtZ79OnEMQki7mKZsWoK/xqEFKFku6gygYlvPt3nT
	47P53zez5iD6Qutz/Q05/3a6roNyo8+XTPWbtYoQz8v5bRKKUZEx9dEW4Wx0w2xdP3wMj/4EssX
	vDQDFp0qWSxn/0uTewvzbSVXPFVp5YY4IaWcHC7cd58l0IFynZZUIlU7ghVAtK3ICczP4Qu1+Jc
	ljq1+LQCAof5Pnx5ECWZph83h2w7gZK4+v7Dt42ucXlTTjOnIisBrU8tgXyL6UK7cdtGlr7bU7f
	SSM+oMOGu8n/VTEgLnxbCgcuOj52pQ==
X-Received: by 2002:a17:907:1c21:b0:ab7:84bc:3233 with SMTP id a640c23a62f3a-abb70b39c8emr1517404866b.28.1739909685985;
        Tue, 18 Feb 2025 12:14:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYqJOnHz3GePRYH+9CXggo4gT2wrzIxv+f1N0iVzcISbgRt+dZe1rzcbqh8W7030iAy3+FMQ==
X-Received: by 2002:a17:907:1c21:b0:ab7:84bc:3233 with SMTP id a640c23a62f3a-abb70b39c8emr1517403066b.28.1739909685634;
        Tue, 18 Feb 2025 12:14:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322fcsm1139431766b.15.2025.02.18.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 12:14:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AC8E9185031D; Tue, 18 Feb 2025 21:14:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
In-Reply-To: <20250218063710.7e1ba2ab@kernel.org>
References: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
 <20250213074039.23200080@kernel.org> <87zfipom9q.fsf@toke.dk>
 <20250217095150.12cdec05@kernel.org> <874j0ro1pd.fsf@toke.dk>
 <20250218063710.7e1ba2ab@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 18 Feb 2025 21:14:43 +0100
Message-ID: <87zfij57t8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 18 Feb 2025 13:51:42 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Hmm, and you don't see any value in being able to specify a permanent
>> >> identifier for virtual devices? That bit was not just motivated
>> >> reasoning on my part... :)=20=20
>> >
>> > I can't think of any :( Specifying an address is already possible.=20=
=20
>>=20
>> Right, but the address can be changed later. Setting the perm_addr makes
>> it possible for a management daemon to set a unique identifier at device
>> creation time which is guaranteed to persist through any renames and
>> address changes that other utilities may perform. That seems like a
>> useful robustness feature that comes at a relatively low cost (the patch
>> is fairly small and uncomplicated)?
>>=20
>> > Permanent address is a property of the hardware platform.
>> > Virtual devices OTOH are primarily used by containers,=20
>> > which are ephemeral by design. At least that's my mental model.=20=20
>>=20
>> Sure, any device feature that comes from hardware is only going to fit
>> virtual devices by analogy. But I don't think the analogy here is super
>> far fetched (cf the above)? :)
>
> I'm not sure how to answer this. It all sounds really speculative
> and disconnected with how I see virtual devices being used.


Alright fine - I'll respin the netdevsim patch instead...

-Toke


