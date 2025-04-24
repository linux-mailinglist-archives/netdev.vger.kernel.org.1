Return-Path: <netdev+bounces-185680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69130A9B52B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD16189D7F6
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5242628467A;
	Thu, 24 Apr 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHZcHJye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C4502BE;
	Thu, 24 Apr 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515613; cv=none; b=UJQKnlzO+L7EcgFBDclKUZyqDYA1P8DPnrAzGZUzDwomI5qSVoOH7tn0nG7sJXM6n/gSsVc8b6QtEHRKHSBI7J4s5CUo5iHLSKCLHingXh4I1+ZHV58I+g7RcrZ8aVXtcWE24MtXPjsO7C9EtT3iM7UFHj7ljjma/2ILa/CvoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515613; c=relaxed/simple;
	bh=wIiZhFy3LxuX7Gvw4Izh6ggx4TutWUOG1hKDXZ1mM30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMvVCc0UoGKfNIqwOEG3Pyvt9m7Yb5tJelf6cG0KW+PXWsw2cQA/0bm8/5repnLL7ZDNKyqvHsgWq54jk5uQA0NYmItS7G/7GC0AYN9n9LZme98yLbt6LFerwnY50AkaRSl46HxAnVCv7UZUL9SVrYZEZUG1uvTUda1lXn8DBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHZcHJye; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so2100936a12.0;
        Thu, 24 Apr 2025 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745515610; x=1746120410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIiZhFy3LxuX7Gvw4Izh6ggx4TutWUOG1hKDXZ1mM30=;
        b=NHZcHJyeqniorBZlit2SQACoEV8Ir1pbqUaFQdLL/35PPKuW10RyJR0wMv4LRScSux
         kC7DoYoxaeGuCzY3DryV11xNDfBdLXxlmVxPEIx8kur2zOSXP0J0OW2fKOQkEiodbh02
         1YdivbQFzGLN7phvDa75ngT6IKWMGyCIw6dL7nCOayUuPYeXbD65DG9ZVItnnFJsj2u9
         pKiebW4XrhcLfy+oSmT8EZea/YP/xx5K32n6GkIuDi9T8O+lTaMYxjD+pgpmLdh73Xn5
         X8q36tnIDQey5actCIEfsqkjrMZguvEZK0eYElm7Q5CZBzN27pg7xkkXQCZIzH35E4in
         ggJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745515610; x=1746120410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIiZhFy3LxuX7Gvw4Izh6ggx4TutWUOG1hKDXZ1mM30=;
        b=bEEI7EGJKXNKAcal3ANFrXfrpKQPFDpk72FVjoyIatLvYmf6XTqItsFPxcesLjX2ua
         FIYr3bVsXgE5AU6ZYVXpi4Gxs5wyXMT591B1niXFkjOs72h7DHrVER8OIaczXw0XWL8H
         JVp4sFkfZk5UkmwAnCZeV9ce64NkYELCDfF9lS5QvrfwhIbNWRdy2ucdPvnqwqA3pR7v
         lxIbxdkQvHhTIh9RzLHzcIIrIiuH8QLfGXflJtVArg/z+MGftVMR/J3174K3iZVsUTtS
         73Ga6p4E4IMLymSi0YNKvFrJMQP+Pmy2MF22aoUfV68uLh1Kt0LzFQw2LRlgxbDuPqY4
         yb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWct6hSpHlud7f/rgGQH6BxGUQmwPEJ2NfCGjnlNwAF3Z36BIPgCuynUsJbhrYJisJnetEv0Uve@vger.kernel.org, AJvYcCXQdT7q3AFUsuG6D1yQjwlByaHnoUAJZ3Mr7qmjKuoKrBlkYtYjr0AE1R8jyLelv9Yn99oBnt/QTeqIdm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eD3UOq3B0c2HkOlSY9S7GFMBsoTtWb3ncOgJ4O/EW1jUOlRA
	IcLv4AewcdrgThzb+HD4KCmnOqfDkh9Fs9TNSwqJx6Nrz9VVCYy/IQv6kaJjQTQg8czEAQ6/+h2
	JpBAmYV28nYn1768SaQQaqGhJM6A=
