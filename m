Return-Path: <netdev+bounces-161950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11827A24C56
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0AE3A4328
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 00:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2B524F;
	Sun,  2 Feb 2025 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyovEjSq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAB79CD
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738457820; cv=none; b=sQjUYqJei7hx1YugLY8nrMksEvhJhPzVoDHYh5Gri8MYWdA0JGCvUaPjEkWbSwaPvff8PftihDgtC4BHP8B0jUYr4MI9O9B6v2xV5hoEVb+LGs+eCKyrxLDYFHrCL6J4CohuDKaDp1QLb5TsSLoX/ED92mAfi37VHV0MalCw7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738457820; c=relaxed/simple;
	bh=r7nPU1Uj4cOh/Nu+51Mjrf3zou26XUwVr4yCNxWUQZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+RPCQciuukDP0tiE8C6LgJqr+uDF9/lL+SaT7rJlmozdmZYJ8OIwHHYtgsLH2LBDvcX3i2l73Cf9JaxQ1K+EwgeFrF1K8CBEkHkYF0fn+IQrBFuqh7Ao08gT14wOk27Zq6prG1MXjVPF2b6qmUOtyaLxY6gEW+4bkEEO7Ml+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyovEjSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20B0C4CED3;
	Sun,  2 Feb 2025 00:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738457820;
	bh=r7nPU1Uj4cOh/Nu+51Mjrf3zou26XUwVr4yCNxWUQZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FyovEjSqebHJtTBERWsyz1RBYETTH2CTTBJaQ/UYPZtrkVEuXfMI0qT0U9Fz/YwhG
	 xE+OobaW9dpJLUopirLusOXk93hvLf+xgvsDeu3H4k6E4SB1lMeUs5jRqlZ+S7r69M
	 i8RRLrC/tmXBO6bf65VKp0ZEZp6iLv9BSyp2oThBq3Om9CwP68F9aPvWKc766qfepp
	 mpVM40S+LOPF8IFt0s/3cSIr8qCXAGt8D9MdMu2CAFohfXSdxBofUDoOM0uDUouluv
	 CIjURF+C/sWvDxLu22E7Bg7oxj/WjXBsHFkc3pKcwNTrnW4CHjCFDtn9DIyOT1ccs8
	 CA38h752GhJHA==
Date: Sat, 1 Feb 2025 16:56:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net v2 2/2] net: ipv6: fix dst ref loops in rpl, seg6
 and ioam6 lwtunnels
Message-ID: <20250201165658.707c5d9d@kernel.org>
In-Reply-To: <4b8d9c6e-cbe6-4c75-b709-c732db0cf331@uliege.be>
References: <20250130031519.2716843-1-kuba@kernel.org>
	<20250130031519.2716843-2-kuba@kernel.org>
	<21027e9a-60f1-4d4b-a09d-9d74f6a692e5@redhat.com>
	<cc9dd246-e8f8-4d10-9ca1-c7fed44ecde6@uliege.be>
	<20250130065518.5872bbfa@kernel.org>
	<59f99151-b1ca-456f-9e87-85dcac5db797@uliege.be>
	<20250130085341.3132a9c0@kernel.org>
	<4b8d9c6e-cbe6-4c75-b709-c732db0cf331@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 14:52:05 +0100 Justin Iurman wrote:
> >> ioam6.sh already triggers the looped cases in both inline and encap
> >> tests. Not sure about seg6 though, and there is no selftest for rpl.  
> > 
> > Right! To be clear I meant just for seg6 and rpl. The ioam6 test
> > is clearly paying off, thanks for putting in the work there! :)  
> 
> Got it. Of course, I'll see what I can do. And glad the ioam6 selftest 
> helped :-) Not sure what the current SRv6 selftests are doing though, 
> but it looks like the "looped cases" were not caught. Probably because 
> the first segment makes it so that the new dst_entry is not the same as 
> the origin (I'll have to double check). I could just add a test with a 
> route matching on a subnet, so that the next segment matches too (i.e., 
> old dst == new dst). Overall, both seg6 and rpl selftests to detect the 
> looped cases would look like "dummy" tests, i.e., useless without 
> kmemleak. Does it sound OK?

Yes, tests written purely for code coverage are perfectly acceptable.
Let alone when they cover paths which where buggy in the past.

FWIW my series was applied now, in case you were waiting.

