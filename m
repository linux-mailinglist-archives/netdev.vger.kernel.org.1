Return-Path: <netdev+bounces-204034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56990AF8814
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1FA564F47
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95325E45A;
	Fri,  4 Jul 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fr2MRKXD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7E1DE2DE
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610984; cv=none; b=VMCc3rBPIcu91ATSMg9AzX7kPwwgVtLtJi7lP49rCZ1/KZJKYR754IQFX4Jf6iK82voeqZH62xvrnRmWc/DeFpraIrJOA0nqrHxrWG/iC9pGYHoIhkV1jPbwMLTDbM4RG1Z5wzUEwhOsGB/yepse1ew54hHBrlpsWIO2Iw5ejUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610984; c=relaxed/simple;
	bh=nXSpNA8M4Ck5F6xOcSmyTSFtp5OvQquw+LlL0If80vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZQbuPMUZhsdk6wkLlgq4FX1CtcSaiDEZTLo6fbzXOZsEH1t5+E//zSrjkzcgweeoPaYUzD/UgRoI1GlnVXoykjdKkHdsMUrQl8I/3X20EDDvWVCiV1rv0hfsm9hx3w2z62Qges7bJL0fvBexCyhMaF3sx1OPVr5sPp1t9tjNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fr2MRKXD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313154270bbso754273a91.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610982; x=1752215782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJhZIcrJpMNq0LUkRcjbdMcofmE/cfg4pDDuml2T7kw=;
        b=Fr2MRKXDn05olhMico18s0k38k00rZQcrm/hxFtAtpf+1ZBNX0jl8ewPTVwlMnXpZD
         W10FVAn6NjuzeEZTYjTtBim+n63FYDSmuKBxtctdRsJWZYrsXIsBklSDhbahq4RLFsTE
         Z6nfBaArBdQ4Wg5T7SYaihCgDr/pKrY1vYOk4zwpkb1p5ibcSFvORxlQv/g4x5WT9KTY
         vaTuaGm/BIsCMxyxxxJbjH1ZAZRapuvpyQZ740l20ton91HwquP0IgczuJ/aP5T4E4JZ
         8vlEyfgSBBA6fAVcMf5XXS9jw6WpNntVNrg0VAh8zFS49ce5ZN4extXS5bpCn5yU7mei
         5pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610982; x=1752215782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJhZIcrJpMNq0LUkRcjbdMcofmE/cfg4pDDuml2T7kw=;
        b=ag/my1HKlWfPP7rtd0LeQGZqNWxYFvOZqxOH8WN9UL772rqlkpucGiz3ahZS5+rMcm
         f5bKZWUB+A7XnXXbLYc8ObVVMiCi0rwSMjaag7BNlReNY3PS4Lae8FRAWz87362VDAsj
         qsodbHjWmBM0Kz9MshqSmpz9YJSRSnn2YvbxCctZYAcHJw3bdPgg0BLBcJmZQpQ9N184
         0kH5BJTQsTE9C1koSCyp/GxcuV6bdfeogzWRqpdSACWUff59iC7MiAMoEA0KaCGoMCnk
         04lDn3yMKYtCmvD7Ec4YOPy/hzGLHCdd9sr+S2yku2Ef0+U8zmzp1tlmEGk+o4Qd/Opv
         FseA==
X-Forwarded-Encrypted: i=1; AJvYcCU+icSEuNHlZ406uDzIWzEUcuP5WjuFj5KuUrxEru6DY+DVrnJHaoTF2GbSsJRTLxC99Qi1jbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YYpg/FEvo42HQ9b3TDFaieTrt2PvxyZS84xH9vVMqY8DVBVm
	bvlRP2kme2a9XpGFFx6rz7QsHkvf40gAUvHcX4yOHtUymgraooX/J9oBdscigRSu36eH4Bpfakh
	tE+REOZSGvcWTtBrgZq4kL76hAgk4WG8NYgaMk8uO
X-Gm-Gg: ASbGncvmz7QApZz6COttgJSz8kIbSVahBH6eF3/wnnlnX3ZPp+jBn9/J2yMeYz7Fa2w
	hSD2rx0xboAZSL0zyptVsHm5xvmaDaDZgwB84Lyi8NFuud16Fnzg4YVAPtpER+pkmDQqajmjxet
	bnTYF0t36qbt9CuW7k7MLvHOKhsgdcKP9hAm2yMRAoZfuBWsYQPrv8Bik7f1UyXw9n8EBS+x1Si
	Q==
X-Google-Smtp-Source: AGHT+IFZJazY0HHgsmXDU5VL6+IsYWgPntWi2l4OY+rLS1bM7IbcJrAefWDZk9LjfpG9/pk5+jRgPlYA4sQ2zX/VSVw=
X-Received: by 2002:a17:90b:3c91:b0:312:1d2d:18df with SMTP id
 98e67ed59e1d1-31aac4cc1dcmr2043413a91.23.1751610982275; Thu, 03 Jul 2025
 23:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com> <20250703222314.309967-6-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250703222314.309967-6-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Jul 2025 23:36:10 -0700
X-Gm-Features: Ac12FXzTg6232dhZE0BeMsDyx28vQJwZtDpAIWL-D4Azhs-fNYZ3MQuDeSy09GA
Message-ID: <CAAVpQUDdJgvUNUdbQeWkAOrkVbwP_-wAEsVjoiKCGB=Y=8=JUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] af_unix: stash pidfs dentry when needed
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:23=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> We need to ensure that pidfs dentry is allocated when we meet any
> struct pid for the first time. This will allows us to open pidfd
> even after the task it corresponds to is reaped.
>
> Basically, we need to identify all places where we fill skb/scm_cookie
> with struct pid reference for the first time and call pidfs_register_pid(=
).
>
> Tricky thing here is that we have a few places where this happends
> depending on what userspace is doing:
> - [__scm_replace_pid()] explicitly sending an SCM_CREDENTIALS message
>                         and specified pid in a numeric format
> - [unix_maybe_add_creds()] enabled SO_PASSCRED/SO_PASSPIDFD but
>                            didn't send SCM_CREDENTIALS explicitly
> - [scm_send()] force_creds is true. Netlink case, we don't need to touch =
it.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

