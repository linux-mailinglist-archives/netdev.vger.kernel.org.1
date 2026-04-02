Return-Path: <netdev+bounces-274680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCytEsrLzmntqAYAu9opvQ
	(envelope-from <netdev+bounces-274680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:04:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDE38DDB1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53AE5300D0C9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD01366075;
	Thu,  2 Apr 2026 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bilblz1n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480235B634;
	Thu,  2 Apr 2026 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160260; cv=none; b=Ax2KisvsZi5WGzg4I1cWkOe3O/fugcdXmU9BcJ1GqU+PmKvGBW2x5QU8Ppt2h6jo1VE1hG5Kbo8+LffDSLgveNrBpjJIQNvenTEopt2uDwO7w8D80MJ5leIhhOXaOF6/AI6Q0fZEKVX028xzdBrJGE8hC884ZWEqq/jSG4Nx+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160260; c=relaxed/simple;
	bh=59lpSwsoPpnlu+KIsVuLkTwpGQQdzM03XV15lTdhlKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk3/bNYhy6FwgHGVBHBOoIhImnYEwOkt58ZFXVIu3rKmI/mzW6zntvon3iHFwnyUulJ+HvPzsrwbABLH6pARLLuemRMDfJrD0fWcrjE5p7FTRZacCk1JDK3BmM3JmTueFDdUlLLSFR1ZrI6OA0zSAzOkUxWd8gmlXuTXKBdDYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bilblz1n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rVNvoOyuAC1qL9Vomz/I3YhnB7WdDWRcRsIwqGMBANc=; b=Bilblz1nKLOlJmJvg/1eS2xGgM
	+fs8I4ECzCdcl1J6q9bog3G7S7rYGCUacEkmpUpe7KvdhfsMyhSvH+7ytcOq1OH67ynT43MS2S5UW
	9Nrv32IP6vifAzdJSDkonLl2VfByLS6B+RbrXj22suhe4l+Wk4rN9sxkCyzmMEMTCjlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8OGx-00EZ93-FQ; Thu, 02 Apr 2026 22:04:11 +0200
Date: Thu, 2 Apr 2026 22:04:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joel <joelcrouch@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sungem: fix PHY initialization hardware failure check
 and pointe style
Message-ID: <4c17e602-e9ba-4ea5-993f-27a221a24ea0@lunn.ch>
References: <20260402194235.11986-1-joelcrouch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402194235.11986-1-joelcrouch@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274680-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 51BDE38DDB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:42:35PM +0000, Joel wrote:
> Currently, bcm5411_init does not validate the result of the PHY register
> reads.  This can lead to silent failures if the hardware is unresponsive
> or the MDIO bus times out, as 0xffff would be treated as valid data.
> 
> This patch:
> 	1: Adds a check for -EIO and 0xffff during BCM5411 initialization.
> 	2: Updates gem_init_phy to log an error message fi the PHY-
> 	   specific init fails.
> 	3: Cleans up pointer formatting(eg,. foo* bar to foo *bar) to
> 	   align with Linux Kernel Coding Style in the modified files.

A patch which does three things should probably be three patches.  We
want lots of small patches, with good commit messages, which are
obviously correct.

Code style changes should definitely be in a different patch to real
changes.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr
	

