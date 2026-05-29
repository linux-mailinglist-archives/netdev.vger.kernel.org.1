Return-Path: <netdev+bounces-293146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPc+CHKkGWrEyAgAu9opvQ
	(envelope-from <netdev+bounces-293146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:36:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E90603B1E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31BF030A5DCC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F093ED3CC;
	Fri, 29 May 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNpj1KeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F653F0745
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065142; cv=none; b=Bg/RuQTlKcLNLKQfkOfmDeB1FlfCiQyDtlaUn1QgAWIH5bU/yXRYoTh8fCFGT241lkh7rIc7RkjMtZI4FXqSurLdcBs3kzJmGYQ1aWTpJv0qroGIeq4zM/jh89Q6ZJ7twvwjH8s4Dyhe3qNndQwhTsvIPtAbf+n7CLa8aQRw5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065142; c=relaxed/simple;
	bh=+0c+HxADZU2QkkkE+cXlphnpotcymvFFiatgaDEuVfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I97h8jjtAk9N4yRmZWXwqmczqYSHoTC/uoYkcuJl9t+SIeepoNbUtULSvUCpJmUzQ5BKyTOwyrNxrzhIAhLeL6fAcxuWo74YNlxw3jVoJJY+VwltfNIk6R+mp9D885OoMasUz25bRNkPOkXhjZuDgtvTBEVWFPqyjN7rseN+LoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNpj1KeC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso83355605e9.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780065138; x=1780669938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FxVV6K7KG/cwmQNSCVh9NB5R4ULQVBXkZnUE7ZqabS4=;
        b=TNpj1KeCyABw9TVHyynadujAdOK7zawbbKUMMrv3tvFFS7W7iP3xGk0SJIxDPON48Z
         rHuC+rGRHBDOBEdgfZnS+SC32BaTux/9wYBUH7gFTLbpmP7dRY0a7+9UuUKwoUv93bR8
         haWiiKwL0emwRa1GAAuITPXqluX6Np0IHnYipojEy3G4yJ/xCtxRZ6vR1iabBAEI6Yrq
         dMoc9JSGK0/TUv4ftNvJCJt1JrG0Gchn1UD/Vv/75a0x13JOCafJt3rhPbqXlZq6socu
         o3qD6s+lpVgYk3UmhwXnnqhSchKUw/NQBFXDm/ogUPfImf88orTy65Pe0/+HirzHnTy7
         QuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065138; x=1780669938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxVV6K7KG/cwmQNSCVh9NB5R4ULQVBXkZnUE7ZqabS4=;
        b=TPxgKSaFTrhYDQsJWHl8hpf72PI3aDL1sHX3s6YSrTmp0ASunoVBk1IEtxcbptUJ5A
         S7TndTixJJ4TX4VlnXS8ExvBJjMtapujN5eDbF6MJwd9Uz7qp/n12znOCjyfEMXd64Yy
         4lORgRyNjfq0CPsfSAPA1RlCDQz9Jqu81eToYGFJCUmF4LGJsTvQ//KtC8CaMTN0Lm/X
         PUPe+j/sgh+I4x7HDXB2/5eCa6npTc5YaxYWf8QEh8QwWPgZK9NtpbtY0ru+kRgiWqin
         MHcqJKGFWhPFgJRo7zuISqM270c1jJTcSsm1ABCJ2KFWgExkA7h4GpQFom1YJsPn5beG
         wN5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8KDf8r9YPNmWGRuht0+ISYN6Ux1PnOEsd8Duyl5W6Tz7mGJzFbOpHfej//unr4HIiamj0e7ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4XGgdX5Z86x0xrGVzSuSxeSSSifAxOdvzPEPHT189ucrPkdo
	tZ+sti7QRyTNlzdby48Jow3jQy+zsv6dxn5/CrO377SMdxFhEwoIWua0
X-Gm-Gg: Acq92OEyEC6DpoYRt9hauj/mVFdZTnFzBy60SIE31GqU7eq/HfwDQiDqSjCV8fjpAE9
	B63NsXkmkYvOlbc/X9TC09x1OKr/z9Sz5vIygRevm1S85dF46tPn1RtS/D6rlnUDuUAGI+YznT0
	Z2KhpFvrndigskhuiAZ17vwJAC6J3v9+LWy/S7N2PRzU9Rwar1QZQONxFaGOO+pudwF3+73Lynu
	EUblz7RL2oR04ZacFzl7rd2DPlwnKWNy46oKmmvqJgyFKmkWvyN2AgzSZ1VoJFNjTqutKZSU/v6
	3CQyG8cYo8FTi2eFx/+KPH8GTA/Lq0OQW/cWKFuR2AV2I3tCCozR3ObTinGt1poCHrpV14cWlAM
	OEnkVBQSVhtnEi1ezP519W6RnBfqLS6LqyxzejaEQ9y///r6RMgTPMbNY3dnKhpnwkIEzy2Ucei
	pFCWeZfFqZAC5hnTA66P8Pjp45F12dpF83Fw0sMEDCTtM=
X-Received: by 2002:a05:600c:4595:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-4909c0a4c04mr53887165e9.9.1780065138102;
        Fri, 29 May 2026 07:32:18 -0700 (PDT)
Received: from cedric-laptop ([195.225.166.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c130ef9sm16292665e9.35.2026.05.29.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:32:17 -0700 (PDT)
Date: Fri, 29 May 2026 16:32:15 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Luke Howard <lukeh@padl.com>, cedric.jehasse@luminex.be, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <rqvaiyu7qm2il4vhdhgwschodlw77fqd6hiszuwmffjvdthtkc@do7mmsdz77qf>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
 <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
 <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
 <gigqfzdzvtoegjd6kb73g2xv4j7uq7f5s2lkrwspiosni3c44p@him3vof5vzrm>
 <793226E0-82B1-464E-9A18-969F773B70D4@padl.com>
 <6040cfca-0af7-41cf-b7d0-00bd8be837bb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6040cfca-0af7-41cf-b7d0-00bd8be837bb@lunn.ch>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293146-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[padl.com,luminex.be,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A9E90603B1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 03:28:56PM +0200, Andrew Lunn wrote:
> > > That's not the same logic.
> > > If one of the two function pointer is NULL, the other can still be executed
> > > (Maybe not that likely as that's probably a mistake in the driver)
> > 
> > True, but agree also that it shouldn’t happen (would be a driver bug).
> 
> However, a kernel splat because you have jumped through a NULL pointer
> makes a good bug report. It is much more obvious what is wrong than a
> report that somebody tried to configure TC, but nothing appeared to
> happen.
>

Removing !avb_ops->port_qav_write || !ops->port_set_scheduling_mode won't make
it jump to a NULL pointer. mv88e6xxx_port_qav_write and
mv88e6xxx_port_set_scheduling_mode will still return -EOPNOTSUPP.
Do you prefer removing the NULL pointer checks in those functions?

Cedric

