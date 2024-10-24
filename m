Return-Path: <netdev+bounces-138717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F19AEA05
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1548281CCE
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A07B1E7674;
	Thu, 24 Oct 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEORTeaL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E41E378A;
	Thu, 24 Oct 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782810; cv=none; b=PEh4dPMSEAiv/BOJfNQMGpYtn5BUgRWg15cbTzw4quxe1FMjSCxVHpz0QZ4bTPjnUfJX/fWuRJt2796M7/MZm4HAMVb/5P4OkPbkTuqgXSNVCn9tsIyhGgKn/2eHQOyLCFziK8H6VYUFNwNILfpF6TneNYWuVX+mXcLw5uqTNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782810; c=relaxed/simple;
	bh=+2/uySlBuG14jAytYUtOfQ+CdOhbHG/L2RdziFggh6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib8pQoEEOC+zlE2/NDW8EcEey4bp/efksMpYkcHlDjPgOqJ9H0oim5XFEUagX7JmmcgO3Trkf6WYcOPg59hnA6Zmb/oZG23WBAZgc21jLPzktD5AaTQLvHOr7h+NyUmqmTBgZEXvjmTtybuR1T9jkyLEkDRYnfssb/rG7NQJwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEORTeaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2328C4CEC7;
	Thu, 24 Oct 2024 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782810;
	bh=+2/uySlBuG14jAytYUtOfQ+CdOhbHG/L2RdziFggh6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEORTeaLkZDxVvyF3BOW9HHvNx88UMCv0Tio04GdcG9VUjPkPmTxhKP/Co7EVJD32
	 r9vPeaGx3h3gqyxkt1RpipYVvpKutXryFUubGQbWCYuqwrXZjxGBGfbxeGst/oOJ+2
	 ROO5RAnVoQaQI/YCWQYUN61BWcF4uXc12TR9br0cg73n/oho+O/Ltu3tNj9z7cHYT3
	 HOkTfC4kUn1u467IAvWrouRYqaIvWWKcis6L2jpK4rDUi/zQD72zoF568gjE8Lbn9Y
	 BtjkwNT4HfqsOpvzsR+XEuFMgpGMYVWePJ75CeR5UqygtPmsDMUdqjVeIs8Zg7syGV
	 8fBS8pYX8gVvA==
Date: Thu, 24 Oct 2024 16:13:24 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] ibmvnic: use ethtool string helpers
Message-ID: <20241024151324.GX1202098@kernel.org>
References: <20241022203240.391648-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022203240.391648-1-rosenp@gmail.com>

On Tue, Oct 22, 2024 at 01:32:40PM -0700, Rosen Penev wrote:
> They are the prefered way to copy ethtool strings.
> 
> Avoids manually incrementing the data pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


