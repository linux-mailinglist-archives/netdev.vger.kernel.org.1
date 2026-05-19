Return-Path: <netdev+bounces-289488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNdeLFV+DGoSiQUAu9opvQ
	(envelope-from <netdev+bounces-289488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:14:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073CB581350
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D1E3313F7BA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFB32F770;
	Tue, 19 May 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Vk+arV+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbAyoBSC"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355D3546C3
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202798; cv=none; b=Q105X7U6gTMaf1ydZgiGJoRmD3mo35CzdizVr6DuHaBHuNNg2DHv/ltb75p/ZRBsdjlOF7NBvpYCMZqfiiL9wyEGCzlVBV5tfbKFzjD9LYKiW+3ZDu6XWK4CRD3QERIGi0akPXUM9EvpnJRzWnO3YxTTdT4YaxwaPt2wsyPrvRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202798; c=relaxed/simple;
	bh=Jqo3HSSwvzTMUx4j4VuQMorJQkEoFNAnSaycmIt5fqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHy7I4SoYQiRk1wHm0Hy+dwbqlWvGRnwo/m7KVmiI95xM1H5NpTfma9OeZduUy6aBqlo3SnrR316s8iU0QXj8pSNItDh9/1M8g84XjDGXaXN4feDuRedUMzxFpjRL0/CzNro2gVRFuNKYBMeXeHzqO0piDc7tTC7BFadJnANyRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Vk+arV+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbAyoBSC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 774BCEC0246;
	Tue, 19 May 2026 10:59:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 10:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779202795; x=
	1779289195; bh=2Yfu6Vm1ovT9VjYoDgg0e1mBn2ALzbX9OPpO8mi8RsQ=; b=V
	k+arV+wwLvPpDHFEX6UVGpWRiMdrzvS2lhnxcxLhkBOIuGgusLyHZZjY+2Oyc+Qa
	unj5bE6+65JoV4BqySMb18Uh/kl8PkOgMoTGPKJp6ZDsi/jO5IhUoTkN1xFP3COx
	2bdvHVYDYuxYQrmyqhX7ZmqNEQiI10FA3tahJjBQ+FzebmsaD5lIX6SSVdRthQEk
	OraptUSmHIP43kczB9lXTsJSnU4MXr9puJaXjPTqs6kAjEBsuo9NN4QtKOb3jUR2
	lhA5gF6GX0pBjH/PmsPXOjMI/rXMtEe6n6HLPwue0dMmalSNny2QdAJPDG9QHDAy
	gQ+MD3Qhn39eVTlmCfCug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779202795; x=1779289195; bh=2Yfu6Vm1ovT9VjYoDgg0e1mBn2ALzbX9OPp
	O8mi8RsQ=; b=PbAyoBSC5Ful+FQDFdHbpS69p9RRDl1wifB0Z4pTSVrzb/AJc0D
	yfnQvRpqwlv6X6/ZKB7csdbGU5zBgIIWCaQvXBW5qa8Wxa2ZUQ2AQ8o1cjPu8kxJ
	muZ7U0joCRbjyBKmTlcgo0PoL4ZtnLuUwoNg2TTpcAGz8PfbCIX5NqFVjR/iV6lI
	lRuVwwgoidG7axY71aPq5vnTPp6t4iDtkew316knvqvOgfDZd9gxC+NSVImC+f1Z
	VNXwXjpGjwJdGWXNuchkj5c6AFw7CIdYLcF+NP2JCJIYhUg6mqSrQ0JygPukR28L
	07ZnM6op5z61AerYx3IAHN2R6h+Dwotb9vg==
X-ME-Sender: <xms:63oMakC55s5FjWxu2KFH69uE5TH-X1m__qbhqy14dCpfguIqQbjYgg>
    <xme:63oMapFAYNyDtSmfwyKgLdIYLE0tV30q5SEelZhld13yyNbKRmO0A3GnGq4CFaBXQ
    REOm183BwUI4VwX898lLZVo8GM7KlvZulkGHcYsI4bVO7L4rq46vQ>
X-ME-Received: <xmr:63oMarOYxxlTtlqh5hYDLSZTZ3_dJRhkeLImiL0CN3yUMSl1Rw0WAsN2cBA81REsoYjE_4WvhTwpKNTzw1fvUOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrshhmlhdrshhilhgvnhgtvgesghhmrghilh
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhuhiirghifhgrshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlvghmsgesghhoohhglhgvrd
    gtohhm
X-ME-Proxy: <xmx:63oMaq6LvVnUcYXCFzadT2Ugx335-vMnuY51VUWmHZHt0UzqvR__JA>
    <xmx:63oMauj8Gqu6l_BswOKAAEW2feT7XPLI6q72e1Hj8fJnpKJIj-d-YQ>
    <xmx:63oMavfUN4HCAY6wZANvuc8wttW_Qp7zqIa1RBzcSlnUuDwQoHv0Lw>
    <xmx:63oMamyT1nzg96JVDW3fZQN-TdrpOslmbGJ0myyXY5A18ltzcXhEvg>
    <xmx:63oMajqbIkAokuD3vGk8Ljak8duHXXDo-7PFf3HtCOaV4cVn2rWQQ4R3>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 10:59:54 -0400 (EDT)
Date: Tue, 19 May 2026 16:59:52 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: gro: don't copy frags between mixed zcopy skbs
Message-ID: <agx66OTyTlQbot0M@krikkit>
References: <4d583fc5401298453d0a2f1b4719a15be30c8e49.1779194090.git.sd@queasysnail.net>
 <743e314d-abfd-4a03-a74e-33a57c0bf6b8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <743e314d-abfd-4a03-a74e-33a57c0bf6b8@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289488-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 073CB581350
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-19, 15:39:19 +0100, Pavel Begunkov wrote:
> On 5/19/26 13:40, Sabrina Dubroca wrote:
> > skb_gro_receive() can currently copy frags between the source and GRO
> > skb, without checking the zerocopy status, and in particular the
> > SKBFL_MANAGED_FRAG_REFS flag.
> > 
> > When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> > on the pages in shinfo->frags. Appending those frags to another skb's
> > frags without fixing up the page refcount can lead to UAF.
> > 
> > When either the last skb in the GRO chain (the one we would append
> > frags to) or the source skb is zerocopy, skip the frags copy, and just
> > append the new skb to the frag_list.
> 
> Was it reproduced? Sounds like we're missing skb_orphan_frags_rx()
> as skbs looping into rx should be orphaned.
> 
> +cc Willem

Yes, as I wrote in the patch:

Huzaifa has found this to be exploitable to overwrite the page cache

Neither of us is that familiar with MANAGED_FRAG_REFS/iouring, so
maybe there's a better way to fix this at another location in the
stack.

-- 
Sabrina

