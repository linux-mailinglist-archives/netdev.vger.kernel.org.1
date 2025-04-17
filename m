Return-Path: <netdev+bounces-183823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A9A9223C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F695A1CC9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759E253B7E;
	Thu, 17 Apr 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+sGNXaQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A481B4153
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906050; cv=none; b=Dd6qQALQdlfl8aQwEm5VpN+tP0QT+CHA8a8d03+5YBpsQgzNOVfmxVK6zz/BjY2RyEdCupRG3g7JuDox6LG093PUcy1dTSZ19cp0nx30CIkjNaF4CEtfyB5Y+KTW+QLE2Bm32/FbBpPZpYY46VYMF/VAfyzqsJRzxlyBoSJ2EYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906050; c=relaxed/simple;
	bh=Wa7gHZln12dvfA4pOGNKpc1rjCEwjtm8F7ok6Kc7dBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nucXQzALPmCV4jRvTwngzcbtYoN5By4mwVBVEC5PdsxhuIZeb/aXqeuTFPZXaPqbkJZlO0tTGSO1ukId0sTxJ1p47QKmR+i/cfxyXJNXiywALBtcA3fTZXqDHWBijgdoa4Myv8Ie/V/uNymdvcYXOWljdpC2MgL9TAdgCUBbD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+sGNXaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140D8C4CEE4;
	Thu, 17 Apr 2025 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744906049;
	bh=Wa7gHZln12dvfA4pOGNKpc1rjCEwjtm8F7ok6Kc7dBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+sGNXaQR7cJzpr5zel8DE7UW9/xQ3Kd0yafK9oAxu1S1dNoCaqATD+q9gCF0913o
	 bhGk7SIbxKkpT11albXqdzXM2nJwqLA0TpjyrruR2uDuQYkfm5X+EiRXniJpbz1pjW
	 h2tOLRtDaMugxe1bZD0tmTPQ6kM14O8yyLBABUw9NmDpV6ENS8kgPZkKnSVEAYhMS0
	 sGYtcjZ0dfOR6nD269cRKYz6Ks11MR0KzBFmL7+pbQN/D0bTEgP105+o3jjoM0L0zf
	 EBjhk9+cGBBo/ig5D3QCsoPPHOIAl0tq7RYc+xwaWg9xiiB17g2x4HErJqgpzhHw/z
	 fUOHWn9B6C5kw==
Date: Thu, 17 Apr 2025 09:07:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
 pctammela@mojatatu.com
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant
 enqueue cases
Message-ID: <20250417090728.5325e724@kernel.org>
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 07:24:22 -0300 Victor Nogueira wrote:
> As described in Gerrard's report [1], there are cases where netem can
> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
> qfq) break whenever the enqueue callback has reentrant behaviour.
> This series addresses these issues by adding extra checks that cater for
> these reentrant corner cases. This series has passed all relevant test
> cases in the TDC suite.

Sorry for asking this question a bit late, but reentrant enqueue seems
error prone. Is there a clear use case for netem as a child?
If so should we also add some sort of "capability" to avoid new qdiscs
falling into the same trap, without giving the problem any thought?

