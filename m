Return-Path: <netdev+bounces-177322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18665A6F084
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA16188CA10
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2721EBA1C;
	Tue, 25 Mar 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJdhCv2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3166E16A395;
	Tue, 25 Mar 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901317; cv=none; b=HKUwr37fdJmHdTyLW/Dr1QW1QbNssR52wJzMHl4vtIBB2ZjAU9MOyYWGQ9cwr6AG+atIXVXOi8lpijfWTpHBWwk4LblR1VBY36H2z/z/seIyXT3SzdIhms3AsZeguQJkBdKiJhNfldP0gr2utgzYkXkmXlnDgkQeaq+S/Tbu0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901317; c=relaxed/simple;
	bh=uwGfJRKErRIwZ5CVP2cWpoqygQMndr3jzVcHrLK7bsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T86hO0e41uOSuXoraXgmgZIfoScdJ42aVsDYrcVLDzYcQbD8U4h3liWnc90hA3fpMrMsVWJ7zUvvJz6LyWZWgEs4ubI57v+a9/WTNXehtnasfdVoyeOoBJKbRGB5/v5S/9aKQVNhSsL7ixsgIZ10J7MzWeaeKQyv70HbhC2n4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJdhCv2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186FCC4CEE4;
	Tue, 25 Mar 2025 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742901316;
	bh=uwGfJRKErRIwZ5CVP2cWpoqygQMndr3jzVcHrLK7bsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJdhCv2+iSYOmGjSYnYes2o+sxg7XWg2TOrEPEBxAQQU7v/LXaL1PkK4YAfxgVBpc
	 MBcd66CJh11zdT/R+6ZHEkGFjSbI6gb14feXnmyTc7STR1W7tZE+95x64M47Ux7jPT
	 oAl0f3sn9rAVwyeoG2RBcsx7eoRQPtwYCYwVNkkTx3+LQEUZg9f/oWMI/+Ucwq/3FO
	 VplvucV/6ltf0zpugqI1K7B+tVCbXYVJcsEMayQHiTcjdSxgFTzG4ssZixzEWWTWsL
	 j0D97/14fQ3sdjTKe+r9+6L4VMkhHA2ej+dPSAAR8/bvLGwqFnnGzuZpv4/NxIfEtS
	 FoAIurzDQewjQ==
Date: Tue, 25 Mar 2025 04:15:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kirill Tkhai <tkhai@ya.ru>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH NET-PREV 00/51] Kill rtnl_lock using fine-grained
 nd_lock
Message-ID: <20250325041510.590d938e@kernel.org>
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 17:37:41 +0300 Kirill Tkhai wrote:
> I mostly write this mostly a few years ago, more or less recently
> I rebased the patches on kernel around 6.11 (there should not
> be many conflicts on that version). Currenly I have no plans
> to complete this.
> 
> If anyone wants to continue, this person can take this patchset
> and done the work.

Was there a pain point you were trying to address, or was rtnl_lock
just an interesting challenge? Paolo mentioned trying to convert veth
to instance locking, I guess he may need to reach for similar solutions.

