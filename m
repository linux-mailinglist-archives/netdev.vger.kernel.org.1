Return-Path: <netdev+bounces-88831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28558A8A26
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046CC1C23200
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0A17166F;
	Wed, 17 Apr 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcsUewrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4013C8E9
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374795; cv=none; b=HeRuoUNlbA5s7mHIFbLTecTa3wRDi/gqW+d7PeiE4CQPuRqYZI3ZvhoZ0W80IRV6qzI+VTNTqj5ihCZe71XIXrEt2GcMibB5pXkcztZzx7PmVI+8oZLF8+lpNsbp+OkCaH4mKcOBmyGBzb/uDuMVMOL9gXYAW/fLux6mvU2dqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374795; c=relaxed/simple;
	bh=42b1rDO/eczrn3WhmiSd1kAEFv5V3xRYKy51xvbdHAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wisu8fr/zAvW8hPmDw3NzkIktuqPpfOfXFt/Ze0TvpAAVgqu84VxmK7r2PAvcHTiuHIv9KsHjgNjWzyLHTT0IWtk8afG2eht4FbZByrIgtkIWflddc+jN5i3Nff63rWIvgR+iKEWidXM3lYQiJ5yWxfhoKp8mNDrZ2jwo03WhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcsUewrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E8C072AA;
	Wed, 17 Apr 2024 17:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713374795;
	bh=42b1rDO/eczrn3WhmiSd1kAEFv5V3xRYKy51xvbdHAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EcsUewrv7PpT41/kwi4GvyKEW4M1+TCI3XOy/LKOWhDsxRvjQZbHzx1ZZj5HqTgR2
	 MPlcDyTjJRzZzUcDYeTTQyhsioKxuXlKdlIGy++kiTVMXj+vGCrkyhBeyEE0Nwbbk4
	 nCpNEFd4YLnahsCJKVJHUOnU+GfHoBwOaNWk5PL4cj5+MA/BPf8Lov9M3eMK+GVFKN
	 xd4WxKOB51/8AQRfLb4oNvg47NpHNqBetrLv+2bfyA0YmHIcYI4XudT0Kc/f+4oP1P
	 Pmylj92N1Ggjh7ciz6LQIVhjc+HegMckhV5X0+ItE/Ik+b70G89Yl4Bj8It1D9aMDD
	 R4UUYJo48XU5A==
Date: Wed, 17 Apr 2024 18:26:31 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 12/14] net_sched: sch_hhf: implement lockless
 hhf_dump()
Message-ID: <20240417172631.GJ2320920@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-13-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415132054.3822230-13-edumazet@google.com>

On Mon, Apr 15, 2024 at 01:20:52PM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, hhf_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in hhf_change().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


