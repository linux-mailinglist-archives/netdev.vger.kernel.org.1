Return-Path: <netdev+bounces-167335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37116A39D45
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D30188391A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02133268FC3;
	Tue, 18 Feb 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPbVYq27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E2267B80
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884894; cv=none; b=a8xyyysX9OgOYY9W+zg7zCsQLkdGuicTH18Orp8jznQO3aAxfJguWdFHnbW+xqy7uuKwUXUbLCCAvVcbmaLIyK0VZvdFbkQsJBGIh+GB98wXKc3VJ/Iu6OAfWobU7kSZ65e3V+GG+k+Ud6wAoyg8eTXG1LXGvCO3ChToYCsbxOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884894; c=relaxed/simple;
	bh=vNJSYCuYen7yBiUlt8/F/NhDj/0DDvBzBZsO/cYBZN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+DZiuEuceuDiXGxk2tmBsy9X6B0dq2dHKEVeYlADMixZSVhKrHhNhjdgJHQbMplYULK3UmFe4QwnuNOyr4nITVeKDEs5xc3bXHvfsHgHZRicAeSa5/WHVBU5CvSte/DB3i8NY4J2QZTxxyZOjQ6UPPYsveLOkF/iLmJfHTi0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPbVYq27; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb705e7662so568759866b.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739884891; x=1740489691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VRsn+AEynXrzDApi3GOCSB7kda1CeXhMpv+TvTGpE8=;
        b=nPbVYq27ZawqQJs54gG+N7vhAULaE74Dqem+QI0sRYaGaOIjWBLt2QoG5tcUwc3LMp
         djms69G1IJbBIk1ct6zk7pVYqfjOSgeYAf1iWCENh67LoeMVSEmtydzKgGJj8Tc9l76C
         WuuqeQDDCyIOEkOllnD6jyoXevFsQcasuZukogKipx1PWdsMNubuA/XAumbQ6PQB0tCr
         LDq4O7XA4VwzBc0u7AbTzZgXWfg3RuYBBH7nZtFulbaQoQ33NLbqRW0+sYsNyXBfmtlh
         B7bTNzWWkIdw/MSwZRTtOdCcvSY0gklRCtR63UEM1Bl4QUWvq/a9E0hNY2sAlnXk0UBj
         MlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884891; x=1740489691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VRsn+AEynXrzDApi3GOCSB7kda1CeXhMpv+TvTGpE8=;
        b=WCmwSTrFh5h1jWTdPe1SImzH+xDJNfQBKoK2MLFFDr6+DyVbrLMCib+29BcCl94Clh
         xJWAJYa/Cd5NSjp5H5hN7jWwen7dmIYRZQh2rlarMyp/Cv3W9/tAO41ixoJfCLNMiLpO
         5H8c8Uh6YVsTuoG1tUv2CloClDHFUQBCWXBrcQZGLZHChPabPVy7fDrOWmXVGS8SxFLe
         QpCI8kArRYUi6P2ZYpnO35JMglNic/737dmwnUOijeEqJm/GD91tp/B5L2C2oYmLtNrE
         ZGjlco416VoKm+9G+YCdNijcB1qKz938xIExxBXygH5ANU0z7hWJW7azb4ZCEs7dMQnF
         B0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXOU4ihObtjwTH56Z7msIt+cczftN+z/C300JdRA5ijC+oXlycAtliPFgF8pDaVHruJceTtaYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ziVcSBfZZXq4P7QWXAR4+4Q1SbeZjnqG9pqzrJMVuL3xeXlD
	BUfLwyQsoYy08f3AcA0Ck6JHRBM2jM7pmgloY374h9j2YDArhUVSFIvhxQsGmmHcpnCjPZBXjn7
	+409vDy9JgS04N+tSz0O/HbNOaPeZDM9KpODG
X-Gm-Gg: ASbGncs64kBQRPYH8CQ8uKEtkP6jpNytufYKEq1JTWgJ8QvD9qD8VIpgOM4rbDPGLum
	xYEn0AGkCfSD+/U8enE6WxM25QblYBrVweTNdJu56w9ct4bAF1+qPjg83dC11tPtLZeu9jQ9s
X-Google-Smtp-Source: AGHT+IHENWMLQyMCFNyQoxq+tfzbXqrmhbnicTEoipxWjXHMkPQJj0dvAxcA8gbOg9IcuPizgSbv9RYX5Ub2iiHYQEw=
X-Received: by 2002:a17:907:1903:b0:abb:c457:af69 with SMTP id
 a640c23a62f3a-abbc457b75emr101178366b.0.1739884891353; Tue, 18 Feb 2025
 05:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 14:21:19 +0100
X-Gm-Features: AWEUYZn0nWNA0Mz8GXU5V1iIM17iCX9C2BuP0-zp0BUC-CYDsMjMQia2EAIfB_0
Message-ID: <CANn89iKyKTD+vQwG-h=oczX=tfBJeY9SVmXFX4a7yMXJCvuJ7w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
>
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
>
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
>
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
>
>         rawtracepoint:tcp_cwnd_reduction_tp {
>                 ....
>         }
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

