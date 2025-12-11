Return-Path: <netdev+bounces-244395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A104CB63A6
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14912300EA26
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12D279DA6;
	Thu, 11 Dec 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw5ddyNH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4141C71;
	Thu, 11 Dec 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765463814; cv=none; b=fdUYQ5x4GF0RkM1nt8n4ir6kfe6R32PYvHvpQ95q0Miso3usH//r1PsrxIgWrvp1T+Y1LmXUE5yVB5/WCj0ZfWnwJ3mh0TSK5S2mG8JRLwJ+S3IH+L+6lKRM8Wxk/WsRAltUXLsf4zRoNnyiaEL9g1npzGxltAiuyZZbsgOPTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765463814; c=relaxed/simple;
	bh=ISs7rIFnpXZ7va3u8+WnalslXIivwIWI2O48OAtFi1E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qo/Vail8ZQbAqomvO2Ywt/9SCpolrSLPTFHs5LXu4HN4eQ7Ni7vRBi9vC7uMFy9XlNK0Rv2Zm15eN0LngAGi0ILqDobRQlo6RWIg2GT591FC7jD2l5fe3DQKum4MEGCMeCalCfYqrg2t//Z1no4+FrbzxmzSrr5/ua6FcJzceLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw5ddyNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87525C113D0;
	Thu, 11 Dec 2025 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765463813;
	bh=ISs7rIFnpXZ7va3u8+WnalslXIivwIWI2O48OAtFi1E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Gw5ddyNHaPhQHkl+stw8w/0qPrUNAY4wjsOPcNJidnQ7LaugA97gHBFHeIQzPiPF7
	 J0uJQ/Wp4CaplWjyETfYlvwxAvw1kUXdwGtXpoUS77MeRdbLWtnctMJzELpI7dd4Dd
	 TN+DN05vb0TlnHDDvPxaLugNZPM5bC3f/Sii0cdOVne1FsGs5djmr+Y33yCPaBIAO0
	 JHmpuQ3vfyRufIJXMl3a6/JSK63wjYLSWpGZHo4uQ0rR8EM8ZL4LDHRteKM9hLLfuc
	 QDAWaB6x3xqxuydVUugWVnhB5E0o6DshETl+9zjF/wuLgk0cTqdPHBeoB0tnuqIdMC
	 opzP6KJvSGy4Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 90BC2F4006A;
	Thu, 11 Dec 2025 09:36:52 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 11 Dec 2025 09:36:52 -0500
X-ME-Sender: <xms:BNc6aaZZBdHjGF49i2V8fzs-p0DBqSMgBc9wLWHsZnY79pV3cBPhbg>
    <xme:BNc6aYMjaULxjhRFtX_GZctkhwnSlKExFSoI5LKPFqndpzgJnsfTpcaudObtzCMTQ
    ms4kvOIFBtXX85_3VVzamHaBYSjtuSXvtxU6CR7Hos1RgUI20erRXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:BNc6aVABD3O9yn01yyuYNACTfURImijeYWt_WhEXgdAzny6Prmzdag>
    <xmx:BNc6ae-851xkdYTEYkkoeZPRjHAudUGLLAvoTk5XdwvR_2El6Bimsw>
    <xmx:BNc6aUE_qbh1kZ-8_C2CYr-hBjarSca6S2uEVi3URmJplX3Xsp66vA>
    <xmx:BNc6aUM7_XeaZHYlwDpkfw_leecjXfJrfgco_OYMb_wjv0bwYI7_Ug>
    <xmx:BNc6aWcA5_gQhWs4pasNl7PuCSzrR89yPoO_eWSm8OJufmu2fYStJNdT>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 70086780054; Thu, 11 Dec 2025 09:36:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZv7QDKcY8dk
Date: Thu, 11 Dec 2025 09:36:32 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Scott Mayhew" <smayhew@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Message-Id: <2f0872f4-f92c-4364-bd7b-fc4826a86f35@app.fastmail.com>
In-Reply-To: <20251209193015.3032058-1-smayhew@redhat.com>
References: <20251209193015.3032058-1-smayhew@redhat.com>
Subject: Re: [PATCH] net/handshake: duplicate handshake cancellations leak socket
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 9, 2025, at 2:30 PM, Scott Mayhew wrote:
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
> Add a test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED) in the pending cancel
> path so duplicate cancels can be detected.
>
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for 
> handling handshake requests")
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  net/handshake/request.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..f78091680bca 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -324,7 +324,11 @@ bool handshake_req_cancel(struct sock *sk)
> 
>  	hn = handshake_pernet(net);
>  	if (hn && remove_pending(hn, req)) {
> -		/* Request hadn't been accepted */
> +		/* Request hadn't been accepted - mark cancelled */
> +		if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
> +			trace_handshake_cancel_busy(net, req, sk);
> +			return false;
> +		}
>  		goto out_true;
>  	}
>  	if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
> -- 
> 2.51.0

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

