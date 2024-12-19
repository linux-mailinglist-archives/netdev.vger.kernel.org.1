Return-Path: <netdev+bounces-153210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722339F72FA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C241891B35
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934EA78F46;
	Thu, 19 Dec 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkKQU2Og"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4B78F44;
	Thu, 19 Dec 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576560; cv=none; b=E6tFhCBW729N78Z9B9XUquJpZ0j41+a2l8QJBI4WlGOnZOqthCRvwwaNv+yrpD7zwjaFkLAeYBR4bpoLVZkkwDVGrXNaGxqRIkwqeJbz+/ihLwrvV5Oqk6ckICz7fw9En07N4jvyue7MUCiHUa1CyaRn/RqETeM57Ilz9UQyW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576560; c=relaxed/simple;
	bh=Vlgt3P8VCOMPIH4c/LNT2h1SaEi+bqBye7QzC6iGU8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It/X33woMKMkFRbWE/FNLJRRGMQUe2355hYOkWJT5EYubjLk23HNSBl8Wc204EKOYzhZUhiL5byqeoWRMd+IvjpyJpFTmrktcPRL6pVIJuEcxXlGfRE/SoWaFm7p0gx8cej27Gf+PANAxLlDx5bkVh6nuaf3IiNrOcss1fotfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkKQU2Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DFEC4CECD;
	Thu, 19 Dec 2024 02:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734576559;
	bh=Vlgt3P8VCOMPIH4c/LNT2h1SaEi+bqBye7QzC6iGU8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkKQU2OglNN+bDY3leM7glzGETjsrMxcCEbYEHKeArRi4gUbPWc9sSJHzF8q+oaq0
	 FT0Qd93yWRaWfl7B7ayXhVWuQzHcInZ+/PenOivcn+RWybHK96+rj3NfUdretQlC5/
	 9RjHHdWASgJ0z6rikWYIVjC62tTEPCoL2ijOKNyTlkNbSTEOLu8c36+DtTtGmnSoBs
	 ljVx/r46sYfg4NSOWPKHRSpO361Js5w1dt1E1zzz6RFK+DY8O2EBdvNaf5KSo7meu6
	 trCNi2W1+bD4qXKr5CokYc0HsJbjLwo2qKAOBEVj6tM0QXm/FD0Gsw4tGFwZfk5n84
	 5IaJk/gnmL+vw==
Date: Wed, 18 Dec 2024 18:49:17 -0800
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
Subject: Re: [PATCH net-next v6 9/9] netdevsim: add HDS feature
Message-ID: <20241218184917.288f0b29@kernel.org>
In-Reply-To: <20241218144530.2963326-10-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-10-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:30 +0000 Taehee Yoo wrote:
>  drivers/net/netdevsim/ethtool.c   | 15 ++++++++++++++-
>  drivers/net/netdevsim/netdevsim.h |  4 ++++

netdevsim patches must come with a selftest that uses them :)
We support bash, C and Python tests. Look inside
tools/testing/selftests/drivers/net/
These tests could serve as examples: stats.py, hw/ncdevmem.c

TBH it doesn't look like netdevsim _actually_ supports HDS,
as in forwarded packets will not be split with the current
code, or linearized. You'd need to modify nsim_start_xmit()
to either linearize the packet or not based on *peer's* HDS
settings.

