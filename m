Return-Path: <netdev+bounces-73052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB02485AB88
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA301C21ED2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7877482EC;
	Mon, 19 Feb 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuZ1LbZd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D344C93
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368732; cv=none; b=CKOErIQTjNdUhRYjvVh1SYmh8n6CzZTAIk5WReN3+O3aEwYSZNhta2B80dp+DY3+x0d1DVfxsow2h+DKthDCTUyY9r0DvEINLojQpmX75cbkEJkECEBfiMPWV8PGAOZjZO76VKqOF30RtesGpwWsBmYp4otSfIcNfrhXd8oxwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368732; c=relaxed/simple;
	bh=adFeI6iQIPSIG5gbGYxAui1bsv/pb6agfE1uD23Yq2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OC2p2WFGfYYQ94Tr31TvNWsM43++oF6XRjXJp0meFcE9hVDGFZ457xCXgx/ukhXqgIczJHa1ZxZCDSF6xvsjx2CU8hU6RDML9MgsfaEQwRZYQ+j480m6T9jSK5wx2decIfME4URJHmS7NKZ3g4Gtp3DSNCbQ+BU7fahfQTWIi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuZ1LbZd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708368729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSiLtRn1dHXbv4XxLONcqsZTvaAnMgcW65jKFt4NQe4=;
	b=OuZ1LbZdxLnIYoAX/b2+IMpkNLLqevMpW6uM4sJUhnJ/OVZ6U09195VHmf4t7KjPSz7Rpi
	iBSwjxfNXwu5hFAHVjlsf4ssZz9TbQoXRy3/ka6i0naXjwsTe1UCswaeCnhHsUgdvBqLuC
	PIOQdQRK5aOkxW/JfD7pJBNPpvjYJ5U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-QKZXI5vXPAygCNUx5dQIRQ-1; Mon, 19 Feb 2024 13:52:08 -0500
X-MC-Unique: QKZXI5vXPAygCNUx5dQIRQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2f71c9f5d2so274363766b.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708368727; x=1708973527;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSiLtRn1dHXbv4XxLONcqsZTvaAnMgcW65jKFt4NQe4=;
        b=Zz1ghdlrrtBr3YMzDHHrqPi/NwLTT1BvUPe9pp5mr4C8LLlUT0IHJdqhlq360EEXum
         HpIH1RCwJs7qgafFlbfMX0iWRGWaACcMIFouxcuGqjs4il0bbTbzCDqDwGq2SC/ujP+X
         yjfYJaeq7xSRMUz5DdVe0yYPTrNuP0sSAJWabZZ1un5l+00nYiHGv+2GnYRLql3dj900
         Tw1g3v73O2KxFUUEjMN0VFKrfwn3EkLxHdiOI/W6AeNPOKhu3OSNhqoxD1xq/3HryCXj
         Eyrwfsj3fnYnqscqRPCEHYu5dgQFjg1diA0O/PD+xLAR6MqBs6nIGLXPMX0Cjb0eDdX1
         66NA==
X-Forwarded-Encrypted: i=1; AJvYcCWeQEt31tgZV2bpwFBUzm5Z+5BWmTk4dP9oG2XoMacRYKE+kRgqwGB53F6qtPNlruS8psYUmBfIwxqsQJFWEYihnjggK6t9
X-Gm-Message-State: AOJu0Yy5DtuCtrx2bdaj21TWsmJFvZsP1vn12n0HDJOGmy6jCD3hJ1ze
	NoP5n+4osTROsYUzUkeRhozySD1lKBZS+t0QOv9/dLLRIoTCLTBlnRu9BSdBlyTMbprpN5aVIli
	a/6msHB/b0UXdwJw/HaUfq0NKCLsZFKsxy0TbCxDHVWMouMr8G6lUyHhyt7Ussg==
X-Received: by 2002:a17:906:3485:b0:a3e:b4af:def5 with SMTP id g5-20020a170906348500b00a3eb4afdef5mr1825498ejb.31.1708368726936;
        Mon, 19 Feb 2024 10:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgELklgy0YvniicQ0U5zqLoEKoEk4TmgmT3CDbzF3z9jnML3ol959N9niiDB45nAdaNROO3A==
X-Received: by 2002:a17:906:3485:b0:a3e:b4af:def5 with SMTP id g5-20020a170906348500b00a3eb4afdef5mr1825485ejb.31.1708368726545;
        Mon, 19 Feb 2024 10:52:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x19-20020a170906135300b00a3e64652a68sm1948568ejb.75.2024.02.19.10.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 10:52:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E021410F616A; Mon, 19 Feb 2024 19:52:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
In-Reply-To: <20240215132634.474055-1-toke@redhat.com>
References: <20240215132634.474055-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 19 Feb 2024 19:52:05 +0100
Message-ID: <87wmr0b82y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Now that we have a system-wide page pool, we can use that for the live
> frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
> avoid the cost of creating a separate page pool instance for each
> syscall invocation. See the individual patches for more details.
>
> Toke H=C3=B8iland-J=C3=B8rgensen (3):
>   net: Register system page pool as an XDP memory model
>   bpf: test_run: Use system page pool for XDP live frame mode
>   bpf: test_run: Fix cacheline alignment of live XDP frame data
>     structures
>
>  include/linux/netdevice.h |   1 +
>  net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
>  net/core/dev.c            |  13 +++-
>  3 files changed, 81 insertions(+), 71 deletions(-)

Hi maintainers

This series is targeting net-next, but it's listed as delegate:bpf in
patchwork[0]; is that a mistake? Do I need to do anything more to nudge it
along?

-Toke

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D826384


