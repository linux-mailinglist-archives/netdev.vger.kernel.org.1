Return-Path: <netdev+bounces-143403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109E9C2481
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2567B25B70
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7941C1F1D;
	Fri,  8 Nov 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gJDT1vcR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77321C1F09
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088569; cv=none; b=TagjbFL+2JTrMzPOpHbIVy3BQkyCtzFlSN4RfPUx4SKJlcoeBwOA0p9GPclJ1eN4f9y3W2SsNTdQd1D+svmBxneP9Q5T2FoosrIR35lb3PI7g8L/XsY+EcCHz7at4gJw/36CLZ0h/d37HgXzkgC1rELQ62tVrp6Lx++1uvqEBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088569; c=relaxed/simple;
	bh=Oywapz89DB80jcfz1c3Dvs68o0LA4gBd2sRlp82SsXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj7cHDmg46XihpuGpGTQuzdB4SLM1CLzQF3apLdZ8LDf5nHQL+k5LftQ9wr44m2ocfgzil3hxUeVet2ys5XlRrzQMsfpWI2I57SxT4bBXnjzjqhqqi8jBDH4dLAkYHKTKRbyposTbvTCRNdAiGwtWRcjObU0qywGvr/aM9JtLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gJDT1vcR; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m6hMKYZTlVheBGXvBL9CWALGMKgO5oJCAA4y7y9HsOM=; t=1731088567; x=1731952567; 
	b=gJDT1vcR22iAw95aGzO4EEP7N89bzyXk62Lo17bE+T2YsWF9OWwA9VMZRrFgXjJJvWws+ar8lna
	mtQnDttmu3Te+iYS+n5aIVpHe36Syp3uWMaeEPqKCroyQF0J9Lm3kbi2FrEEazCeNokKsQTwxxPxo
	fNfcpLXvCcxkXjwGoZFenwjHI/RSzC14QFwpkdBBo9anKw5+8VjXLWHKr4ooC2F+8DKoJJJy55Vpu
	DsMywu5a9QqJ8nl0Cj1scIYm1YsVh8Wy2/XUyEOJppi9WMhbzX4uj+qDNKQ5lZjrsH/GB3mZhAT8x
	F0uSmrAJAz1dp11psaUu9VLKmosVXcu0b+9A==;
Received: from mail-oo1-f50.google.com ([209.85.161.50]:56395)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t9TDE-0005iU-NG
	for netdev@vger.kernel.org; Fri, 08 Nov 2024 09:56:01 -0800
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc0992560so1480209eaf.0
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 09:56:00 -0800 (PST)
X-Gm-Message-State: AOJu0YzS9WisEUVu2GlOuE3gbTAG3SwDVQ1FI4Nr31lyskkkJCaPNaio
	MgUaqyeiTiOITUs6NUgRLFHYG8SZ8AT8nZslm9wn/5ad+im3OGgBo+XTjWzX8IfBzRnoSHcScxn
	474Uu9286cBJUC6Ow8N/SMW8PZco=
X-Google-Smtp-Source: AGHT+IEGeXfZbCMZAbbjrVckKjT3+DS4HYpbTydyMeq5e1dbarRluELleXA5mx0CfKG6ekBevLcgJEmQYrgtqJ7iaQ4=
X-Received: by 2002:a05:6820:1f08:b0:5eb:827b:9bbf with SMTP id
 006d021491bc7-5ee57c6b6c8mr3320855eaf.7.1731088560123; Fri, 08 Nov 2024
 09:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-2-ouster@cs.stanford.edu>
 <174d72f1-6636-538a-72d2-fd20f9c4cbd0@gmail.com>
In-Reply-To: <174d72f1-6636-538a-72d2-fd20f9c4cbd0@gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 8 Nov 2024 09:55:24 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxdRVm7jY7FZCNsvd8Kvd_p5FPUSHq8gbZvzn0GSK6=2w@mail.gmail.com>
Message-ID: <CAGXJAmxdRVm7jY7FZCNsvd8Kvd_p5FPUSHq8gbZvzn0GSK6=2w@mail.gmail.com>
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for Homa
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: ee5a8a2ba51c5094c3d10c175eb088a4

On Thu, Nov 7, 2024 at 1:58=E2=80=AFPM Edward Cree <ecree.xilinx@gmail.com>=
 wrote:
>
> On 28/10/2024 21:35, John Ousterhout wrote:
> > Note: for man pages, see the Homa Wiki at:
> > https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
> >
> > Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
> ...
> > +/**
> > + * Holds either an IPv4 or IPv6 address (smaller and easier to use tha=
n
> > + * sockaddr_storage).
> > + */
> > +union sockaddr_in_union {
> > +     struct sockaddr sa;
> > +     struct sockaddr_in in4;
> > +     struct sockaddr_in6 in6;
> > +};
>
> Are there fundamental reasons why Homa can only run over IP and not
>  other L3 networks?  Or performance measurements showing that the
>  cost of using sockaddr_storage is excessive?
> Otherwise, baking this into the uAPI seems unwise.

This structure made it easier to write code that runs over both IPv4
and IPv6. But, I see your point about the limitations it creates
(there is no fundamental reason Homa couldn't run over other datagram
protocols). In looking over the code, I don't think this structure is
used anymore in the kernel code or the kernel-user interface (it
appears in one structure, but I believe that field is now obsolete and
can be eliminated); its remaining uses are in user-level code. I will
remove sockaddr_in_union from this file.

> > +     /**
> > +      * @error_addr: the address of the peer is stored here when avail=
able.
> > +      * This field is different from the msg_name field in struct msgh=
dr
> > +      * in that the msg_name field isn't set after errors. This field =
will
> > +      * always be set when peer information is available, which includ=
es
> > +      * some error cases.
> > +      */
> > +     union sockaddr_in_union peer_addr;
>
> Member name (peer_addr) doesn't match the kerneldoc (@error_addr).

I will fix.

> > +int     homa_send(int sockfd, const void *message_buf,
> > +               size_t length, const union sockaddr_in_union *dest_addr=
,
> > +               uint64_t *id, uint64_t completion_cookie);
> > +int     homa_sendv(int sockfd, const struct iovec *iov,
> > +                int iovcnt, const union sockaddr_in_union *dest_addr,
> > +                uint64_t *id, uint64_t completion_cookie);
> > +ssize_t homa_reply(int sockfd, const void *message_buf,
> > +                size_t length, const union sockaddr_in_union *dest_add=
r,
> > +                uint64_t id);
> > +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> > +                 int iovcnt, const union sockaddr_in_union *dest_addr,
> > +                 uint64_t id);
>
> I don't think these belong in here.  They seem to be userland
>  library functions which wrap the sendmsg syscall, and as far as
>  I can tell the definitions corresponding to these prototypes do
>  not appear in the patch series.

I'll remove for now. This leaves open the question of where these
declarations should go once the userland library is upstreamed. Those
library methods are low-level wrappers that make it easier to use the
sendmsg kernel call for Homa; users will probably think of them as if
they were system calls. It feels awkward to require people to #include
2 different header files in order to use Homa kernel calls; is it
considered bad form to mix declarations for very low-level methods
like these ("not much more than kernel calls") with those for "real"
kernel calls? Do you know of other low-level kernel-call wrappers in
Linux that are analogous to these? If so, how are they handled?

Thanks for your comments.

-John-

