Return-Path: <netdev+bounces-106688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDB917456
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901012862DD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD917F378;
	Tue, 25 Jun 2024 22:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4546149C6E;
	Tue, 25 Jun 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355280; cv=none; b=p14PpSv11aKeNEshAudOqOdBrH+v3pl5M5EPa7qqlRDgW7Zw+QDbwiUPgPet5qnF78cHVkuVqjvcAy0pu0YHZ9J8NEwTgTtwvUjjUcptkw1xa85WHRZSC6dXjVT04Qwn9CBrSYT1k77FdInXr4snNV7ghzNzlsQeiIodfd4yII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355280; c=relaxed/simple;
	bh=P10SFpT0eNxOw5hUhPL1NK3ZPAbCn8W+gSCPpWkouHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqQ2pFkrt96GqUc/PqIGCg1txflaeF5oAyljLV/r1sJ32Qm5gKQaA/h1j5ZaohtqrdwYpfwSNnwX6JxtKC0H4Gx88MzxDfKO1Iaw3fFiP8/7syTk/nYEHg6OJztO3ps/yBsXtL9mJntvf76RVnmLMU15WlAxG+95pSatJ6tQq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B608FC32781;
	Tue, 25 Jun 2024 22:41:17 +0000 (UTC)
Date: Tue, 25 Jun 2024 18:41:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: yskelg@gmail.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Takashi Iwai <tiwai@suse.de>, "David S.
 Miller" <davem@davemloft.net>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Taehee Yoo <ap420073@gmail.com>, Austin Kim
 <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pbuk5246@gmail.com
Subject: Re: [PATCH] qdisc: fix NULL pointer dereference in
 perf_trace_qdisc_reset()
Message-ID: <20240625184116.6e05c529@rorschach.local.home>
In-Reply-To: <20240621114551.2061-3-yskelg@gmail.com>
References: <20240621114551.2061-3-yskelg@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2024 20:45:49 +0900
yskelg@gmail.com wrote:

> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index f1b5e816e7e5..170b51fbe47a 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -81,7 +81,7 @@ TRACE_EVENT(qdisc_reset,
>  	TP_ARGS(q),
> =20
>  	TP_STRUCT__entry(
> -		__string(	dev,		qdisc_dev(q)->name	)
> +		__string(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "noop_queue")

=46rom a tracing point of view:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  		__string(	kind,		q->ops->id		)
>  		__field(	u32,		parent			)
>  		__field(	u32,		handle			)

