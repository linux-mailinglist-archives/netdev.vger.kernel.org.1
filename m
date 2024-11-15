Return-Path: <netdev+bounces-145157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EC9CD5C0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68311F21E51
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CA4207A;
	Fri, 15 Nov 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnCG1I+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115E82AF05
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 03:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639970; cv=none; b=YEPjuHD169WOPbvcTVsYCxQj3eELU/B7hR5NjTs0Ew/TbB+ZAnpYIPi8c2t+HKtWt7uhX3HMRfAMrnFqyn5flMG812Faf+XQEsVEsqcRSeL2HiNdl28j8AazsK+sI+BEkWz17ZTjMSvwtgo3mZ5C6TK7SeVkr3BTWDI+EUe57NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639970; c=relaxed/simple;
	bh=En76RHlckrmo1xOI5oPVOeEzPPf6LEIoCKoFVg8Xhuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eo3+7Bya0Mxh+JewZUMaa9dkmyUR0buy9EwXCvx/VIfoYjMNz5FEpBvlbrY60ZmqYNdlVgwu5XHoq9X+4HfPphAML9sdU7nUr3mPvV1H58vxCnzC9kdOYlSJ6C6gm1WA6/BYuirj+YNBzZznjWp94ff/RQ0P1rM760AXw84Jd3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnCG1I+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C178C4CECD;
	Fri, 15 Nov 2024 03:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731639969;
	bh=En76RHlckrmo1xOI5oPVOeEzPPf6LEIoCKoFVg8Xhuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DnCG1I+JlrehIoAunX4y2J56N4dMeo78m7Z3W40Ymf+XVuRU60sTtZVDuQkq2AlOl
	 P0g76rqX5L4DhHjsyuuxMfeHR+Er2AxYzLFiHaTS7qMG2Sg99XAKA0txZxhRmLJVc9
	 QrUygyXBd8A1xBmU55QsReZ29UwD2oglNgp9Tlvv83unuwn9iyAnumkjn4WTJtH956
	 OQ4BDDH1PK0ZqyNWikfIhYGw+KsKp/Q85vn/umy5IztXVt+4uwaWoiT5hoK8tdEJxs
	 B4Uifgou/DUddfIx9S21tyoo3tTgDLmGz8b0XHggyiLpUPkWM5kbricCylPoxgPcGt
	 +xH3x6I2LN45w==
Date: Thu, 14 Nov 2024 19:06:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 0/2] tools/net/ynl: rework async
 notification handling
Message-ID: <20241114190608.67c62e03@kernel.org>
In-Reply-To: <20241113090843.72917-1-donald.hunter@gmail.com>
References: <20241113090843.72917-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 09:08:41 +0000 Donald Hunter wrote:
> Revert patch 1bf70e6c3a53 which modified check_ntf() and instead add a
> new poll_ntf() with async notification semantics. See patch 2 for a
> detailed description.

Applied, thanks!

