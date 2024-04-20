Return-Path: <netdev+bounces-89781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827F8AB8CF
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 04:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1811C20CC7
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC85DF51;
	Sat, 20 Apr 2024 02:36:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF72DF44;
	Sat, 20 Apr 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580560; cv=none; b=MtGzIMuUQ8xPYu6CoUHzsQQhV3417gCX+2LHhzD4cFWB0psqeuI8Aqjuagm5uOUT5sX1VVxL8LPEV2VAO0CElJrZrdpCpyhkKOWrRhI1neXmqSI51+IaUJ1rQT/0TJqhBQI9Fk04zl/GRD3L0XpNtvZThM6ugL8nKAGtRUAyf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580560; c=relaxed/simple;
	bh=rebUQf/UKr8xUTovVhPoRr3DOOOrnUizU7UWCD3khKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILl5VDAEQDVJQvhUVFrndtPzhfSBW+lqjSwFmxsa5AGF0ArG6riS4Ydj3nNtALqBM4IoqtKv6FjZ8+/AFgZb7yxBMtbcrGpq7pC021zJETE4xkT+L34DQBmXzYOB/9neNJm4GDgfbJqdDpfcj9N3vVe1+HC7U5ChF7ga3UJ4I2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF88C32782;
	Sat, 20 Apr 2024 02:35:57 +0000 (UTC)
Date: Fri, 19 Apr 2024 22:35:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, atenart@kernel.org,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to
 detect
Message-ID: <20240419223553.49cb0628@rorschach.local.home>
In-Reply-To: <CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com>
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
	<CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
	<20240418084646.68713c42@kernel.org>
	<CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
	<CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
	<CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
	<CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
	<CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com>
	<CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
	<CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com>
	<CAL+tcoA_eU98hMoWA2UM2LD_fNp=geY0uUfc+4pDnbUCKK6=Ew@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 16:00:20 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> If other experts see this thread, please help me. I would appreciate
> it. I have strong interests and feel strong responsibility to
> implement something like this patch series. It can be very useful!!

I'm not a networking expert, but as I'm Cc'd and this is about tracing,
I'll jump in to see if I can help. Honestly, reading the thread, it
appears that you and Eric are talking past each other.

I believe Eric is concerned about losing the value of the enum. Enums
are types, and if you typecast them to another type, they lose the
previous type, and all the safety that goes with it.

Now, I do not really understand the problem trying to be solved here. I
understand how TCP works but I never looked into the implementation of
MPTCP.

You added this:

+static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
+{
+	return reason += RST_REASON_START;
+}

And used it for places like this:

@@ -309,8 +309,13 @@ static struct dst_entry *subflow_v4_route_req(const struct sock *sk,
 		return dst;
 
 	dst_release(dst);
-	if (!req->syncookie)
-		tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
+	if (!req->syncookie) {
+		struct mptcp_ext *mpext = mptcp_get_ext(skb);
+		enum sk_rst_reason reason;
+
+		reason = convert_mptcp_reason(mpext->reset_reason);
+		tcp_request_sock_ops.send_reset(sk, skb, reason);
+	}
 	return NULL;
 }

As I don't know this code or how MPTCP works, I do not understand the
above. It use to pass to send_reset() SK_RST_REASON_NOT_SPECIFIED. But
now it takes a "reset_reason" calls the "convert_mptcp_reason()" to get
back a enum value.

If you are mapping the reset_reason to enum sk_rst_reason, why not do
it via a real conversion instead of this fragile arithmetic between the two
values?

static inline enum sk_rst_reason convert_mptcp_reason(u32 reason)
{
	switch(reason) {
	case 0: return SK_RST_REASON_MPTCP_RST_EUNSPEC;
	case 1: return SK_RST_REASON_MPTCP_RST_EMPTCP;
	case 2: return SK_RST_REASON_MPTCP_RST_ERESOURCE;
	[..]
	default: return SK_RST_REASON_MAX; // or some other error value
	]
}

I'm not sure if this is any better, but it's not doing any casting and
it's easier to understand. It's a simple mapping between the reason and
the enum and there's no inherit dependency between the values. Could
possibly create enums for the reason numbers and replace the hard coded
values with them.

That way that helper function is at least doing a real conversion of
one type to another.

But like I said from the beginning. I don't understand the details here
and have not spent the time to dig deeper. I just read the thread and I
agree with Eric that the arithmetic conversion of reason to an enum
looks fragile at best and buggy at worst.

-- Steve

