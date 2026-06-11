Return-Path: <netdev+bounces-298330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uov+HyQVK2pu2QMAu9opvQ
	(envelope-from <netdev+bounces-298330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:05:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01410674F06
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:05:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hIqa7+L5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298330-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81952303D4E9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293443161BF;
	Thu, 11 Jun 2026 20:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596A41C6A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208354; cv=none; b=ESYjaEGyJ0K3xkynsSLC7Xc+x9phxJHxV31ydYPBBnbCu2b80bODkpnwTHkkeWpO/G0XiKeHskFXZAqQCgzMmeh3Bz9ZngLlF38pmcp9noj9YH/wEHXeaZx7SXU+/+HQLkI9p9gN8pQbb3SGQYTOS/hAfLtMuNcMYcOnUbrFPok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208354; c=relaxed/simple;
	bh=FtbqDhS0Pa0r8jYOj6VpnC+sRqg+URulBLrpRIaeTKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1ZjeY5WErPy5z5GA3YVWvgLTrKtXdAOn7+5KlKlZLMaGM8Sl6pn0KB8yjpYuH/RWRdCa9sBAXxHx7w59XxGWRNyt9C+we5tJ51ju4QhEXK4akA+0ZdxSik1halJFeN5PGrJJe2nu0RDUAYF5aoeaMc9E8rSpDdj36YmbWYNzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIqa7+L5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9201F00A3A;
	Thu, 11 Jun 2026 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208352;
	bh=vnIpqTeqEGomSv+6TVEDldbVU2+bN9ipwFUtdYEtb4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hIqa7+L5hy4RuhKcFmiu6jlBg6tL1mwrHtjXR+j3sMVRerNPkiRT7ZevUJ4oqg1nC
	 WfH2iF3dzPhzXWYEtvqKszHHgL3OoWAzIfwC3ZPOsUvClW9GShmw1xqZLXNsbUWQ15
	 L54+j6t2Jz5J1DUiA773OcVz9tb6TO3os3Y+y6sOAZl4c71nRBgVWwxe9fLCDvkyI0
	 AFjiVRaV2Pb27cKIpNzxEngx7oAjmBaRv3YfC5CSrpDwsrsN3sVRNcHKkexQtMMKIg
	 S41BtKyb/3Rc5GyJDd6jfkn3nML5vyX0bMqtm9RYQZZ0Eh1g8jGU+Oja20UmTWJqcr
	 d2eCmF8tvHEKw==
Date: Thu, 11 Jun 2026 13:05:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch, gal@nvidia.com,
 jacob.e.keller@intel.com, sdf@fomichev.me, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Message-ID: <20260611130551.0af71a7d@kernel.org>
In-Reply-To: <20260611130520.350410ab@kernel.org>
References: <20260611200355.2020663-1-kuba@kernel.org>
	<20260611130520.350410ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,m:kory.maincent@bootlin.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01410674F06

On Thu, 11 Jun 2026 13:05:20 -0700 Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 13:03:55 -0700 Jakub Kicinski wrote:
> > Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")  
> 
> Ugh, wrong fixes tag of course, should be:
> 
> Fixes: f9a3e05114b8 ("net: ethtool: optionally skip rtnl_lock on Netlink path for SET ops")
> 
> I guess the GET side was also wrong but its harmless.

I mean -- so it doesn't need a Fixes tag, it's covered by the patch,
of course.

