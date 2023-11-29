Return-Path: <netdev+bounces-52225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BE7FDEE2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA252826B3
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF7F4C3AC;
	Wed, 29 Nov 2023 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/QcH9dk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D752CA
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701280380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBaSH7LNSvnZ++ObRGyio4HFQ2m6jCIWs4RrhBcFnF4=;
	b=O/QcH9dkXxgg7r98wE/NCzZAEG658sWOSApLuiRe/5NMS3wLCtS4kxPOXUzWROLqOe8QsN
	oMqO/R2FgR9ZTqfR2buJEjZrH/iGTXQ+QMAeAqiphHkK2Ob/aRL63SDvXnhMEuYugF/bDL
	/E64Sfny1Y9MVDzO/IwXHHgHMnaimJs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Fu5BkZucOqSPB54rbsLoMw-1; Wed, 29 Nov 2023 12:52:58 -0500
X-MC-Unique: Fu5BkZucOqSPB54rbsLoMw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332f91f43d0so67363f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280377; x=1701885177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBaSH7LNSvnZ++ObRGyio4HFQ2m6jCIWs4RrhBcFnF4=;
        b=hEB1hpneyykBxhxG+o8bdiR+CKAykfKLBsXeivjXOu+6izy9t8nAesqgGVhOBtSRWz
         523rlhCdXkrjiGfIuYZEp6S7BMNqAPWxae+qe2T17bEU5NvHIaE1sWbkSTAjWBCBbJp6
         qNMyWMuTYsHtNwDgNrQjyewyWglifApLgeRqI0FBngkQjXA25h9ouKim9E/tkJwnj7SR
         0RMC0cnNzldybphgRo/5TBSvkX4BLBQWTsyRZBclTvAxn44FeG/QH1m2TsPhYPY9/Ea+
         QOXmlD4aMfa6mIPsRHz1lJkBaPv8tmo+0TF7RC9xLVI8gKD0jDMvA9dKkf0MjP6bBH0y
         SSRw==
X-Gm-Message-State: AOJu0YzX1Aig0lfvzNVNxw6LGKmcx5EFpH9T8rEVCoM8zBDmgMTtzgzC
	qg/PT3peJtwAdThZED7FmhXvGB2oJF+WMvidTJn/2b28qTmUyILlRyj7FakMjHFpzAFPT9j/x31
	9Hg5dDFgIlY6QH1uy
X-Received: by 2002:adf:eb88:0:b0:333:a26:d569 with SMTP id t8-20020adfeb88000000b003330a26d569mr5132624wrn.57.1701280376885;
        Wed, 29 Nov 2023 09:52:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEntrogb7Kg0t3uSLJr5JdCJhNUnFYFOV4b+e0gY9lE7gQFazivoqTCuqSpbhDGjWr2oaFaTw==
X-Received: by 2002:adf:eb88:0:b0:333:a26:d569 with SMTP id t8-20020adfeb88000000b003330a26d569mr5132606wrn.57.1701280376521;
        Wed, 29 Nov 2023 09:52:56 -0800 (PST)
Received: from debian (2a01cb058d23d600d702cd48001e04aa.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:d702:cd48:1e:4aa])
        by smtp.gmail.com with ESMTPSA id cr18-20020a05600004f200b0033304787251sm8095944wrb.17.2023.11.29.09.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:52:56 -0800 (PST)
Date: Wed, 29 Nov 2023 18:52:53 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZWd6dWXOorUv/PRc@debian>
References: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
 <CANn89i+sqG+T7LNxXhB-KHM-c7DU2v__vEbiV1_DJV7tkuEaGg@mail.gmail.com>
 <ZWZnQL1tnjJ9R8Er@debian>
 <CANn89iLYsaZ+uDJA_4M-46XS0fbp0foiumhMdjtfw-Jg9bNq+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLYsaZ+uDJA_4M-46XS0fbp0foiumhMdjtfw-Jg9bNq+w@mail.gmail.com>

