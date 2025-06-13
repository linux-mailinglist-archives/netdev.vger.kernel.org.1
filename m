Return-Path: <netdev+bounces-197607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F92AD94CC
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990BD3B92E9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626D233134;
	Fri, 13 Jun 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Qpp45CBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD4230BEE
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840691; cv=none; b=VkbsRjpiLDTfNNzeunUSsxfwW5cifp0b7NAr+lV4JkBf4ppubgcoa96Wzzi0KWsTyJd3D1ky4Q/W6BFiXfELJEj2g7wHFoGEgTVSB1mXUH2uRZVJHXcJimiYQJdiMWULXAxAbt5L+dR5xqxY3G1DlO+jhprxXk3czCyDXKgG9T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840691; c=relaxed/simple;
	bh=Bb/QERQMoH5bUKF9d2tQTeWD2v4J2NTxSyxm7iDLWc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTJWX0Mk6tKgcItvjm8TmRWANhtiu5YDuxWEPhb/MzlFzAe0dSgypJNzPdSvkYPBXOEdEh9s4I974tk+fSAMFuVDAx0rYDQdD94TieqZ/udcDkwW4Dg8OWte34+hmFTZ7SPYFKVFkfc9jQJ7h4XZk/zwYJigrjPLkbnFUUzI710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Qpp45CBK; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3Z45daxs3aOhjFGzQlPP+5zzNS3JGzrOov70qQlSn9o=; t=1749840690; x=1750704690; 
	b=Qpp45CBKXo6w/zs5DyMA26pikSueyu4Cql3sywT93SDk30rCfiwO3iKRfyQlO1djy7OoFg+I3wH
	1dvr1Ld5WYg+5V4Yv4grgrXGdEsws18/Gh7kjobu2H2EtvGKVU2OwlDvKGwRoEkPr/cqRMY9daJnF
	wIjqycIt2QdqnUsvonLMDsqxwcsh87AfRr4TGJUsJYTH8GvOas3Ko65L/dFlO/oRy7d3bYWw098gq
	YPOJy3hpdwVy3ULr4TpFbfR4ABSAVEW7VQEWg+yrYkYskgf/t+CCnABFV70H7nJxIfHRBqfd2OmaJ
	xKaj1wFL9Me0J0bZMD2UdcCz8a1Vl3E2VaXA==;
Received: from mail-oa1-f54.google.com ([209.85.160.54]:56521)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uQ9Uv-0001gO-4n
	for netdev@vger.kernel.org; Fri, 13 Jun 2025 11:51:29 -0700
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2da73158006so1726498fac.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 11:51:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwYzkmrIKcpk9MS+I5XJKxxDOaWhtdbo54FGSoA4f6QXjHMO3eV
	r4/kpq1aDuZ0cGZ2z5P8ufPxOfZ0tpRC/WpoC362pSbIxNtGXHby3tzcxZRc9pBhdt1WPNQPfEb
	DmRj8xVMVrPj1cqyCkGrAvQs4YzBZ50k=
X-Google-Smtp-Source: AGHT+IGp+Yj1tvnRFOtPT1cOv3s9hcL39rjm9zDo7I2WEgyWQaGXeki2wKc7MbrRpDnmQPivxCm7JIi48kdX6R2+2JY=
X-Received: by 2002:a05:6870:6386:b0:2c1:461f:309a with SMTP id
 586e51a60fabf-2eaf057d324mr599406fac.8.1749840688542; Fri, 13 Jun 2025
 11:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609154051.1319-1-ouster@cs.stanford.edu> <20250609154051.1319-9-ouster@cs.stanford.edu>
 <20250613144340.GL414686@horms.kernel.org>
In-Reply-To: <20250613144340.GL414686@horms.kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 13 Jun 2025 11:50:39 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxawtNvsK0mN5mFuQURzwRF9VmmiGhGOjNJqe8fo_hQUQ@mail.gmail.com>
X-Gm-Features: AX0GCFtex3eqLn7TMPOy7ofKb9B0ZYaCw7j-ojaghgCZ5JpCV-6pgJh97WsZKB8
Message-ID: <CAGXJAmxawtNvsK0mN5mFuQURzwRF9VmmiGhGOjNJqe8fo_hQUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 08/15] net: homa: create homa_pacer.h and homa_pacer.c
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: f033b90f7cba6c0793427b12797f2d01

On Fri, Jun 13, 2025 at 7:43=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
> > +     int checks =3D 0;
>
> Checks is set but otherwise unused in this function.
> Probably it can be removed.

Fixed now (also not caught by gcc).

-John-

