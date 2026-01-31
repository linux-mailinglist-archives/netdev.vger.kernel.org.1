Return-Path: <netdev+bounces-255379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DTdMGWlfWkTTAIAu9opvQ
	(envelope-from <netdev+bounces-255379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:47:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58350C0FCA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 07:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A85D30022C9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D762DFA3A;
	Sat, 31 Jan 2026 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPyBzfU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5F2C0260
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769842019; cv=pass; b=OUXK1xQ6u1XeCQD6BvKHBrYa4J7yGac6KgamyfuUfGI1tZQfmRtBTEQh5xwtZzlyQoxWMG+sK2WpQsymTrtqs/On+gBjf3+o4RT363Zt8AwJiS3F3mfvfxjoiBo2pBegs3HCLZJ72Z/S/FG3vf9f4lER80PIC5hwMho3K7scuKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769842019; c=relaxed/simple;
	bh=aG9ksOKIu90wu45wCI72IlcZtK8z55JAfZdaj74lpX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmxKnXsImXsw4NObPoUz32uHz8jdi3QjoGdFPYQ4x6FVvrSwUtpkJIgNbz1oJlnza535w2jO6KcPSVwBBVwubN6w1NNpFTxuBRl1Lkb6Z82+A1UsDPknyGibFQJyowDWj0ooAA2rjpVu2b7xcGUCdrAluOPHNUfmtwoYpwp+EF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tPyBzfU9; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12331482b8fso4041187c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 22:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769842017; cv=none;
        d=google.com; s=arc-20240605;
        b=j7yJqCEwbtloS551LK+ee46Atpqi/NWoSQWsn9N5ZzTP/JlW+IxWu/uY90g9XvtoC5
         rfM8UYW0qcl674ZCIZdHIZ82p8y47qwBL7UG3F1sHwUqbkXCsEi6F097//3inSBxtDxB
         WvSsTl6OAnRrxOHiXnTTToCnWQfnijwnp0cu7ZzL/kyme9s60WKBAUVdbKe2sQvoywRM
         zWtYxutUuKroNM1eHKK3JVVJZ59s2VwZUZFprkTAET2w64WGnEb4s1xsMiVjZtWQBiD8
         Pu3ZNiBU2fnV3Atlo+0zMUMfCEYaEXkZ/4MHZFt1ALHXizbjk0zS/am4676v1q+Jv9Ig
         Mmjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aG9ksOKIu90wu45wCI72IlcZtK8z55JAfZdaj74lpX8=;
        fh=6bpKV31xqhUdHwarDgX5h8PXt8Q4gzYtYfK32OiWesc=;
        b=GRsYNimWpCgdKx2xGEMnsvkuZCQd8TaSyO5QOOucXVuah6GrJy9SFMB4MMSlzJlkmm
         x46LDapORO1uMu5DMULmu6rRPNcsLQn+yy24aEtM11sOER+A8ybdp4KVbwIpNwDg6AQQ
         v6/wB2cFMkkkfnAMJT4y6EfTTdKNYmchh+BMsEiRNp9xnTG3OGWeMHfTn2hehpbV7Lqk
         ayp8dilhX9kXvX07Cs1WOKB8zEE1H895VzymxLbuWpCKZ8sbu7UEdi3tPIvw7FdSMCTY
         +j4xN1Q2VJrGM564HGnClec4IqeMkeJQo4O0V8LmNAzs+BzNbxvN/vxt5vhEZq8rXEHE
         V48Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769842017; x=1770446817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG9ksOKIu90wu45wCI72IlcZtK8z55JAfZdaj74lpX8=;
        b=tPyBzfU9K7Hv178kIw6/kVD+4FkZ71iF1m8PTScSwrEkOeEbYOQ+GkZcw1tnDF6YXc
         E9HX4kgsSjamB84upL/a2Bl/QknOi+7PiGofZU+NylWHufBOkEogsRkup27KuLzsnsyh
         4sIj5DHZsKkgwojnJiCiIOzH2/0VxZgZenPA0EcDF6/RqSQJaUw9XIPUnaRLifnuUs80
         sf/N/LMz6VAksv8qDQFe1qEQNBVeCmYJKvTp7d95WQvH9d52wLzMcT5m5FrKL3qhnfUC
         Nc6/Xy5vIAAffPeheRAYP71MHsUKeya/baN5N8bNRcbTb2W3GhWEy08F8bvccaiJyhoC
         syXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769842017; x=1770446817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aG9ksOKIu90wu45wCI72IlcZtK8z55JAfZdaj74lpX8=;
        b=taeoGuiZ16QjUfl4dcBxIbFSXMX05y6J0aqxHgDMtnbX2ayJIhjLEsQoSGapFFb7Dj
         9ewm4zC1qksRlJnOxvm5JD7sxWw2wTN/V8U4lOqPKgbH/1CIsY7gXMD2p9JHMPbJ6Y+T
         4DUeGrpGyonX8vvXWywgtn7uW2vDLZQJXMIA8RmTGhpbxN6PbwQryrdhUfinEfpsbTCy
         0grYdb4GKN9iYHnhfQy1Z02GFhF4PVa5t+q7bhiN8Gz/odmBRYThtNpuEwozkuNLXn5U
         aBYZPCrLgasTqk0cHTbbaU1AxWyl6eyUNChqKsSf4uPFUQ1y6s13Ft4//yRwXYUny2dL
         AP8A==
X-Forwarded-Encrypted: i=1; AJvYcCU3FF8fErH6+yHx5541pvX/O7hGLoM1AgvBIEBTfaq19nBw4SI1T0oidCVpYpcEqQ7CRGnfqSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQb+S2TT3nPVn79Y4QaQ8LHz026gsMY5J+ASJVsfASSqtfLqm
	hLpjSoVlq5xlEOjKzLwMPbjXEiqRq/eqGYPAoqDh4fA/kP7gWcCUKOph6Ijr8V1yTyb0Yh+yZZt
	hEAX8zWNKHlys89Cp38a1HNZW/Vr1oPniHLEbPh4C
X-Gm-Gg: AZuq6aI3O4uouVVLaydd8I0uvtk1/ZfcI1I3zl8MEhyLnpnr9/l7CC43FubJx6EUXHx
	RjNo/ugBJtBQN3KIXRjHhqgzW2mEJgJdM2ZFVRWQjKhi4GMYAYG9yZEX1tAtZAWL1USPkKT2/uv
	M29DIg4JO7M871Mnfuavoo6nMi9cXsRPF2wm4gGKGvjZA7h+KG9k1B+5agGOBIouMaIYrjWJp2J
	H70y3/NHEkYFWeecEIkBVUiFSLTNCvEF6rq5mWmXDou9xYog40dKPSrGV0PR2X4z5iyc0/xYePM
	2LLIlYcFnymLa2z9UW4Jus7USfnJMAop9vnxesjGa5kMH32XsUAglOD1B9o/OxUJEq1Ueow=
X-Received: by 2002:a05:7022:e25:b0:119:e56b:957b with SMTP id
 a92af1059eb24-125c0f0dc62mr2650305c88.0.1769842016589; Fri, 30 Jan 2026
 22:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com> <20260130210303.3888261-9-edumazet@google.com>
In-Reply-To: <20260130210303.3888261-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 30 Jan 2026 22:46:45 -0800
X-Gm-Features: AZwV_QgbSPr6YOYxPbQH0q0nkWzrCQXsLke-SAcCa1tbedxEIw4xxM3BVZ-1hok
Message-ID: <CAAVpQUDm7rTe1oxew1e5gvrPDCBbWP1ONjNHBK4KcQLmvkZdUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] ipv6: colocate inet6_cork in inet_cork_full
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255379-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58350C0FCA
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> All inet6_cork users also use one inet_cork_full.
>
> Reduce number of parameters and increase data locality.
>
> This saves ~275 bytes of code on x86_64.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

