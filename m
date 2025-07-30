Return-Path: <netdev+bounces-211078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29829B167B9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376483AD4F4
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA00521FF45;
	Wed, 30 Jul 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxrV+kta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87115214801
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908135; cv=none; b=rPSLBFlOVTJH9R0FbFbvTaDE92S3QwHqnUcisRb3cDIOl6rBE0F18PlHlhESNjWmwMd/rh6OaFR2SH8Je8qjJXL8KzY0kem9W4Uvx25X4n8i5RKl7YC1c17zrJKRFmVtSyWwGsGuC9ES2PgTmTBR0AZa97UMB8hNBXdpNXLHpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908135; c=relaxed/simple;
	bh=1aAClxT4psf3EFYQgGOZLBSfvvX4pMIV7tHo+ij758U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n37ksnMfLokI7JpVGHvTZISHqYkl1pCba4+if8ZaW2mM3OVcSYpNoEuRtXG9z3PZGX6XqnxZfvmJEpjp/v8R0fL5dEwxXUngMfAxXYyfDucY3P5k4anHvMtM5w76y6wSkKBEyqGDXozKBtjbIG8B4E10xyQo3PJsEee73+6XlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxrV+kta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7D8C4CEE3;
	Wed, 30 Jul 2025 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753908135;
	bh=1aAClxT4psf3EFYQgGOZLBSfvvX4pMIV7tHo+ij758U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxrV+ktaH63F648frkgSVxyvAEXU9mSlTmC6l9yPlA7lvcOgjkJZDHWTE6ZNyEUuM
	 RGBxksa378Ha00BkxmFsZ6DkgC+UxA6VcL0AgaM9rkALaNQmbTuu4sEp+C2Qyq43vo
	 g2/XqghmatowUTv+/7NMcC6vaM4OVKRJNYS7ImIuTlEN8TQxB91nlyuAMT7txczVUI
	 VyQdbRfP4MHXTHurPtZyi4dKbswOfS0ziMX4/U/r12VlN8v9hwb0WGCp5B5ZpP87qo
	 LRKOoNaEFZQ9flnx2oOKtsHGcKin68u5Ia0z20LXDVpqgA/20AKsnA8nO+jWvb8Gct
	 rEg95gM1LQBCw==
Date: Wed, 30 Jul 2025 13:42:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Simon Horman <horms@kernel.org>, "Ruinskiy, Dima"
 <dima.ruinskiy@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next v1 1/1] e1000e: Introduce private flag and module
 param to disable K1
Message-ID: <20250730134213.36f1f625@kernel.org>
In-Reply-To: <20250730152848.GJ1877762@horms.kernel.org>
References: <20250710092455.1742136-1-vitaly.lifshits@intel.com>
	<20250714165505.GR721198@horms.kernel.org>
	<CO1PR11MB5089BDD57F90FE7BEBE824F5D654A@CO1PR11MB5089.namprd11.prod.outlook.com>
	<b7265975-d28c-4081-811c-bf7316954192@intel.com>
	<f44bfb41-d3bd-471c-916e-53fd66b04f27@intel.com>
	<20250730152848.GJ1877762@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 16:28:48 +0100 Simon Horman wrote:
> My opinion is that devlink is the correct way to solve this problem.
> However, I do understand from the responses above (3) that this is somewhat
> non-trivial to implement and thus comes with some risks. And I do accept
> your argument that for old drivers, which already use module parameters,
> some pragmatism seems appropriate.
> 
> IOW, I drop my objection to using a module parameter in this case.
> 
> What I would suggest is that some consideration is given to adding devlink
> support to this driver. And thus modernising it in that respect. Doing so
> may provide better options for users in future.

FWIW I will still object. The ethtool priv flag is fine, personally 
I don't have a strong preference on devlink vs ethtool priv flags.
But if you a module param you'd need a very strong justification..

