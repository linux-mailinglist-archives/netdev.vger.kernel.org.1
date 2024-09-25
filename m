Return-Path: <netdev+bounces-129682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A20B9857EE
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 13:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EF1C21674
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 11:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5644C1537DA;
	Wed, 25 Sep 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R947yg/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62E146A93;
	Wed, 25 Sep 2024 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263142; cv=none; b=W5+Wlwtqgw0Vq3iIJWNLc3lA7rjU5fgroS8oE+OvcE4rAf/Qtf+chgb8OGFHaREYDP4s7/oRn3+8LIWNGal39uZlbLI9KD28OlGE7hcyzuNUWyJ6b9EkBDjJQ3qLLJIlan0tkf3GXi0PNldSVY95WMOOf+BhZxC+63k7jrzJCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263142; c=relaxed/simple;
	bh=LSJq1uNpXSP4ZmzorfnTFL60qw3FPktUVAcY8S2ci40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT7oKuB25Qk07LuJ+YYT0VbDlG9o2v7vIX+gNJRVC92/ghWke3NPPRz+olZ+Wg6VKijEKhYWNKj4i44syZgdHhTo+R+WGuMDXJxV/Du6LoYj10X3tFSmZhnhi3kSDdJR/gPW6pD/3CaxWI23bp0fVLEfo6NUKNUWNSiUUBCczHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R947yg/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A6C4CEC3;
	Wed, 25 Sep 2024 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727263141;
	bh=LSJq1uNpXSP4ZmzorfnTFL60qw3FPktUVAcY8S2ci40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R947yg/7wDOLc8Ix/bcjcntfctoEHcooM3bsYkp1vuMM7ISETUj/8vDJx07JsKHFR
	 OYYKhvMwXFF2oGb5ErOjtxryZnEO3cpaWJ2BIWOplBdWSwNUOOgEv7cCB7lSEQpAIz
	 4xR6lwtZEe+fqp6fKdygNrLQ/O7FFXcf2cLFKf2MQaZ8ZP8B73eNOo+WDkr9SlYcQc
	 Jwscu5u2TPywzPtNrujP9nporUq6pTP4zb5EC9JgeoK+TbD+Rp5Iw+Ui4Dsk0TJTi4
	 h1bW2kImkAnqNETGL0oF5XeylbYGIioBnkG+94uBZ8c3+vFjiBzmcN5hU1RST/m7NE
	 /zva7qQwMY4Sg==
Date: Wed, 25 Sep 2024 12:18:57 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, f.fainelli@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <20240925111857.GU4029621@kernel.org>
References: <20240924185634.2358-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924185634.2358-1-kdipendra88@gmail.com>

On Tue, Sep 24, 2024 at 06:56:33PM +0000, Dipendra Khadka wrote:
> Add error pointer checks in bcm_sysport_map_queues() and
> bcm_sysport_unmap_queues() after calling dsa_port_from_netdev().
> 
> Fixes: d156576362c0 ("net: systemport: Establish lower/upper queue mapping")
> Fixes: da106a140f9c ("net: systemport: Unmap queues upon DSA unregister event")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

I'm sorry to be picky, but I think the fixes tag should be (only):

Fixes: 1593cd40d785 ("net: systemport: use standard netdevice notifier to detect DSA presence")

Otherwise, this looks good to me.

...

