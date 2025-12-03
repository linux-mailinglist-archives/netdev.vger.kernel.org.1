Return-Path: <netdev+bounces-243430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CECA0E02
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 19:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C35830022E0
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483F33BBC4;
	Wed,  3 Dec 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTC65UTS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A133BBA5
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784447; cv=none; b=dmbMoxwjNTXLhwbIa44Vdqh0vhD+QJfBgJs8/iaW92n2FkKUniDjdLfmCeq3DKdq/G2YzAS78abzqRJK0zBYKklxuN5R1lisxx9L38wDrPpfjWax/qrQOVOFRV1IIEyEjK2g/zA6awxJKy7JrG0b90wz/rCXxobtuhvDQcI6wyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784447; c=relaxed/simple;
	bh=aEfIXhkV82Xl1BuVCpCimguK0wzp0KyEmjGWoBZcic0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE2TGBleWsQzIYUNrJ7f/qiMpCzVYJCoeY/1VPdsLS9y93bJx6gkSdb7/IiF9DPg48luCPt6RKhdXHs0stGspzByG6JIpv1Bi/xUEIFdFi+/XC2sgtZ+l1sQrpVlO1CNQVU/nA1mD6kfrhpoIFI4C4n5ajNUQAvMwEXv6uka+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTC65UTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06851C4CEF5;
	Wed,  3 Dec 2025 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784446;
	bh=aEfIXhkV82Xl1BuVCpCimguK0wzp0KyEmjGWoBZcic0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTC65UTSu2zPWD8h3N7UjXxgWMJIsSioIaxfEGBMElLufYo6moK7bJy8UFiwUUcLh
	 Mo93E3KBJ4erjFCGxawBxeU2Y7Uhy5sYggW4flZ/nWAB2V5RciuOlggUjqITukQwhp
	 Jft0/uDkUson5ZTlHEa6z2CKAUCNfnvDmisJQVCmah3B/O9leO5h4++OhQBrpermnl
	 sgnsMd0JrL6fgfvOJkks1POaYD3MpYgSU21vft+g9Q5JZqCfv3UvbWeUmfn1UiUEqF
	 kQy7YXH05s0G/yzQvRIWAPVSL3U8zVNaVpBNAigP8N/qM3OnpP9Cu0HGXV/ZI6yi7e
	 IDQHjwQGEvEAg==
Date: Wed, 3 Dec 2025 17:54:02 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net 1/3] mlxsw: spectrum_router: Fix possible neighbour
 reference count leak
Message-ID: <aTB5Oqp5ilW5fOpv@horms.kernel.org>
References: <cover.1764695650.git.petrm@nvidia.com>
 <ec2934ae4aca187a8d8c9329a08ce93cca411378.1764695650.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2934ae4aca187a8d8c9329a08ce93cca411378.1764695650.git.petrm@nvidia.com>

On Tue, Dec 02, 2025 at 06:44:11PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> mlxsw_sp_router_schedule_work() takes a reference on a neighbour,
> expecting a work item to release it later on. However, we might fail to
> schedule the work item, in which case the neighbour reference count will
> be leaked.
> 
> Fix by taking the reference just before scheduling the work item. Note
> that mlxsw_sp_router_schedule_work() can receive a NULL neighbour
> pointer, but neigh_clone() handles that correctly.
> 
> Spotted during code review, did not actually observe the reference count
> leak.
> 
> Fixes: 151b89f6025a ("mlxsw: spectrum_router: Reuse work neighbor initialization in work scheduler")
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


