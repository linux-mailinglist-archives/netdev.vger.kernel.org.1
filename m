Return-Path: <netdev+bounces-169515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1673BA44485
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD8B17F404
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110814A60A;
	Tue, 25 Feb 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYCGeBpn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739D81727
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497603; cv=none; b=krdU+aBPgi+lRDW9OH+dwQS2/7XMQIpzQc9CQ3zpOtpwucv2qGMmgK4kswrh9NMlRx3UQKnmiLCKWK1lsAh41OE0a1eBLJlzV3tqEqdn+aAeqF0mv2s09oUf4x/a7dbXtfhOI1we71HTJyQ3tAa0erpiySu5u5WAlY4dynp4qG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497603; c=relaxed/simple;
	bh=C9Crx40HbvCbn4GeoVtQ3Ygq3ygOQ9nSYyB9A++NoMg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHma1PeJzMeouvkWJpE6oHcYsqTovum5Bf7PZA0tQKNrzujBljTPxmh+6JNWuCFqrPQMMnpQ3RV1qbgTEVhqtyZk4+/kcloU5PyfgiY/J2YWXJjDczZL5tHPeUEEhOdPLJFSJc+UHTmzAuB+Qi4GnE8H63iaH/KFbw4dDEwspSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYCGeBpn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740497601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9Crx40HbvCbn4GeoVtQ3Ygq3ygOQ9nSYyB9A++NoMg=;
	b=dYCGeBpnL/OFRieCnviYYT2PBOqH86lcjHyWVsBKSVmOEQ9C8wZgUeinNCBsXRpc4yjbvB
	vhXh0wQVa7LxVO84wLW85CTzU81DazskcilMcFoArZGSGHJ9j9Zezav06wcvZu2FWPT/6i
	tZhe3NmtchVyxbT78oADVD8kmwh3mzs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-9JInWnq1NiO-gXsQlSqf0A-1; Tue, 25 Feb 2025 10:32:58 -0500
X-MC-Unique: 9JInWnq1NiO-gXsQlSqf0A-1
X-Mimecast-MFC-AGG-ID: 9JInWnq1NiO-gXsQlSqf0A_1740497577
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abb7e837a7aso487349566b.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 07:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497577; x=1741102377;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C9Crx40HbvCbn4GeoVtQ3Ygq3ygOQ9nSYyB9A++NoMg=;
        b=uP55RdUPjBNuTD3hMNygfcVsw9LN4ZblUILhas0CcaeOs6l1NGcqqNkYii8TtCTJ5E
         wRbocQioyde1qrtLBbaJZOgq/qkHNtuu0qOziqqy9T7QlKDKqX6OP3sw2WJ1Ypfyl1t6
         QkkTTjt5qs0NYpPeMAZWWEMyPWX9VOK23g1SO/YlBKoI66zKtaG8LEfvGIRHoUFj0t/9
         DQOaf7lCgI/UPri/aMIwaCVbBQdecdBWbDITpcTWpKoJ0se00+3kQYVtjQsLhNeRb/4D
         ysNzKaBnPthuuNSF26rFSDTUXD5Zvm/mCqH0g8zxkY9IBt4i3T7mDib8NTI2JyQtbr14
         qMIg==
X-Forwarded-Encrypted: i=1; AJvYcCUvy4A3BI7/plpYtaE/vW5gUjDd9WewV6nyCAZer2C8rq8kkaXOohTV2IUCgzKmmzVJO3fixC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08g+jqS8s0+/rXwOT60xsFURS2lOBwdXQB+uF71NJhjD2rC2T
	ltdlffqgDB/gMryXMxZv4p8w39ufIfVoIzh/lgZpBzBVo9YR5zXSHN1CDA7IyMQyNk8ZVgxjxdM
	Sf1WISAJMO35Oe4hdqedFsb+XcjZm8Gtnuj3K5XYaya710zvWq57ZaQ==
X-Gm-Gg: ASbGncsvaznTgZfRR25FPm8Cx4dsuOC7ad5lE4ujfxCYXQr/QO/E9zT63+vQoLHWOzS
	AZ8zPPM7Dbnx+vymTgsZMqthWY0wtls+7fa9oQUI9MyLpWDCcU8JJYoEh4gvi/VTimayWF9dljx
	f71UK1wEcXSveSanmVxTAEAjTDgVtvziut0VCMIvDH7MjtWfB4t8txIpNDFH9BzMb1xKJPdj7jJ
	DMf+9PeOq4EtvWWF3pscN/AffMNrvgT+IHdOOkvx8VjuIiu/LUiMJ4JU68j/I2QhpXxf3PaafJ/
	oUq5ve8/tyiU
X-Received: by 2002:a17:906:30cb:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-abc09c19ea5mr1607976666b.38.1740497577472;
        Tue, 25 Feb 2025 07:32:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF3+i2Gm1aUPhUaBNxj5u5tbwyt3MeVX876gWJD/IfWjY9OJnLQDc37H8S9ky+bGoOp9yVRQ==
X-Received: by 2002:a17:906:30cb:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-abc09c19ea5mr1607974366b.38.1740497577103;
        Tue, 25 Feb 2025 07:32:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20134fdsm160623866b.94.2025.02.25.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:32:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5505318AFCBC; Tue, 25 Feb 2025 16:32:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Michal Ostrowski <mostrows@earthlink.net>, James
 Chapman <jchapman@katalix.com>, Simon Horman <horms@kernel.org>,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] ppp: use IFF_NO_QUEUE in virtual
 interfaces
In-Reply-To: <20250225032857.2932213-1-dqfext@gmail.com>
References: <20250225032857.2932213-1-dqfext@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 25 Feb 2025 16:32:55 +0100
Message-ID: <87a5aaxcns.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qingfang Deng <dqfext@gmail.com> writes:

> For PPPoE, PPTP, and PPPoL2TP, the start_xmit() function directly
> forwards packets to the underlying network stack and never returns
> anything other than 1. So these interfaces do not require a qdisc,
> and the IFF_NO_QUEUE flag should be set.
>
> Introduces a direct_xmit flag in struct ppp_channel to indicate when
> IFF_NO_QUEUE should be applied. The flag is set in ppp_connect_channel()
> for relevant protocols.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
> RFC v1 -> v2: Conditionally set the flag for relevant protocols.
>
> I'm not sure if ppp_connect_channel can be invoked while the device
> is still up. As a qdisc is attached in dev_activate() called by
> dev_open(), setting the IFF_NO_QUEUE flag on a running device will have
> no effect.

No idea either. I don't think there's anything on the kernel side
preventing it, but it would make the most sense if the interface isn't
brought up before the underlying transport is established?

Anyway, assuming this is the case, I think this approach is better, so:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


