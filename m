Return-Path: <netdev+bounces-196959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAAAD716B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759433B2B01
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F04242D63;
	Thu, 12 Jun 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1n5FXu7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0016324061F;
	Thu, 12 Jun 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734109; cv=none; b=gkvij9MoncW6OlesH/WGI74VabX5XP5FzyOaGoF2oJ39zZvJ6/pYC773v50VEGOYgTFf/mN2WlDxEDQnkqvayjzOzmKKviUTdnhqr1Hp/L7RVdp88iw9w2TAqVXSjKVpPu6FklD25ZAF8eiTtTAmB4fpRucwtZCFesQMzaY6Dy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734109; c=relaxed/simple;
	bh=1WJKyHWbBFQMnfE1yMXgMixPdEhOB4CbJkieNuNbAuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okb7wgStTHlq8srE4WVtnH0wgc2E28OUFkDLjw9dSTbyDeXyMUIN9+Ha7VsriI77O/N8+Dh2fTwu0Ye6l6oaITl1HfgzuF7zkUGpanmevlgJqesohRhUh3LB7wdtOVeSmcTJEmKL1DV/DjGpFlB6H0IDAnOpQ718EPIAMetmgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1n5FXu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D2FC4CEEA;
	Thu, 12 Jun 2025 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734108;
	bh=1WJKyHWbBFQMnfE1yMXgMixPdEhOB4CbJkieNuNbAuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1n5FXu7UVoHraCQNkneMxMZ/E2DyA4g8lk9bLCzsJkngI+M5mP9+wsWx0H6dGRem
	 hRzUyxmpjJqUHDMtBTFcrDzzssF0KSvYwd2KNRLxXKqca4yTQ1u702XNOsj91am03B
	 kTo0qV64iOKCgCxspMqeTI9jEeHzDZ0E3qEvzIlgX9gg9rzVXq4s/ab1EJSyVFQHga
	 aIl8w3FuSrCZAxsY7QAuWxSK64Xw4tfDNPhtAek3TCvjImH3n8WoqnGHrGowNp4msJ
	 7wJuet5krcgqoDXEZvic07M8pPi6dwSRdQOf+ohjffSXl7DvR2N2B9bikzi6f42Ho9
	 hMgn7OLzSaEhA==
Date: Thu, 12 Jun 2025 14:15:04 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 2/3] ionic: clean dbpage in de-init
Message-ID: <20250612131504.GC414686@horms.kernel.org>
References: <20250609214644.64851-1-shannon.nelson@amd.com>
 <20250609214644.64851-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609214644.64851-3-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:46:43PM -0700, Shannon Nelson wrote:
> Since the kern_dbpage gets set up in ionic_lif_init() and that
> function's error path will clean it if needed, the kern_dbpage
> on teardown should be cleaned in ionic_lif_deinit(), not in
> ionic_lif_free().  As it is currently we get a double call
> to iounmap() on kern_dbpage if the PCI ionic fails setting up
> the lif.  One example of this is when firmware isn't responding
> to AdminQ requests and ionic's first AdminQ call fails to
> setup the NotifyQ.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


