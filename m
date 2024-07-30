Return-Path: <netdev+bounces-114098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E9940EE7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8B51C21CB0
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7681957E7;
	Tue, 30 Jul 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EafZYHBc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A715194A6B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334979; cv=none; b=QOYAvTet2pkB1PG6PHMHSwrmG+uDexRJVbG0Y+hiyDRp9BQFll4bt8v19xKYBR3bHT//QbVHHQ3swvjdo9H57Rd4MT+G9ES3W0L9kuYvXEaih2Qr1ske3+4DmBQRhWlFp3BT8PcvsQ1XKhrvrFEYqq25u74DPoqFUdqXU8IaC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334979; c=relaxed/simple;
	bh=lS9HhdtLF+ce4u9oCui2lNNghuoy0C3sxx2ZrpadLu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5AGCW9wkHjGpcplqewAoVZuXib7Xlu65jUtNZR84nvD/me+BoNdtNxR8a3Cd8kj4IARsh+QQAVTOaBoGXGwMZwc4H7NAPFC4vpvGKnvS9ORNou9m3BgWMB+f9nsRX/xkPhWzzNdhhwWzx5+/sZSOZKgkl55BSscFtwqIQMuzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EafZYHBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90980C32782;
	Tue, 30 Jul 2024 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722334979;
	bh=lS9HhdtLF+ce4u9oCui2lNNghuoy0C3sxx2ZrpadLu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EafZYHBccvmwcqWlKZOwsv95YGvUoEeYINTyNYaumh9Yr0UVOKrGLuJaHmg6FQpke
	 /3yNBmwAEFmDMBvGQQaAbY6vuihwU7kNZ9qv2Y6iUIsV4B/qs9/15SCpiJ6EqbQFs8
	 1F9osI8QY24PmCgsXc9P7RaK/wSU/9Y0TDw6uTnmDMSFRgpKFv83T1mj+nWGSjReKs
	 1dUunMlq5Jn2gpj+/MiBEubS5BUz4nxSjnZSYYEjeOcc/+v+4r8G/k1NKCBmgPFHLW
	 7lEUTJEpVPFtraK1Ma2gIVBEIdv49D7IVpBwK7OdSdgwEQXOqbb9h4N7mv0iQMkTKZ
	 ibkP83FZWwVCw==
Date: Tue, 30 Jul 2024 11:22:55 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 05/13] ice: add parser execution main loop
Message-ID: <20240730102255.GT97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-6-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-6-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:08:01PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Implement the core work of the runtime parser via:
> - ice_parser_rt_execute()
> - ice_parser_rt_reset()
> - ice_parser_rt_pkt_buf_set()
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


