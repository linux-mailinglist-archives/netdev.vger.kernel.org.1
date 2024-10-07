Return-Path: <netdev+bounces-132768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C57993134
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B005283123
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F351D9323;
	Mon,  7 Oct 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrZIPd+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB81D86DC;
	Mon,  7 Oct 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315040; cv=none; b=T8UahFdMpEX2MVCPtEYv5kYafQL4quXqyCGJir2ngLYKpqw3X6zB+Z2oQbgPjzP2RMhbIsJTOFYaBsi1il5f1fIVo8BA/SEAOQz68rgg7C+4Uuh3HAGxmGIv3/64qaQWiRqOUNz0y4hm15zHUEytIOcAhiJXYuzCfTx7Dz5fcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315040; c=relaxed/simple;
	bh=5cKVZtW1P+FLDiyBUcU65TPjXSEMfZ6QClzETXex82U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HANBpelRu3n772qWtdZ/9v0wKc9zqvGUwiRtie/3B3HME6WYT0OQIJ1xRBKALaQ5nA5bdmtBrVOWK6a1Ia7TDkBANOf9jW7p7Cd/epGlF4cJB/X48z2vXnAk7vt3j4oFVirw3mFE57wkYSc0OBrqVWV5pqv2amHZWIhcYwPBngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrZIPd+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E0CC4CEC6;
	Mon,  7 Oct 2024 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315039;
	bh=5cKVZtW1P+FLDiyBUcU65TPjXSEMfZ6QClzETXex82U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JrZIPd+ocELapWwNTLS259UaNgAm+zkFv5jvA94JRCKlu2QI6pVtcm//+zfIefn/w
	 08+N9zI+MjW317SxpR3rmcN0PqyxK1hPuqOTjt9/xhmKQYDDnEa4V8UvNpS/l/+mcM
	 oHyiIfNkND2LhRx4O5bbbAbXpdTHsl35dqEWuC8lzmZlWzqOIo2dqOWcbfHvjKM5su
	 MYNyCcBzLYO8UMdiGTQ17t/eBrdW3TT3PnxHAfot/7kYojotbPyymTa/T3+CzEoPFH
	 RHjmuah10aU7XynZP90DKNmxM8nFeO6H7iVHrARNBqJcZ771u1/Yybm0xU9TRogs0J
	 pa/o6nnKCWBhA==
Date: Mon, 7 Oct 2024 08:30:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Madalin Bucur <madalin.bucur@nxp.com>, Sean Anderson
 <sean.anderson@seco.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/2] improve multicast join group performance
Message-ID: <20241007083038.6b2e1f12@kernel.org>
In-Reply-To: <13350842-4d40-480a-b33d-3f223fca6c63@pengutronix.de>
References: <20241007-igmp-speedup-v1-0-6c0a387890a5@pengutronix.de>
	<13350842-4d40-480a-b33d-3f223fca6c63@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 16:30:47 +0200 Jonas Rebmann wrote:
> On 07/10/2024 16.17, Jonas Rebmann wrote:
> > This series seeks to improve performance on updating igmp group
> > memberships such as with IP_ADD_MEMBERSHIP or MCAST_JOIN_SOURCE_GROUP.  
> 
> Sorry, I forgot: This should have been tagged for net-next. Will be 
> fixed in v2.

No need to repost just for that.

