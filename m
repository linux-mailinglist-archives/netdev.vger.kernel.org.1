Return-Path: <netdev+bounces-64351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE0832A87
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50CBB1F22700
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971951C5A;
	Fri, 19 Jan 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nul9RvPF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97542053
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671042; cv=none; b=o3CDSjbOrQpf5tW0YB8ZUgV9vuCVwT/+DQuGH3peUi8BiUZG3JE2ZPMQo6qemYPLEFonc98WTozNve4koS0qRGyUgCUv4WMbfw7x1PoY6K5DM7nOhMnMNFlgKyl1F8DKHw5Rq3mn4DX77gSfxrE8yHZ7sIKaas/EJ5AQE44EAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671042; c=relaxed/simple;
	bh=a0uoUAhE9Q/R8dAQmJXcJaB+JtxtGdoOYTSiiQFFVOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEKQHmrZGUOdrqTz2I25A/BBxhqxYHko56sl1fJS9sbRVDTJf6LgWC9SqMsGb3SWowW5BnFKi+Y35FsOnmflpw1DHVT+jcb40G24J/2o02rNNhz7IL5fUGNPk+bd2PvSDWIcE/5KAm4QB75pvHNWoZC1mMiygZQSkzr6JOb+RDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nul9RvPF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso11661a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705671039; x=1706275839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlPKgk/fnxfuP9Q07OQUqP/M5AyA82LzstwsivBtf6g=;
        b=nul9RvPFHF6EuLsGBAqKplKksdXbVLfav5JoH8sEWiZT14HzEbgUXSPIF02ghOfN+6
         hi2qt/6dz6HZdJ4SVCJFOQDHFIEcoVWQkl+QI5TGAXtxzsDOOiIVuyDr37t5G6sOil/Y
         HjcVrDnZ6kvm2N6C6V5s5Uh1uEtOKZCiZNmmv7MqkmQ54Q9NmC8cmWVemjnp+13H4nGI
         WSkSc7keVQhdF89Judunh89nqMD75no/4ZyLwCjcRf2PxmA5GDxI9pC9s9rzqmJVY16Z
         bQgcwwZPqW6YzTTgtnHYgZUiRR/xxqD199w3vWqcZycrX0mfdVaQQb2qeno3aVC6rFqG
         qLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705671039; x=1706275839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlPKgk/fnxfuP9Q07OQUqP/M5AyA82LzstwsivBtf6g=;
        b=tHykEqNUZgj78ifkVKxjTUiU33BDwKgh6FiYHXgkiZu+feLBs2TH91HJOvVSGHTWux
         IgFlBjD/m/ePGAeZdSxCc0R4HMIMQ3b8o62TOPh0dz3lE6RP/ptnpIgxll0RiOV35Jd9
         +15+W7RzHNVyQLkUukTMHI9ZHt+M/mmMvS51znyTiTXMTxH0QxYDWFmFlVc1Kw86kpqV
         q9r0bTwDmTL6Kffq6Qmpl/FN/W6TzeFtLzE0qyc9ocqFKQbOBgfIbJXTLV1vAFfaK19a
         O9eWWqlFJmx1bMlZiDi1fBVTVMKBjVSWGlC9L8cpIb46EjLR08uAbjxcVRtopxZ5jrLk
         mxDw==
X-Gm-Message-State: AOJu0YyrB8h3KNea0e6GKIHvGJDnLkZQU8/VoInny4EZcqA2TbxJ26DQ
	wHlJuP9jIsnhACRDjpQmk0NkrVQU8Vz3pU/ugD+iGbGqVthLL6+19Pd4FptfSM9wXrDR3RQ03XF
	Ax3ptc/t2SvBxvuvSBD3itX7+754I+Wkn0Sup
X-Google-Smtp-Source: AGHT+IEy618Y3/rnv27J0YKl6nteuEuaj1gr3/MtT4QpOm/YZFwymuXAqIXVg2+w9piaKntBDi5Xxra7C0Nh9D15xJE=
X-Received: by 2002:a05:6402:3127:b0:55a:465a:45a5 with SMTP id
 dd7-20020a056402312700b0055a465a45a5mr174471edb.4.1705671038644; Fri, 19 Jan
 2024 05:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119015515.61898-1-kuniyu@amazon.com>
In-Reply-To: <20240119015515.61898-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Jan 2024 14:30:27 +0100
Message-ID: <CANn89i+uUWt6qMCW_x5u=Khgo=G64WMT0eSYMhGBn=90=ztW_Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] llc: Drop support for ETH_P_TR_802_2.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:55=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzbot reported an uninit-value bug below. [0]
>
> llc supports ETH_P_802_2 (0x0004) and used to support ETH_P_TR_802_2
> (0x0011), and syzbot abused the latter to trigger the bug.
>
>   write$tun(r0, &(0x7f0000000040)=3D{@val=3D{0x0, 0x11}, @val, @mpls=3D{[=
], @llc=3D{@snap=3D{0xaa, 0x1, ')', "90e5dd"}}}}, 0x16)
>
> llc_conn_handler() initialises local variables {saddr,daddr}.mac
> based on skb in llc_pdu_decode_sa()/llc_pdu_decode_da() and passes
> them to __llc_lookup().
>
> However, the initialisation is done only when skb->protocol is
> htons(ETH_P_802_2), otherwise, __llc_lookup_established() and
> __llc_lookup_listener() will read garbage.
>
> The missing initialisation existed prior to commit 211ed865108e
> ("net: delete all instances of special processing for token ring").

SGTM, thanks.

Reviewed-by: Eric Dumazet <edumazet@google.com>

