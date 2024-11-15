Return-Path: <netdev+bounces-145175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E202D9CD628
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A30E1F226A1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44573156960;
	Fri, 15 Nov 2024 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du+SIzwU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18566664C6;
	Fri, 15 Nov 2024 04:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644133; cv=none; b=scGhKqTwMQDWtoqluyZ+e4LRzTZ9pG7OiQEPT/OzayO4WErIbIj9CIrfJbLIwvfIMOpwM+QeDOVWPqO7fM4lL1yeqbRFxGBNQEPVkgP9ApbJuH7csiMCMlqyYAOQolB2v08R/k4CQZoeI1gY2vaBDON+rYLXF7Pfp4MjGM8cHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644133; c=relaxed/simple;
	bh=h0mgpNn3A+Jb8CQpdRlZYdmbo+q7m2DjnO2GSIw+aBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBjsoBOgdbgT1Yhc8BExYR1KZoUHrov6XMZg43njAHKt4pXIU2Dp2g8EiptclClgOe1nUe78WdMhFKKNRnnT2nzwwFMWCa/orZwMyMVk5sQdv2MvN5UgRNSRPy2VuMtD294IMFkMGxknv9jTRq9aeBQzEF+CsTRQfoAQm0bKYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du+SIzwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64A7C4CECF;
	Fri, 15 Nov 2024 04:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731644132;
	bh=h0mgpNn3A+Jb8CQpdRlZYdmbo+q7m2DjnO2GSIw+aBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Du+SIzwUEBehe76/dUgMM6uPD0NgsqUJuJ70Dbh2JsPdP5iFHb8Re5YYF6IJa15Dy
	 NaEaR5LAhJInWiJVTvM9LsxW/QrgsQS3LQMcAYBhNIkYUoc06ROzVT5CmnBGIwkl4R
	 BbF77zQwKf/n5nwVB8sy9nDYNKOy1qdPnnt0d/U3MnDa9ivu1w9jZ/WmSRSE7PDh6d
	 egFOujztG5FkDF8XcVjsYXBY+uKV4MPycrDbUwRpFigp3H4s6YnITt16lJmJhrqEWA
	 dvkRQcq88Q2j87gtOkZEM70xk5zJ/wT5rNwIPiLgxL+pvh5kAoqk2DRwMw98KATUC6
	 SDhCiW09gihhg==
Date: Thu, 14 Nov 2024 20:15:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v5 3/7] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241114201529.32f9f1ab@kernel.org>
In-Reply-To: <20241113173222.372128-4-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
	<20241113173222.372128-4-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 17:32:17 +0000 Taehee Yoo wrote:
> NICs that uses bnxt_en driver supports tcp-data-split feature by the
> name of HDS(header-data-split).
> But there is no implementation for the HDS to enable by ethtool.
> Only getting the current HDS status is implemented and The HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows rx-copybreak value. and it was unchangeable.
> 
> This implements `ethtool -G <interface name> tcp-data-split <value>`
> command option.
> The value can be <on> and <auto>.
> The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
> automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
> automatically disabled.
> 
> HDS feature relies on the aggregation ring.
> So, if HDS is enabled, the bnxt_en driver initializes the aggregation ring.
> This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

I may be missing some existing check but doesn't enabling XDP force
page_mode which in turn clears BNXT_FLAG_AGG_RINGS, including HDS ?
If user specifically requested HDS we should refuse to install XDP
in non-multibuf mode.

TBH a selftest under tools/testing/drivers/net would go a long way
to make it clear we caught all cases. You can add a dummy netdevsim
implementation for testing without bnxt present (some of the existing
python tests can work with real drivers and netdevsim):
https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

