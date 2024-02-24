Return-Path: <netdev+bounces-74694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923278623EC
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542B71C21A27
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E371B59B;
	Sat, 24 Feb 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/e4ofWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C818037
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767077; cv=none; b=eqdkT2Gy7zrpCUQlXGuS6rbwegjhxxSKmq8Dr+WAPo+rt05BwxmJWUD57e3h+A85Ui2fAa6gDxAkYY5y7qGkUG6Dw0MNG96czDuyXE6DnHzR6GvBiJFEDFb+cuiyYUnjvZuOvoce3Fw48AG2cvtoJqY23i7yop1D+ZNEtlK7AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767077; c=relaxed/simple;
	bh=y2+xsbNA7nJA5AJAIiiYtBIFp5DHt0sr/WcAwRB23LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGTuyUboF26OXZgvmf/9REO5VOv5qKIFH4hlJDZ6G5GC06E2coA3q59ZHTQW8AFuTUCnY/03CaF8m7PKdZsK0m4jH5shvnp1fyD6UgyLin0OXjGGknbwGD0avywZoGJnJz/vv7qhzM9KhLkt04jTE6FzFh4J7zFHwT7GDiQ5KSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/e4ofWD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso3757a12.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708767073; x=1709371873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=y/e4ofWD20vd3a1URnY4gVNi+xSV3qazdgGof9LdTOzGjqTop0P6aPamki0ZqSqYfB
         8jzkcCaMNaIpmJ0G14woHpNmbJvu/21hSAOyxvWzlfcTyg1WSUuQxHDXvDvmN3lpxB02
         ej0DLMEvAf8S1YVFIb61w0mDWMR793YdZ3YIHn9a7t7ZxU/4A0DVieYSU4KYgccZtO8C
         W0d5MnLT7+WrmnZ9cJ135R76IUHgL2rqZSQ/h4LASdB8h2e0+uax9yjGIw31p4tuTRf1
         OxfMDNLFpY3POZ0yl9X2ouDzGJLcC0KIZ1CnYoVGT2/hTwVoeF9ZgNt8JRMldLkqinZc
         LK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767073; x=1709371873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmY5NkPyqyDzoEieFjYp7SW5hjVc2+Nb3/NQOzb8Ges=;
        b=r5RN0lkM6ZW96GkxMIY7FvyRVV2b+bxBKA4YWlKIcGl+YyjsWnsET4GWRy56EPSk+w
         sFWlICv46VL3FjoXcOqZ4dfYBB6c4x4SeTjKRJxBIB5MdAE08k7nhluA0qDZRSkOn5SR
         +Ly9ymkgJbBbtEpX59teNWdl5qWQBdpZRiO0cP/NzU/FX7qOmc0yz0SoZ8GWDsXTDwk5
         xRIIYLVNbl8lAAXS8BI828R50Yols4MnxZpXfbFUqgvYwoUVGXhXhNrI2rmrK0nRp63g
         HbIV1pCTnV7EjiEw5r4TQHJODQLaZGV4pNITR50Mz5b52+VEyeF3kCDB7+BeussRsoI7
         lisw==
X-Forwarded-Encrypted: i=1; AJvYcCVppUIt1ry2uAdTnkobZmAqppXfFK1vDbBq+NlAXftRfTcfxsMznbyVsHuQEW+5yFQGypP2Oy8OtusJY2o3cSWBwBgmG86k
X-Gm-Message-State: AOJu0YyJKqR71qu8HCPopQOkMTnbLOZ0/dKZJegWg/i5xrlBpVXsoaFy
	+bQTv8HGnxMewVeZIxyCIXqDYTQQd727TQJPGgYST7s7Ay/SgScvAsqT/Gp4eXZ08tFqE4x4qKx
	Xf5jGF27rUzWmA8jV6ahiUxJ5bsJLdk754WJC5YN3UBxWl66XlJ94
X-Google-Smtp-Source: AGHT+IGOZl/nBisuhQ6zD6jxD83U4XFWrPSRI4XTF0ONfj1DyW3nznVrpeMbXo6M+AY0O65iMMFktnvrm6rpep/W1WI=
X-Received: by 2002:a50:a6d7:0:b0:565:733d:2b30 with SMTP id
 f23-20020a50a6d7000000b00565733d2b30mr114515edc.4.1708767073364; Sat, 24 Feb
 2024 01:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com> <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 10:30:59 +0100
Message-ID: <CANn89iKB3ov_rthyscWn=h4yxmhReXAJzHu9+dOdpzPA8F=C-w@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:04=E2=80=AFAM Dmitry Safonov <dima@arista.com> w=
rote:
>
> Two reasons:
> 1. It's grown up enough
> 2. In order to not do header spaghetti by including
>    <trace/events/tcp.h>, which is necessary for TCP tracepoints.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Okay, but what about CONFIG_IPV6=3Dm ?

I do not see any EXPORT_SYMBOL() in this patch.

