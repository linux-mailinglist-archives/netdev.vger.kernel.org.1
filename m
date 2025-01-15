Return-Path: <netdev+bounces-158602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3399A12A6E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184941605C8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F91CD21C;
	Wed, 15 Jan 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHYByf7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DE24A7EB;
	Wed, 15 Jan 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736964402; cv=none; b=a1srGbNWrJyXwoyrkDU95rjDaF4em/f91Ixu9xKjJu7FRxUl/6J9LCWKh1TKXv+emA3sq6I37w/0zYqh1Q2xPt9V44mXyflskNUZ/WDTz74rz4k5XETSUHFNkFxkLzHZn7cXoQ1GlDOM2MwhgGJNgtHzy8Hs+kuaNruz3syuk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736964402; c=relaxed/simple;
	bh=xz2kufYW/RZfl0crE9ckOAJCTUVjwl4WlP4eSWByqmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0GKfJMMWoz2eCFECyPQ8RtfuaLZcHnybuOiK13YCWgY/HGN174RFRKquqnDfpN0fn6aCMCEfaG8xBGr8kMZKFFx3caq7b6ZSMBEsuX/URZhY4ElhzKrB71cMp19Rjny2KyGrLAQNnpwx+GJJg8qpuYNtVa+4mNfXvWa7lPMvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHYByf7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC63C4CEE0;
	Wed, 15 Jan 2025 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736964401;
	bh=xz2kufYW/RZfl0crE9ckOAJCTUVjwl4WlP4eSWByqmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHYByf7AjtUDebD9GmWFMI4vV4W4UsFGPKbpdTmjPigFg62wXNJ4C8RelThto/ySc
	 JlCqa7naxwdbOHiWTZWBSrMBaWdfnTfXDflpftzCaCU4uFu9VA3qBkOCS2gzX9bGTV
	 QAO6VNVuU0cIMBMDCfdLAj02Oi7pXsFDKeE0GDc2+IS80ep3gyS9oIMUmBb2aiGUlX
	 xva9rqAxt+pQ0ROUq2RIPmbBBqa+mc3vVv/N/sUM3R1IkFC2cFEx26OpuHml1sM6Hd
	 agUBCQMKm5qB2iFGrJmU65QMH4LHqkDwPCZ5cFLuNn4jmuZm7E1Vb+7mtbyWc/8K7U
	 aKF3AehggPIqg==
Date: Wed, 15 Jan 2025 10:06:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>, Daniel Golle
 <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] net: phy: realtek: fix status when link is down
Message-ID: <20250115100640.57e4132e@kernel.org>
In-Reply-To: <2e76c69d-a260-4067-a054-6a5d6cd18869@gmail.com>
References: <cover.1736951652.git.daniel@makrotopia.org>
	<2e76c69d-a260-4067-a054-6a5d6cd18869@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 18:19:44 +0100 Heiner Kallweit wrote:
> Note that the Realtek PHY driver has just been moved to its own subdirectory.
> So you have to rebase your patch set.

Maybe not just yet. This is for net, and the rename was in net-next.
But as you may be alluding to 6.13 is likely to get released this
weekend, so the distinction will stop being relevant.

Let's keep rebasing on net for now, without anticipating the merge.

nit: subject should have said v2

