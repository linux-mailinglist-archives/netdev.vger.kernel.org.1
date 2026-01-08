Return-Path: <netdev+bounces-247928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF08D00A6B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC9DD3048697
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE9246766;
	Thu,  8 Jan 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkxeG/E4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6723182D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838714; cv=none; b=gZ8ReEL0f2ekg89CCQy57pNjp9QuCueH+0F7lPy2mVoLdkKlHSMRXpYCDgnRT/1YMEvMtESnd7m53dTpdOL3DsPLVVaj7/0rtFIlxzrX4RPt9m/Rdb79ues2JIpMpK94sHn+1TCHT65g2dbwrrNOofqgn+92wEJYGWyX84/W5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838714; c=relaxed/simple;
	bh=m6nzrMr5C8GMHw1NcJLXXPXSto9QlZnPkCdNACldZUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9HU+EbpjbFYY0cYESm3ofk3SNZ87ZyUswlA4ZKHOnHRJxknVOWaUnZQX4wWbdloVm2IvWSz9nDo9bHrPcobF+2XpiItJkopBhzYW5lA3Z6jE4ZVt3iyGm5zwercDlVLh8cA8iOetpsxcv37Qk3pqGcUGbsYjpPcKX7fxsXquy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkxeG/E4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38431C4CEF1;
	Thu,  8 Jan 2026 02:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767838714;
	bh=m6nzrMr5C8GMHw1NcJLXXPXSto9QlZnPkCdNACldZUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nkxeG/E4NszmSFajVyOIVaAmBcHpSCcEBkEfr6MIFNXg0mdhBBPXR9Qa0wx1SXgBv
	 ihqC+lMJrIt/PtEqhbpiESdPKt1s2g71RLpD8lGrzW9zqGcZDbytIAEfZdNoCf2/q9
	 rm/BmNTUOYNOKbUAs5wNdmiclckiOlhNzSCwpB5ZFbtX7tlveDHSFEEJQy4n6JeCJj
	 FBKxWNFd5HMmcJb8/PgUiIF1APsry1pWWNYQ98bvIqBrfPRQmmYlzd+UwW0wNLHRSi
	 aPSlQ3PgS0M5uYwglriPO1vzngyZwOXcTm5MbiQCUo8ecwKi/MjJgm9eW5okT9zUzG
	 n06M5yCTE4ccg==
Date: Wed, 7 Jan 2026 18:18:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 William Liu <will@willsroot.io>, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch net v6 4/8] net_sched: Implement the right netem
 duplication behavior
Message-ID: <20260107181833.692a9ea1@kernel.org>
In-Reply-To: <aV7tYRnVikZXAC23@pop-os.localdomain>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
	<20251227194135.1111972-5-xiyou.wangcong@gmail.com>
	<20251230092850.43251a09@phoenix.local>
	<aV7tYRnVikZXAC23@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 15:33:53 -0800 Cong Wang wrote:
> > It is worth testing for the case where netem is used as a leaf qdisc.
> > I worry that this could cause the parent qdisc to get accounting wrong.
> > I.e if HTB calls netem and netem queues 2 packets, the qlen in HTB
> > would be incorrect.  
> 
> In patch 6/8, I added "Test PRIO with NETEM duplication", which installs
> netem Qdisc as a child and leaf of root prio qdisc.
> 
> Or am I misunderstanding it?

Does something automatically validates that backlog is 0 when qdisc is
destroyed? The test itself only checks:

  "matchPattern": "Sent \\d+ bytes (\\d+) pkt",

