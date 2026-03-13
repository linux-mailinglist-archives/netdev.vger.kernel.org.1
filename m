Return-Path: <netdev+bounces-267451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Gz5NvUOtGlvfwAAu9opvQ
	(envelope-from <netdev+bounces-267451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:19:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8CC2839F2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B8B030E0ADE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D822D78A;
	Fri, 13 Mar 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="GvtyrQ3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zz19DQwL"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7CC223336;
	Fri, 13 Mar 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407778; cv=none; b=ri+V6Eo0fuO3oRzi980FBQyyNilSqQBjJX1fffcm3C3IsgKKIl5/odsTavloXld4Lge2+s4AwXVvHz65DbaZ4LcSvoVTiq7NXrEP0QhcVoyu8M976P8Mvq9VKkXPMDznuGZbPgQP3pi0EYRzix1AJAL3MGzFPJGodlJfaR6ox1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407778; c=relaxed/simple;
	bh=3BgQXh9doMaVreka5OJDzVHJcwJHGqpgYXRU/iQP0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTsls8N47fGBojw2z1udxIxReSc3fyeWYYmXpupXOP8VIMZ2iGjj+i8KnXCzZwEMCbNb3DlofF7R2k+wM9ltbb3MAVSfpp+35EQK6olH7gjF45QEOsBNNw8YrnJuxcWe4O37tvLvmaqO8YagYrEpCAMyWuMNVsmUxgi/AwCKrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=GvtyrQ3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zz19DQwL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B30A1D001E8;
	Fri, 13 Mar 2026 09:16:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 09:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773407773; x=
	1773494173; bh=ZEJ90FcF0L41COAXJBmumbj/27G8Ou6IO8TuBIK501s=; b=G
	vtyrQ3PPkysdLImTPecUL+Zroa9CLHMf0CRWpFkNYwNtJCCupBOsOogfqz6VM5zj
	KhIMG5ker3P2Lp9I9L6gRyB7W0vqbFUbYmat6/7d3mf6J0eruaVuBZ2PcivOXIBM
	sRX8BdaP7Vs1kNafppIECgzb8Ie43WyzrYpDgdAyNmt/mebOk8WtFrigdtbjw3q4
	QLyLA2nVlu7tSrRznim2j2MvN3OMeCADk8qkJMAJzdwqo04t7I5maK2flZ2nlA5B
	ieDpoHW71zeDtYk2MFfUMSkvlg4lcFT5UApaQU75foBIBmwcKyk6vxZKbyjcmT/y
	6yRZBZir6zdQcZKHWjOrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773407773; x=1773494173; bh=ZEJ90FcF0L41COAXJBmumbj/27G8Ou6IO8T
	uBIK501s=; b=zz19DQwL9jl/+H7VkE7FLJiXLDEq8B2nP2FyBJW/iS5g+7ZWPHT
	/m/1EkgR99gdz16qOxpsXNAvOpX6WuqHcHdYVk98HWIs3lbZ+kvgM2qySC4k/ImF
	M/QGRE+wd3HqPUBaL+W0FJMs6l3c00onGxq8Cd/+uYvhO2YtvPKzKJUlkNlfdxmh
	szCKFLWe9D+yoKwMwQ+CIQ0QvQUV8hBACzn/L+MlkyKi726j1aP25PtaKgbVsI+C
	eLALmnzEzGpEZZ4dLetc6XdWWtuaFYn65KUhAo0zn5W3R0b/ZYxD/UraC3/WIXLc
	DaQu3P61h3jOzcU9XL7LX1IHY/Tu5YHeL2Q==
X-ME-Sender: <xms:HQ60aczyuk4OeeYslMFv8LlfwNygn1jxOI24gwy-QUDHqglHy21btg>
    <xme:HQ60aezmUheNRh515RFDPQ3W2aZYEAPCpMMbT168CZld8d78Im5X3NYNOYMrNz4OJ
    YAlUi5ym6RtrLc_ignlLqvIPPlrOu9VJm7QwtHSV3BlfFfdT66UqGY>
X-ME-Received: <xmr:HQ60aVJ2UGmAJ2-EOZcuJuLDSnPPbFQR8g6olBMMbenP0bjpbjXKTFCrjiKz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeljeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepudekieeijedvfedugfeiiedujeeiheeihfekieffhefgheeludeifefg
    ueejkeejnecuffhomhgrihhnpehivghtfhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgv
    thdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    ifihhlfhhrvggurdhophgvnhhsohhurhgtvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprh
    gtphhtthhopehskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:HQ60aahYjiJbB-P95wRDvm-ITEAhgBNyuGq5iE159TC_avBZMEF_fg>
    <xmx:HQ60aWPtIdW6jpknPKZmVLHt6RrpT2vKd3lY8OzT5-CKFEHph1a9vA>
    <xmx:HQ60aV6DNShB4w_0C8sH8byIM1Qw5lnmWYF01g_YEZ4sMYk31ntaWA>
    <xmx:HQ60adloJLCOiUQdhMNuvxvDyK4ymN8sIdG5SL1NVHOIKpItUu43zg>
    <xmx:HQ60aSdCBGrH9piWGEk4gzjjYEvY_kmD-sAMNqyyHcY_Kax62Wx0Gm2z>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 09:16:12 -0400 (EDT)
Date: Fri, 13 Mar 2026 14:16:10 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [RFC net-next 1/3] net/tls_sw: support randomized zero padding
Message-ID: <abQOGm6BqAE5eEln@krikkit>
References: <20260309054837.2299732-2-wilfred.opensource@gmail.com>
 <20260309054837.2299732-3-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309054837.2299732-3-wilfred.opensource@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267451-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:dkim,ietf.org:url]
