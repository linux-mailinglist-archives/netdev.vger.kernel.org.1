Return-Path: <netdev+bounces-72465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16D858354
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02611C21292
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471C13246E;
	Fri, 16 Feb 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYGhlHmD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971861E53F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102930; cv=none; b=i3MyzUcZDn2X835Q/xarRWYM0DDfKMjMPOQ3tpuIabnBsi+8H0Jjg71EqTht4edTEIlWJulJnGBg2ptpVj7UkCuGDaa1I0lMW/x4n3whEc3ECodxZjfnlNKoyLOjMGlF9YBjRRrofoUKebIRcKyIjtL8MTuGGspZT/Kq3u3sZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102930; c=relaxed/simple;
	bh=bTad7K7GepXfLklJ9g+Y4ZvM8AHhSVMv67nCpxMyNtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laLwKd8I8PiRZbD1ELw+/dGOZETByZildVvMlmNb4KliiUK4AO+c5HF/MQpWI5EvijS4LLuEiU4VGZwDhYgLka/73OHu8dlRDWSec4X2CYHFwdQ9pfc9Btc8BNMlfbHecfH3TSP4ePcI5eBVo8IxBUE6MAjYepiW/2w0B/hYlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYGhlHmD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563dfa4ccdcso12300a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102927; x=1708707727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTad7K7GepXfLklJ9g+Y4ZvM8AHhSVMv67nCpxMyNtE=;
        b=eYGhlHmDBXTPij7r2rc4jYBHSAy5X2q3jMs7bXt/zbfun3mdjCmOad4XjB3mZBV9EH
         IRMHqywDdTF630ypsEcu2Ra3/ScYVMPEgrXU6C0HXziaQX0zug7CQt4941z7SukYH2Pi
         UNLoetjOmJ8iGJQ68BK5YPtL26t9BiXnwv1zMiMTFfU/tE5gaOhD3fJqayA0tPvFYEmc
         HTqzAHueKiM3HssK3otemL0u1JBcAsVMqErc2JbGT+UMKV5iPdqE4XsQmzzi11W8KWVL
         xQJ1w1evykZGveuxrmeEqrs4pRQ890MD4mUg+777iQkFCgBC0y/Q+4F+e5a/raMDfFZB
         n0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102927; x=1708707727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTad7K7GepXfLklJ9g+Y4ZvM8AHhSVMv67nCpxMyNtE=;
        b=J4ckutRcjFXvpADP3xWlC1PCbcCf4EuyF2rwsNaT/6zF/tNdT2XY5q7EpCQV5hKiu5
         TvtVr5th4xMSPL2XUmsZZetwcZqHlSkATYW8CzOS8hzL+pUWfD4djHlZbXYurXFuOBqd
         E0haIOIbJHfKtW61RJWrrlPvJc9PPeRLFU8NUJmRPkRi8hHd5V10eYsD6aWywHC1LkRj
         lQgxkSs+ybLTIUG6xjPxV8H0NsMEsPd5+pEX3RLID1Fo68/37GS2kNRbfAIAgqlSricK
         WkWn0/agwklb0St2kJue6ctM16LG6YRcbcAk46LiWmVHohO8WSvOF3MtB7iDEOGzQlTW
         QBoA==
X-Forwarded-Encrypted: i=1; AJvYcCUo3WQIsT3uHj/ySnA4cJIYF9HDfhi45ewfG6eMBP43xJ1nQCNSm0IGwNncfX2IonAS9iT0nPG9xa81IiduxoxwBaUtL2/j
X-Gm-Message-State: AOJu0Yym9+quJxonJSvPH+GuaVqFudQNaDm9qEjmuHyILSeAzIiMaU9j
	Jt95z28Yjl/rF55lscwwcaAiMch3cAV/SqalPvkQURgfR1kumCKmA552BN3XTbMIKvlaXbAVwoq
	An+AI3sYYB18uChFLaL/nx/9qNxnRuvh7xWAXIqDZ+5WFnzGDgA==
X-Google-Smtp-Source: AGHT+IHsYs/z9rBkdSqBIvYb8ruhAYRPyc3ss4PpNmBojP41Fge2Sd49cxaa6dgcMzAGrY/x1QXFVRp9PMtVMfTNYW8=
X-Received: by 2002:a50:aa93:0:b0:563:afb0:28a with SMTP id
 q19-20020a50aa93000000b00563afb0028amr200595edc.0.1708102923058; Fri, 16 Feb
 2024 09:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216162006.2342759-1-edumazet@google.com> <7904adc0b3ab1c6b4bc328b0509435c9d38fc98a.camel@redhat.com>
In-Reply-To: <7904adc0b3ab1c6b4bc328b0509435c9d38fc98a.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 18:01:50 +0100
Message-ID: <CANn89iJYSjpaDE3xDbioSBC6VQE=aZoU8RSXKT98VQY8fxFBEQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: reorganize "struct sock" fields
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Neal Cardwell <ncardwell@google.com>, 
	Naman Gulati <namangulati@google.com>, Coco Li <lixiaoyan@google.com>, 
	Wei Wang <weiwan@google.com>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 5:59=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Fri, 2024-02-16 at 16:20 +0000, Eric Dumazet wrote:
> > Last major reorg happened in commit 9115e8cd2a0c ("net: reorganize
> > struct sock for better data locality")
> >
> > Since then, many changes have been done.
> >
> > Before SO_PEEK_OFF support is added to TCP, we need
> > to move sk_peek_off to a better location.
> >
> > It is time to make another pass, and add six groups,
> > without explicit alignment.
> >
> > - sock_write_rx (following sk_refcnt) read-write fields in rx path.
> > - sock_read_rx read-mostly fields in rx path.
> > - sock_read_rxtx read-mostly fields in both rx and tx paths.
> > - sock_write_rxtx read-write fields in both rx and tx paths.
> > - sock_write_tx read-write fields in tx paths.
> > - sock_read_tx read-mostly fields in tx paths.
> >
> > Results on TCP_RR benchmarks seem to show a gain (4 to 5 %).
> >
> > It is possible UDP needs a change, because sk_peek_off
> > shares a cache line with sk_receive_queue.
>
> Yes, I think we need to touch UDP.
>
> > If this the case, we can exchange roles of sk->sk_receive
> > and up->reader_queue queues.
>
> That option looks quite invasive and possibly error prone to me. What
> about adding a 'peeking_with_offset' flag nearby up->reader_queue, set
> it via an udp specific set_peek_off(), and test such flag in
> udp_recvmsg() before accessing sk->sk_peek_off?

Nice idea, that could work.

>
> > After this change, we have the following layout:
>
> Looks great!
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>
> I'll try to run some benchmarks when time allows ;)
>
> Many thanks!
>
> Paolo
>

