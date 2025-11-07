Return-Path: <netdev+bounces-236796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDDCC40367
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FC294F2B60
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C70319875;
	Fri,  7 Nov 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro3z5yS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363892E62A4
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523710; cv=none; b=cmyR/PhtbUbo8z1iONpm0Aj0Ybly6FyIMQh1t1wtRONjYqS7+1Zx6cj4MZc7GYaU5XlvYmlJ0LBIfG3dVAyY8YmlJSshwonacjzJHLkuh5U0rTGWuRiFci/2xWNXlgeB0+9pXcfXa4HuXUnqB+CToerPIPhkpDXdEDdNPT0YFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523710; c=relaxed/simple;
	bh=4IaHY4BKpYsxR5q7jSPPkcBrCVgWYofh/OWPcZhmCWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPUsuKXrGfDzebckX5cmVNKxYhzpyaJ9s5KMf63YGpKe6NICk6/O5YDepr1uSHy4jqHCGbHsUQhF3gIzwlT/5s0fm6crtDAT1n2K/fTvqAn3YkvyGkC9ObI2fVYrHNPPikSLGfcJTRlMkk1d0a9M9Mv6VnEBXlfkoQuwvztKflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro3z5yS/; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-64124e430adso141228a12.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 05:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762523706; x=1763128506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1mgT8udApcgBiPObXF+Y+AIxrYHKzvdKUGLqdhuh54=;
        b=Ro3z5yS/M2ZM9Z/lH1H7ubcGxfZvT+gbtx5KLjhRoz5v5vnGoy4oOYdj8IU7p4BM37
         ftAvT5paUvhxa7cPCqLQGj+50VM637k3vifybEBqj4Pj+qRsPvKmPs14ZYouj2QGio5C
         1JNf6vGzVSvR06tckRhkMUFByVBnIic+N4TRZnc5x/jdTurZ3Jhs0KJ/JVyoRPBskclU
         ecHZMgVP6xLvNQGuWDL63WTAp4C5337lBhweVb8G30FkwZy62bgLv5J1WDpyLRq8nw4z
         wAZd8DrGcuXQ6m3IATSCtLVgEXr14nDUA3LIaM9XHm8OlVurVIpkDIJ9ZGquN4CgmvcY
         +nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523706; x=1763128506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1mgT8udApcgBiPObXF+Y+AIxrYHKzvdKUGLqdhuh54=;
        b=H5Db3E9MWEexVuXAfSmTP6zh7m1N0UENxpzMkNju/IHyWflHmar2ToKrlUrl+mcecb
         KDSEXVcr4zUFETgGAUrKvD8bvQiZhbEPSk406eB0RQIRZNHmc40exUctBpc4g0aBpqoZ
         LAdkTL2jDDoZZ+4xlRfINTN3B8f6+t/B/I9KZbfZSfCXg4p5y3Zrq3o+biLVjcb0MmqN
         DTQvs/BlDxhNu6ALGcESlPOoY2xnHJbghmMAbxfJmenHtv+OSeewBjg4xBB8Xf3Q7UzI
         yuaB/DGRiNWtsaDIF1WC8LrhYSt7M62c29GujEPrdl6pIBcvrcn3aTFB5yyjWh6dgFIm
         VO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzxr+o5W3EhMOENr1WvfY/sPX9uUdsKBidKAhiMCaeButJo/XV5mocQmNb4fAohHd4zbdJP7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/doX14vBLGonMto9+tSbwTVBa8nuUXYmTF/hFxR5B7IEOgJT
	Qyv5+mNWsPKm0eDN6XbRS+GMiEdbVpA0ZohBBHfPzEnP4lEVY14GFOFrrHfaVMqd9gFahJ4kOqo
	U85+jQMlvABA7E5pdWBqLwY88TZoijDc=
X-Gm-Gg: ASbGncsG0g390j/wxsYi7Jaf2qrWGly3vfAE2zrYR6ALap1a8WX5wrVmIwbM8necQTo
	17Xk3v9xIAsSq7KQa5ouTVTyqkhk0v22KJAy5H6znT7Flp+UFVH6iEe24zpx7axp+UmoX3IREv2
	HYG60MRvK2TWPNxaZutfrJMqBhrpHEKvzblEbVLBFn1707l19TxDemEytCBqsU7Y3Vq63wdLTxF
	QXb+PNKqgqF0eEatE0oNhFIfEeRydoCtCtppSfJ3XGbi+h+75xlBb4Y6Hk=
X-Google-Smtp-Source: AGHT+IEnDQagfCLvUpZx+7s0UUQVn+4wdwvyXbvi2WXZ9XKszyeCZ7T2q+51fITuWRiWZBdAtxHTBFEehGPrlA1uyMo=
X-Received: by 2002:a05:6402:1456:b0:640:9aed:6ac4 with SMTP id
 4fb4d7f45d1cf-6413f20924dmr1743445a12.3.1762523706023; Fri, 07 Nov 2025
 05:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106135658.866481-1-1599101385@qq.com> <20251106135658.866481-4-1599101385@qq.com>
 <aQzYJX1pDMksNLO9@krikkit>
