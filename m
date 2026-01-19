Return-Path: <netdev+bounces-251233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF311D3B5DF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E28D304356D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDF6363C45;
	Mon, 19 Jan 2026 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUWp9gn+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED73B7A8
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847572; cv=none; b=brJL31Anw2IhPlRX/hViEuuLvIYwFDQj24NFdzHG/XxE6DDS1BSUgJZG0SeziLNOyCR7qkRqfbEwKdBC9Ox1JM8f/2/klDT82hZzTCXhEo6xs7eldEOmy8nySNa1FRzFWchWdyJYfgvAOJ2vb1aW2pMIwagTFxGYCNBnC7llUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847572; c=relaxed/simple;
	bh=7833sjxn/KlgrWPZu7MOKDyyu4ukGTL66pta31Q4GFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvJLlrir35FfeuS8daQBGJHIxSIDZjthtmURZ4R+B/pzVX9kTIhkxV8Xw+D5zgfX9KZcNCMyOu4vC3TM+aTsi60SdeEp54lHJx4gR0ACSuI5iV/nN3puqGCbcWnwJrM4PWI9fPrjw5jtQZdPtQu7/kcwnoDO7on8+N2LfNsboqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUWp9gn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D961C116C6;
	Mon, 19 Jan 2026 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768847572;
	bh=7833sjxn/KlgrWPZu7MOKDyyu4ukGTL66pta31Q4GFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUWp9gn+Tguf/aMxdAIuQ/KQs1SsibYnvAJgLlsHaIym6L9KHlD9WdoJZJd9vNiof
	 Qq0A7ZEFzrPA8TI0pM2t2ScF0Ry6cyfNp21smdyF54riNFN39unRgeh3/2j+5dopwp
	 Eo+ROjouV3sf0WwKJMbE3utaeXRkfrnLxz77l8mDsMBqfG+ZN21re2HylRtKV4gNjh
	 WuSHFvX8kNGhDTZ2rJvdJf+Cy5LFSrJU7TQDcYr+58LXRRUrO3cxyoIpAL3UWuLfo2
	 SxyayuJeTsv3tXIy2iJBJ+J4TDzbFZ3X6D8/rrEdy9AGJzvAFKhehJdiOrSYTIYyiC
	 WjcnzkDHsB02w==
Date: Mon, 19 Jan 2026 10:32:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v1 0/3] act_gate fixes and gate selftest update
Message-ID: <20260119103251.41eb61aa@kernel.org>
In-Reply-To: <20260116112522.159480-1-p@1g4.org>
References: <20260116112522.159480-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 11:25:50 +0000 Paul Moses wrote:
> This series fixes act_gate schedule update races by switching to an RCU
> prepare-then-swap update pattern and ensures netlink dump structs are
> zeroed to avoid leaking padding to userspace. It also updates the
> tc-testing gate replace test to include the mandatory schedule entries
> so the test suite reflects the action's strict semantics.

Please repost and CC appropriate maintainers and authors.
./scripts/get_maintainer.pl $patch
-- 
pw-bot: cr

