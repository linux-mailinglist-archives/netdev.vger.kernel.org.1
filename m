Return-Path: <netdev+bounces-287213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO9KKqhBA2oy2QEAu9opvQ
	(envelope-from <netdev+bounces-287213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:05:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8AD5233E5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6A9E3001010
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E1839060B;
	Tue, 12 May 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="AS9onW9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGi3imwL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE53346AC4;
	Tue, 12 May 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598309; cv=none; b=U1xeXli55TxEBb9kspQNcHsWm1Peder2W6p9jNxrdGg2ECE+CZKRdmghULUIa/wBWu7ZOk5K9bJWDC8SMA3ut8W+heXL9ZqfggSN22qxr9mMdsxYD0jv0mGngSXWYE5x1vPmi58GwZrSqGfD3W7QUnv8xI5jv9X4pENr+AxEJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598309; c=relaxed/simple;
	bh=VUqOtT28QtamBhTUI7hcF8tSInGIdl5ywozCPk2lkrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+LcHrGsbTOQMpKWANVWpPYNx6TDPbD948jqYgwIwBo8sWz23SIoLqingC4dRQXbx/LOxdndchUepXEjO03IE7uU7j23r0POX30b2S20k3feNR4DJiCbggcZVAQj2R3xApzYNEmj+yK4cHYd5VWjQgI7NvXV7DztNIFA5pzSBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=AS9onW9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGi3imwL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B602C140020E;
	Tue, 12 May 2026 11:05:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 11:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778598305; x=
	1778684705; bh=UZIvXI70GG2eH5JwWXbZK5ECjIUULOELaOAAhDLAcYo=; b=A
	S9onW9lMU7lHHTQAq/4mwGFI7BBYj4jYt2f9thwwMz+W1C6ngttcA6jMnUI1VW5N
	Y+Of+i5TdX8uIcwB/L3+A5QcQPkfktsIbolw1Fy39iRwWDGM0uhjH37EQG2eoYcT
	IcIleb9ixMIe1+Oqy6erdxcelygS19StpYtcIAu87LvYqtpHZsEyN8BDfKNaPMzV
	whXp2ovMaiW1IgbTLjwHDzMQACFdwrSh6ct+WzRyCZgrkj1Dz2rsbnoONHf/+SeT
	c4MJHxazQYYslCvwMgF01GUyr72/zMaejqKZWMgbsj8+Mq3ooGdMIErDKGZhE+s3
	2AT5rYlQMBciXgaKS+0Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778598305; x=1778684705; bh=UZIvXI70GG2eH5JwWXbZK5ECjIUULOELaOA
	AhDLAcYo=; b=WGi3imwLKWQcQOarF2fbzasGfN/tlWfRH58KKRelCpdcsg14Icg
	2yoTZIUbpoZEVoIHofrnkaEOlAIyR6WVbxcAgj9bgG433dPty2th1bK2sPD6P6q8
	EVZknawJtnU8lrhpc+Vst3yTGQEYkDNQJhKPwYCI8LBerrVrIbIrx6hSDC23m4GE
	JEPFIXN0v37CPinghww1xBbYlkK6eAsJBAIydf8y0VfLIVkwTeY9z6o7KMGlXs6u
	+pXPKpNID1CPBorI+v2RJlKHk2UGM90gYw19A5B5oLN1/BDU/r8wZdy14KyoTgm/
	x1++TDii2pWcrdq2V9MvaXjeka4FMib35UA==
X-ME-Sender: <xms:oUEDaid-uVXeaarOflC2klACKfcU-J7M7NayYGyqGcHeXZghnTQS7g>
    <xme:oUEDahJ20lJQ0-HCDn1Iy0i5jsVn-rSu0etYCVNBuG6CqgDqE5qiepIGVnfYy84DC
    5KpHqdS517Y_36ow7Y2XTZ4KHXoI0e-RUSZkTlQMlrWovgg_pB8-Z4>
X-ME-Received: <xmr:oUEDanyhyE_7zCWapPrya8j0xRGSp89YM7AwvOgIkGqNWunOOga_7eSJxI2mLOc_ACIKJVgnla2leHzvqvqSNvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvg
    htpdhrtghpthhtohepuggvvhhnvgigvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    vgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghv
    sehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggv
    nhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oUEDavvfc7EE7-MP08eVcizsgXxjkoZ1bsZY-HaL4CsrxVVgWjokIA>
    <xmx:oUEDaiDc_Jc1Yb-79yvEilD0-3Cb4vWLm1EXca6MCwzNw7XmnG1v7g>
    <xmx:oUEDapFgugn7-ca2nV1IeY6PX_UwLOMdwIzEjuGvg71ArB5wTcZkfw>
    <xmx:oUEDaqCcb87DwQkOfGsZt-mx1oL9L7XtjEgSHemxVrn743ZUp_ehMQ>
    <xmx:oUEDahuv-Pnq8gQ9szmqgFpUpAmpPTkAcL9H75R-2J2ycJqc3JDQxq0->
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 11:05:01 -0400 (EDT)
Date: Tue, 12 May 2026 17:04:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: David CARLIER <devnexen@gmail.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] ovpn: tcp - use cached peer pointer in
 ovpn_tcp_close()
