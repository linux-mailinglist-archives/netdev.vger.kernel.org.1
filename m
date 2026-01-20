Return-Path: <netdev+bounces-251441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F988D3C561
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD46C745BA2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CD3ECBD5;
	Tue, 20 Jan 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVH0iemt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DC3A63F0
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904555; cv=pass; b=rKIysDjdLzpRhBXONf2J1hIxLPsvPaiYnAYJQRWRKqzQmTJCNIjqtBPp5pSjH6QYddQ7em3CPdcB6WssXXRmMB4VtajcZtnsG2Heq37VBlx/+46xSBytyGSzLmcJhbMTAXry7E9Yd/eU1zEwtqJOaDoXlePOMnNQmKBMt0PuOOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904555; c=relaxed/simple;
	bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOhH9AWVdQ36rC6SsBR1Vz/LLB6F5b5cNFtPelAcePWYFSt/UUNRYXl4CCx7P2fq0jYN9HoOK/vszsiFhhZ56irTYYLF8IhaZnx5TNcp7N6bQyv6SZS8Znx6ctSUBpg/X881WIuvIRTSnF6awPQOoEo960MPl9xSuRMxmW+de4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVH0iemt; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014d4ddb54so55850601cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904553; cv=none;
        d=google.com; s=arc-20240605;
        b=f/CatRPwYfj8AmeJIGILx9wlEMoGernBkW8GKLWPAEem5odXo71JY5V3+JMCSnT6bJ
         6xn9Wh7NmJYWJv3w1QMj5nfPMz6UlP1CJgwGHGK2R4E6AXRCXzZWVOyaL6p4MQn+Zpqm
         5hl6KDZKu4NuqQm0lQR6fBZ/IXR85IMzOiIfUJqU0qicZ1RH25qRSHZucfvoOyiJdilX
         D+BLTVVYE72bUJ5lbEVzMce+AicUUSrmgdp4PMVbu4jcD/KDDJkeIxvyMS0KtRK43Vrj
         bAW52NFmBtrAZGKkfEhb55rjLtADwIVQNV1XMcXH3hJQTqb5rwwAj8BRpwYhh7JGAs3/
         Xcmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        fh=iDgx5k3RpAB16Oy4a8eBHP/W5jgb2rwIdJ5Yc0jwHWI=;
        b=E2cR6BpISlTZSm+3V9SU3w8GlUTzv2fJp+Cy9pmq905IpN4M6PHtklrOoY7+KrP3y0
         +krd2Jvvn7eDhcHN8GVL8cwYiRBQ83i/H1PGewTKfUVbHc/lOtxnrz9Zpz3tRBLqm4Ej
         kpp+a0uzedK7gaM9x2jLcentD+QK6TTC9Pct8BCkAUP/0FQo9Ab8qsoOOi3evBPv/F+x
         pFMFg//oM9Gi3p6bpzcqJ50C+8I8Sg7JW/EiI66gNFvBH25hij0o1ZztYVNVzOD6aNgk
         uWv1hl0yP2y02ksdQYKF2qRpiEgVPBufW/qDbZcbv3Z2MeHlJe36SZmr79kvHIUEFlzq
         +XOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904553; x=1769509353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        b=BVH0iemtJXKgFzcspkojUU8TuSs21rpLoDur2zzJ922EnIgWrkLaRMp0B9iuSoktNz
         5khK03tz7j7PR5kUv2f2CyTtzux3YZlaF5IHhlZ5DXMbV81KSbPJC99Eqlpk1RAFtCX1
         kcgM+g1EuR3S1b9x62NLLLBHhV7l5ORtqmC8YWruZ5CW30RV1vxOD7/nagZH4UIyLHGi
         YSWeK48Q3xFjL/2JjJpn+NjaEeggPzhKQy1pmtns8mcq5b2RM9ONHdWaB8hceS2Yvc0B
         c9kotr6V+LvrwRvSfFWeLTyNXlGEM/3lI/7canEuRoqj+bHKm0ZXuIq2Q8s102nxLK3U
         qSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904553; x=1769509353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        b=HHq3UOl6G706iUVV/eePbeqs6rszZGqPxiA1ihOq9GqB+2xA+9TEWvRmZFxcd/q4/J
         w9vytA9EtcmbuOWNr4fGHy9QaZ5ol566kcIT2Js9QTZYNHKZeExqDXOaffDPtZhOHCed
         5CZeA4GEdoNKDnDteO7GgH/Fua4uas5lrmmwHr1DquZnj3uYKy4cu3ISXDhJP3pNWFnt
         dWw9F9zt8+N/klL3Lw2ODGUH8JFvRgfpQ09gfyFvJH/rZsebQ2mf0wu5748QxAdKt4Gm
         5rx/MVSOqWOFlLCLiwyW1+W6Y7ClS0rUbmSwvtJCV8s4mAfHeBcojPf9j98Zqn+QlZEz
         hakw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZKZyPbvukB+73s5ge9ieMphSKUpex3vfd3GOoUBO9WmptHD4VOKK/BFaTk/TWEjQVNTNUZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUGqpkofmt4HOf5CceI1IecIwuvMiOuboOSj1wT/IZcLexaby
	69tq/l+z7/pPryx6I42KhRetV2V4ytbhCH8+W9g3QQW5YOaKwehm3EQ7OhOPIjuG3jA6Q4WdPkq
	Yabyv7c0aBQZYL9UuAwbZC3uEaKsenEhNlFxbx+bX
X-Gm-Gg: AY/fxX4k9fEQEiOLN0TcQq7mRi8dSMpCsEfcfQOiyj0F3Mpl8qwWyIQ866M2S1Cqc61
	grI6NJjgPC7NrR5PPNM1QtKI78W+8Bmb2NJakaGeZ/3AWrr3mozqb8lmQ6PXHDHzrk0IfKZWGmG
	KhojsOVi59WlI/ZpJAYV2WNKKcr8Fd12RbzHkB7Ub72E8yTtri/uxetzqTG/cb5tk/FTmXfUdmg
	ZAkJTv7ZwNuKIgTyUxG/AnQFr6BkMLkiQO1iKBZSK8F0k3nTbU1XDe5006Nwt9O68Q5+KI=
X-Received: by 2002:ac8:7dc3:0:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-502a17de1edmr195650251cf.83.1768904552249; Tue, 20 Jan 2026
 02:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:22:20 +0100
X-Gm-Features: AZwV_Qj6HtGAH-_1CoFAtwz8z7DAfNNNRGDqqnAwXby63-7-acE9435g0aUmmD4
Message-ID: <CANn89iKKQH=moYMied14AHrsDTOKK0pM4kVQHdh1FS4WcnU7ww@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 07/15] tcp: accecn: retransmit downgraded SYN
 in AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
> (the TCP Client) times out before receiving the SYN/ACK, it SHOULD
> attempt to negotiate the use of AccECN at least one more time by
> continuing to set all three TCP ECN flags (AE,CWR,ECE) =3D (1,1,1) on
> the first retransmitted SYN (using the usual retransmission time-outs).
>
> If this first retransmission also fails to be acknowledged, in
> deployment scenarios where AccECN path traversal might be problematic,
> the TCP Client SHOULD send subsequent retransmissions of the SYN with
> the three TCP-ECN flags cleared (AE,CWR,ECE) =3D (0,0,0).
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

Please amend the changelog to give the RFC precise relevant chapter
(3.1.4.1 if I am not mistaken)

Reviewed-by: Eric Dumazet <edumazet@google.com>

