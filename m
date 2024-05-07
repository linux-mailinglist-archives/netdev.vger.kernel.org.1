Return-Path: <netdev+bounces-94263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB038BEE35
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513CA1F26E34
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C677E8;
	Tue,  7 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3fl5TGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50910187328
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114425; cv=none; b=LxuNhj9dzjBQuq6+7Nwjmtr9D7REtumCRrNH6IjUE8lRL8PF/wlfyGXXgLz94KLh9dPQzjJssY9n8XCnFDxCniLkRHjRo0syt43sr15wLWkeZxtFbrYwJpxnXk7KqDi4qoUpEwdvkIdUfktDpFax44hm4hQmQXs1BcbwFmsCbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114425; c=relaxed/simple;
	bh=Ufk/gFJYW08m7tE7G2uG8BgEpDnsGM1baz9D3cs+nRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWl5vmKHApduBm7KFXBYAK18DYYWIncjagGD8kSrX2TnwgW0FxfP7Y5GAC2jgHa7g++S7RhQ3nN5GBttRRXpFjaPjJw7/5aEElXgulI6hLaDl96J9aDdHpsL2zd5H4N5vV32GDKuIKMzN6k0JzgufDlNh1PTrMHwyHlPZjeIw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3fl5TGH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59b49162aeso751883066b.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715114422; x=1715719222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ufk/gFJYW08m7tE7G2uG8BgEpDnsGM1baz9D3cs+nRI=;
        b=L3fl5TGH5LweDNRmRfNVsoLtXRFNkoFz1tOdhJdzeX+2nZUFUUUwO2coJ/q42zyHJE
         6rQvWdzmeNZCpmp8b9ncMRgmCt3fpqT2lgY9YUuwyfNIiBSy/6C+8y2YiU5rTo+u0PI8
         XeG/D2UwoJGxtN2G9Eo8bXqiwVvIKFymlrM0XMFTKxM/b0eI0C3OvSEtAUi5Ihww8xh1
         7/2jkqq1k7xpBpyQZ1Jx/hvFH3M6koVf//8920nxSYZp1v5DUoA+avYZ+O3eT3yzL+EQ
         /zZQcCbSO9+JvHkhKsfEgEZ8spS49g2jcigr1+5IB8TvVM0WvoYD8/8fLhC93Hc7aik+
         r9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715114422; x=1715719222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ufk/gFJYW08m7tE7G2uG8BgEpDnsGM1baz9D3cs+nRI=;
        b=dYWIFqfEuQjvKk23lxu1494mLIfOPV+1YxR1a84TPqBiEXmzY17zBrkm/1/x897+ve
         4dGNN/n6MaOSFaKZqUZuCXkSwsk0IaxAF7MthQEsYLJfQXa2uVfKfEwKZ8QepikO2l7c
         26JAKqceNWci0xEahMrcurH4b5P4GVCLHkf/sUkKzOMultJLhwR3PhDVb23SG4VHQFNg
         LpuixYRDuQb3yLZ2ZQNOVYyxe2fJ23sCWU/yUxy6NG/tO1bTDrwrnIzMyyt5gSb5+RVj
         i2rpf8vKlfx06OOJjq48fDN1ZEXOCOnr4z6gyFB2IvDAkmhg3/wnij0TXK7gpyfFlcm7
         Bhgg==
X-Forwarded-Encrypted: i=1; AJvYcCU/7g7YXryNx5y+nWcOrzX1L26kttd9qCTuGVmtNDwhtNJd1+UhcfEUXwUy9w3oX9NR4wYM5Of86NvshzWkcvM+lMBCz7EQ
X-Gm-Message-State: AOJu0YyHll+1OZy1zdePUm+I0966Cp4k5O/5uDA5VPJlWQxehFpylt0Y
	aNpHGpJbFBnkeQkyshwdLH2A6PLHW5W5odrNChxLOV1eXwUblOkEbByjbIA6RCd+8laX3gcLC9i
	w174SuxNUm5ZhAWwwZSCa9YVpNYIMuHkzfWhq
X-Google-Smtp-Source: AGHT+IHoWg8CpyvonDrgH7k6Min8utjszRF1fn3vv3n7qsxUc74v0bFIRuQHR7hWe4VitqtobG69Me7VuIq9BP38F2o=
X-Received: by 2002:a17:906:a2d3:b0:a59:c209:3e31 with SMTP id
 a640c23a62f3a-a59fb94b588mr33022366b.21.1715114422346; Tue, 07 May 2024
 13:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org> <CAHS8izPu9nJu-ogEZ9pJw8RzH7sxsMT9pC25widSoEQVK_d9qw@mail.gmail.com>
 <20240507122148.1aba2359@kernel.org>
In-Reply-To: <20240507122148.1aba2359@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 May 2024 13:40:08 -0700
Message-ID: <CAHS8izPUZC+66cRfiakQrVD5qrjd7S+=FLJSwCF4_esmYpf6mA@mail.gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Andrew Gospodarek <andrew.gospodarek@broadcom.com>, 
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Shailend Chand <shailend@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 7 May 2024 11:17:57 -0700 Mina Almasry wrote:
> > Me/Willem/Pavel/David/Shailend (I know, list is long xD), submitted a
> > Devem TCP + Io_uring joint talk. We don't know if we'll get accepted.
> > So far we plan to cover netmem + memory pools out of that list. We
> > didn't plan to cover queue-API yet because we didn't have it accepted
> > at talk submission time, but we just got it accepted so I was gonna
> > reach out anyway to see if folks would be OK to have it in our talk.
> >
> > Any objection to having queue-API discussed as part of our talk? Or
> > add some of us to yours? I'm fine with whatever. Just thought it fits
> > well as part of this Devmem TCP + io_uring talk.
>
> I wonder if Amritha submitted something.
>

Yes please let us know.

> Otherwise it makes sense to cover as part of your session.
> Or - if you're submitting a new session, pop my name on the list
> as well, if you don't mind.

I'm not thinking of submitting a new session tbh, but I could if you
insist. Tbh I'm worried we have too little content for the devmem TCP
+ io_uring talk as-is. Could we dedicate 10/15 mins of that 30 min
talk to queue-API and add you to it? AFAICT I'm allowed to edit the
list of presenters and resubmit the talk.

--=20
Thanks,
Mina

