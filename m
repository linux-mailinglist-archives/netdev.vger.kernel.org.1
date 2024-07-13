Return-Path: <netdev+bounces-111282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2E39307A8
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2491F213E3
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B4413D521;
	Sat, 13 Jul 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwOlO+ND"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237E41C62;
	Sat, 13 Jul 2024 22:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720908549; cv=none; b=hG2IA7BNWvt9qFTvcvpZXoEP4sk8BGdvaErLD4Zphx85y506MEaPU0XXEGm9lcPNcXcWnRIqZbIVUBBAr+yjv41NxmIcTWh2MMmUj+1L0Jcy7rTx3Ec22iVCqB+u533Ee9bAxBOwdLXWtGlE97xG7eKDml4IZHTxLJApmrn0hMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720908549; c=relaxed/simple;
	bh=VgWxPCNUhsN8Lie+8YtIktJ46jaKYUaL35ZxVkvb2c0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHHPXq03h5d84F5zUzFGNnKsZ73A7fL8dl/dNUwEWedoBXPLR88ZDvEdAocyIIZYh16vkrlfdKk6UCTdc8feqoSO7UAhJ1ARYI1ezjUc77i8mBfhmRIvR5jsOl5XqtkqWgIllHWO3OBeVOmWpltoZUdLNv5rKhM1S5b9UeeL7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwOlO+ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40604C32781;
	Sat, 13 Jul 2024 22:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720908548;
	bh=VgWxPCNUhsN8Lie+8YtIktJ46jaKYUaL35ZxVkvb2c0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PwOlO+NDfvPGs0bVy/LFRjANLqifD+DkNcIpJaoc8K3ytIFR1QwZZmDw/lGcX4U8s
	 63U7861NE1u7o8V5+TqbBL1yOnoAEUONubCHJDysjRLhlVILPNSZQvBBs+qCMh16Vy
	 Zuh+6EczyPfGYT7B8SfUPagZ6tmly9us9W7gcjG5xXvZyX6gttPqbR3jm3XfH3Aiww
	 ciyAMccx6hk1lSqtSxh5jF1XwAyOwf53shdZtpsX+yXRFP2gfCN5RVO0vEYWFwh9tE
	 6KXsU9ijxF8x64nKME5Eu7+urji/Jh3pJ+4ATdlEz0ZAWuTZwPMxBveZr20ybd2kts
	 Vz7gnV4HWEjgw==
Date: Sat, 13 Jul 2024 15:09:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ilias.apalodimas@linaro.org, jonathan.lemon@gmail.com
Subject: Re: [PATCH net] xdp: fix invalid wait context of
 page_pool_destroy()
Message-ID: <20240713150907.4a65209a@kernel.org>
In-Reply-To: <20240712095116.3801586-1-ap420073@gmail.com>
References: <20240712095116.3801586-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 09:51:16 +0000 Taehee Yoo wrote:
> Tested this patch with device memory TCP, which is not yet merged into the 
> net and net-next branch.

That's fine, I'm pretty sure I've hit this with just page pools and XDP
before.. LGTM:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

