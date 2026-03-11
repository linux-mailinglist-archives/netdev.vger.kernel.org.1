Return-Path: <netdev+bounces-266766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHs+NPXGsWnvFAAAu9opvQ
	(envelope-from <netdev+bounces-266766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:48:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C7A2699D0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B2B630630B2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E232D239B;
	Wed, 11 Mar 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P9TytM+b"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4C295DAC
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258368; cv=none; b=srMvtkTbWZBqz+aZ/twu4JIrTkmw5COji8d4gb0OorZWBQfG8YswzfarnMEZrEK4KwDJQFuvjRtUe8JneEkDvfPeQ0hH9MMhH0hn3aHJi0/gDMHfBn1ulqepYhRj68WgYP4pBUHy06Gi/FSEMYDoexTAfPjCr1yt00IytqIdGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258368; c=relaxed/simple;
	bh=FFvAjx9zCnHSgMM/+8MPstyURpNgnN7LrwEdyxYRiCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4j0N4ZHKpEiBEZHwtLpZq+Kh1SYII4OfMnYe4Q2NkeK7kef6EgmBu93+iZTHn6Xo+Gvo0kOJivixDWjFxFbthyX0noLjH6aNvG8wbVw5GbVt+b9ufgr5QH3Cv+bjhBo5be1BuTsRM5sPswDIOqfdyiU5EJW5/CrHTDHK4aMy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P9TytM+b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=K3XkQEq73jWsAKMEWUB76dwZ/8sAlrAAfvgWR7FJ4Kw=; b=P9
	TytM+bHeOnkJKMR+kF8qB+bfGb9d1gIKSkDNEZ+TgFo2sEJh8Gw4gh/3iHFCt0WdUFF9xmjk83mQX
	IfX/TXIXpMk0j/uS97tfBJh8cGVoIloew71NyKJUFnleWUKbdwsRY+ihMgyahSvc0jeBTilGPiOK5
	XvVLn+0lj5gNtGo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0PVM-00BEJC-Rb; Wed, 11 Mar 2026 20:46:04 +0100
Date: Wed, 11 Mar 2026 20:46:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: stmmac: TX stalls with head OWN=1; requiring manual DMA kick
 (6.12.63)
Message-ID: <b2868f3d-ef84-4ec0-ac37-e41029a1d385@lunn.ch>
References: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266766-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30C7A2699D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 08:34:36PM +0200, Tomer Maimon wrote:
> Hi Giuseppe,
> 
> On kernel 6.12.63 (GMAC, normal 16‑byte TX descriptors), we observe
> brief TX stalls when sending small packets.

You might want to look at Russell Kings patches from this week to
rework the descriptor handling.

Also, please don't report problems on dead kernels. 6.12.76 is the
current version for the 6.12 LTS. There is a small chance your problem
has already been fixed, and you are wasting everybody's time.

       Andrew

