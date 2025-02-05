Return-Path: <netdev+bounces-162904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20086A2861B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E169F3A7048
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5D213240;
	Wed,  5 Feb 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzTktOKs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE73131E2D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746325; cv=none; b=d32qPilVlUsggQXd/mwh9NLSQnEYnYUEttlNE252fYBRcu4B+jQjpt4jw3JS28HOmIvvjB22bXQkCGuE24WFohEEvT/t8Zsd1wT5DieyH2vRUUpkShbcPMdtqNU4WbDap/mOsgRcORx9eF2CSVnHahaJpdcOK6vYBHejvvBmTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746325; c=relaxed/simple;
	bh=Ak+NGjfmFkLzFCZKIdMOneqNI3wb3o4wgMJ3/8+MsXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SV8niEGIbOoD8dYP1eSUDlZnmo2Yt4fIo1ymcuz8vNCAPth8M+xh8TsyVmwD8vER3lsBjjooPE4YVX5YZqktlihqQw6WuNdqt1AcUg2tSNZYCRRQMHksbhmb0eOuvLJ+K5oC0pvLpZxfLsorTZocQfzZrAfaBWWq/dtbmxG8QsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzTktOKs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738746322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ak+NGjfmFkLzFCZKIdMOneqNI3wb3o4wgMJ3/8+MsXg=;
	b=dzTktOKs0ZnQnJjDVp2vrV0zx3x9xOIC4ZZOW/fi5PHrRsDx3gA3V9gRFVxrr+arHMvcOY
	kZ3sPi2ai2mKmPqFZI67E86WgZbJQJqGfME13VjQsrxOO5hMQAG3ODYU0w5CcN2kq8Zse9
	6IqAFlsydxQLGsnjfbkQ3cOBvl1lVgw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-rlST-uS4PzGGpWRVrQ6--A-1; Wed, 05 Feb 2025 04:05:21 -0500
X-MC-Unique: rlST-uS4PzGGpWRVrQ6--A-1
X-Mimecast-MFC-AGG-ID: rlST-uS4PzGGpWRVrQ6--A
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6b904a886so592791266b.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 01:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738746320; x=1739351120;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ak+NGjfmFkLzFCZKIdMOneqNI3wb3o4wgMJ3/8+MsXg=;
        b=gOd8aQ7F30GtBURm7/eYRxxCNQcyrNtppcgD8aznOymUtfuwe8xdqITekLaqAGEqHo
         IIacyRI5He09P/kocwS+4VIQ0KcNjQALOPF7cmvx5QvLs+tRjyrCUvYatiKEoXgEmVFw
         M36XuBoGxLJsWg+gKdE3FGNdB+Ns0NsGJLWFMsPcRhC8fZqFfV9n048xsCpowm5FvIYl
         3MAJBh4mXcTeZgOnLtIExYFKdrKwaePtKQw1GOnUFUoB49u3kOZqG1cC37albKLlr2lF
         mdHDatyMhKnuIJHp1Ry5t8+zw7xAZJEOcMavr1oqAwTr1RbtghVzI9DtQnE54So294rN
         lT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVphEX4qt0lHSfNlLcSkRqieFpP7v3ct9jtmwv7C0fLsMqQbCPmjy7iIr2nfhbBCaElPyN0U7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw10BOY2RuVIvNdjgU1OzPOQvXH8juNcTtlghPo5TPT7t22qkr
	1yau4DxIaIQIvvwXTYbsn1G+oa8WCn5m/UUn+u4L7i9adMO1FLhcNXymXhQknPDjkH1Uudl48U5
	wnyqCFtHSM4phFoL4VMme7r1UGVaDQ0MOus/TBc+OSL8HqjLXf854wg==
X-Gm-Gg: ASbGnctZErqq5Ud3mAXz69AQeGlt3sdcINrdP2PqNgy5qDsJludVx0wZXGapsUQk1or
	KfZp8vHG5dzlVrbU/09nr1vppR25wJ8BuXoHXGpQr2UBbmvykW+P5i3OUMIkHUG0UgVUrVfApTs
	PcJKyq4AIR7vqlUYGO1hfdt9sryK4tlC9FpaN1/p6a3qaJvQH38qi/gQVf6BXv8ZBKMd/BbXN8Q
	ncYg6dPLGtByd1jTVFPqHHEAhzyOYCtltr6fM6T0A24zlREO3M4D79CFEVmivfQafQ7McuKPFMB
	H2pJO7RS+dl2p85uWxbow8hI25d3Ew==
X-Received: by 2002:a17:907:96a2:b0:ab2:faed:f180 with SMTP id a640c23a62f3a-ab75e27cdebmr202683866b.33.1738746320042;
        Wed, 05 Feb 2025 01:05:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpjETfLmrSBMLq/pcQVVkd4lbXzq6HytNl9JNAnnek9lltci5/MIVWyypmldy8SbR51GGz5Q==
X-Received: by 2002:a17:907:96a2:b0:ab2:faed:f180 with SMTP id a640c23a62f3a-ab75e27cdebmr202680066b.33.1738746319629;
        Wed, 05 Feb 2025 01:05:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7008b2c04sm858244766b.33.2025.02.05.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 01:05:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A5CF2180BE88; Wed, 05 Feb 2025 10:05:17 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netdevsim: Support setting dev->perm_addr
In-Reply-To: <20250204085624.39b0dc69@kernel.org>
References: <20250203-netdevsim-perm_addr-v1-1-10084bc93044@redhat.com>
 <20250203143958.6172c5cd@kernel.org> <871pweymzr.fsf@toke.dk>
 <20250204085624.39b0dc69@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Feb 2025 10:05:17 +0100
Message-ID: <87seosyd6a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 04 Feb 2025 12:20:56 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > netdevsim is not for user space testing. We have gone down the path
>> > of supporting random features in it already, and then wasted time tryi=
ng
>> > to maintain them thru various devlink related perturbations, just to
>> > find out that the features weren't actually used any more.
>> >
>> > NetworkManager can do the HW testing using virtme-ng.=20=20
>>=20
>> Sorry if I'm being dense, but how would that work? What device type
>> would one create inside a virtme-ng environment that would have a
>> perm_addr set?
>
> virtme-ng is just a qemu wrapper. Qemu supports a bunch of emulated HW.

Hmm, okay, I'll pass the suggestion along.

>> > If you want to go down the netdevsim path you must provide a meaningfu=
l=20
>> > in-tree test, but let's be clear that we will 100% delete both the test
>> > and the netdevsim functionality if it causes any issues.=20=20
>>=20
>> Can certainly add a test case, sure! Any preference for where to put it?
>> Somewhere in selftests/net, I guess, but where? rtnetlink.sh and
>> bpf_offload.py seem to be the only files currently doing anything with
>> netdevsim. I could add a case to the former?
>
> No preference, just an emphasis on _meaningful_.

OK, so checking that the feature works is not enough, in other words?

> Kernel supports loading OOT modules, too. I really don't want us
> to be in the business of carrying test harnesses for random pieces
> of user space code.

Right. How do you feel about Andrew's suggestion of just setting a
static perm_addr for netdevsim devices?

-Toke


