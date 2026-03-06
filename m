Return-Path: <netdev+bounces-264830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFSjMwrsqmmOYAEAu9opvQ
	(envelope-from <netdev+bounces-264830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:00:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9303E22342E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A07304C954
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA563A9DBA;
	Fri,  6 Mar 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezVaNHCo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875C3A9D8B;
	Fri,  6 Mar 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808656; cv=none; b=R9p6Q9JWjRqY0XXP7CJESs9u/CamfaOGJlllJ0MHzkLafxGwNZl0a6YKG2qRr8H6zvxMFCpAdxq0T9lcxMHSIwUGjJLUByjPh4lYi+k+7lTfkEHI7dXreLx2Lg3VjY9UJUdQ0rwy/5pNTt4rq6WS2OqG9fRLA/3xZlFYJjsCfKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808656; c=relaxed/simple;
	bh=mkZSpwuAWg+oNtoRHtNBGLiQS70mf05asgGvqRRkAHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Grpqu6vG1Rkji7KNl0mCrddOsIsywD6i3nI79TZMmrPB3s7AaPngyVluuZhjuguA16whpFV60y2EaJf2qBiR3or1QsNlrleK0Nl5hja93nw9/SfaQeE/eilz6XWCL3YvqMkxp/9aBiYHYniTPybN9P4O8YRIChuFJnS8Rv3F92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezVaNHCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EACC4CEF7;
	Fri,  6 Mar 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772808656;
	bh=mkZSpwuAWg+oNtoRHtNBGLiQS70mf05asgGvqRRkAHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezVaNHCon2awEeXNwwNc0MkGuccIinCGiNTRGN4BJZpJ5SZrGcxF+3QC0zlLaf3Fp
	 3WYy5irMwCm82Bi/ALnD6Nalu9kwCd3jEskI8hH5jWd17HK32DuUlX9L3jGd0ena07
	 xVJojGu9ZOSDpSfZ0g26DSpKz5OmtGvl/tTqtVqQ7sLhqDA4gcmnUQgDbEZrHcOM9/
	 tNF/vlWyUrbX5cNmPGwbnMuiDWonxJCOglT94LpT/O+hjkg2fK5CWv7k/piDwqK5s8
	 F0tHFrC9RfioaAV80VGF4Ybp2/HgibzTu9BUYoLojFabdMmofTNEMyOCJ8q7IizbYr
	 S1Fr/i8TqZU+A==
Date: Fri, 6 Mar 2026 06:50:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, Frank.Li@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: safely reinitialize TX BD ring when it
 has unsent frames
Message-ID: <20260306065054.22450f3d@kernel.org>
In-Reply-To: <20260306054002.2208360-1-wei.fang@nxp.com>
References: <20260306054002.2208360-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9303E22342E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264830-lists,netdev=lfdr.de];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 13:40:02 +0800 Wei Fang wrote:
> +		if (timeout >= 100) {
> +			dev_warn(&si->pdev->dev,
> +				 "MAC %d RX is not empty\n", mac);
> +			break;
> +		};

spurious semicolon here
-- 
pw-bot: cr

