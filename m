Return-Path: <netdev+bounces-285234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNxNMLFr/Gn0PgAAu9opvQ
	(envelope-from <netdev+bounces-285234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:38:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC04E6E46
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF214301B6D0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC03EB80E;
	Thu,  7 May 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="S/Wgk7L7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7I0t9i2"
X-Original-To: netdev@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E253CBE7E;
	Thu,  7 May 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150279; cv=none; b=Ac41Wk0HgR06PeCIRA/V6RkY0MCtj4IclQl9le2+LVWEB3E1DHMjgiwN2PpW4xUDPx7Z9e/xAmTL+NphbNScAGSLqCsgamsrbrhVRo4gnbjIZRNSYWzUH9fF0XbSmIg/hlWg4rz58CAvp0n2cTUI5tnYhNrP2HzwjYIvEpbDtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150279; c=relaxed/simple;
	bh=25/JK8duwYXUq+U+VuTQsMd0zTawA5KXJqtVS+KmWEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhtUQnIkWuTTkusBIh/a7lpUpbonEcDu7Gba4WvYP9PhWzb4Ew2IRJJz8638Z3OAcgRWQnJYWtBKe0ExvXhEWbIl71jZ8CyINmQ3mEcqe49GzkSzbL8PfaQHucHWHC5BywLVqFhGlysPh/VjzVUJTuA2FIof+0KDuIwZDrSYSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=S/Wgk7L7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7I0t9i2; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id B734C138051E;
	Thu,  7 May 2026 06:37:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 07 May 2026 06:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778150276; x=
	1778157476; bh=QFJP61XO+xUDojAtLdP+GNe7fMdGrq1+Pb4a2M9nANg=; b=S
	/Wgk7L70FkkarZCde//igk4ex1rWGa+bsTcoOOGVwuBXlsVbN+CZWb6trb6Vws74
	uZGwJz2aqA6NCTX5aEp7H4qjANr+jgG5pOqHDRb8a31LsjYgkGQGSKz+e6G9FNMD
	LxAvGBYzk72dlwD1El4dg55NwMynTawizHMe/47e1rL1/VolY6GwKGPiV7tlIh9T
	ZVKS+Re3bNG3UNLdK/YyqOA6AX5+zpWhcnOLuZWrlZPuESu4l6ezdGeb/Brd0KEh
	SsANpdfukmaIF97CSRsHSYKdT2Um12OTnJDIUhiUyFboiGj+ajCnYTfvw772vd1W
	BtURXmUiUKLrc3v2SkXug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778150276; x=1778157476; bh=QFJP61XO+xUDojAtLdP+GNe7fMdGrq1+Pb4
	a2M9nANg=; b=I7I0t9i2iZtVYPk3NVrVEBTzps9vzvU1Nq9gAJSLQxKr6o+LcHZ
	I25WEsalyEXYARXvvE2XwtXQPhGM80ixkZxFTk0poS+YJMboz7gz5t2o8NJQ3amw
	baOTsrTvn8IOAEj+kUfuA1AOd+cOlUXLsdQSB40D3TA28wQuNFq9gz9vaFe+QzJy
	Y825K0X5g4QW7i3x3Ju0T3sGnuSsXXOOF2DIdthjCXmsGF5wgr+APh+sqCQ2bqJo
	o1+jiwKjqFHYAciE+MucZb/BXgwfsmzBz/1Xny3vJEVllTiPA3x3e9aopICOEqZf
	tgX1LRYzbJS7dYM0y5nS5on0olsEZK+9mKQ==
X-ME-Sender: <xms:hGv8aeceJEuvL1uYz3_VMNkzzb9D720A5peYfsnSMGwVipKRQcG2ag>
    <xme:hGv8aZ254VYgFV3sGyJ5P2K2ZRm2aL_kOQIOeIjPjGeC5yDEJQsvfDpmkAAmB_ZII
    fPGUvFDEECjloBSIUCvhK4DAshouoBJGlUnmMABeJufChwd-39NiKo>
X-ME-Received: <xmr:hGv8aTn7XHT342ea06OSZjmVPqoSYH8uvJZa6zwrV3y_r2sBK5Gbyu-JYwRY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepjeekleevleekfefgueehveejueekvdehvdeugedvkeelgefhleegieev
    ffdtuedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hGv8aSbU6eFL_iMS0BygzFvbqj28AmlQQMGKt4HfCDbtrpsmMlDtuw>
    <xmx:hGv8aZoULJpyu7qt4dgb9ScCbxJ5SYnNqw8NjP2l9mA6LdyyeOFcBQ>
    <xmx:hGv8aQgVkMvXm4E_GtAxTLBnG-qWS2zuweiFxw4jizIyPgqR9iMe9g>
    <xmx:hGv8aTw1ysoTUUoYwbHELVIFBEGUuNCtDgEjBuEDji-a91C_6kVfXA>
    <xmx:hGv8aaQvXMH-epBrbsDCa2NDKV7NaR6wWmZaBIslzEfWtHBXmBfB0-d8>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 06:37:55 -0400 (EDT)
Date: Thu, 7 May 2026 12:37:54 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Masahide NAKAMURA <nakam@linux-ipv6.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v8 02/14] xfrm: add extack to xfrm_init_state
Message-ID: <afxrgimWVUHMAdjk@krikkit>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
 <migrate-state-v8-2-4578fb016965@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <migrate-state-v8-2-4578fb016965@secunet.com>
X-Rspamd-Queue-Id: 81CC04E6E46
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,linux-ipv6.org,paul-moore.com,gmail.com,lwn.net,linuxfoundation.org,vger.kernel.org,linux-ipsec.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,secunet.com:email,queasysnail.net:email,queasysnail.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

2026-05-05, 06:32:19 +0200, Antony Antony wrote:
> Add a struct extack parameter to xfrm_init_state() and pass it
> through to __xfrm_init_state(). This allows validation errors detected
> during state initialization to propagate meaningful error messages back
> to userspace.
> 
> xfrm_state_migrate_create() now passes extack so that errors from the
> XFRM_MSG_MIGRATE_STATE path are properly reported. Callers without an
> extack context (af_key, ipcomp4, ipcomp6) pass NULL, preserving their
> existing behaviour.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> 
> ---
> v5->v6: added this patch
> ---
>  include/net/xfrm.h    | 2 +-
>  net/ipv4/ipcomp.c     | 2 +-
>  net/ipv6/ipcomp6.c    | 2 +-
>  net/key/af_key.c      | 2 +-
>  net/xfrm/xfrm_state.c | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

