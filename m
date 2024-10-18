Return-Path: <netdev+bounces-136953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6EC9A3BAA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003021F20F1A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3C20103E;
	Fri, 18 Oct 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwLpEOAD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B9B17E00F
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247757; cv=none; b=RkR1E+6ty23iTZcdE7tr90F3Kd15bmPrzTFUxk5KlOy9ZVblB/6nrmDpV7zVizW7SgeCPipJ4BuSmyAEMmdzBNav9FIibQ0c384MVCW7g69auVxyKzQ/rBdUt2ontLESeE/f9DdWhgue7P/tdQOxLNuD6W1H/bkCgSMzDrmKrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247757; c=relaxed/simple;
	bh=MYW6dbPyv1LA2KO8BAnlhzC9LvUw5Q9ucfBBjD7XiEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HkiEj1V56QmBWSZeSxgPsknoa3S1GHLZQr1qplt6wwtncrIFRM5FzhYdlVSktfSNpRSy06cZ2mojgEg8GvdFyIFKVjTT/QHrs2B57A0N2fAMBZabHoDHcuQHbACFWE5cBg6j50JzAFY0nyNRWcfdBeOGtB0Egb9zVSmIeHfwbH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwLpEOAD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729247755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrTOHGvby1w1ZPMwlyiQRBjU/VK2YYsb8ixcq/NW7Fo=;
	b=YwLpEOADa1wTKcJ0kupaZOLeZjr6MaBKm70SeJMrbnYeP8darKY/rXlUWynWYm8D2/Ze/F
	YCEKdFq/+SMPkz2g1f8sMK1asFFftcVO9ODcMnApcpf3l2yn+DQtf9pZ6u0yJI/YDQmr+u
	ZhCnbwsaaOMrCW4IobU2mmnsGpi+U/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-y3tX5gL_Pg6JcS-UWt2U_Q-1; Fri, 18 Oct 2024 06:35:54 -0400
X-MC-Unique: y3tX5gL_Pg6JcS-UWt2U_Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43154a0886bso12637955e9.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 03:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247753; x=1729852553;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrTOHGvby1w1ZPMwlyiQRBjU/VK2YYsb8ixcq/NW7Fo=;
        b=PFJxdayzRtiXclqZmXKUnaq3CHYOR69kYR0AqkE4m+wKFj/KkZEtybgGGhJWPgJ4Xr
         KeyFUDqVO6mg2Tc7wsQJFP0JFkfq9jjgP494uhgRSyPdlvtauvZHXczQgRNA+/mGnBaE
         5PWQ5A+0c5NKrqymV6wxCgje7N4SUNbqoyLo/3DllucByJOAhriNCnB7bgc5/4LS8I+9
         QCX7KbIPng1PUuDkIfKdvUbwMz3Na5HpjgJ+gF71TeW/q0dAYGsKXgwv9FPvSwzui7Cn
         xLwqRHwvjdvNZ6wTzg7JxLd5+/e4cGb39ZRFepYvtLkrF1ULO5dGJ6ITum3572nwCcAv
         YQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT4g6bue/QZafsAdkEfXLNA3IgzTz5+VJsek2PI4w1T2D5N4yRvn5nhoBSgDbqFs/QrQt4Yns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINIlPq5WwoulFrrusDGy3AUfB6rh5pTFTCqAjjR9lrzRZlldv
	XQGF0F7NLuUdl5J7XPz/B5FL0xF6PZLYUBOXE1qaQ/38UoTyZSwn5e26Em7voQ7ieWMvsY2kO99
	Y4rmzRlIj4YTYiutFl1iiSeUsnV3EWqu+7tYBVCl5KsareYrQHStuWA==
X-Received: by 2002:a05:6000:c81:b0:37d:52fc:edf1 with SMTP id ffacd0b85a97d-37eab6ec059mr1250835f8f.58.1729247752870;
        Fri, 18 Oct 2024 03:35:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFugxrw1zdOmWyzIUEN18vLVXOK89+UGpHiLlPe5ww0HM+JYH2Pkhn6/X2q66XMH9V2lOuQLQ==
X-Received: by 2002:a05:6000:c81:b0:37d:52fc:edf1 with SMTP id ffacd0b85a97d-37eab6ec059mr1250799f8f.58.1729247752374;
        Fri, 18 Oct 2024 03:35:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06922dsm1569144f8f.40.2024.10.18.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:35:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 97D28160ACB6; Fri, 18 Oct 2024 12:35:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Simon Horman <horms@kernel.org>, Pablo Neira Ayuso
 <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH nf-next] netfilter: bpf: Pass string literal as format
 argument of request_module()
In-Reply-To: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
References: <20241018-nf-mod-fmt-v1-1-b5a275d6861c@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 18 Oct 2024 12:35:50 +0200
Message-ID: <87ttd9y9yx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Horman <horms@kernel.org> writes:

> Both gcc-14 and clang-18 report that passing a non-string literal as the
> format argument of request_module() is potentially insecure.
>
> E.g. clang-18 says:
>
> .../nf_bpf_link.c:46:24: warning: format string is not a string literal (=
potentially insecure) [-Wformat-security]
>    46 |                 err =3D request_module(mod);
>       |                                      ^~~
> .../kmod.h:25:55: note: expanded from macro 'request_module'
>    25 | #define request_module(mod...) __request_module(true, mod)
>       |                                                       ^~~
> .../nf_bpf_link.c:46:24: note: treat the string as an argument to avoid t=
his
>    46 |                 err =3D request_module(mod);
>       |                                      ^
>       |                                      "%s",
> .../kmod.h:25:55: note: expanded from macro 'request_module'
>    25 | #define request_module(mod...) __request_module(true, mod)
>       |                                                       ^
>
> It is always the case where the contents of mod is safe to pass as the
> format argument. That is, in my understanding, it never contains any
> format escape sequences.
>
> But, it seems better to be safe than sorry. And, as a bonus, compiler
> output becomes less verbose by addressing this issue as suggested by
> clang-18.
>
> No functional change intended.
> Compile tested only.
>
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


