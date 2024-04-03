Return-Path: <netdev+bounces-84429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB6896EEF
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E3D1C22143
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A9C38DC0;
	Wed,  3 Apr 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw5cyG05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F023BE
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147836; cv=none; b=igmYFdZ5QSV22dZNcfvr7NrDe5Vdrtd2UEiMJ90JcyJSOgQ2hAt360tT2MBtdsQCL2ZvGIj0gw4dBbvje+C/ciK4Pf0HIbLWXllCqyOEx5GNizro3288Zn/Zke6qCBJvls9Ved3W+iehur3DhNvYi/dl2BS60uX6yMbieaAPyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147836; c=relaxed/simple;
	bh=CF3rnAd/fsvx1wfC7sulODyXxsR3kMxI1t0AdWue+sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3x+pP4zbGvbmIu0jgXvZS13bo3+RTLUQgODf4NFG2TFK91Nqn2IdU2qftbZ+O0jjCC0f0vZ1FL4RK/Maoe2ixKostB0qlECKrziLzTmO9zEUcTymtczeagFBwj7FyLhslqwjpGhJKXf+praHTTz6UlvI1jpJ0ZaY7nW3rkCneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw5cyG05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AE8C433F1;
	Wed,  3 Apr 2024 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712147836;
	bh=CF3rnAd/fsvx1wfC7sulODyXxsR3kMxI1t0AdWue+sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yw5cyG050teVqA5YfBMVrpj9eyUfSvT3sGgnEYVrBQlArA0Aj8SDBJsVeq8wUfPBv
	 fzrcPsQvSTIyCxnVsR0T4NT49Yy0A0YIuiVc8gahlKMBKcPAHPouWmI3541y8xtt2r
	 cAuAD61XT1tweV/It2N3q9OStj8pthTppRpos7bsGaYaT+2AVOrmOd2qzScuL2E4iZ
	 FpOivrlZuFe86UmhF9B7agZQtNLsCJblLn7kgCHTiJ2uW8gtfuG+AIGtS+eTIHnc+1
	 XbOYx0gz7wz58awn2mp+nNX2C0BDVnwDPolLpyM14Egkmo5WBdsny+DAuJThS/z0K2
	 a1LmgkXRJ/GkQ==
Date: Wed, 3 Apr 2024 13:37:12 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 02/15] mlxsw: pci: Move mlxsw_pci_cq_{init,
 fini}()
Message-ID: <20240403123712.GX26556@kernel.org>
References: <cover.1712062203.git.petrm@nvidia.com>
 <25196cb5baf5acf6ec1e956203790e018ba8e306.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25196cb5baf5acf6ec1e956203790e018ba8e306.1712062203.git.petrm@nvidia.com>

On Tue, Apr 02, 2024 at 03:54:15PM +0200, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Move mlxsw_pci_cq_{init, fini}() after mlxsw_pci_cq_tasklet() as a next
> patch will setup the tasklet as part of initialization.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


