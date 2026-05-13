Return-Path: <netdev+bounces-287589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOheCtR6BGpoKgIAu9opvQ
	(envelope-from <netdev+bounces-287589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:21:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8094C533EC9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D87C32BF14C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DEB3A1E6A;
	Wed, 13 May 2026 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwymHeD9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AE372698
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676952; cv=pass; b=mpB+GpjPud22JL7jw0aKdKCh5ApX8COtoAhjQielYmJkl89XTGU3hhmkpIInXAg9tpTSyHlufHc9oVEA/KBDS1dOxXyAmy9FBkaim0PiLvfrTQNXYJ0CUaS8SRdKEyIGMhL6rZkf0Qqt0f/u2fyPr58I9m/9E8tktAPw+aQaqNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676952; c=relaxed/simple;
	bh=z5pppaFfNtI94Xp4RMt+gQ7icJ5vvzLalnbJhVv8y7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4eyM5GQmViKjjbsDU/BOfa50nMSZagkJbVSp+aNwOF2G0LCmJ1bMZd/8SGkAt4H4o3jxHnxMaYCBqPDJ9maRs389HpbQIAwK/iR0sg4yzbyVMxzQUxJDhYo7JV1eAguQY9RQ/9Dmw8Ks3E/YjydSxzDqLKN63qgO6bWTNQwWd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwymHeD9; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso304a12.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778676949; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/8r6pJCHCSJnTFoBz49z+ubdXIoxwqrglOE16Wyrfa95wQm43k0E/jIVkH2Exhyg2
         3FEdEztLCNcVhSnGkH2eTGpyjza/ExiQMCAvxOIEFa5Hu5aQpJ8HpXatFnR6EAgi6WMJ
         bQmAaEgD5XrH1J3IeWKqGtr3Cb3xEtApRMbd5aGXGdRIMu0G6HDsbBd11Y7BwpEybiqv
         OPpRegB3gyqQOX2g7D+ZZa1R+haqc8BYJi4C/wzE+HLBU79YYpUlyVXQGmyK8CrmkEIH
         Fd2OfSwT+UwwulBxb1mXXEUOH9JICWUWO9HkZhNAgToiWbVBjTJfVHBUgMJBIaOQLEjs
         Ymgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5pppaFfNtI94Xp4RMt+gQ7icJ5vvzLalnbJhVv8y7I=;
        fh=bRVDoQsQ8Wsct0NQDW3nq5JPTtHLXbzE7Ms/q7xYkh0=;
        b=ToS2gktYvoD0ZU0otEWNu6cw9hCYo9KeQLlRyebEL4Xg2QveJAlh4ADvjQjq/zvLCt
         tIzar+oLdCxeN+hnV6HjAKxKxkmGqCEhUZgKV0UOrVxKlD6TJhK0fc+sDH12PR3wDssQ
         2L4q0Nq4buHkdyNSe7h/r4XCPkpfWVJ5YQAv1rEm2dsE+QoBLTwjQOTuvmvbG1h5zhRg
         HWNQf5O77EQnA3iDMf/LPlNIGdP8OuoP6Z0utGi60yGxYhTOzQJ0wMdUyvJGQThyhzIP
         QTnuzM1/shuadMyii6bFiCuzmA1I1fU269EjQ2Di0mTZldoyamriJm71DiZq029pPr0+
         uB7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778676949; x=1779281749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5pppaFfNtI94Xp4RMt+gQ7icJ5vvzLalnbJhVv8y7I=;
        b=dwymHeD9h93u/FzjRQDQxUSmcJhn6ndbmZWRkLN2eldp8GyxnRY9J987/MN3Ty9bcR
         ieqyZxTAEkCgcko6NfN84r8Kxm/AL8s0vwhc7qegTN6XAA7Ntyr3BGbRDZj0/mj7kX+b
         0DAZqLfJB4XSd/5eu7+vx0HdThGoiREPY+47ERKBumGqO+rCG6jVOUQTf6mNDog/Rzeh
         ZjZ/v8MhyRO06dDaSFGujYB7nmtO22/vXToqbGWsiKs+hutZXyNBHhQMpSDPzQfo2PED
         zMsCIudrCDDf3Qc5gl/XAqH/40YHBldWyLKIYLefmECekmZBvngimJ1PgOZenyM0A2OM
         Gt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676949; x=1779281749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5pppaFfNtI94Xp4RMt+gQ7icJ5vvzLalnbJhVv8y7I=;
        b=mrJYvRAA4xzHkcmJhv1GD2wviGuTbd42wmM8Mots3ER+RwMG90v7Z+qgjwd4vABdVK
         Djzr3hwkjHH3jWC/aDNwv68AT2UDlN78iAwUVOdfGbtk2KlyjSsgZX9GRPceRaceLnBY
         0J3j3cRmenAbb9rbkUvEGY9TxVb6nuOyh4GMPSm6CwtKfAVMH8/tLTfvzTrY99eLiPqB
         gCDCkQ4cwhuhqTZYPia52jMIhLPORl6dVeprQJvwulTz6mV2bn9jPNEog2qRnBVH7h0w
         NRtUOVr0Cmj7friLQBxAxPt8dJjMdW2E2JakQtAzD1ZtM/RJWOT1fnmbDmk+CRPv7Rkc
         kaAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+c38dLmiyP7S0hNPdFnV5B1uZSx5g+H0HnG11VcShfBBya0iwjNrYBRmM5rf1gbw2gWOPv9qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkytQBMIy2FB4dVps0JUpBFYG+kRF0XGAiXsDyG//0LTshkpA
	5TF0ZvYr9mTlQMAMB6UU+f1KPWHzkdkOYbM7V0x/CyBsjetQDaKxlUeVSt+bri6M5OjDGTT1q1B
	LVgELcSdVn5JdsTP7BMLB1+gpE43tflJOYTfjAYu3
X-Gm-Gg: Acq92OF4YfIufhNvsg+EMnPgcXMaf5O6jdwT+rgHQFNQGpoS4TW7jtWMng025vV+THR
	qVzzaJDCPBlK6nEU+oqYeb35jWUjJZrWUoz78w16SQtmMnWzswYScxQcu/7eEPJaaFK6NHjUoWd
	UDmb+5iQanumLf74VkDUwyrpZmEoUGITfPmveyDQhSDm3c8A1t6ITfJYSbIY72E7KZeGZmmTpYC
	nbEAmt8suTqaORQxlIp3iiMGwSDpcfaAIVgZsDqcebN5+A4jSIcNpxV/zxxzWaPAPNPtES21xMO
	UX/e3UUNPb6MGcIkdRr1j8m0wHUB9GIDZBpndyWuyVzm8zVq2nhUzy1+VDY=
X-Received: by 2002:aa7:d987:0:b0:670:2007:668c with SMTP id
 4fb4d7f45d1cf-682143aeccfmr62081a12.4.1778676948796; Wed, 13 May 2026
 05:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-msg_no_shared_frags-v1-1-55ea46760331@google.com> <20260513095038.116dcb34@pumpkin>
In-Reply-To: <20260513095038.116dcb34@pumpkin>
From: Jann Horn <jannh@google.com>
Date: Wed, 13 May 2026 14:55:12 +0200
X-Gm-Features: AVHnY4KfwE3y7h8hFZX8aDELXSD4dJEB9400TNzsk3fsPJWPaOeiLqvFuTUjsx4
Message-ID: <CAG48ez3gw9F3YM9Xf5z-Ye+5Vfw8TmGT81sDMXV6pPHL_omrOw@mail.gmail.com>
Subject: Re: [PATCH] net: block MSG_NO_SHARED_FRAGS in sendmsg()
To: David Laight <david.laight.linux@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8094C533EC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 10:50=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
> On Tue, 12 May 2026 16:02:03 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > This change should cause no difference in behavior; it just cleans up s=
ome
> > hazardous code that could have become a problem in the future.
> >
> > MSG_NO_SHARED_FRAGS is a kernel-internal flag that cancels the effect o=
f
> > MSG_SPLICE_PAGES, another kernel-internal flag that influences the
> > data-sharing semantics of SKBs.
> >
> > Prevent passing this flag in from userspace via sendmsg() by adding it =
to
> > MSG_INTERNAL_SENDMSG_FLAGS.
> >
> > This is not currently an observable problem because MSG_NO_SHARED_FRAGS
> > only has an effect if kernel code adds MSG_SPLICE_PAGES to it.
> > The only codepath that adds MSG_SPLICE_PAGES to user-supplied flags fro=
m
> > which MSG_NO_SHARED_FRAGS hasn't been cleared is the path
> > tcp_bpf_sendmsg -> tcp_bpf_send_verdict -> tcp_bpf_push, and that is no=
t a
> > problem because tcp_bpf_sendmsg always intentionally sets
> > MSG_NO_SHARED_FRAGS anyway.
>
> Should that be inverted to an explicit list of valid flags?

That would be more robust in the long term, yes. I figured I'd just
add this one flag to MSG_INTERNAL_SENDMSG_FLAGS since that's more
obviously correct than making sure I have a full list of allowed
flags.

> Unfortunately it doesn't look like calls with unsupported flags can be
> errored - which actually means that no new ones can be allocated for
> new functionality.

That's not entirely true - to avoid issues like that, MSG_ZEROCOPY was
wired up such that it only takes effect if userspace first sets
SO_ZEROCOPY, which essentially means "I promise I'm not passing
MSG_ZEROCOPY to this socket accidentally".

