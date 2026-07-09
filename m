Return-Path: <netdev+bounces-306325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nrY4BrPYT2p4pAIAu9opvQ
	(envelope-from <netdev+bounces-306325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F369D733CBB
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 19:21:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="bSr/uqyz";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306325-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306325-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FFBA3005314
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 17:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F143C7AD;
	Thu,  9 Jul 2026 17:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FD43C076;
	Thu,  9 Jul 2026 17:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617710; cv=none; b=PFBaxSbyQpQmJwy1yWsgJXRKt5ppa8mOiy8lel8E6cnUQQsFJc0C06p/lx/TwkADe+tLgM8VHcG5OzUE2Kxgj+c9SXuyue1o78965RcSVcN6PwlnT5EFMV7qbBMrUuaUsr3m9bL6JulPuTWR7b5yX1CrxLkkoWedq3NdUbytA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617710; c=relaxed/simple;
	bh=c5rCvUfv5qRx2UlHcco6fj2IzQZUFugwoC5z0NJdmKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ0BC3yGzPQzCOylTHFLh1pXw2ejLuHztF5D5HJMxAa8NkuAT95KVSLM7vCl6Y6rHgQG01Wz1mqbsSi88F6M94CuV/R1apnT929Qj/Gi6FF3cRxPoK/OHOHt6mo/r4kt5KBiH6PynqycocpHaHHOvhaHTgNClmzcBpUNowmuL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSr/uqyz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3501F000E9;
	Thu,  9 Jul 2026 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783617708;
	bh=ygR5jkfSRc2DlZer6eJtodZHcT2Z+c8aaRhL3htsIjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bSr/uqyzC3j3xoA4wGfF9lHr2KXZN/+l/UmNSYE03z1R0OeKLbg4Rfh9aXH9+6LkS
	 esD9c4tdM7sWlg7JJlo+/9I1FWs/wPoaayFu28nBLQuob7VS9GCSFHWA/m2b/v8E4s
	 oL0hgp7UjT8Lz/JJm8qfCWj7womYScyFwh0R8IhOt1Kvay+SrePNevTOuE5olcCWeV
	 rnXhKHUDmqZoD4yzXdtWPXOnylDplr6eTu9HjgdkCaUR2E1RCsGRqo0QQjdKpkQzUj
	 8fzbWRXfvlOsa+jwWJAluS31IZI0d2VTo6CHv8/qy022kBBsQY/wolX4siFBzKakAd
	 G2E8ugD1mjrcQ==
Date: Thu, 9 Jul 2026 18:21:44 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: alacritech: add missing MODULE_DEVICE_TABLE()
Message-ID: <20260709172144.GX1364329@horms.kernel.org>
References: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704152053.49780-1-pengpeng@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306325-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:LinoSanfilippo@gmx.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F369D733CBB

On Sat, Jul 04, 2026 at 11:20:53PM +0800, Pengpeng Hou wrote:
> The driver has a match table for the pci bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


