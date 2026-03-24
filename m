Return-Path: <netdev+bounces-270838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC7WMNftwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:50:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BE300B31
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A3B3019BBA
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389537B01F;
	Tue, 24 Mar 2026 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTq3q854"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065A339863
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316745; cv=none; b=k6gH+bPnlsJNkqEErQ3ChBx17N7vtKgfbATHAt/wv4ruKhVxcx0FlXT+moASvmUB/ZKGW17xIMbewT4rDp4qzY1aqEerJ7QNeQY1XN5ZLxwt7AVHGHR10RWE56iqOtwBEYd/IUq1hIFQPj9QeYtHshJR7gryzUVxMPRt67JEGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316745; c=relaxed/simple;
	bh=7197zyylyhbyfExzIW/Yxv7fatz1gEPm+HHyiIeHcdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4bT+/uSmUgpPvzapp67d/6YVflV5qeNmCDyGzByd4giEeTQyAmRJ143VEl5/4pRU7CLaieoMGSaTHmZKiNvYmgGKMfps8lUifvVtReDHhQt6fIINM1tP3L+niuJiZ10sKh25YusYWXBTZn4ce0Ivmb1QtYA3eYYpUVWhXBhwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTq3q854; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CB8C4CEF7;
	Tue, 24 Mar 2026 01:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774316744;
	bh=7197zyylyhbyfExzIW/Yxv7fatz1gEPm+HHyiIeHcdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UTq3q854RRIc87zQhIj1pUZ7fst8aGfaUlq52oEnIo74zy7wTpFyXXSS++6jKZmbc
	 vL3F9gEd/uBk+VCWoGmTnJ7lUp2b1Rf5jfVcb2gzRyoIm0WczNqWk8QpPsfTLLL6c8
	 qr3IAiagmJPkZxv1396a2g+/JmwgiVI5p0tp98T4Q9qSXz5SK/KTr+ceneyxkhEGD4
	 uOcffa8mA5UOD6cQmJtHeOZtCa3S/jwLqAhhjNLgyHewrw56scu9hvIi6GydZzNLdD
	 sP+Bg+jyYbYMIcdbekDnjG5zfYoHEN45ySi8LB+FAWCsBj4qBv+nJe1FrMD7BGA8Sr
	 9DbySAEhzVQnA==
Date: Mon, 23 Mar 2026 18:45:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net 1/1] ovpn: fix race between deleting interface and
 adding new peer
Message-ID: <20260323184543.764a903e@kernel.org>
In-Reply-To: <20260323184304.42c3930f@kernel.org>
References: <20260320100351.2283994-1-antonio@openvpn.net>
	<20260320100351.2283994-2-antonio@openvpn.net>
	<20260323184304.42c3930f@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,queasysnail.net,redhat.com,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-270838-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 277BE300B31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 18:43:04 -0700 Jakub Kicinski wrote:
> On Fri, 20 Mar 2026 11:03:51 +0100 Antonio Quartulli wrote:
> > While deleting an existing ovpn interface, there is a very
> > narrow window where adding a new peer via netlink may cause
> > the netdevice to hang and prevent its unregistration.
> > 
> > It may happen during ovpn_dellink(), when all existing peers are
> > freed and the device is queued for deregistration, but a
> > CMD_PEER_NEW message comes in adding a new peer that takes again
> > a reference to the netdev.
> > 
> > At this point there is no way to release the device because we are
> > under the assumption that all peers were already released.
> > 
> > Fix the race condition by releasing all peers in ndo_uninit(),
> > when the netdevice has already been removed from the netdev
> > list and thus an incoming CMD_PEER_NEW cannot have any effect
> > anymore.
> > 
> > At this point ovpn_dellink() becomes empty and can just be
> > removed.  
> 
> This looks like a step in the right direction but AI points out that
> it's not enough:

On second thought I wonder if the fix will not be to move the flush
even later. So please fix the AI-reported issue in the same submission.

