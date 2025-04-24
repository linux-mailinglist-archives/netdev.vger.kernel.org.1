Return-Path: <netdev+bounces-185652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F392A9B346
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84B43ABED4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A427A926;
	Thu, 24 Apr 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBco315q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503E27F741;
	Thu, 24 Apr 2025 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510607; cv=none; b=Tk0Az0Jg4Kt5XaC9D2xuDpB2/ma0HjF4qhmXYP9xAU2hnozVj5pAGubVnihItVJGNryM5bLQgIemWVMNU0kaS3zejxZwOBdxt7hWYjnyT9EGy1rmSQPWOxth2ISyrLDYQgU45UHY7nB02Skp9zT3q5fhHgB5lsmLzFBC3eRfA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510607; c=relaxed/simple;
	bh=gwmub9V1s7OtbSQu33WoDoG4zFi1R//niy7dgWyB1Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwiKLP6gQz2OUGfDJk1CFlYDDf4C3CzIQi5+sra1XkfmJxjuDAiTtOjOynZEqY6zE+1zeFJNdMG2mihOex9i4n8XeA5yv8HExA3jvclM73GIhMqHHmGt639Cx/iAID59f2/zi4i/k0OEI72bh5D8+uI+DRC+/j2ORXQidaZgg3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBco315q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso2058238a12.1;
        Thu, 24 Apr 2025 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745510604; x=1746115404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwmub9V1s7OtbSQu33WoDoG4zFi1R//niy7dgWyB1Rc=;
        b=dBco315qtsaUtYQQTx6xiwfTYMg4Fv/iaz8u664BxpHdBXbTbPw8AefgW81cpqRHcr
         1L18WDoendtU9IgRwwFP31yMgjsrtCJEPY/yXTqn1faVjrpkuOtih2eIQA7jqUWpxUow
         WM3WgZ33iWDDKmR6KgtOjLVvRyOddLbxi5Sx6qhsSMHIQgBZ34gGASSAr5ZySQGMbx96
         Cd4ZhfIp2rt3mAyBzkt8k7SZ2O0hrP86+OgW9XGMO/1SSLOXGStZ7nOwg1Nu8BY8WM3O
         dSPhAssgcbDeL4t03sy4ZFCVZxcgyu8ZzLDcg+I34HDBYANQtP9iKIygdvExaYXxBdc4
         eS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510604; x=1746115404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwmub9V1s7OtbSQu33WoDoG4zFi1R//niy7dgWyB1Rc=;
        b=PpUgiSu90WWP3fnqLRHuHoaAZRDxiYc7f9TCIHvJYyo5ahAPeiXgn/7M7nIk6YA1S9
         xqomk8eWb2z0dNElknMcroQ5x0K5r8QMe6UPiXsMgulG9hkdwCrmb67CuLJrKsXitj5v
         kFCTwC/4GobRzXvIkM8/AABws9bP+HPXV9RlU3Qxpkdcpk1JYCv9WXJ9SRJd3fxKYS/U
         KmcXmzfp7UNSISCkMjmhvCKLrm00JjsC3yhjixJyx4hI78bOM6ELpy5aR80raa3DP6p9
         a86AJpGh5Az5KB9G/wjJu5Xplt8zB+rYd4wO5YHdBT2zcMFGUvlDDvcgGc/7e06G8xaE
         OkHA==
X-Forwarded-Encrypted: i=1; AJvYcCWXLVSahjSmHea+Xl7BHNEbhiMFxTNigrK540EebDFiFS+6qaiF4sOr7Sdk4cEeGWWokEbYxJE4jAPw+9A=@vger.kernel.org, AJvYcCWZ4PqlUCvxbEx9tPomz259o5+LXPVhzONvgqccg/loHhImG3viMQMCY0tUxTPiFnx33iheK/zJ@vger.kernel.org
X-Gm-Message-State: AOJu0YySS2to1/WymXQ0BFcrfQ4agQqrxSUjrkuNln4uPNSnWhj4m0GZ
	e0ZypnlN/w1PWxgRXZLu6WNUVafDRpW2yvUBLYav1aEhkzOICfmijb/+dOjEK8/a5okJ+ry4ZFc
	jk0xLcMnC9a4TxYjOPiWiOe1il/Y=
X-Gm-Gg: ASbGncuYVz3oivf7ow8nnBp/F7mIFbHjJ2/sySzrxwIDrhVskSz2KWbeYAC9ziF6BkM
	N41VOWOGRDdW9ZPYtzOJQwQEZMwoKQz11LrPwRhUHK99TIaZ/wMcHmF2pOWGxBrESlJf45Wabpr
	Y6jaoTN3gkw7qqjZkb4QH1
X-Google-Smtp-Source: AGHT+IFQWoL1hL+rjuGIAdSWWrMhRLWhWHhJBObVQO6gqAAl3XAQ1e2z0nGjbJtm8t54PmKZEdKGUsYL/h/aFwUgIrc=
X-Received: by 2002:a17:906:4fd0:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-ace572a2580mr297129466b.34.1745510603548; Thu, 24 Apr 2025
 09:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com> <80208a6c-ec42-6260-5f6f-b3c5c2788fcd@gentwo.org>
In-Reply-To: <80208a6c-ec42-6260-5f6f-b3c5c2788fcd@gentwo.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 24 Apr 2025 18:03:11 +0200
X-Gm-Features: ATxdqUEOWFXlCzjV_nM4MRoRlDiYlYAK5aexpc-gpBDaZKUfEa2BIixZznjqzs0
Message-ID: <CAGudoHEwfYpmahzg1NsurZWe5Of-kwX3JJaWvm=LA4_rC-CdKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the percpu
 allocator scalability problem
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Vlad Buslov <vladbu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>, 
	Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 5:50=E2=80=AFPM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
>
> On Thu, 24 Apr 2025, Harry Yoo wrote:
>
> > Consider mm_struct: it allocates two percpu regions (mm_cid and rss_sta=
t),
> > so each allocate=E2=80=93free cycle requires two expensive acquire/rele=
ase on
> > that mutex.
>
> > We can mitigate this contention by retaining the percpu regions after
> > the object is freed and releasing them only when the backing slab pages
> > are freed.
>
> Could you keep a cache of recently used per cpu regions so that you can
> avoid frequent percpu allocation operation?
>
> You could allocate larger percpu areas for a batch of them and
> then assign as needed.

I was considering a mechanism like that earlier, but the changes
needed to make it happen would result in worse state for the
alloc/free path.

RSS counters are embedded into mm with only the per-cpu areas being a
pointer. The machinery maintains a global list of all of their
instances, i.e. the pointers to internal to mm_struct. That is to say
even if you deserialized allocation of percpu memory itself, you would
still globally serialize on adding/removing the counters to the global
list.

But suppose this got reworked somehow and this bit ceases to be a problem.

Another spot where mm alloc/free globally serializes (at least on
x86_64) is pgd_alloc/free on the global pgd_lock.

Suppose you managed to decompose the lock into a finer granularity, to
the point where it does not pose a problem from contention standpoint.
Even then that's work which does not have to happen there.

General theme is there is a lot of expensive work happening when
dealing with mm lifecycle (*both* from single- and multi-threaded
standpoint) and preferably it would only be dealt with once per
object's existence.
--=20
Mateusz Guzik <mjguzik gmail.com>

