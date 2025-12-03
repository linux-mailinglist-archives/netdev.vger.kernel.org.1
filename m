Return-Path: <netdev+bounces-243414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 009DCC9F61E
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D7CDC3001BFD
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65A306497;
	Wed,  3 Dec 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0X5tPsY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F14306484
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773781; cv=none; b=B1xAbWZqVeEbPuPj6z9jjvPmrQBTkvvvHMbSHgNaPGgElApHwTr8BnP1GHeTx1EEVE2dQcP93y2uTJfXaH8ZJoFrZMns80zubHM4eGWfDryWNu86lQnXbVm3WDn4KDXMY/Sxzzb0zqU8Etv8hsDOwDrHbAl2F027FqSRsntMCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773781; c=relaxed/simple;
	bh=Sdmj+/pJ+nLkLaviE2J8S8mxqxK7tULeh2R05cZtdSA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ab4trMXeKySBu+he74cmz1eh3HyePTGuzVg3+Oft4BONXnhlzXYU7Z6PFTmQUGM6wGZLTRah2DHxWkTfUOew1cO++gtKz7h9ZFTDFU7Si7Mw+1RjilvrqqZddzjZmS2opQFxg4qOHkFOttNe8Wrc3ycnPIY+FQ/7F5kPvEwubjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0X5tPsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7921C116C6;
	Wed,  3 Dec 2025 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773781;
	bh=Sdmj+/pJ+nLkLaviE2J8S8mxqxK7tULeh2R05cZtdSA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=T0X5tPsYN9aSkO9gEliGGUwOsD5um4pEhG9kXzkL5lzjiJ7Hs9f8MQnlq6WQ54Etx
	 bD1UV+J/xfUk+x/Wcv3LpPqoJtP8PWAAyqebdXcLbGnXoau1J9Nic91Tv+w3P48RxS
	 BUvvhh+1kKCF5lrusjq+Mt5FW17O+boBAoy1g/txPomt1IP+oUbBh36Cw7C4XDQOIs
	 23lzW0Z1OzNdm9WSaS0Zme4bQjmxwTBo8Cgwmo9AwDAjBc7J/aLuXloaSXZJ06LN3l
	 C/v1R19G0LIIJ+TxBsZ0HFj8z1/2Yu5x9ke48zXpWCAZ151lh8v7ieIhaQXlbL99RO
	 PJn1uJeKpsx1A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DC769F4006C;
	Wed,  3 Dec 2025 09:56:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 03 Dec 2025 09:56:19 -0500
X-ME-Sender: <xms:k08waW_51DZuHSb6ssGYV8X7D40GA-I4JC_byHmv_bL3EsF5JZIvVg>
    <xme:k08waRjCqsCHLAp3dfbU6SrFwmuQGbzeKuA_5SifJeVmMzNHwSxvqK5qKadWz1Tam
    UR-FbTWIVlB8V3DIR9npHospF-GdiaIn4Hd6_2YXhoO9ePvUScky524>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdevhhhutghkucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdr
    ohhrgheqnecuggftrfgrthhtvghrnhephfffkefffedtgfehieevkeduuefhvdejvdefvd
    euuddvgeelkeegtefgudfhfeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlheppehkvghr
    nhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegtrghophhinhhgsegtmhhsshdrtghhihhn
    rghmohgsihhlvgdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrd
    hnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtlhhsqdhhrghnughshhgrkhgv
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrh
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:k08waY_A_xzk3kM5P8ytwYtpZnCWRaI6PQf8eW8b0iO41_p5X1fbIQ>
    <xmx:k08wadRdhR2WQ81EdqgQ7W2VMgDevEVRQVXaOM-dxznnd6wVXcm4kg>
    <xmx:k08waSekKy9QTMSPprUKMRmy130QLzZFuD46aKxM_WY6SxSTUHlUNQ>
    <xmx:k08wafTveKFAhlQVsT3UdGOn0OKkByrzf2PqYxjYQVR4vGyI7ttlBw>
    <xmx:k08waeI6IZFG_V2291D9pezZVu-PaGVaoyjeyoF7DjiiHPcSrOLlrb6x>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BF80F780054; Wed,  3 Dec 2025 09:56:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aidyn3_a5KKc
Date: Wed, 03 Dec 2025 09:55:58 -0500
From: "Chuck Lever" <cel@kernel.org>
To: caoping <caoping@cmss.chinamobile.com>,
 "Chuck Lever" <chuck.lever@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org
Message-Id: <fe675ba1-4711-4c79-8929-f7cc90aea4ad@app.fastmail.com>
In-Reply-To: <20251203041250.967606-1-caoping@cmss.chinamobile.com>
References: <20251203041250.967606-1-caoping@cmss.chinamobile.com>
Subject: Re: [PATCH] net/handshake: restore destructor on submit failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 2, 2025, at 11:12 PM, caoping wrote:
> handshake_req_submit() replaces sk->sk_destruct but never restores it when
> submission fails before the request is hashed. handshake_sk_destruct() then
> returns early and the original destructor never runs, leaking the socket.
> Restore sk_destruct on the error path.
>
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for 
> handling handshake requests")
>
> Signed-off-by: caoping <caoping@cmss.chinamobile.com>
> ---
>  net/handshake/request.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/handshake/request.c b/net/handshake/request.c
> index 274d2c89b6b2..89435ed755cd 100644
> --- a/net/handshake/request.c
> +++ b/net/handshake/request.c
> @@ -276,6 +276,8 @@ int handshake_req_submit(struct socket *sock, 
> struct handshake_req *req,
>  out_unlock:
>  	spin_unlock(&hn->hn_lock);
>  out_err:
> +	/* Restore original destructor so socket teardown still runs on 
> failure */
> +	req->hr_sk->sk_destruct = req->hr_odestruct;
>  	trace_handshake_submit_err(net, req, req->hr_sk, ret);
>  	handshake_req_destroy(req);
>  	return ret;
>
> base-commit: 4a26e7032d7d57c998598c08a034872d6f0d3945
> -- 
> 2.47.3

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Consider adding a Cc: stable@vger.kernel.org when applying.


-- 
Chuck Lever

