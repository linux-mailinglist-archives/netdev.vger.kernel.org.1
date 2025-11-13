Return-Path: <netdev+bounces-238432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A017C58DCD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B76B4FFABE
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10AD35F8D6;
	Thu, 13 Nov 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1pjjSg4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059335581D
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050560; cv=none; b=tZiz9y8kajUbTRWGxdH2XcdYFfJhffxJRoydOIX0PI97h6ohJd5Cv6vZ/qsUoqnGM/GSJiwiuAG7yA554VFCe55mbcgacI/HrHrF1SufvzFTJurjWWn/hJp8QQpTHV6BPG4fXRceNuiXqMpdZ7mW11fjxMekiqrw83jm+v+hx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050560; c=relaxed/simple;
	bh=kafW6vm77X+S5eJdFGrqID+7DDj+I7gbTIu7zvP37RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkxjjwCyDGW1m8HNv6bshbhfCrraUQjxv0eFtxrKg4Mygf8MYSnNJcJcyozx+pAig3TCiQfOKF0uJw5myNFwEEYmXFtE+rZnh598H/NvYQfgsmccNrZ4tiwSchTwHKMhkSKpJKG9IvFDxH9igFc8hOeP45Q4zZGk2CqRDn7DM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1pjjSg4; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-937268fe284so515925241.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763050558; x=1763655358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtZrc8pcV94m9BaS5IFrkwCaXzwDk1JO5Dgtlvx9nnI=;
        b=C1pjjSg4y7VbbIQiWGAig7QPRE5zgmqH/55gQfJZRM+KANtXd2Mb8clkAgb1X9mKIh
         YS0lWKizGIfFUaVm6RNL2rm6pr2XytoNAyfBoyNK9Wi5baNBLqIBLAxR9oibluvYcAP3
         CAYYdn5eQheU7At9zJ2ShrWKV5RyLWDeeYAIj0Lo80XPUkp3kBtE7G1Ggo1aQ17aqGbj
         jgY2wjdJac1QkXXJ4YXh1+INLFcxEQQSz6wHIwZnBMO9wNR4lv0kFGiusFT3YBO79Hg1
         XrRdOPbCMWcSHSgWodgoRvlYBdpdjNIRDBApUsmQJe+i2E+7oHPxiUM+nVrNUKsVRWer
         83LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050558; x=1763655358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QtZrc8pcV94m9BaS5IFrkwCaXzwDk1JO5Dgtlvx9nnI=;
        b=wsdXCLHYaX8Np4KrPCvhT17wbC+Uhl3uPOtjIHkFebqbp3GVCBNKytOIO3gUxCDDIo
         iwVcIn66Qx4vnAC91VXWNlI5q5r9P/HEQYxYDfL/IMwN8ysxxObBTeKyvzPyJ+zS6lzt
         uSA03azObNREHabsxLlj4MCjshwsPB6pCgc/0/yTBzkMq/la/J4touV80vMOz6hZ2T1x
         EPRHpD4aGkkgMVmY+88aYXhIm8gl/nqgdnLXRNSIHBpr+HA5ELW626Gg3R+0kmMwkqZP
         D9c0le94qEmMhsYj+5/eKbdDmHRsA4vvNEhBaCd+m14J60BrwBvq1MSkpe5OCNT1/41k
         2IdA==
X-Forwarded-Encrypted: i=1; AJvYcCWtCEQScA3zkbPwBbBuvZrXldSrseewsqI2AKOXCYm/qIR9Ql359tWcypdsQ9wbmVPvNyYV14I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5g4sVDBF05ZSRb2iMRy49o5WSvXxkWzUUQKzB9J7tQdm+RQQx
	nkhoKTek29n9IjJMA5V+mb2l8cCISKnKzK3TY7thwkLFkrtSRuBqlvLlWa2SEdgpfm0VCU8kIJm
	nE9B6Yz93FDpR+aLWkExl3d8Wox/rppI=
X-Gm-Gg: ASbGnctGbwDnYWsV9cSLN9vbEaNt5deUoahwcz79sSabhNYGZ0mpz+xXzE+s/f77Mfm
	AfE/mgQP3kTCtSkfIj/VPFIayMaBAqGEQAsxb++/P5YYLzurL8Vt9Vp9qcNCtWrxLaaZS+4mGrf
	H06+h+IpK/zfaKVJg7I3gM1KR2eIJTmlZIlomYvdHYJugy/S+/vovtnE4OH6EaweYbzbBLO+eXU
	Q5KWurqJ3AbBm0UBxlg4fNE2yyJUuKHezMGw4zqvhrjdySjXn80Gkh64oBJZbM=
X-Google-Smtp-Source: AGHT+IH2HUQ+XY5AWd7wrPGPnvmbvbSLt8KzksKdJcvdqRJKUPwqI37CvV3L4gFpgWh2H8+Lncy/ncP5xaKiRgSBfY0=
X-Received: by 2002:a05:6102:947:b0:5df:af0f:3094 with SMTP id
 ada2fe7eead31-5dfc5b9fa3amr116681137.42.1763050557931; Thu, 13 Nov 2025
 08:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113153220.16961-1-scott_mitchell@apple.com> <aRX_VP61EqRM-8z7@strlen.de>
In-Reply-To: <aRX_VP61EqRM-8z7@strlen.de>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Thu, 13 Nov 2025 08:15:46 -0800
X-Gm-Features: AWmQ_bmfelQ7mL859A_WFlpN488ACFKOjNy8IKc90uyX9-mjfPmXI3utiSYZVBs
Message-ID: <CAFn2buAJY0RpSBAevCVavq9cUkenBKe3QcnXFA+5qqiS=8z5rA@mail.gmail.com>
Subject: Re: [PATCH v3] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 7:55=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> > +static int
> > +nfqnl_hash_resize(struct nfqnl_instance *inst, u32 hash_size)
> > +{
> > +     struct hlist_head *new_hash, *old_hash;
> > +     struct nf_queue_entry *entry;
> > +     unsigned int h, hash_mask;
> > +
> > +     hash_size =3D nfqnl_normalize_hash_size(hash_size);
> > +     if (hash_size =3D=3D inst->queue_hash_size)
> > +             return 0;
> > +
> > +     new_hash =3D kvcalloc(hash_size, sizeof(*new_hash), GFP_KERNEL_AC=
COUNT);
>
> This doesn't work, please re-test with LOCKDEP enabled before sending
> next version.
>
> > +     inst->queue_hash =3D kvcalloc(hash_size, sizeof(*inst->queue_hash=
),
> > +                                 GFP_KERNEL_ACCOUNT);
>
> .. and this doesn't work either, we are holding rcu read lock and
> the queue instance spinlock, so we cannot do a sleeping allocation.
>
> That said, I don't see a compelling reason why rcu read lock is held
> here, but resolving that needs prep work :-/
>
> So there are only two choices:
> 1. add a prep patch that pushes the locks to where they are needed,
>    the rebase this patch on top
> 2. use GFP_ATOMIC like in v1 and update comment to say that
>    GFP_KERNEL_ACCOUNT would need more work to place allocations
>    outside of the locks.

I will go with option 2 to make incremental progress.

