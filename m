Return-Path: <netdev+bounces-255123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAMQGuCVfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:28:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 815ECBA143
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AEF83002B6A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB33632AAD2;
	Fri, 30 Jan 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ygZmXh/F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKt0DvBZ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF822561AB;
	Fri, 30 Jan 2026 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772507; cv=none; b=KpVNxcU5DrSy/QWisJWYZjlhDy8dW06Om8jpkx08/DQgyVUhseSO58sb3UWsjyni3FJ7xHHzhUENPISgv58jIYh185lKF5a2Z7lbEwPw5f13at8ha2pE8s9Mxy58n+tMFMyQ9v94Zyd6baZYywYZNb7OFzjl93opSEeCBnArs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772507; c=relaxed/simple;
	bh=rkG8xetznpS00ubWfKkmJIWYKAFjeq42mPQ7VWx586c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx7N0vsQ3pcrVk4wy30bMrN1Zsnq4T7Aneil6jXb7O1Xko2DLisQb2lKIOTp31cyDMqfW/f0iokWUp7fatvCK58a24iEZkRgnexsOVczN/mvuAAGF9yK07ZPswxVRb4Pm+plDg02x7JtKrI22DJdasOYaUwtTYK2nyfCf6EJtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ygZmXh/F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKt0DvBZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63A7A14000F5;
	Fri, 30 Jan 2026 06:28:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 30 Jan 2026 06:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769772503; x=
	1769858903; bh=ay+37y+yJvUhkN/e+UkFG+5HZ0yJBlraYJBawBaJYZQ=; b=y
	gZmXh/Fs9jNfNxcl8QicrfE2YZuOdJe6yTttkt8NKHVkfwK5Cr9mf+YJqeCvep3k
	8PRUJnhKdwOnzeMhIKuLHprNqfaa0jevhFJEnuhRYRQkEDK/KyRJvoZlXNRJ9xzH
	ag4j2tlmAP8hndPw9orEMv8nmqKpKHxXO24liWNaOLklTx6jXdTS9adQu1+/+teJ
	9myIw+m5X1PR+w7+/QNKsdyYXQCTssiK/8zWKwZFT9rq3dhgjOVk5qqgLpODJdzf
	AeaN4wC2Cc39wqz1Z0OKT+pn9IB3lriQIF6/+1H7NXVAN7lmIY6flpcsf/URQqpG
	KaEfxcCHJw9ZZhb2N4ztQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769772503; x=1769858903; bh=ay+37y+yJvUhkN/e+UkFG+5HZ0yJBlraYJB
	awBaJYZQ=; b=aKt0DvBZBnhKYTkjLsIblJgs2TVlmZ8LOk27AnO9t/J8HS7KDjl
	MXhG7Lzr0ozPR4j8RACBLgWdDzh+zCcW2suhBPxoTRCXHsjNzD7HXOQb9C18pCYy
	pH57YcH1vxwZJsK7cq7XaDI5eNaygzSIbVQBBS6XrlIV7Eonhd9/yMPzwEIJoMm5
	QEddN4fWdInYylFUFvPHVB61im1LDBCYpijU3tBeNlYBg/lcatxV9DrZnP4ZSQQW
	UKAgfCuxOZLbXcEnnn85FArrNKkXL4l8wvO28FII1nNGT3ZXYbZh2FkQiRL1+rc6
	qu+dYD9EP1WalArtyk0rQt63WfPIvGK7Qhg==
X-ME-Sender: <xms:1ZV8aQGespPDjnu0k_kniajYiCx5RC2FcNrIpgN7MdqM6iRy8QwCuA>
    <xme:1ZV8adAftIGOyi5VXu9IhSoaHLKOq5IXZDdaRKl-F9jvxIvKHgOxjCSUpslHOSWRA
    Dd4JQXknJa55oIISqoazkC8ltQ4q5bvdXMfuP_Z58makH3fcNqqlQ>
X-ME-Received: <xmr:1ZV8aSy5fYl1vVxEVGYsW5FqRS7KhRQHKeYUGB2VjmyHW6hqD0xImay5i0sP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedufedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnthhonhihrdgrnhhtohhnhiesshgvtg
    hunhgvthdrtghomhdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgv
    tghunhgvthdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtoheptghhihgrtghhrghnghifrghnghesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:1ZV8aTen9YuAm9L3fPR_FVaBfdOLaeOP5chlODloI0yieHZIQ7YHhw>
    <xmx:1ZV8aXsk8kPRiZvHohKecjhMBHm9J8nxhxeor8Lf4FeKOTTPM1Yjrw>
    <xmx:1ZV8aYBJYmR5-zyZ_77KvtqRFDQGCCaBp-NPj9lCZCey5TMW3lCjLg>
    <xmx:1ZV8afHeXbCDU3WVqF_YAYKZ7LI8I9GEctIKRu2DKtWxhYelUpQyqw>
    <xmx:15V8aSqYEsCcgGoIv5f4vGsZsauLQaIAOaqX7RFHLx7yJq9BdJ93VZOF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 06:28:21 -0500 (EST)
Date: Fri, 30 Jan 2026 12:28:19 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chiachang Wang <chiachangwang@google.com>,
	Yan Yan <evitayan@google.com>, devel@linux-ipsec.org,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ipsec-next v5 3/8] xfrm: allow migration from UDP
 encapsulated to non-encapsulated ESP
Message-ID: <aXyV028imsUPWSyq@krikkit>
References: <cover.1769509130.git.antony.antony@secunet.com>
 <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c30e7f8543048a384f693684ccba5f71fe8543b.1769509131.git.antony.antony@secunet.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255123-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 815ECBA143
X-Rspamd-Action: no action

2026-01-27, 11:42:40 +0100, Antony Antony wrote:
> The current code prevents migrating an SA from UDP encapsulation to
> plain ESP. This is needed when moving from a NATed path to a non-NATed
> one, for example when switching from IPv4+NAT to IPv6.
> 
> Only copy the existing encapsulation during migration if the encap
> attribute is explicitly provided.

Are we sure nobody out there relies on this behavior (silently copying
the existing UDP encap without having to explicitly request it in the
MIGRATE request)? If there are, this patch would break their setup by
clearing the encap that they expect to still be present.

-- 
Sabrina

