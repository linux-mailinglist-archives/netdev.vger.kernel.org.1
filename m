Return-Path: <netdev+bounces-197703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE4AD999D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 04:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBC71782F5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91D7082D;
	Sat, 14 Jun 2025 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xo7VZeOu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA195200A3
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749867563; cv=none; b=gaq/O8mGxaGcKUTlcUxlG2uVyFLe6u8jIWmgqBpB8uXinK6LO+V6Y1oHeItnLMv2BTyVh/QssQgWqoyO5LPnawSQM/xS2J+mLTFovW5s3ETnj+0aQDcT/L213jfGxPgziCUZyn6gYWylhQDy4OyY3QGGHQVs8LLsvEcKhR0Usrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749867563; c=relaxed/simple;
	bh=AJuRSop8QkkGDZ8RIYWjeGO7mDVPmBvjRxvlq1diPXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQMt4qzLryGUd7i9AstJJ/rHeNTzRL2O6/LqNVNAFjIwPHgbNeAqlowu0hylsZLIhL9QR59kt0UGV2IRmMVzprvy12OHcmIDTuYz1h+pFSaZsQujLWudtXbw/05kBtpXj8UgoRZImhY3Vhe61Sxe+EP4kJjV85jYjYBsAvvjBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xo7VZeOu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e389599fso89245ad.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749867561; x=1750472361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn7hQ4tKQxqRQgt1sWefNjIs0nazm1nLsrkpL0FkOCs=;
        b=xo7VZeOudDM4r+wd5+/fzdH81NYY+LWRalknQIWQvKTM/W341oJaoA/bbu6P6K4053
         Q4V/4RpKLufIV03VXq4YzjwetNrswpvBFfOmqRTe2n/mlx6gfb/B9p9fUNe1CyOR5O49
         nesQD97Lqz8rhPiCNX+XV2jvIIX/QBLXSNyYkZ31GOTQInKtxEI1KBRor02j6FTw1lmz
         BvPBdREaNo/ZR6mPr96/cAv8yCl3t7ZJkK/VbIerCDtjZ0ogPS8mZWnFsxZxahi1e7zp
         Ir/3NV+BK9rfbPXR5UE8rrEYKtQ5Op5Qi8CeQlUKoPRJZR5Ffalufbzrh/Q7SS+x7b+f
         73OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749867561; x=1750472361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn7hQ4tKQxqRQgt1sWefNjIs0nazm1nLsrkpL0FkOCs=;
        b=HZpGJlYLL0lQETlNs0rwN/tUyan1Hp9E+Ant+4qp1erGwKBeeBwXOuwQDnpMPI4Gb5
         qlPl2bMpjHa0gLVLQwPCm5/tBh+CGIuBU1SLJonRo3LJTagorlhY1PEf0LsH8P+CvLOW
         zHi2LN6nlCxZOFGQbvTZ41VJsex2+XFt8+763eAnG3G/+2oNaJEjWIcL5QLy+FXdQFVC
         GDIQ2wU0T2ayD7pnVBTWPmdGYSVxB1Bvf2/XJiw2oWVnDiQe/Rij9IWoVv5nMZRUVCaW
         wdiODXqpUpCCOZrV32hIUz+g4Rh6sxLUnicli3u6oOLrH+PeO9Xv+hfLL/g2sIDbi9Yp
         Cnrg==
X-Forwarded-Encrypted: i=1; AJvYcCWzFdCng6BGv6XeBYDFIEYk5MaPN+clH1VGCdcTEFyDNbIecA07QkYIdiS3wStCgGbJaxkk/EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMDJ4dVdrmkAG/JGDov3AzrPeYJ1SyEW/8jn0ztXCxyqm5l0V9
	LTEyyd5z/HZeAOBfmGePh2ajI6jvCCU/C/w8oiHYCEh2ABhuUCrIssyfcPRAX8y8WuntmIInifA
	2Jx8gEHBMHrvVu/l7ZCYFZrCcMCm7rWzmZe/IPwSu