In-Reply-To: <aQzYJX1pDMksNLO9@krikkit>
From: clingfei <clf700383@gmail.com>
Date: Fri, 7 Nov 2025 21:54:54 +0800
X-Gm-Features: AWmQ_bksbnjZ87k8jDfIudu2wjQmoqySCvs1ttxxFttTG9ZL53LlbyBGCBHZDgI
Message-ID: <CADPKJ-5sUXaStr1TrNsgLF3vOq6+E3icGAkAh7xAWWWpGeep6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] net: key: Validate address family in set_ipsecrequest()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	eadavis@qq.com, ssrane_b23@ee.vjti.ac.in, 
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sabrina Dubroca <sd@queasysnail.net> =E4=BA=8E2025=E5=B9=B411=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 01:17=E5=86=99=E9=81=93=EF=BC=9A
>
> note: There are a few issues with the format of this patch, and the
> subject prefix should be "[PATCH ipsec n/3]" for all the patches in
> the series. But I'm also not sure if this is the right way to fix this
> syzbot report.
>
>
> 2025-11-06, 21:56:58 +0800, clingfei wrote:
> > From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>
>
>
> From here:
>
> > Hi syzbot,
> >
> > Please test the following patch.
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.g=
it master
> >
> > Thanks,
> > Shaurya Rane
> >
> > From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
> > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > Date: Sun, 19 Oct 2025 23:18:30 +0530
> > Subject: [PATCH] net: key: Validate address family in set_ipsecrequest(=
)
>
> to here should be removed.
>

Sorry for the incorrect format of this patch. I will fix it in later patche=
s.

>
> > syzbot reported a kernel BUG in set_ipsecrequest() due to an
> > skb_over_panic when processing XFRM_MSG_MIGRATE messages.
> >
> > The root cause is that set_ipsecrequest() does not validate the
> > address family parameter before using it to calculate buffer sizes.
> > When an unsupported family value (such as 0) is passed,
> > pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.
> >
> > In pfkey_send_migrate(), the buffer size is calculated based on
> > pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
> > family=3D0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
> > (16 bytes) is allocated per entry. However, set_ipsecrequest() is
> > called multiple times in a loop (once for old_family, once for
> > new_family, for each migration bundle), repeatedly calling skb_put_zero=
()
> > with 16 bytes each time.
>
> So the root of the problem is a mismatch between allocation size and
> the actual size needed. Unexpected families are not good, sure, but
> would not cause a panic if the sizes were handled correctly.
>
> OTOH, for this old code which is being deprecated, maybe it doesn't
> matter to fix it "properly". (but see below)
>

I agree that the root cause of the problem is a mismatch between
 the allocation size and the actual size needed. I'm not familiar with the
kernel network stack, and I'm unsure if unexpected families might cause
other problems. But, regarding this specific issue, avoiding integer overfl=
ow
is sufficient to ensure consistency in size allocation and usage.

>
> > This causes the tail pointer to exceed the end pointer of the skb,
> > triggering skb_over_panic:
> >   tail: 0x188 (392 bytes)
> >   end:  0x180 (384 bytes)
> >
> > Fix this by validating that pfkey_sockaddr_len() returns a non-zero
> > value before proceeding with buffer operations. This ensures proper
> > size calculations and prevents buffer overflow. Checking socklen
> > instead of just family=3D=3D0 provides comprehensive validation for all
> > unsupported address families.
> >
> > Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dbe97dd4da14ae88b6ba4
> > Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
> > endpoint address(es)")
> > Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > ---
> >  net/key/af_key.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/key/af_key.c b/net/key/af_key.c
> > index cfda15a5aa4d..93c20a31e03d 100644
> > --- a/net/key/af_key.c
> > +++ b/net/key/af_key.c
> > @@ -3529,7 +3529,11 @@ static int set_ipsecrequest(struct sk_buff *skb,
> >       if (!family)
> >               return -EINVAL;
> >
> > -     size_req =3D sizeof(struct sadb_x_ipsecrequest) +
> > +    /* Reject invalid/unsupported address families */
>
> Steffen, AFAICT the whole migrate code has no family
> validation. Shouldn't we check {old,new}_family to be one of
> {AF_INET,AF_INET6} in xfrm_migrate_check? This should take care of the
> problems that this series tries to address, and avoid having objects
> installed in the kernel with unexpected families (which would match
> what validate_tmpl does).
>
>
> Looking quickly at xfrm_migrate_state_find, it also seems to compare
> addresses without checking that both addresses are of the same
> family. That seems a bit wrong, but changing the behavior of that old
> code is maybe too risky.
>
>
>
> > +    if (!socklen)
> > +        return -EINVAL;
> > +
> > +    size_req =3D sizeof(struct sadb_x_ipsecrequest) +
>
> nit: tabs should be used, not spaces
>
> >                  pfkey_sockaddr_pair_size(family);
> >
> >       rq =3D skb_put_zero(skb, size_req);
>
> --
> Sabrina

I think the check on socklen is trying to reject unexpected families,
but I am not sure if it is too late, and this check can only take
effect when the
type of family is handled successfully.

