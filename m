Return-Path: <netdev+bounces-160226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9881A18E82
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A533A592B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0D20FAB9;
	Wed, 22 Jan 2025 09:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43320FA8E;
	Wed, 22 Jan 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538790; cv=none; b=JZ6aY/Wq6hLKl/FgIgin2WlPTNme8SJMUfSMyQAk1cuNspyE6U/SFKPpMCPYhLAGSE4WkZYwbWSaVbsTjSijJeU9kw8ogX8toJJ8X/paDXzPZy+uNYEo2p3VLAtui+pD7e1eejqn/GTU5qXqPpmDpXEb8VwZ0YVHgkWdkA9MZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538790; c=relaxed/simple;
	bh=gaF4lX+QSvuwIW3B1fDcdth63Juyz4/dM6q+jb/YglI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RteaQld3o2H+vwfxjxLH8rq/tNPjHocqjvqPB2oJxCQMCV4zSKe9eEOLs2GhUHyxhMo9cx7Vgn+/PHl9DdUMKQ4aPZaE1GGSHYpA4PJ/0VWyAL0mc3zRwcEpZ6GReUeOwzu3OmBGTV25biUJYlSOM/cmdGgekosjNi0vkXVkJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso1363757a12.1;
        Wed, 22 Jan 2025 01:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737538787; x=1738143587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hRyr/LFB41D26kZ8C17Nz9XbLAXmLDU3xx1SDSHzNI=;
        b=GxQvWZyfXGehSkAXDPq9xG4E3nkQWB9ItZ5blyUvnlV2YZBQzoX6znvxnqbTVv49O/
         P28KMJWt/rRhoobMSjH+9uQmdsZD9DhedKnYwqVM031U9EOGSrTRVhhdnj0hUm3HN747
         cJMo/ifkKotRYMP3i51FZFWQPe6yQ2hGUji+NtDPWw3PpgGdcJT2E1MpLMN7BMX97pSN
         WOOmjpnmZE2WFKJrNWCEQAF//RS+Gxxy3Xd2fHgmLYx7tRKqUzhsc5LMEHV9Z7KdVEZF
         3rM7HJKflGn94vMzIH2Md5y20IMO5bQ88Ul/AwAI5A2/E0gUWxtst8kRJRdoy7Hgpv8G
         SR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVH6fX6cAF6WliGl7ZvypWoyw5Q+jd+IYzLjfVwLmOxnGbByBjhMLq66RGqgfA5rYDiRagMl6/pGfHPal4=@vger.kernel.org, AJvYcCVia050/oVy2/HRUJHi7wZ6CeWOAJyheto8QS6t6bibx8Zd8nqJSWjdyBqST7dEJ/77E3d9jsc1cXbfSMQYcj1gP3r5@vger.kernel.org, AJvYcCXRb8QQddHhUVeVnCh4cmlCkMgn3ZT/BVWgsu8gMavvaI5xm2hQeJJ0lzH3rG8cC44Qq+y8xU97@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxxId55Lo0u+5Aq3/pWR5Cxa8V8dNFdvctkQFRTKd61N5Cj6B
	n8OfDqSP+x8/iuomP0wJPwEEnBaa/EXhQjSTp880bixLbjV38Adt
X-Gm-Gg: ASbGncuC5/iu4hzuQjt16LCA5Y1sL+1ELWMP35LzDZVV1OyQTeLVi+clJoscs4kux/j
	b7Y3U7j3hu2IJCMA7XrXH/on74UOorEvZzOw2XZRALTHEUbolfMN7FrRHwQZKANlyqXgP1fZQnB
	ABlzWL98xENYBi4D+Nz0pQq3PcM5Z3TaA8//6eLnrfkh2LknmD/e10FZlpEYGCXoEz/cQeI8N8Y
	uOyIFs+Vd17/JFTfSINBpXC9xAOU+Dxn/vE/rzhMjF7XQtUQDopC8k3v+IuCg==
