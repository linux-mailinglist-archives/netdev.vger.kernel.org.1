Return-Path: <netdev+bounces-186813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A4AA195F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DB0168D34
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456C248883;
	Tue, 29 Apr 2025 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKKcFFl4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C8227E95
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950161; cv=none; b=Ul35LR/NfkiNJl4tuQvTbAtvFXY/TziSJooCfqNmVoKx9RWUlzCnqQQ+YtkuLxi+FyWMMzAfcsXDO09wjg/8iagY1ujg+qsGCQdV1LtibqbIxrfLBV+DhFD/tktL79VbzywCFQea51wnmui8LK1ZBkz4J0303pStI7JxLq1ul3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950161; c=relaxed/simple;
	bh=VIDiz2Br7gkDAUb5ysgJHB91/g5rCAmCNAQRMlGrjCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoYvorPpGvEOJfsDuxiEaFrds73J3RknRbADOyy7ORT27Gghlax7uazA/L6BUExXi7aDOSbXUh13skdi7RKZrPbuapnck0Z7RDJh5GM7F2yrEBIPd+vEpa5BuRAxYAEAyp+JSUNrnzj2HeUFSUap1GRojQUwwiMh1hTDxNdi6XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKKcFFl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F6C4CEE3;
	Tue, 29 Apr 2025 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950160;
	bh=VIDiz2Br7gkDAUb5ysgJHB91/g5rCAmCNAQRMlGrjCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BKKcFFl4y2RqnzgO2Z9jsXzLmoBuCcOtGQOGno0b7kKlAXlvyxNW9w2mFrCYa9+GQ
	 7ph+9krUcQ4yid9ZsAJS5pA3ve6SVLoI3uzNxm1tgroa96L2B4IkwApB6DeFNtFWUv
	 X9TcmDCOjDYRXbtrvOLK5QncOMaau1z4qhb8dXnT76Twn9/oOwbi/ROpPmcU2LZ9Yj
	 aOYuoV0tZ9m2LCeOdo7hid/ahX94RXnLxM5mz3LXgciENNzGheN5Qn357c7tLop+Ic
	 3vnSaALhF+SzjTfmv7XvgDXoqEHYheTD+hsvy7GndzAgRovQG2tkxdUsf99nZZ6oiF
	 d3yxFe4NU3dqg==
Date: Tue, 29 Apr 2025 11:09:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: netdev@vger.kernel.org, allison.henderson@oracle.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2] net: rds: Replace strncpy with strscpy in connection
 setup
Message-ID: <20250429110919.37ceacce@kernel.org>
In-Reply-To: <20250426192113.47012-1-shankari.ak0208@gmail.com>
References: <20250424183634.02c51156@kernel.org>
	<20250426192113.47012-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Apr 2025 00:51:13 +0530 Shankari Anand wrote:
> From: Shankari02 <shankari.ak0208@gmail.com>

Not your full name, the last From: in the email is what matters.
Maybe try to correct the author of the commit in your git tree.

> This patch replaces strncpy() with strscpy(), which is the preferred, safer
> alternative for bounded string copying in the Linux kernel. strscpy() guarantees
> null-termination as long as the destination buffer is non-zero in size and provides
> a return value to detect truncation.

Please wrap the commit message at 72 chars.

> Padding of the 'transport' field is not necessary because it is treated purely
> as a null-terminated string and is not used for binary comparisons or direct
> memory operations that would rely on padding. Therefore, switching to strscpy()
> is safe and appropriate here.

It's treated as purely null-terminated string? Where exactly
in the code do you see that? Because all I see is a memcpy..

