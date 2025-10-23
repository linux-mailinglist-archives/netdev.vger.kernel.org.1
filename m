Return-Path: <netdev+bounces-231928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91176BFEC0F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34E564E06CE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8686619F13F;
	Thu, 23 Oct 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFVinwf/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584E91FC3
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179925; cv=none; b=YYD2QwhOe1B5LiqqjIQ5OHdMpTDATZE85eBUmIS2eHrRYs/RuiHdcLgK0BA8gI0rjuK2jwjanDw+RwP8Qohm7DXSo3Z50wCvTda01eFtyM3whO8pP9HkhhNBF8UbiO3ZJ/pgwzUoD+cPMEzDRqklSNBZcGCo4xfjFJgdl+197i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179925; c=relaxed/simple;
	bh=vs3DFWcftFIdnPqEkvqeznsOt4cXsZth+n3V8wPumpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+a+lIQqGRZI5TEt6zQ0xfX+Cq4DkiMAJiZruiHNxUen2UuyowK3gGF7su8rhzneD+T6J2afaei1ZWsZn19ncMA0WBJFJYqpBvKvGpSsA5tbOeLzHgjD4oDEWCsSB0ErNloS6oPZpFdBKRvxt8JX9VPay1KLRVNSDT4eErTDojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFVinwf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAE1C4CEE7;
	Thu, 23 Oct 2025 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761179924;
	bh=vs3DFWcftFIdnPqEkvqeznsOt4cXsZth+n3V8wPumpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GFVinwf/vT9VBexa/jmvySEA3C793Cwd9sFuXkh+x4JAkl+uQhX4XCKmr7uzR5QYr
	 +UjzLgOtHDZOKX+j0bP8b7Xesn90lfUW+lLdBlNCmQjHOIXxRtdWabCLuq246L/bYi
	 8xGxjlFRmhC/XVWpRdfQTiK5UVFsGc+ZO5aMlGjNg1hJMgXVwZkjn/0e/XGXmjSfMd
	 KI1S3Kc86GYlCPRTz1ins1Pwk7cCc/EoeNcJr8yM+BTk1wdmuLuGG3RT40gh23aO0H
	 WLj1XEGw6W+TZLlh594d/yimeQ1quoFg1YDslxIAqJcytHvmlr/5r5kQOs1BXriUBt
	 pMEZHJC4C+/yQ==
Date: Wed, 22 Oct 2025 17:38:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 petrm@nvidia.com, willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Message-ID: <20251022173843.3df955a4@kernel.org>
In-Reply-To: <aPj5u_jSFPc5xOfg@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
	<20251022062635.007f508b@kernel.org>
	<aPjjFeSFT0hlItHf@shredder>
	<20251022081004.72b6d3cc@kernel.org>
	<aPj5u_jSFPc5xOfg@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 18:35:23 +0300 Ido Schimmel wrote:
> I will change the test to require at least version 2.1.5. Can you please
> update traceroute in the CI and see if it helps?

Will do but I'm a little behind on everything, so it may be tomorrow 
or even Friday. So ignore NIPA for now, worse case we'll follow up.

