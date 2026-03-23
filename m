Return-Path: <netdev+bounces-270605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNFqLFprwWkVTAQAu9opvQ
	(envelope-from <netdev+bounces-270605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:33:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 396982F84FB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250FB32A6ADF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F73BC670;
	Mon, 23 Mar 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMScEXi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA13BC691
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282370; cv=none; b=q8SRHwoAxm2h8dfTDSbLOmTugGDpsU9e12IsBsqcYs45zeILUDF1wjDvTpFD27ffb30r8eZ2d2gLmean7Pp3bMw+VAVXpTUBeMoP8LQJRGMMh41ykLxnWkacyvFtlAv6byeeyJvjI4Er9J1UwteWVOLuIE2MZ8yPir8a4K5ZsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282370; c=relaxed/simple;
	bh=VOFUyeohAJ07OONVhdkNQ8waaN87UYJH1sjvCbOQG3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrPLHmFl6xfGyFr+klBLaIx24/bTJPx1xzGJH+McubZnrCayrKZlwAueWfUl+zAmoyIvGtLJxoeKRgy5lFBiK0NNf10TNC+HAhfK4sD8r32V9hwHrzp1LDK9B+JXk6J3FAlXMX7i6AfKuRfjUdPTfBL02MVCHN+sVNN/TEjxO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMScEXi5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4836cd6e0d4so5707085e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774282367; x=1774887167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOFUyeohAJ07OONVhdkNQ8waaN87UYJH1sjvCbOQG3g=;
        b=hMScEXi5oDc/Q9cO5lVi7FeYllwzX3sPXhHM2aifh9ArFcI614Y0dSnIm92CzK4gMx
         Gd9dZqvXvSncME7f/3KZ+RbeiWq8ehwqg5OR2iPqxHAXq2S8IFa4FfiK40wLAnuPovw2
         Pn3MIr8bf2kwQ8hTQTgsXDiOtmxG3q7CD6t9CbrCtQYyfM9ILqCs+RcMxUKaac5Ca8hG
         X7ce8munO36jPAGRwn27WmBrs+IF/i4TqFhCAiQmWzKy8sOGsBK2cOALrzuh5ZanbEWD
         WLrqqztfOb3734r/pz4fLcwaT/mgtj9kwOYf30FXbjMf4yfJLzS+/m2TeP1KrsH409Ll
         E71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282367; x=1774887167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOFUyeohAJ07OONVhdkNQ8waaN87UYJH1sjvCbOQG3g=;
        b=lvwWPvWtDFxaEk+Yy5Ic1fGO1ZrJkW7rNnhZk8u0GIf328bEZyKFRwZFOJMN5G1KDZ
         Pr4BzsFLJeBwFRdFozWayOSWne3exmqLHAsZyMs6GjSwK8jlj8tT2EzfPpULfh2xAI78
         NtkmTCaMABDW+KG7zz45Yz2pG3HU/93H3lj8o30tMuy/UrfMgJIQdbXIhWTwK4YSBf/V
         C6zvDPINtFge07vqhKre84918IwE9hwK3fgvLgvGwxyMBZ8tC8HzyfWNgvCh7pXF89bc
         ghL5y4g2DjvjcrMPa0FRTf54TYrITwpfJb+t1S5wDuadTbPy9wefIZNn6cWd0Kxe99aE
         46kA==
X-Forwarded-Encrypted: i=1; AJvYcCWegQZ3cwGVLQ0rVc3wW0jxxbp613tGYXhSVwIQq2xyn/dvgBLKeRGTYrRBE2o/eLbbdz/6Ggc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmA500Z42/uQ9qrfE9JLaieNaxpNbuTgvyksBhTrfvrRLVBj/M
	tXV3Go/NNMuOLdicpWRIeLxM3SeMWNKFnrV94SUgumIGtNzYSZDteu/1
X-Gm-Gg: ATEYQzyBdqdWeLZTTiHdaUAsgFY5H6Fy35UFgbcAddWBWn9Gkgk/vex51Fi+SgS0scW
	r9pJ/sUrHemdOYpYumqf+xjxbsYz2me6ol3pHd/yPJzlx92xcWGegPaLKoawgQvElJvnWUdIwQW
	x4kXuoIo0nF763IDTlzhpw+I9pcZdRkp/X3296Zw6+Y7Gs+IXNj2LoBBfTRuyy6oH5PXfjH/K2j
	cIpS+DYGMXXaezHgRk/AHj3HO4voe6TjdVQWZ7ZojyMG/RKjP9Znsxx2mlmvqScZbbMz6Mg7y/e
	DfcVE12ybllpRim6ybp9QCFxV83n28TnB7+przdaR+ZnQtWmrIilbAm58AETCoxLkISYZ8x9bgf
	zJIyehU7UgEHvbACO43g7WkCeTC1JDBC7s+WwzP6O+2OqF0Vm0lHC3V7nFpugja+Nmv4UbEJMyx
	zXhdQuP896TQegWFM=
X-Received: by 2002:a05:600c:1f86:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-486fee2e4efmr94768485e9.6.1774282367163;
        Mon, 23 Mar 2026 09:12:47 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:653e:51cc:7cba:e6df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe889652sm117964405e9.2.2026.03.23.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:12:46 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:12:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v6 1/4] net: dsa: add driver-private pointer to
 struct dsa_bridge
Message-ID: <20260323161242.52u35huiot3khq5w@skbuf>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <4ff5b936b1f4ad31ffe132aaef798d247a8ac812.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff5b936b1f4ad31ffe132aaef798d247a8ac812.1774136876.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270605-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 396982F84FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 12:18:58AM +0000, Daniel Golle wrote:
> When a DSA driver offloads a bridge to firmware, it typically receives a
> firmware-assigned bridge identifier (e.g. a FID) that must be stored and
> retrieved by subsequent operations. Without a place to store this in the
> DSA core's bridge structure, drivers must maintain a parallel list of
> bridge objects and search it on every join, leave, and FDB operation.

Why list?

What's wrong with a driver-level array for lookup? The bridge.num is
guaranteed to be between 1 and ds->max_num_bridges.

