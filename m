Return-Path: <netdev+bounces-177531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C68A7078D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC53169A7B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264A25F98B;
	Tue, 25 Mar 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8SVvpg2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7E25F983;
	Tue, 25 Mar 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922025; cv=none; b=HtlxaLBUAkCNi5TPx2geVsnhlLOzvEX1lLrcOeluc1EM6zTclRRuPqq0MiBPFBDMD5CfuZOdOwHKtZ6p8NdjtUiujfyEiZv/E2Y2Xc2gbxCb5zIT64VxoppV3o436uWbyuXAuJzBExbbRpOO8x8dFuNE4uIc2AoWfAI5lACwXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922025; c=relaxed/simple;
	bh=Q0Z/XV2SVEkIoUtYmxXKaHbhCHg46BhIFu++fLKZfDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B++V008ZcPdI1Fhm2yH23iIC2/Lw7cejt/sD2gAf6lsbzQkohZgLxWbQYF9Rn+6dSHXDnJw66Be1+Jw/JumQYesc47WDMz16hCvIcIy3euugC6JKC/3xeTJFRacPbB5aW0UYjkxY4ArGiNOx8ooe2vad0whzckAYuOsP/be9J+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8SVvpg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0647BC4CEE4;
	Tue, 25 Mar 2025 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922025;
	bh=Q0Z/XV2SVEkIoUtYmxXKaHbhCHg46BhIFu++fLKZfDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8SVvpg2Qgrp8zS0g95LAlCt3BckoWlwfpt905d2X3EGknhoQhsYsWvLg9zT4n8/s
	 SivSt4gQnuIvjXxAyywcH7D26ZX0fkpqTyP/EE/oh6/jbfWhVAk5H6IYgRpZKAm7q6
	 t6fJA1pl7PncnqYIAQoXmwkNgIv8x4IR1fofa84gSbrgC+kQNLiM6VUKM898F9WQAu
	 k8PsYcRKnQ0n+GFLXMFiz5AbedNp9isySqDuy/AsskCexBMvSqoEyiHtosMiPgnVOY
	 AKvtMa6fX+ek7hIcCHT8aYNTwzgmXjVX2Y2xAxZmD7IZiy102wfqfCEs+/TYl47sWk
	 hIm66LYVx2nFw==
Date: Tue, 25 Mar 2025 10:00:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next] netpoll: optimize struct layout for cache
 efficiency
Message-ID: <20250325100017.257cb04b@kernel.org>
In-Reply-To: <20250325-just-sloth-of-examination-7cd2df@leitao>
References: <20250324-netpoll_structstruct-v1-1-ff78f8a88dbb@debian.org>
	<20250325084838.5b2fdd1c@kernel.org>
	<20250325-just-sloth-of-examination-7cd2df@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 09:50:21 -0700 Breno Leitao wrote:
> > It's a little odd to leave the tracker in hot data, if you do it
> > should at least be adjacent to the pointer it tracks?  
> 
> Double-checking this better, netdevice_tracker is NOT on the hot path.
> It is only used on the setup functions.
> 
> If you think this is not a total waste of time, I will send a v2 moving
> it to the bottom.

I'd keep it next to dev. A bit of packing to save space is fine, 
but let's prioritize readability during the reshuffle.
Note that net-next is closed for the MW.

