Return-Path: <netdev+bounces-229638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE57BDF1FA
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88BF3B195D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067192D7DC1;
	Wed, 15 Oct 2025 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QysWyZJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55352D77E8
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539185; cv=none; b=IdveRRiNQAUlczfut+gFC3sdqTypvfQHug4LSdFfmrQa/lfSQxXF4ir3Sqqv2W4m1VIBiTtVx4lOAuDuZ6s/1WIYPwbCfp5quv6cfwUUBCRSUlQDemmuUmPKjDHFEAbI87TbB1ulTsUlpOzkkTRw/KIJNn7WIPDmLejy5wn1ttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539185; c=relaxed/simple;
	bh=Rg0rg8l1XMf8EcsgtuUj+YtHHaPAHGSsniJ+xusmAok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d40HdmPqaSDatTbdXpo3HyOV783KvpjKwclvXF5RjtOrHzErvMjakEMjHQrRKeZOZDKi9sSwvuCH+y/78Oz+RAlrFh3D0G+RMmhqTBRBwhCMTAgKtpkurXVgqBUorW9bdi3fwQCplZsr4XhYFyGPji1Sl8vytxlRb4YrkBC0Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QysWyZJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4B6C4CEFB;
	Wed, 15 Oct 2025 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539185;
	bh=Rg0rg8l1XMf8EcsgtuUj+YtHHaPAHGSsniJ+xusmAok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QysWyZJzJOK++ujHeTRp5+//y7mRcCpOeE+eCYAkNZlcn66ms7AEXhPV6YVbewB+V
	 fPUhbFaC4TrjUJk89DU6x6VOVHN/129ZbUk9XrmwlzRyPJm4uRsX2YLzhtIG5cP90U
	 8/aA15TmRmwXQU4C5YGtluHVJni2J6EGM7wDV8WsqIogHMJZJWlxINXwbzcVchnQKb
	 g2lYD0f5UlLx7BcP1XHQNtWnvfgBbANw0DdUGiwsuWfxwsas+2b0Fh0l2iMPRavyJo
	 DL9DJlNlLju/arH2Vi4JxMdTlsRB9+V7PhHGHDo0w84JGRvp6e/9EMRlznxIHUJVDj
	 b8FmVKksfB6Pg==
Date: Wed, 15 Oct 2025 15:39:40 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] net: ti: am65-cpsw: move hw timestamping
 to ndo callback
Message-ID: <aO-yLBOiQ5j-41vw@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-2-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:10PM +0000, Vadim Fedorenko wrote:
> Migrate driver to new API for HW timestamping.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


