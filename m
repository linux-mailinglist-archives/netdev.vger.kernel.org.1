Return-Path: <netdev+bounces-271169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EOzEYi8wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:32:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A843190E3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8F39305C905
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD66370D7D;
	Tue, 24 Mar 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RG/+I26t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M3wF/DGu"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC523A0EBB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369282; cv=none; b=ClrcYu/Bt85z5zDGkeC6ErxW78kxet301EyUVpWvYIaIa4DfMO80ba7W/DvNVLcpEEuGmq+Q1l4BiMDXX0+5sgX2rmyyef3sYBWqGgFGZqtdOxq+GGWe2T4y9hvw3OJkU/+t1tKDgo7VRQlETPE/Xp1LT98YQhxJoUmapVOsyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369282; c=relaxed/simple;
	bh=tdJfN6Syo+DU4+R9yVeDTXQhwqBzNdrDr1QDy3kE/ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3fUrKY6AbuGyVXlM2pB671VXF0ZlK7cVXRBkESPq3IWiaNKcGZWUieCBfv4GSBEh3u3Wkay9sci54eNhq4w1C/JSsCKB8sPelcDhTXRcSrEum3Xry2N5xg3JWo3U9ql626XCToqY1tL+rAJe/y8lj73q08h4OGFGfBEc/39R64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RG/+I26t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M3wF/DGu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DFA6EC00D0;
	Tue, 24 Mar 2026 12:21:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Mar 2026 12:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1774369280; x=
	1774455680; bh=XfMTS3vNPgawo9HgJ7+NJgtiGfH/NEv8F0qRgZZpKwA=; b=R
	G/+I26tJ/wXERBevPqKVVAOhbcUarwTw4ycZWJ3GixH+TCEsqC0URS/JUSaq6Omn
	QhnQX9S8XeVKKIfcTILiaxHLldA21OpEetzTB8MN2ArxZKDGyQEfWkCVZ02p4DD4
	IQ/sKhUNualW30MdB0SWTmYDKrmk61QCPqJEZ0S68JB880Nvw6iINuPuluK7g835
	pI1EE/ctS0Nxifg5wAWyQ/Eu+1u2RCszeamqgvLQ1yifqm04y+4/Uu328+H58fDp
	JY/UBbaSFarQU+fOpaHwmUYtBO3SmQBx4pV+BqintUMPLxOOKL+yUiwVXPmjjMG6
	HyJg4uNnvzmgwei2/SX3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774369280; x=1774455680; bh=XfMTS3vNPgawo9HgJ7+NJgtiGfH/NEv8F0q
	RgZZpKwA=; b=M3wF/DGuvSupbEt0zZe/LNl2eA4IAUC/J/8xcqNLqroS4Srf7cg
	jkD536Y4dA7uW0r/aKLUlkhPOStxidj/dj2TTdIwWFsEBWyHtuFRrI2k2tVi5UyV
	/R7IkJPOLwSSPgXkNYges7AK8v4CrqtaTS5TSs1KC1XrMUFQHplkrQStrUB9iC3b
	+Nr56bcIcV5r9Bs9tjYC1EbtYG9qgcI5wAIvZ89pTcgDFvwkWD5mubULpBohII/N
	9yr8GASkKl10rEQYpVoMxrYAsEDHuGaAPTi4ZK0d3dJqr4Re/DqvlI5TwrA33Y3o
	gG/7YOvtpvyocR/tBRQHWRSHIKf6gxaLoEw==
X-ME-Sender: <xms:_7nCadFJZQtBcXcdBPpK2HGzcUI4sQ-SOB51HrmbHKmJgSn6PDM8Pw>
    <xme:_7nCaeKeT-KUxV5IDsLVS8iq6T3m7yRG-o8tv2hwDbqrk6A1mwvJYblGNkQSrw1ej
    YnuGV2CSg8y2rgdnHGOyMcf0EYKoG2HwCVINqH_UaLrk3OU1oliv9g>
X-ME-Received: <xmr:_7nCaajrTiEjwYmZwup_2VM-Tf0FS-C7N7sDYzuFAvrVEIOw6mOx0Y8j8TfL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepphgr
    sggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrvggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhope
    htrghrihhqthesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgslhhotghhsehnvhhi
    ughirgdrtghomhdprhgtphhtthhopegsohhrihhsphesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:_7nCacmD4Td8XhWmru3MBlIi-vkKiRJ3TbOKJoJUdRaCAxGdEpW60g>
    <xmx:_7nCaRVJQnm83A1LTFP4YjbUeSGpSj5hrwfzqx2L-PV1DG65SnCpLQ>
    <xmx:_7nCaZvNPO_aRx1XW254E8aG6zNi_AMyTs7etp2UfcO01d2Cv2US5A>
    <xmx:_7nCac7aGTxXIMzD4REp2o06yIpWiDD9U6KVsfAq2EyrRUjGsYW8iQ>
    <xmx:ALrCaU7DbnG8ixuFDGESNmK-DcXTpGUGTNC_8j-38DhsMldF5ztOUCFq>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 12:21:19 -0400 (EDT)
Date: Tue, 24 Mar 2026 17:21:18 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	leon@kernel.org, Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH net-next v9 0/6] tls: Add TLS 1.3 hardware offload support
Message-ID: <acK5_hW2dMKpWqdZ@krikkit>
References: <20260320235706.636531-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320235706.636531-1-rjethwani@purestorage.com>
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
	TAGGED_FROM(0.00)[bounces-271169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,purestorage.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: B4A843190E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

@maintainers sorry, I haven't had time to look at this revision
yet. Can I get a bit more time?

2026-03-20, 17:57:00 -0600, Rishikesh Jethwani wrote:
> Hi all,
> 
> This series adds TLS 1.3 hardware offload support including KeyUpdate
> (rekey) and a selftest for validation.

-- 
Sabrina

