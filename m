Return-Path: <netdev+bounces-160329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4353A1946A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989DC3AA26D
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A892144A5;
	Wed, 22 Jan 2025 14:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0C19C56C;
	Wed, 22 Jan 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737557762; cv=none; b=UGIUCsUPWsjNTs5rgeoEp8uxt1aTuQQCXaiWDf5K78zwIb8DEbLrLPxrqgVAVfbTFhbEzvutaYGgjCepRadPQPFtUpmcFFjFf7F4ZAZCAHiIrt6VpPrCj2Rcw7lqZ36j8belCZrsINC+KWJQgXjd0V30eWXqFkQeegsL8dRWNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737557762; c=relaxed/simple;
	bh=rvWlu+bKgz3ZewfcGUdmZW0sol8tRslku+B5BC3UbJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfcHR+n6MrudPQEtrmIEWzaOAcBu7ha1zHmFx1BFZTpVvhyaU1eyI0wdkXj293DRadRe0sJoAN1mDTnTFCXusp3unVnwEuRBngYImqhruiMexPKo8tZE5wrVUnT0zzvM7Jd1XGqjJilCB9d2u9yqfKD+Ij82gQ724optyYJg+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7DEC4CED3;
	Wed, 22 Jan 2025 14:55:59 +0000 (UTC)
Date: Wed, 22 Jan 2025 09:56:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Yonghong Song
 <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>
Subject: Re: [PATCH RFC net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250122095604.3c93bc93@gandalf.local.home>
In-Reply-To: <20250122-vengeful-myna-of-tranquility-f0f8cf@leitao>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
	<CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
	<20250120-panda-of-impressive-aptitude-2b714e@leitao>
	<CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
	<20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
	<20250120100340.4129eff7@batman.local.home>
	<20250122-vengeful-myna-of-tranquility-f0f8cf@leitao>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 01:39:42 -0800
Breno Leitao <leitao@debian.org> wrote:

> Right, DECLARE_TRACE would solve my current problem, but, a056a5bed7fa
> ("sched/debug: Export the newly added tracepoints") says "BPF doesn't
> have infrastructure to access these bare tracepoints either.".
> 
> Does BPF know how to attach to this bare tracepointers now?
> 
> On the other side, it seems real tracepoints is getting more pervasive?
> So, this current approach might be OK also?
> 
> 	https://lore.kernel.org/bpf/20250118033723.GV1977892@ZenIV/T/#m4c2fb2d904e839b34800daf8578dff0b9abd69a0

Thanks for the pointer. I didn't know this discussion was going on. I just
asked to attend if this gets accepted. I'm only a 6 hour drive from
Montreal anyway.

> 
> > You can see its use in include/trace/events/sched.h  
> 
> I suppose I need to export the tracepointer with
> EXPORT_TRACEPOINT_SYMBOL_GPL(), right?

For modules to use them directly, yes. But there's other ways too.

> 
> I am trying to hack something as the following, but, I struggled to hook
> BPF into it.

Maybe you can use the iterator to search for the tracepoint.

#include <linux/tracepoint.h>

static void fct(struct tracepoint *tp, void *priv)
{
	if (!tp->name || strcmp(tp->name, "<tracepoint_name>") != 0)
		return 0;

	// attach to tracepoint tp
}

[..]
	for_each_kernel_tracepoint(fct, NULL);

This is how LTTng hooks to tracepoints.

-- Steve


