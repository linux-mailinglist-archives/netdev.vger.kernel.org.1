Return-Path: <netdev+bounces-274500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDnJA/ZWzmnrmwYAu9opvQ
	(envelope-from <netdev+bounces-274500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:45:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3B388851
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88ADD30C0D9B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9273C945D;
	Thu,  2 Apr 2026 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="RfFDkdtU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkV3Czmh"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B273BE640;
	Thu,  2 Apr 2026 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129836; cv=none; b=uGEi94fRBNxEYdyjuJnaCzsL+Yc1jb1SWUG+yGsPKR3HKIjviKhmoCt5i1PNRprMFvGPWHTK5Cas9//61ikReSPpirK38OXkWEYHDEy6u1nlgr6TlKoLOdoNJb0dZnwfgVbNF0WE5X1nlIirKeCrEjZZZ/F5OInl2dPxsXrfV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129836; c=relaxed/simple;
	bh=YtVI4AgHwJtUENT6p3xzig+p7Q9T8b/oQ0tZTNdIFRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9ecsZWFduURLSikTM9Gh32CYPNmQsKpCHwM1lZHtRgudr56AbW5x0OsZGOfNEFoJ18CKu3P29l4JBbPcWq3wc+wGi3bXRWM3lb9Tn239R7mckvads3u/V0N9mjPsF6XRB1b5taod7X3zpfCNAf6CuWF4Hr2cyaIhF0ZI1g7mRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=RfFDkdtU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkV3Czmh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AB671400285;
	Thu,  2 Apr 2026 07:37:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 07:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775129823; x=
	1775216223; bh=3ax/Y5Jw8jmWhL4qQAuF/j7sP4Eeb8pjR3+iBd6r6aU=; b=R
	fFDkdtUbOAascrUk5Xcp1Wa922lBCba+2E54tOsnWrsln0RZCvCwhh8Fk13N0uFG
	uSMbXM+wqbwA5WqyZxDQ6Jr2gwBqKQnR80eILhrWywV9xOdAcohlB8yic0Cz2G4m
	0jNgyDXjflEWnTDdwVdeKeYCuyjUmKC9d5YHsspwUwSLj0CMshuGbCH4uhGwTbug
	TJxpQpJWj4oeU+2Oyo9D5C9V9mYkBK+ryiexyfoeMDwhVGSDqq2RMwIUF3EBUDTz
	jKucHvo9y62vFTe5fI1KL9x9zEY1r7+A3Fr9ETpwre1akvoqBcVCJRJZeW/WDsqJ
	8GpnFREKhGqgiNvJmwqbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775129823; x=1775216223; bh=3ax/Y5Jw8jmWhL4qQAuF/j7sP4Eeb8pjR3+
	iBd6r6aU=; b=BkV3Czmh2cfUxv+2eS7kwP+T88JvYLjc3e3K19KLkN5dNHLGLPa
	efPTYkb++0Z5sHbw+V/gLZIIqEluAZPHemLYoQZmVlmwVu98dM42/EVibxTXY/Fq
	C4OB2rvasgwEps9Hj1TB3JEKxlqMKM4jIsHYqtdY+QqHNcgZX5CAUYRTcoekTN89
	ESeqHvTP7BkTrBIi4Oj13K/JSFjvQ9q2VbqKCz7dvscX5Gk5XMZKdJFPYV/4+BEv
	G4w8y8qj6sJqxQf4UaQPo58Ielra6hxnt4RdTx501gqiim1AaOBMNqYu+gjIagiV
	YxduTf4hTTV9fAjM/GR6y3fciYFvjvH8E4Q==
X-ME-Sender: <xms:31TOabtiqTqeLCg9Kc8cPd9UBelBSR6VFsB0lvwWANboMpCVB-04qA>
    <xme:31TOaeBI5Yna7oXl0xtT4NNPuNeVx6k5UtI3rfCrlaVLTVzn4NJ3sy08BxkIraKBE
    iO98icd94_dyItvaz4qqzdyNOhTAg2Rs9uOVILqi7E1TojSwjIqug>
X-ME-Received: <xmr:31TOaeDdI2vborYmq8TQ3CQQsPInoZZ1k6QILIqA3OkkQ-8_ILdK-NnbLhZb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvuefffefg
    udffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    gusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghrrghtihhusehnvhhiughirgdrtghomhdprh
    gtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvg
X-ME-Proxy: <xmx:31TOaQqKG80QMLtH0t5IB_PjsrHtHyS2fK9bgC4j3MHxbd_JUxb15Q>
    <xmx:31TOaRHQj8mvMwT38XvQdbu2mGnUjtNGO8HkpgV515uvhIWt7JWaIw>
    <xmx:31TOactbQeeLPGMalj17M54MIGdoWkr_1gB414mWYJ2QXvpxwxe-2A>
    <xmx:31TOafaYYFUD5mhZjbv72GZHA4odUEJ4-lFGQg55Pcitxk8ftV6zWw>
    <xmx:31TOaQRK5kglNAV-G065Ty3Eh0fsWYGd4GUnXTaYZSqasbEHIFaYpm9r>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 07:37:02 -0400 (EDT)
Date: Thu, 2 Apr 2026 13:37:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net v6 3/4] selftests: Add MACsec VLAN propagation
 traffic test
Message-ID: <ac5U3LFm2pOV3vWM@krikkit>
References: <20260330130130.989236-1-cratiu@nvidia.com>
 <20260330130130.989236-4-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330130130.989236-4-cratiu@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274500-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BE3B388851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-30, 16:01:29 +0300, Cosmin Ratiu wrote:
> +def _get_mac(ifname, host=None):
> +    """Gets MAC address of an interface."""
> +    dev = ip(f"-d link show dev {ifname}", json=True, host=host)

nit: MAC address doesn't need '-d'

I would have used fixed SCI on both ends to avoid this mess with the
local/remote MAC address, but it's ok as you wrote it.

> +    return dev[0]["address"]

[...]
> +def _check_nsim_vid(cfg, vid, expected) -> None:
> +    """Checks if a VLAN is present. Only works on netdevsim."""
> +
> +    nsim = cfg.get_local_nsim_dev()
> +    if not nsim:
> +        return
> +
> +    vlan_path = nsim.nsims[0].dfs_dir + "vlan"

nit: os.path.join for consistency with other users

> +    with open(vlan_path, encoding="utf-8") as f:
> +        vids = f.read()
> +    found = f"ctag {vid}\n" in vids
> +    ksft_eq(found, expected,
> +            f"VLAN {vid} {'expected' if expected else 'not expected'}"
> +            f" in debugfs")

-- 
Sabrina

