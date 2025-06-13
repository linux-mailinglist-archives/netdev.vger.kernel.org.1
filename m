Return-Path: <netdev+bounces-197574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F168AD9398
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BFF3A4981
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DE522330F;
	Fri, 13 Jun 2025 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="DVipFYLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997F14BF89
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834789; cv=none; b=RPyuebQAHc8iFtZWeh7+//N/kDMA12G8D00kOlubdqCRjvIjf02iJcVrpGmVurCpH09VfoWiIaeEJBUFSUPxZBzJq6g7I243rC2D0V3Ta7C6z6huRoB7mCMgcTzYnVQzqBRjLTofkZE29w+5n8+wAUXT9B2tjOTxottABxkDvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834789; c=relaxed/simple;
	bh=ngRTd1HHf8LWYsX4y94CHvaAp57n31KnKKEhpt0tYEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgo6s/K7Kqd5urUyMJ3JRqyQ60mEPc4TdpOVNeNtvYM2+yJILveKOiAzazEoCWiBRv941446CiN5loSuyKD0YiVWV+MOOzVXK0Y8d96IaezCHX4RhpN/ERi/ArtnGpOUbLLE0GNOSVYPwvGelY2OoUKsYX6GseH2kF6DwO/B8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=DVipFYLh; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lNdz5I3U+tRLjxZfly53l4+x33pV0gdByCxXeIl9K00=; t=1749834787; x=1750698787; 
	b=DVipFYLhNuNxcXjWbL3XQ/lq+q3N5Fn/N9NeLM30V/LFOvf6ZTtD/e28SfcEglvgpTv4R48l6WE
	wq4msFah3kGb7nXTZLPooLexuz8OP3afRCcxzA+cDPNh4bAhpGjVLfdBRAPsfvZ/ypRhwX2gFiijp
	cFhcuPzgQ1B5j5vDaMTjrmoLlRwP6y1pBsmfmYespYnl9achijWCPd/axTBGvxiCmJP8AEI0pG1pY
	Ela5P+EbUg64mY5VSc6oYzcgCBqxr+2tnmDuKASLcCdq9p3X0/P74YARMhK+K8O/LqB7XL4/MxZoP
	iT9xxsE+Pg0L8eWbjG7VbIBnG26LNPalkrGg==;
Received: from mail-io1-f43.google.com ([209.85.166.43]:58778)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uQ7xc-0001fb-Pz
	for netdev@vger.kernel.org; Fri, 13 Jun 2025 10:13:01 -0700
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86d0168616aso203180239f.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 10:13:00 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywm/bcOclkZ+YVQhKXRgI5FvZ4VrblGx7x8FgTyHwU0rP0/kXOW
	vUzHG/gs/FGU52dsAR5GHLCZWStlAPTCPdvXR0cPTngZ5yE+sQiwPC5baNCcTShetwxLRFNy0at
	4uNinwnLpBWoMZWdsaJ+C0XplOuFHmfY=
X-Google-Smtp-Source: AGHT+IHNACIKuiaA4xZlctnYY3XCrWXj64ntfrJC7Ay02R0McXI8ZIeaXnzAwJwSSI3ki14yjmigWrgFnb5t3bKAtvs=
X-Received: by 2002:a05:6871:440b:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2eaf086cb61mr353583fac.18.1749834769239; Fri, 13 Jun 2025
 10:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154051.1319-1-ouster@cs.stanford.edu> <20250609154051.1319-6-ouster@cs.stanford.edu>
 <20250613143958.GH414686@horms.kernel.org>
In-Reply-To: <20250613143958.GH414686@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Jun 2025 10:12:11 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxQn_iAqhOHwxEQ16n+MKjFyEbiUoBbGyDY+TLYooeJhQ@mail.gmail.com>
X-Gm-Features: AX0GCFsj1lkNjRiSsxjr6k6V8u5ByRyRC3P69zqXrWX7Rp3-aUQyK53LGk7ydg8
Message-ID: <CAGXJAmxQn_iAqhOHwxEQ16n+MKjFyEbiUoBbGyDY+TLYooeJhQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/15] net: homa: create homa_peer.h and homa_peer.c
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 6214ac49f2cb083a0c8190805312a710

(I have implemented all of your suggestions for which there are no
responses below)

On Fri, Jun 13, 2025 at 7:40=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
> > +/**
> > + * homa_peer_hash() - Hash function used for @peertab->ht.
> > + * @data:    Pointer to key for which a hash is desired. Must actually
> > + *           be a struct homa_peer_key.
> > + * @dummy:   Not used
> > + * @seed:    Seed for the hash.
> > + * Return:   A 32-bit hash value for the given key.
> > + */
> > +static inline u32 homa_peer_hash(const void *data, u32 dummy, u32 seed=
)
>
> Sorry if this has already been asked but can homa reuse the code in
> drivers/md/dm-vdo/murmurhash3.c:murmurhash3_128() (after moving it
> somewhere else).

No problem; the question hasn't been asked before. I'd be happy to use
an existing implementation of murmurhash3 but couldn't find one that
was accessible. What do you mean by "moving it somewhere else"? Are
you suggesting I add a new murmurhash3 implementation somewhere
"public" in the kernel? I'm a little hesitant to do this because I'm
not at all expert on murmurhash3: I'm not confident about getting this
right. Also, I wouldn't feel comfortable taking on maintainer
responsibility for this.

> > +     const struct homa_peer *peer =3D obj;
> > +     const struct homa_peer_key *key =3D arg->key;
>
> nit: Reverse xmas tree here please.
>      Likewise elsewhere in this patchset.
>
>      This tool can he useful here
>      https://github.com/ecree-solarflare/xmastree/commits/master/

Thanks for the pointer to xmastree.pl; I wasn't aware of it and it
will be super-helpful. I've fixed all of the reverse xmas tree issues
now.

-John-