X-Google-Smtp-Source: AGHT+IFHaJzpuKeQuRURWE44dU3p/dEgmZ8Um4qL5KPgzg+tW2+xxJXc7DX8p+M5aNuBzD61ZKrFuA==
X-Received: by 2002:a05:6402:27cf:b0:5d0:ece3:158a with SMTP id 4fb4d7f45d1cf-5da0bac2db9mr27510461a12.3.1737538786782;
        Wed, 22 Jan 2025 01:39:46 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683d79sm8347757a12.37.2025.01.22.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 01:39:45 -0800 (PST)
Date: Wed, 22 Jan 2025 01:39:42 -0800
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250122-vengeful-myna-of-tranquility-f0f8cf@leitao>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
 <CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
 <20250120-panda-of-impressive-aptitude-2b714e@leitao>
 <CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
 <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
 <20250120100340.4129eff7@batman.local.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120100340.4129eff7@batman.local.home>

Hello Steven,

On Mon, Jan 20, 2025 at 10:03:40AM -0500, Steven Rostedt wrote:
> On Mon, 20 Jan 2025 05:20:05 -0800
> Breno Leitao <leitao@debian.org> wrote:
> 
> > This patch enhances the API's stability by introducing a guaranteed hook
> > point, allowing the compiler to make changes without disrupting the
> > BPF program's functionality.
> 
> Instead of using a TRACE_EVENT() macro, you can use DECLARE_TRACE()
> which will create the tracepoint in the kernel, but will not create a
> trace event that is exported to the tracefs file system. Then BPF could
> hook to it and it will still not be exposed as an user space API.

Right, DECLARE_TRACE would solve my current problem, but, a056a5bed7fa
("sched/debug: Export the newly added tracepoints") says "BPF doesn't
have infrastructure to access these bare tracepoints either.".

Does BPF know how to attach to this bare tracepointers now?

On the other side, it seems real tracepoints is getting more pervasive?
So, this current approach might be OK also?

	https://lore.kernel.org/bpf/20250118033723.GV1977892@ZenIV/T/#m4c2fb2d904e839b34800daf8578dff0b9abd69a0

> You can see its use in include/trace/events/sched.h

I suppose I need to export the tracepointer with
EXPORT_TRACEPOINT_SYMBOL_GPL(), right?

I am trying to hack something as the following, but, I struggled to hook
BPF into it.

Thank you!
--breno

Author: Breno Leitao <leitao@debian.org>
Date:   Fri Jan 17 09:26:22 2025 -0800

    trace: tcp: Add tracepoint for tcp_cwnd_reduction()
    
    Add a lightweight tracepoint to monitor TCP congestion window
    adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
    of:
      - TCP window size fluctuations
      - Active socket behavior
      - Congestion window reduction events
    
    Meta has been using BPF programs to monitor this function for years.
    Adding a proper tracepoint provides a stable API for all users who need
    to monitor TCP congestion window behavior.
    
    Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
    infrastructure and exporting to tracefs, keeping the implementation
    minimal. (Thanks Steven Rostedt)

    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a27c4b619dffd..07add3e20931a 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,11 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+DECLARE_TRACE(tcp_cwnd_reduction_tp,
+	TP_PROTO(const struct sock *sk, const int newly_acked_sacked,
+		 const int newly_lost, const int flag),
+	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag));
+
 #include <trace/events/net_probe_common.h>
 
 TRACE_EVENT(tcp_probe,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4811727b8a022..74cf8dbbedaa0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2710,6 +2710,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
 	if (newly_acked_sacked <= 0 || WARN_ON_ONCE(!tp->prior_cwnd))
 		return;
 
+	trace_tcp_cwnd_reduction_tp(sk, newly_acked_sacked, newly_lost, flag);
+
 	tp->prr_delivered += newly_acked_sacked;
 	if (delta < 0) {
 		u64 dividend = (u64)tp->snd_ssthresh * tp->prr_delivered +
@@ -2726,6 +2728,7 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int newly_lost,
 	sndcnt = max(sndcnt, (tp->prr_out ? 0 : 1));
 	tcp_snd_cwnd_set(tp, tcp_packets_in_flight(tp) + sndcnt);
 }
+EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_cwnd_reduction_tp);
 
 static inline void tcp_end_cwnd_reduction(struct sock *sk)
 {

