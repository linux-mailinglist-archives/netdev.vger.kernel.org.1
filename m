Return-Path: <netdev+bounces-250909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB7DD3989D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C1D030062E2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1F2FD66D;
	Sun, 18 Jan 2026 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx+Hh6yS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22C2FC891
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758325; cv=none; b=U/WogbKkivlQWKP8qCYi0qMb0Atf+7zuysf0Z8jU3qANFom2chRtmYDRjDjHfzrlFnAV0pFaS+yIIiurW5srp8Ps9rOzPwuTiNqm88JLazNWLYDmdytIb5mBjgphGsXUgOj8p6Sess/3Tf3CiNoZHTOOY7N3K6TWfxIneiSdXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758325; c=relaxed/simple;
	bh=s0irCw+gMjmzH65mBrP4Mzm7/teDdFv8COtAVdp7uJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYJcMvxjqeA0k1pMGuDW8eJ32wXi9eUbiKy/FfeHE4/Af3g9DKb7euCO9KcSnmFBdXBAd4RWLoov+zoBKTGPHY9flcm7nI5hq5kJl0ITBFWiUWBpuTOhINCoUkZTkt+Tra0S+I4YtHZrHY1Py1+xyjtf5YeoQkbd+P0loY1TvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx+Hh6yS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8768225837so491504466b.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768758307; x=1769363107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+lLGRI572lOA24qrLkpQ+3948vS4VnXxEWoByvnQJrs=;
        b=jx+Hh6yS+aE7WsNuHxm8uVup268woTU9vdoJdTYL7xiMh9b10/sO1kNI7GLEKNSucN
         fjZxHXusAjp2MsH1AgXdTi5qSLYn77H6oncJd2jV5+iv3VojzU9wFqmoY5lsPEd1PJ4b
         2IDbN+yZIzCGcARTre5xWNimszoIq9dUHHNzEynDpDHxWeloSYfBAa4ry8VHJ6iYsCya
         RWNejxKJp8FUXi48p9uVN44NXCwp4efNbLts9lvW9a8cFgvfUQxqMqsISaiNFQ3TVyPs
         wHXy0tAaNGMxWb2PUfc8De0G+tyWdBqn4BSwiDZmdBckoL1SsLmsLd5/lqUpPi10Uyer
         NRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758307; x=1769363107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lLGRI572lOA24qrLkpQ+3948vS4VnXxEWoByvnQJrs=;
        b=o0i8rujJ6AUsEQCWN105rHNPfrvA2sjaYJPHZTzpiqvGlqpvXjBZ77VDH45SxxbB51
         UnK3FcCQqk45KAq1TtfkEZafC4d4WtJRkc48SWd1Q39lqhJBEHZIpjD5rETxfQmWT7Ei
         dHYo8X4BIuvFfbuTxAQUnVXvfAhl3uY7ccToV40HIDHdUpcDVWEYujgLEqJiZvry+waW
         8y06t/9RJDYoHnJn3IuDSFrgLUKTD1LS9+9gA0W1bk7UhgefukWQTRtyctezhAG/J/zm
         mstx6hnlbz+phWpBbosLvSdnP/IBQQlphn94gWmdrmqnPhm3pBW3J7z5Yoa+OgngpdFI
         ctMA==
X-Forwarded-Encrypted: i=1; AJvYcCVTWHEKCQppgS6yBg2FU/NtVp3tHQJCRrfiTYsXALaQBpSNi6zdPjxFcwiHovoNavx0jKK0whc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Kf9e6gQWe+0NvKQ4NjaWVDp0DGO4yjgkSVQhnz+pUJ1zpURc
	twUHNXU0gq48riiQzUUwW5tm528HyZpjXNolLuLu3tnVeHMqWf1eM9DI
