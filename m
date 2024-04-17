Return-Path: <netdev+bounces-88832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537BC8A8A2D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8525F1C222C6
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158C117167E;
	Wed, 17 Apr 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFJZa21d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC716FF52
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374944; cv=none; b=TQbWc9BSnb90niL1OXtZAzqx7zAOiHRW5J63a5nq3OwQwbHYayaIB00RdOBQpSo9wgdUjJA87Z4EbJQCA5TNvIvAmZ3QfeUXpPxaqnNK5uHLdMiumBC0TsAwzZquWEsXq6619AdsoZ4GtlHp/RsTeGNZZZndDFdhc/6Qx19XH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374944; c=relaxed/simple;
	bh=b7R2+cUZWpLtI5PXc9qyorYuS/lA5d/ZVwiyQfTJmHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/6G0mn+LltrDUjN4Gy+xuIB0yNwEWcDk3Tj+zTT21A2K+AVK352jgNcoOFer5ftV/wS5HA1POLH845bb1We78ueHepYlOUe0uND2Z7vPzlfXXpAWI0Vi0GyRtUaT9QDGq1ueNifFPDbWWpE4CIPyZrAuqYRMxZwdVUx6HX3ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFJZa21d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7075CC072AA;
	Wed, 17 Apr 2024 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374943;
	bh=b7R2+cUZWpLtI5PXc9qyorYuS/lA5d/ZVwiyQfTJmHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hFJZa21d1bgXCegrdk2xS5Brsz9d0mm0Z+PqUs12up2yKgmMpm+1F3KrQMw3E2CUl
	 BogKkmW0EwFfvnZp9yWBJYV5t6Duf94rI21CWPeBDoH4jPtkt8YPZkI3/L+2YrXsBB
	 6aSD/yi9luXz/4iKoqT78msacqKnKRPpzz546vQtyxHqJxVXkmVPbh5AXMA8L8yzSe
	 lMfgyqebPpRV+2PGWwOITHzJQcIEnO1nk8qeTIE5sr0Q40rQt2XqFH7CK1dMGL/xFM
	 LTVJjM/M2fr+93xF5WNKqEpQn/4p7m33VUXifwo4DyNeTBemA5CT8sNiMfIdxXRWVa
	 eRVgSFnR/uj1w==
Date: Wed, 17 Apr 2024 18:28:59 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 13/14] net_sched: sch_pie: implement lockless
 pie_dump()
Message-ID: <20240417172859.GK2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-14-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-14-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:53PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, pie_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in pie_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


