Return-Path: <netdev+bounces-260257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EBWBr7fnGnCLwQAu9opvQ
	(envelope-from <netdev+bounces-260257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:16:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6F17F141
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C7A317722B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5C37E2F3;
	Mon, 23 Feb 2026 23:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76343502BA;
	Mon, 23 Feb 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888348; cv=none; b=Ea6sebHm545j54w2si6NdY4vHX9yUZR8IGCzpVaaurLr+yNsgWoEaerHYCa/UTZh40/l3WpGZcb3E+vFdydku3KJulJ62vb24+uwpCrmU/8G+H8s2bVAKG9XF9zzc6VkQ2nNodqeoydPi6T0hWY4jXo+jZjZzr/bdqYFeLFAdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888348; c=relaxed/simple;
	bh=pnvJv1+/1g6KH6AlmPTZRGIvK0vkhCQ0O1avFyhYKUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTmO/075GEoo1BOiXbWBZI5OaqJeK7KCghIIF2YNgas3klGqL2RA1Vn97E+NGm3Jq8pb1GSU2jcuXr1ggt0E8WjTwLg2XyrpvF7VBkVbTHjPHLrPbElm+GiUBH7NihX4N1AFlWjQl5QwiLK+hEgZPPcMVejjhP6F6LRjZX/Drk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vuf61-000000000yO-0Opd;
	Mon, 23 Feb 2026 23:12:09 +0000
Date: Mon, 23 Feb 2026 23:12:04 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Bart Van Assche <bart.vanassche@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 23/62] net: phy: mxl-86110: Fix locking in an error path
Message-ID: <aZzexPsIeNh5yVdG@makrotopia.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260257-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,maxlinear.com:email,makrotopia.org:mid,makrotopia.org:email,acm.org:email]
X-Rspamd-Queue-Id: A7F6F17F141
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

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/phy/mxl-86110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
> index 42a5fe3f115f..d010b023f7b9 100644
> --- a/drivers/net/phy/mxl-86110.c
> +++ b/drivers/net/phy/mxl-86110.c
> @@ -891,7 +891,7 @@ static int mxl86111_config_inband(struct phy_device *phydev, unsigned int modes)
>  			       MII_BMCR, BMCR_ANENABLE,
>  			       (modes == LINK_INBAND_DISABLE) ? 0 : BMCR_ANENABLE);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  
>  	phy_lock_mdio_bus(phydev);
>  

