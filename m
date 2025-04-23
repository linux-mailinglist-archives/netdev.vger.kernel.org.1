Return-Path: <netdev+bounces-184931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A6A97BCE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68023B19AB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B72566CF;
	Wed, 23 Apr 2025 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNVaW+Pd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D902701BB;
	Wed, 23 Apr 2025 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369358; cv=none; b=u2SwMU9ZW49/kurvisfOBJZktdL8Wg/A5FntVJXtfPQzVZ0O6wddIv6Zik+wAkdcZnQiqf1M0MEksEKDPbGkcDdQKgfr83m+8+QnJYhSrcMbm23UNrEUu1vVi6wVS397vQdbbU70n9y+OWGpi+9/YccxrvztIstG2FLUZnL8nL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369358; c=relaxed/simple;
	bh=YPISFp/jKbPQuxE02XZsEPc0QP7WqJn1oGY0PZr5WR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxfPyMFNgpm8oIlpZNIqXDT3uqt9ytl3pLMCi7hO4vJYhvh/IwZU3lSjG/flQBMVHARH2Da80mRg85JxT0vfKiSfvdxpjdjJcUcRo/835GB1srh+9E0pbNc+xR0Gs3pO0paOZ1pEuwXoKAFIWcGq77nhZW5aJmalT9rdqp8a8Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNVaW+Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FAEC4CEE9;
	Wed, 23 Apr 2025 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745369355;
	bh=YPISFp/jKbPQuxE02XZsEPc0QP7WqJn1oGY0PZr5WR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vNVaW+PdmSQpmGC+UPEct4CiRUJRZhVszLCUcOQwLX/ExdnWiKsK1eklLNoUUUZtI
	 yLLH2DD90E3twxY/8UxhpLPUwcMdOlZPcQCQh49zR5Jz64+cx9s3ctAhrgYy0pt3BV
	 T7xJ7Pk6SpW2jeOnl3p0fn4J9ylmo0Y+Ygv+Ou0JvMOxZRsCTyzr4Ywzm8OnTNpANq
	 QPx6xanQqawJCDlixsdHHeM12Nn2Smj5IDO/li1ZxnipHn0RkHBlnPFEV82NdL8ChK
	 BaiL0dmIAjbOuFcDF5lXFtwKD2NZ9DlW019Fcy1Ok7yI5TYOpHk7sxxcTqnhWr+pFI
	 BFb/aWngh97bw==
Date: Tue, 22 Apr 2025 17:49:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>, Daniele Venzano
 <venza@brownhat.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Simon Horman
 <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Sabrina Dubroca
 <sd@queasysnail.net>, Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 2/8] net: octeontx2: Use pure PCI devres API
Message-ID: <20250422174914.43329f7f@kernel.org>
In-Reply-To: <20250416164407.127261-4-phasta@kernel.org>
References: <20250416164407.127261-2-phasta@kernel.org>
	<20250416164407.127261-4-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:44:02 +0200 Philipp Stanner wrote:
>  err_release_regions:
>  	pci_set_drvdata(pdev, NULL);
> -	pci_release_regions(pdev);

This error path should be renamed. Could you also apply your conversion
to drivers/net/ethernet/marvell/octeontx2/af/ ?
-- 
pw-bot: cr

