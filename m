Return-Path: <netdev+bounces-183723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726CCA91AF7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D4B57AF736
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA123F406;
	Thu, 17 Apr 2025 11:32:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866A23956D;
	Thu, 17 Apr 2025 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889522; cv=none; b=iSHluGr9sTU2GccCatgxrqxvTueEM4oPmosg4DTfikdOm+LzQlSZe+un3M9egm3XP1t0Hn2C0lLpNPnUYVHhL7rJ5RFNchMA5PEL1vDHhTUQUDLcibuiVI0n60nckTo0VFbWyfDGoH2APw/H6cdPMRJ3WbLy+oywADTb01Cv7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889522; c=relaxed/simple;
	bh=CtN2uHgb1NyUBudgvvRWzNh1KaO46exRTxvJdTqFaPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY4en8m61j42xqjM2g4wT1Uc07O/avZTT0t/kOue2eJ2RZmZrQ6zmYM0nmwjg5tDJ6AS3ZSivJkSjQRLAzmCQcQHg2K3n3YKsBDU5dcEWWBN49KnFdNkpdn53xWRc5zBJ+xI/XhH4BGRMuU1h6UO4+BaR1InZ5OfnBi04V9CBGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso1074864a12.0;
        Thu, 17 Apr 2025 04:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744889519; x=1745494319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrCgsSPeTbv6ZtB0KQCzqyqRTg9cqGn94RPdFydJybE=;
        b=e5n1pPCEIFTgkLhxN0/CmRA+bx2nRT3g1wARyMeK5zpWrdhAqlteNGkwc8RcgYi+CP
         6LjhJDaGvAlg6Ge6+lz1Uhn0vfwGlxS4WwPAKhX/GsCrswc23U1ZQ2gtVD1fCUPekNS0
         WSMLMWxfNXQXO1FwcoaxQiybk94eG8cHcAefl0uWQ2Jsop5x3ZUVyfM0s6f5MhG+w//r
         J/Up3r2B06t6hTADroJ5S7dEBQVZ9TGNs65CnsL9GR4zP+VVAFGwuk5zqvHiX8+4357E
         vo5LgDbRb2iGEnw11HdQ+2Oophz1nSJ0f3ThfKPYZSwX/Ttm6ks71yCU7W1xlWZxy8NT
         MIEA==
X-Forwarded-Encrypted: i=1; AJvYcCXTXNJV/UQFeG6Ebhe5dRu6/Vvzd2WCy4mNKOFxFln91bkXP0l0su0+oHAIW1PYHMwz8aBDLqx6LULepLg=@vger.kernel.org, AJvYcCXZW/Bf+ElBFRWX6CMa29Wk8zjPDobFKOS5ZaNNoE8wz0Pfr2dcNASruMCDNCFr+GlGIqxD42+J@vger.kernel.org, AJvYcCXr/Sf3MdX9lBZGTnQlY9Wdd1cbAXzGfm2w637mc8ec5H/yhs9wHJx8D1Ib77c+Jq8J78cqQoIsIVudkJyExaxfEHXL@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpMLFMzTttE7TJpGGDHl5nCewbXvMnCXRgBBrJkKTD3ccXJFg
	p0dhEjcgDWRTxYhA60ELieV30l0O4NT4bToHFgNaWeeKtOG55rqY
X-Gm-Gg: ASbGnctmpqDWhitVgMYSc3GcU+gT8stsXAHHdytUVAzfN3YG3wl+QyYNwKinJhJLSe0
	V4T4J5JExZowp6k8cySbpPGZn3hYnjy1yPBQ69nK5/5QsYbgIUYpJd5pTi0hGxbbfUNvoCanbnA
	UWtIeivOWqUCnxQNyj5cHhtgU2Q74s+B7mtVTN9Me3rCPmy7hFhiJAv1dQQ4sAA1/a734COreIz
	gvS4MWzzKC6LNjoXvHFzuHhnBrXwyqrdAUQSmR5dFj26Gp9OgLThr/gfVGwAIogXB5uPsgUQ/Bw
	7wlhhYuD9LlnkdeKvfwweKxPmdsobem7WOjtg8sRDQ==
X-Google-Smtp-Source: AGHT+IGxA9Hf/ORmBiX3EsGsQ+lHUMmc7HAeGV3DKGvVn28b9CeYys7216ndWydAeCXQyTKeEGtb3g==
X-Received: by 2002:a05:6402:2387:b0:5f4:d22e:28c3 with SMTP id 4fb4d7f45d1cf-5f4d22e29a8mr1391178a12.4.1744889518572;
        Thu, 17 Apr 2025 04:31:58 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54fa9sm9886770a12.1.2025.04.17.04.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 04:31:58 -0700 (PDT)
Date: Thu, 17 Apr 2025 04:31:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, kuniyu@amazon.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev,
	song@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Message-ID: <aADmq6cGLe3yD9Qx@gmail.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <6800064ea440f_fc9d7294c4@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6800064ea440f_fc9d7294c4@willemb.c.googlers.com.notmuch>

Hello Willem,

On Wed, Apr 16, 2025 at 03:34:38PM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > Add a lightweight tracepoint to monitor UDP send message operations,
> > similar to the recently introduced tcp_sendmsg_locked() trace event in
> > commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> > tcp_sendmsg_locked()")
> > 
> > This implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> > creating extensive trace event infrastructure and exporting to tracefs,
> > keeping it minimal and efficient.
> > 
> > Since this patch creates a rawtracepoint, it can be accessed using
> > standard tracing tools like bpftrace:
> > 
> >     rawtracepoint:udp_sendmsg_tp {
> >         ...
> >     }
> 
> What does this enable beyond kfunc:udp_sendmsg?

A few things come to mind when evaluating the use of tracepoints.

One significant advantage is that tracepoints provide a stable API where
programs can hook into, making it easier for users to interact with key
functions.

However, kfunc/kprobes has some notable disadvantages. For instance,
partial or total inlining can cause hooks to fail, which is not ideal
and can lead to issues (mainly when we have partial inlines, and the
hook works _sometimes_).

In contrast, tracepoints create a more stable API for users to hook
into, eliminating the need to patch the kernel with noinline function
attributes. This solution may be ugly, but it is a common practice.
(and this is my main goal with it, remove `noinline` from our internal
kernel)

While tracepoints are not officially considered stable APIs, they tend
to be "more stable" in practice due to their deliberate and strategic
placement. As a result, they are less likely to get renamed or changed
frequently.

Additionally, tracepoints offer performance benefits, being faster than
both kfunc and kprobes. 

For further discussion on this topic, please refer to same discussion in
VFS:

https://lore.kernel.org/bpf/20250118033723.GV1977892@ZenIV/T/#m4c2fb2d904e839b34800daf8578dff0b9abd69a0

Thanks
--breno

