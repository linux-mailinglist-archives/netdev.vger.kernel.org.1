Return-Path: <netdev+bounces-156843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5030A07FDE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A39A3A315A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AF1A0712;
	Thu,  9 Jan 2025 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="vOA3lc0A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157B199239
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447802; cv=none; b=ioq+Zp0OR6PlTfG0SYQL6l0AAXE8odHyaqYgFjphT3SBfLSkYy5H33Y7L33CMmCzKRq49KuKhz8xq9zrYQF1a5pq5ROtL3YV8U0ofOjGxSXnZSYjCwt6mJyEZC5kTp2Ta9s+vYA5BZGydCUmvza7PoZs+tqq09R/W2KALN38mTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447802; c=relaxed/simple;
	bh=iZOss7/NTcXa+D2geSTjVGOqGhyQFaYymVnt/4HeFB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHV5PrUTyAxZc+gPo+xEBf5MENxnfE4skyPWai31sJd4+yu0wj4Z+chzBTzjXURpyN+AymLvqUzqeYDSzfyX5ujHvOhZAgp4tBSIroSWFlYpyV/1lWfpKhwvs+jlunQuofChl5UgOsBdQliK5hBn/x4zxnsbpBkhh7DClYEzYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=vOA3lc0A; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QPexWF+1NsuV7DrMamikN7hh/U78Vtr5LmjQRD4ZoLM=; t=1736447800; x=1737311800; 
	b=vOA3lc0Au9pBo8YR/GeyPoyhWwCUUCibZF9J4WgjWJyz38D/5OWxZOOSETDzxHa/LsTPFwJMXB/
	891uAK9yOgsUw5GqGHCK8PPJLTQ2qDJISy0lqDnDIMStBJC1TyXaVbl3cb39m7DQNa6PdwBahH2ru
	ETnNRzB7ITowJIRfVgMtWDUxQwyug+//RG0JwA3LXGiKdG1RhcZaCn6CvKWhuL9d70U6j2CiSfqV9
	XmZ9mV9moTAPDGszneXQCaSauPHDzGcaHV+ryUvaudxJfeu5E6L+cCvYYEczxioirxgl8/JTRL1BL
	ac8ljHqT9ri0zmjfyT+MZrQaLR6H/jnD9wtQ==;
Received: from mail-oa1-f45.google.com ([209.85.160.45]:56468)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tVxOT-0005mR-6N
	for netdev@vger.kernel.org; Thu, 09 Jan 2025 10:36:34 -0800
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29fc424237bso753485fac.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 10:36:33 -0800 (PST)
X-Gm-Message-State: AOJu0YzgBJoovVh7ku85qeqgOIlrdLIYyPEHgLMdIlAPFyTD2Y8l+0qP
	Jd4GFcKfZwPSmDV9ICwkV6jx3PXZnzl68/TDIHeVYO18PxHVwZKrAtqpSfPFNg/Opx2AD3M3nJo
	4Sq5+0wH3OSShM9wRUXe4yThauHg=
X-Google-Smtp-Source: AGHT+IEtbdPFxBu4R6eY+vUpofCqGuJ42HYouejwL7kMiWac6POy1vxYJ5PgFGdqqhk2oplHhVdBkclKrV8A+1czxuo=
X-Received: by 2002:a05:6871:2283:b0:2a7:d345:c0bb with SMTP id
 586e51a60fabf-2aa069763f5mr4701463fac.27.1736447792628; Thu, 09 Jan 2025
 10:36:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-8-ouster@cs.stanford.edu>
 <20250108145641.GA21926@j66a10360.sqa.eu95>
In-Reply-To: <20250108145641.GA21926@j66a10360.sqa.eu95>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 9 Jan 2025 10:35:56 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxstm21n50hjim3hLHrt0eKOGit2nfBfhgU-DvnyL7caQ@mail.gmail.com>
X-Gm-Features: AbW1kvZEHe81SpDyQz3Z904r9D4AcQ76_BkjtRg0ECpc545ZYToHhfLcFUPtuKE
Message-ID: <CAGXJAmxstm21n50hjim3hLHrt0eKOGit2nfBfhgU-DvnyL7caQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/12] net: homa: create homa_sock.h and homa_sock.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: dcedbbeaec314583a5a6d4e37e27e533

On Wed, Jan 8, 2025 at 6:56=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
> > +int homa_sock_init(struct homa_sock *hsk, struct homa *homa)
> > +{
> > +     struct homa_socktab *socktab =3D homa->port_map;
> > +     int result =3D 0;
> > +     int i;
> > +
> > +     spin_lock_bh(&socktab->write_lock);
> > +     atomic_set(&hsk->protect_count, 0);
> > +     spin_lock_init(&hsk->lock);
> > +     hsk->last_locker =3D "none";
> > +     atomic_set(&hsk->protect_count, 0);
> > +     hsk->homa =3D homa;
> > +     hsk->ip_header_length =3D (hsk->inet.sk.sk_family =3D=3D AF_INET)
> > +                     ? HOMA_IPV4_HEADER_LENGTH : HOMA_IPV6_HEADER_LENG=
TH;
> > +     hsk->shutdown =3D false;
> > +     while (1) {
> > +             if (homa->next_client_port < HOMA_MIN_DEFAULT_PORT)
> > +                     homa->next_client_port =3D HOMA_MIN_DEFAULT_PORT;
> > +             if (!homa_sock_find(socktab, homa->next_client_port))
> > +                     break;
> > +             homa->next_client_port++;
>
> It seems there might be a possibility of an infinite loop if all the
> ports are in use.

Oops, you're right. I have fixed this to detect "all ports in use".

> > +     hsk->buffer_pool =3D kzalloc(sizeof(*hsk->buffer_pool), GFP_KERNE=
L);
>
> using GFP_ATOMIC. I noticed that Homa frequently uses GFP_KERNEL with BH =
disabled.
> Please fix it all.

Done. Thanks for the comments.

-John-

