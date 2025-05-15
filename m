Return-Path: <netdev+bounces-190846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D28AB9102
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE428174147
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAB212FAA;
	Thu, 15 May 2025 20:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nKKaXMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6029B785
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342421; cv=none; b=eeE4ZmDUXsaGJIJ63Qer1qLhr+9FTghN68mMtfIuFcLNqwbwloHzyo/j0y4doe1sE+pP2gJvWSfevupmRFRIiKa9fLEc20F7KD4A67g8kvlZbS/L19DiV4H0jCgnsKW6ACQaBSxdA1DIWhBM4nywq+17T6FABED23z5Ka0hE18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342421; c=relaxed/simple;
	bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3dMnA8eXORUmyBV/jq9i5d+wEFjwLMAvLe0/GsgXklKe/B4Caeen5q0hweNlYBUedrCmxXUfYcKcOsEh/xwFSMVDHnyd5sWSYN6ayDTiGG27E1fK05Bi4L++gpVoKFdn3phx1iLVc2GN/qekn3iPKsvbHCj1FDUpvSeo0/bXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nKKaXMq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso3546a12.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342417; x=1747947217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
        b=2nKKaXMqiU+Y6HP+xLOkg9rKEusnHOmOeXkq5h/Lhxw2Q5GjKRUQzRj0ZWR+ijlJZi
         puAiKjv1EPimoohXSmZNbBrrwhMe8MUBiZB8yMz7p1tbx7cu0H6lSylVQldX2FmrKOeL
         R+9adWGLo8XvTiMS2VuZevsKr+JFhFDC5bWMsCu2tiL8l+ITcqOWfvoMyDO3VmhE57lg
         9Fb9xr/GIKkVsBl3ivleppN8dMfE+18jhgv9Obr+yCyjBTHUB2QTmso1wprAeKhn+0TW
         YpcMF5PSUrq+OkYDsycdVPNbhSu8VacQOHAEG0Axm7VsikxPJ/q9GYm5cc1n3Mo741a/
         nmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342417; x=1747947217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRv9EmETRWPXZVHYTT7h73M1bxh8y8TuRvMu5qA/7F0=;
        b=jb+1FOsjswYwElGKZlMdBpd6zWXz1QL9goVKntzg4BeCKYsTzp7gLvL22BZQVm1rnm
         dkmCjmDo7dbd5lNWPjxyCZ5ynPyptIZ6K5tKFWqIONcuIv+DDZds2mVswYHCBgShUN+w
         aqP0x8sxXjMbvRfWU5MtIsjQrqO3T+Vkx5JazD/ECPNc9PqJH97SeJfxeLoaZLe+pzkn
         PUyLTbFXPB0naCTU1EBYBbpeEF0UqiLVEjYvTKv68/p7ihG1xvIcdMy2zTGgU6WOLL1f
         Krro6DhMAzhR9jyVz9QnQeCOCaVkMRc0ZDROSwITKV9TswOZDg9pU3IUmJWg+6ECqMFx
         ZDPw==
X-Forwarded-Encrypted: i=1; AJvYcCVKO0j4rMk3ItUOxnxwTK3VXGt7vFPI/xSDoP8UvxpC23iKH8K1Kg9dHI1dsUvDNnaBtufkA9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzC+U1rkdEV0NfQtrNUbFeInMeskGR1HR7n9q4aqkxinVMw5o
	ctmU9p4fsv9IKLYNERNNLikXKSOBhtntvqMzZADir/ccKxU4fn/SIpN5qZaivUGEh/W8SDMFH2Q
	0RPGggT8u7FmvBWxcyjuKTQByAguOgafAWYUoa7kr
X-Gm-Gg: ASbGnct/OR2BHVAMGfgt4ojNokGFp86LWkD7liPXQE9+X4RrQviWCq+yDGCkwYGhydZ
	BiF8YLj6v5XNEqbYj9vfN7oed+yZv4dBIhVPr1fLFq2iJZlC5RMKPg9RNB8GI9yw9WNeN/JIChk
	25Ml205a30vyVGs/dytj2TJRlcNfGR73nPV7mffhHh7qOVGOmxBLEPcpwxbUCg
X-Google-Smtp-Source: AGHT+IHZ9jFIvkL3s/WhGIrI4IThR5QXdM3cICdVMwLZGSJ4WKA5W38ar/Q+P8ZFLrgmTwdP5BUbeE+U40I1JEI8RSQ=
X-Received: by 2002:aa7:c392:0:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-601233a4fc5mr3186a12.2.1747342415935; Thu, 15 May 2025 13:53:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:53:00 +0200
X-Gm-Features: AX0GCFv4nrwtDZxOQKAFnOch8tVFv6sz1vCJIdy3HEL5SN0W7L19J7ev9XtxuAM
Message-ID: <CAG48ez00GnBZZDjpYBmccgztaW+0206_X8__UiFxtBQhm7rvhg@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] coredump: reflow dump helpers a little
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> They look rather messy right now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

