Return-Path: <netdev+bounces-277205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WumjEydd2GkgcggAu9opvQ
	(envelope-from <netdev+bounces-277205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9703D1555
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81566300C008
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FC330307;
	Fri, 10 Apr 2026 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCoIE2qw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739353290DC;
	Fri, 10 Apr 2026 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775787299; cv=none; b=DAzmygT4QxIvazctq0twdXquvZq7gVxEtBWxgnixc9girKXwUAKYtJHAD4oy2mLIkAP4VslUJjEQgh/WhibtqBeGAZ0mhwPvvQqiJnX/lllSBAw/YLspQCUh9LYir/HYu8Jl9AgVRn/0fuyjmTB9Dxyi425dTDC2y6OrWjXiPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775787299; c=relaxed/simple;
	bh=b0ijHN6xdedLurNsgVQ/lYvLOuMFihUsVDXKW4uRyFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQw+ijJdR08qDzyvYHFc8SNcqQglS0NI8jtCPBzD5UL7SVyv99nvrCMnvJhx6feZygnfvvOpNcCMdCih3aa4tzMGA3Z5rgZwJWy6bJL6mMWsOmrs7pUJXsmxz6omwyoSgk9Rr8fYhjSIj4fRNnvX+M+sHKgyLaLI+NmEIDTBf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCoIE2qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BD1C4CEF7;
	Fri, 10 Apr 2026 02:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775787299;
	bh=b0ijHN6xdedLurNsgVQ/lYvLOuMFihUsVDXKW4uRyFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCoIE2qwbqUuhhrzQMZjbg9H5CUtmHN6mqFegVGQeCVHWGHWAUoiZog2Swgqo4RNw
	 84G41HgvivvgxFvZ0QU60kjQRXrE7DnUGYZNynbQa2loTmEU1WK9fTgTkMQTI6WNhQ
	 Lv/QqYb3Jme+x/C129Mqh+c6So00r9s8mnjNA5CQYXIz4n3RechFTeQexNztiQ4fN8
	 UsxQ/+YnxZEtl8WGl5YCsYi2fExZ7AXachNq4k2Iq3qtXlvKpujVN2Afg1OR5Fa9cA
	 Uex05fHN/UNXUz63KY4mjSNrUa8YE5d+H3cqih3KHkZUHNbtHa5MDbag6l2fUHv/5D
	 8a+x8xDdCwMzQ==
Date: Thu, 9 Apr 2026 19:14:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Donald Hunter <donald.hunter@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] ethtool: strset: check nla_len overflow
Message-ID: <20260409191457.5432442d@kernel.org>
In-Reply-To: <bb2e7087-aa36-4556-8778-b65d11354779@lunn.ch>
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
	<20260408-b4-ynl_ethtool-v2-5-7623a5e8f70b@gmail.com>
	<adaFjwkOrPoBgzoc@devvm17672.vll0.facebook.com>
	<20260408173943.2c239ae8@kernel.org>
	<adfG99Pb-4QewoQ7@devvm17672.vll0.facebook.com>
	<bb2e7087-aa36-4556-8778-b65d11354779@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277205-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C9703D1555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 18:12:36 +0200 Andrew Lunn wrote:
> > I guess... Should we update ethtool.yaml doc to tell the users to prefer
> > ioctl over netlink for strset-get and mention this new EMSGSIZE?  
> 
> No. The ioctl is deprecated. It can still be used for drivers which
> need it, but netlink is the preferred method.

Off the top of my head I think string sets are used in Netlink in
bitsets. These are the first class citizen string sets, maintained 
in the core.

I'm not sure if there was any motivation for exposing other string
sets (like driver priv flags, legacy stats etc) via Netlink or it 
was just a "why not cover the entire enum if it just works" thing.

There is no known real user space which runs into the Netlink + legacy
strings issue. Hangbin was doing exhaustive testing of the ethtool
YNL.

LMK if this makes sense or I'm missing a concern. If we need to make
larger string sets work we'll definitely have to revisit. But I'd like
to have that helper from patch 4 in tree sooner rather than later,
so I'd lean towards merging this series.