Message-ID: <agNBm3vvxI15D7ib@krikkit>
References: <20260512042036.19870-1-devnexen@gmail.com>
 <20260512042036.19870-2-devnexen@gmail.com>
 <CANn89i+qfzW_S-Z_vT3=UH00Qu2KodJf=V7O3o=yMVgfjK82xg@mail.gmail.com>
 <CA+XhMqy50a8zq1foi564r2niHzJo54E3TCpT-YmYa=r2n75Uyg@mail.gmail.com>
 <4ff6590a-6695-4c6c-b677-a7891b249165@openvpn.net>
 <agM1LMZ30jZDRqZ3@krikkit>
 <a2cbd426-cf71-40d5-9b5e-220758775660@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2cbd426-cf71-40d5-9b5e-220758775660@openvpn.net>
X-Rspamd-Queue-Id: 0C8AD5233E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,lunn.ch,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-12, 16:17:39 +0200, Antonio Quartulli wrote:
> On 12/05/2026 16:11, Sabrina Dubroca wrote:
> > 2026-05-12, 15:55:39 +0200, Antonio Quartulli wrote:
> > > Hi,
> > > 
> > > On 12/05/2026 06:56, David CARLIER wrote:
> > > >     Same multi-read pattern shows up in ovpn_tcp_recvmsg(),
> > > >     ovpn_tcp_sendmsg(), ovpn_tcp_data_ready() and ovpn_tcp_write_space()
> > > >     - happy to roll those into v2 as well, or punt to a follow-up,
> > > >     whichever you'd prefer.
> > > 
> > > @Eric, if you have no objection, I'd pick this patch up in my tree and let
> > > David follow with a new patch for net-next.
> > 
> > But this patch is not fixing any problem either, right?
> 
> Mh, because the sock outlives the peer, so there is no risk in accessing
> sock->peer in this case, right?

I guess I got distracted by some of the discussion. I thought this was
only about "peer and sock->peer may differ", and not "sock may be gone
so sock->peer is not valid".

sock->peer can't change behind our backs, because, as David said:

    sock->peer is only assigned once, in ovpn_socket_new()


But the sock doesn't outlive the peer. ovpn_socket_release() does
ovpn_peer_put(), and frees the ovpn_socket immediately via
kfree(sock). So if:

   ovpn_tcp_close() starts, finds sk_user_data set and a peer, does peer_hold
   the peer gets deleted in parallel, ovpn_socket_release() frees the ovpn_socket
   ovpn_tcp_close() resumes and does ovpn_peer_del(sock->peer)

we can indeed hit a UAF on sock.


So this patch is needed as-is, sorry for my confusion earlier:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>


The refactoring of all those peer accesses can be done in -next.

-- 
Sabrina

