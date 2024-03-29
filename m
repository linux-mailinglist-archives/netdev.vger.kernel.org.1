Return-Path: <netdev+bounces-83392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B68921AA
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4431F2608D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BD82D603;
	Fri, 29 Mar 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7l+/YTU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8122075
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730054; cv=none; b=TZDsWVld07ug80vHAaoyrKQlCftCYUrDhfHhS5x1L9QawY75x66FRPNE25AujdI3cjVaDWjGuGUa3gzDbfmTwhI1FobkwemseiYwRESvYdzzPHts7x6A1PQJwogw2rhc3dR8tRg8uIAG/havITesi4zBtAeJSLIJdwJFBq6j2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730054; c=relaxed/simple;
	bh=2H8JVcLKr6i+5o1D6bATxDH4/oWcNSR3rFdDIOXQc9U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfEfk4FQMiiCpmTNFcH2I+flHnQdE8btG6ssdjeBgTwwQTyVja47d2BY+xgzixNdHmE7KeIb8wbaxCHuW+51P6YUg4m3CGSqp+6HyHbb5ahX17oYVcuRqNONF7eXB/zxUvIUBMiUOuEyndPrFeQkImNGEpTScYM4sunP/hz6TPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7l+/YTU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711730052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2H8JVcLKr6i+5o1D6bATxDH4/oWcNSR3rFdDIOXQc9U=;
	b=b7l+/YTUGzZUjPI79x5zA87dwfZJEbyGtk0oXYclCm4TsbjYKLBkJIc3NmJU2ffH9g9mwb
	oygW0loWD0vXUspSt85STLIPFHeupsb1EKT20Lwlw0cP/Kjc59Ow3nnaREk1YlgMZ6QWJs
	M7F8OZkahBVvtNDOIZHhTd+XezJXuaw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-LyRWLu1HN_6Cgs8lxUWBoQ-1; Fri, 29 Mar 2024 12:34:11 -0400
X-MC-Unique: LyRWLu1HN_6Cgs8lxUWBoQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ecafa5d4dso517448f8f.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711730049; x=1712334849;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2H8JVcLKr6i+5o1D6bATxDH4/oWcNSR3rFdDIOXQc9U=;
        b=D3/+kLbZ6hIUMjkAe5V38shQwf8KF25RfimhxR/QQ0mFC4emIFKDdbfVsEfzJ7r5C8
         DhUh4R4UKjrSRgSmSMhdYmTuX7gOF3ngYdpTkGWI75KYjyOlSOIkmXMzcn3KGE13dCYQ
         73DMbNC0RkCgs5HIDxQd/q1W8PD5YaHKWM3jz/kN+enISjLtc3X9sIZEmSnUW54brngP
         yhitr3W/r8l8Do8EtlKEXa9KP8NW4Y7VE0M2sOsMWgqRRvcM71LHbaBbJ+kBnNXj9eWd
         2W3NclAtT4WXq7cno/7SMYdWcW8+w7HJtpXcl43LnekyyrBzKn7DQ1LwI64DrvbJRTik
         MMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD796dDcBf24EZK0/5OOJJ6Z/oHo6tDalmmWAnLmzL3ugRdlTeC5oQ7PafRBTbK9cj2GeHNdAnyxCG3Ne3Uyf1kT+NfZqV
X-Gm-Message-State: AOJu0YzX1c3C8eI3RyOK5fsOUuTLJDbSNvQ/a+fpF+JV5m+Viyf81MRm
	zBzaq61TSMcXr3sT3sCSRb7kCUOFNly4rGy2cwAL3vu9ZcYb70w/EwawCl3U2akbmnba93Wo1Am
	88Lc2BJcu3carIAmQTXQsL5zBebwB0j6JxOmapO5S/o6h4hPVmFZAzLWbcNe5cw==
X-Received: by 2002:a05:600c:3b9c:b0:414:93ba:3bc0 with SMTP id n28-20020a05600c3b9c00b0041493ba3bc0mr1919286wms.2.1711730049754;
        Fri, 29 Mar 2024 09:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSrmlv0hiqQXmYe9F29rvkSULi7BTfUh4hk86ESICIuFXZgejTpYNjQx6p5o++LZ3C2hsRBw==
X-Received: by 2002:a05:600c:3b9c:b0:414:93ba:3bc0 with SMTP id n28-20020a05600c3b9c00b0041493ba3bc0mr1919258wms.2.1711730049273;
        Fri, 29 Mar 2024 09:34:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-47.dyn.eolo.it. [146.241.249.47])
        by smtp.gmail.com with ESMTPSA id bh8-20020a05600c3d0800b004132ae838absm5883570wmb.43.2024.03.29.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:34:08 -0700 (PDT)
Message-ID: <2ee8745cfa411fa2c397af8b1323f77e1bd00d29.camel@redhat.com>
Subject: Re: mptcp splat
From: Paolo Abeni <pabeni@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Matthieu Baerts
	 <matttbe@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Network Development
 <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
 Geliang Tang <geliang@kernel.org>
Date: Fri, 29 Mar 2024 17:34:07 +0100
In-Reply-To: <CAADnVQJxsqbJgu9K-ML2-1tRcgEmHY-UuQOCDxqv8_6iVkW7Tg@mail.gmail.com>
References: 
	<CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
	 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
	 <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
	 <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
	 <CAADnVQKXcEhL680E85=rrYuu4eVvVTH60kYRY_VnAKzZo1qKYg@mail.gmail.com>
	 <649dc1dc-ca80-4686-ae37-62d7c81dde8b@linux.dev>
	 <5fe3398c-0ed6-48b8-a5b4-2cc7329b554a@kernel.org>
	 <CAADnVQJxsqbJgu9K-ML2-1tRcgEmHY-UuQOCDxqv8_6iVkW7Tg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-29 at 09:26 -0700, Alexei Starovoitov wrote:
> On Thu, Mar 28, 2024 at 10:35=E2=80=AFAM Matthieu Baerts <matttbe@kernel.=
org> wrote:
> >=20
> > Hi Martin,
> >=20
> > On 27/03/2024 23:16, Martin KaFai Lau wrote:
> >=20
> > (...)
> >=20
> > > Unrelated, is there a way to tell if a tcp_sock is a subflow?
> >=20
> > Yes, you can use "sk_is_mptcp(sk)". Please note that this 'sk' *has* to
> > be a tcp_sock, this is not checked by the helper.
> >=20
> > That's what is used with bpf_mptcp_sock_from_subflow()
> >=20
> > https://elixir.bootlin.com/linux/latest/source/net/mptcp/bpf.c#L15
> >=20
> > > bpf prog
> > > can use it to decide if it wants to setsockopt on a subflow or not.
> > I think it is important to keep the possibility to set socket options
> > per subflow. If the original issue discussed here is limited to
> > set_rcvlowat(), best to address it there.
>=20
>=20
> All makes sense to me.
>=20
> Paolo,
> could you send an official patch?

Sure, thank you for reminding me. This was falling off my radar. I'll
send it after some testing.

Thanks!

Paolo


