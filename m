Return-Path: <netdev+bounces-53278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DD5801E30
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6B280E18
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D6EAC9;
	Sat,  2 Dec 2023 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrQ+05CG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51943D82
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 19:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E0C433C9;
	Sat,  2 Dec 2023 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701544694;
	bh=q99w6aYzc7yVUidNOrcEr3gJ7JQ31CH9A37d0TCBQhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rrQ+05CGvVb+9S/qXfkD9f/nEyTFxZ37dv0N1Dor8HSUPTRdHu4r5HurTfaobWwfv
	 /O0iSXrG5ord9mfDKODltAzHLTtwtcFWxSNzKbq0kF8eu3h38O1PXshrPiG9OG0KCj
	 noAWhAc0Zg5UhXC6w/ISC8jOZnUkgadGR9pX0uutez/9mi99FBWSxOko5r9nQrIblP
	 gJwO1gmdAzgEVp8UVxsAN64L4sVNyShHI0Vxiz5Oyvm98BpXw7mRKhMywpcLFWSLiI
	 aDwivGa8F0cOozhdkPstWS+RY7RaNDHKyiXi+Pc3Y5c2kxN+E/ddMQIZODBkhkmp/b
	 pjRtWmea2dEdw==
Date: Sat, 2 Dec 2023 11:18:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, marcelo.leitner@gmail.com, vladbu@nvidia.com, Victor
 Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net-next 2/4] net/sched: add helper to check if a
 notification is needed
Message-ID: <20231202111812.0efcdd77@kernel.org>
In-Reply-To: <20231201204314.220543-3-pctammela@mojatatu.com>
References: <20231201204314.220543-1-pctammela@mojatatu.com>
	<20231201204314.220543-3-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 17:43:12 -0300 Pedro Tammela wrote:
> +static inline bool tc_should_notify(const struct net *net, u16 nlflags)

nit: tc_notify_needed() ? doesn't matter

> +{
> +	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, RTNLGRP_TC);

I think it'd be nice to have an rtnl_* helper which looks at the flags
as well. With a proper kdoc. Maybe someone will notice that and remember
to implement F_ECHO for their command?

