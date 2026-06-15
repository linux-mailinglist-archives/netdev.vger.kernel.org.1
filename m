Return-Path: <netdev+bounces-299605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MmoTN4VhMGpASQUAu9opvQ
	(envelope-from <netdev+bounces-299605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:33:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0D5689DE0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:33:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=Avu7pGKu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299605-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299605-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0DED3027968
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4286E3B5841;
	Mon, 15 Jun 2026 20:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF130DEB2
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:32:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555576; cv=none; b=mTjGqZ4gYIDEQymIb9zDG2ZbhzAnVSuvGkyyBXcGvOB4T/P+yPeW3OWkM485Xd650gLPzh3AqXLrw6GojGVfp7VhPKFPskBtfPGwu9Lu5UY1V/JE4P8Kvk/jel0SU1AUKavkpKI0FTfxMd0aSimxLOrJHZHHOK4ICBiClEHRK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555576; c=relaxed/simple;
	bh=vyf57u2yvDyqcojmNqD+tFuOF6bgs81sXc5Q88y/ZVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ275EATw/KeRAeyYauy2aogBy1Ou4H8WF8lZZGi5wptrO3rMJRYscPCoVIFTfr+f+NY57sIZrHN1WiMAYygfqx/qSicAFyD5p0DK6KfT7QIeAkxB0rArhcZkuDo9osKxAyI2h3LHS/dQt9YqVtyKFmcOMto4UjZ5Sp6Vq8B4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Avu7pGKu; arc=none smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8857a27041so1061064a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781555573; x=1782160373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjSF43dZSPrUADUnDYnSuZv/ycTbl9Y+Y3hRxda0dXQ=;
        b=Avu7pGKu8eYRrEv4THDxKqJEeXqoCSP1+eIOYlVBH7Lxqz9/mB/ojf9m2tgHd8OWOI
         gSJOFY3mx6UFUrDW+KwDekgjykg9bVPuLT5IQYdS4o4Dop9plLDULf55OyzqQb/bEjf3
         mJs1OFEbzFOIYtzvQYIFcDz7ZQ7MqU0KML1gnp9rzaNp9mkVQhRh/3V3m+P/HTmxlcoK
         V++QVrZvHroxgNqyNwxZ8nq6l20J0tZuZgbBo3dZuOW7gy9h+qS85C0rvHzVzBnNC2SL
         /urtimNkWtG41plZjJb3FjLsVNvLboVi4eEvV0qZZzuQlY5yB5CxrkHg64qkqgQGOo6x
         mOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555573; x=1782160373;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjSF43dZSPrUADUnDYnSuZv/ycTbl9Y+Y3hRxda0dXQ=;
        b=KT3qGs49YzZceV7pUJ1yMz1K+DI9hhxl3ZKSwz4OefBkcRR4PKM5HhoBRthLgCUmP6
         IYj5d5nW342GZmRMbHOJg6fzeLxry9ai3a2mB2h+o4kuRldWSsWTvjC62SHD8zt73SRc
         Xzk6jGxmlCraAHkmuSrQer2BuTZR90fR7z6rFbWv6aulcUEBFcxw97ciNUfhMmxDR585
         P6rGKWCEqlUcBb7/PKcuZthBWisLdFsmqG0AJMpdyRHBKgmGD8mn2WHDFlE4Q8OqMAAo
         Mt2xNeJKaLI+q/ioKhFSKhXV7qdYpgQMq3G+qVv30xyIEdC6INTp/tJVyXGNU8aY3xuX
         HgmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8rYkljEAC4ZZcJqbo0aID6bjW29d44QDfyJBsJXc7vS9tnocsXRLiryT3e4EcjoGo9PeMUWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FK8S0H8C9jE/YZV6/K76nLEXrcG53pVbEmNlp4SkkISqM9xu
	PZ5p3LdTkrhFXdpoAy9gmYv4DH1AV/JlJCKub/PAMIJYWG2FJvqbgknCxfkvHuJgvb4=
X-Gm-Gg: Acq92OGWTTmRVD7Ua5xFQBAxcRcHW+qozMQf2P04qF4ZbPjeZsi2WAohjFJen+ztmB0
	vwnytL5ldMJLhD80kPb51Sz2pSgQngVRU9buX8hNC4nPwflP7+VpCIBQqU0yt0iBJB5sGC85smR
	JSpzrmrTqT7mBtm6e4rIPuRcHkEF2DXye6ozv6H8WbEOtZMNEeJ8MJgwa4XjXI0pGtwxHnCHJ5p
	h6R/VBPGhIvkQzIu41dbee7qTHPl5Bf4++bI2EA0/UGglS9ChMEskYShYtaoDgK9bcDE67DzfkK
	6wmDij8sAMfi54AHmUdOrmckvFGMk3yYNzsFBt6fA1PiAJKeXlu6SdHNejHnVINBOogbycmKGRx
	fvEI2EQERV+acWyPGfzOl8UTz3GYRnrI3jNfRLc47OvZ5mCz/nfck3kNd/hY/U4SsnW/7ftkJ6k
	W+l7E=
X-Received: by 2002:a05:6a00:2e12:b0:83c:928:6e5a with SMTP id d2e1a72fcca58-844e196615bmr13494623b3a.13.1781555572982;
        Mon, 15 Jun 2026 13:32:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ad0118asm10179696b3a.27.2026.06.15.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:32:52 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:32:51 -0700
From: Joe Damato <joe@dama.to>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net-next] octeontx2-pf: add page pool ethtool statistics
Message-ID: <ajBhc6nliDO2m+ST@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
References: <20260615032141.521667-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615032141.521667-1-rkannoth@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299605-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,marvell.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D0D5689DE0

On Mon, Jun 15, 2026 at 08:51:41AM +0530, Ratheesh Kannoth wrote:
> Expose page pool allocator statistics through ethtool.
> When the interface is up, aggregate stats from each
> receive queue page pool and append the common page_pool ethtool stat
> block to the driver's private statistics set.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../marvell/octeontx2/nic/otx2_ethtool.c      | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

