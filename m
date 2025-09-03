Return-Path: <netdev+bounces-219738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7CB42D58
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B423A5D25
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BBF2DA758;
	Wed,  3 Sep 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U9zVtug/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016C1459F7
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941964; cv=none; b=Kx0+cARh9yP2VDl61GHp15HTwblKMyhUGbZxoh2D88HXTaTBjDUNeu+StRBL/20d4nc87tO5sRUO30BVsYXF6PAGudBf+cL0amuQrKm0OO8Ieow8u0tHxeW6jJR+alnyH6/nZdHpxSIqEktmZG2oQyv0alhOrebhCOZvYH8MmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941964; c=relaxed/simple;
	bh=CZCxyVRjGmIgbC2+w/rDZBnmRaashl0wu/5ho5DdFng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhVGEK4kTULUnQO7vfUHIjP6+pw5m/kqI7v8Lf9KfhFQ/jrtkEchzZhz/Qkag3W8C7VC0DWwmvOIax2K0IIyeHfywEDMRzbaPUVSKDP5TBW8IdMWDWTQPBC9XvC4iO66OSKOz7vvi4k73k6mo9BUAPqKcMKegA3pK6hKlA3mWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=U9zVtug/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so297797a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756941962; x=1757546762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwdklP4KWlGIE1TPiux2aozGiq8ju61lCzTwNSsrvjg=;
        b=U9zVtug/jre9t4P+HI57eB/Y5TQ3FV2YwNCqf4uR6NTFDvTWr/FRp1AU8bSVozEx9i
         VdiShPpiZOapHbMQ4W9DG+SLiXqrxqgWqRxhfwWbEgTz10Ibykga4ukr49SLpa4j5iA7
         DOAWJtHYNWETXVYgankR6I/gXHONafSleh2zD2LV4wSs8QqI4+Fj8sXR0/eyvacL0Hdh
         t25yUd0QBEmIKIzVd1eDuCBypwCBQ/lnBVVIMqX/OO4bc9JUtaOeO02szBhN8RnrV/Nd
         8VlGETw2znPMOwv9gBjvgMCUGhG0FcOiQI+b9XE+VBd7pM/Eqrkao2t0nooCgt1fAC1X
         KLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941962; x=1757546762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwdklP4KWlGIE1TPiux2aozGiq8ju61lCzTwNSsrvjg=;
        b=pkOQJJVYK6dIm12uPZPlUPSBiccvz+zx7hgyvClHL6CXbn9T6dlRrhySNdXPyNIruk
         HCEJ3F83eSiPk7fZ8Y3qFoGIAtzXHEh9UTV6yBbXIcDG8qSdQ/TlaFLIZZGFqRwVKCCB
         2IXVqyy+aU3axs17viyHG4IFELvRB5117BqJZ0dn9CapH86KC9/5ABVaZSzw/e/86lk8
         mXb2OAshVQkplQQHtpa+/OtiZYxjlN1b4JQS0PIsriw0Ml83Jg5TuO/n08XAwZK8dLm3
         0C+AKZ3EOExX+L6TP/+wOgUG98/HBtlTBTNYq10AyC2NddeRF/IYOo0wWktoSmiQ15SE
         4RMw==
X-Forwarded-Encrypted: i=1; AJvYcCWiAEWU1SsW/rtM7scN6OeGUYzkuNZfXhdCRhq0cOORg5un9thPAKo05fanJhyd0iLqLcFPC3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeDXDOb57yi9EaRhj0nSe10TQZeVMXLnSMbPVnS8KX3y3TDaHU
	etqyKF0bnABhfkdM76G/sLsq4aiByFN1nip7ViycrQ8PtE6+IVwuT2Vuybo6QvFr58gFCfLtQ+u
	fwAkEBNswb1cp9DZNZOEcNN+anvDj1dtNLyZuTnyd
X-Gm-Gg: ASbGncvNmVo6p5EKhncXTSZyku6Mt6vlo2pJ15xmXEsqVoogdbTj/M1JfsDJgqATb9A
	e7xx/uVugN7Jz7MUFEGewzFRuRhhqK7p41QMmcD9T+LAghE87C9zSFb5lVmgFYbbYOb7xHQupF/
	9o9n9NddbynNQN0Pxzf5SqVOdlakMHl56EXUjKgofGhMCjKVvsAJlY7RFaiHaonRYSfO5l6mguj
	bGoaruhw3QxZccNds344C9+BQOxr1wucmEKa2+xJi6lB1w4SQpDnmvYLkzQ9oVfX7NdbMSSntiw
	yD+ofwaf8gXecfWviAzM8t/faVXqsqSt
X-Google-Smtp-Source: AGHT+IEJt+Bc66o4PxoYoI6kkp3fEpqoU2LXdQUNHT9yM38QSK2XD/eq/9C2pWmpWi3fCMgYVO3TS9qXhaYKQ6c9OMo=
X-Received: by 2002:a17:902:ce02:b0:246:a42b:a31d with SMTP id
 d9443c01a7336-24944ad758dmr206762635ad.44.1756941962239; Wed, 03 Sep 2025
 16:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com>
 <20250903-b4-tcp-ao-md5-rst-finwait2-v4-1-ef3a9eec3ef3@arista.com> <CAAVpQUD1mPPFHx+7eVEVJq1xz1S4PJVDcN6FDsVxPy=ehNiV7w@mail.gmail.com>
In-Reply-To: <CAAVpQUD1mPPFHx+7eVEVJq1xz1S4PJVDcN6FDsVxPy=ehNiV7w@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 4 Sep 2025 00:25:50 +0100
X-Gm-Features: Ac12FXz2-8v5QXc2t5UnQHmCGXmAEH983k_rFviNYPRTr7vbSyRsyg7wpi9XgJE
Message-ID: <CAGrbwDRXcVM08a2=Vph1Bf4uq7+aFe7kBhzs+oA6zRTd8ZXeRA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
> <devnull+dima.arista.com@kernel.org> wrote:
[..]
> > +void tcp_md5_destruct_sock(struct sock *sk)
> > +{
> > +       struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +       if (tp->md5sig_info) {
> > +               struct tcp_md5sig_info *md5sig;
> > +
> > +               md5sig =3D rcu_dereference_protected(tp->md5sig_info, 1=
);
> > +               tcp_clear_md5_list(sk);
> > +               rcu_assign_pointer(tp->md5sig_info, NULL);
> > +               call_rcu(&md5sig->rcu, tcp_md5sig_info_free_rcu);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(tcp_md5_destruct_sock);
>
> EXPORT_IPV6_MOD_GPL() is preferable.

Thanks, will use that in v5. I did remember that ipv6 may be compiled
as a module, but forgotten that there is a special helper.

>
> Other than that
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Thanks!

Thanks,
            Dmitry