X-Gm-Gg: ASbGncsmynenVOKdmH0CQwqhG5sSveOUtfExOZE5+90wXI4slDmj+RVos6dqjktQJdN
	nlvzlFYernkRTYU+vRj0d5us+h+dp6QGNGCVbkXqFrW+RZg+eAFCGddv5vLWSxGUgl6LB3LOGUQ
	GImSeTp5i41OnYkTZm/uK9
X-Google-Smtp-Source: AGHT+IEGOMR+vkqbrr1aAnKdjcsgbPhgb/w0LxGlhNTkXPi4SgqxARsBt3AVG3NQTKJE+6WeiTKNkw4pRe9SmtykSJM=
X-Received: by 2002:a05:6402:3481:b0:5ec:939e:a60e with SMTP id
 4fb4d7f45d1cf-5f6fab0aa66mr249451a12.0.1745515609608; Thu, 24 Apr 2025
 10:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com> <80208a6c-ec42-6260-5f6f-b3c5c2788fcd@gentwo.org>
 <CAGudoHEwfYpmahzg1NsurZWe5Of-kwX3JJaWvm=LA4_rC-CdKQ@mail.gmail.com> <cd7de95e-96b6-b957-2889-bf53d0a019e2@gentwo.org>
In-Reply-To: <cd7de95e-96b6-b957-2889-bf53d0a019e2@gentwo.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 24 Apr 2025 19:26:35 +0200
X-Gm-Features: ATxdqUFYWN-cd_DMErkV7CJkSwlUQKtICdN_JoevuiBqeeRvsQR6ZYn-MTzoDb0
Message-ID: <CAGudoHHbSKLxHgXfFYFdz5nXFBOQPh5EkCX8C7770vfMH-SLeA@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 6:39=E2=80=AFPM Christoph Lameter (Ampere)
<cl@gentwo.org> wrote:
>
> On Thu, 24 Apr 2025, Mateusz Guzik wrote:
>
> > > You could allocate larger percpu areas for a batch of them and
> > > then assign as needed.
> >
> > I was considering a mechanism like that earlier, but the changes
> > needed to make it happen would result in worse state for the
> > alloc/free path.
> >
> > RSS counters are embedded into mm with only the per-cpu areas being a
> > pointer. The machinery maintains a global list of all of their
> > instances, i.e. the pointers to internal to mm_struct. That is to say
> > even if you deserialized allocation of percpu memory itself, you would
> > still globally serialize on adding/removing the counters to the global
> > list.
> >
> > But suppose this got reworked somehow and this bit ceases to be a probl=
em.
> >
> > Another spot where mm alloc/free globally serializes (at least on
> > x86_64) is pgd_alloc/free on the global pgd_lock.
> >
> > Suppose you managed to decompose the lock into a finer granularity, to
> > the point where it does not pose a problem from contention standpoint.
> > Even then that's work which does not have to happen there.
> >
> > General theme is there is a lot of expensive work happening when
> > dealing with mm lifecycle (*both* from single- and multi-threaded
> > standpoint) and preferably it would only be dealt with once per
> > object's existence.
>
> Maybe change the lifecyle? Allocate a batch nr of entries initially from
> the slab allocator and use them for multiple mm_structs as the need
> arises.
>
> Do not free them to the slab allocator until you
> have too many that do nothing around?
>
> You may also want to avoid counter updates with this scheme if you only
> count the batchees useed. It will become a bit fuzzy but you improve scal=
ability.
>

If I get this right this proposal boils down to caching all the state,
but hiding the objects from reclaim?

If going this kind of route, perhaps it would be simpler to prevent
direct reclaim on mm objs and instead if there is memory shortage, let
a different thread take care of them?
--=20
Mateusz Guzik <mjguzik gmail.com>

