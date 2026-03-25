Return-Path: <netdev+bounces-271459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Aq1GJWew2nGsAQAu9opvQ
	(envelope-from <netdev+bounces-271459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:36:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75D32179E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 528B7300BC79
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD922B8AB;
	Wed, 25 Mar 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP6PkZGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B893382C9
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427675; cv=none; b=PeXqMTFCrOKJjE6UEQEGpdddKxeykk9xbJVTLJrPrVfJpC0zfB0jdQbIGYnSI75+nnGAG9zl/4sLWveRpXgaWnMhng7vOf6IKe6yoNmi7xpo0NFj8UoP8StPaZmGO1sg1o+Gz8q+eWBMlgvBzPrN+YBwrrqPXyQwks9HiKxrAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427675; c=relaxed/simple;
	bh=4V3lTPm1S/eM2tQHrejTl6/D1Ute/YL/Ahl0p2KEzUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6e1Nq5/SIHflQHHntqucBlOgnbidGGqFzuz5W3CEtJbJyHLGX5RVJW+m8VjZsdRA8RUrwlNoQF5merBg96DnCuwwt5TBTwMz0cKD5kjs+0zRPLS9ssv3BN7TTmRVSDW/Gc2mY+cSdFzU/lYMl7Cf30sLW650M8JytNgk1nnB5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP6PkZGw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fca3245cso7420525e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774427671; x=1775032471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVyNhJGEVYhfPhLuJOyBfAjamXKzSj7hV+JkaTH9/tw=;
        b=DP6PkZGwgF1Vd8KTEsQv3IUQy2xcC0W5CQyUlIkVu+wbPD7qG5PWZ+R82TPK2CntyA
         Q48kPQmdCXMUSYdiL6mqeDEzvAG23Qi0HMsJBY+bYVisah7rlZsmBEtZBJ1GAskysKjH
         IvWSlKcNlkWJFNj3Aqn31x/XV6o7qoKBQvSOKZRqFu6Qf82iqZ4B6Rijk1a0TqdQE9nA
         Rt71rB8Q43AZrzpevH54gIvhbWyLMVRxviKuGrHUMJdeX+qoYI6E0hAgRn8LCEBswofQ
         W1UWYI3pSooBv8yhYSL0VFGJTZ/aTVuD5bBYa0hLixlgBPQN6ZDsNyBHzZ9qWuF/z6um
         vNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427671; x=1775032471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVyNhJGEVYhfPhLuJOyBfAjamXKzSj7hV+JkaTH9/tw=;
        b=RWovw6ncFS/cK4XabymttQonLL3gWCE9QIVVpchIcMf03a8H0HN2KTEoqhCzhbbDrR
         3tisFgDZqDJIv0AnVaLPnFYxJKMBE3EMqCOO75ZWsUTSFXe9alIMaP9rh8mJRn0yxgub
         67nm/AldybnLMtglMkRqNVSfFAID5z3R/81+3IjcR9ZvrZAvG0XX62LMbsF27F8bIM+H
         MCCLCIuyCyDWDRQWBRY03ezwx/c0vgb067otEHdcRs+PVY3e5oFRiieFA57FoAL2GBhe
         kU+uhR0jOpm6/kMP64bobjgxehyb6FEmWOhaLWSAVcefGlcq7BOW28KxuHqS290d8qhI
         R4UA==
X-Forwarded-Encrypted: i=1; AJvYcCWDDSYRl8eK66ZWr+nJ4fVp2bneorztVl4IEUK6XjFjaltbBzugd12wXlwEbRlwK0gpmlrTjZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUz+wjFxN1OnrhCABG+cm9eQBQihaMMeilHYz2OVn+3LM+LkoK
	MASoRAx5jTt+cpYrqUORXmYPix5rilinuPydrjAe9Qfg+8FWCUx390XB
X-Gm-Gg: ATEYQzxaXC3C1S5rSesjfMH8x7AaSKOOJ//Mfg5OU1MJp0FGvuq7Bcfbp6P2opsf1DJ
	5J2pF/khiasYXHKncyDCkJgeUWhDMMPUvHP1JW4YNLzIhW2k7BZaX5pFNx9xOQuNNrU2JDo3VuP
	Wr7cjqntfIXahDRIqr9D3HkNvIL7nD0zBIb6wtCqIoAGy3cfktAgLJdPVjQL9AxXRQ82BeVqPlC
	axFQORcXaw4a6GoC0Y+zjO0ohTfVdw/MnajjGXp/LUZmhlqAJ5OrgEi2BYuVNkAQ25hirf20xxW
	LHxdeMw3CtqxHRYXlRZd2TCPGaJFzVjalTZ/kZtO/UayFuf6HJraVE09Y5SuYQcNedjkFrn9tVy
	coeuGeaiFiCfOoolw1L1lXf8KEja6/F+Q+8gsyr84q0UG5VoyafEPh74sp5WaQ6VlLiUDOj8NGc
	LT/PIXbORcFNbFaQ==
X-Received: by 2002:a05:600c:4e89:b0:485:3d00:f16 with SMTP id 5b1f17b1804b1-48715fe6f59mr22744185e9.1.1774427671028;
        Wed, 25 Mar 2026 01:34:31 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:1955:43a4:bdf:48ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm45607872f8f.8.2026.03.25.01.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 01:34:30 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:34:27 +0200
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
Subject: Re: [PATCH net-next v6 2/4] net: dsa: add bridge member iteration
 macro and port mask helper
Message-ID: <20260325083427.eef2dmpv6lnyvlmn@skbuf>
References: <cover.1774136876.git.daniel@makrotopia.org>
 <ff936ce4ad3044102c367c55e7a455ab0020e4b7.1774136876.git.daniel@makrotopia.org>
 <acCllYmKczZrDgv9@makrotopia.org>
 <20260323163104.a2d2hbs7jfgsptj3@skbuf>
 <acMe0vr5GT8ZSfI3@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acMe0vr5GT8ZSfI3@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271459-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E75D32179E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:31:30PM +0000, Daniel Golle wrote:
> On Mon, Mar 23, 2026 at 06:31:04PM +0200, Vladimir Oltean wrote:
> > On Mon, Mar 23, 2026 at 02:29:41AM +0000, Daniel Golle wrote:
> > > I'm also planning to introduce dsa_bridge_for_each_member macro in
> > > addition to that which works on (struct dsa_bridge *) and uses
> > > dsa_switch_for_each_bridge_member.
> > 
> > I don't like the dsa_bridge_for_each_member() name. You are likely
> > not considering cross-chip bridging, where a bridge spans multiple
> > dsa_switch structures. That is also a serious reason why your
> > bridge->priv design is not viable (two switches can't lay their eggs
> > in the same basket without overwriting each other).
> 
> dsa_bridge_for_each_local_member() ?
> 
> dsa_switch_for_each_dsa_bridge_member()
> (but that's too close to dsa_switch_for_each_bridge_member imho)
> 
> I was planning to have both, dsa_switch and dsa_bridge as parameters,
> of course, limiting the scope to a single dsa_switch.

I'm not sure that we do need two iterators. Just
dsa_switch_for_each_bridge_member() should be fine.

