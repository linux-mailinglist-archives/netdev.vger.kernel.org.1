Return-Path: <netdev+bounces-118602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C964695236B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569191F22958
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A7A1BF315;
	Wed, 14 Aug 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="eUl6VTSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF55218C910
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667849; cv=none; b=P9N5v/lBKNOTQ0QqCN+g4f806pQeQiyNxsBLxXZZHamP8UKmb4JcDTdE9Oz59qlgj+4wWlQmUi588l180IJRV2NUm4sAfcOiDslo5SxGD3st6np+LuMVtvzJpReKf6I8CwIiaM1W8QY+n5Zqj6KF1y8JsESAUfJtv04vgdIV5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667849; c=relaxed/simple;
	bh=TLftIb1Si+biTr6rYjJIM382CS7J4BsQWh/7YbOdigQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGvncfUEKxLBNQxAiOaRzeIXe81gGeWFbYsjqIhYCqZZihxM09pE2bVgdvAmfyczknSHx/4WBrQ3ij9/8qApdytvtt0j9I3Kw5ZNz4rfAOAeOQiYTQ8VLsjP2cCfXBX84TqZToKUWlSNb85uF8X+Z/QDHrSKq+9XObsc9orTyAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=eUl6VTSj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so475891a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723667846; x=1724272646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLftIb1Si+biTr6rYjJIM382CS7J4BsQWh/7YbOdigQ=;
        b=eUl6VTSjTli6mKrjOX56n1a4RTzFv9PKcdCklcj+owjI22cWIgXvW4oPoYPh1W/eUA
         YEP4pePtW3S5nPjWlzcra+mIkDB65FdpHFR8rRT1/+k4tcaZjQRAthrPPI/xVSlUL6Ae
         EwTom6FJkeLBR0QTXL25V5CzSZ9eFO4vMTU9w11XhJm/wRYvbyErn90ikjH3wtvxib/6
         oBnkmXCfBFih4rSIUYR/EmKGiDwvVg2qoETFBbSnZyG6elH+dQWeXOwY+nJfweyjGOFQ
         jgXm+TEjyAeEGTZjogFPcMkwntgGVaNGJKYTxfxDzXOHzt5ddyPWXiGvJYokR0iFOHHb
         ij/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723667846; x=1724272646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLftIb1Si+biTr6rYjJIM382CS7J4BsQWh/7YbOdigQ=;
        b=gugxd66+KyQ04D3gszUsbmWdKU47Si9IdNi5V/TZqsa89hnN6CRHRYrQLQ3NrbIwX4
         7C6DX1D61wo+cwlIaADjEDYRGs/rVGRvDYb29i0b9xNxOgFJeUFTSqj/kckErredGgDO
         wExqBmegwR6qv95LY+I6apmzgDZ4kKfuw6y4cBt2muCp/EQvLFngXxrZE03h1b4K85OC
         XoQjLbo+ipGqOI6EXU8/wynrbO7XDr/b40mv0hLWkTOyAAjEpYU75gCvYXLR0emA09Kn
         +ZZIjWMrqv3XQtUuqtBn1Dsj6bZlrnAQhOaDoeJ7vp8W2fLQPe9UxvECcDJdOIK4g5W3
         hjnw==
X-Forwarded-Encrypted: i=1; AJvYcCVVc6Wuo5tL5MxifC3A+/9ILMweLF9p6nMSMLVSLaFmn59tp5UmGnyqxkiQ0n6T8VnpLsO4eglpsl21dkJD2tfFpMEsSLPC
X-Gm-Message-State: AOJu0YyRBK5iVS0FDaJrC9oOc87TuC3AmcH6sF5MK92QeEi9IJK/9peA
	32R5zJAJ0X6PbFNdIq4oOnAANGb8gJlJQ27Cub/C15+ouEZXzmdlNy0JLiVj/tLlq9/N7QpSa13
	+MI7ruvoyU0O+a8V0klopzfSrHr2fgg7lYuHQoiZHMpffvMf5Zg==
