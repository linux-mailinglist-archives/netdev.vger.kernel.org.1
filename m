Return-Path: <netdev+bounces-217169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C3B37AC2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9CE16CB1D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CF278170;
	Wed, 27 Aug 2025 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4V/ILMsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8AA1DB546
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277312; cv=none; b=kdCzd8X5h8sDMqNTf3DZa4FucxlkurfGzs2TarOLK35iwY5sRbrr9pyn2z9/HGHp2mHH79SLuXWYt9Ia4/ZqAeV5I8bRzqHgMtJJ20U1KfzBpUgUrBgWnyV3Qwi+cg59/o1kLVBHG2NoE0EKgfNqyNEKQ+QlyMmfTG+khmTaaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277312; c=relaxed/simple;
	bh=KDIIDbtUUSONkUIsWg5HrwwmQCERUmjTq7MXv9xCvq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL+BapnOXTl/z9vc5SQeuQhJf9oE22nV9p5FZiVUHRZk1FNOpb4I+MJCNiEpDIJSWYgxJdtbsn3vpAB/iEhPUfNxuUAjWsUxr0PmiA+A/tIzzGfxI1r+Otwr8cfg0Jtv9lQbTm/KkPI3ouImo8VCHJ+RukI7+6UiJ6Px4eLkI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4V/ILMsd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24664469fd9so41252045ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756277310; x=1756882110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDIIDbtUUSONkUIsWg5HrwwmQCERUmjTq7MXv9xCvq8=;
        b=4V/ILMsd8iFrfS/6nzfSK0Z6D54+8vAGfMxK1glwcFE8NIcudsri9Qd2JLJzRCjwwb
         bYB7wOffhR2Ogge+vO8kETo97cxZZi0iF0fJF6yC0U0sVR0l7QblsXuRdPcNqV8Vk591
         M0MmxoPgfHO4JcYMuuw8QI/f/1b/LvZjsTn4SMF9YzBjcS95SJWc9qdYTGHlAGwn2v/j
         TzcJCCG7CeJdhtd4weYJ1kNYIMDAQ3pCg9vlEPVtJieXGcP/qyTkEA5u0oyc+SJS4VBw
         tv3RUqJTkq+5WdUZEC5EkHBM4VG0YCSMcAOjoMwLsAKVMkZxLOisPfhw6k/uy/H3qqg4
         JNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756277310; x=1756882110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDIIDbtUUSONkUIsWg5HrwwmQCERUmjTq7MXv9xCvq8=;
        b=NGaUicCnupF7FDfU5hcPgnAwPEVb1VaQjddvwGjdTDm7DNO8iHegr0z/1xrYvSRKHQ
         Vc1aZIO3b6kEcHbcihH2LxzbvALj2tj9TDXNwpKZsNdD7yMop1cBXO2HuVUEB9gI17UD
         qNU+NQMhfG412vtBolz3sP9Vx0HOhncRSv6TQBB3yKosyiUbjmn6hhbmvhKj7Pxlupo0
         JUuaL+yZds/82Of+Xo3BYvF/y7era7ywvG1QSK/YJ5q6VYir8qNQiIDOcuNhBNh1b1/1
         6XLIDq5sJXkJciv29CsGF7fcuiFmChEkhEKnn546Fq5R4excO80awsZHle09u3WH5XNN
         vb9g==
X-Forwarded-Encrypted: i=1; AJvYcCXQduNNNqwTGjHpDI0me+nFU+yWWARzgCFGdU5JGwydvRXUk6Z+rPj69yK4raYz11VMtU/NwDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzouYuMbENUBmW9WwErrjyk/0/ECYkpLLAZqshEYGtM1tmM2R9O
	mq9EcPJs0Nus58ToCEfgR624YVLH89pTk2JSLXYwj0NCDCDoz3OY8xVol726Tf61j9Vvvgh6HRL
	Z0EPWnhdmAA0g3zAAvl30WswaJHiO5LsFU9vlbmKK
X-Gm-Gg: ASbGncsTOk8+L/VLIDrtmgiAkltRVHRIwXBk6K+SD8zkSHtyC21d+Nb/SbCO03WwP1/
	+zlXBN4jxSOxEIyySSAuQ8NJRB5P9ERLrHfKPmESyCoDjM/TFiwqtHz40SQypeU70uZLxNudVKv
	68gIBxqE09/cFPHqWDbwI31yhOCU7V/QSNHb+Ti/AyYviGfcOV5bVwMIIbVG7Xb95JZ7NwKO+eT
	iFKcTxhy8ioJVvk6qaWUT1fVaNIj/f9habRvaeCKAmlMFXuvazX7+ne+vpYRaIMNYcewdleEQ6/
	11fhHyMiN88Qdw==
X-Google-Smtp-Source: AGHT+IGlKOPsL5HmiGB6ns14OEUdaHHHLVp3PKOpPKy5ph7E3HATr4YLd59x3SSmQWYPxrDN/z6Sf1MwNyBIM3fXdPQ=
X-Received: by 2002:a17:903:2ecd:b0:246:22e3:6a2a with SMTP id
 d9443c01a7336-2462ee1a616mr238109095ad.15.1756277309980; Tue, 26 Aug 2025
 23:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823085857.47674-1-takamitz@amazon.co.jp> <20250823085857.47674-4-takamitz@amazon.co.jp>
In-Reply-To: <20250823085857.47674-4-takamitz@amazon.co.jp>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 23:48:17 -0700
X-Gm-Features: Ac12FXyHytAfOhleRkCY940agxPKzR2y5s0bTYnTsYrXaqhUZs3xBCr0fcpPY0w
Message-ID: <CAAVpQUAtFWD0gsuY1zCodD=ZGY=-FQnG+=Qve8cQ1yKkVq3i8Q@mail.gmail.com>
Subject: Re: [PATCH v2 net 3/3] net: rose: include node references in
 rose_neigh refcount
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kohei Enju <enjuk@amazon.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>, 
	syzbot+942297eecf7d2d61d1f1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 2:01=E2=80=AFAM Takamitsu Iwai <takamitz@amazon.co.=
jp> wrote:
>
> Current implementation maintains two separate reference counting
> mechanisms: the 'count' field in struct rose_neigh tracks references from
> rose_node structures, while the 'use' field (now refcount_t) tracks
> references from rose_sock.
>
> This patch merges these two reference counting systems using 'use' field
> for proper reference management. Specifically, this patch adds incrementi=
ng
> and decrementing of rose_neigh->use when rose_neigh->count is incremented
> or decremented.
>
> This patch also modifies rose_rt_free(), rose_rt_device_down() and
> rose_clear_route() to properly release references to rose_neigh objects
> before freeing a rose_node through rose_remove_node().
>
> These changes ensure rose_neigh structures are properly freed only when
> all references, including those from rose_node structures, are released.
> As a result, this resolves a slab-use-after-free issue reported by Syzbot=
.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+942297eecf7d2d61d1f1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D942297eecf7d2d61d1f1
> Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

