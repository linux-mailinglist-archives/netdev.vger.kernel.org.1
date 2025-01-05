Return-Path: <netdev+bounces-155257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A409A0187C
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 09:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BAB1883403
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9513C9D9;
	Sun,  5 Jan 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2/Xw35C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352B38FA3
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736064915; cv=none; b=tJ06OpPgpjRoBvpXoEnLoNV4mfzazzD1V3AXKV7JwGEpYbBEfKS29VJKD9Aw+IbgyTIO/j8CJGynfPOBZr8cjnUzsNCb7TFUaooH3htbavY+VuKlL6ZKrS4yt3GHxVFYdhqnERJFLsN6KItw568KXCTgMASGSgr11lJRj6s6ob0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736064915; c=relaxed/simple;
	bh=T5NJXp+ZwwSk3CtektKFXWCm71Q0aZL4BglyNE9k7bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgeZ4i0JSN3S+ValCaEvVQiOqnGuofXVgVmXeV8BP+RIoT6EuIswd7e266G1J1aj3QTpFolTRLbYRuFUTSw+rBNB9nOoXB0JPymTCr+8vYAV0Nmf5LqlWVF34+QLlZYRm0lDK36U42KE4T8X2RL1fjclJRHtpP28Nvj/6dvAjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2/Xw35C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso4773042a12.1
        for <netdev@vger.kernel.org>; Sun, 05 Jan 2025 00:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736064911; x=1736669711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SZjxMLQhQsvR+61eZqi7biFucTvFfuBFc4OhmGjUWc=;
        b=t2/Xw35CiPCttP2Hl9eZC1aAnSGr+o5kdFBJh9W8Rxwhsgsa5zyjZtBcl3z1uLYDdR
         A5xT7JfWIJa6ToMHCU+P634/4Z8FT0sqnnGOg4ZXA+oG5zW104PpEa7FS7cv7F9mPnFs
         LUm0N4bSj6U1oHNQ2Dkp0bOSI7YPDR4g53+NtEQ0+enVkdUmDstmC2tFfsNiHyoPtr5C
         35ImwvMr9VIURIYYpDdjbbfftjAAcbOP1T8aBW8aPEvPg1QvPr6buTi4Juc+OmjCjMpf
         ShWzgLcEwP7tsYJHedCLbLkINT7vuoRqiwAxIU8J9CFHhjYhroXYtrKlbWdTuC6QJT1l
         JQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736064911; x=1736669711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SZjxMLQhQsvR+61eZqi7biFucTvFfuBFc4OhmGjUWc=;
        b=wk1FoJaMfzBNksPMkLa4HKoyd+610c00kiYGhWExZjEwQzlA0wS9mtSXXoQMWXEALq
         ArqGNJYA7hB7BYhFcpk8iuIrNE+gBho6wXHEgDRCuDsqZIae/J2eZ7cegrjfGTaCKnFw
         BN4OB+ai0KO8H/74cray3gb+OlEdEOcKhK5EO3ByDDvM7Jobp8EshpWCtA/4t29VBz6Q
         ydrXRHoncJVHw6M+YErvT7Nj+k0tYoBJlSuP9xvnYTow+yxk6LsXUPBju7/dnsa0uuee
         WGTBvwOESdfA4znwLWp4P2GTXvcN+W8CnuZdy3s8xEeJTVW2vuyXdY9xjQjuL8s2s+pt
         4NRw==
X-Forwarded-Encrypted: i=1; AJvYcCWi1FVj/hpqcd+Js4PVAyylJGZr/hytuTQGXgxWsh5CGkR4DSccD+9BcSnhSmldQg6cQ9DLQig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpw+VZELYbHUwNlkBPcdTtoailTHuJ688+vvHH70KY1vKxTi56
	6zItaL5xawwHxxk63VqRYpBS+pVuL7Ndkogj+btA01yqqFxs4YF76kxC06jDarbUBqTOL8Z4DWs
	oNQ2mPAm4B4RTMdrjuyBPxsITvv2snS5B1o3N
X-Gm-Gg: ASbGncvmED1J4cc/HfJ0iML07UIjjVMKxylUlBBjSugLBpW/ybYDfoB1Cvi25St7r2j
	LfgfpY/yODVhHpROMXU3fuRzdub5VlXsR4cXzwVo=
X-Google-Smtp-Source: AGHT+IHw94L9pYn4JSzFh8kcYSrnpzrST6+Nefws/gMJJJD4tSICcjS9ICp2poUuYb4I7Kb10rf4O5VWYI9hHD77cCk=
X-Received: by 2002:a05:6402:3512:b0:5d1:2534:57bf with SMTP id
 4fb4d7f45d1cf-5d81de162b7mr45171330a12.32.1736064911440; Sun, 05 Jan 2025
 00:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105003813.1222118-1-champetier.etienne@gmail.com>
In-Reply-To: <20250105003813.1222118-1-champetier.etienne@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jan 2025 09:15:00 +0100
Message-ID: <CANn89iKb+T3cZLJUwRNZah6hKHn3XbUyw29PsEAif5LC96NRoA@mail.gmail.com>
Subject: Re: [PATCH] ipvlan: Support bonding events
To: Etienne Champetier <champetier.etienne@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 1:43=E2=80=AFAM Etienne Champetier
<champetier.etienne@gmail.com> wrote:
>
> This allows ipvlan to function properly on top of
> bonds using active-backup mode.
> This was implemented for macvlan in 2014 in commit
> 4c9912556867 ("macvlan: Support bonding events").
>
> Signed-off-by: Etienne Champetier <champetier.etienne@gmail.com>

Which tree are you targeting ?

Please look at Documentation/process/maintainer-netdev.rst  for reference.

