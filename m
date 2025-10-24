Return-Path: <netdev+bounces-232586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A42AC06CDA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7847D5678DC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7CE31CA4E;
	Fri, 24 Oct 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSAy7VI6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803923A9A8
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317529; cv=none; b=HU1PONGFZbbIRlvck+udoA4e2IVscGibGhVV44F24ISBXs/pAYtkyk6OhefRemtImf9fZeqTnku0qTKPDHTrLzGDcIo8b0a5+UQ9gYm1YC8EiTFpPiIRJkoCWLnctSkFsfOyePZewDmzdbRJPKZ9RPS+0ePUze+RsobrhrCs2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317529; c=relaxed/simple;
	bh=OcekF0uNEQgSI4aBvsnmMv6ZMJE2SZqDXxC9GMDna+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOlQMl2wngb/+hgVntUvOuT0DE9Kj6m08zjrhokEIREfLyA6kdTOpry+n4OxhZmBNieEtKsSduU/7VhVljZimupz7FRae6us6vHsCbQD3oQq9LSsKHAfnn9YXpcrF0qV6ZeV7wXUjcZjn7ynroiv76j5GmDMgFm9RNcbE/Te3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSAy7VI6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290d14e5c9aso28188995ad.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317527; x=1761922327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcekF0uNEQgSI4aBvsnmMv6ZMJE2SZqDXxC9GMDna+I=;
        b=mSAy7VI6Fr40Azq5gvMR92yXNX+PwMygazuQG2CEp811dJCh+dTrPrkKUnC7ZlH8rq
         h7vWE8XgCdqYFc6Hy3NXKVhscRl9GZ4gGSydJyIyUDCUwFKz3U+sYyEm0G5kpWzgzdaD
         UrsohFYUafFkwqe6qABoRtOdgn9VIIGnnfyV2tVYcitFqdT+IG7facmejP0oRs5pWmXC
         BnUDwYEvvWvU2QzODcgSgDb5A+fyMUDk8gDB96i9xhNGkNEbzZwMIlSv9RbukKEDYXJ6
         lmqWIAO6IlDLN00cJ1MoQX/KrjiS5naWrlpzgSC77BV6ISvIsf/ajpFCvLNasqvU8hcU
         Bkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317527; x=1761922327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcekF0uNEQgSI4aBvsnmMv6ZMJE2SZqDXxC9GMDna+I=;
        b=Fgt3PJRCb5+adw7g7R43tTPD/F6/BYbfwd8uTmw0ZJ2NB2mKjpW+ywaExwQs/fABCj
         aEFSGmkgjNiqTiK1kYKDXUb8bLEYi9iGBF3w4RNLJUFJdvjbnQG6vkiwsa5ygwXMtA0X
         YblxE4306S33An1JGAKKHGu1Qb+HmTFKt+g13XJ2M1/benPsQ2Tm/yWBlwe2zF/u5mSr
         fFPRM2zY7PsywBcx5cCJpMSI9dl2O2XjsWmrBndXfRgBL+86OJrzFso9+LOJsSTKvzqK
         l0l1CSJUCSkput2M0Xa86WzxXTyrtNmT0qJ3i5kpPRxlE8gQ7wF6lfS4Tf50tZtHMevX
         o/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYwvOtDTPbyIQpRS0C/NHi7DndIFFDYTu3zm/1mz19g+JyE4szbPIDMtgmV2c0J74USnNQD3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGsL5x0siUzKzAnw8DQxlOxSX+adRAod7zcXr+8k4vvX7aBKEn
	pNKoSStvoEhiiPHka3H+U++35+S8VQwwf3vML5a0ks2rEWG9ZeTt+oplOBYtiISXvzpyoGEPL6P
	y7lkaiiCGbSttQ3gwsVPM1cd3vefg0bk=
X-Gm-Gg: ASbGncugFTkwRYfdLbsXb8DbxjjHgB9UIyKKp52rSqvS8djf8xuRHCOrIQUU68TJMC+
	xoF0zWJNn1Q2Ato49fVYzYenm0mOPW2oFP0Bsjt5+qJqceeWJPbQMBWAzuuUckSZx5+D2rR8Wcw
	DEHa/GM8IPqv6mQQ+bpDsxlT1RkpeptBXc3tcruAana3zz+oFronzcPI+SxR+g+gscDfgMuXaeF
	4Lq9NHVxMRY17rtr3MlALptyAVld6xIt/wrDiowAXJGiiB1izzitetydAmc7F2BX0Uf6AsaLw==
X-Google-Smtp-Source: AGHT+IFv5vkfuTE//Te5nmz1wt82UnKhpQMtl17iJPAGJ5j+ovA3i8x3RUgXcOqZOScksox0/R/ieVuy0Koq/DAPnL0=
X-Received: by 2002:a17:902:dac9:b0:28e:9427:68f7 with SMTP id
 d9443c01a7336-290c9c8a5c1mr373268475ad.6.1761317526939; Fri, 24 Oct 2025
 07:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-6-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-6-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 10:51:55 -0400
X-Gm-Features: AWmQ_blBoikGr7lZkMaIWvhnVCBxMBypRtxx5vMnfD3wT1Eoh6eGKx2FhNTNx60
Message-ID: <CADvbK_fnzXPNiLTQ9fV0P8ZYaw1au8iwMoijsmgHmcGbyS=0dg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/8] sctp: Use sk_clone() in sctp_accept().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_accept() calls sctp_v[46]_create_accept_sk() to allocate a new
> socket and calls sctp_sock_migrate() to copy fields from the parent
> socket to the new socket.
>
> sctp_v4_create_accept_sk() allocates sk by sk_alloc(), initialises
> it by sock_init_data(), and copy a bunch of fields from the parent
> socekt by sctp_copy_sock().
>
> sctp_sock_migrate() calls sctp_copy_descendant() to copy most fields
> in sctp_sock from the parent socket by memcpy().
>
> These can be simply replaced by sk_clone().
>
> Let's consolidate sctp_v[46]_create_accept_sk() to sctp_clone_sock()
> with sk_clone().
>
> We will reuse sctp_clone_sock() for sctp_do_peeloff() and then remove
> sctp_copy_descendant().
>
> Note that sock_reset_flag(newsk, SOCK_ZAPPED) is not copied to
> sctp_clone_sock() as sctp does not use SOCK_ZAPPED at all.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Nice patch for the dup sk copy code cleanup. Thanks.

Acked-by: Xin Long <lucien.xin@gmail.com>

