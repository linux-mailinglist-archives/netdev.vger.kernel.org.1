Return-Path: <netdev+bounces-273441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHC6HiIsy2n8EQYAu9opvQ
	(envelope-from <netdev+bounces-273441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6208363433
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 04:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F8543025299
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA93363C64;
	Tue, 31 Mar 2026 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGTOP1SN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7E20B810;
	Tue, 31 Mar 2026 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774922783; cv=none; b=jqg5rPwtMIyu2N/586DZPLFF4JrP6ZitT+OuiYtW2HzNWzeoEfu/9W+gttoOwoq309OrfoyL8bL+ks4XZie9OkopStviPpfgg/6Xrh5dpTWqfmJcTFK1ZqXuYNnQhWS3FQYRKENxbw208AzOTskcBfNaHTNi0w3/1pGHnZJFUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774922783; c=relaxed/simple;
	bh=SVPYs7PznDPtK6QGOFCjbzGaVuJ6yTrkjur9T3T0Toc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XNVR2c1ITxjOfQyf8dgb2J/Ivx4gwSwffo+DOtYRGv+uYWIwWiW0daxHZ+nOnc9w/X3xWqGvF9wgcB+43QiI64kwPQdcXa3vTDeRIAoo/qLjXT/9jLYL+A4/L4zcdRmk4Abi1EusP1y7fIDbLksMqhBTq27H/5zKHLfGquDV0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGTOP1SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB2DC4CEF7;
	Tue, 31 Mar 2026 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774922783;
	bh=SVPYs7PznDPtK6QGOFCjbzGaVuJ6yTrkjur9T3T0Toc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iGTOP1SNggvuWflFMYKEG8OWUEFhVcrcDlM6dCPfOCMgKA1q+RmgMc7x6HPpzaRcF
	 4mFlO5rhLzcekl886kG22phVG2Too/rM5OroKk9gkA3WTJcUni7vhpyTk3CriKE2g5
	 /J0ucpnr2UOcvyUaS7on2jcb+5nkq0RFrmmanxK7GeFS1l0RR2P9TO0swoNTEC0WHU
	 iGca3+oZ7OGVQpQNtm9wx9HeG65hrr8WypCRsajiBm4JapHaNgjkPnkak3ANEwOU6T
	 5JW5jehJU6p/OJnEb/gxhfU5EBtpJZX8qVb9dWpuAJf6m+KDovDK6iajPrv2EUh4Rk
	 d4lM1zPT2VFPQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0CD43F40078;
	Mon, 30 Mar 2026 22:06:22 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 22:06:22 -0400
X-ME-Sender: <xms:HSzLaZF83MyqK5bSCesxABdJCnXeOrrzSRlpllM4cO5QlIRHemMB9g>
    <xme:HSzLaZIjBsHtkKGLgziE3oynMflJG8wl1pfeD5DjC54aZ7atsF4X77CvtkWLIpmuM
    _HcuAmVfM1bkKPKqeq5Pz1vrfMGXz-PeosLXEahcuJG0r2upG1xcoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthhlshdq
    hhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegthh
    hutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsugesqhhuvggr
    shihshhnrghilhdrnhgvthdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomh
X-ME-Proxy: <xmx:HSzLaZlc_2zmMJKXj85UacGOmHw8r44VkI0gzt2kLgRxRYWOsF_7iA>
    <xmx:HizLaQ3hr8FO9JWp61wxFNSDFRS8mbL-rwtdLrHhEffiEvBuCUdCUQ>
    <xmx:HizLaR3R07xEhTNcYjUWhJ1Iqd9hr-7pyv0Yo-uQCiE2VnKLGd4DXA>
    <xmx:HizLaar3f9M8mp1bgs7jWekaPumZzzmj2YlF4snL5PwZoeuWoirt_w>
    <xmx:HizLaVgE1UnexfKvx61DJWHpdfviY5EY6aMAsCvvVAusA-c_U72lJ3xq>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE5C7780070; Mon, 30 Mar 2026 22:06:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUjyVK6KVs--
Date: Mon, 30 Mar 2026 22:06:01 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: john.fastabend@gmail.com, "Jakub Kicinski" <kuba@kernel.org>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Hannes Reinecke" <hare@suse.de>
Message-Id: <dba824ff-d3e5-4a7e-9e2f-5c0017473390@app.fastmail.com>
In-Reply-To: <acqMIKWFmx6B1lD8@krikkit>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
 <20260328-tls-read-sock-v7-4-15678415dfc1@oracle.com>
 <acqMIKWFmx6B1lD8@krikkit>
Subject: Re: [PATCH net-next v7 4/5] tls: Suppress spurious saved_data_ready on all
 receive paths
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,oracle.com,wdc.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273441-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.822];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6208363433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, Mar 30, 2026, at 10:43 AM, Sabrina Dubroca wrote:
> 2026-03-28, 11:17:11 -0400, Chuck Lever wrote:
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 5fdd43a55f1e..8fb2f2a93846 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -1373,7 +1373,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_pso=
ck *psock, bool nonblock,
>>  			return ret;
>> =20
>>  		if (!skb_queue_empty(&sk->sk_receive_queue)) {
>> -			tls_strp_check_rcv(&ctx->strp);
>> +			/* Defer notification to the exit point;
>> +			 * this thread will consume the record
>> +			 * directly.
>> +			 */
>
> That's a really nice improvement over the comment you had here
> before. Thanks.
>
>> +			tls_strp_check_rcv(&ctx->strp, false);
>>  			if (tls_strp_msg_ready(ctx))
>>  				break;
>>  		}
>
> [...]
>> @@ -2142,7 +2146,7 @@ int tls_sw_recvmsg(struct sock *sk,
>>  		err =3D tls_record_content_type(msg, tls_msg(darg.skb), &control);
>>  		if (err <=3D 0) {
>>  			DEBUG_NET_WARN_ON_ONCE(darg.zc);
>> -			tls_rx_rec_done(ctx);
>> +			tls_rx_rec_release(ctx);
>>  put_on_rx_list_err:
>>  			__skb_queue_tail(&ctx->rx_list, darg.skb);
>>  			goto recv_end;
>> @@ -2156,7 +2160,8 @@ int tls_sw_recvmsg(struct sock *sk,
>>  		/* TLS 1.3 may have updated the length by more than overhead */
>>  		rxm =3D strp_msg(darg.skb);
>>  		chunk =3D rxm->full_len;
>> -		tls_rx_rec_done(ctx);
>> +		tls_rx_rec_release(ctx);
>> +		tls_strp_check_rcv(&ctx->strp, false);
>
> Not strictly an objection against your patch, but after those changes,
> calling tls_strp_check_rcv() at this point in tls_sw_recvmsg() is
> starting to look like a leftover from the transition from generic strp
> to custom strp. We're not going to do anything with the next record
> until we call tls_rx_rec_wait(), so it seems it would fit better
> before the loop in tls_rx_rec_wait().
>
>
> [...]
>> @@ -2290,7 +2296,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,=
  loff_t *ppos,
>>  		if (err < 0)
>>  			goto splice_read_end;
>> =20
>> -		tls_rx_rec_done(ctx);
>> +		tls_rx_rec_release(ctx);
>>  		skb =3D darg.skb;
>>  	}
>> =20
>> @@ -2317,6 +2323,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,=
  loff_t *ppos,
>>  	consume_skb(skb);
>> =20
>>  splice_read_end:
>> +	tls_strp_check_rcv(&ctx->strp, true);
>
> This is in effect adding a
>
> if (strp->msg_ready)
>     tls_rx_msg_ready(strp);
>
> [a bit more than that]
> in case we dequeue from the rx_list but don't use the record (or only
> part of it).
>
> I wonder if that should be seen as a problem (another spurious wakeup)
> or an improvement (wake up because there's data ready)? Or if we
> should wake up anyway if we exit with rx_list non-empty, regardless or
> the parser's state, since there is data to read (tls_sk_poll looks at
> both rx_list and msg_ready).
>
> [this applies to all 3 RX functions, but this one is the simplest,
> which makes it more visible]
>
>>  	tls_rx_reader_unlock(sk, ctx);
>>  	return copied ? : err;
>> =20
>> @@ -2382,7 +2389,7 @@ int tls_sw_read_sock(struct sock *sk, read_desc=
riptor_t *desc,
>>  			tlm =3D tls_msg(skb);
>>  			decrypted +=3D rxm->full_len;
>> =20
>> -			tls_rx_rec_done(ctx);
>> +			tls_rx_rec_release(ctx);
>
> With this, there's no tls_strp_check_rcv() call inside the
> tls_sw_read_sock() loop, so in the next iteration, tls_rx_rec_wait()
> will have to go for at least one round of its own loop. [this points
> back to the recvmsg comment above, and a bit to the "cold path"
> discussion we had earlier]

All three points are really the same architectural question:
where should the parse-next-record step live -- eagerly inline
after release, or lazily in tls_rx_rec_wait()? And when a record
is already parsed at function exit, should the wakeup be
considered spurious or useful?

I=E2=80=99d like to try to help answer those questions. I set up loopback
NFS-over-TLS on a 10-CPU test system running these patches with
patches that replace recvmsg in NFSD with read_sock. I profiled
the server-side receive path with perf under several fio write
workloads. The backing store is tmpfs, so disk I/O is not a factor.

At 1M block size with a single fio job (540 IOPS, 540 MiB/s),
AES-GCM decryption dominates at 49% of cycles. The TLS record
parsing functions (tls_strp_check_rcv, tls_rx_rec_wait,
tls_strp_msg_release) do not appear above the 0.5% threshold.

At 4k block size with 8 jobs over a single connection (29K
IOPS, 113 MiB/s), AES-GCM drops to 5% and mutex contention
on the socket lock rises to 6.4%. tls_strp_check_rcv and
tls_rx_rec_wait each account for 0.05%.

At 4k block size with 32 jobs over nconnect=3D8 (87K IOPS,
339 MiB/s), mutex contention drops to 0.75% as the load
spreads across eight TLS connections. tls_strp_check_rcv
rises to 0.14% and tls_rx_rec_wait to 0.12%. The profile
is broadly distributed across NFS compound processing, XDR
encode/decode, credential handling, TCP transmit, and memory
allocation.

Across all three workloads the total cost of the functions
reorganized by patch 4/5 -- tls_strp_check_rcv,
tls_strp_msg_release, tls_rx_rec_wait, and tls_rx_msg_ready
-- stays below 0.5% of server CPU cycles. Moving the
tls_strp_check_rcv call site from its current position to
tls_rx_rec_wait, or adding an eager parse inside the
tls_sw_read_sock loop, would not produce a measurable
difference at these load levels.

From a performance standpoint, the architecture doesn=E2=80=99t
really matter. I think we have room to innovate when we
get around to async support for decryption (which I agree
will be challenging).


--=20
Chuck Lever

