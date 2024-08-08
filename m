Return-Path: <netdev+bounces-116910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA13994C0E7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F83A2867AC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961F18FDAB;
	Thu,  8 Aug 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTJRrEXe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11F18DF99;
	Thu,  8 Aug 2024 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130479; cv=none; b=gUmUAnP9EmOolcYyn4Xk6rtWNRsQLUJzuXLN2AV5OxOc+xuLd0tovwG/4vFccfGPP5obyLbOd99Fnfvk+Y6d9+tY1pOXE0aU7FTl48FVXwnjN49HV1QS1ODEv40NUu9REB1jyn2esUIwSirICFi5MnsCfihiDbDnj5DkY/JQjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130479; c=relaxed/simple;
	bh=hd4IgJX5oZYn+oeDdDWKM6rrCjGHM4yWKE+GqL04nLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G73BZkXe6IgzkLFvuqj7LVbEBcWb5Hj5CKeM8hvzS5tMIXGM9t//dMul0x7cmjqTrfL+C2hOnRPZQIiQIvnjgIUzbrer1R94iNnXYXZwX3TASEC+kFB5DhwF8f/jZnd2Uot+563VgFbuRsrOsfapYeCcWlhyigk7STtP2w8pid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTJRrEXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE24C4AF0D;
	Thu,  8 Aug 2024 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723130479;
	bh=hd4IgJX5oZYn+oeDdDWKM6rrCjGHM4yWKE+GqL04nLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CTJRrEXeaC8mgCTRUSjFCNRpgiE3nFgDz3Bz9edG2GocCNrQGcUrqVKhAOQgTDUaf
	 6YF19qKQUouBEukfPIbKQhxvchhZtVSSPWS7WKAAuxlnPwaY4f4yHFtu1y5i0ri7LC
	 vjYwrQQpyZ8N0rLhqCB8AHxaD4WTtF2uZEtbNuCqufMBFZ+/gj/TVfCSqhfEWW62UR
	 2vZIcjaa3o0w5TNKzC+gjLrUg3KQ/JIYNkLU9Hd18PoFlzDj5ySbyxTHWFYWTGzfHN
	 BK6aYK4atPvcKLNjTNuhOLYDoxZy3YTH/yohMLpgQWc7g9vUISE3O/HYKODNlosZ42
	 ofz4RUsA/5mTA==
Date: Thu, 8 Aug 2024 08:21:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH] octeontx2-af: Fix CPT AF register offset calculation
Message-ID: <20240808082117.3c0be819@kernel.org>
In-Reply-To: <20240806070239.1541623-1-bbhushan2@marvell.com>
References: <20240806070239.1541623-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Aug 2024 12:32:39 +0530 Bharat Bhushan wrote:
> Some CPT AF registers are per LF and others are global.
> Translation of PF/VF local LF slot number to actual LF slot
> number is required only for accessing perf LF registers.
> CPT AF global registers access does not requires any LF
> slot number.

s/does/do/ s/requires/require/

Does it mean something will not work without this patch?
Or it's just a cleanup of unnecessary code?

> Also there is no reason CPT PF/VF to know actual lf's register
> offset.
-- 
pw-bot: cr

