Return-Path: <netdev+bounces-79203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A535B878457
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4414BB20986
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2447F5D;
	Mon, 11 Mar 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvOE3mM5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9D481B1
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172754; cv=none; b=Jt2jGHynBcoyjRRTGeMgUkorFbjDTNGYDshIn7ZqSSf5fIC4Eo/rM4hNJmtqu6vQq0Utdg/DxtDBnSAsRr+WYgkJofBNgUivBbLkZuvhz0gXZTUyV+G/ejqo8q+Tn3LdO2kCw8ZKl3EkF2fU3yoQ/pHYVykDPAJgFqFdMIn+LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172754; c=relaxed/simple;
	bh=tu1iEXLWt88iPfpb+0nKj4qynZQzMoCLJCtIWOwaHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ix5lWA5/X0tRN/KcaOM1O+f1uFAgA48w9gfvi3Z3ywAiHXHrzi1ij3MiMsQJ8bXVx2xciXvFothzcQQ7Bj5sxGEYxEO84FzQYxTk2dLb6Kb0WZPkUe0B3CQ99A5vFVL8nrVGq+2hbLV0HwaCdbgVz5XsI5zcBakdrVkdvzdHdUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvOE3mM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE1DC43394;
	Mon, 11 Mar 2024 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710172753;
	bh=tu1iEXLWt88iPfpb+0nKj4qynZQzMoCLJCtIWOwaHR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvOE3mM5/oKUfnpzlGyeiiVP45rmr2auV0tvrKwdtet4O0++nMY8CG/PJZrQI32qM
	 2gH+zOVmze/y0xV8dnYx5tgpwJxu76UnQtQzf3/b4wYIOwsOHMRO91+4nJ9IE8sFvy
	 yzjLJDY3QDN7juhaz7XWZ5JfJTEuaJhuoeDhglB22yEucGzzmTXPvqikwgkvDpLL0X
	 oET7z9hXFoGWcI06UYQgrQuUNP3gAsSKtz5Tq177z3GkQEn47WfzTbqeiDm2PsHnkh
	 XYQ+bwt5yfVkm5Vnt63LT3AzxzMsl9S9QB7daxClWepeiiRLvlXYqUX5ZyOZMb8WP7
	 MU4xAyBgrPeGA==
Date: Mon, 11 Mar 2024 08:59:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 11/11] selftests: forwarding: Add a test for NH
 group stats
Message-ID: <20240311085912.5a149182@kernel.org>
In-Reply-To: <87bk7lkp5n.fsf@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
	<2a424c54062a5f1efd13b9ec5b2b0e29c6af2574.1709901020.git.petrm@nvidia.com>
	<20240308090333.4d59fc49@kernel.org>
	<87sf10l5fy.fsf@nvidia.com>
	<20240308194853.7619538a@kernel.org>
	<87frwxkp9v.fsf@nvidia.com>
	<87bk7lkp5n.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 12:00:59 +0100 Petr Machata wrote:
> > It should run the SW parts and skip the HW ones.  
> 
> In fact why don't I paste the run I still have in the terminal from last
> week:
> 
> [root@virtme-ng forwarding]# TESTS=" nh_stats_test_v4 nh_stats_test_v6 " ./router_mpath_nh_res.sh
> TEST: NH stats test IPv4                                            [ OK ]
> TEST: HW stats not offloaded on veth topology                       [SKIP]
> TEST: NH stats test IPv6                                            [ OK ]
> TEST: HW stats not offloaded on veth topology                       [SKIP]

SKIP beats PASS so the result for the entire test (according to our
local result parser) will be SKIP. Can we switch to XFAIL?

