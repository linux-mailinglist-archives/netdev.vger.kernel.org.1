Return-Path: <netdev+bounces-193093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B80AC27CF
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365563B947D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1C296D26;
	Fri, 23 May 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fx38Ads2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B9521FF2F
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018745; cv=none; b=driFrlJc/N3+GFhH++dGSDIZLVpLUaKqEGuhMAuhPGogqSVnC9b37D45s06tlFKfMvalgHlNyVfB2kYKrLJhZUWF+Q6MAkqWPuTAFLzHB+f/k4n9F1jqWIEp3VnRNtdtNmbE6wt76kWT2Jv90+1Wg0KbfX2K+k82aVsA9iag9wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018745; c=relaxed/simple;
	bh=mpFi+2LlAim3mrcdlXQrRcd+42FS4GK431HSAs3Pv5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYUJRvnJyfCN+ObXOAP6/X6EP06RAt4yVtocEBCJj6RTaomy/Qh4AUcjzth1gIm1ZCXPdktKlt/GqUcXYmtszqIjtFIZ9iVIAst1Fv7feUogKivTg6+8BqyYMGMZr7Dgah+scfTKWCKVDXGTcnM+jUDLOeTbPDaoMmiU5r1JvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fx38Ads2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-231ba6da557so1905ad.1
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748018743; x=1748623543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbEfAILviHMr4oDTgiobfZLOFz+Pj86C9/pKLGp4dvI=;
        b=Fx38Ads2KsM0At3WNqmcGdi2x7suJV/Tbp5TngGz3F/WB3HK5EJdortRVrfqG+A/7p
         7CGyX8mUC27p1Ryl7/FgQT4dDbdnHY5LWPo1upX0CnIvdJjLq6TVzb/dg4GOwvLQaCxF
         hw8CNRsfQbVnXwdU9DlHPGYvT0XN6WLpJTvq3z4aqEJ5Bq1QtYLA8OFvMC3AvOLI/ITQ
         cat+uMkjodSB+Ms2j1+NERmO82mjpLYl9uSSXUqGOgz2WT/UUnKFS2oTVewvP7MbU5FT
         qpJSsBTtqvvLSAgLrTOmkUCTftf/R/rIMHQrkD82GkLYPfpfiN0SL4naFJ3jmgBR8aSY
         yXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748018743; x=1748623543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbEfAILviHMr4oDTgiobfZLOFz+Pj86C9/pKLGp4dvI=;
        b=j2MXhwKLgfbcqEnbsQpw4+9il+SsCv0JENHbLuZjQaV7+IVLoeck+/qL+Qhl/tIElT
         xN/tTi7MxsS1r49cfzGDbWnqeTvJT/lc/4xulC/AsJyQrdqnt6vXIkJE5DcHJY/+EBWt
         CLz91jSEUZY+XwHCmfZglvkiztgINb7V67516fDADrtxdtM+hx99vfUB5QiABSS41mW/
         18m97bFlmYTVOdV54f74HLgF0Svwz7ySDowPgY6grV2sHTSulKO+mkBYnhrlCvXvj5gw
         rSZNIgc1e/knMJZrm/RP4fmO5ibX3G/SCacWURght/HtAcAH8m9U27fxQwV+6zHXSVdr
         17ng==
X-Forwarded-Encrypted: i=1; AJvYcCXfseZnim2EuWdREz+RugK24Xe9U0a6h60TO+hmvHnUKW27n1vdRTRT+yKDxj1EYCi/nxNOqZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JfU/PYVbJWS8Tcj6864wSHLOYBws7VMT4LSJAxPZDsbmgKdY
	Tf69Y+S1g9ujkYCgBTL0XOfcnuC9oKgb1yvr+LL3cq7KZ68Vupo00QEdUSv87bYIwtTIcobxmdI
	T6vMtK7b7VcU4msBTXlPYqGJPWrVlN1BF0HRbvNCT
X-Gm-Gg: ASbGncvwG683sHWnfaEfUeDLANe7F+yu0EENuc2OacvRwcbMtsKvjTfrsc3N1oaj04k
	oGMv1OxRrQ6OIWkIQrlz4Ci8Y/tWR91JOnIWzOKfx7SFjtWImsLJnW8XhC8Nrq9N0M5Je4LIs47
	RdQ8hWp5GJjgEHCsNUT+k0ZkCxh80rxOShc6J/u6FfBahvdbaCegq00mYs96qLBAa2uDcMWnqJK
	w==
X-Google-Smtp-Source: AGHT+IHKENtOk1185zLF5YBywUwyLB+xqcNyvyViyfrVAjkVKT7E+/W3igasj3tGPTfHTU6T75kaDQdKqicwHmsdjXE=
X-Received: by 2002:a17:903:3c4d:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-233f306ae91mr3190475ad.12.1748018742179; Fri, 23 May 2025
 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523064524.3035067-1-dongchenchen2@huawei.com> <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
In-Reply-To: <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 09:45:28 -0700
X-Gm-Features: AX0GCFtkvgsG2TRBwxiCM9xaIIEsYdecLQRjq4ECWuQCPug6wVwy2u3pcYDiD8o
Message-ID: <CAHS8izP=AuPbV6N=c05J2kJLJ16-AmRzu983khXaR91Pti=cNw@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: Fix use-after-free in page_pool_recycle_in_ring
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Dong Chenchen <dongchenchen2@huawei.com>, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangchangzhong@huawei.com, 
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 1:31=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2025/5/23 14:45, Dong Chenchen wrote:
>
> >
> >  static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_r=
ef netmem)
> >  {
> > +     bool in_softirq;
> >       int ret;
> int -> bool?
>
> >       /* BH protection not needed if current is softirq */
> > -     if (in_softirq())
> > -             ret =3D ptr_ring_produce(&pool->ring, (__force void *)net=
mem);
> > -     else
> > -             ret =3D ptr_ring_produce_bh(&pool->ring, (__force void *)=
netmem);
> > -
> > -     if (!ret) {
> > +     in_softirq =3D page_pool_producer_lock(pool);
> > +     ret =3D !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
> > +     if (ret)
> >               recycle_stat_inc(pool, ring);
> > -             return true;
> > -     }
> > +     page_pool_producer_unlock(pool, in_softirq);
> >
> > -     return false;
> > +     return ret;
> >  }
> >
> >  /* Only allow direct recycling in special circumstances, into the
> > @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_pool *p=
ool)
> >
> >  static int page_pool_release(struct page_pool *pool)
> >  {
> > +     bool in_softirq;
> >       int inflight;
> >
> >       page_pool_scrub(pool);
> >       inflight =3D page_pool_inflight(pool, true);
> > +     /* Acquire producer lock to make sure producers have exited. */
> > +     in_softirq =3D page_pool_producer_lock(pool);
> > +     page_pool_producer_unlock(pool, in_softirq);
>
> Is a compiler barrier needed to ensure compiler doesn't optimize away
> the above code?
>

I don't want to derail this conversation too much, and I suggested a
similar fix to this initially, but now I'm not sure I understand why
it works.

Why is the existing barrier not working and acquiring/releasing the
producer lock fixes this issue instead? The existing barrier is the
producer thread incrementing pool->pages_state_release_cnt, and
page_pool_release() is supposed to block the freeing of the page_pool
until it sees the
`atomic_inc_return_relaxed(&pool->pages_state_release_cnt);` from the
producer thread. Any idea why this barrier is not working? AFAIU it
should do the exact same thing as acquiring/dropping the producer
lock.


--=20
Thanks,
Mina

