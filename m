Return-Path: <netdev+bounces-154486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233959FE196
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 02:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D2A1615BC
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277F1096F;
	Mon, 30 Dec 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9FT1Sjv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413E173;
	Mon, 30 Dec 2024 01:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735522302; cv=none; b=ZJuvuDS/eLIfwk7shRkbVOVwDkDCAuCyuVK51R5pUcmUoYw1h8RFfOfSg2wQg6A5/4yAiUI+k3HHtSG6tNq7AICVBbW3cLmoZkgylDvtkYbS/RO52jB81U7j0rdeFARFoKcsZUvCw3d+qBkYm8Vl+y3AOYvq0ZMmTLHljdNdwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735522302; c=relaxed/simple;
	bh=22WWUXvlZXsozJBKWk56EsJUhsunee4MbR4P6XeDaKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzwJmEYNmhBGnUFWwuzCJb/ghw+hknH9oDiUuWFIMjQxuO92LCEgYes/5vi25LdKD3ClSrS3xbnGIqP9VCj2YE83Jt2LdM+1p3/Ud3Tv+Fcn8TBdOrfMbjNp2z9ejs457v107WqRiLFzckz8er2HSrGJHCC8jzHLRbRdTlgXN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9FT1Sjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B9AC4CED1;
	Mon, 30 Dec 2024 01:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735522301;
	bh=22WWUXvlZXsozJBKWk56EsJUhsunee4MbR4P6XeDaKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9FT1SjvJPBg1Y5/H8cfYMikV0tyc/X7pW9ctWkitIOSQaJ7dk4OdLle+ypPQJr8t
	 z29hE39c2IZRSAtIKKnRXA1Ny3KyrwS89Witdc6I3cfuEwUhg396bJ2AJiWWEfEjMN
	 hFaxITlQWUmqcAN25Dm/Ikn5dWLd2kBfWQozs0JeCIbOzWImhLQo4EtS7uIBrksVPh
	 keG1nuYUY/2RG13DoM7oz7rtGLc7VFoLaGxnZB0tpwXeCxP/r/8NPquqPbal2jIbtk
	 5ZeENOoo5uTGHWsK89nSHd85X2MLtcNe0HTKPwAIr0eHjS7Jx9a96OdVxWvAGsSAMN
	 ejSXaJeWTs9KQ==
Date: Sun, 29 Dec 2024 17:31:38 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/29] crypto: scatterlist handling improvements
Message-ID: <20241230013138.GA76656@quark.localdomain>
References: <20241230001418.74739-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230001418.74739-1-ebiggers@kernel.org>

On Sun, Dec 29, 2024 at 04:13:49PM -0800, Eric Biggers wrote:
> 
> base-commit: 7b6092ee7a4ce2d03dc65b87537889e8e1e0ab95
> prerequisite-patch-id: a0414cca60a72ee1056cce0a74175103b19e0e77

This patchset is also available at:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crypto-scatterlist-v2

