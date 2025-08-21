Return-Path: <netdev+bounces-215624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18533B2F9A5
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982BD1BA3707
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F3C3218A9;
	Thu, 21 Aug 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEQJcZ/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006FF31DD95
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781475; cv=none; b=VMh5BzLfvia+ELUNS9XdBAd8jnCY5R4JKyAffa3/GYgIijwuWk/+SkGYlDpEQ1sckmnxQagmZ894xK+g7TQw/5H5Df6fqiIy4ZBw97oXQ7K+JyYjU+4n+K3c3MWEHjBswvDQKdpDTYSPOUYCCk6Z31nldpabn4nWYSIRE1wN5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781475; c=relaxed/simple;
	bh=dksXjVdpoZxSgSUQEjTqurSba+l6eHHY6MPN1daXJck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TedjCoDT1SySrMm32OfR42mRDJWViJXoGfF5OlZ0EsWkRbLZZzzJDhv2+PFBCrrnEZS6tTmRbTFzkAH2BJPRqxvbm2a9qx+KLqajTdCobAjeGuxnJsTQ9gL3WEsjN8y9QaN6BloBzrPJ8AGn0YYaM/uEwGcvcv+PkxI/h/pTL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEQJcZ/O; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e86faa158fso138286685a.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755781473; x=1756386273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cyf0y+0F3zjeNAsfKiaSOtP08SnUX+d4gcmortqinM=;
        b=mEQJcZ/O65dATBlYGtnKTmDmhKhukdF45BXUwIsXmz/8E2kVElQXFQwIHNWVg8q8ug
         9KJSNf+LkwVn+QrVlYkNYyuvRTL9mIdG9Jrlu/ZE5Lv/ct+K7HFLzF6WiD8i9UVn7Wf+
         NT69uI9ElWNrfOgQedsLVuF58qC/tyoHAFUrCDC/GW0uaK2YjuA1K94TUmfEu0hbBZZA
         UY4SvTIZnpW2fAWKbH0tWJ4WXPnlpUnZ2QqdgYmJUllauwdS6LkRSkJFxRsCnnCgkBv5
         CqWkiB7g+KDAy7u1MxPXXdLedySimf/Nm+WOoyMjaMsRFTJ6sfiV6QhGoIxyu/F4zGVz
         5mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781473; x=1756386273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cyf0y+0F3zjeNAsfKiaSOtP08SnUX+d4gcmortqinM=;
        b=ouosaj3VD4S6vJPKpvs7ebFFfl0+LUTGqjPRnFFzwkkf1kT3CP0jnfl0T10mvS23bq
         mPJN0LxxXrsGGvK4bcxB3fh8VH/rEf4aSlTuIgsDUmNS+c4OSNaONB/UFEEseTjLfLr/
         mwBZB+OfpmdaSoyIWStUCgVPuBHl0PuDqeFZeV9lBerDtej3OvdX952rSHO5x+yMmba+
         YcoiL01Zf5lhrHlUUcuCcQ6/rQGKWYacDGx7mYFZ4ZlHUKS0iMeNokOSXRH39sue8KFC
         NFAaQ+ETfzN/DRwJlVlSgbCBaM7GIfX0C9dml4PE5JW3bPasbZdnP/x3ZEdEdf393Gpq
         Bi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAxiuPCV45MzD9PchWBDUxhxZhS7qmjLjcAeSukRc0Bgx9wEMYsXkp7LmbhtMX1zns9h7tjzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfryV78cqt0F20y3GtT5bnzlQYSEBk+OUkVFeMV7YPDci9Qv7A
	zSCg6P5TZisc4QnWMS7Mk0dPalc0JdEFJ8W4SVdC0HITwLc13tVx4jZ/wxX/6QPwz6PcaU2QnzE
	PIwXg6qjevwmEbJioqOWEYUmeg3ZYcpKILc5fGwsN
X-Gm-Gg: ASbGncsQbg9ry6nzIFU0TSBRmvcoQ7WaTryHYp3UzLkBootkavAOYyFoyuygyKxTIP7
	xlTBZ1kcB1l7/0LcO1Q2y/Ct6IcNXW82r9S4YHivPP4gGyDsv1BEuGm09C5lPxmY5MRfoJfoUS5
	2GWpmAIsJRBstJiHLWnPv23LUXzkoUMoiKPl9aX5jOJTkHT+xJ3W0teJs02kShpymrasjvX3aCs
	Xgya9ck+i/sMjxY7UYRfIz7Jg==
X-Google-Smtp-Source: AGHT+IE/rVuZ9SCIHg1gU7wHZFKJcVFlbis3SdAosQsMQXAAs3D+JvW5TH6jC+V2oisrZbfPgFfUQfa4iF740e0XHhA=
X-Received: by 2002:a05:620a:1915:b0:7e9:f820:2b32 with SMTP id
 af79cd13be357-7ea0972ad73mr237461685a.39.1755781472346; Thu, 21 Aug 2025
 06:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 06:04:20 -0700
X-Gm-Features: Ac12FXyJZ2QzT9xkYMMFg0cMwGaeSy-IVq_aPmJhAwN18-ZLuJFS365DtCRetGA
Message-ID: <CANn89iLFEM+mbU2d0AEH3O+3zg5Cwm7pdmaadUxXifUqLuaQLg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the reuqired
> AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
> AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced. Please
> find below tables for more details:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | Number of | Required | Remaining |  Number of  |    Final    |
> |   SACK    |  AccECN  |  option   |  reduced    |  number of  |
> |  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |  x (<=3D2)  |  0 to 3  |    any    |      0      |      x      |
> +-----------+----------+-----------+-------------+-------------+
> |     3     |    0     |    any    |      0      |      3      |
> |     3     |    1     |    <4     |      1      |      2      |
> |     3     |    1     |    >=3D4    |      0      |      3      |
> |     3     |    2     |    <8     |      1      |      2      |
> |     3     |    2     |    >=3D8    |      0      |      3      |
> |     3     |    3     |    <12    |      1      |      2      |
> |     3     |    3     |    >=3D12   |      0      |      3      |
> +-----------+----------+-----------+-------------+-------------+
> |  y (>=3D4)  |    0     |    any    |      0      |      y      |
> |  y (>=3D4)  |    1     |    <4     |      1      |     y-1     |
> |  y (>=3D4)  |    1     |    >=3D4    |      0      |      y      |
> |  y (>=3D4)  |    2     |    <8     |      1      |     y-1     |
> |  y (>=3D4)  |    2     |    >=3D8    |      0      |      y      |
> |  y (>=3D4)  |    3     |    <4     |      2      |     y-2     |
> |  y (>=3D4)  |    3     |    <12    |      1      |     y-1     |
> |  y (>=3D4)  |    3     |    >=3D12   |      0      |      y      |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>

It is unclear if this chart takes into account the TCP TS option ?

Can you clarify this point ?

