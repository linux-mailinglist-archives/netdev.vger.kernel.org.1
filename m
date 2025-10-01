Return-Path: <netdev+bounces-227425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6DBAEFBC
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 04:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D673AF6FB
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362725D527;
	Wed,  1 Oct 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CGOo6OXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCA25C80E
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759284605; cv=none; b=ZItlKblTETEoPGq9dCORh7o6CYRCU1mMHOrT/Ka76/6FZGtdulhhcokzjCzHCH/rMsWM50NdoCGdUEzGOJtdm/Vyt9hHv1dIhWQksiXeIFulJRG1DApOB4riXWixNyifCgWC9yr9CKllOwjGZ/igdF1GQjTk1c3QMlRlUTgx6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759284605; c=relaxed/simple;
	bh=ewy8bEtm2e2qFkCfiN1Yi8GekyihfoxvOUMheYkIH18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c32pVrSz7qbFjnZZIYJccszkayrBXfvx1mWTWqQyRYFqJYagBSfRbN3PHq1W+GVnrPXChecXeNP83Lw/qFmGqbusYcCAOMhQgQXszoM4Az6QebzEYFyM8WidR/rtqHuBd0TkdQLggrATJDkFAZpA5V4heV9mgOtskZViI4DbZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGOo6OXc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b0418f6fc27so978905966b.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 19:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759284601; x=1759889401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7erB5ZGDmVyr8AkZLrpn4uzVS17t4/mCKRzLiEmHgA=;
        b=CGOo6OXcmUhMZEtbtW6LWfGpxv2CPJrLc3u5NvfMLnGcYF2JmfHNbkS/zvArXz72pt
         nBN9XpvPN0zT0W/hIsjR2lBuP1y9KWsPzCSBFyEox7gZdjyT1eOjKzOFVULfYWUFLebg
         G4Bf/qgmLt7fG2EB9xlHiJZJFRMiHMXW+aVE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759284601; x=1759889401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7erB5ZGDmVyr8AkZLrpn4uzVS17t4/mCKRzLiEmHgA=;
        b=TnAMKcmE0ULwX2vHzp2AkmxC2aqo9OMcWaZv4grtzeBmb96tYCftS/pvdZYi4l/n78
         SSdAHgVYNO/1X1RNVQaB0R0l/agd1bFC90obEG+o7bZtjkRU2iDwyXlYIPIzT14309BY
         dNdHJvSUkmh60/yOgPcOWRoPQz9ITa9Cim28dbJSbhRrcSCh11q4WIaftc7YFNfKldrH
         2HMRezj8KYGaNJ/Q/evzjN2To0aAzfkTXo8eWu3GDdAB3twVJKVZ2lTdeUTJ9qAE+KMk
         mzG+2/WJPr98y87B0kVPsLbi3OiTWLvwIFJUQoXaV5KHa3Af9ZjOdNeaCg/oTVhfvjw4
         dZQA==
X-Forwarded-Encrypted: i=1; AJvYcCUdHv0Y/9H1MXkhESmR4sJhFx+7zrhO/yxYIisoQwuwwV9ipV1zfOTb7s1PQWt0eIGI9N4Av6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYt4KFRne59y8MR5wjHldd2f6E1frijqK4/8TfjXCS5HtoMjP
	O/WqwO50iAO4QoRYgOXF8dD3Lqch0gCiPDBdA3fQbNH7NZVPn2Dw0OaBFJqy61qzoqoCv8hSCp7
	tGOGH3Ko=
X-Gm-Gg: ASbGncv18uKi8XxhT8B7dun0LmPMRDXnNcIntq44p7kRS2zl+vaZCqkQIq4YwtWEbHE
	8OCAghbE2iSg8M3vV0Q4NJz4iHe/sBx95fYD9PKy+7lJo7z4MtneGR2eL0NjVIzhuXlh1pm/YmT
	pbuA8MTC5jYM11vG5DoZgDUfx4kRzZVwdulJV8tPpeXN3Eecu7r3gFtCukRVIbbjFl3+oBUKZtr
	vC4aM684ApJtiUjeb5QjlSafsouAnOOnGwOk10fq9K/OUrg8wwZuL6SE+jJx93Pz73kbpY8Ilc6
	ltPnK3r22zudWxX8oVJNArdHurUkVcaVPH0vSL4XE3jLYq0xbcsRmYgqAgISiVz6zP8IOcKQibS
	8IvsgK3ToN7Ej2RAXAaYK+LqccCCJuhq/w9IH/zgblV+yQrvl/PFLd+Tb9iUPE3bDmpo7kBVHr4
	BW6EQDDF8ea1m6qHMVy+VU
X-Google-Smtp-Source: AGHT+IHyhjdbLkpFeeqM8YiPSHLtRhAjBjABY62AHWtXp6BtDSG1GfXLjW+nUV1zklALjl1xArb9Gw==
X-Received: by 2002:a17:907:6ea5:b0:b40:da21:bf38 with SMTP id a640c23a62f3a-b46e479ff19mr184989066b.36.1759284601377;
        Tue, 30 Sep 2025 19:10:01 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7681sm1266799066b.58.2025.09.30.19.09.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 19:09:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0418f6fc27so978902666b.3
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 19:09:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfJsaJCUuodwp7+sMnMv+Me26JRYa/0RGtdPpE7n/6I0TcKc8fgKWrV+xFay/7OVBnooJucYo=@vger.kernel.org
X-Received: by 2002:a17:906:c146:b0:b46:1db9:cb7c with SMTP id
 a640c23a62f3a-b46e4791038mr207901666b.33.1759284599468; Tue, 30 Sep 2025
 19:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 19:09:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
X-Gm-Features: AS18NWBi9I9vAHH4YHKcIzlLSZYxGaQO5CqV_lK8IoryGo-bstgFslhzgwijcZU
Message-ID: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
Subject: Re: [GIT PULL] BPF changes for 6.18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, peterz@infradead.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Jiri added to participants ]

On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Note, there is a trivial conflict between tip and bpf-next trees:
> in kernel/events/uprobes.c between commit:
>   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when =
ip is changed")
> from the bpf-next tree and commit:
>   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> from the tip tree:
> https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> since Jiri's two separate uprobe/bpf related patch series landed
> in different trees. One was mostly uprobe. Another was mostly bpf.

So the conflict isn't complicated and I did it the way linux-next did
it, but honestly, the placement of that arch_uprobe_optimize() thing
isn't obvious.

My first reaction was to put it before the instruction_pointer()
check, because it seems like whatever rewriting the arch wants to do
might as well be done regardless.

It's very confusing how it's sometimes skipped, and sometimes not
skipped. For example. if the uprobe is skipped because of
single-stepping disabling it, the arch optimization still *will* be
done, because the "skip_sstep()" test is done after - but other
skipping tests are done before.

Jiri, it would be good to just add a note about when that optimization
is done and when not done. Because as-is, it's very confusing.

The answer may well be "it doesn't matter, semantics are the same" (I
suspect that _is_ the answer), but even so that current ordering is
just confusing when it sometimes goes through that
arch_uprobe_optimize() and sometimes skips it.

Side note: the conflict in the selftests was worse, and the magic to
build it is not obvious. It errors out randomly with various kernel
configs with useless error messages, and I eventually just gave up
entirely with a

   attempt to use poisoned =E2=80=98gettid=E2=80=99

error.

             Linus

