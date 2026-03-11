Return-Path: <netdev+bounces-266780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHpLFX7dsWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-266780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:24:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B35EB26A608
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328D0306B087
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E58D34B1AD;
	Wed, 11 Mar 2026 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp3Ultb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF912DF3F2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773264251; cv=none; b=DKbl7ExtNIsqyMzYTBIQlUPXoXq4i53X5A7m1+2JUAiurIoTIQ8jfK+CVSdoN5bZw/FPNEw7AN2I8xA9eBZ1wpWWCVJCdN+Q8sk1mC2wE41kdJ2JtwTnZxGISsNOCwhLPZrSJXSCbe3enyhi4x7gwNQxVqR5aLByl43jzd+3+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773264251; c=relaxed/simple;
	bh=XfWqvbsVc9ds4VVMoGSCLr8lNokOczr/75K3US0vH7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV9k2CNfojQjjLqznWqmb6LgGYt1nICbni1u13DudihlJ+Lv2s1PGZdZ+mmcUCQMClnlyGpWAW0VpHVvZCubc23UE9NYdSWWyIiosMe0ci9wXWZe1wNE81EkX52Tajuz4Ltnj85cBQE0aTIVtmzCGFVbdMexzat4zeXNgswzOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp3Ultb3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439fbfb12d0so46322f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773264248; x=1773869048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XfWqvbsVc9ds4VVMoGSCLr8lNokOczr/75K3US0vH7E=;
        b=Fp3Ultb3XaOiT32t6j67WhylIq6lmQPUsj34b8Vjv6i4EqSJSg9LvIPD+5LsY/DKe1
         l0DOyU//8hGw3rRgBw9CVGyfCFkJHtGsiDAnAyQjmvkNL/1sNOdk3zyaVbUOpXIfgyXF
         Q4gIkLMj4+jraYjo6Og4XKXFjncrIGBajokBoeGcnrkytoBJV1krvPEWwrcrtVc1buC+
         hnxmhno9TmJM79vprctGRSMmE1i3VuYDa9tN0mw4J7O1QJJYM6bR/PlLfjx6Y7o0dqvG
         BS6gdXyrNcmbmCWVEfSfhF7udn9NRyPkKqBwgyv7K3nVttVZVPgqH1zU49SoB8hG5d0P
         l7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773264248; x=1773869048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfWqvbsVc9ds4VVMoGSCLr8lNokOczr/75K3US0vH7E=;
        b=XiiyyryJPk5zcMnbw1TkczZgodu+AgBnG1vbqCOrm8cCgqts5cuORg4PqjSlRIauHZ
         o3AvZA4lG55bbq1wQU5Qi5XiuOyVvJp/M8urOfSL50G39ma1wg5+JhmCXfgM5hXf/XVq
         XP67RmG93AzFDusPC9ET1m4WTLfcUmYtOAZW6R/IBalHAG88RFUxvBywd1GdsWZlIS0A
         nhytBzRZiKhIcQ8xsGfbw0T+UPQb+AqbLTkewxmEfTV0mux4/BFVl14OtmTZcXZRKsS2
         B3iRJB9nSwziDrCs/jNWLXPSAuLPWUl2KQQWhB3LXjHSOiJaACiliYz3wuU82rPQKBrP
         S+zw==
X-Forwarded-Encrypted: i=1; AJvYcCXWUVFcUGTAobmjbLGBceow8VbMErcMM6G2uurvT/SN1pApDRedhrMI1HZt766tDAx/6xXOsnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqB3PIxNK4RIa0shG4Bp8Dmzwld6PGDCI/LO4LMoTzTHEvsuBB
	qIykN6QrrDZd2nC+n8aiXjG7jc77up7qpgdPmAx0dvFGDI4yYXvQVd6U
X-Gm-Gg: ATEYQzwKDAMXEmp5QrKRYNtInDuQEqrPSIoj//B4SlUic0/gaFYOfMdTQdwKDq5tZv8
	JLoMajddBI9obZGo9UM13G6IPN+yyHgqRl+8ipSgwYFpWQWmwCigf9eDVel3kI0DCzYahDUsG+j
	dsFNXqY3vtZvOEpd9EFIeTwZN2r8kS/JYJjoKclgd09FZntCkEkIPEe1sqqo0KLk/zlypqJ0iYR
	de/U96bDaWV+WSPQ4BTC9cno86hCrySlQeNSt2aCP3iB9Wo4oXO4TEI4hSRRRmr4Ie4AgNpK0B/
	YhmjjDfTTPYp2xsOQqnHYvfegIzkgYkx9whaZLIWu/RHME3o2CqqegCieSADAqvPkdcAHDqFuv3
	ytzDID2wcULLY0OaeEYpDrjkwySQxV37fEOPzcNJuZG4/6Lm5EJMX3mz65IWxIYdezFuBGh9Ijh
	O+TAEl08GsUSr9Gg==
X-Received: by 2002:a05:600c:5491:b0:483:7d93:9f8a with SMTP id 5b1f17b1804b1-4854b0abbddmr41110555e9.1.1773264248026;
        Wed, 11 Mar 2026 14:24:08 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:e489:77c9:805a:398d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm208565585e9.7.2026.03.11.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:24:07 -0700 (PDT)
Date: Wed, 11 Mar 2026 23:24:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
	pascal.eberhard@se.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
	Tristram.Ha@microchip.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260311212404.xsx55lh3gnuze253@skbuf>
References: <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266780-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B35EB26A608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 05:58:32PM +0100, Bastien Curutchet wrote:
> In the end, it feels OK to me to migrate KSZ8463 into ksz8863.c but it's
> hard to know for sure before actually doing it.

Sorry, what ksz8863.c? I may be misunderstanding something.

