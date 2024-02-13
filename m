Return-Path: <netdev+bounces-71500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695DA853A03
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25700281BD6
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C4101F7;
	Tue, 13 Feb 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlDAINCd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3465910A05
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849568; cv=none; b=cVG8Z7OBjfi2d+rYatfYnEJ2erAqfYOfVDrKgUmTE0V2BEZfNxx3ha5sF6NljWn+HT+lWNYm6lS9yjFPSPNeb3qTYIWba1hDk14j7K5QP7H31IRMA59OgE7qo6sb3P9irIFCpK5pApOnj3knnQocJZqggTUT8GK0TI42OZvf6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849568; c=relaxed/simple;
	bh=vFyzzIkAIhLCHQjdoVYi/963h97yJoyQPJWJe+zB5AU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqA8cTYK7PWklgwdz2UDxMtn6UWTndebyXE7raXdMkzgP8e3eeX/37oFE10R/lj8+OzVBpGCqQ5wZxxpqHrvzt0ZgjOVoSz7sD7cONCF0nd+oFwacCtKBJO6lFIt6JNCS0rPLEtG4l7P3lbH+sbSXE0vP1PaWy/a0CGoD5mgKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlDAINCd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707849564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pc6zq8ipr/1RWW2wO3n3l4IMAdT1AegFnZYIl0+Lw/U=;
	b=GlDAINCdkagZND7YFAgoWi3ewCBDpaAUyOvrIAIVhdUWhESEEiLxrXQ5ytc5v5GjA9ATRw
	VZuCsYbNkbGQ/SMgC7LFuQj3WgISedE1tdx3p8YV7MdENPzaV54MUsGgDC/qX2vc4293IT
	ki50PtglUrbR/dKu4QYfw016gEymm5I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-pCJl3yHsPhmZduI_7tXYmA-1; Tue, 13 Feb 2024 13:39:23 -0500
X-MC-Unique: pCJl3yHsPhmZduI_7tXYmA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33cd063f475so162973f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849562; x=1708454362;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc6zq8ipr/1RWW2wO3n3l4IMAdT1AegFnZYIl0+Lw/U=;
        b=GISQmCuwXfFSTHUYKGKql0lmkdKa8RU6BSByWqQ4d6RmOmcFTjGFKi0aftueSPikM7
         urC48/01VSlh0+aZjItRXuGXa1pypJgjCijgw3KINNXgZ7j1ttXaE53K2WOgI/4MIbtr
         7gdkbbA+bvbpEhbV71zG/tx7Lafy6bjuO2Bq4WSD9FruieX5Y6NafkF14xYE0ymK9GIh
         Z+DLTZoOUpYLbr0cGiHvN5Hud0gk5MPl2uh7Ris2mP8jGaWYaJFNY+SB6m1o5lOIzUt5
         o2EJnNeyRNqa4ZS3RyJOJ0m+n4EXqKX9RaADu9BDCmfRFkaIfixbHYBTc6YSEiGBtJ6M
         s1Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWIs9MJvoDr1x6sHrVOKsma/P4yLQYBkkmSIRs6xUxUn82gePzCyYA27ysnaePnqwCBW+k7e7RpLHhwP1bYsdX3xUeXb/ug
X-Gm-Message-State: AOJu0YwIxMpYOAvLHIaZe4YoC8kQzBdnNe9YqWyq2+kxhWax8pja8KRd
	qLKpiInmCV3ZQxyknjo5yYXujRjp/VoDpSgZdoYO8zi6gWGAajmG9k/y++a0ZKeud4ORNnf5KOw
	GIaHDVINGVFrzpEnbiaadY7w75Haa5O59Pw+nSUT6Kb/Z99cj6/QyEA==
X-Received: by 2002:a05:600c:5127:b0:40f:c34a:b69 with SMTP id o39-20020a05600c512700b0040fc34a0b69mr363970wms.2.1707849561891;
        Tue, 13 Feb 2024 10:39:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPp2rSeOwCEAum0FsiP3dr4kFDpRL7nrpDnTLLbayjDluiqxfGjnOLfN3vAdgUdOGV18xFlQ==
