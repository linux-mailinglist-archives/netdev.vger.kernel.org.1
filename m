Return-Path: <netdev+bounces-93441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A598BBC8E
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383DA28214A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D123BBEA;
	Sat,  4 May 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnlA5KHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915D22F00;
	Sat,  4 May 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834760; cv=none; b=CaC7/lFVjabbGOva0fu6fQQ115JioS46zwLqhWeezzr3P8xsITLRjOOhq+vnDP1kVNhaE/UH6R7A0a2JJ+aQ82s1g7lHXAjFKnn+FBLM2fx2ZDZR5V0rshWMmbmmWfsydZ6lFrCy3UjFUIaoEdb6Fy2mJf0OPWgALkcsb8ntirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834760; c=relaxed/simple;
	bh=ArksyxeeP1MMkr9Ujq3hylvnBGzE09FmLgmsVBEoOTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deB3wDOye1jAPTeh7f9gHuD0Jq6O9GrMRG6+mv6LalUBvmCVmj3U/pvD3OwNwCiLMyN3AcwigSZ2Zfg8pj5lhVkcTtjz0d58G1IrNH10TIB0gz2dR+p2cZYeiQMd2IaKxMt1CrCC8zE3y7FkOML5Z0SNtJy5PgOzWPCVoLvD9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnlA5KHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80300C072AA;
	Sat,  4 May 2024 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834760;
	bh=ArksyxeeP1MMkr9Ujq3hylvnBGzE09FmLgmsVBEoOTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PnlA5KHSYydjhgfy0HYLGyoss41YwnKtS0SMTVkRtHb63cMXw8buMQ6aWh1ESA7uM
	 h2R3tck9qOkJgYL02IrI2gPcjcKtPGFU4S0rrFcJp0sc5T+A+MB4T3W4y9NzicJ3Pe
	 cpa2lfT9Ys6jZMMXFCubLFy4RwhvodELC1HMErtV61gMMSwVr0z8kRjC2S7ojMxdRZ
	 nO/5lTQUfKlvwTPILPBzaz2ZSyTXig06rtLWhhNeIHgwSGg+4Jat49tsA0pKQFgCjJ
	 vhcVejOSP4u5BOusxSRQibw19puDQovoVpwZeDR7rlAkpMNcuW5Ewc9GpCQYR/+u3f
	 ttT2faLJkqwtw==
Date: Sat, 4 May 2024 15:59:16 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next 1/3] net: qede: use return from
 qede_parse_actions() for flow_spec
Message-ID: <20240504145916.GD2279@kernel.org>
References: <20240503105505.839342-1-ast@fiberby.net>
 <20240503105505.839342-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503105505.839342-2-ast@fiberby.net>

On Fri, May 03, 2024 at 10:55:01AM +0000, Asbjørn Sloth Tønnesen wrote:
> In qede_flow_spec_to_rule(), when calling
> qede_parse_actions() then the return code
> was only used for a non-zero check, and then
> -EINVAL was returned.
> 
> qede_parse_actions() can currently fail with:
> * -EINVAL
> * -EOPNOTSUPP
> 
> Commit 319a1d19471e ("flow_offload: check for
> basic action hw stats type") broke the implicit
> assumption that it could only fail with -EINVAL,
> by changing it to return -EOPNOTSUPP, when hardware
> stats are requested.
> 
> However AFAICT it's not possible to trigger
> qede_parse_actions() to return -EOPNOTSUPP, when
> called from qede_flow_spec_to_rule(), as hardware
> stats can't be requested by ethtool_rx_flow_rule_create().
> 
> This patch changes qede_flow_spec_to_rule() to use
> the actual return code from qede_parse_actions(),
> so it's no longer assumed that all errors are -EINVAL.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


