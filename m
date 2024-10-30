Return-Path: <netdev+bounces-140447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393B09B67FF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA01C21201
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21E2139BF;
	Wed, 30 Oct 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJHcwzjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441911F426F
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302684; cv=none; b=jrwBl68lZTYW1ZDFuT3OfTEpjjodmHTKP8BeGm7Y0Mn5kKkO0J5S+PEtdk7ScvwBkSUMwTBu8t0ChXx9UB4qgGJVjobyVkRjrHB135x9N9yYvgc8z3uhcSDz20Dpk906LGTSBB8Bhw/PTEf1G5B1xWzzk8Ad+bEZVv7HSOBxLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302684; c=relaxed/simple;
	bh=lWLNB6NauvSC3irEBTZhZs6g8sLTn5D2zaDYEGJJkAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMnynAToY5wCIOP3If+m3sgb/GsOWsIsxd23MWCn9bu4K6FaHBi78DM7qX8Lfk0xqiFwb2GEwAdasLD7kjrJo9pVoFZ7QcO5zRcqhV+dw8dVnNVKsMMKAbkja/J7yJfzCHf44LLke5kVdcu0a+MZmB/4jba84i5B1JbjXqKdi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJHcwzjf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb561f273eso61964141fa.2
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730302679; x=1730907479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrMCWRpczwyRTmnrS6nIF4HKYVkA9torv7EN4XtnnJI=;
        b=CJHcwzjf1DlXkV6asHilDSL94o/kA4VH8E+t9Z3/aJmTDMv3QkosxlxGhUY3oiy7P8
         1BchP1MaPyxL8/NOpuRBxxIZwp9L/LYEOIrI/F6yi5FrQdSGN/nzgBVorOxUuME+9T0h
         fY/J/OzxTysMR5bRb6qXqf+qqaMsyFtRVp7qCvmnTxOuJbc+ZUB16QAIBXKbQiopXRGw
         Zq6bjabRArF7CszFm2/uhy/Kkrgm6MWCFhwRJUXSlKE2GShG20sCstoubv7tpOOmvZ9g
         Y2glRGQcAoCCdEoAbWJB00jZbXc425k1sWEkxOfWlbVwBWAbzhz9V6bP4RU2GMIf6yyT
         r7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302679; x=1730907479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrMCWRpczwyRTmnrS6nIF4HKYVkA9torv7EN4XtnnJI=;
        b=EQAksb9WFoww7GDYNGkARqgiIKUo0CBh/RMmssB/Bgb0NxwO55HEnW+J5p+4NekJUy
         DQnk7C31BksTfeStbLAA6lDqDdsfTS9XIUFlRwPvg+fE9TCXjdAdSiRLVqvLcN3pKT6i
         f7Qw/irKLfNYzkgUVaNpGiRk3wORuBW4w+d0i0NxaSZLLl4M5oyzUasxDFMmntgWnOsu
         RZZC2zVA0MWOzfSqKn6gjAwZgQPo84JJP0zir1EqVjZVwKLhqmuw0333o1W3+6dWtVYN
         nlkAVyrOYZNPfIOyCY7/q9lYbFskMWzJqEXO3dhB53RD7jq+J3uThYqQdySI/g+fxUBn
         dpqA==
X-Forwarded-Encrypted: i=1; AJvYcCXu7mcq1ev5r+EH67lPSCPewzHZYWLVdWrrFoQTtlm22h8oBJglNnaMGbPBQ0JReszvoQgTbfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwucK+/sPFeMXKCWU689PTgOpe+8hqHZLU9fpb1ThLUEj1wOAVA
	/IkHZi3Xu7s90V6J4fVmjli+smNQEbZufPR8jCRmCXTWjtXNvJcujejGuttKo3WCd/N9q3vIEUz
	/PenfP14d5u4qe1BQuPofo02juN6QKomcuXl2
X-Google-Smtp-Source: AGHT+IG7DRpQ0VVMTcG6EnMiWykyPu51ceO5M4tUaSNQltNn+7su5SexoUVL9I4k/XDx6ioEftGeQAPKiITlI5Hsoro=
X-Received: by 2002:a2e:4611:0:b0:2fb:382e:410b with SMTP id
 38308e7fff4ca-2fd059d31f3mr18514061fa.32.1730302679117; Wed, 30 Oct 2024
 08:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030140224.972565-1-leitao@debian.org> <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
 <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
In-Reply-To: <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Oct 2024 16:37:44 +0100
Message-ID: <CANn89i+1ddxa3aQH=1ev2fX5+T=PBT2C0i0YwqQzWaJuMfVi=A@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com, aehkn@xenhub.one, 
	stable@vger.kernel.org, 
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:

> Thanks.  I got the impression that the scheduler list was append-only,
> and the entries were never freed.

mptcp_unregister_scheduler() is there, and could be used at some point.

