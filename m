Return-Path: <netdev+bounces-283238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P6xKZLX9GmfFQIAu9opvQ
	(envelope-from <netdev+bounces-283238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:40:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BD4AE1FF
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD01B3004CBA
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E640B6C1;
	Fri,  1 May 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bDC7G1JY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4E3P4Bt"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA83D5225;
	Fri,  1 May 2026 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653639; cv=none; b=nJTN+FEmNG+ofs5V205X1h1JHo3Ml8njx1v3MsexVv9iaLPdfaxQHE1NTfE3gmNWZZ4vwLruVplXFh+vMYFLY9gxYoWkmAUIkR5ETnaTOGL8zCyfH354SVoWfmJ3D7icpLrO1Dru0wYBH0hLxi0d5y3/KG8PRXXEAPmbykWZYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653639; c=relaxed/simple;
	bh=oPTsl+/496bFh76vbS1ubzBHeDSAPNRi0MlcpI2817E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+ZVv/+EzOCx4UY+E75zoYg85vOTPU6AkJsaqIKoStxLbQDZ5jAeEpQz64cUNYzTQ7bmFwz6QDrAEfhmz2JTdZSrhDa5hltdDXkwyOTUKYQuCGbYO6Ysc04ybD4EId8NLkKg4QPOadl0GMINdPvFk6kuW0RE9OOalDdq9j9N49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bDC7G1JY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4E3P4Bt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 51EB1EC00AD;
	Fri,  1 May 2026 12:40:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 01 May 2026 12:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1777653631; x=
	1777740031; bh=EDzZJrBF0h84N+Gtj5o0fJbwTeT70yzNk/Y8SM68IW0=; b=b
	DC7G1JY1tzExZduEO995/ESD+VNnu/KrSx7JhYOSmTVsEOMKkqzxuGMpicbQ80em
	Wqx13fCwm+tThfzk0+pzWF75hfxJDHc3pi8uiNb3u8gyju5447qCPxMIY4d5LQ0g
	kII9wLOHvwgw5kdumYNCJyA3NWmdK6YAYn7QfK+o7rl3/1HgMEc1zQDfL9cDhNyo
	Y++upjGdsDIMJCEUiWqbvRZrsIFmoYbbuqH1xwL90aw3M8Vf5yXJVtYITVRN0vyz
	C/kG5M5PxVRfBD98yiVqbihsqbqNGf28kXWde6UwnDGaC+KP7L5fHcU9CBQoiKgi
	QVg6vxfx8upmTQggx2psQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777653631; x=1777740031; bh=EDzZJrBF0h84N+Gtj5o0fJbwTeT70yzNk/Y
	8SM68IW0=; b=P4E3P4BtuuHNMN79XJ2aVUD3zx3/BVjKaJtogChu7l/G8HTeQRT
	Nyuu2kBFiTZKQXKo6B/UeG5dMIRSKJBH5fRuai+rsyz9wd1IkZGM2LiKRm7PH3RJ
	WEOtjMkzpXH8fp240O0hAG6aA3+zOB6vyF3gdGodZ8ed3q8nc6viZ3q9q7CX7asM
	HzVKDvGrr8w2BmzTX5+anRxk47A+rgGJjITPhj5qztp0PzX0GTeYYN4KfAfxqGIt
	S9Dbn+wrse9tSZ/pvS4Zi66NamosmEDshQSfTd3RPPS+2FwLnknhdEgdqSep8Eks
	lQ0oeN13EaxmpvJT2gH+AGYkg6x/BdXBnlA==
X-ME-Sender: <xms:ftf0adt4OR1Pl7ZxS8dVFC9df0y3_juzHJ9YUmMWAM_hUCCPpXBW4A>
    <xme:ftf0aTKDm3VeLQsp6ES5u7b-u4i7d8yRI_XGpUAMAjS_G2zKzCHHHFmxL1mN_MiC7
    J3oUePw_impsgUw_zsV5pxQqlWwwSPztH3ZA3f-bYVfAvKjYXG0GlY>
X-ME-Received: <xmr:ftf0aUqrG5MGzwGTEYSWqo_7k6CXx8UhykqdxhqZ13fi9n6Aw0Ug0ukOVxAH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtjeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshih
    shhnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtd
    efhfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpd
    hnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvght
    uggvvheslhhunhhnrdgthhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ftf0aeVdqjBR69tUD6d6GY1ZWvntYS09CBO8xud9CgBsnt76kB--jQ>
    <xmx:ftf0aR0GebU2wwF71G8yEE5JJ715hteOvKgvE1RR9zT_FlZV1OdhoQ>
    <xmx:ftf0adTvQflkmo4ENF5Dpbkxpf2Ne-yCE6TzV_g7QsSKJ6SWSdcMFA>
    <xmx:ftf0aVQdZm18VXqJpC580VHl7Q-N_iNyf58KxOZ5qC7LhsHUr__vpQ>
    <xmx:f9f0absOJcs2rNO4ZceBOqI6mRlu5h6eJzW2650Fn0T0AgnW0BuI4x0b>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 12:40:30 -0400 (EDT)
Date: Fri, 1 May 2026 18:40:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bpf@vger.kernel.org, john.fastabend@gmail.com,
	linux-kselftest@vger.kernel.org,
	=?utf-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>,
	daniel@iogearbox.net, jonathan.lemon@gmail.com
Subject: Re: [PATCH net 4/7] net: tls: fix off-by-one in sg_chain entry count
 for wrapped sk_msg ring
Message-ID: <afTXe_kAumf2vjvE@krikkit>
References: <20260429222944.2139041-1-kuba@kernel.org>
 <20260429222944.2139041-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429222944.2139041-5-kuba@kernel.org>
X-Rspamd-Queue-Id: AC0BD4AE1FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,iogearbox.net];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim]

[I'm slowly trying to catch up with the chunk of ktls patches that
were posted in the past 3 days]

2026-04-29, 15:29:41 -0700, Jakub Kicinski wrote:
[...]
> Every other wrapped-ring arithmetic operation in the sk_msg subsystem
> (sk_msg_iter_dist, sk_msg_iter_var_next, sk_msg_iter_var_prev,
> bpf_msg_pull_data) correctly uses NR_MSG_FRAG_IDS as the ring modulus.
> This sg_chain call is the sole remaining use of MAX_SKB_FRAGS for
> ring-modulus arithmetic and was introduced after the ring expansion.

[...]
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 906a1998c630..600e13effaab 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -802,7 +802,7 @@ static int tls_push_record(struct sock *sk, int flags,
>  
>  	if (msg_pl->sg.end < msg_pl->sg.start) {
>  		sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
> -			 MAX_SKB_FRAGS - msg_pl->sg.start + 1,
> +			 NR_MSG_FRAG_IDS - msg_pl->sg.start + 1,
>  			 msg_pl->sg.data);

And get rid of the [start] / NR - start dance to make this code a bit
clearer?

This should maybe even be an skmsg helper to avoid "random" code
making assumptions on the size of the sg.data array. The last
paragraph in your commit message also tends to suggest that.

-- 
Sabrina

