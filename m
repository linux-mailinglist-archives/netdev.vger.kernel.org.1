Return-Path: <netdev+bounces-73781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDCC85E5D9
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7462928503B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70C85294;
	Wed, 21 Feb 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W62OODu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9184FD8
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539843; cv=none; b=MyQD/CpibbeppoH+yuzmvnGN7REXw6syt0GMopW0KZyDMGAftNW3cou5V344mfPZ0VR2atO+UjOYEcrwQ/Vd9AdsjyODNH3kOSGOrWy8kaFbdiWvfQ2F0OBs3u0oTxW1zcesxhzoUQx1raM5qYwQKvFW8VnHNSsOZEM1jLO99hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539843; c=relaxed/simple;
	bh=3QIljDITRQwfWL2tz9FshApTGmK5ZzfFey/sWAWMfSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4o+BMBPL8rOBfYASo6eseIv7kZ8Kq4R12aw4Y+y0FlV1LAVK6FYrP3yiqUJLFpPR/OHGW4LBlstsJHUwPQ1d0DhZOioaQEU8EOeyfAU8EPpRgo6Ek37I8UUauFwwCJWObwpev+d8YrG5fSY8GBo3ZMDDHLkEaVWQuBpAmoVEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W62OODu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859F6C433F1;
	Wed, 21 Feb 2024 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539843;
	bh=3QIljDITRQwfWL2tz9FshApTGmK5ZzfFey/sWAWMfSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W62OODu5NUa1p2Qiif+fF0jEoH0r/txppsvCDeXDZ6HdWKzufsmZK7zFfTkOShvSJ
	 Ah8KuopLgF5OEguBfO83sHGr4EQmZ9Z0JS/cZk6baXHlWW5uFdwdxNrw8zU7o0FoDk
	 GJlcbneOuOCGgwi4+AD4eEaJiUqF3HYI0ZW/4O4tB6sWxwGqibVaag8X2NYUcv6/qX
	 oZeYdmUcfoGVacUAoYz3cOS+aQ9od8W09L5tD+6X/CeSGDZAaueA61FQJbsBQkcWTa
	 GWaE3zP3ipQzkcm2wgwjKC/UOq3AzjmrN+0oUIE4p0jprihpcNrgbD5dtpFzr4sWtU
	 Zg0ugbKYEtWvQ==
Date: Wed, 21 Feb 2024 10:24:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <mkubecek@suse.cz>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, <netdev@vger.kernel.org>,
 <alexander.duyck@gmail.com>, <willemdebruijn.kernel@gmail.com>,
 <gal@nvidia.com>, <jesse.brandeburg@intel.com>,
 <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <pabeni@redhat.com>, <andrew@lunn.ch>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH ethtool v2] ethtool: add support for RSS input
 transformation
Message-ID: <20240221102401.4b3ad429@kernel.org>
In-Reply-To: <cbd0173c-8d32-4e08-abaf-073db12729ab@intel.com>
References: <20240202202520.70162-1-ahmed.zaki@intel.com>
	<20240202183326.160f0678@kernel.org>
	<cbd0173c-8d32-4e08-abaf-073db12729ab@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 07:54:13 -0700 Ahmed Zaki wrote:
> On 2024-02-02 7:33 p.m., Jakub Kicinski wrote:
> > On Fri,  2 Feb 2024 13:25:20 -0700 Ahmed Zaki wrote:  
> >> Add support for RSS input transformation [1]. Currently, only symmetric-xor
> >> is supported. The user can set the RSS input transformation via:
> >>
> >>      # ethtool -X <dev> xfrm symmetric-xor
> >>
> >> and sets it off (default) by:
> >>
> >>      # ethtool -X <dev> xfrm none
> >>
> >> The status of the transformation is reported by a new section at the end
> >> of "ethtool -x":
> >>
> >>      # ethtool -x <dev>
> >>        .
> >>        .
> >>        .
> >>        .
> >>        RSS hash function:
> >>            toeplitz: on
> >>            xor: off
> >>            crc32: off
> >>        RSS input transformation:
> >>            symmetric-xor: on
> >>
> >> Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/
> >> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> >> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>  
> > 
> > Acked-by: Jakub Kicinski <kuba@kernel.org>
> > 
> > Thanks!  
> 
> I am not sure what is the status with this. patchwork is showing it as 
> archived.
> 
> We are close to the end of the release cycle and I am worried there 
> might be last minute requests.

patchwork auto-archives after a month. Michal, would you be able to
scan thru ethtool patches at least once every three weeks to avoid this?

