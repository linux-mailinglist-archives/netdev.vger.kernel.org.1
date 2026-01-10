Return-Path: <netdev+bounces-248731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EBAD0DCBE
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F31E430210DE
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC5298CA3;
	Sat, 10 Jan 2026 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JymwyqmP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FBC223328;
	Sat, 10 Jan 2026 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074788; cv=none; b=X03eQxUn4J7otlUCWVJ8+R1zsbInohBXCPWXNJCt+aFT+Bo3bDmCjjJmOI90GFRcooHgYRSH6ao+Xi5euSEpPgKvrd2OcA/PMa3NW3+nYMGkJ2ZasIenazbNDQN2962tHxZIlZBJ32xTeprrlKnDbs8dTuKjaJlrehLB/zJ99mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074788; c=relaxed/simple;
	bh=1pce/+hL+mT4ikoF0LMeY9bsocfA5If5JoWOMV1Ha+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6HzBTr0LNv3Kd92KAyl4eXuGvCkijciyqCqUu+Hw0OS7+l2NHjRmfuR8cF4DmoDFbm/bVNQb5fXkzfmOUTuWZe0coUxv2HJHlMg4SSPqhB2t5HsNSLCpsP8/zTfyBIak67VT23tElSXIvIymoNpxArenEp3pSVkPmbHD6Go4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JymwyqmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147CFC4CEF1;
	Sat, 10 Jan 2026 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768074787;
	bh=1pce/+hL+mT4ikoF0LMeY9bsocfA5If5JoWOMV1Ha+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JymwyqmPz+GxaedKcYJ6EC3ttFAS5FDePO0zeT7fWqdqt7dV/ssMsrJpEH087slQ/
	 JYSwT7uOPDdBaWSiYF+vShftlrQiLGCj8M9zRKT6J3iAkiFPxB3tpzW+czsKweMrgm
	 KKcaN2sOoMEKok8AJVORKtJNrcu/nEZrXHsP4kVaAOI8WUwBTVtk4FbO0O33aTDav7
	 jqJY/ct3miD0F6lz1AZe4XtWtsrnxyaBzkiu5EZq//MKX75FbA4NefQDUX9StIxl8z
	 wqKm2PAn5HwW3jg4Nla9XU8uX9Wv2DrO8A0YmwxPwevEIhwNp1dpIAWDrE1QIcp7zh
	 dHoaeaPGYwfxg==
Date: Sat, 10 Jan 2026 11:53:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>,
 <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <michal.simek@amd.com>, <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
 <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <bmasney@redhat.com>
Subject: Re: [PATCH 2/2] net: axienet: Fix resource release ordering
Message-ID: <20260110115306.4049b2cb@kernel.org>
In-Reply-To: <20260109071051.4101460-3-suraj.gupta2@amd.com>
References: <20260109071051.4101460-1-suraj.gupta2@amd.com>
	<20260109071051.4101460-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 12:40:51 +0530 Suraj Gupta wrote:
> Device-managed resources are released after manually-managed resources.
> Therefore, once any manually-managed resource is acquired, all further
> resources must be manually-managed too.

only for resources which have dependencies. Please include in the commit
message what exactly is going wrong in this driver. The commit under
Fixes seems to be running ioremap, I don't see how that matters vs
netdev allocation for example..

> Convert all resources before the MDIO bus is created into device-managed
> resources. In all cases but one there are already devm variants available.
-- 
pw-bot: cr

