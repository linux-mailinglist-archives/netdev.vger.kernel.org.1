Return-Path: <netdev+bounces-247891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8E2D00427
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 22:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002FD3033D65
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 21:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B4A318BBC;
	Wed,  7 Jan 2026 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZTcugHZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD762D3231
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822856; cv=none; b=tO+pFqo6r+nULBGHZeSNQ8SxI/itA8R6HyyO4ERz4lDl1jOp2b9tnxQ3q4N89qBxO+abdqohAgajzwJfVaOlDneEISWPjM02L8m6k5KLDaaA45LRAvpmcPPvgoLmm4eSe7KMGH643TIzxHaGKgfeV4Pkj4FKbB9LOdNJx7n24y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822856; c=relaxed/simple;
	bh=/MejwX65hDKfR53cfS2/woBJf8a6swBHRdIPDU/11ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4HIIkvSkq2NP87NAjUrkcYsKmNJiRzzfiWtjd5FSF5V4e3+qvwnue/9euW6KdodtwipAZimqdrnW7HFc7DZX3h12gXR67DBzI+zcezicvyChqslF1x33FDGckCOG8BiZmxMmn8tt8IQOYwd5//jtx9vuWgyW90ZOLs06Kt4Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZTcugHZU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso1102729a12.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 13:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767822855; x=1768427655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glsfhtDUmyowawtGUoJCa771AHF+/UGGwRgXKhqc+y8=;
        b=ZTcugHZUC9ieAvB/Va+V/ITTY/Xwf6Lz0B1lrUMRZQ+KCemYKW4dX1K0896uVuW+W4
         e5i4ws1vBBt2uB3x4ymUPA3We4Q5yv8d9K/I8oD3FBg0EFuwCbmDwhq9yUmpyski7J1G
         /poj3Un56Ozsy0VCv7nuGcjU7q6AZ07jhWRPwM3SFCsyrzpaBLJmmGvNlzR8g2ErqhU4
         J9f9rSIpEkW8pICt1nch4RDsN3cGauucZ3/LFroj1BGMS0lNiBa+vaE67aaBLAyr6dud
         JYF2GHlJgclRhJmCwagfY9OJcliIbn3WK+RMzjm4kKncfQOf8GvxwImwolAtrFsk8cbv
         DkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822855; x=1768427655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glsfhtDUmyowawtGUoJCa771AHF+/UGGwRgXKhqc+y8=;
        b=R4aXm+oJEH66cyuI7cRjszzFhc5uEeHMIrMpLkqFke48jFAfEPsQBP1Mga/lrbVmfJ
         xj7h/poreAT72Vv7AkJRsx3S6BQgvy5eIplxtF3PtdD2NhBl/jo+W+Az4awgk64yTavP
         T6w4Hgeg5h59vcdDDzX+JWY0BQbdrC1yT+7igUg7x/mmlq8sDiUozOQ8gXjJjexTjzJo
         HJ71zl8QwcyvGg8+n6y5nm+G1tswqLmGhdCB8decgT8OInutWKi6S67Loh5QK6UuNtLd
         yBzGlz418xK+nL5oZo9Ido62wXteCsmHLNHbt/bfLLxLrryojjbz+FJBmVIjfLUvNxan
         OfSw==
X-Forwarded-Encrypted: i=1; AJvYcCW7N203BXWL0sHV+nYDd0nTSWs6Cy5eT4opwC8ZssLknIphJpyku+OwCUs5ylXRSYegWSj8ONs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/TjJ69PDiC2UH1H8t6NIWiP3iVlykUIyBewXYcHagm9mHFtW
	tOhIPmF2lcBcf6M7HZJBR+H+FoVlFG+h2dBHV2cINU6i7xuAfuxUXuryBP+jPswh4krKvNiLWlu
	nMHBtAyQlCuizQ7Hu+JqK2Nu0fG38y/DE1ua23BMU
