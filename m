Return-Path: <netdev+bounces-152655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C05049F5106
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138381643CD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2071459FD;
	Tue, 17 Dec 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz1flhZ4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDE211C;
	Tue, 17 Dec 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453027; cv=none; b=iCAZLp2FVKk5zArrIoj6ON/LCqNqaOjlvG+1YbV8+edYVypbR2cOiKwDBqHUC8dZ8ZIi+ZWgzWyFkEDIjdcjSZ1pj1bYR6LuPaMLrU6apEU1ziHtC9X09GV8iyvzDmxD7Mkx62LHYz5I9ShTbXmCpUsp45Q4g54e+5ZG6+qBu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453027; c=relaxed/simple;
	bh=vd1jPB2m2SSZKX/64wtCnC0SCvhkIZ6+Iqpq4FcqM0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fA/2XTDwdxU8fjPOnE1RwId5JfiNRqoz4qqZoL8xPuiPPArUthP+WMRv+Nl/gutt6eO1X6EQ4OfDU3pDHtty7Z3E3kweMMoQ1h/zVK22B7xiv8jUxNrebizQ8dj+Tef6B5vkhXq39EXUuNY225StX470dNUyl4Q/n5DW48ZgAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz1flhZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA695C4CED3;
	Tue, 17 Dec 2024 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734453027;
	bh=vd1jPB2m2SSZKX/64wtCnC0SCvhkIZ6+Iqpq4FcqM0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rz1flhZ4QUeUrr9ECpsXfwmUjB65hOzcJWf1ddox87W7rfz4vriwFTJranxmHpjrE
	 yQf1tbPG8kS0fvvbFnBwzu2jqyqf/09ahdwr0opqAPxTmL7DZPrxiuS9c1Hl/JNcnU
	 IURbj6p906+3dJeqnxaJc5ltK8T2DC+mpEO4FaaP4YN2hChFUV4lhvXEnjPmslQcQy
	 QOt6RquyKtKDGy6uASPTs1mf36pgat+0SFgeaoz6iWeoo/bj/9zNZjZnHsJuW+UJBZ
	 jl5TPqoOPfKJ8npUO6OFFPZPnkus3QdW5S0xXLDU9GvI54M1QpbTtNe27683jmF0VB
	 lkPDgqNfVbh7g==
Date: Tue, 17 Dec 2024 08:30:24 -0800
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
Subject: Re: [PATCH net-next v5 0/7] bnxt_en: implement tcp-data-split and
 thresh option
Message-ID: <20241217083024.6b743b74@kernel.org>
In-Reply-To: <20241113173222.372128-1-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 17:32:14 +0000 Taehee Yoo wrote:
> This series implements header-data-split-thresh ethtool command.
> This series also implements backend of tcp-data-split and
> header-data-split-thresh ethtool command for bnxt_en driver.
> These ethtool commands are mandatory options for device memory TCP.

Hi Taehee! Any progress on this series?
Being able to increase HDS threshold is highly beneficial for workloads
sending small RPCs, it'd be great if the changes were part of v6.14.

