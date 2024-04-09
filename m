Return-Path: <netdev+bounces-86204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B489E01D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B00B3699C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C1136664;
	Tue,  9 Apr 2024 15:36:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A30A135A67;
	Tue,  9 Apr 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676974; cv=none; b=GXGRlSRbVKerSDrf91RfUTm0sesZn5ChDuFXPjrf4ZYhm1caeBrC1VE6vrujVBcFXZuTEtJ0wGyHW9gWWUeMm6rvRPuiiElIFNuKX2GXODDx5Ts9WilPOOZHHwyIfBWv04A4LmTLDdhYIDhJiZyx5S34CiKVAWJDXfD7+oum+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676974; c=relaxed/simple;
	bh=ZllP92/rBztqSQFwtsA/VIM+vevUvKCza45kq5uSvXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNxjKP0tDV2jEFDcRCZYNHgVLwy9krwJw2CXB6kxu2l8BTxnd9Zm0Rv4logCQxAUIgNPTznseTKgaYNtN38HZTtgeJCgxYFdXnlSRdDHvDk94qwN1cra8DhbYduPOwQ7ccxBCOesL7c6YG8nxrpoHKYs/5JRY1rujbQ3JaZcOP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75864C433C7;
	Tue,  9 Apr 2024 15:36:12 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:38:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, mptcp@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 6/6] rstreason: make it work in trace world
Message-ID: <20240409113846.5559359a@gandalf.local.home>
In-Reply-To: <20240409100934.37725-7-kerneljasonxing@gmail.com>
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
	<20240409100934.37725-7-kerneljasonxing@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 18:09:34 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

>  /*
>   * tcp event with arguments sk and skb
> @@ -74,20 +75,38 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
>  	TP_ARGS(sk, skb)
>  );
>  
> +#undef FN1
> +#define FN1(reason)	TRACE_DEFINE_ENUM(SK_RST_REASON_##reason);
> +#undef FN2
> +#define FN2(reason)	TRACE_DEFINE_ENUM(SKB_DROP_REASON_##reason);
> +DEFINE_RST_REASON(FN1, FN1)

Interesting. I've never seen the passing of the internal macros to the main
macro before. I see that you are using it for handling both the
SK_RST_REASON and the SK_DROP_REASON.

> +
> +#undef FN1
> +#undef FNe1
> +#define FN1(reason)	{ SK_RST_REASON_##reason, #reason },
> +#define FNe1(reason)	{ SK_RST_REASON_##reason, #reason }
> +
> +#undef FN2
> +#undef FNe2
> +#define FN2(reason)	{ SKB_DROP_REASON_##reason, #reason },
> +#define FNe2(reason)	{ SKB_DROP_REASON_##reason, #reason }

Anyway, from a tracing point of view, as it looks like it would work
(I haven't tested it).

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

