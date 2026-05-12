Return-Path: <netdev+bounces-286998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B7uLJDiAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-286998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A751C94F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5602301467D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9448C8D4;
	Tue, 12 May 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XT0MkHvQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9LZw+4R"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA948C8C7;
	Tue, 12 May 2026 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573826; cv=none; b=PcA/VNgxKZAWN31HSvmVzDBPOQyJjxTy3fNfNpGiTsbNwUROHmENsZ/N4Mqo/rEHit0k9gIEpfeCd8DSIaKrLuKcxKTVEGwocuLe/NUJrVYE+Tw4nnF8pCgJry+2b1J63u2hcyjAJ9F3Nze1mWwPtPKZZEyWE6ZykkR5yR91wsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573826; c=relaxed/simple;
	bh=tI/lGNkIuja9ajGxoyDmTYN2O82oKg71izMcMng78FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upjP8kPKpkry8tN0cgJruwsQELcVwU4qLDKHFocpLmjjyI2xijKBTgmwqWwrY/tIOhnEUOt4SbcGm+LCYeIaQvA1dZXz0iUCXn/Xw/4p4qLDrobBx1U6YCOdfY6D/djkayPHvjmly5QbRT1KcxvHR0i6gv/4yVS3s5eIpKrh3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XT0MkHvQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9LZw+4R; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35E4E7A00FB;
	Tue, 12 May 2026 04:17:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 04:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1778573820; x=
	1778660220; bh=kcKh2gyMp7VEH9jihouElpFQws/Ywu5UdBi3fT/ZVuc=; b=X
	T0MkHvQOyKIMTDwArqiH72Imdoi1gVGv3e8/vAe6y/80WW3/1S2pfX22GlJlyBJp
	VDJ1ZE8Sc1Z+QUJTD9xg641n8b+aypQgv5GLr23NVkub5Ch5HORSvoKAYBvf0Cqo
	OZwGs4Q1ecAVsl6bOXnPG0g+U+5Q1HYiVuOubKgbWFP0oWBsmyCU5+Y9CYm0z1lo
	luDVflVl0Kr6eVQQaPdE3qYdZv25M4s3EnZWYpgTdaTNo+ZoZ7W5hnoQx4hSzRNm
	13AymYf5rMi9eh4Wt5MmpVorPSUDOa4B8vSgKbqT09SNNKiwda7dEEDdpAuMIr04
	poqPstleyIV8AjUqvLBRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778573820; x=1778660220; bh=kcKh2gyMp7VEH9jihouElpFQws/Ywu5UdBi
	3fT/ZVuc=; b=j9LZw+4RW+KuQR8WsCO6P/PIayNeKLJXUbLmmAC7lFmAp4IRndK
	j/Mai/xcx7OcJKaZfO02I6KnWkaZgeQ1+4SWYDE/WWvm4CtUDPt8syrE8sxX0u6R
	Sb33qfMmIHUlc5ocgBvKMkc1qOsl94UAhqRgSzQshySZimRPram25G+8N4vzpl3n
	GfvH9Vq2XPJR71Cx+M640qef1WJtDewpzFdjmY4brcqQnnSxoVYr6meHJUhPmFOr
	a/ayLqFSQJXEE4W2j3qJcqO84JDX0nqaSvFEJsyyOt7dUef6tMwvdnRy40OuH2hk
	ZeZechjeLEvcY7XaUY6fwcbC2oYE6u1TTDg==
X-ME-Sender: <xms:_OECaijExGUt5nrPvQjaSH6XqyG0t3S6kLeicGN2RmBI4hb1Cw5Trg>
    <xme:_OECahj9TcFCwqrGyxfwH97HAJFc-dja8mUAB4OTBr6P-9RLeGHMYV3Y3wbLULosu
    h_v4DggSx1fulrpUWy57qNbuFV1f9R-nyFMl1SZobMSGe0ZnpVCKNk>
X-ME-Received: <xmr:_OECalmS1h9-jlElWGL--DdoWAa4uzlbHujTmsLpRcwcl28TGde7gDrz5QSE6isBQpwjWvpD1WxTxQ_NXpfou6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddufedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedugedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigjhhliihhvghnghesghhmrghilh
    drtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpth
    htohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssehs
    thhrvghsshhinhguuhhkthhiohhnrdhorhhgpdhrtghpthhtoheprghlsghinhifhigrnh
    hgsehtvghntggvnhhtrdgtohhm
X-ME-Proxy: <xmx:_OECalbZX1ACmoDEYa-kiby7beNiSrriMwSMydHJnj4U50YfpWrAUg>
    <xmx:_OECaoxNO4ZhZ4ngfRL_Kd0r6NT24WrSiz1DleK2fqwXkEaNrAvMSw>
    <xmx:_OECasZdt5arzMwX9JhojuGTm2bhsvKTzXkCLytngN3H34-ur8wMag>
    <xmx:_OECahzmD5gJ2KY6iXQc4sAVIeBVpkAcfTT_HeHfrhJUxvKXWgtJMA>
    <xmx:_OECaibgWh23Vvd26f9z0Jvamit-c8UXScSfx7rmwQWV-u-x-oF0Npv4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 04:16:59 -0400 (EDT)
Date: Tue, 12 May 2026 10:16:57 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: alexjlzheng@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	hannes@stressinduktion.org, albinwyang@tencent.com,
	shenyangyang4@huawei.com, kuniyu@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH net v4 v4 1/3] macsec: introduce dedicated workqueue for
 SA crypto cleanup
Message-ID: <agLh-SUJqwZ8XF_n@krikkit>
References: <20260511153102.2640368-1-alexjlzheng@tencent.com>
 <20260511153102.2640368-2-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511153102.2640368-2-alexjlzheng@tencent.com>
X-Rspamd-Queue-Id: 126A751C94F
X-Rspamd-Server: lfdr
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
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-286998-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-05-11, 23:30:58 +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> Introduce a dedicated ordered workqueue, macsec_wq, which will be used
> by subsequent patches to defer SA crypto cleanup (crypto_free_aead and
> related teardown) out of softirq context.
> 
> Using a dedicated workqueue instead of system_wq allows macsec_exit()
> to drain exactly the work items belonging to this module via
> destroy_workqueue(), without interfering with unrelated work items on
> system_wq or causing unexpected delays elsewhere.
> 
> rcu_barrier() in macsec_exit() ensures all in-flight rcu_work callbacks
> have enqueued their work items before destroy_workqueue() drains and
> destroys the queue, making the two-step teardown correct and complete.
> The same sequence is kept in the error path of macsec_init() as a
> precaution, to mirror macsec_exit() and stay safe if work ever becomes
> queueable before this point in the future.
> 
> While at it, rename the error labels in macsec_init() from the
> resource-named style (rtnl:, notifier:, wq:) to the err_xxx: style
> (err_rtnl:, err_notifier:, err_destroy_wq:) to align with the broader
> kernel convention.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  drivers/net/macsec.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks for the fixes!

-- 
Sabrina

