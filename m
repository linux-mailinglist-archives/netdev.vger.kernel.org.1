Return-Path: <netdev+bounces-253187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JOyFpVDdmmXOQEAu9opvQ
	(envelope-from <netdev+bounces-253187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:23:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4578169D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 436E23001001
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240422D4DD;
	Sun, 25 Jan 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pI+buHLV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46620DD52;
	Sun, 25 Jan 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769358224; cv=none; b=ZVGN6MLX8FtCyvNIJLAPbNrh0xIYPjoe5SfLnAepwkf5yGujlLqcvIXv78Z0Frdr4OzLZXdmekpWE5nF78+tZWs52/Tq2uvbwzfA+0fcLjESnNR+yyW77xC/iLsGSx0e6PLigh5yKyVFaPJIWISCIpDLkPapdVZH559eXhr6VXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769358224; c=relaxed/simple;
	bh=dh6l1y44YjRzqo1Z5sKxOCag83tEw2MD8b6C/Lh2tNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef8L60Qlvlx3WCCjDgaS6SQ972lhRQg3+6I9ASjMn8S9yKi9XPFzzU3lxGTHWQSWd1uNFXWbsZkVvjRlbrQXVUHKyZQzQX3BvzYPrwNzF6Alnua3Kwa01qa8368sb1pfyI2nklXPu44yWqyDFagvQd7QSbUh5T5/M9dENfLyf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pI+buHLV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=7S6KK6Y26jvg6dt7cG8Sr15lfGs5dZY1KLNywDrXJOU=; b=pI
	+buHLVTkrQzX0zvCxuVmeSAVxUrnXoOi2mejD5dYhEm0Qs0ka7E3Rf8PNP4zrkRvPMBZSiwNertE8
	rj+APaymCqExYtkxxXmeJMFamROsliA7wugm1zrVL/m79bytAaspdTssXlapViZ6z/sD8tZ/ESHtw
	mOexgD2bdGX+L6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vk2ta-004cl4-GU; Sun, 25 Jan 2026 17:23:26 +0100
Date: Sun, 25 Jan 2026 17:23:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: netdev@vger.kernel.org, "Lucien.Jheng" <lucienzx159@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: air_en8811h: factor out
 shareable code
Message-ID: <365006c0-8b44-46d5-8023-0912de0588f8@lunn.ch>
References: <20260123075817.1162068-1-bjorn@mork.no>
 <20260123075817.1162068-2-bjorn@mork.no>
 <9743e516-20d1-4f73-a566-1fdd415d60a9@lunn.ch>
 <87a4y3j6hi.fsf@miraculix.mork.no>
 <af7daf2e-7a8a-4a83-902a-28c9375daea3@lunn.ch>
 <87ecnehsmr.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecnehsmr.fsf@miraculix.mork.no>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253187-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,makrotopia.org,nxp.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC4578169D
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 11:51:56AM +0100, Bjørn Mork wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > Maybe a different strategy. Most of read_status is generic, it appears
> > just reading lpa is specific to the device. So have a generic
> > read_status() function, and then use phy_id_compare() to call the
> > needed device specific function.
> 
> Yes, maybe that's better.  My immediate feeling was that this
> contradicted your comments on the RFC

Reviewers sometimes get things wrong. It is not always possible to see
everything from just the patch, and then jump to the wrong conclusion,
etc. The review process should be a conversation. We can talk about
different solutions, which might contradict earlier suggestions, as we
get a better understanding of the problem to be solved.

   Andrew

