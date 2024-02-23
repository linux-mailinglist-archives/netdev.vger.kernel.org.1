Return-Path: <netdev+bounces-74248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6000C86096E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22E7286034
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81BDDBB;
	Fri, 23 Feb 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHBNjGLG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C004D2E6
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708659202; cv=none; b=cy7j1rl4AU2jGvx2Yh3nBHVwDDrE+FuuPvPR9ZOV4AlF+rCkajeXttFUMfsvMrg42Sa/bkki8I8oN/F/KBeFKXpEK+V4SVk2wZTOdW4Cl3XZvGjtXJshDDuJaKZZzLuDrsqujDGoL4RbFAXIq/JqPlkDrJEZs/wrC4jcVQMTLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708659202; c=relaxed/simple;
	bh=qbd1U2Lie4MQNKWB6NoDPfRvHsZMlbKFyQvA176uBWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTlF8V3U39V6gPjfEeTGgIQIAA26YxVn4ChMNViqapA3tiol7kfLGvLe0zvKEi3EoIyCZJpKKW7tTpar2Nxm5TM1aBqaq7zgp6NcAxuxbyQqavmnNznmVIRVJg0pBok30NAPJo/GrSFl+puHCM957Q+saV8m82ilcfBgJRgP0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHBNjGLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC883C433C7;
	Fri, 23 Feb 2024 03:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708659202;
	bh=qbd1U2Lie4MQNKWB6NoDPfRvHsZMlbKFyQvA176uBWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NHBNjGLGULSEqO197dDwZcVgNv8ioEv86zRdR+FfkDLHuQv3FiND3TYRrhiPbdpoy
	 pBf7G8RvEBmhB4jo+tBXv0hfqos0AzeinhrtvWqfuAPsP+X9fAsBQK0JueRo/eCZCW
	 JTaoz4lkCdt7pY0EawcGiT7cYNt9RM8qGstK0A6lkFXT8ogr0dFY3pTgNy1Lx9I9qH
	 93k12b8zvDiRfvSkj1w2u5GC/yfwqFpLpFK+Wk9iry0XYuCv3RjZBy9CnEzBG+xDLc
	 qUZ05OfJX46JyVSPNe++WBBJhVyg0uSb+Q6JCH1WJkGJ0BroKBIhXpD2EOGYDhkTJK
	 gzPIhUQ86ruAA==
Date: Thu, 22 Feb 2024 19:33:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>,
 syzbot+99d15fcdb0132a1e1a82@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: mpls: error out if inner headers are not
 set
Message-ID: <20240222193320.58e34be1@kernel.org>
In-Reply-To: <20240222140321.14080-1-fw@strlen.de>
References: <CANn89iJZnY_0iM8Ft9cAOA7twCb8iQ4jf5FJP8fubg9_Z0EZkg@mail.gmail.com>
	<20240222140321.14080-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 15:03:10 +0100 Florian Westphal wrote:
> Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")

This is for net-next, right?

