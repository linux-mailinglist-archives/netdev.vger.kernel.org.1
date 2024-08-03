Return-Path: <netdev+bounces-115453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B8994666C
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AE6282416
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A01C3E;
	Sat,  3 Aug 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLV1Tj66"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860081C01
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644132; cv=none; b=B9kX26ES40QpRiw4xOud2xKgXoI1dDeCjQkt4RlxleGz2q2fooThXCkIW/IQvfHMbBz4yPuMBTDPxkEzJ4taAKZYHLwqpDtMJWiW6S8kEOwJeqB7au9dC1BJOsk/A1OJgzPFWDE6VoQaWjapHsEBijnwgmvoA2BMsOVGA+77XGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644132; c=relaxed/simple;
	bh=gG0kYEOkqf3NFcNMc8PPYRiN52hhx9kRpZoL7WZAFaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXa40MM+iB2WS5dh+CMil5K826tXGST8241NiJBhyqngHHtMfh5HzzSK7SpfWHyb0sGyvG/cSWrW8xFtmyAgk3gH6nzPOonEKKhQFMAyQP4z3fIj0NiVKPJUAWN8PT+DV3K/JbdKGyOLXXXHjMf/OuJRthLivyWSD31uz3sFqPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLV1Tj66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F21C32782;
	Sat,  3 Aug 2024 00:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722644132;
	bh=gG0kYEOkqf3NFcNMc8PPYRiN52hhx9kRpZoL7WZAFaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HLV1Tj664zPVBdG6U84T5ItbCGmfRXrwa2OsYc0bRKClb/ixS2CpmJvAeOY0xp/xr
	 mPdz09XZeM+OZJ/YsNniWDd6/9qNGHSaWq8R5ndo4UvTUaxf39J1+0YVlkNvC8Rxm6
	 bE9BGsGgme7uxdkD5uipRqGKLt5jZiGaAWfX/qubJEYZ8bCQRuBE0G3XoUO7nVzo1X
	 6PLI5lodO1sAAT+r1PKWaBM0YT4f2pEnrivB7MkHBuL3Leug5DRZGTDpJJw5VyNY5O
	 tLFzI0bH6ZQh2ZIXyY+5hsvFrS4GQkrqJPa7BQ5Yh3p4NE9jLBWf9kfbTGB7dFJBOJ
	 BOr58mXDUVx9Q==
Date: Fri, 2 Aug 2024 17:15:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com
Subject: Re: [PATCH net-next 7/7] ibmvnic: Perform tx CSO during send scrq
 direct
Message-ID: <20240802171531.101037f6@kernel.org>
In-Reply-To: <20240801212340.132607-8-nnac123@linux.ibm.com>
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
	<20240801212340.132607-8-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 16:23:40 -0500 Nick Child wrote:
> This extra
> precaution (requesting header info when the backing device may not use
> it) comes at the cost of performance (using direct vs indirect hcalls
> has a 30% delta in small packet RR transaction rate). 

What's "small" in this case? Non-GSO, or also less than MTU?