X-Google-Smtp-Source: AGHT+IECSKhWvub+J5jLYPsIyibU4mdTElyLtByP7KuwytcBwiNhyAWbfD3scyJEX/dBpjYdI/4CB5OKroIzwR/heQ0=
X-Received: by 2002:a17:907:97c5:b0:a72:8c15:c73e with SMTP id
 a640c23a62f3a-a836701bdeemr226210566b.55.1723667845584; Wed, 14 Aug 2024
 13:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <66ab8b9ef3d74_2441da2947d@willemb.c.googlers.com.notmuch>
 <CALx6S37FjSB6h6zLAdV+YF-C5H0O0968Zooo=9cJCm8Z3x0XvQ@mail.gmail.com>
In-Reply-To: <CALx6S37FjSB6h6zLAdV+YF-C5H0O0968Zooo=9cJCm8Z3x0XvQ@mail.gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Wed, 14 Aug 2024 13:37:14 -0700
Message-ID: <CALx6S37ENf9AVc9oqoJ+Uh-6DAG6ctNdi0H-Y-8KHQnwZt0AFg@mail.gmail.com>
Subject: Re: [PATCH 00/12] flow_dissector: Dissect UDP encapsulation protocols
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:28=E2=80=AFPM Tom Herbert <tom@herbertland.com> w=
rote:
>
> On Thu, Aug 1, 2024 at 6:20=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Tom Herbert wrote:
> > > Add support in flow_dissector for dissecting into UDP
> > > encapsulations like VXLAN. __skb_flow_dissect_udp is called for
> > > IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsi=
ng
> > > of UDP encapsulations. If the flag is set when parsing a UDP packet t=
hen
> > > a socket lookup is performed. The offset of the base network header,
> > > either an IPv4 or IPv6 header, is tracked and passed to
> > > __skb_flow_dissect_udp so that it can perform the socket lookup.
> > > If a socket is found and it's for a UDP encapsulation (encap_type is
> > > set in the UDP socket) then a switch is performed on the encap_type
> > > value (cases are UDP_ENCAP_* values)
> >
> > The main concern with the flow dissector is that its execution depends
> > on untrusted packets.
> >
> > For this reason we added the BPF dissector for new protocols. What is
> > the reason to prefer adding more C code?
> >
> > And somewhat academic, but: would it be different if the BPF would
> > ship with the kernel and autoload at boot, just like C modules?
>
> Hi Willem,
>
> I agree with that, and believe the ultimate goal is to replace flow
> dissector C code with eBPF which I still intend to work on that, but
> right now I'm hoping to get support as part of obsoleting protocol
> specific checksum offload on receive. We can use flow dissector to
> identify the checksum in a packet marked checksum-unnecessary by a
> legacy device for doing conversion to checksum-complete. This handles
> the case where the device reports a valid L4 checksum in a UDP
> encapsulation and the outer UDP checksum is zero.

Also, there's another wrinkle with doing this in eBPF. UDP
encapsulations are identified by port number, not a protocol number,
so we can't hardcode port numbers into eBPF like we can other protocol
constants. We'd probably need to hook into setup_udp_tunnel_sock
somehow.

Tom

>
> >
> > A second concern is changing the defaults. I have not looked at this
> > closely, but if dissection today stops at the outer UDP header for
> > skb_get_hash, then we don't want to accidentally change this behavior.
> > Or if not accidental, call it out explicitly.
>
> No defaults are being changed. Flow dissector flag
> FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS needs to be set in the call to flow
> dissector. In this patch set it's not being used, but as I mentioned
> it will be used in subsequent patch sets for obsoleting
> CHECKSUM_UNNECESSARY.
>
> For other use cases, the flag can be optionally set. TC-flower for
> instance could use this for VXLAN and Geneve parsing.
>
> >
> > >
> > > Tested: Verified fou, gue, vxlan, and geneve are properly dissected f=
or
> > > IPv4 and IPv6 cases. This includes testing ETH_P_TEB case
> >
> > Manually?
>
> Yes for the time being.
>
> Tom

