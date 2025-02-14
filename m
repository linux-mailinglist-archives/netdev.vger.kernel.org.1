Return-Path: <netdev+bounces-166425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9213A35F6E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3921676C6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397DD2641FA;
	Fri, 14 Feb 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IYMbXnGq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746022641CE
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540695; cv=none; b=lsGCeKDG5/35n9hxQOwFoSvX6HWRqymgQxOOf7pIqKCnC8egWO1bPNm3RCV6mYjtlc+Vmn2f53rrcIfouUfhATV3OJPSuc5Sd/U77NaEfslzua/5iHFlyDWkeHBXsu0NFX0HFpxRtGV9k3oONfFU1DAQdbpvCra3ByCu0gGV1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540695; c=relaxed/simple;
	bh=BRnHtysPLccMsZmphY8kyqv52wVryKp9chQU7QlYYLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et/AFOPLCbYkzsc/x67pyufABJ8tam6bZoc79/RLmBcmoJ/PgbYrpGujcTQURGNYyixY5ZxsW4U7+tf2QMktpMf5jpvkmno2JrVgKABxHV0uszY5rYwzSsRDRA+fl8tMeA+99rFUqfB9Vn3eX1i3piwVltQul4+H+eYvEO/b750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IYMbXnGq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sQeMWAmqvHsGAQGs7OFlW86G1XWayOkPA/i8UTyB8oc=; b=IYMbXnGq4EzIe+3eMQ90tC3i81
	DlmhnJZnigO9UnQ/USUJWScsgwq/Jk7TDBAIflv8zHSj9PlCn04HbTWwLOxAbrMpBxvGXUqB7V9Gp
	UwQSyv7z6TsowMQOS83Qwyp1QAhFx/TWB670Kbzv2FRYgrxl8F/vmdFF5eVG88w4I7pE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tivzt-00E54L-8R; Fri, 14 Feb 2025 14:44:49 +0100
Date: Fri, 14 Feb 2025 14:44:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [net v1] devlink: fix xa_alloc_cyclic error handling
Message-ID: <2fcd3d16-c259-4356-82b7-2f1a3ad45dfa@lunn.ch>
References: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214132453.4108-1-michal.swiatkowski@linux.intel.com>

On Fri, Feb 14, 2025 at 02:24:53PM +0100, Michal Swiatkowski wrote:
> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> from xa_alloc_cyclic() in scheduler code [1]. The same is done in
> devlink_rel_alloc().

If the same bug exists twice it might exist more times. Did you find
this instance by searching the whole tree? Or just networking?

This is also something which would be good to have the static
analysers check for. I wounder if smatch can check this?

	Andrew

> 
> In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
> be returned, which will cause IS_ERR() to be false. Which can lead to
> dereference not allocated pointer (rel).
> 
> Fix it by checking if err is lower than zero.
> 
> This wasn't found in real usecase, only noticed. Credit to Pierre.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  net/devlink/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/devlink/core.c b/net/devlink/core.c
> index f49cd83f1955..7203c39532fc 100644
> --- a/net/devlink/core.c
> +++ b/net/devlink/core.c
> @@ -117,7 +117,7 @@ static struct devlink_rel *devlink_rel_alloc(void)
>  
>  	err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
>  			      xa_limit_32b, &next, GFP_KERNEL);
> -	if (err) {
> +	if (err < 0) {
>  		kfree(rel);
>  		return ERR_PTR(err);
>  	}
> -- 
> 2.42.0
> 
> 

