Return-Path: <netdev+bounces-238724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC47C5E972
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 18:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3A3844B6
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF932E75C;
	Fri, 14 Nov 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4BLOo8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F728541A
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137216; cv=none; b=GP/wD3MZPTmsZemE/lOl0BL5HOzpyd46+3Fd7udBTFpGfxOGZuYTyf5KOzyqWdEx7x3quf56wzYOyihnyZDiN0Y/PKtoNzghuyzSc9bjk7a+0JNKkKdUV6yBOri2dMS1h+K8Q9C2kHFM9p9YLQROheNakkzU+kQIJYlNmmnAbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137216; c=relaxed/simple;
	bh=eeknFlu9uT6m751Oqqd09j1wEYY1O7NYz8dorQmzB2w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=belMt7fQ7QBbtwAbrZ7mU6gYXc9g9btu8RAKHvrWWb9XB3FO4yyuoi/wUmeghAFb9VUKeAH4H1/PUDbmoPWWzGxATcGs1mPjIp7QmzzmWV8GWYfWLanjiHh3egaDXd1zotBAsNcWQ7UczMmokswu2tklyJYUe7v8igz1z8xlwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4BLOo8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C56C4CEFB;
	Fri, 14 Nov 2025 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137215;
	bh=eeknFlu9uT6m751Oqqd09j1wEYY1O7NYz8dorQmzB2w=;
	h=Date:From:To:Cc:Subject:From;
	b=U4BLOo8mq4yodnrJqVfuw5Jodke/5f+tFEJAmvGhl8J9JQJTb0sU9YI4efjOp+BjI
	 0gkDyp8M+ktADvYLYhGwclOS8R0X7VLnr9Il1I8nS6aIy00tOcDSUEfmnYZF3tq57b
	 ZeO1VRU396lFYMI1orWTvMC2Rww2lp3NjLXNy7EQqTb2ZUNK/BUZbCxGqolN4Ymsxk
	 s9VJiZy5shdN38PaHAlDW+R9D74gpcyGNTymEmPoqfpCCFNZfygJ16Jlxi+kcZVh6S
	 EprQ+zLHjUnwOY9u7SxWkzp6bZSulqLFLittRylrbE9m4RQiCJS0gsdvSjYKQVbKoE
	 a4djMsYquldvg==
Date: Fri, 14 Nov 2025 08:20:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <20251114082014.750edfad@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Hangbin!

The flakiness of bond_macvlan_ipvlan.sh has increased quite a lot
recently. Not sure if there's any correlation with kernel changes,
I didn't spot anything in bonding itself. Here's the history of runs:

https://netdev.bots.linux.dev/contest.html?executor=vmksft-bonding&test=bond-macvlan-ipvlan-sh

It looks like it's gotten much worse starting around the 9th?

Only the non-debug kernel build is flaking, debug builds are completely
clear:

https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=bond-macvlan-ipvlan-sh

A few things that stood out to me, all the failures are like this:

# TEST: balance-$lb/$$$vlan_bridge: IPv4: client->$$$vlan_2   [FAIL]

Always IPv4 ping to the second interface, always fails neighbor
resolution:

# 192.0.2.12 dev eth0 FAILED 

If it's ipvlan that fails rather than macvlan there is a bunch of
otherhost drops:

# 17: ipvlan0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
#     link/ether 00:0a:0b:0c:0d:01 brd ff:ff:ff:ff:ff:ff link-netns s-8BLcCn
#     RX:  bytes packets errors dropped  missed   mcast           
#            702      10      0       0       0       3 
#     RX errors:  length    crc   frame    fifo overrun otherhost
#                      0      0       0       0       0         4

FWIW here's the contents of the branches if you want to look thru:
https://netdev.bots.linux.dev/static/nipa/branch_deltas/net-next-2025-11-09--12-00.html
but 9th was the weekend, and the failure just got more frequent,
we've been trying to track this down for a while..

