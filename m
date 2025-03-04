Return-Path: <netdev+bounces-171650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7DDA4E05F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A973AB846
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47319204C11;
	Tue,  4 Mar 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOHXvAn/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D02054F7;
	Tue,  4 Mar 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097219; cv=none; b=Tb+JHhua23oS6PWngYEfhtgki/GfLov62vKTCaj7fxVYi9RSQHNyEGeLDqHf+IsKxEVyWU9bCABrlU+w73FJvKfewaYvTMcxnuWTN64bLscCeJckk8NAqyTJaM/ANZpPJic/tV0llHxlQfRrenIn7hzPOLjd6vtkcyQ+Fz5lMNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097219; c=relaxed/simple;
	bh=JrdF0vtV0pwL5L590faoWin/GHpdb7YheXDBmCQex+0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TEMebxWFdPEFT506AK9f0xCrE46WdORHpnWDSj7C6mJLE/yuZ+A8q6UhV5QWQ3pbXxEtU6rN4t1RLZr7beklladon7VQ8FYzq4SBQeTB+4w+0dmlKqsj4kjQVYiL1RH18CQbH8GI2DtyWq2BV/azb6CDE65bWOBzoxxwxAY4k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOHXvAn/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c2303a56d6so603774485a.3;
        Tue, 04 Mar 2025 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741097216; x=1741702016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1Muupcpy+OM9bjik9PXq7Ryx61fO0zb5gU8UKxppt8=;
        b=BOHXvAn/wgFYzHF/EoT8ifAF9R/Ce8Qgd/cIRx566dT1BBmrCjQeoCRPOS/J67Coh3
         IAoDmwUw2JJoe55mzplzGcIKZrFSCrK+/uPwoS+0JBToJdGLak7UdvwC1jWtRjd1T2Xd
         s64sHL67ztLTqjiAQCY5Eg5F9x76ddJMO6yFb/IOqC6SMKagaBixdt2za6KfptJgN0HE
         aYZu/RwB+TF1dQ+IVAheoPRJ6KBn9oDloeYuRLmG8Q6YxPreptcsN8ffNCjZrIrmVYD9
         tdYgrpFAQWKEz3QPIHODjiBJkgWkK7PwwU7gcM/cD5Z5wxI2j7VPt5jK9ZsXWeGfHGFk
         aniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097216; x=1741702016;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I1Muupcpy+OM9bjik9PXq7Ryx61fO0zb5gU8UKxppt8=;
        b=geO1JbCHLz65KWHpHGpqJKlArzDJZ5WYoqKpgOB42RWrnf54vcT3pxnDJvTouKEXHM
         nhLI/fttR+xLRgbr07y5ehmtq6P3RqrtrzBv6nBZo15NlLWzYZ3kkiF7FPqgx6F/AZri
         bUAmcYsXujuSxY4ytUOf/WWfNMVyOKQY8o2Td1iOlxh75chIeT+fBjX8MrZ2SxkgUZR1
         mLpUVtEqZEneGXYkJBT89J2QdPuXaNTdJ7jJVGZhT250mE1qMlQqRdaxSVzlmKUy6xZ2
         lVSBopZBF2hCbBKa1tsZSEh3xu7wRyPlrmw04KhVJZ8LW5FkLUMHiyRdi7sQE5Cdw3Kh
         KoMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsi7dhd3jyjprwl3oyRyrH3Xy3NTVCAyN8tT4onX5vy+AAyvN3kRFWewEQfaTjPRlyS5K4ZYlx@vger.kernel.org, AJvYcCWCQaAfRGTG9uffXl+ViRRNaYu7wr7dU44aJhQV4FlvAkVqqBqvjs22NaOca0M0yLVenJGKn5UO5Xu4RJ/U91v5HLY5yWq1@vger.kernel.org, AJvYcCXucF26VwCuatPgQMDhOZSgymjF3pgfOfIc9PBGkLwmMWC+syEvliXm7SnwUfLpPlzGkMa3CVAhmeiSoEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5jHMVKKaIjtIe8OEzuk6CTm3jhLi0KRGc9/TzaN9vLHS3Okr
	CZwtdJRfZGT8ov9QMhTRUik2Zvr9AI3JSae/xgaaviljAcs10wlQ
X-Gm-Gg: ASbGncsYUi0PIEQ+3mabcWAEjUYIIeJz1aqoGiaerwuhFROrzU9QIwkqyLgyWBmyRMt
	2t365XU224SyMB8lIvfYEdDyeGa0ubxTOH2BYeG45/JJbAH7jaq2wia8zF3365R9YyVe7uCu95W
	CVsrED3TLX8Y8yZVGWjvZpVanUYA0lkQGnKc2WF7kgFSfdjxjwi0jD6HtZJY5FNZK75LdNCxF0l
	EmdxJPJj76JK/mOSeqlguLbs7WX9eooIa1epW1UID8ddt9oq/rdvsXJnGJ7rvLDo4DxlTE3zksP
	id1gmIq1ecf+EUq2wA0VbJcqyYQrcTRisgY74QM2nrpkbsL8PYvxJ+OSzc607T9C/dNrbRFYVnG
	gKw1IjdhmiW2jev7HJCijqw==
X-Google-Smtp-Source: AGHT+IGApDbbAFIVP4UAhuK4gruOfc1K42rEtfDe0QgRcGiarlFw8FydgN2j9mXLeJC52LhY80Pv6w==
X-Received: by 2002:a05:620a:424e:b0:7c0:c1d0:d0b4 with SMTP id af79cd13be357-7c39c60ea81mr2948041985a.40.1741097216179;
        Tue, 04 Mar 2025 06:06:56 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cca94sm66581446d6.77.2025.03.04.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 06:06:55 -0800 (PST)
Date: Tue, 04 Mar 2025 09:06:55 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?B?Q2hyaXN0aWFuIEfDtnR0c2NoZQ==?= <cgzones@googlemail.com>, 
 Serge Hallyn <serge@hallyn.com>, 
 Jan Kara <jack@suse.com>, 
 Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, 
 linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 cocci@inria.fr, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Christian Hopps <chopps@labn.net>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <67c708ff63eac_257ad92942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250302160657.127253-9-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-9-cgoettsche@seltendoof.de>
Subject: Re: [PATCH v2 10/11] skbuff: reorder capability check last
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christian G=C3=B6ttsche wrote:
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> =

> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore=

>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited=

>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit=

>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> =

> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Similar to Paolo's response to patch 7: these networking patches
should probably go through net-next.

> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b1c81687e9d8..7ed538e15b56 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1566,7 +1566,7 @@ int mm_account_pinned_pages(struct mmpin *mmp, si=
ze_t size)
>  	unsigned long max_pg, num_pg, new_pg, old_pg, rlim;
>  	struct user_struct *user;
>  =

> -	if (capable(CAP_IPC_LOCK) || !size)
> +	if (!size || capable(CAP_IPC_LOCK))
>  		return 0;

Not sure that this case is relevant:

Unlike most other capable checks, this does not protect a privileged
operation and returns with error for unprivileged users.

It offers a shortcut to privileged users to avoid memory accounting,
but continues in the comon case that the user is not privileged.

So the common case here is to generate denial messages when LSMs are
enabled. size 0 is not likely, so swapping the order is unlikely to
significantly change the number of denial messages.

>  =

>  	rlim =3D rlimit(RLIMIT_MEMLOCK);
> -- =

> 2.47.2
> =