X-Gm-Gg: AY/fxX6ETSaMMqL8qp+Kzb2EmUHQdFRx17ZWIoxg7NgXG/SvJi3PK7YhvCG4E2A21lq
	LATXmNy9KCwOUeXdfw80EZJ5ck37LMQn1EB6qvLQQvTOx975j0utR3AUxRjCVr9lBHyX0yXLe+x
	0qa1bgkTxvwmzII6PwmLG/zax+GPPE/G1A2zk8jHItH3LS5lfMlympgGDQK3mzlotU+HBSYWQpY
	Z41cXMg9DuSue6jthQA462DLWpNEXNDXSK53qfj4jtJTxR3iSoV4EbJyxNwsqs0sQqaLRW0nn3b
	XbNCMCKWjqKev91JXzrSY2THAc2kvnokopDu618yh0DeN5MfUIuZ2/JI2ln61ayToxjKa3hT5ps
	QRc8FKIf/bjUqGkBN1q7C6kQmyKLF759f7MMbWsvitqmIbye1XB46yDIudV9rFjjVVMSqseYMkV
	0pB525Pe0+OpWgROPXGEhFAJoeXoR9KOLPwY1T
X-Received: by 2002:a17:907:c0a:b0:b7a:1be1:983 with SMTP id a640c23a62f3a-b879324ea84mr842454266b.63.1768758306343;
        Sun, 18 Jan 2026 09:45:06 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c96f4sm874098366b.40.2026.01.18.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:45:05 -0800 (PST)
Date: Sun, 18 Jan 2026 18:44:58 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260118.a37c57a422d7@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260112.Wufar9coosoo@digikod.net>
 <20260112.a7f8e16a6573@gnoack.org>
 <62eda124-de91-4445-b163-9dfb8039d08c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62eda124-de91-4445-b163-9dfb8039d08c@gmail.com>

Hello!

On Sat, Jan 17, 2026 at 01:57:20PM -0500, Justin Suess wrote:
> On 1/12/26 15:53, Günther Noack wrote:
> > On Mon, Jan 12, 2026 at 05:08:02PM +0100, Mickaël Salaün wrote:
> >> On Sat, Jan 10, 2026 at 03:32:55PM +0100, Günther Noack wrote:
> >>> ## Alternatives and Related Work
> >>>
> >>> ### Alternative: Use existing LSM hooks
> >>>
> >>> The existing hooks security_unix_stream_connect(),
> >>> security_unix_may_send() and security_socket_connect() do not give
> >>> access to the resolved file system path.
> >>>
> >>> Resolving the file system path again within Landlock would in my
> >>> understanding produce a TOCTOU race, so making the decision based on
> >>> the struct sockaddr_un contents is not an option.
> >>>
> >>> It is tempting to use the struct path that the listening socket is
> >>> bound to, which can be acquired through the existing hooks.
> >>> Unfortunately, the listening socket may have been bound from within a
> >>> different namespace, and it is therefore a path that can not actually
> >>> be referenced by the sandboxed program at the time of constructing the
> >>> Landlock policy.  (More details are on the Github issue at [6] and on
> >>> the LKML at [9]).
> >> Please move (or duplicate) this rationale in the patch dedicated to the
> >> new hook.  It helps patch review (and to understand commits when already
> >> merged).
> > Justin, would you like to look into this?
> > Please feel free to copy the wording.
> No problem.
> 
> It's quite long, so would it make sense in the notes?
> Instead of directly in the commit message?

I think including it in the commit message is what Mickaël meant here.
The quoted email above is already from the cover letter (which I
assume you meant by "notes"?).  IMHO, the considerations that are
specific to the LSM hook are OK to put on the commit that introduces
it, even if they are a bit longer.  That way, a summary of the
tradeoffs also makes its way into the overall commit history (unlike
the cover letter).

FWIW, commit messages with long descriptions are not unheard of,
e.g. commit ee6a44da3c87 ("tty: Require CAP_SYS_ADMIN for all usages
of TIOCL_SELMOUSEREPORT"), which I submitted a while back.

For reference, the official guidance on commit messages is
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes


> >>> Seeking feedback on:
> >>>
> >>> - Feedback on the LSM hook name would be appreciated. We realize that
> >>>   not all invocations of the LSM hook are related to connect(2) as the
> >>>   name suggests, but some also happen during sendmsg(2).
> >> Renaming security_unix_path_connect() to security_unix_find() would look
> >> appropriate to me wrt the caller.
> > Justin, this is also on your commit.  (I find security_unix_find() and
> > security_unix_resolve() equally acceptable options.)
> security_unix_find works for me, and seems to better match the hook
> location. I'll send an updated commit.

Thanks! Please feel free to ping me, I'd be ready to send an updated v3.

–Günther

