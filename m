Return-Path: <netdev+bounces-260272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKMRCrPunGnqMAQAu9opvQ
	(envelope-from <netdev+bounces-260272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:20:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8FB1802F6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C4BC3088270
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A472135AD;
	Tue, 24 Feb 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j2D3bokk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97E204F93;
	Tue, 24 Feb 2026 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892399; cv=none; b=PT4cxDU0Wk1WlXdC4ZOlFX9eGhzdw7BECZuLHk3CJfhlnCSrqVcjpqS4ErROC3Zh2qyQ1VhE0O+mFhTIePxkKDnrRERkpITbQ+d7h/bbaop8P6lozSOUlzpn2a/x742YmuKFsqSiBUC+Eu5Ulb+nxmOjlOwHS5hqUz9P+kfViBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892399; c=relaxed/simple;
	bh=dciRGoN7WFLoFqpHkJ0YEkum8LTzaOwjLNnQ7VOOkfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onPkQNc97GR2wfx5RGXpjQRuuqXh4BTV0W7soGTOKAPPqXEhE3CfztH3B4gnwNf9uJoYKyH1S/fwX0z0aE2yaCfiyknksCEI4zNM60LlQ6UxM8gFug3I72etUPovCulcsqQD1meOy1JndB8ULUgAvPgtf4UHYFzD7to8pmjJAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j2D3bokk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GHaSrimv6EXgmCgAuKFl87ZenTVFS/f/vOi6bxFR7ZE=; b=j2D3bokk5i9uu70gM1qaSvgjQf
	PwdUFU4jYX3ZRyGT0KV3T15FoSy+02Gj3pSMUHbawLY047VRD4lbY50wXw+FXywXZIENQ9/92PlqF
	PJDLkYVcHlDsEnB4dYWTI2hzcSbrNxvXD8cpd08Hxl2k1hA0X8RUtTgw0P3DXC9WspUs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vug8z-008WuR-Om; Tue, 24 Feb 2026 01:19:17 +0100
Date: Tue, 24 Feb 2026 01:19:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bart Van Assche <bart.vanassche@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>, Xu Liang <lxu@maxlinear.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 23/62] net: phy: mxl-86110: Fix locking in an error path
Message-ID: <98a65068-a1c2-4292-bde9-61efcee53df4@lunn.ch>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
 <20260223220102.2158611-24-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223220102.2158611-24-bart.vanassche@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260272-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email,maxlinear.com:email]
X-Rspamd-Queue-Id: 9A8FB1802F6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:00:23PM -0800, Bart Van Assche wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> Only call phy_unlock_mdio_bus() if phy_lock_mdio_bus() has been called
> first. This has been detected by the Clang thread-safety analyzer.
> 
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Xu Liang <lxu@maxlinear.com>
> Cc: netdev@vger.kernel.org
> Fixes: 3d1b3f4ffc0a ("net: phy: mxl-86110: add basic support for MxL86111 PHY")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

