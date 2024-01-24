Return-Path: <netdev+bounces-65416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EA83A676
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE4EB22039
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252C1862E;
	Wed, 24 Jan 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAx/F09a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0A1862A;
	Wed, 24 Jan 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091248; cv=none; b=i7sEFC7Mkc5cMlLGeQdKBrTfj3MEXj2lblpmfhNISlaWsyFgSj+r0c1RBGJWGfKXbnLKSWBqVp7+q8NPWyuaBqGYKj9duAOAlkmXewxIjI1gOzBrVbrWzUw/yNIt75omdxl/PAhibIs2BKFFW/h8qqmhgsR1eaWF+9Cv/FDjOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091248; c=relaxed/simple;
	bh=/9Bgs9Ucy3j81IsL52Q0gGKY1HfdMRpMhJNhpIJhjKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvKl0S0YRw8+1W3hi/q3WEJX+codv4L+AlsjbsxzYTQffSRf+quNGu5xDpTw23n9oP5Jaefzd9JwZdnAEDscJbu5V3Oj35OcEAm6zhwlDx493AFM8hw2h8KgxMHcU2ytrSa/aPDrUsZoF8Nwe3ZwTFstz1OKij4V9Ew6+cwnvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAx/F09a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA19C433F1;
	Wed, 24 Jan 2024 10:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706091247;
	bh=/9Bgs9Ucy3j81IsL52Q0gGKY1HfdMRpMhJNhpIJhjKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAx/F09aVkFD8ly+L+bDGv7l9Ad2emBf9wREK1IuNzgMyBi2nzMNzqV6K0NDUfW72
	 CYMkj1CCMxscvL6YODMgdcd5BhOF1HOEr3G/tl+vnMOkciJVq6TXXRZrKmB3BG+Btc
	 qFfPoQnF/G/XW3sM6PG27qrboilC/oBcbDltaSVt9v35J5qdYq2Ho5VCP5IsjnuDSh
	 YoMrc8kT+8CVVn/ImffruHwNArxY0AnWFSPkKVH4lSEMMfEj1VP5F2cnGVPSWWZmKO
	 AaDdTSSUWyafb6fTn/bVWswh5TVZ+NP83HxZsXn5L+vZ2s1gfzT6SRJdvjDWgIcl9M
	 dyVYPn1w51Y5Q==
Date: Wed, 24 Jan 2024 10:14:02 +0000
From: Simon Horman <horms@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us,
	ivecera@redhat.com, netdev@vger.kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, rostedt@goodmis.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: switchdev: Relay all replay messages
 through a central function
Message-ID: <20240124101402.GU254773@kernel.org>
References: <20240123153707.550795-1-tobias@waldekranz.com>
 <20240123153707.550795-4-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123153707.550795-4-tobias@waldekranz.com>

On Tue, Jan 23, 2024 at 04:37:05PM +0100, Tobias Waldekranz wrote:

...

> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 5b045284849e..05f22f971312 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -307,6 +307,23 @@ int switchdev_port_obj_del(struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
>  
> +/**
> + *	switchdev_replay - Replay switchdev message to driver

nit: switchdev_call_replay

> + *	@nb: notifier block to send the message to
> + *	@val: value passed unmodified to notifier function

nit: this should document @type rather than @value

> + *	@info: notifier information data
> + *
> + *	Typically issued by the bridge, as a response to a replay
> + *	request initiated by a port that is either attaching to, or
> + *	detaching from, that bridge.
> + */
> +int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
> +			  struct switchdev_notifier_info *info)
> +{
> +	return nb->notifier_call(nb, type, info);
> +}
> +EXPORT_SYMBOL_GPL(switchdev_call_replay);
> +
>  static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
>  static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
>  
> -- 
> 2.34.1
> 

