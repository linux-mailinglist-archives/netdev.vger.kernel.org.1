Return-Path: <netdev+bounces-68174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FDB846045
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D482DB2798C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D482C64;
	Thu,  1 Feb 2024 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yq0/h8Rf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3C5A4E0
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813137; cv=none; b=BRzG4wdMMs7UlCDK/yqRHDL4+bpUagt2ioxCJWOUADRpwxMPyqqD/Zn/xwZcXq/no5zRkNWYtG4lhsElowzTJ/lZMuRaTGtMiXPsiS0Vs7UmjzSxQWLFK58VAH+vihHV+h/PvUj/OgcWa1SvVoyTDD82EjFUwKcaKSU27NxsKdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813137; c=relaxed/simple;
	bh=WLN/I8zDIYv90emnu+BrvNcZrC5OZrKJETTsJYXnWTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjQcLLHqqQkwPkqdw1+3hM1HxZaDONtck4tNS9wZN+dwA7sjLonf+PeurYYIe6ftoDWFZzMtVQurzHvisbp3VDVfurtV/HbQLOpmK2qMR9lyv5ffp0YfKLGt65o0yJqh5es79tAUrFPdDPRPpf0NlXD7W3TnDaxuZABHSHA6qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yq0/h8Rf; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso670628241.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706813135; x=1707417935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX+XzKo3hA/FKch3SlJ9SoxyEE2YWPNWjBbiP8ff5mw=;
        b=Yq0/h8Rf6nn6jo/4ybGWe1xHTJ1V5gpN9w9PX/Lz9TsjE2/EleA74R2zrXGdq/494V
         psqKdEcVY7P1O78zXptHzfIPfdpKmU0eC9bsohiOmGcwr5Gy2riFENzZx/3iHEO4qMbk
         EsFq4Fn7KrjNtCZXRQehuu9fK8WLB1Jd+reV2GuYfybOT23JzgK2uHUZ8/YxdH42IAks
         PHJ8T+Pl1fH7LSY8dVb91uApi/IyfzNAVSXkwSvEVS/rtpUvyJgaU72VANN51jjcBxaX
         HSCPbfdHxgT+9gWYkMoA+08IYETFwaNjgmKp0u6YVX6TNJ1B2nUBqVhfNmtN0CjPLvko
         Sujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706813135; x=1707417935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KX+XzKo3hA/FKch3SlJ9SoxyEE2YWPNWjBbiP8ff5mw=;
        b=A9WAJO1zdMlh2B0k/qDUtWNZGy0En8C7WXSMKSN5U0JTe9aUJDQZBaSrmxwbbcfq/t
         +g+k4yvbgYRaYdQesuzMtCRqFKEkggRvdaTvIZkZklJHrCBB8OJzvxhm2JmCni1cE2Qk
         8SAHAzSyPXyPnKmaKYhLVBn8nc1fj8TOfKEq6J3ybgGOnfZraNShWThsP51aQ/Pgvl2f
         fK4Kjsy7LTqUq/7Hlt4tGSibuuF8SEWN4iU3V3m+PSNnRCxpTdJtIEXNdCZH1Vbkt/uN
         7tV2Uj7G+mQkmDi9Ld2A7rvSh8eIJQSwRsbjfoHOha+Tfd4O+EbMexZv/yMAiEyc7tjQ
         0aUA==
X-Gm-Message-State: AOJu0YzC/91qnpmNy+E+wzQEqSoxSTtuCc9dBv6BBYjdBDN8aZiHxan/
	CqdEW9ihdJfWI4MhaIwqFpdnles3WWOeuGOlCt3URs5ro7CotnLkzTIYcjwWNDnH4ECiDjp6dcd
	aBwqFkT9bYUm0+qusdtD7VbZptgSLYnKNdywj
X-Google-Smtp-Source: AGHT+IH1Wl5ytQxmsJFPNY4DrHKVCmHhPAyclcfbt6/cJFgaOTuEXKaeL7MSzTipVlTACWjESrw5MiwBVrVpy5tQ1Wk=
X-Received: by 2002:a67:ad12:0:b0:46b:3a27:9895 with SMTP id
 t18-20020a67ad12000000b0046b3a279895mr6007237vsl.14.1706813135051; Thu, 01
 Feb 2024 10:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129202741.3424902-1-aahila@google.com> <ZbvFEtQskK3xzi6y@nanopsycho>
In-Reply-To: <ZbvFEtQskK3xzi6y@nanopsycho>
From: Aahil Awatramani <aahila@google.com>
Date: Thu, 1 Feb 2024 10:45:23 -0800
Message-ID: <CAGfWUPzeWeF-XPGem=VqxG=DaOEMRWnjCcueD+ODsEKLczDEMA@mail.gmail.com>
Subject: Re: [PATCH net-next v6] bonding: Add independent control state machine
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Any chance we can have some coverage via self-tests?

I plan to work on these self-tests decoupled from the current patch.

> Hmm, I wonder how it makes sense to add new features here. This should
> rot.

Could you clarify what you are suggesting here?


On Thu, Feb 1, 2024 at 8:28=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Mon, Jan 29, 2024 at 09:27:41PM CET, aahila@google.com wrote:
>
> [...]
>
>
> >diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bon=
d_procfs.c
> >index 43be458422b3..95d88df94756 100644
> >--- a/drivers/net/bonding/bond_procfs.c
> >+++ b/drivers/net/bonding/bond_procfs.c
> >@@ -154,6 +154,8 @@ static void bond_info_show_master(struct seq_file *s=
eq)
> >                          (bond->params.lacp_active) ? "on" : "off");
> >               seq_printf(seq, "LACP rate: %s\n",
> >                          (bond->params.lacp_fast) ? "fast" : "slow");
> >+              seq_printf(seq, "LACP coupled_control: %s\n",
> >+                         (bond->params.coupled_control) ? "on" : "off")=
;
>
> Hmm, I wonder how it makes sense to add new features here. This should
> rot.
>
>
> >               seq_printf(seq, "Min links: %d\n", bond->params.min_links=
);
> >               optval =3D bond_opt_get_val(BOND_OPT_AD_SELECT,
> >                                         bond->params.ad_select);
>
> [...]

