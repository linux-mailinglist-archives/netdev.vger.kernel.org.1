Return-Path: <netdev+bounces-280932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDFcE2jn6mnEFQAAu9opvQ
	(envelope-from <netdev+bounces-280932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:45:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C745984D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DC8300D6B7
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF421CFEF;
	Fri, 24 Apr 2026 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CZ0sAuDU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F157C9F;
	Fri, 24 Apr 2026 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002340; cv=none; b=LKuNQXMHXQfQyvEs0s5V3vd7+UmenItX+o/uEWKbqpwUFkE8ixshGajhyn6tJW9PKmtvX6ireiie8Q12OBA5CfgQtGhTcN3QKnY0T78CRoYt/3VkG8vVhL/q+fef9YmeiI+3oPqlAIq7w0Z3Joqwbs/8zUPzytmvsd4IMH/jbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002340; c=relaxed/simple;
	bh=3POdAH3z+TZL0x6RJFkpWOx3TAPsHN/IOCZLzmkM7rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiqeIl1Fde/UxSwU1k8+W9xRnSQQtyAuiwasfQpQbazt627/+fjqNRKbshFk3N2xgwo0CgqXIYsvEyc4VCpfBvBfQoO5pD6h+W/ClDXWoo9d+PKV4e3oKfPaMorbLHVBAnBGtahiioJQc3zOlCIqtlv4iBGF0A97UeTHg2bwV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CZ0sAuDU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vYlH3Yq+AlNLa1zGd5i2W5qshJCjQKhQ7j+W98woCRE=; b=CZ0sAuDURdMM7HbKHK+FSi1v9L
	smZnWuupi75s+/aNxh8PlghtkKtsYmTMjyxyNtKKWLJGytGqeC6smjLuGxvLUhkr5R30Heps+BI1/
	eJ34TbjnVGbXAGqBeSmdv+jje2SFRlPeDoOUc8m9vEOpZw6SzZWLkSdXkYu0t5mhVH+0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wG7U0-00HKYb-Nc; Fri, 24 Apr 2026 05:45:36 +0200
Date: Fri, 24 Apr 2026 05:45:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joel <joelcrouch@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sungem: validate BCM5411 PHY register reads
Message-ID: <0f243998-6cdb-46bc-8eda-11d4bbc5ae2e@lunn.ch>
References: <20260424033348.1917-1-joelcrouch@gmail.com>
 <20260424033348.1917-3-joelcrouch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424033348.1917-3-joelcrouch@gmail.com>
X-Rspamd-Queue-Id: 892C745984D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Fri, Apr 24, 2026 at 03:33:48AM +0000, Joel wrote:
> Check for -EIO and 0xffff during initialization to prevent silent failures. Add error logging to gem_init_phy to report failures.

I assume you have the hardware?

Looking at the git history, there have not been any fixes to this
driver since 2012. Why has this problem suddenly appeared? Is you
hardware getting flaky?

       Andrew