X-Gm-Gg: ASbGncu+lndVem3T7teobdCRRUSckMFzRxxByYe72vlwdQqxY1gpWUT7RJWMHYelVyH
	4jcIE2CLcTWYWZ6xbwPJnchL/C8oO1haL+JHWJpH+Ad3aPUfvFkxMS1ePJyblnF33hg9HN62+Ki
	51552WC/h3ejNDv9RrTUT7u5OlItVyYNW/oiqph84N9cmK
X-Google-Smtp-Source: AGHT+IGYdXYi+poo/RbTJj3aTyp+thNZAzJ5yQqSIcmi+S8nbDQIjlrXV7TRD/xqSf9eS1uYlnMXOLt+1LwilFumYxA=
X-Received: by 2002:a17:902:ef08:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-2366c5a25dfmr1048025ad.12.1749867560457; Fri, 13 Jun 2025
 19:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org> <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org> <20250613011305.GA18998@system.software.com>
In-Reply-To: <20250613011305.GA18998@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Jun 2025 19:19:07 -0700
X-Gm-Features: AX0GCFuFHl8rGE_NSTG6eYqMKv1bvWBwteyyrelqyPJ0hyn_uDtWnwn8gbn2YYg
Message-ID: <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Byungchul Park <byungchul@sk.com>
Cc: Jakub Kicinski <kuba@kernel.org>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 6:13=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> > On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > > What's the intended relation between the types?
> > >
> > > One thing I'm trying to achieve is to remove pp fields from struct pa=
ge,
> > > and make network code use struct netmem_desc { pp fields; } instead o=
f
> > > sturc page for that purpose.
> > >
> > > The reason why I union'ed it with the existing pp fields in struct
> > > net_iov *temporarily* for now is, to fade out the existing pp fields
> > > from struct net_iov so as to make the final form like:
> >
> > I see, I may have mixed up the complaints there. I thought the effort
> > was also about removing the need for the ref count. And Rx is
> > relatively light on use of ref counting.
> >
> > > > netmem_ref exists to clearly indicate that memory may not be readab=
le.
> > > > Majority of memory we expect to allocate from page pool must be
> > > > kernel-readable. What's the plan for reading the "single pointer"
> > > > memory within the kernel?
> > > >
> > > > I think you're approaching this problem from the easiest and least
> > >
> > > No, I've never looked for the easiest way.  My bad if there are a bet=
ter
> > > way to achieve it.  What would you recommend?
> >
> > Sorry, I don't mean that the approach you took is the easiest way out.
> > I meant that between Rx and Tx handling Rx is the easier part because
> > we already have the suitable abstraction. It's true that we use more
> > fields in page struct on Rx, but I thought Tx is also more urgent
> > as there are open reports for networking taking references on slab
> > pages.
> >
> > In any case, please make sure you maintain clear separation between
> > readable and unreadable memory in the code you produce.
>
> Do you mean the current patches do not?  If yes, please point out one
> as example, which would be helpful to extract action items.
>

I think one thing we could do to improve separation between readable
(pages/netmem_desc) and unreadable (net_iov) is to remove the struct
netmem_desc field inside the net_iov, and instead just duplicate the
pp/pp_ref_count/etc fields. The current code gives off the impression
that net_iov may be a container of netmem_desc which is not really
accurate.

But I don't think that's a major blocker. I think maybe the real issue
is that there are no reviews from any mm maintainers? So I'm not 100%
sure this is in line with their memdesc plans. I think probably
patches 2->8 are generic netmem-ifications that are good to merge
anyway, but I would say patch 1 and 9 need a reviewed by from someone
on the mm side. Just my 2 cents.

Btw, this series has been marked as changes requested on patchwork, so
it is in need of a respin one way or another:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=3D=
byungchul&state=3D*&q=3D&archive=3D&delegate=3D

https://docs.kernel.org/process/maintainer-netdev.html#patch-status

--=20
Thanks,
Mina

