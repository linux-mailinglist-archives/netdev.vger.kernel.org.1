Return-Path: <netdev+bounces-155044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583DDA00C7B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF273A0499
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A292F1FBE8E;
	Fri,  3 Jan 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glXM2uBz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20B14F9CC
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923602; cv=none; b=F0PQy0zFxKSJDofIX0xAah9ejBHh2WkbnH95OryCO4XXLHn3lMjKrHH6Rxr82vVmtL64ihAWC2I2JuAigF4+Tm/7IPXBAk/JF3Sw7pRqWT/5xjfub+287njsleCs32lbrzGe2t4vryK6jQXa05j0W17jNvTtE0Z7jQZdDD3WsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923602; c=relaxed/simple;
	bh=Hw4GTu34YXSFDWu6CElfpVBvfdvcBcohLY6hEYoxp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSOo2yXm5QTl9WLLAqLDDKig5hRFA/Q00MouhFkxyyoMB5i1k9RQxxB4BsAQsB6OnIGsmXR7/TrhKQ+YYq9EhJZaFSHGDUVbrWRSdX2ejzwqvez341OPy+IJyxhiCsIn+9OWMJ6UQ6rinH+O/LP2dNHpdPpU7yd6IOrnDXYMJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glXM2uBz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735923599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XfUlWD9Hczq6KcSfqzg4iPKW3lwUVkATrJJ+x5WCxM=;
	b=glXM2uBz+FnNU5WE0//Rbvi4lSg5/9uU7U4gbWJIipp0WhtV9VI1rTCjIxy6ELTSns/OfP
	KHBkkKpepW1QoV17It4MwF7cX6ULQnjBsechCi1KPgghgV0sHa/64WFbM3OQEPFa2HlR7u
	mNywVk6c9+n+NnkalQrk0DmehnTIZTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-DQK-yhfAMj-qMM_V-A57Sg-1; Fri, 03 Jan 2025 11:59:57 -0500
X-MC-Unique: DQK-yhfAMj-qMM_V-A57Sg-1
X-Mimecast-MFC-AGG-ID: DQK-yhfAMj-qMM_V-A57Sg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361a8fc3bdso66163815e9.2
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 08:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735923596; x=1736528396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XfUlWD9Hczq6KcSfqzg4iPKW3lwUVkATrJJ+x5WCxM=;
        b=qSQXBXI/xntGptEgElFvXZxjSaQdrguf0+wQUA+EbI3rNzF06dKkxLnpXlTgmbb9WQ
         S+/GNIAW+gYjYsXHkc3JizVPdt8eGP3L5hjKOKgR/ss6XqNPFlOZ/455lTBea9qV44yH
         9iV4H8jEaH8LsvGBTpv6rZV7dmDA2dQv4k62lGK+mxAkHhWQsiOj761KWcxAg2RGZ6qZ
         HAJjBTmTpLb8UioOPMnf29OB5ghvhGoeQP4GEHk6UYdbWh2EbQwARFVldQk3VJrCi+em
         JF/TMTwYHmBpu64PmAycnMJGaRLliSG4Qu2VQC60iYVZH2kTLHJLi8u6tmjAzPFfa0vv
         bbGg==
X-Forwarded-Encrypted: i=1; AJvYcCVDSt0NRmxpMGkWdR4Vp1tG2TORxQlsku3yGhMY6iWX2Yut/RVpB4WD/fXK50GOo9269skbSwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UAoHNEn6scz+q6oKPpdfOy5axndqFNE6OA2togjUTSK7rXfw
	5NuzUHm6IFuUGfy3jAxlR6BEtciFf0PQrsTDpQuLmt/3gm6U4Xb7SQRkvPQ8Mdf+PwqZw4pRuTw
	kS1OFmOLO4QVop4vI5bHW+HhVF2DvpzFC5CW15lcIyoWjiCkzFpfbKg==
X-Gm-Gg: ASbGncvflpi2mcE2v5jE4RVYBqOD4Cj3d3D19s4whLPJfcGNavltS1QGcsne85fS95G
	cZ1tVao5f3CDQcPHERh2iHmGjXkiWYG2UNSiOuPYYlhuTgTSKw3aimbvrjtBueSScxXePbvDV2p
	jLoPP4fIIpMQ/MLWOFh7QA9cvXbIlxGoC5fNbzi2gJu7mZbftPA5h43M2N03UaIEWaEYrwpU8ad
	FPqQXlNULxQuBXIgb6zHOjAEfUOXzeKjckOOO+tSAy6tjClI1lGVTe7kN28s4hctJc//u0yKXLb
	gRL+s29H+8BC9OY1of8wpq5G8iPP/Q2tivK5
