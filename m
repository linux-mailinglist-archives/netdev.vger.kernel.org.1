Return-Path: <netdev+bounces-287355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ+DKufPA2qz+wEAu9opvQ
	(envelope-from <netdev+bounces-287355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:12:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0452BC05
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A20D2300443D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819E3563DD;
	Wed, 13 May 2026 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iogcs/IM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CC34E771;
	Wed, 13 May 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634721; cv=none; b=oaC2j172XPF7CDdOfHH/rf/WNd3NG6d4yuadolYJQlynZtxndw6aqHkoayD8KXex/bgFtT+QDxDWUxb4QqBQhSXSEYMIVu2i7zy69kppKD7j7cHSCUpP0XQkPxutRsQVT6rZwAuclFQi8uZXXhbUa6xdvtd6IDK3EW2Oi26Sq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634721; c=relaxed/simple;
	bh=X8xyFaDNY+yozyj2fEPUXKlcQPTMJS7n1ODq9MaFark=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZL+TbomEcPgsuE8hI2cT1lTpQB8th/vGCyPhmcGHlQUoyfICdNjWT8msZ8YC6yQZPz/2iMABpWZsnT4Ab4bQOgwOMZAqtgG6hfb4Yuq6E8itltw7IlV7ocbJTD+Lq+ZXCg561tgzBEMWvDkyPLIfXzyqm72xyOK8/XPHG3J7J7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iogcs/IM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5903C4AF0B;
	Wed, 13 May 2026 01:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634721;
	bh=X8xyFaDNY+yozyj2fEPUXKlcQPTMJS7n1ODq9MaFark=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iogcs/IMoEdc1ZBPmn7vmHvPRKnCMAjuxgTAC/x2Ni0O0Od0tmTrCio4F9r/vbIsz
	 7+YABkag0iisGQPjc5clMQEbxrjJ9nZEyOWqypuOurssD8q0EgHjgIQuBZa6Ir1HxR
	 JVwQ2fvR78/GSghy61i69DkzGuCxlFw0Z9qeDEw0tSxJXQBnGrYZKof7qLEqui/lME
	 8r7xy+kiZjm2dfigHoc13N3HbeM0SgKkS9Rwl5nW5dHPx+D/D+2yBep/hZaNeKKMyr
	 kEYPjMWZAbwWWfgdSw334aYBlGMjVV7BCkuVdv8hQGM0yZZM5PI9Sl/CAell0mi2Fj
	 MfArin0OE8MvQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CE34EF40075;
	Tue, 12 May 2026 21:11:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 12 May 2026 21:11:59 -0400
X-ME-Sender: <xms:388DamAEjnFcHNs3GpP0eH_QlORW8nNiha1ZgxmxSUx8vrZe3O5TrA>
    <xme:388DarXwdBUu4cSSIKmw2H9MgJbY7LVPvQgvyU0x-WT_uJpi_RFxJQFeg2mMjkEDt
    ryLsi6aA4XcC_9AzWFPJpacLEHATtZyz8kMQqS3CPwFoiACa7ITWRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrghhisehg
    rhhimhgsvghrghdrmhgvpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgv
    lhdqthhlshdqhhgrnhgushhhrghkvgeslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehs
    ugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhm
X-ME-Proxy: <xmx:388DarsiURtQ8dsSwVenwKa_yOX9Jr8PYGTwzo5XFXpjGG_DN7RZcQ>
    <xmx:388DaidDJo55gpJ6LkUUMrxk3OQHUpFHH0bzXPQLHX2IGiQ-IMA4tw>
    <xmx:388DapkKVDQD5-NwIrELjn6Z3Rau5NNEJN6WtEowecUE-iuq83JI3Q>
    <xmx:388DatAJzP5qY4k6x81f3qJ9kclYWGd2k1Oa2tBDbObB1IyHW-g9bg>
    <xmx:388DarPP68IaGKp5pPkMKyTpTNYt1l7Wv4JlzR3gs-B7JsJtYp99w834>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9EC95780070; Tue, 12 May 2026 21:11:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 May 2026 21:11:39 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>, "Sabrina Dubroca" <sd@queasysnail.net>
Cc: "John Fastabend" <john.fastabend@gmail.com>,
 "Eric Dumazet" <edumazet@google.com>, "Simon Horman" <horms@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, "Chuck Lever" <chuck.lever@oracle.com>,
 "Sagi Grimberg" <sagi@grimberg.me>
Message-Id: <c3f9038f-e4ed-42c9-b4f8-7a9dce2933df@app.fastmail.com>
In-Reply-To: <20260512171715.078b49cf@kernel.org>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
 <20260511-tls-read-sock-v10-3-279fc5015f0e@oracle.com>
 <agMiq7CULgkRzd_E@krikkit> <20260512171715.078b49cf@kernel.org>
Subject: Re: [PATCH net-next v10 3/7] tls: Re-present partially-consumed records in
 tls_sw_read_sock()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9FC0452BC05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,grimberg.me];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,app.fastmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287355-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Tue, May 12, 2026, at 8:17 PM, Jakub Kicinski wrote:
> On Tue, 12 May 2026 14:52:59 +0200 Sabrina Dubroca wrote:
>> > __tcp_read_sock() handles the same case by leaving the unread
>> > bytes available for the next iteration to re-present, though
>> > its mechanism (sequence-number re-lookup) differs from the TLS
>> > path's explicit queue management. Adopt the same loop-level
>> > behavior here: update rxm->offset and rxm->full_len, requeue
>> > the skb to the head of rx_list, and continue. The next
>> > iteration pops the same skb and re-presents the unread bytes
>> > to read_actor().
>> >=20
>> > Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()") =20
>>=20
>> Fixes typically go through "net", not "net-next".
>
> Just to be sure - no in-kernel reader partially consumes today
> without setting desc to 0, right?

Correct, today's only read_sock TLS consumer (nvme/tcp) does not
exercise the partial-consume path. But, this fix is a prerequisite
for upcoming consumers; specifically NFSD is about to be converted
from sock_recvmsg to read_sock. NFSD=E2=80=99s multi-fragment RPC parser
legitimately returns used < len with desc->count still non-zero
when a TLS record straddles an RPC fragment boundary.


> If so a more appropriate direction would be to say that in
> the commit message and drop the Fixes tag.

I=E2=80=99ll drop the Fixes: tag and route 2/7 and 3/7 through net-next.

Note that 7/7 in this series also bears a Fixes: tag. Should
that one go through net instead?


--=20
Chuck Lever

