Return-Path: <netdev+bounces-279510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 20lQBQWh42lVJQEAu9opvQ
	(envelope-from <netdev+bounces-279510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CE421719
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A83623024164
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05962C027F;
	Sat, 18 Apr 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWf6sF3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1251EB5C2
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525569; cv=none; b=Op7ECY7lGAAXI8K3vi1dVTVsCfLd6EYm5VFEuCXAexneLqzN4uVrAONcWUQWLVI3k22893iSoN90MvUIz0WKq/NHbZwRjzzTGPwvKN0LO+1kUJ0bBIvAZGM0B+OpHdl27cv29ZmBUAHyhsapZPebuBsphd0ploNl6uUuNdm4kUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525569; c=relaxed/simple;
	bh=P8E15VCdTNIBX1BOMvNb+PldnL6YcssvUuh4J1WaKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFQhF51E9RpsW5KrVnx4tL1KKaSnWaWmbmpgRSAuCp68aprU0bnoFHYpQk+rTrxz15/gdiRFxhALFv0d4qb0E8nhWulIC9G+HPCkWG0NhsLpnQ66dEmbZbTFm4b6lmyQQuU4H73rwqJY48UUcXPvouktLncGkkknM8SDvATfUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWf6sF3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0B2C2BCB4;
	Sat, 18 Apr 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776525569;
	bh=P8E15VCdTNIBX1BOMvNb+PldnL6YcssvUuh4J1WaKyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWf6sF3H9fANgV5eMOyJr+acBTXVd6Yni6c5IW0E2faAaFwyTZwolrHM+W2SmeYCa
	 +W8svoWkjKzXlsvRht6CYbtHPu6w5zZLniCaKapMr021k5mfdJhwjUE33pm0XO4gO/
	 55RbDcZxmtOACwOTdCeP7yjQpiMq06CKhoIyo1GHXcmGjsUO63zPpTTbK6rSlb3kWW
	 y/h5Kckn+zNxyjpWnGqwV42eb4lumzHJg34g905CHPq5bAVrSZNnVbXAVRvC0YFXAY
	 AIkm3tnkqEqJscB0tYthHnGIMaXALrukfNjFzeH5EflsXO58eh1AatLNtkYyt9JRdf
	 R/U8o0rCiWCZA==
Date: Sat, 18 Apr 2026 16:19:25 +0100
From: Simon Horman <horms@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] slip: reject VJ receive packets on instances with
 no rstate array
Message-ID: <20260418151925.GF280379@horms.kernel.org>
References: <20260415204130.258866-2-bestswngs@gmail.com>
 <20260418123929.GE280379@horms.kernel.org>
 <aeOXJoeq6VkCnqAH@SLSGDTSWING002>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeOXJoeq6VkCnqAH@SLSGDTSWING002>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279510-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 615CE421719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 10:37:26PM +0800, Weiming Shi wrote:
> On 26-04-18 13:39, Simon Horman wrote:
> > On Thu, Apr 16, 2026 at 04:41:31AM +0800, Weiming Shi wrote:

...

> > I do note that Sashiko flags some other problems in this code.
> > I do not think that needs to delay progress of this patch.
> > But you may wish to look into them as follow-up work.
> 
> Thanks for your review. 
> 
> I've already sent two follow-up patches for the decode()/pull16() 
> bounds-checking issues:
> 
>     [PATCH net] slip: fix slab-out-of-bounds write in slhc_uncompress()
>     https://lore.kernel.org/netdev/20260415213359.335657-2-bestswngs@gmail.com/
> 
>     [PATCH net] slip: bound decode() reads against the compressed packet length
>     https://lore.kernel.org/netdev/20260416100147.531855-5-bestswngs@gmail.com/

Great, thanks!