X-Received: by 2002:a05:600c:46c7:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-43668b5e244mr382242065e9.24.1735923596158;
        Fri, 03 Jan 2025 08:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3+VowO+yJ4mAQNn3qzywn/HFa+7FG3OUT+ALv2b7BPPq9p++XlOKrnfrcWNjr2Uj0C6LzbQ==
X-Received: by 2002:a05:600c:46c7:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-43668b5e244mr382241875e9.24.1735923595799;
        Fri, 03 Jan 2025 08:59:55 -0800 (PST)
Received: from debian (2a01cb058918ce0019efe14cc4985863.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:19ef:e14c:c498:5863])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656a0b361sm521357635e9.0.2025.01.03.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:59:55 -0800 (PST)
Date: Fri, 3 Jan 2025 17:59:53 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-sctp@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t
 conversion.
Message-ID: <Z3gXieFRj+xqozJE@debian>
References: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
 <CADvbK_fsM_EfoNjhybKJr92ojqFo6OdnuA2WiFJyi6Y1=rX4Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_fsM_EfoNjhybKJr92ojqFo6OdnuA2WiFJyi6Y1=rX4Gw@mail.gmail.com>

On Fri, Jan 03, 2025 at 10:35:55AM -0500, Xin Long wrote:
> On Thu, Jan 2, 2025 at 11:34 AM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
> > that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
> > variable. For the SCTP_DSCP_SET_MASK case, we can just use
> > inet_dsfield_to_dscp() to get a dscp_t value.
> >
> > Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
> > to drop the inet_dscp_to_dsfield() conversion function.
> With inet_dsfield_to_dscp() && inet_dsfield_to_dscp(), the logic
> looks like: tos(dsfield) -> dscp_t -> tos(dsfield)
> It's a bit confusing, but it has been doing that all over routing places.

The objective is to have DSCP values stored in dscp_t variables in the
kernel and keep __u8 values in user space APIs and packet headers. In
practice this means using inet_dscp_to_dsfield() and
inet_dsfield_to_dscp() at boundaries with user space or networking.

However, since core kernel functions and structures are getting updated
incrementally, some inet_dscp_to_dsfield() and inet_dsfield_to_dscp()
conversions are temporarily needed between already converted and not yet
converted parts of the stack.

> In sctp_v4_xmit(), there's the similar tos/dscp thing, although it's not
> for fl4.flowi4_tos.

The sctp_v4_xmit() case is special because its dscp variable, despite
its name, doesn't only carry a DSCP value, but also ECN bits.
Converting it to a dscp_t variable would lose the ECN information.

To be more precise, this is only the case if the SCTP_DSCP_SET_MASK
flag is not set. That is, when the "dscp" variable is set using
inet->tos. Since inet->tos contains both DSCP and ECN bits, this allows
the socket owner to manage ECN. I don't know if that's intented by the
SCTP code. If that isn't, and the ECN bits aren't supposed to be taken
into account here, then I'm happy to send a patch to convert
sctp_v4_xmit() to dscp_t too.

> Also, I'm curious there are still a few places under net/ using:
> 
>   fl4.flowi4_tos = tos & INET_DSCP_MASK;
> 
> Will you consider changing all of them with
> inet_dsfield_to_dscp() && inet_dsfield_to_dscp() as well?

Yes, I have a few more cases to convert. But some of them will have to
stay. For example, in net/ipv4/ip_output.c, __ip_queue_xmit() has
"fl4->flowi4_tos = tos & INET_DSCP_MASK;", but we can't just convert
that "tos" variable to dscp_t because it carries both DSCP and ECN
values. Although ->flowi4_tos isn't concerned with ECN, these ECN bits
are used later to set the IP header.

There are other cases that I'm not planning to convert, for example
because the value is read from a UAPI structure that can't be updated.
For example the "fl4.flowi4_tos = params->tos & INET_DSCP_MASK;" case
in bpf_ipv4_fib_lookup(), where "params" is a struct bpf_fib_lookup,
exported in UAPI.

To summarise, the plan is to incrementally convert most ->flowi4_tos
assignments, so that we have a dscp_t variable at hand. Then I'll send
a patch converting all ->flowi4_tos users at once. Most of it should
consist of trivial inet_dscp_to_dsfield() removals, thanks to the
previous dscp_t conversions. The cases that won't follow that pattern
will be explained in the commit message, but the idea is to have as few
of them as possible.

BTW, the reason for this work is to avoid having ECN bits interfering
with route lookups. We had several such issues and regressions in the
past because of ->flowi4_tos having ECN bits set in specific scenarios.

> Thanks.