X-Gm-Gg: AY/fxX50vySHabMfqIg1azA8OOX2nNaoBc+hoa6qcNaldk3USgrqL2xQzL67blbV8UJ
	dx6NHcFt10msaNiqR2C1l5/dcyWOvEEuYHUvJU7Ej2RTSNyZKoKg959cTRv7J/ujBMSMCx+OwAh
	V6UXv3YJopUqjoX29SDNZutLs35WDtqJOnaJhmojqbrBzO8cXvOmgat7Jb/2VfvSlY1kaTU3+Yz
	GVNIKf38yp9Y3IOQ+MUcUvZUwuCw5P+dbzgXrGWZytg86Z+6+kgs3hLZaZlymQJPDUy0xo=
X-Google-Smtp-Source: AGHT+IGmDa04TwAFrUVZIKE0bCmyIfgat7wJWWL+XRgau6V3p4p1z6v7uRzUa5yn29Rvvq5RrrPOJUM02YqDMGwe8b8=
X-Received: by 2002:a17:90b:1650:b0:340:d1b5:bfda with SMTP id
 98e67ed59e1d1-34f68c33781mr3244535a91.3.1767822854607; Wed, 07 Jan 2026
 13:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Jan 2026 16:54:02 -0500
X-Gm-Features: AQt7F2qw6OaC4MXbk1CPG_jNqQef9CEQ0d5ZkvwF0tURdpz-_nm5g4KzXb8fLmg
Message-ID: <CAHC9VhQF26sVYoKxZ_7x2nL1HxuK0zeH013e8ugigz9B+Kpkjg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 4:33=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Hi,
>
> This patch introduces a new LSM hook unix_path_connect.
>
> The idea for this patch and the hook came from G=C3=BCnther Noack, who
> is cc'd. Much credit to him for the idea and discussion.
>
> This patch is based on the lsm next branch.
>
> Motivation
> ---
>
> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> identifying object from a policy perspective is the path passed to
> connect(2). However, this operation currently restricts LSMs that rely
> on VFS-based mediation, because the pathname resolved during connect()
> is not preserved in a form visible to existing hooks before connection
> establishment. As a result, LSMs such as Landlock cannot currently
> restrict connections to named UNIX domain sockets by their VFS path.
>
> This gap has been discussed previously (e.g. in the context of Landlock's
> path-based access controls). [1] [2]
>
> I've cc'd the netdev folks as well on this, as the placement of this hook=
 is
> important and in a core unix socket function.
>
> Design Choices
> ---
>
> The hook is called in net/unix/af_unix.c in the function unix_find_bsd().
>
> The hook takes a single parameter, a const struct path* to the named unix
> socket to which the connection is being established.
>
> The hook takes place after normal permissions checks, and after the
> inode is determined to be a socket. It however, takes place before
> the socket is actually connected to.
>
> If the hook returns non-zero it will do a put on the path, and return.
>
> References
> ---
>
> [1]: https://github.com/landlock-lsm/linux/issues/36#issue-2354007438
> [2]: https://lore.kernel.org/linux-security-module/cover.1767115163.git.m=
@maowtm.org/
>
> Kind Regards,
> Justin Suess
>
> Justin Suess (1):
>   lsm: Add hook unix_path_connect
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/unix/af_unix.c            |  8 ++++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)

A couple of things related to the documentation aspects of this patch.
First, since this is just a single patch, and will need to be part of
a larger patchset to gain acceptance[1], please skip the cover letter
and ensure that the patch's description contains all the important
information.  Similarly, while it is fine to include references to
other sources of discussion in the patch's description, the links
should not replace a proper explanation of the patch.  Whenever you
are writing a patch description, imagine yourself ten years in the
future, on a plane with no/terrible network access, trying to debug an
issue and all you have for historical information is the git log.  I
promise you, it's not as outlandish as it might seem ;)

[1] See my other reply regarding new LSM hook guidance; this patch
will need to be part of a larger patchset that actually makes use of
this hook.

--=20
paul-moore.com

