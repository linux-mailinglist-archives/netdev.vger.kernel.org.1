Return-Path: <netdev+bounces-120311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FFF958E59
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A07B22791
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D62614C59C;
	Tue, 20 Aug 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="DbVy/u0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CF7BB14
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180446; cv=none; b=ZLA7NZWXfCY/ej5WAy1aqtyBVfdNq2NoldvsPoNOAUGK5ALI+mIBRW2gEsZ2TNsiQ1pFhGtOxiz6q1Fmf+eqXJaUu4gjgq02B2tH8DBW2KaOLCYNjIQDhwCMsxsWX8CWj1ztvP55U9eTvbRzgy7aFXLQtgKWTPZgqg5tm7obIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180446; c=relaxed/simple;
	bh=9KTs0hk/2zIqCckuZAZRsHF5mJjxlbOezVGnZko6vOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAhtJ2iaPSwx8pWk6DjqSWJwcCw7v73OMhHCy9aBL84lxc35CZBJ0/+/JxLcKZ2cCU7qHd80T/0DSzcisROOKi7G4ghNzD3sJMFyp/nlJWO2FE48s6cO/1kNRdFr+n6qfi4AKc5wiWAkvrtg+1n2P0UNVdoY5ql5LQp3JlkA0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=DbVy/u0n; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso67411551fa.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724180442; x=1724785242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9O2LSPgQiUuC2Mm9qrubexDUw2ZYdb0DkN15V0u0BMg=;
        b=DbVy/u0nBh++zZfVpu1H9d9rJ/HujGqnMxkmh4yXXkktgy6r+5HGpFQpOjyEAgyVM8
         +nCUby5zT2I8875Qi6b60Eq1oLP7SJII/mkb8P0O/QFnBinL3ebUspvF1aaQ58GL+1qd
         VZl+aR9kQsBUXQlplMsskH0eLBuVdsXqCthLBzk5leSIrxqw60bhwPGHAR5ONWUBZwRE
         B+9JqyI7S8z1FqusxboFRq/JMAjKlHZe49ZPxy+WE1XZiItFIYkYRhNlVUh+ZJCDQ1fU
         kofYAV0eTbTQlErDofaWH1VgRnarYiv0myZnFTmiFGpmcyEU8vQVP6OoF0r3H08qznbW
         sVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180443; x=1724785243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9O2LSPgQiUuC2Mm9qrubexDUw2ZYdb0DkN15V0u0BMg=;
        b=M58aJDa4zRvZLK+7aB/iZy3MT+3mGt07qxKsRd86+kCIfl/Ca9HtKrsWM5pzocl4/5
         mrCTuGLeb2rAPEiZlkriRjUBM9viWDx9h7lq9sbpxba8UtCCY5Y0Fj73Qgd7HIq2bkgA
         3OoBKBOkrjCan8gQ7P6qN3v6KE9R506a7Pw5zoeAT7FcFL8FjwTXlJIl2f1LaKuqjSWN
         73gsRZ30dPk85I4jDyKE789bslnx3Xy/Xc+MD3OByW/HrLV4clF6GHjVseusCWlAVEgM
         sLxHGR8Tzeh+LVz+uJVI+U+QriyJ+5dKiehdkLNVPPmljkX7W/j28rt7RtBcTh9plkzA
         2jiA==
X-Forwarded-Encrypted: i=1; AJvYcCVc0hq7e/7H7bt/bkRnpChA0N06FZda/ZR5+5vaU3FeFYK8BXawrQ/HgB8p/beIvE0+WHJzbKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rMRIeMm/fp3DXSAXhjO6Gw2wbkGIxI7vh5DpA+rCSBiJDPIa
	x6f1DBp7CccsgBk/36mqxbaq4VEu6oeOb5504CC5YMJpMbl3iUhR1w/ZXrA1uomqUaVC+9aROPI
	ZyWMSX5LoKXOlE574GZu41XxDBU4sud/Ax07Eo0GV7mK9ruo=
X-Google-Smtp-Source: AGHT+IHBc2BFandLyGY8t2FckQDiR6sdEe/hZBi4LlsqSoJvL8CCyXpeUXlrwcq8RqibrIy1t7yU3NbQ0Py/0yusnTw=
X-Received: by 2002:a2e:a985:0:b0:2f3:eabc:d26a with SMTP id
 38308e7fff4ca-2f3eabcd353mr24441141fa.23.1724180441873; Tue, 20 Aug 2024
 12:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214527.2100137-1-tom@herbertland.com> <20240815214527.2100137-5-tom@herbertland.com>
 <CANn89iJqv_5Qg-EAZsqmTnu9Jv15Tg1SvALhscvmdquuSmJhog@mail.gmail.com>
In-Reply-To: <CANn89iJqv_5Qg-EAZsqmTnu9Jv15Tg1SvALhscvmdquuSmJhog@mail.gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 20 Aug 2024 12:00:30 -0700
Message-ID: <CALx6S36SRug4WyGTpc65eVEt7XWPe+_1pbRAQu7CjtxckwbBVA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] flow_dissector: UDP encap infrastructure
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	felipe@sipanda.io, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 11:52=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Aug 15, 2024 at 11:46=E2=80=AFPM Tom Herbert <tom@herbertland.com=
> wrote:
> >
> > Add infrastructure for parsing into UDP encapsulations
> >
> > Add function __skb_flow_dissect_udp that is called for IPPROTO_UDP.
> > The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing of UDP
> > encapsulations. If the flag is set when parsing a UDP packet then
> > a socket lookup is performed. The offset of the base network header,
> > either an IPv4 or IPv6 header, is tracked and passed to
> > __skb_flow_dissect_udp so that it can perform the socket lookup
> >
> > If a socket is found and it's for a UDP encapsulation (encap_type is
> > set in the UDP socket) then a switch is performed on the encap_type
> > value (cases are UDP_ENCAP_* values)
> >
> > An encapsulated packet in UDP can either be indicated by an
> > EtherType or IP protocol. The processing for dissecting a UDP encap
> > protocol returns a flow dissector return code. If
> > FLOW_DISSECT_RET_PROTO_AGAIN or FLOW_DISSECT_RET_IPPROTO_AGAIN is
> > returned then the corresponding  encapsulated protocol is dissected.
> > The nhoff is set to point to the header to process.  In the case
> > FLOW_DISSECT_RET_PROTO_AGAIN the EtherType protocol is returned and
> > the IP protocol is set to zero. In the case of
> > FLOW_DISSECT_RET_IPPROTO_AGAIN, the IP protocol is returned and
> > the EtherType protocol is returned unchanged
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
>
> I am a bit confused.
>
> How is this series netns ready ?
>
> tunnel decap devices can be in different netns from the lower device.
>
> socket lookups need the correct net pointer.

Hi Eric,

How would we know what the correct net pointer is? Seems like there
could be multiple choices if netns were nested. Maybe best effort is
sufficient here?

Tom

