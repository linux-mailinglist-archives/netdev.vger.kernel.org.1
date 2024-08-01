Return-Path: <netdev+bounces-114812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396B9444AF
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000BB1F23055
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010F1586C4;
	Thu,  1 Aug 2024 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtULnWB8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADB157490
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494782; cv=none; b=YL6jD0G1Ggs8qvGVIl5OZFW2BRWVq04WZnQp2g7mdW373ljglbrmXd/BOU3btPB06HdhWVt4HbgizJfXiJdtGW7AfoUirX1d4ZD31u6dtZttXibSevHyKlpQU3sGzAZ+mOxuGwzxwYpp7UbgPwcxp8PUhmLFdcgLNH2/uqeggkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494782; c=relaxed/simple;
	bh=Jkx8f277zrEWVXwSQwLfnFzKGG0nvS+9X97LVjs4P+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWuUUmeCZQl72VvJXz60MBqDkOztiKPfMpl8eJK/qESEjVgBbbIUtP3xX7pcyR1u4O4ZDGj0E3qoB0cyy5Uv33379QvbNUAdJ1mjxOU7CHtAkhcfl5KRIbfbehOTem8At+I34UMOv032GBSV5ZtPPIoVmP9zPK5zotfWsZn3M2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtULnWB8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so28656a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722494780; x=1723099580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkx8f277zrEWVXwSQwLfnFzKGG0nvS+9X97LVjs4P+M=;
        b=FtULnWB8UXB1uCxt9b/qOEG0sM+OqimX4i9LbVl1wXx3K0Ik8KeCiOQONIwADdDDwf
         TcQ6LuSBF7dpvsijnxCZeeyHPZrWyDtVC9+RnO7/pS+qVBn5YFnsztbZ+Gpc9mgdxO7a
         3cpXYI1TGK+Q1KUy7TKvVIfVy/tDXF6mt9TM2x2qOGG9guZlJWzjkVtxKvlU/u6HQk84
         b18lRAVz3UqgQEwpmapJS+wd0SfT6R22CgKf8oWG0IrsFidLho2pMcJxc0p4ox4pMDUP
         qYda2ltMmpZKUb5Eg7S9SYoqXKiou3mtj2IWVNJNyF9VhihYFBphuBmQlY3F2SNcCdqc
         Vczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722494780; x=1723099580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkx8f277zrEWVXwSQwLfnFzKGG0nvS+9X97LVjs4P+M=;
        b=A49xRdXLojs9p05X5Q1s5X6zUzR2lmAcvVgdA+VFA73rmcupK1tacdkN2fjqMV1CBI
         4vvvmRWz2suhqtaquUO8qfQ33n/QxNomo7ljYJ+ia1KPuCpCgAOQ8JSxc9SveOHXRd/M
         +xMBfqQtj0jjXlP5/5BumYqAtM5kPIgB4F2KUh2U8s7JRiGAnNu1sSetx0EoBjl0xISq
         QArsk2Y8hthJFxgXmpUAuMxSpwBXJgz5NZTgPs6h/PzwIYlF4o1eak2NYlWjRWolq05m
         NjPvcBErPtkw1eRMtzWsKr7nuyHEo8zOIfwFM8tP1gkcllh6XWAVIUE1pxOlSz5UJAZU
         I+ig==
X-Forwarded-Encrypted: i=1; AJvYcCXKPau32bgvSPpBZIrrpwV27u1QqAcsejFIDnmVDcm8v0drenro/J4mwCAupt1EkrtzWTfN1jRBz2Grg0ANVhJCf3jmVDYe
X-Gm-Message-State: AOJu0YzNoLFuwCaubxykd89ce45BVxuE/CwtUizS1jx0LSEu/nf6gDHe
	qnwNwmRY5w8MB3pgTU1H+WUoWNGU+k9/lOV2OpiQ1+G1bduruuvsVcsbbmxys+2xPmpqZOGTKl7
	lh+Gc0mxreZ+tgHzRnC4ehgybMlNACTJnz1U9
X-Google-Smtp-Source: AGHT+IE3cw1MNNwcwf69//fIN28Z82cEPX2hnQMioZqEX77H81l4nLfCXbjwHpaAduox8tkpsQsu1fFAsNW27BCwhx8=
X-Received: by 2002:a05:6402:2550:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5b740390cbamr42068a12.1.1722494779197; Wed, 31 Jul 2024
 23:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
In-Reply-To: <20240801-tcp-ao-static-branch-rcu-v3-1-3ca33048c22d@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 08:46:08 +0200
Message-ID: <CANn89iKiDDQu9A8URr6ZtYuBL6uSmtGxYhw7-TOUgGz5cp9OnQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace period
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:13=E2=80=AFAM Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> The lifetime of TCP-AO static_key is the same as the last
> tcp_ao_info. On the socket destruction tcp_ao_info ceases to be
> with RCU grace period, while tcp-ao static branch is currently deferred
> destructed. The static key definition is
> : DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
>
> which means that if RCU grace period is delayed by more than a second
> and tcp_ao_needed is in the process of disablement, other CPUs may
> yet see tcp_ao_info which atent dead, but soon-to-be.
> And that breaks the assumption of static_key_fast_inc_not_disabled().
>
> See the comment near the definition:
> > * The caller must make sure that the static key can't get disabled whil=
e
> > * in this function. It doesn't patch jump labels, only adds a user to
> > * an already enabled static key.
>
> Originally it was introduced in commit eb8c507296f6 ("jump_label:
> Prevent key->enabled int overflow"), which is needed for the atomic
> contexts, one of which would be the creation of a full socket from a
> request socket. In that atomic context, it's known by the presence
> of the key (md5/ao) that the static branch is already enabled.
> So, the ref counter for that static branch is just incremented
> instead of holding the proper mutex.
> static_key_fast_inc_not_disabled() is just a helper for such usage
> case. But it must not be used if the static branch could get disabled
> in parallel as it's not protected by jump_label_mutex and as a result,
> races with jump_label_update() implementation details.
>
> Happened on netdev test-bot[1], so not a theoretical issue:
>
>
> [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/696681/5-c=
onnect-deny-ipv6/stderr
>
> Cc: stable@kernel.org
> Fixes: 67fa83f7c86a ("net/tcp: Add static_key for TCP-AO")
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

