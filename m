Return-Path: <netdev+bounces-205317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32765AFE2E6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42B937B758B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675827E7FB;
	Wed,  9 Jul 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtD+n6Mn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263E27C879
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050298; cv=none; b=p0J7qS0amaqI6hC0qvTZB1Qp9NCfGc9JHnPxvRLz1qau0OSx1Rmp9DCDRtBAvQQKvUyBRjZpA8iI4/0IrK1ad3Tvam/tSQMCaBg4D6JquVCjudOW7hoS5v990iOlGpYDVQ5ErpfFV7RylK47TbrpdeDmHV+pbse5XsQWMbytNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050298; c=relaxed/simple;
	bh=Hi1K3gzWceAt3LdQzd976EdfyC2JUiVQTq2wEoJX18E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHX3v64U9tzifSD3Ajx+DzgNFnURgGCjvzFvHUaIPU8o61uzw5XgnwVUOGkNupyLjNHTEP/bz8ZWHrS/KVDW+NzpvT7z1sC7QLsFiMn3JlezRykhp0E7C9gLakchwV+ucGqncrQsZvu56DBmIjBJUv06e4t7j1dYiIHfDO+C0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtD+n6Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4054C4CEF0;
	Wed,  9 Jul 2025 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050294;
	bh=Hi1K3gzWceAt3LdQzd976EdfyC2JUiVQTq2wEoJX18E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtD+n6Mnam6vx3Vhl/liOQqHpmuQQQyrUoonUHFLbDqWKeeP5SNfC9U0vqaG4Zz+c
	 6OUFLZNr3IbWriRwpIHEEPRdM0JHDIZCrN1fwX72uL94xKSbOP0WI86HEfrQ3iaB5O
	 XCf6gUHTDCf6dZyBgXr+4D55YElPKXLaIYvZfq+VijZZWcFXE4Mc5HpC7oOosqLpMv
	 uC/j9VvpCpgQ9tTgnR2NMxv4uto5A5oSR3YEJLsOoGiuONtYJv3O//8wFqZN6J9hPs
	 KFf8E6JKFGJ9nocx8DFR+l4xkxG+cR4yzOhVUM8itNa7wbWQfMhPIbKIcnQx4B3bOW
	 71tBvs6/DPBZA==
Date: Wed, 9 Jul 2025 09:38:10 +0100
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V6 05/13] devlink: pass struct devlink_port * as
 arg to devlink_nl_param_fill()
Message-ID: <20250709083810.GG452973@horms.kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
 <20250709030456.1290841-6-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709030456.1290841-6-saeed@kernel.org>

On Tue, Jul 08, 2025 at 08:04:47PM -0700, Saeed Mahameed wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> As the follow-up patch will need to get struct devlink_port *, avoid
> unnecessary lookup and instead of port_index pass the struct
> devlink_port * directly.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


