Return-Path: <netdev+bounces-169911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED273A4663F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A9F3B3404
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118021D585;
	Wed, 26 Feb 2025 16:10:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760721CFEA;
	Wed, 26 Feb 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586256; cv=none; b=b/xdPSy6zlKFls0Ef6k5wNLkad7KSi1uHxmywtOhpUO5VDBqYNpi0/pOSLDHMDwTTPyqMYVDadSTIAq+XI+hueRIU4b6C8NnKDl+jrPChIQSXudh9GE3ZGQLMJ/CM3HrI4iBu22fzVH1akMC8W7yhbxwJ62PvaGwMVwi+l8muVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586256; c=relaxed/simple;
	bh=NiH8SRXw2DXbtCKmXtL7dumfhM6oSyvlJXoK8NUJwS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF58IoizKlN/kIiGhLqD+UXEOEHQeckIWlaVSQ04aB+mY8RT6nhVaE7gKyLu3g9Z0v11YqoVqYqgDC2XpdY7owE8KlhDFS3WC9EAXG6fOUWT06KLlJEpvFsb6Djc+iT7IK8i79rdxy2W8YvScOPUwe3W45uvjXotxhaYsMGlD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so11196301a12.3;
        Wed, 26 Feb 2025 08:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586253; x=1741191053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdFq/RSQGllNMaaMkzzrwTZL0ht5WX0qvlwijavAzn4=;
        b=qclbH2EuBUYx8LYlp/Z9ZNEq3RnnGNkkYw1HrE2GNta0jjZv5QGWwhPW6TnXB3jAUB
         zfJRqqnJ2M9lS1wB/PP4YXxEUgc/asLeECiWd1yVgHHEzTRgxpoT2LKTY1LL/j1W0pgS
         ZfFniFZ0qWxRvitQyJ6ohohnd3dN8soaFot7r+sQT+/8QB/qRrpwGEPmtz1G95J1tLpF
         7tOXz2uKQcLEfP2GPodOR0DoEAaEj2to1vlSxbAF+67IKITPBSOK16oTeRiow9/IaWXh
         C432ckyqC+jKg0gvIWIylebX9u2gid/bJnwgzZ3nL8JbiHg/UvAhGK5+Oa+LC45BJ6G7
         ARNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUal/bnPxI+PGa4QfDRjLSourwJUANdmTQn0Llnfv1WFPHUoL6qFnKdrbj6bAzfe0wfEKzf9E07@vger.kernel.org, AJvYcCVv2X2iltq2d1tgjD2hIiCnS7al8h8sRbMM2sMqnC2fcp1zEeJIz2IwuO6EsDTCnfoaBjC9FaXKo24Jnrt4O0LnxNCx@vger.kernel.org, AJvYcCW25vYtNQ4IVVcA+4bwwkd4vlmgNyqVVhocvJsQqR5ybl0o6deEhZmqahyRgVpvUTsKS2b5Knaagm+qnOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCa66pf5z0Rg0dvVK6GDjGE6zuevt8tytrDuqlQi2c2YfbADY
	IzoVaceF/be4LX37vLIKk0rP0ALP9nFmSVQvhBSZP12Z956i6S9cQmmuzg==
X-Gm-Gg: ASbGncvBDbstiszZX7oJGZLW9bmjwrTsVexyCmDKlT1Oqebqoko0u2poDfMQtawxWrv
	7CYr7dmP87V9Kr0htsZi+mIF6dM0rt5xP4Fc3atxjOGZtDQlGG7zHwvmYPURjdQI3OokWbeR595
	E1aR/c7ysIpyXZcn/NSSlLOSjyrz+ncrX45Nx6hL8UMlwT1Pss5I36WQp19j8j/i7ty3VlrIwkz
	dGlX6yiB8EhWKkWtufzXIGQ8sYJsIpg0ZcLY4B6C7Q+DDe3LHcYlRkK+nsn8yHp8bgKCbou2x5b
	X9dx00ySDC8AQzMs
X-Google-Smtp-Source: AGHT+IHkM42/HOpoB5e04qARcXv0azFNm3lcPy13WbWpWbJWwaQKpfFqbOJx/CyYcNMJ21Tke9hjgQ==
X-Received: by 2002:a05:6402:4305:b0:5d4:1ac2:277f with SMTP id 4fb4d7f45d1cf-5e4a0d71fb1mr5146443a12.9.1740586253056;
        Wed, 26 Feb 2025 08:10:53 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e460ff8aa2sm2954375a12.56.2025.02.26.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:10:52 -0800 (PST)
Date: Wed, 26 Feb 2025 08:10:50 -0800
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Message-ID: <20250226-cunning-innocent-degu-d6c2fe@leitao>
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
 <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>

Hello David,

On Mon, Feb 24, 2025 at 12:16:04PM -0700, David Ahern wrote:
> On 2/24/25 12:03 PM, Eric Dumazet wrote:
> > On Mon, Feb 24, 2025 at 7:24 PM Breno Leitao <leitao@debian.org> wrote:
> >>
> >> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
> >> the tracing of TCP messages being sent.
> >>
> >> Meta has been using BPF programs to monitor this function for years,
> >> indicating significant interest in observing this important
> >> functionality. Adding a proper tracepoint provides a stable API for all
> >> users who need visibility into TCP message transmission.
> >>
> >> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
> >> creating unnecessary trace event infrastructure and tracefs exports,
> >> keeping the implementation minimal while stabilizing the API.
> >>
> >> Given that this patch creates a rawtracepoint, you could hook into it
> >> using regular tooling, like bpftrace, using regular rawtracepoint
> >> infrastructure, such as:
> >>
> >>         rawtracepoint:tcp_sendmsg_tp {
> >>                 ....
> >>         }
> > 
> > I would expect tcp_sendmsg() being stable enough ?
> > 
> > kprobe:tcp_sendmsg {
> > }
> 
> Also, if a tracepoint is added, inside of tcp_sendmsg_locked would cover
> more use cases (see kernel references to it).

Agree, this seems to provide more useful information

> We have a patch for a couple years now with a tracepoint inside the

Sorry, where do you have this patch? is it downstream?

> while (msg_data_left(msg)) {
> }
> 
> loop which is more useful than just entry to sendmsg.

Do you mean something like the following?

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 1a40c41ff8c30..23318e252d6b9 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -259,6 +259,11 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+DECLARE_TRACE(tcp_sendmsg_tp,
+	TP_PROTO(const struct sock *sk, const struct msghdr *msg, size_t size, ssize_t copied),
+	TP_ARGS(sk, msg, size, copied)
+);
+
 DECLARE_TRACE(tcp_cwnd_reduction_tp,
 	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
 		 int newly_lost, int flag),
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 08d73f17e8162..5fcef82275d4a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1290,6 +1290,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			sk_mem_charge(sk, copy);
 		}
 
+		trace_tcp_sendmsg_tp(sk, msg, size, copy);
+
 		if (!copied)
 			TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_PSH;
 

