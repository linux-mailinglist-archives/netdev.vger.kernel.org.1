Return-Path: <netdev+bounces-129833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFAE9866D5
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693D9B23198
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FBF13D891;
	Wed, 25 Sep 2024 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piIxb7d/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940E129E93
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292365; cv=none; b=Cs1HnbCbRsGVkzALrLn10buITKeWz4JJxgqrAO7G75VHDGCIM13VlvziOREVnygUBpTero7Q4S77SIrjPZ0U/0qNm/qZnNl/unQ6u7nQNInE4WJvIlLJ973TJpL7c4YIwv8NmhDQZ3O+DLGD9LAkbQaw7Xyo/8LuPSBRC+U1aqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292365; c=relaxed/simple;
	bh=Q9yw2XjXzLtOTXlJUvql4uEzP/L5lyTpgE7VtHTgrC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ne8+eVAf6wrcVSH1Cam9hBH6PHmPAKyGexe5xa15ebexa0TmR4eV3M3na6ck65jseTsh3Oo59g94QiFpXwwD9kR0fnZQRYebyneN42qCx3pulivgpXfTpLX9wai3YYu6w6xSkM47qzN2ZbZ/i/dNqhUfNXvH7ZGk4D4fKrLUyyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piIxb7d/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso126395a12.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727292362; x=1727897162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9yw2XjXzLtOTXlJUvql4uEzP/L5lyTpgE7VtHTgrC8=;
        b=piIxb7d/N8tySHDa5Mv/KsxHur7yY9MPdsUAGZvGItaWYxpb29PnuNyDo9jsJukjcM
         BzUBjvIZLu3OlojajU1jDZ1IZiHg9lpIUtLJWTuhkBiStVFi/rW0iiZzgGWhXqXdhP1/
         QOG/aOE+gdzd56UXIwpsknP7uQclxXnyCd017KMNqNoSI2oEmfR7he8lPi34OkrXM3tX
         7jZXS5Lnz6e4f0OHX00YAp4iAUqwpKmMFsb23dmeS50PKCOLXNuXtcf75L2vs8lrGfAu
         OaJEJ40ASU/yeEqLvLVTLDqKOzmOe8oMMGU1fy7qDqHTlVU2W8tt08jqU6M1YglECpTB
         Wz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727292362; x=1727897162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9yw2XjXzLtOTXlJUvql4uEzP/L5lyTpgE7VtHTgrC8=;
        b=a1hU+DqOrUioO72NHocAVJU2vT+PinoPPKPDQNe2txVW12Uea/8+EQyETcb3H1xIS3
         Dyq3+CGe6fJDsxuJnRu6fuXepu1DKSSe3dvT8EBxePf8Ayr1OpWISSwwBiE+rKNmPve8
         KXONk8CjTtZj1rwZLvtbV5yzrKjJeaRO9kSFHvyBWx/Iw17Gkncy34KYPvbn5U9WmBQE
         k9YcsY3cFLhhtMjCJbVcKaGGYn3BUZO215ly7bobs3nlF4weIZC3P5BShK5pOrJCBi2r
         9fmgAZO9BD3hybat6+G7XZp9g7Lou2mvZb6auaYUSAAHxiQ3YLqBWKFoV+lHqeCgP7oZ
         r9OA==
X-Forwarded-Encrypted: i=1; AJvYcCX8kEMScy/ufuH30RYjFMp038qsspmvNlpYkyn5NF/WOpgRoU3ZLBoPAI/UaJ/Et8Lm+HkU5Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxStEAEqYvFCMDVk4jl0fA5Ot6DEIQXG3zlhnXLl/GtztEkM5yk
	/OmCj0IIOcAjHvtD5xu0oTfyu7LGEw8/0KHAsqbcbDQ0Jf/5yOaKSy7v5IPBOud6csOsHaYRi3f
	ORMhGF5Xk1h95TYwYrPPTAUR9Bz7P8IbTtncT
X-Google-Smtp-Source: AGHT+IHHRNA+KIRA2swKZBI+fpT5BYjoa5qAfH9gIrq/eU7SvczH23wGfNPL8zzhzvbOb7/q5Xhk9odmVlpH+dTnsqE=
X-Received: by 2002:a05:6402:40c5:b0:5c5:c447:e408 with SMTP id
 4fb4d7f45d1cf-5c720754baamr2338532a12.29.1727292361698; Wed, 25 Sep 2024
 12:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com> <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com> <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
 <c739f928-86a2-46f8-b92e-86366758bb82@orange.com> <CANn89i+nMyTsY8+KcoYXZPor8Y3r+rbt5LvZe1sC3yZq1wqGeQ@mail.gmail.com>
 <290f16f7-8f31-46c9-907d-ce298a9b8630@orange.com> <d1d6fd2c-c631-44a0-9962-c482540b3847@orange.com>
In-Reply-To: <d1d6fd2c-c631-44a0-9962-c482540b3847@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Sep 2024 21:25:50 +0200
Message-ID: <CANn89iL0Cy0sEiYZnFbHFAJpj1dUD-Z93wLyHJyr=f-xuLzZtQ@mail.gmail.com>
Subject: Re: Massive hash collisions on FIB
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 9:06=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> On 24/09/2024 19:18, Alexandre Ferrieux wrote:
> >
> > I see you did the work for the two other hashes (laddr and devindex).
> > I tried to inject the dispersion the same way as you did, just before t=
he final
> > scrambling. Is this what you'd do ?
> >
> > diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> Doing this, I discovered with surprise that the job was already done in I=
Pv6, as
> inet6_addr_hash() uses net_hash_mix() too. Which leads to the question: w=
hy are
> the IPv4 and IPv6 FIB-exact-lookup implementations different/duplicated ?

inet_addr_hash() is also using net_hash_mix()

fib_info_laddrhash_bucket() is also using net_hash_mix()

You know we make these kinds of changes whenever they are needed for
our workload.

For example

d07418afea8f1d9896aaf9dc5ae47ac4f45b220c ipv4: avoid quadratic
behavior in netns dismantle

Just submit a patch, stop wondering why it was not already done.

