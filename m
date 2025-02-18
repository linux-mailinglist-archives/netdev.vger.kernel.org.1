Return-Path: <netdev+bounces-167328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05797A39C87
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D43188D00F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD725A62C;
	Tue, 18 Feb 2025 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzqjgusV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF125A35C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883111; cv=none; b=gCxdZZBlVKeWMKrgsBHbi1plx/LnurWlDa5FUejQNELQGvrGqJazzZB2JQiJ9NhvkayuCnjBa93uI0V70Bk3gzCIn0gHHDSbPnnUBZE6y01OgyzRSBBMhUMJ9J9cO9fzi06yNwfJtWFPJp9aiqqnazTFKICz2GFTZkKV9940jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883111; c=relaxed/simple;
	bh=yDeksfbZKe1JdBhjuF5yIitFtTc58RboGR1pDNtz+jA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBu0Vnxmp2BMEv0+zJ7qQ45xpRLFsrmXEUJOi3+1HeEhu1Gk74b3DN3eTsYVgPDeBfe6X/FZt9cQb8vM4pUTzsi2MU7U5e3PdqxujxfPMuyaBS+UOsIwfEMmZDk8zNJoW371dbcdzeEnd+QGdIdgC+6xsmLtN71SUFL5qjiXeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzqjgusV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739883108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDeksfbZKe1JdBhjuF5yIitFtTc58RboGR1pDNtz+jA=;
	b=GzqjgusVOazxyh+CSd20H7ubxnb3GDXP3O0V8d/54Js0K/Dse3+ns41X3BJBzJpotJtSWf
	1hipE7LJs/Ceetc93F0eSe/RTEIQuik9A6MwZ++uehDGZSUoA4VaHJFWfqt4p5hpKUOMqr
	+GzoJE0SJDs1/RHB9qS5kpVV1K0sxy0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-gdvCWjrAN_KTO5lQr3MXXQ-1; Tue, 18 Feb 2025 07:51:46 -0500
X-MC-Unique: gdvCWjrAN_KTO5lQr3MXXQ-1
X-Mimecast-MFC-AGG-ID: gdvCWjrAN_KTO5lQr3MXXQ_1739883105
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5462c601f48so252594e87.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883105; x=1740487905;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDeksfbZKe1JdBhjuF5yIitFtTc58RboGR1pDNtz+jA=;
        b=l3DrEkbAhwoZdZFtvpTIexuk6YChjg924jk6b6/bcERlYHwz2HGrVDCP1UjL7qua2x
         WfJ0Ez3RfCD1eHyvyppOn1DAL/CEvMbvIeCRzRvD8ENLqgR7tGHDyJJ2PxJb8dLBFKev
         lZKXxcOvm11StOsYqLtCOGTSQYF9QCjK7oTkYbNfEh1/iv/DeYBt6C26nlhrOiN6uwae
         8mhQCDks+PxetA7HxKgPezxJ5ljelrZ107TbhakK/uYqlgBDUlYnBaLdPpwH4Z/NEm/e
         Lr256PWrSST7KyIuoHDZmYU8jx3lkfvx9w92ZlQKejOsTRGQBvujM1njPKtYHUKHaDPI
         GULg==
X-Forwarded-Encrypted: i=1; AJvYcCUI8r8GBkSHtcWqLVVdFGlElQhFj3nAc4QHAWXawRRUbXOTf8C3VuRja5SwDJnrYkdAYzInjzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGw08JvaJ36/GZedZRhYzi8oK0Xk5QAoc6Eqi2RfQq0x9+B7g
	+SoQZNecsBd6VitJCf2mPBmriC+cMV7Sx/cm0TABDTwptCeMeNEnrA0P4x6K2IuA3HL5uYCMzJ8
	LumDmEaSCvxxU1e3uTEgY7yaEzcLxdBrtweqXXVwwPZGgd+NoF4zG7Q==
X-Gm-Gg: ASbGncuDweATBYLNyrBopy5xeD9yGTPVHv2CHpskLiBmZ8iFPykaURa1+w9bfVSDUl0
	of5KhpDHJKihXLoERcqew+kQQFqdlnVP6jgemF0DFksIRQLcKumSYR7lrzCF2Y2OWBllFhjS7ob
	adnKlUQtpP0zemLcFBKXgcZlsW+VIiMlKkkJkxhZXOccg6SKm1X2dBseVhYUvISG7UC0OhFLo3E
	1I+hCz3rWp0xxe9IkdZ1scnepPRgZPnj4J1meXHJK99AWlAj+wDPvLXRxOR5l9jUFnY+Q7PKt7W
	+w==
X-Received: by 2002:a05:6512:31d3:b0:545:2e85:c152 with SMTP id 2adb3069b0e04-5452fe8bec4mr4597943e87.34.1739883105294;
        Tue, 18 Feb 2025 04:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDB6OdZI9uKwygC2D3eM9WhtOarfSlBLR7LXmDhxom0B6+5cY1SrgMcEswSUgxEE3VlJqKUA==
X-Received: by 2002:a05:6512:31d3:b0:545:2e85:c152 with SMTP id 2adb3069b0e04-5452fe8bec4mr4597928e87.34.1739883104895;
        Tue, 18 Feb 2025 04:51:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5458da7ec7esm1087076e87.103.2025.02.18.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:51:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7CD94185024D; Tue, 18 Feb 2025 13:51:42 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
In-Reply-To: <20250217095150.12cdec05@kernel.org>
References: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
 <20250213074039.23200080@kernel.org> <87zfipom9q.fsf@toke.dk>
 <20250217095150.12cdec05@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 18 Feb 2025 13:51:42 +0100
Message-ID: <874j0ro1pd.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 13 Feb 2025 17:13:53 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>>=20
>> > On Thu, 13 Feb 2025 14:45:22 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:=20=20
>> >> Eric suggested[0] allowing user-settable values for dev->perm_addr at
>> >> device creation time, instead of mucking about with netdevsim to get a
>> >> virtual device with a permanent address set.=20=20
>> >
>> > I vote no. Complicating the core so that its easier for someone=20
>> > to write a unit test is the wrong engineering trade off.
>> > Use a VM or netdevsim, that's what they are for.=20=20
>>=20
>> Hmm, and you don't see any value in being able to specify a permanent
>> identifier for virtual devices? That bit was not just motivated
>> reasoning on my part... :)
>
> I can't think of any :( Specifying an address is already possible.

Right, but the address can be changed later. Setting the perm_addr makes
it possible for a management daemon to set a unique identifier at device
creation time which is guaranteed to persist through any renames and
address changes that other utilities may perform. That seems like a
useful robustness feature that comes at a relatively low cost (the patch
is fairly small and uncomplicated)?

> Permanent address is a property of the hardware platform.
> Virtual devices OTOH are primarily used by containers,=20
> which are ephemeral by design. At least that's my mental model.

Sure, any device feature that comes from hardware is only going to fit
virtual devices by analogy. But I don't think the analogy here is super
far fetched (cf the above)? :)

-Toke


