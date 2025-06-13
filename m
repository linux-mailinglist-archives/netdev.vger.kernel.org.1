Return-Path: <netdev+bounces-197606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDCDAD94BF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B5C1882137
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D3232369;
	Fri, 13 Jun 2025 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="nB2MvObe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2E231826
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840519; cv=none; b=uxmhIXcH0ZHIDcI9n55jOIXBB0MjgZjsis3LWI9wmAGxJ0hxz5jni3xGSLB3rpUEgWbQp106kfGmqIVd5GNhy1aPccJk79FMGfmArhNpbwZEoUZYbjUy9JB/Ic9zBblK+voqCv0iLoIxK18XZh+IPrvTK9zsQ4KNK1OU/JeQDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840519; c=relaxed/simple;
	bh=mQh3k9u8+kAj5LmpFeBOcStLvZw4ju9EHS0VP75w83o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duprq3oMW30e4GNd+Smyx161vkoGSRDWpqA51FHZO3qpMElAt7IRl6GtUNiqtezr/EjkUp6kBopQW3dWIurEzHns3561Py8jLzb7LMcxtygaW34HsRz316rfZCB3jWx426IoMs5Q3sZZvszabuR0znTnS3iBn4K9w7PzOtLXanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=nB2MvObe; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fbmE94I/oYqw7JcUbXa5ZYLXcanATbYDmDwcjJp4TZ8=; t=1749840517; x=1750704517; 
	b=nB2MvObeunhnrAgzrWU9xepaUvH4fhA2PUIWvB970zQHH3qQLuyoBTrd9hWk96nNYj0h86/O8kx
	b6TRYHVzjHgbz0NhuIrMlPZCOEA88I4uG66QPedJFY2EumxAoGUr0Lr/mCAHW3l6tqiTxXuFk++3K
	JSqvbo6cEqFmacg5cwmuT5tjK/CaiXsRAvhFFC5/LP7QkIc73OOd+sJVGrUvIT6r7cFxvRHeIXEI2
	XYwxWVtSgpEKAxtpSjJQ1Ik9O0UXSOYf7+8ItCH0p00Xcp0xtVa1P8KP2VhpMCpQVx0IOE2ij28C4
	swToP7WXJiT3z9R/L2XyfPTGt5hl0tRCzDrg==;
Received: from mail-oi1-f172.google.com ([209.85.167.172]:50395)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uQ9S6-0001Oq-LV
	for netdev@vger.kernel.org; Fri, 13 Jun 2025 11:48:35 -0700
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4034118aeb7so629607b6e.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 11:48:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yws8wDUEscVGjkyny4YpZPZoyIZcU3CGj7kZhpRuhqUBdmwZ5MR
	ldmZ0ymWPXf9mWbRW95CuYFuwqqwt7tFQzgG1CuPc6QJODKqFgbGibVF1YA6mB8col49ml2RnJj
	SXe+QdPMTwbTjnC7SDEmzvrYqTlgANXA=
X-Google-Smtp-Source: AGHT+IHpfP6XSovP7/elHQ2DXNS/jqUMr7EygmJ1ytxt53sQgigcoJi0T+XLCtanw2ZxBKQIuAFXIy+fGvA0eg/973A=
X-Received: by 2002:a05:6871:5827:b0:2c1:bc87:9bd7 with SMTP id
 586e51a60fabf-2eaf0ba60fcmr522955fac.35.1749840514088; Fri, 13 Jun 2025
 11:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154051.1319-1-ouster@cs.stanford.edu> <20250609154051.1319-7-ouster@cs.stanford.edu>
 <20250613144240.GK414686@horms.kernel.org>
In-Reply-To: <20250613144240.GK414686@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Jun 2025 11:47:45 -0700
X-Gmail-Original-Message-ID: <CAGXJAmyP-6H5Efxn3bde+CpH5rL_Ka0J=gF=u2-VvZvv9umiCA@mail.gmail.com>
X-Gm-Features: AX0GCFuHcAx9l7fM87xqUaiPfh3VlkyVBPgFERNQucwTDyGIlAMDrbK7NpzlhNc
Message-ID: <CAGXJAmyP-6H5Efxn3bde+CpH5rL_Ka0J=gF=u2-VvZvv9umiCA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/15] net: homa: create homa_sock.h and homa_sock.c
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 980022258218d8e0da9e8fd80fb6777b

On Fri, Jun 13, 2025 at 7:42=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> > +      * locks and thus may not be able to work concurently, but there =
are
>
> nit: concurrently

Fixed.

> > +      * enough buckets in the table to make such colllisions rare.
> > +      *
> > +      * See "Homa Locking Strategy" in homa_impl.h for more info about
> > +      * locking.
> > +      */
> > +     spinlock_t lock __context__(rpc_bucket_lock, 1, 1);
>
> As per my comment on __context__ in reply to another patch in this series=
.
> I am clear on the intent of using __context__ here. And it does not seem
> to be a common construct within the Kernel. I suspect it would be best
> to remove it.

See my response on patch 03/15

-John-

