Return-Path: <netdev+bounces-89232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F128A9BC5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B264C2863D0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EAF1607B2;
	Thu, 18 Apr 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD0jWwsr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621A165FAC
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448521; cv=none; b=i0d+wbXFO7KHnlefOW9sH26CYBKkCW0ZsFMncCgs5hM0CFFYYSsxU1boAJI9LiNJQBOPc6BLvAaT5gpNeipoHUibM2Ud0oyJGja/AAgOnCGqUoXM1RkvYALA8ttH3qcnlbRoN31WeyZqZ9Vq6bxuy6Kn4T+e8PQU5z0kOgjpVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448521; c=relaxed/simple;
	bh=sED8Ptg5Tck54RTvcjpDRih5soBhsX/1jdVbhF+bl6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o485T8a+3U2kPhDKsSkxjMTiRlFvtwv42GxQNMH8goro3+qXY4nyPwedjKyc1AQxTxs/UXr2a//fFAMonyweo5F29aBJdhabcOKe4hAtEm6o6YrIM3i3ygiR+lwPlH5nhFBVLLEXzRCeh3/Bzhlhfg44n99hgk16XCR18fJG4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD0jWwsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7F5C4AF09;
	Thu, 18 Apr 2024 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713448520;
	bh=sED8Ptg5Tck54RTvcjpDRih5soBhsX/1jdVbhF+bl6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HD0jWwsrdYmylc0YqhP+1aDELL4h2SqKKkYzuAoVGj4yPgqstvxxAYqZJfl7gbZMx
	 EHiDj8v9magws4dhCuHDqhNWlA9EW1Xe3FSBN5veVFXg51zMm6HCx7GdhaDXfy5Kux
	 zwFS8nLm35Z1eEkdmP/9DPjGvX+HUmb/e2BjxOLcab+uowGfAlY89PmEqyQmLpYzhI
	 NPkNdrdXJMyyvJ+WfcdjiExO2PWUNPhsFVEYhgPc3artCfKrgAeEJrchTRWfTlxtnI
	 byaygW3JjAALbLsX8W2e1xLrwKH58aZm9q+GKtJDgN9+zTnOB2dVVae1V+L5CKS+9v
	 9XgOBZOmMRjXg==
Date: Thu, 18 Apr 2024 14:55:15 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 01/14] net_sched: sch_fq: implement lockless
 fq_dump()
Message-ID: <20240418135515.GA3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418073248.2952954-2-edumazet@google.com>

On Thu, Apr 18, 2024 at 07:32:35AM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, fq_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() in fq_change()
> 
> v2: Addressed Simon feedback in V1: https://lore.kernel.org/netdev/20240416181915.GT2320920@kernel.org/
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


