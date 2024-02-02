Return-Path: <netdev+bounces-68593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88A84756C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50693B23893
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A31487F0;
	Fri,  2 Feb 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWazF4NR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF61487DB
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706892808; cv=none; b=srFuqQKvOQjUerDF+HdUHVwhTztpEvczMKTYvX6+Qa43ntoVSL0WMprPLO28rBImuridtZCpGuLAe89z0vRWHNJsnyJyKFZOPuKrUXBpfoq0PDIhcJcPjEpslb/fBkSYu3XpnBT8hdTOGxsWQ1k4mMNxHAhrat7VOzMF1qKmmoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706892808; c=relaxed/simple;
	bh=OTd2GrYK2dd+xwX77/wmbOJ550myVDA/FB3dqKByg6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kib3CWapo9bT121Q6E2bVhmVJy767pd/KSDTOp/0P6D7uxtQEHCsVBaO4Y7qjkcsUsgfATGVdpCVagfrs/ywtnU838jl4G4RcEq0jP2I7776oK0D3YaXGD9oF7IcYUz67c6F9hrQCiN6byU6Fk3VAfSxbETy4RlOsTcaqMEhy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWazF4NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A777C433C7;
	Fri,  2 Feb 2024 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706892807;
	bh=OTd2GrYK2dd+xwX77/wmbOJ550myVDA/FB3dqKByg6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWazF4NRMXZbagzmbnlHQl5iSnwtsu7/DjEe7DyWkSWEK3ZFXUzQDQ5APHLugWXMC
	 T7d5RixKojczbvOcvuaI+746uraFUbrVdy9p0B0/+2e5vrnX9picN31mA7PTlj1RKA
	 +kf7M06pMKXBbiA2NePyBl33zoVqVYBhHET6LeV3kAPO+xNHKHSQutoWugRF1yVZrN
	 iJiaTuy/CNtpOWVA1hzPr53GAjIHVS7GIxDOD5lZvfRQjN+iArIoFO73/OqX/0xami
	 UeUIuGM5JCX282MgUhAUt3CMIo8OaIGf0BIrFzcv1dIBW4oxCXvbVYkiWzLlnwhcgH
	 UQc8fGSVCVtMg==
Date: Fri, 2 Feb 2024 17:53:22 +0100
From: Simon Horman <horms@kernel.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next] tsnep: Add helper for RX XDP_RING_NEED_WAKEUP
 flag
Message-ID: <20240202165322.GR530335@kernel.org>
References: <20240131205434.63409-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131205434.63409-1-gerhard@engleder-embedded.com>

On Wed, Jan 31, 2024 at 09:54:34PM +0100, Gerhard Engleder wrote:
> Similar chunk of code is used in tsnep_rx_poll_zc() and
> tsnep_rx_reopen_xsk() to maintain the RX XDP_RING_NEED_WAKEUP flag.
> Consolidate the code to common helper function.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>

Reviewed-by: Simon Horman <horms@kernel.org>


