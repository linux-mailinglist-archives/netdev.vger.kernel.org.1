Return-Path: <netdev+bounces-243914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F89CAA8F7
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41CC0305130B
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F128468B;
	Sat,  6 Dec 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdNYSTZ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790D3B8D48;
	Sat,  6 Dec 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765033945; cv=none; b=dRmiqO+6Gz5sXriafXWMPYDipdSyePjTm+IHWptZWNqZ/g2JoRPvpYvBgtV+yB25ow4CHmTH1cARmEg1R1VsQAFfxY4Q0A4qG8dcatJB186BI5YLqUSCmW8mjp5dd5XNRBaqg8r5S11JTY3e2o754SzPuYuTaCbKrJVcAI6Xo1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765033945; c=relaxed/simple;
	bh=heCjDJaK/8yYZnizxFi58MmiCDcbuYi5+RI8fl2EFZI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LwZv1rrALJKawJ6zkA8qPAJIiOs10TgoJXuI2uG0DdlRkq/U0ZK1FVChK1mIoZd9HgS6GPrroAH+WErhhwnVJ7MhihtdAfAlBKMDCF7Ww1ViZRQ6ExOPNrZ9porzpDRH3xtoM/wSHCCin5xlhs97NOcqDbb5ylbJPYmp4zxesY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdNYSTZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC4CC116B1;
	Sat,  6 Dec 2025 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765033944;
	bh=heCjDJaK/8yYZnizxFi58MmiCDcbuYi5+RI8fl2EFZI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DdNYSTZ4v7mpgljzBNgEfEDtUXrhurWzglRn/i7Wf3KE0vuWdJLvKBkmwgUPwHR4v
	 ZUutk3vx0+kAU9XHW/7GGPEDMWiuMeeXYD4hm7VwDk4U4sfhXdjTe5JNqY1Zw6sV3Z
	 EgjohB9H5OiwhZ6SdA5CxQ/RJNZVpP5art50WE867ioZHlkDMuOKPYtKjvSHxbM00L
	 38rVXWFGa4mv9MEjE8JwuTtNbwODeeC7Lidyoio1JAGPpLJCKGw0MJv/6ApRSOTdRk
	 aHSaa7A7Z3JpKYmngfZd4TRTe7H6IRk0hc4eXxOsqnI4+jOknOR81uhl8ahXkSvqYu
	 T88nJcL1tjXzA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B282F4007A;
	Sat,  6 Dec 2025 10:12:22 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 06 Dec 2025 10:12:22 -0500
X-ME-Sender: <xms:1kc0aVJpCDyJK4iH90Nh2U0dQwXR5he14IlfZPP_qjB6CnpMpUT9Qg>
    <xme:1kc0ab9XWy19bm8uCETN_BvvGFLh14ZtMcj6iCcTHUC8zHhjdWqZ9CryoDmuacBbs
    4g0XO-aqTxRNCmCzi4IrFTVhQMVsyry1FTtN7FafyrZHsXy89tE2vRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkvghrnhgvlhdqthhlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugi
    druggvvhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehsmhgrhihhvgifsehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvg
    htuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1kc0aRx8QT32xeVT1_X69bf6KvlgWR8ANXNdOLNV_BfnONWrmtdu9Q>
    <xmx:1kc0actNyerePgSXQIs1akqJihrwYaivTwx0B6bfFD80no8kELtKkQ>
    <xmx:1kc0ae2UqRxJOsBvyN610esArqklNPeC5GzHmBzgsXQh8VjnrArSGQ>
    <xmx:1kc0aX89qnuzoo7JTio7yM02WaoC0YAyazIL53lKGVQQmH-588FdtQ>
    <xmx:1kc0afPb4hAowOQIYPVbkzCxGRhOURpkg87lrqENxj1q6H6X0rKRv4Dc>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7A617780054; Sat,  6 Dec 2025 10:12:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKAJIIlgov-V
Date: Sat, 06 Dec 2025 10:12:02 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Message-Id: <938c82cd-9760-42e5-b0ce-123c86710782@app.fastmail.com>
In-Reply-To: <20251206143006.2493798-1-smayhew@redhat.com>
References: <20251206143006.2493798-1-smayhew@redhat.com>
Subject: Re: [PATCH] net/handshake: a handshake can only be cancelled once
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Dec 6, 2025, at 9:30 AM, Scott Mayhew wrote:
> When a handshake request is cancelled it is removed from the
> handshake_net->hn_requests list, but it is still present in the
> handshake_rhashtbl until it is destroyed.
>
> If a second cancellation request arrives for the same handshake request,
> then remove_pending() will return false... and assuming
> HANDSHAKE_F_REQ_COMPLETED isn't set in req->hr_flags, we'll continue
> processing through the out_true label, where we put another reference on
> the sock and a refcount underflow occurs.
>
> This can happen for example if a handshake times out - particularly if
> the SUNRPC client sends the AUTH_TLS probe to the server but doesn't
> follow it up with the ClientHello due to a problem with tlshd.  When the
> timeout is hit on the server, the server will send a FIN, which triggers
> a cancellation request via xs_reset_transport().  When the timeout is
> hit on the client, another cancellation request happens via
> xs_tls_handshake_sync().
>
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for 
> handling handshake requests")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  net/handshake/request.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..c7b20d167a55 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -333,6 +333,10 @@ bool handshake_req_cancel(struct sock *sk)
>  		return false;
>  	}
> 
> +	/* Duplicate cancellation request */
> +	trace_handshake_cancel_none(net, req, sk);
> +	return false;
> +
>  out_true:
>  	trace_handshake_cancel(net, req, sk);
> 
> -- 
> 2.51.0

To help support engineers find this patch, I recommend using
"net/handshake: duplicate handshake cancellations leak socket" as
the short description.

The proposed solution might introduce a socket reference leak:

1. Request submitted: sock_hold() called (line 271)
2. Request accepted by daemon via handshake_req_next()
   (removes from pending list)
3. Cancel called:
  - remove_pending() returns FALSE (not in pending list)
  - test_and_set_bit() returns FALSE (sets the bit now)
  - With patch: returns FALSE, sock_put() NOT called
4. handshake_complete() called: bit already set, skips sock_put()

What if we use test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED) in the
pending cancel path so duplicate cancels can be detected?

Instead of:

        if (hn && remove_pending(hn, req)) {
                /* Request hadn't been accepted */
                goto out_true;
        }

go with this bit of untested code:

        if (hn && remove_pending(hn, req)) {
                /* Request hadn't been accepted - mark cancelled */
                if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
                        trace_handshake_cancel_busy(net, req, sk);
                        return false;
                }
                goto out_true;
        }

-- 
Chuck Lever

