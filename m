Return-Path: <netdev+bounces-238360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D27DCC57B78
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3154C358497
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F2158DA3;
	Thu, 13 Nov 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="ZokX+vlm"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1912D1F1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040924; cv=none; b=c9eegaOxNcbErd2exoqvB143uQrAzKdm+HpmrswoDIORv5NjzLHJa95Wik2YZzEDWjmGvQL0jSsFTvY/ERqT31FCPt8j6wmeAETFI6nIvXmI3GY6fqgMvCVnlgHNZPYhHPuRfmWMB7zHO54ADQzIOr2mMhkpu3fn0KgiQU8kUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040924; c=relaxed/simple;
	bh=NSDVt8ey4YOlXB+TltCdAR2Hn3qO32j7/zgQJOzbgh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYdWllJbDDPti2KNeH2qoTJ9tIPJoczHiHfYht/qca3M8OR14FZOCYrfExfHnejf+/OxofKia1BeEGPUlW4mIiGDHUw5Y8MGbyVSB8l8KhIZv3isRKEoxfHr8Y7DnPfpkCzLHZQ7uDQ/kc8AN3SPg4KoGc+0pwB/wZzdDuwmGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=ZokX+vlm; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1763040919; bh=NSDVt8ey4YOlXB+TltCdAR2Hn3qO32j7/zgQJOzbgh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZokX+vlma2ls8Mn7QPgSEj1egnAkEzfPP0Pc57uOu+PP0Ol4zTMLUSQSqZNeJVegl
	 inIvOcCkNnd7Lhht5VM9d2b3ujKb1oVHUPRYRipj4TfYpG7g4Xbu71u/TfP9PBZ1gW
	 YoNVSrigH4ljX3VB5vAWCdaLl0Jl44tNwmynyJghiu8f1ZUvO/K2mvRj/ma0WWAxAe
	 jMr6L5X7MGGxDhxd8ofgNflugeODYK8MlPtvthV0M12i1lVPkcZMVIIonblpQNFSCH
	 YBr8xM/ULAZtW0Tg9byAXa+zY7hi9xXheA9Eq01tB4AEvmNqFAoUuemQHMzMfB9uUv
	 ZHpkG/FXOgwng==
To: Xiang Mei <xmei5@asu.edu>, security@kernel.org
Cc: netdev@vger.kernel.org, cake@lists.bufferbloat.net, bestswngs@gmail.com
Subject: Re: [PATCH net v3] net/sched: sch_cake: Fix incorrect qlen
 reduction in cake_drop
In-Reply-To: <aRVZJmTAWyrnXpCJ@p1>
References: <20251113035303.51165-1-xmei5@asu.edu> <aRVZJmTAWyrnXpCJ@p1>
Date: Thu, 13 Nov 2025 14:35:18 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87346ijbs9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiang Mei <xmei5@asu.edu> writes:

> There is still one problem I am not very sure since I am not very 
> experienced with cake and gso. It's about the gso branch [1]. The slen 
> is the lenth added to the cake sch and that branch uses 
> `qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);` to inform the 
> parent sched. However, when we drop the packet, it could be probmatic 
> since we should reduce slen instead of len. Is this a potential
> problem?

Hmm, no I think it's fine? The qdisc_tree_reduce_backlog(sch, 1-numsegs,
len-slen) *increases* the backlog with the difference between the
original length and the number of new segments. And then we *decrease*
the backlog with the number of bytes we dropped.

The compensation we're doing is for the backlog update of the parent,
which is still using the original packet length regardless of any
splitting, so that doesn't change the compensation value.

-Toke

