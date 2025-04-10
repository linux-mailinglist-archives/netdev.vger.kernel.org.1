Return-Path: <netdev+bounces-181211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E15A84199
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE971B847D9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9A325745C;
	Thu, 10 Apr 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4U9Xmfc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B51DDC0F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284037; cv=none; b=IcPpwl+xnIdMdTwoOiZkcAlZeSrrA2+o/x9Xmwz29DgKKlyH+K8t4ju1eoglp1PP1alcjJSkyjwOoXjzo6LgdwfbnodpxOy9WIcT+qAi5udleHGEz96ND1W85y0t46nq3JoQVwCvmXZLRh07JUz/r7z938M5oS13FK++q1dG1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284037; c=relaxed/simple;
	bh=P7FSOPyCaZzw4MDKF4Bo/uTCE2TQchgw/q2xK/7WAJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK63tEK+V8BiYfU1XZ0zfh2nX4q5nXixbMx32RSHk+FlAsj+CT1yWDSFbrK2Mbbk9kLEcq8uljJjhNM7WroLktpROmbF5I5ahZxLMD4V6QtGTeINwItjEEz602fvGitB3K0kqAYVZbMNjw8MMVVCsKhk+rMhXA8gfnLrYE9QW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4U9Xmfc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5a88b34a6so71696585a.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744284034; x=1744888834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0ixxsklCwnKZEwu+xxz6ML9VqBkfgtWeGM0YywlyPA=;
        b=R4U9XmfcvApFe96BPrYROEkTCfPAMM/emOuxRZzBbeUpFCJYPD2qtr4VEF3QbM8oKn
         ls0GhHMLjjBa7cOBgTo2ppUgddDlyxasvfhn+if3osyO3iyiUcb0qVeYvNtTsm9rfXgQ
         qp+FG6FYYv0jve6qaIgsSbwFCY7e/v0tzNOstC9gZSfkwP5kNCzk51f90vVpQe3/MULg
         wvsLyiXHroZ5CWdBY7KQj0V2z1uHShDeOvjpZTd6h1PNgX3Le/mmMYfd/NQVhZUlao3y
         Twx4Jb5ml/Jzg6yLG/OqYng7yx8H8BU3b2SruBMda7puqO53PMLHViApEOu/Ou8ixIbH
         D3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284034; x=1744888834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0ixxsklCwnKZEwu+xxz6ML9VqBkfgtWeGM0YywlyPA=;
        b=Dl3bwjCiYmdpPx9+2+5Ic65xTPobEMTlhCSkcYhK5YWbdF6FGB+Dtq7ntQwTwsjogx
         a3ysWqh1nlTMBAnPthrYWOEv3uKUn+Y2xw7iRJx08Q4r6Et/7qhNYeZmEZbt9Cp6Ygt+
         m+ttpqeVniKkpyLsO5eGpl4gRB9MTLzEOBJhZ0ttjaD//qXwiDJoxN2KFw4fngIW2ztI
         xsYzVUvfGLllOgyZcdjSxWrOCxnwDz0qqpM+Ku2bFny3xU4kub/dj9aM+stPK/2Ji4cT
         hdrliQtZC59dMlssf92zXfBbSMnIeKfeY7rXxaJFnCXU2Yrd1BlOyAR+z5/nv3v7K5kV
         EcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEZn7KCdBAnDf59lKKOas3SfD/m9nnuwEmkqH1u9kuoOLw4CunkFZdrp6p5JU1f/llnye28Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAwkBVPfVfjUmhB3KjuO6Bcmh8bYwqlQOjEYhDUZvIzmG+1xL
	Y13Idxn6naw1Grqxk60Yi5CuGyoJg8dlK1p5XVxEZJyp2UKe/9cb9qcc+DnF5keieTOqCstrZ0R
	SLuwupQKwsEPidF94gHj7oG1Oc/uPdQlUIs+0
X-Gm-Gg: ASbGncsw5HcDStSiui998i+WupsPmXYrp6locDDmltAT/Toykm6gIHZ8oMSLCzVdvR7
	CoFest5vaZj8F+ZS7PhJfKAJRLcz/dpxJJp3nGqc9VKmROMnzDblv1Q2BAmGJOyA1rhElgh4N6R
	cNe1PVIEhS+sItDFrw93Eb4LA=
X-Google-Smtp-Source: AGHT+IEgN9y5qDoSxI1c2250Mg+hPLym13IISYXLAMk5PmoXhL1N625xKxdHLuOBaEnFYuwCqDuB7OGtPB5FVv6Tx9o=
X-Received: by 2002:a05:620a:4453:b0:7c5:50dd:5071 with SMTP id
 af79cd13be357-7c7a76704eamr283135185a.22.1744284033438; Thu, 10 Apr 2025
 04:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409073524.557189-1-sven@narfation.org> <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
In-Reply-To: <d72376b8-a794-4c47-b981-11df6e17e417@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Apr 2025 13:20:21 +0200
X-Gm-Features: ATxdqUHzAGp9hO7I8G4vSPPvOZQl2TjQ8-xe1NM8fip-lY8rnbmQhJokHb0BTTs
Message-ID: <CANn89iJgmwTfQBi7aaMY40_JnA47MjzCF2+Md89dgyE9Cgt9DA@mail.gmail.com>
Subject: Re: [PATCH net v3] batman-adv: Fix double-hold of meshif when getting enabled
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 12:13=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 4/9/25 9:35 AM, Sven Eckelmann wrote:
> > It was originally meant to replace the dev_hold with netdev_hold. But t=
his
> > was missed in this place and thus there was an imbalance when trying to
> > remove the interfaces.
> >
> > Fixes: 00b35530811f ("batman-adv: adopt netdev_hold() / netdev_put()")
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
>
> You must wait at least 24h before reposting, see:
>
> https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/process/m=
aintainer-netdev.rst#L15
>
> Also this is somewhat strange: the same patch come from 2 different
> persons (sometimes with garbled SoBs), and we usually receive PR for
> batman patches.
>
> @Svev, @Simon: could you please double check you are on the same page
> and clarify the intent here?

Also I do not see credits given to syzbot  team ?

https://lkml.org/lkml/2025/4/8/1988

