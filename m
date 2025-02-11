Return-Path: <netdev+bounces-165210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41BA30F77
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EC23A2E2D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A90253326;
	Tue, 11 Feb 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pF+h16jW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC820C010
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287210; cv=none; b=i2/NhVdT8XtTVpMunDJ5VpbEtXtCWHKSezEq0o57sHeuDOma824cyg0T53FScHRrnhaMTwr7QoIglMlCd+fmSQMGsQKZDIa1Rqw6a4Q66KqyQkIIIlWBJQ/gSgeVfPC247Oj5MUldlR7eqwA3CmYrIwlg4tg8nJ+9UR0+/srcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287210; c=relaxed/simple;
	bh=TzaJxWcJKmUY5Ga5qo61EJCKNiAgvtpHLBzwKKn2UgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGbFTZb4GpD9yYWV9cgAbPt6CLQjO9JpdbUQH8PP5ADUnM8vlNhLjwzGaePS2ZnXfAwIaeJJFwmZ88AQH/AR8+lq8W1k6RmT9MLHfhsY7PZ7i9vhq5uMNWwob7dM2a+WXp9B8F8b4UqZgT9xSJVzudC+JCf7SP/OI9oqj07YSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pF+h16jW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de84c2f62aso3774764a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739287206; x=1739892006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzaJxWcJKmUY5Ga5qo61EJCKNiAgvtpHLBzwKKn2UgY=;
        b=pF+h16jW7YgkccUVcLT2I+P10VVDUdyknUqP5DbXSsIl3jcR3YytOScD4xBmlnQOiy
         KeDLEGNZBvbaYlhl4vG835IDcODpILJ7kfQwfGHE2AdudXwMEfcQdVuFlUlCgH+E79cf
         lNQokdygOSmz0TD/KB+PH1xybcZ0vU3h+XonOCpy5eReO99TH6GDQG0qsXMscUMD0vl+
         avaBvCMknrrhhF02ZmwuWXVBIwM6CgoSPyjkbzZxoU74AVx6GTzfgkv8vVR27JXYsy3s
         yPUvLRUTr24BN30Q+mLho34krU6hCed+6KIDHNwZi1lY4G4daNUXbOlZ3VsjJRsgUqtT
         rAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739287206; x=1739892006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzaJxWcJKmUY5Ga5qo61EJCKNiAgvtpHLBzwKKn2UgY=;
        b=aOMFl1+JNTrJZ9S6hdWnT3oyd+LA9cwM+dkLN+cNVPNYXZiIjBjvCNOiCXYs1l/6/G
         eIohuCH9XnoniMBTVIU30EcWpiIu9QXfiYuENucyk+b8VX+0iqEKoBhrsDX2hrFOpSM+
         MQvj1fdaiGCxUSnSJMm9oPlPRAtkYdiFKV6/9SHBTYPpKryKPMnFCAuyVJa/opjzK9aa
         Auoy2rEI/IJyKhPgS96YKBjgiqNsy+x5TfJAea0fBwDclU4EWWtJuGBecbyRbP6t7VSd
         icgbNxvIwPBaqlcO7zFjWowEZ33wjix0lG5IUzI8CIZPh3SvTlj7zrDFNdgC06cGGtkb
         Legg==
X-Forwarded-Encrypted: i=1; AJvYcCWWcip1QRS8/F24rjMM9jvaSAbmPkucdcM5LgY5kaSqLFn1hVdJkJZKAls1Ao7Rtrkhhcy7VbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSvPjB4l55ru39qToZ9ftu621J46qgfcukm15bia4zd50MKe+
	FmVVtwbufTzIFSrcrXQ9kSEA0lOzW+PTUmYNIgDPp+xdIFxFAOYK3UYMwfm/rKShvzpYPU+k1Ys
	xOEMWw5lDo94DIgqfEuepPws07QJwBjlZkscO
X-Gm-Gg: ASbGncuoQnQzfBr9kniPg1P3MmIiG5H+Pm6Y4mg7KwfrTLUJJ5f4CmrzUuvKdU5ASjJ
	MuRvvsEdswWnmu3awAnKVCQw1vBwxC6PbMTPWbFxiQ22O/Usq6HzJaDFB+mFf4Usetf/bcMsYAQ
	==
X-Google-Smtp-Source: AGHT+IEth4owsN2cD9rohcAARjd/9382+dkUD7t78PWGv1IE2yUnn9CnXi53JmFCuYO1txkt65Y7e8lsH/5TjgHniUg=
X-Received: by 2002:a05:6402:1e91:b0:5d0:81af:4a43 with SMTP id
 4fb4d7f45d1cf-5de44e5f276mr21275900a12.0.1739287205956; Tue, 11 Feb 2025
 07:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
In-Reply-To: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 16:19:54 +0100
X-Gm-Features: AWEUYZmNEvQX4IUPNwHy7Y7XlqImzph57mMR2FKZX52SNCst07ZlNJorvgmWpUA
Message-ID: <CANn89iLMK5B-9LQtga2HEnEs3rS=ta6eOcxxXB2gCkYYApLM4w@mail.gmail.com>
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 7:04=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
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
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

I can give my +2 on this patch, although I have no way of testing it.

I will trust Steven on this :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

