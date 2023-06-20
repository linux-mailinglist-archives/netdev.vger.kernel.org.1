Return-Path: <netdev+bounces-12341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333D73721F
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E241C2033E
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025532AB2E;
	Tue, 20 Jun 2023 16:53:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E32AB20
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D3EC433C0;
	Tue, 20 Jun 2023 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687280016;
	bh=tym3va7j07rMbqs2XCuinzFJ802Qjkt0MtFqmhGk3ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r10cVUfPBuLkZ56j6N+k+iw6IlMHxU/i6xOx+Be0wPkyUvEcegadWTS5mNWxEmDiU
	 J0fjeuu8J6bVpiazUkWIorhudFokmftZAzeQYW0/zT8mY8qSv7YEqHJenT4K+40IOK
	 G30vR1/hzQtsGqGagf1dCpMejq/k0B0h0/z7IeCU7is+DF5/AtUZg2Wsgm9W7ZryvS
	 mVSgStXPQa1B9tN9BuGzfEZIym9ne1/UX5vvVLBPEFlJ22PAAgaFWf7KBs5/UvlhCm
	 buQ9y/5VK26svr9vU678dKI7ye4mUtsbwertXGCgv6ISyORtc4TdvNjF6Oaa4ob8Ud
	 93jj3GtI5KPbg==
Date: Tue, 20 Jun 2023 09:53:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
 michal.swiatkowski@intel.com
Subject: Re: [PATCH iwl-net] ice: add missing napi deletion
Message-ID: <20230620095335.43504612@kernel.org>
In-Reply-To: <20230620082454.377001-1-maciej.fijalkowski@intel.com>
References: <20230620082454.377001-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 10:24:54 +0200 Maciej Fijalkowski wrote:
> Error path from ice_probe() is missing ice_napi_del() calls, add it to
> ice_deinit_eth() as ice_init_eth() was the one to add napi instances. It
> is also a good habit to delete napis when removing driver and this also
> addresses that. FWIW ice_napi_del() had no callsites.
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Is there user visible impact? I agree that it's a good habit, but
since unregister cleans up NAPI instances automatically the patch
is not necessarily a fix.

