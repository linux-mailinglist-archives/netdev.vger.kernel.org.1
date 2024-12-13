Return-Path: <netdev+bounces-151851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D49F14FA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 19:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4825816914F
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D518A92C;
	Fri, 13 Dec 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="g2tkN4rp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECB1DA5F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114784; cv=none; b=bnE9OuLy0HBasK91QiR9Jykx7aCB5o7Y31R9sKyr4wv7boZmLyQmtPOtcAkr+YMJCyV5Y8WMZTmy6Z13UcIU9tKBmlw4sCWQUa6TxIKB64rDbXB98CJ9qWlGLh2hKbeRHkgiPC3Ofzscfix13ZAQmcvUSCcpNDFY5s2rhGvQctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114784; c=relaxed/simple;
	bh=k8zGXdB9rlD/vHleNyZW8sRtDfuJte4fM1lP6CQslmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMJ56JH9tKCFliVPXLQ/jsk+EiKeT9i3DAtC11VUDaVZSMW8hE9OCUlHIfq8irkIueQTre9V45LFJnVHismz1SxHbQDd6I+AGbjb4kIBh5z2Al9RY0ByxjgBYYqHQrlyktA/BKwIP99pH3N6eFAZLIuVOkKey5Udf/u3ZVrcpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=g2tkN4rp; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lANyaQGIFIvjHovpw6zbG76eF4vbf6S0gk4iBUksITY=; t=1734114782; x=1734978782; 
	b=g2tkN4rpLjoJhecg9L/jcjBRvFRpDuuaNmbKqQ6luuxjtJ9H0GLdRpSGUqkBfJnU9dTeGt6vaW9
	aE0/YsQ1+kewhKOuZQ41RPuB4LS3TlNPZpPhDQQ4Fc9ygOmmEaX87aqDPZCVDGzIs/8qTsURAVKZb
	/72VtOj027gOnYeGK/DULUSiKLFpvqCNkis+nn2svpUSZfUeVNfzkCjwGwEXJ35XeyydnTN/MIE4L
	MlsWZn02OBjXh+RXYGds73zYDHFQYr/ahLTS7EtMFWCBrAdUCFhXUwGM3OC+mkhVWwvcOX9an3qoR
	TFYwl+GkWInJ5GVe+TukO10mgIyK+y8IM8bw==;
Received: from mail-oa1-f52.google.com ([209.85.160.52]:50650)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tMAT9-0003ui-PM
	for netdev@vger.kernel.org; Fri, 13 Dec 2024 10:32:56 -0800
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e149aff1dso661897fac.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 10:32:55 -0800 (PST)
X-Gm-Message-State: AOJu0YxHqr2RuaBqcvgBqKkh+FXn7ZPAcAvqR4A8UncroZBfUS38sOtl
	lNbvFbHvOsHWlDbZkkU+WQ5VB7h5tGkIcTRj/f4m30Jw7qL79V0m4IOadlAeWwxdpD1fLsTc8WT
	k6mMpWI031oRJm6DHTe/K2nhKE5g=
X-Google-Smtp-Source: AGHT+IHPkSWcLkZ2nmAlBixIfSNUEu4c8mmC3wOhSiU5kYioNasPNzmBRHgSqm7TflahAmJJkVBHhOqUxI6rWBdvopo=
X-Received: by 2002:a05:6870:5686:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2a3ac99912emr1829132fac.36.1734114775196; Fri, 13 Dec 2024
 10:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175131.3839-1-ouster@cs.stanford.edu> <20241209175131.3839-4-ouster@cs.stanford.edu>
 <5d9d563c-a321-cc75-a986-49ddc1935681@gmail.com>
In-Reply-To: <5d9d563c-a321-cc75-a986-49ddc1935681@gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Dec 2024 10:32:19 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwvkFF4Xfmf64GZA0vUUcpZhj7SsUR+0ifoxXTcYrLgXA@mail.gmail.com>
Message-ID: <CAGXJAmwvkFF4Xfmf64GZA0vUUcpZhj7SsUR+0ifoxXTcYrLgXA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/12] net: homa: define Homa packet formats
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 143d975f4418483bad6282b216f6b212

On Thu, Dec 12, 2024 at 4:29=E2=80=AFAM Edward Cree <ecree.xilinx@gmail.com=
> wrote:
>
> On 09/12/2024 17:51, John Ousterhout wrote:
> > Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ...> +/**
> > + * define ETHERNET_MAX_PAYLOAD - Maximum length of an Ethernet packet,
> > + * excluding preamble, frame delimeter, VLAN header, CRC, and interpac=
ket gap;
> > + * i.e. all of this space is available for Homa.
> > + */
> > +#define ETHERNET_MAX_PAYLOAD 1500
>
> This would seem to bake in an assumption about Ethernet MTU, which is
>  bad as this can vary on different Ethernet networks (e.g. jumbo frames
>  on the one hand, or VxLAN on the other which reduces MTU to 1460 iirc).
> In any case this define doesn't seem to be used anywhere in this patch
>  series (nor in the version on Github), so I'd say just dike it out.

I have deleted it (should have been done a long time ago).

> > +/**
> > + * struct common_header - Wire format for the first bytes in every Hom=
a
> > + * packet. This must (mostly) match the format of a TCP header to enab=
le
> > + * Homa packets to actually be transmitted as TCP packets (and thereby
> > + * take advantage of TSO and other features).
> > + */
> > +struct common_header {
>
> Arguably names like this should be namespaced (i.e. call it "struct
>  homa_common_header"), as otherwise some other kernel .h file declaring
>  a different "struct common_header" type for unrelated uses would cause
>  compilation errors if both are included in the same unit.
> Some of your typenames are namespaced and some aren't, and it's not clear
>  how that division has been made.

I have now changed all of those names to have "homa_" prefixes.

> > +     __u8 dummy1;
>
> This is the flags byte in TCP, right?  Seems like you'd need to specify
>  something about what goes here (or at least make it reserved) so as not
>  to confuse TSO implementations.  I see HomaModule defines it as filled
>  in with SYN|RST, at least the commit message here should say something
>  about why you've not done the same in the kernel.

I'll change the name to "reserved1". By the time Homa is fully
upstreamed this will be named "flags" and will be used in TCP
hijacking. I have removed TCP hijacking from this first patch series
in order to reduce its length.

> > +     __be16 dummy2;
>
> Again, specify something here, even if it's only "reserved, must be 0"
>  to allow for future extension.

I'll rename this to "reserved" also (it doesn't have to be zero right
now, since TCP hijacking isn't included).

> > + *    No hijacking:
>
> Assuming you don't intend to try to upstream TCP hijacking, this line
>  probably doesn't want to be here as without context it'll just confuse
>  the reader.

This was accidentally left behind when I removed hijacking. I'll
remove this line.

Thanks for the comments.

-John-

