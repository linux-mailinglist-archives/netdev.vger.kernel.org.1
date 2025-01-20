Return-Path: <netdev+bounces-159796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7224CA16EF4
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88F713A55A9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4A1E47BC;
	Mon, 20 Jan 2025 15:03:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB71E0DCD;
	Mon, 20 Jan 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385424; cv=none; b=pkaUgGY+1HoJGGiHecIt7ORkmwSAdm0viuWhOoUHGP/QohL+I2PKwGJReA0TtxARcib7LkLHXvj81uyZcFvCDk+1Bh56jnZRS1xWFeuKpE8hbNKKtgPio6w+GzQWp9HQK8gHGVfIeQjd6vIXlH/S/2NKeo+5fWBJT9kTguCyLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385424; c=relaxed/simple;
	bh=zJDrsnkuoWbFXC2m+uNTIrYe9ow3fcJl2J2ZXA9yydM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUQ1N7lpkvksXGZfIgEuU+hqx3JEjetUBAnPMYdeTcSwGcVa/uHS/Cqg4YGVUGpsl8TlUESTgC0L+c6CYnGN1LjXORXn+G20gSWCCIsbQy+zXsbzLPPXYV+jdcUd1iKM5taxSunwcgnbyg0HOw+xWhLKa1KkxftZM3VtkjSaCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179D6C4CEDD;
	Mon, 20 Jan 2025 15:03:41 +0000 (UTC)
Date: Mon, 20 Jan 2025 10:03:40 -0500
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
Message-ID: <20250120100340.4129eff7@batman.local.home>
In-Reply-To: <20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
References: <20250120-cwnd_tracepoint-v1-1-36b0e0d643fa@debian.org>
	<CAL+tcoC+A94uzaSZ+SKhV04=iDWrvUGEfxYJKYCF0ovqvyhfOg@mail.gmail.com>
	<20250120-panda-of-impressive-aptitude-2b714e@leitao>
	<CAL+tcoCzStjkEMdNw5ORYbQy3VnVE9A6aj6HcmQvGj3VG1VypA@mail.gmail.com>
	<20250120-daring-outstanding-jaguarundi-c8aaed@leitao>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jan 2025 05:20:05 -0800
Breno Leitao <leitao@debian.org> wrote:

> This patch enhances the API's stability by introducing a guaranteed hook
> point, allowing the compiler to make changes without disrupting the
> BPF program's functionality.

Instead of using a TRACE_EVENT() macro, you can use DECLARE_TRACE()
which will create the tracepoint in the kernel, but will not create a
trace event that is exported to the tracefs file system. Then BPF could
hook to it and it will still not be exposed as an user space API.

You can see its use in include/trace/events/sched.h

-- Steve