X-Received: by 2002:a05:600c:5127:b0:40f:c34a:b69 with SMTP id o39-20020a05600c512700b0040fc34a0b69mr363956wms.2.1707849561576;
        Tue, 13 Feb 2024 10:39:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaSDfJFM62i0FJ6mC6gzWo+nr5iUTLcSjCeH7cU/Crx3PwRWDd1s09Qr7U2nNUBbv242iRmlNcJMWnzj/qC/YmAlKwIdVCREID6prl62aSgKvZ+NzbtYAFkRMij2TNOxR55QtnVqH0iMAvEr/P1fz53x3cRqtzTkre6P2s//Ie76Mi9ZcK5jfkmEK0WYwATlZU9SEBOtISrMakJWj+dcTNXi3WwsoOnMP0c5IV/pf7FGiblDu69VsAt59Ps+YJ2g==
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b00410e6a6403esm5836378wmq.34.2024.02.13.10.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 10:39:21 -0800 (PST)
Message-ID: <725a92b4813242549f2316e6682d3312b5e658d8.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com, jmaloy@redhat.com,
 netdev@vger.kernel.org, davem@davemloft.net
Date: Tue, 13 Feb 2024 19:39:19 +0100
In-Reply-To: <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
	 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
	 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
	 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
	 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
	 <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
	 <CANn89iL2FvTVYv6ym58=4L-K-kSan6R4PEv488ztyX4HsNquug@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 16:49 +0100, Eric Dumazet wrote:
> On Tue, Feb 13, 2024 at 4:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > On Tue, 2024-02-13 at 14:34 +0100, Eric Dumazet wrote:
> > > This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the no=
n
> > > MSG_PEEK case is very strange IMO.
> > >=20
> > > Ideally, we should read/write over sk_peek_offset only when MSG_PEEK
> > > is used by the caller.
> > >=20
> > > That would only touch non fast paths.
> > >=20
> > > Since the API is mono-threaded anyway, the caller should not rely on
> > > the fact that normal recvmsg() call
> > > would 'consume' sk_peek_offset.
> >=20
> > Storing in sk_peek_seq the tcp next sequence number to be peeked should
> > avoid changes in the non MSG_PEEK cases.
> >=20
> > AFAICS that would need a new get_peek_off() sock_op and a bit somewhere
> > (in sk_flags?) to discriminate when sk_peek_seq is actually set. Would
> > that be acceptable?
>=20
> We could have a parallel SO_PEEK_OFFSET option, reusing the same socket f=
ield.
>=20
> The new semantic would be : Supported by TCP (so far), and tcp
> recvmsg() only reads/writes this field when MSG_PEEK is used.
> Applications would have to clear the values themselves.

I feel like there is some misunderstanding, or at least I can't follow.
Let me be more verbose, to try to clarify my reasoning.

Two consecutive recvmsg(MSG_PEEK) calls for TCP after SO_PEEK_OFF will
return adjacent data. AFAICS this is the same semantic currently
implemented by UDP and unix sockets.

Currently 'sk_peek_off' maintains the next offset to be peeked into the
current receive queue. To implement the above behaviour, tcp_recvmsg()
has to update 'sk_peek_off' after MSG_PEEK, to move the offset to the
next data, and after a plain read, to account for the data removed from
the receive queue.

I proposed to let introduce a tcp-specific set_peek_off doing something
alike:

	WRTIE_ONCE(sk->sk_peek_off, tcp_sk(sk)->copied_seq + val);

so that the recvmsg will need to update sk_peek_off only for MSG_PEEK,
while retaining the semantic described above.

To keep the userspace interface unchanged that will need a paired
tcp_get_peek_off(), so that getsockopt(SO_PEEK_OFF) could return to the
user a plain offset. An additional bit flag will be needed to store the
information "the user-space enabled peek with offset".

I don't understand how a setsockopt(PEEK_OFFSET) variant would help
avoiding touching sk->sk_peek_offset?

Thanks!

Paolo


