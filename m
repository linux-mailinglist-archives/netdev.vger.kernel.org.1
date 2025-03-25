Return-Path: <netdev+bounces-177404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F4BA70076
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F123C840675
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE25267F61;
	Tue, 25 Mar 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIXQ4K5P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A232267F58
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905866; cv=none; b=WEQHAnCw6jMBgBaVtGycrjlNzPy81/VEPTl15iRDdr72i4aOi5rOxTaoc+3MUkDwDze9OrdrKZKpUOs1OGNgnOkYb/QVDzEIrcJ/gFYaZzBUvzKI4Jl8n5VF9EanHPY/KttyWlKiNKVd1YBXZ79y30bmBDuZF/ek5qMtQyn3HOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905866; c=relaxed/simple;
	bh=0MCOUrzYIIvvCG567dqPHEyy66MNTZeT2L0TmtlGyR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ig30TbouOVEMM/PIkCyIF6tnEM7IYvwkLD5f5rw02ttwsOMr41qTZ63yg/MBRKZUToITeYB7w1qIOEqV6SiUx/e9FA/2IrloX94Foi0bdtoulFbkkIS9Y0pAchPL2KEqhyCHNSXsVqoziG/hf82Hl4AhyHxyGkSqDXbWf+KhGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIXQ4K5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F2BC4CEE4;
	Tue, 25 Mar 2025 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905865;
	bh=0MCOUrzYIIvvCG567dqPHEyy66MNTZeT2L0TmtlGyR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NIXQ4K5PQw068AnBMK2YaGISRAWh7yxIEY3iVIbrb8OY5g4GwezpzDsR6NXnhTxKK
	 RYegfNhLccO9l25gAvGQlWyDBFlKRImWl1T1ceCFDC5KokcREtDNNNMBMCtN3m/o+R
	 TAIkOUGQjIVi3+RE583a1026GVUg4Bp881Rqc9iDXQNqbiuAZJiSc8nTMAINfUFOUm
	 TIcGUcRsbjL2iTSOxiYNGy8HHLl4YiwAQ7jWhEcwrOmdD9vY+eWFSCdqN35h3XFMRc
	 ev2Xr+FdyhBhH6CtgG3QECQlQ0KVEiYi8T6U+bVqn147xaBbb9Zf+BEBgHgQ0RSNyZ
	 YdYijfDH/UnDA==
Date: Tue, 25 Mar 2025 05:30:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mptcp: pm: Fix undefined behavior in
 mptcp_remove_anno_list_by_saddr()
Message-ID: <20250325053058.412af7c5@kernel.org>
In-Reply-To: <7F685866-E146-4E99-A750-47154BDE44C6@linux.dev>
References: <20250325110639.49399-2-thorsten.blum@linux.dev>
	<7F685866-E146-4E99-A750-47154BDE44C6@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 12:33:11 +0100 Thorsten Blum wrote:
> On 25. Mar 2025, at 12:06, Thorsten Blum wrote:
> > 
> > Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
> > removed a necessary if-check, leading to undefined behavior because
> > the freed pointer is subsequently returned from the function.
> > 
> > Reintroduce the if-check to fix this and add a local return variable to
> > prevent further checkpatch warnings, which originally led to the removal
> > of the if-check.
> > 
> > Fixes: e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---  
> 
> Never mind, technically it's not actually undefined behavior because of
> the implicit bool conversion, but returning a freed pointer still seems
> confusing.

CCing the list back in.
-- 
pw-bot: cr

