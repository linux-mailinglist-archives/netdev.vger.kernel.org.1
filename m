Return-Path: <netdev+bounces-251347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4CD3BDFD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7899234B9F7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 03:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1F63314D0;
	Tue, 20 Jan 2026 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw/BMzIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE93314DA
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768880397; cv=none; b=ZxKWYJMowHH6IQb5HrXcsEB7D44i4fyPYZTtfsF0YlyvlxI3AJ5dwAdL37xrKTSm0YsK1YAwed/6XjFTZM50rvw2axLiKWNg7f3h32yhWqg845qiFOrs07hYFY0C77ESwo6nXSXrSJ+KlA6SKtKz9G1Xxq67vLmnls1pKHlSrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768880397; c=relaxed/simple;
	bh=PkQnT9HrASsJc7IurqBQq+Uzv9yailjV38eVPJVHhAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EytkeGOc3mhAANKAQNKLpuzvFhzPt69QxXtUCwHS7HSiX4TPTMFB6QYkEtSZBn0gGHpt0bFloxFwZ3acPnTZPIKhT5hwoPONMTgHSuKnQWsOzZWU63HYnhvZbfJrooHiHZ3GSb0pEU1Q8PEvB2alW2H1KbKnRhrTnEtPrZZa+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw/BMzIS; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64455a2a096so4007529d50.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768880395; x=1769485195; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f2e7dJ5whTj9SkU/TlgqUpo4cL0LQRd5uYBnJ44hS4=;
        b=Gw/BMzISSY9TwPlVTqjdrPv5xoy9IucnPOywTAMIcOG2d12GuE3BvIM86jkEIbbzWG
         jpQfag4w2e4OcO7fVhb82Tjtz+ElJSnDDkyjXAu43uJK5vVfwcnHiJJUyKUf8z8+5IR+
         ErBQ5n6LqGlXzEtzS2F3wWMRj2F7UTcD6E6/XRnDugIhEVvynaqHWLQZtrQ8po/oN3KV
         y5kbkfdOZZSZRtz0wHQVRcklTCp1KWbX5UXdKBG9bHhL7aEcdaqiokMuDW7n04SUGRXw
         BkO9TQs5GWdB/TKji+PeaIXS+mlcUhQdE/GFtMW8BktTG+Y2Lu3w/rzkaUe91V3llMjG
         6v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880395; x=1769485195;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+f2e7dJ5whTj9SkU/TlgqUpo4cL0LQRd5uYBnJ44hS4=;
        b=m4beC0nl14Ygcm4YrY0IJ6Vq4Ikrf+0uSH9CiiiE4Z5LUxGJcduDSP6XdAK2DqNiCB
         Oq08S5CDW5ffPzx1cfNW/dGMVUP72tC3Qhgyk9YLC1FV1dShXyPZLA4VJV7cnOCsaRmQ
         su/Q4c0TIa5DBZeiMlSkE/JR6JSu52yKK3a9R8eIaVYh+8sB/yPgIO78ICZwECVMAak7
         NCUzqVKt8zDgVw1v64anzdhYkw1QZqukfUY9mV2QljagcWFgotdrO9RI9/0ZP1FoCsaz
         YTpqtyfEXpjBYIP/v5wX7QGZ6W9aJzGbEDfpM0Kk6QCqgLlAHYzs66UhjZtME0yW5s7x
         3WKw==
X-Forwarded-Encrypted: i=1; AJvYcCXwY3Ec+UHPhzB887xjLbyr2MWs+kzQC8L32g/A6yioPPmFHRijHLVPGke/3aZ28/jELApyxPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGeu97fsSkSzik2xxDKAysDF3hI2rqCNQWWa+DX02oaEpG2abx
	G7arg1C+9Muq2u21jkjviSCg81SiRPgm3+9JgDXqLZXfypvFZu4H2otS
X-Gm-Gg: AZuq6aL4l49JvOKHL7O/mU4+z4qUU3pBV1fEHGSPr+3qvQ+ZXeEaD0tBVtX1vwzhD7x
	PV8l+TgvRDYEV6MEZLcx5s60V+pIexf7ihJw0DdEfjDsFS5H8hOO3zLeEBifvMY9hJNlDyfxgoI
	b6OPDlC2ClZUmfTYJTDRW/+zlN+Zw7OF7kK48LePmAs/JFLL9Z/fuhRhDmEn0x9Ak255NDc1+vi
	Phaya8e6zlev1K+Y5LN1HjHog9GZnNBhrr/Ye11yX769mgvI6YzOBIUjq+3CXay66HGcHUSmjiR
	TP7ktapJEDRvZufGYRJzrtF+YEl98TP8b4U8lGN7doa5dQ0QYur9eG726OrvHcLhCrAqMmndDv2
	WcJ64of4Wzr9m+lIAvVIfWxyo+OQIoEARl7EMVPH6m8Y/yW+E1sFFXwdDcdTs7wImk7U2mQwqmB
	xB5AhEq7Hl3fJN8etEC7IQiuT9uFOBI3bBx/owGbeRJWZ26IThu9z5mK9BrKVtv5PWlf0=
X-Received: by 2002:a05:690c:dd3:b0:794:35b:af5e with SMTP id 00721157ae682-7940a0e6771mr11618687b3.5.1768880394417;
        Mon, 19 Jan 2026 19:39:54 -0800 (PST)
Received: from smtpclient.apple (2607-8700-5500-8678-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:8678::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68d305dsm47643947b3.55.2026.01.19.19.39.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 19:39:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in helper
 prototypes
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
Date: Tue, 20 Jan 2026 11:39:31 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
 <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

[...]

> On Jan 20, 2026, at 04:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
>=20
> Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
>   not for snprintf variants?

For bpf_get_stack_proto_raw_tp, I chose ARG_PTR_TO_UNINIT_MEM to be =
consistent with its siblings:

=E2=80=A2 bpf_get_stack_proto_tp (bpf_trace.c:1425)
=E2=80=A2 bpf_get_stack_proto (stackmap.c:525)
=E2=80=A2 bpf_get_stack_sleepable_proto (stackmap.c:541)

All of these are wrappers around the same core function bpf_get_stack() =
/ __bpf_get_stack(), passing the buffer with identical semantics, and =
all use ARG_PTR_TO_UNINIT_MEM.=