On Wed, Nov 29, 2023 at 04:39:55PM +0100, Eric Dumazet wrote:
> On Tue, Nov 28, 2023 at 11:18 PM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > On Tue, Nov 28, 2023 at 11:14:28AM +0100, Eric Dumazet wrote:
> > > On Fri, Nov 24, 2023 at 12:11 AM Guillaume Nault <gnault@redhat.com> wrote:
> > > >
> > > > Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
> > > > that are bound but haven't yet called connect() or listen().
> > > >
> > > > This allows ss to dump bound-only TCP sockets, together with listening
> > > > sockets (as there's no specific state for bound-only sockets). This is
> > > > similar to the UDP behaviour for which bound-only sockets are already
> > > > dumped by ss -lu.
> > > >
> > > > The code is inspired by the ->lhash2 loop. However there's no manual
> > > > test of the source port, since this kind of filtering is already
> > > > handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
> > > > at a time, to avoid running with bh disabled for too long.
> > > >
> > > > No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
> > > > socket, bound respectively to 40000, 64000, 60000, the result is:
> > > >
> > > >   $ ss -lt
> > > >   State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
> > > >   UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
> > > >   UNCONN 0      0               [::]:60000         [::]:*
> > > >   UNCONN 0      0                  *:64000            *:*
> > >
> > >
> > > Hmm...   "ss -l" is supposed to only list listening sockets.
> > >
> > > So this change might confuse some users ?
> > >
> >
> > On the other hand I can't find a more sensible solution. The problem is
> > that "ss -l" sets both the TCPF_LISTEN and the TCPF_CLOSE flags. And
> > since we don't have a way to express "bound but not yet listening"
> > sockets, these sockets fall into the CLOSE category. So we're really
> > just returning what ss asked for.
> >
> > If we can't rely on TCPF_CLOSE, then I don't see what kind of filter we
> > could use to request a dump of these TCP sockets. Using "-a" doesn't
> > help as it just sets all the TCPF_* flags (appart from
> > TCPF_NEW_SYN_RECV). Adding a new option wouldn't help either as we
> > couldn't map it to any of the TCPF_* flags. In any case, we still need
> > to rely on TCPF_CLOSE.
> >
> > So maybe we can just improve the ss man page for "-l" and explain that
> > it also lists closed sockets, which includes the bound-only ones
> > (this is already true for non-TCP sockets anyway). We could also tell
> > the user to run "ss state listening" for getting listening sockets
> > exclusively (or we could implement a new option, like "-L", to make
> > that shorter if necessary).
> 
> This exists already : ss -t state LISTENING
> 
> >
> > What do you think?
> >
> 
> We might need a new bit in r->idiag_state (we have a lot of free bits
> there), different from
> the combination used by "ss -l"  which unfortunately used ( (1 <<
> SS_LISTEN) | (1 << SS_CLOSE) ) )
> 
> "ss -t state bound" (or ss -tB ???)  would then set this new bit ( 1
> << SS_BOUND) and the kernel would handle this pseudo state ?
> 
> (mapped to CLOSED and in bhash2)

I'll do that in v3. Thanks.

> diff --git a/include/net/tcp_states.h b/include/net/tcp_states.h
> index cc00118acca1b695a534bd73984b9d1f1794db25..97238c0f64aa6643cf492a856e8d67ddcca1a729
> 100644
> --- a/include/net/tcp_states.h
> +++ b/include/net/tcp_states.h
> @@ -22,6 +22,7 @@ enum {
>         TCP_LISTEN,
>         TCP_CLOSING,    /* Now a valid state */
>         TCP_NEW_SYN_RECV,
> +       TCP_BOUND,
> 
>         TCP_MAX_STATES  /* Leave at the end! */
>  };
> @@ -43,6 +44,7 @@ enum {
>         TCPF_LISTEN      = (1 << TCP_LISTEN),
>         TCPF_CLOSING     = (1 << TCP_CLOSING),
>         TCPF_NEW_SYN_RECV = (1 << TCP_NEW_SYN_RECV),
> +       TCPF_BOUND       = (1 << TCP_BOUND),
>  };
> 
>  #endif /* _LINUX_TCP_STATES_H */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a62423360a5681525496f8840bfe1d37ea3dc504..c3d22edb9e9563672356750153167884c92eae67
> 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6570,6 +6570,7 @@ enum {
>         BPF_TCP_LISTEN,
>         BPF_TCP_CLOSING,        /* Now a valid state */
>         BPF_TCP_NEW_SYN_RECV,
> +       BPF_TCP_BOUND,
> 
>         BPF_TCP_MAX_STATES      /* Leave at the end! */
>  };
> 


