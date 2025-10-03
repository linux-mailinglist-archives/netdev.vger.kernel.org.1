Return-Path: <netdev+bounces-227821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D166BB8421
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 00:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BE91B2078B
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73588258EE1;
	Fri,  3 Oct 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5I4LePG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011C261B83
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529032; cv=none; b=oDNu5b1CsNdUcJ3CJygbf8+9Gqsc2cooiXN7Np+pHF6f61ptGnVWPoVQrDUPMz3oAm4wAtNkB0td4xDEMldGDu3fJumrWopo2P64g++3RZ6KGLdIgjsPzcbP5F1MMKnA6dZhd0NW7V/PXUXZSIP0zr98bs9Y7tne/zeuatSNBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529032; c=relaxed/simple;
	bh=FETUPxZjo1EqzMJ3Fc1ECCRLkysnMqFm5vV9+mBJboE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6NB8l5wI+N/J+3uKuyVohZDGs/S24c2+nzTXeJQYmzLfzH0kd85mVZb711b/jPPkkEtL+GI5/uO4V+FS+vVnO9DYeApAsaG5xjmnJM9al4+smngG9IG55vYW4OK1ItPN7EHvacVA6jLcZMzd09TLjWRVW08gKZsC/Shgxz0i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5I4LePG; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6354af028c6so2682196d50.3
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759529030; x=1760133830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7l8G4klFL2hUMCpoFN73V2guBbCIpccmSkTTddipZo=;
        b=L5I4LePGUc/ChOY3iLTYrH8+/OkbX0hgLKyKrdEJSNs515JmZKZ6TW0CLe3TsaaKb7
         GcXOQOgEHp37lREmp4B5WoR78yVYwQb0lPHiLDsYdcec8WiLH/3etxaC8noclQJbFgyd
         PJ7VksHzvORJJoiEYcJzPBGD3lcKptM+kkVbjNLJkM1b96Fr/hATVhcuLFqSOL/vjR64
         5m+GnMASRaqUtEHDieCQyOtGtqskeQZMez0xBs6XeWJ3bH88NOswMzTkUUQoJzHENcER
         uuznaDE0leVp6FcGrCrvpKXSKfpGKuAsjSXy0sx9JKa8hWq1EsQOJCvXouLxv7mjhbXk
         kfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529030; x=1760133830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7l8G4klFL2hUMCpoFN73V2guBbCIpccmSkTTddipZo=;
        b=TePjpkAUB6wr3vL5akF4McI5CxEMD9bYmjBGJ+YyYKRj0wHlb/omLyO8shRaqILOG/
         pNkCz9IrlWI5LwlGC0FZTSuz+my7XoRyKhhkjNxVdMDSFk7JXzhBiz1mCHhug+/Y3dZE
         +U5Qana6TUbk+oFXZKj4HYMD9R5gy2WuqlVNdTcvEdKyCTolXy/DBKeQA1FTjarNn9nw
         AOSqBfqRcobBSKYd+VOCMabYFIRpTmu54FPfJ7jFCNtqorCq2WRrhd10Y7xMtX3D782e
         xv/3gk94c1+uyXfKXWQOSz9uJsLd3SXHzen3SQbsEbpnNRG+mSt92NptgQa4PzgIwVzE
         hcmg==
X-Forwarded-Encrypted: i=1; AJvYcCU/1wvlG/bKC2J1Eqpwd03I5I14QjhbhSe80Z1vXkojeXYkS4fYVLVdAHTIB5BsHaePF6ZidfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBbtu/+AiK0sLH9hk6pMcPXVWSo1HAgKYSLFrNjyL15GBBmgq
	vSiiPSjJ/2MAFDJ+IWiU2EJ+WhNlMQa4V9giGlpPl8XeiGpy/HpXs3f8H6vC52Yzd13ZiAzvGxN
	5C8ls6qCezLIZ6i0GQYiGXeRMrg69wWQ=
X-Gm-Gg: ASbGnctEQqrT7wph/9N9B+nb369Z+5/RxfhTk/e4A0E0dZ0dPFxR1o/tDrmL7/qRRc1
	c1tX9Am9wInXIMZeBmUgqzleSR6mLfD368ZwvTQ1BUv047r3eXHUaXW4Xa5YDybsLicezEYdnvt
	vNxzulBlc8kzMHJUfsNh51v9MvlZaryWS6Z2oZAYNO9u1FYEpeIpQj/9R4/c/2aq8pPnuZO+aN4
	JPyjyfMp16WmZ6gIAo5DsgxAYixkdU=
X-Google-Smtp-Source: AGHT+IHrxe3JDL54sXXcJKwC7ywZpRFoUViH0+78HqD6QpkD3BwPdJAF43Fm7wkWuj71g1PeEj2AVny0rbeecr7Sdag=
X-Received: by 2002:a53:c055:0:10b0:636:875:62ff with SMTP id
 956f58d0204a3-63b9a105f94mr3987180d50.35.1759529029810; Fri, 03 Oct 2025
 15:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002225356.1505480-1-ameryhung@gmail.com> <20251002225356.1505480-7-ameryhung@gmail.com>
 <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 3 Oct 2025 15:03:37 -0700
X-Gm-Features: AS18NWBZrlJsJAwdWIoBMdWhMwHsZPpbGaHwyGFKc5eQ6vKg5otabttiwb-w9PA
Message-ID: <CAMB2axOUU5J4Ec=tuBDYePzucw1QQLciFWC01=eVQdPOhT1BGQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 2, 2025 at 3:54=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> >         bpf_selem_free_list(&old_selem_free_list, false);
> >         if (alloc_selem) {
> >                 mem_uncharge(smap, owner, smap->elem_size);
> > @@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_sto=
rage *local_storage)
> >          * when unlinking elem from the local_storage->list and
> >          * the map's bucket->list.
> >          */
> > -       raw_spin_lock_irqsave(&local_storage->lock, flags);
> > +       while (raw_res_spin_lock_irqsave(&local_storage->lock, flags));
>
> This pattern and other while(foo) doesn't make sense to me.
> res_spin_lock will fail only on deadlock or timeout.
> We should not spin, since retry will likely produce the same
> result. So the above pattern just enters into infinite spin.

I only spin in destroy() and map_free(), which cannot deadlock with
itself or each other. However, IIUC, a head waiter that detects
deadlock will cause other queued waiters to also return -DEADLOCK. I
think they should be able to make progress with a retry. Or better if
rqspinlock does not force queued waiters to exit the queue if it is
deadlock not timeout.

>
> If it should never fail in practice then pr_warn_once and goto out
> leaking memory. Better yet defer to irq_work and cleanup there.

Hmm, both functions are already called in some deferred callbacks.
Even if we defer the cleanup again, they still need to grab locks and
still might fail, no?

