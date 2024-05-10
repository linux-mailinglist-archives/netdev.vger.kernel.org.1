Return-Path: <netdev+bounces-95433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70C98C2396
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7563128574E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1131708AF;
	Fri, 10 May 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQz01ke3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7224170843;
	Fri, 10 May 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340600; cv=none; b=o/X6H0L4G40XRfOv4C047zWLjQbsWPH2pY1cw5VRi9GZBnstG76lA+6PFFG5ytCiMxS20ll7D67MNpVl/A9hEa//KYEuby1Xyi6ntmvhyegueTt+G3eiCitMQVxbsLZvTsNajc2gmNsvhcchdmW84R9vJIsW5l0RnFmkbAa/XIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340600; c=relaxed/simple;
	bh=KKvkbTRtzbeN5SrXmbObuSNo+cFIWCX53J8nwbybmrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOVx/D+JDLoW8cEx7ArZhL/kXoW4dWOfEYnR1y7kHCV7MUkEtkVS3NO7NUH9uJpInN0st7rPxk59P6euEaTB/YHCdaqxaXyaR2FgxWLNtmf31KFimalRO67pYIWdZOHnGbgJq1Gm77TL52/oNdzyNrPDvWkGmk5qhfdN/gaWA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQz01ke3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3729C113CC;
	Fri, 10 May 2024 11:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340600;
	bh=KKvkbTRtzbeN5SrXmbObuSNo+cFIWCX53J8nwbybmrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQz01ke3r7dXgmtw0ymtob0suOdZ1ULAS7AQs8Nk/XN1ZgGnk0MS3bsZdvLufV0sZ
	 NQp2XHzC+y1KuhM70m7BUButUKig7SWbW65CdTBhODw2/FGX8Xd8AcsPgZWoQQ7R6H
	 4G4vwRmSixfodgQ6bfycPtFbkHkWogql00YpjmVG4TK1f8+UUabERHV71mLM+EdShG
	 Gto7Gl2SwwmUvU/UESCef7UuBvDelu7Qb5OxmmbPO8+A7YCDter+58Cct4v0oLQJ2l
	 T1kbcZtv/TpmYrG+q9k9WeaM71HKdEkpyUO22SgqHJwl2uFfoa97XrncY+Ibqc5JS3
	 k/uuKaeykpEcA==
Date: Fri, 10 May 2024 12:29:54 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 11/14] net: qede: use extack in
 qede_parse_flow_attr()
Message-ID: <20240510112954.GN2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-12-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-12-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:59PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_parse_flow_attr() to take extack,
> and drop the edev argument.
> 
> Convert DP_NOTICE calls to use NL_SET_ERR_MSG_* instead.
> 
> Pass extack in calls to qede_flow_parse_{tcp,udp}_v{4,6}().
> 
> In calls to qede_parse_flow_attr(), if extack is
> unavailable, then use NULL for now, until a
> subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


