Return-Path: <netdev+bounces-167061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31864A38AAA
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 18:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A19E1887845
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 17:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D42229B10;
	Mon, 17 Feb 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKqLnLCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2621A421;
	Mon, 17 Feb 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813864; cv=none; b=KOpAjuZaMvFRJOuOGzJE7IYu4ydqVUMqZ6uzo21mbQGIrX6CwxDhlnZUKvhYFZdMMa83yq2bVM7FRNMUCXcLRvnwbWts0FjipFnVqgs6nYx62j5yocek17MdxRdR1ZQvxALfjrZeSP7Pp1gUcGRs1Eu+gK/Oo0ndvcp+CSwRNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813864; c=relaxed/simple;
	bh=bs0udLnZLKIihp/oOYtvD0qF1aNRM/Cd/sDif6twihM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLwJUTr6wza3I8E+Ti9URqAR8N+Jw8+9rhFqzKgs6q/NzlD2s8HeExXFNHR9ImgaS6ehII77TVbTNNj93JEMYINmxSIUOD/K6GdKP88iG8DTOJp9gf2pszoV2p/pVQR1XOGEbsbJRsrE5kHAuV/f6GIhdDSN89ucghm30Udxhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKqLnLCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0ADC4CED1;
	Mon, 17 Feb 2025 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739813864;
	bh=bs0udLnZLKIihp/oOYtvD0qF1aNRM/Cd/sDif6twihM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NKqLnLCmqAbcMk/uJFpo40ZKvCpiB1k3h8wFN/vcZluCv6XOBo6nqzxSREqMViwTN
	 Pvqe3D6MK0V5R/P8WO2trUh3MDssPdpWvCgr1Zi+bk4dYc4r2ZsFKHr4WqACNvSGVn
	 +ysU4izAqc0n9UqLbw3JtOptjsMhY8ajHXMWk+1qafO/6ynpCjSxbeCImBhDfFE7wr
	 9BmvvJKyOC4M6hhj4Le8vkhbz51/b1Ns+djxmTaEtnHbLcH72VpJWcF7yLla2DEKrA
	 C/phj6mkq6YwmIEmVZqntDEwmPiFiEvLXrlzMWzHNSOBKhTRfxISHTZPRwM3Mst3gT
	 HvV7xPw2xxnVQ==
Date: Mon, 17 Feb 2025 09:37:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hayes Wang
 <hayeswang@realtek.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250217093742.0eb20b95@kernel.org>
In-Reply-To: <20250217-weightless-calm-degu-539e59@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
	<20250212174329.53793-2-frederic@kernel.org>
	<20250212194820.059dac6f@kernel.org>
	<20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
	<20250213071426.01490615@kernel.org>
	<20250214-grinning-upbeat-chowchow-5c0e2f@leitao>
	<20250214141011.501910f3@kernel.org>
	<20250217-weightless-calm-degu-539e59@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 08:46:21 -0800 Breno Leitao wrote:
> I think a better solution is to do something as:
> 
> 	if (!hrtimer_active(&rq->napi_timer))
> 		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);

sounds good

