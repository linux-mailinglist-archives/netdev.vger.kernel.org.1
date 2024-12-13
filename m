Return-Path: <netdev+bounces-151602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA09F02DD
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7844128195C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC412AD14;
	Fri, 13 Dec 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRcw5Yq2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654E2CA9
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734058842; cv=none; b=DmxCW7SERVlK5mj+fCw5JNeRuWFWInfNGXF17ejMhoav06E3E1VlNvsvcWvZK2FHJGQooer+UvB+Jm6HU0naC2bzcDYXQPkzPnk2fEnoZzoUzycVHq8bxka8Uu/XesQm+5SIcrTmsk51IcKQ5Fr8EeXibMGCZkcPSfJ/HcMuYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734058842; c=relaxed/simple;
	bh=T0sOKS6YS/1dE1j9zgYFAExqSYhZRKMgj9DLJHWxbxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldsm/a46gI/q6PjO0EOQzF8z+4+On43rUULj+ZcmL3yFijDuCXwo+ru06qJ8CKYjr+tLwqsZs0yYMZjJzIqtVRNRnh/SuAd27EfkUAMnw04W3ZKTjBsjMhb2aNq66t82ilNdnDgkshhPd38gd3PkfPVSxGMTWT5QnnDUItSY+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRcw5Yq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231D2C4CECE;
	Fri, 13 Dec 2024 03:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734058841;
	bh=T0sOKS6YS/1dE1j9zgYFAExqSYhZRKMgj9DLJHWxbxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dRcw5Yq2TFlm800S5F147YrPzbzrGjvT/muFyWE99kfRRGI8rYd784Ft+Ys/OeaG/
	 k4mxaVBkqhqWJ/YrvvkEuGqDgI3dmV9+CV/ENx05Km4dgIwhw7cBWO0JBlUyxu/t3z
	 TwtWEXTnssWi6Jvhh7VrJbq5ioP+zOwtmBsy5f/4Bj7DygRKFqI5XFEBos5QyXjziK
	 r9tl1xOlwtC2qFa9o9V1PTuR6kRP8+XdANf8/5Q7K8xqyYGAUy5328oN5e18OfowSA
	 +uqkZwZAAHzA5skIBlQNCRE+SsH3wRrOFwXFsvd9maX6+Gjw1qHfhKAEltCqUC6skB
	 nYNeRyeIMMJGg==
Date: Thu, 12 Dec 2024 19:00:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, wojciech.drewek@intel.com,
 mateusz.polchlopek@intel.com, joe@perches.com, horms@kernel.org,
 jiri@resnulli.us, apw@canonical.com, lukas.bulwahn@gmail.com,
 dwaipayanray1@gmail.com, Igor Bagnucki <igor.bagnucki@intel.com>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 6/7] ice: dump ethtool stats and skb by Tx hang
 devlink health reporter
Message-ID: <20241212190040.3b99b7af@kernel.org>
In-Reply-To: <20241211223231.397203-7-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
	<20241211223231.397203-7-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 14:32:14 -0800 Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Print the ethtool stats and skb diagnostic information as part of Tx hang
> devlink health dump.
> 
> Move the declarations of ethtool functions that devlink health uses out
> to a new file: ice_ethtool_common.h
> 
> To utilize our existing ethtool code in this context, convert it to
> non-static.

This is going too far, user space is fully capable of capturing this
data. It gets a netlink notification when health reporter flips to 
a bad state. I think Jiri worked on a daemon what could capture more
data from user space ? I may be misremembering...
-- 
pw-bot: cr