X-Rspamd-Queue-Id: 5C8CC2839F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-09, 15:48:36 +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Currently, for TLS 1.3, ktls does not support record zero padding [1].
> Record zero padding is used to allow the sender to hide the size of the
> traffic patterns from an observer. TLS is susceptible to a variety of traffic
> analysis attacks based on observing the length and timing of encrypted
> packets [2]. Upcoming Western Digital NVMe-TCP hardware controllers
> implement TLS 1.3. Which from a security perspective, can benefit from having
> record zero padding enabled to mitigate against traffic analysis attacks [2].
> 
> Thus, for TX, add support to appending a randomized number of zero padding
> bytes to end-of-record (EOR) records that are not full. The number of zero

I don't think this is the right behavior. I expect that a user that
enables zero-padding would want _every_ record they send to be padded,
and their payload is going to be split into however many records that
requires. This could mean that data that would just fit in a record
will get split into one full + one very small record.

As it is, if I repeatedly call send with MSG_MORE to let ktls chunk
this for me, zero-padding has no effect. That doesn't seem right.

Does that make sense?

> padding bytes to append is determined by the remaining record room and the
> user specified upper bound (minimum of the two). That is
> rand([0, min(record_room, upper_bound)]).
> 
> For TLS 1.3, zero padding is added after the content type byte, as such,
> if the record in context meets the above conditions for zero padding,
> attach a zero padding buffer to the content type byte before a record is
> encrypted. The padding buffer is freed when the record is freed.
> 
> By default, record zero padding is disabled, and userspace may enable it
> by using the setsockopt TLS_TX_RANDOM_PAD option.
> 
> [1] https://datatracker.ietf.org/doc/html/rfc8446#section-5.4l

nit: there's a stray 'l' at the end of that link (and other references
to that section in your commit messages within the series)


> @@ -1033,6 +1055,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  	unsigned char record_type = TLS_RECORD_TYPE_DATA;
>  	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
>  	bool eor = !(msg->msg_flags & MSG_MORE);
> +	bool tls_13 = (prot->version == TLS_1_3_VERSION);
> +	bool rec_zero_pad = eor && tls_13 && tls_ctx->tx_record_zero_pad;

Thus here, rec_zero_pad would simply be tls_ctx->tx_record_zero_pad
(the tls_13 check should be redundant I think?).


> @@ -1085,8 +1110,19 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  			full_record = true;
>  		}
>  
> +		if (rec_zero_pad && !full_record)
> +			zero_pad_len = record_room - try_to_copy;

And I would turn this logic the other way around:

 - decide zero_pad_len (get_random if that's the API approach we want,
   discussion in the cover letter) for every new record
 - adjust record_room based on that
 - then see if the record will be full


(I'll postpone looking at the actual implementation for now)

-- 
Sabrina

