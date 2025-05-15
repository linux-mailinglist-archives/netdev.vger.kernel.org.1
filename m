Return-Path: <netdev+bounces-190726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913BAB880C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57271BC44A6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B274481C4;
	Thu, 15 May 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbMozRqq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735C4B1E52
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315972; cv=none; b=rCvQjUUgbiVGEH+D7RrCVic/m9NxD2fuwCslduMZpiu+ceVBANvxCb7UQU0BXpwu9Zf1BITiVaMdt8/o7CXFgK5tMOvIUT0Nr8scQ/UxLJNiJXb+BZfV/LmxJw1ADauGuEkbJd7w7qKpEGZ7+jLcHkvJX0vyw8wywxGYxZbFou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315972; c=relaxed/simple;
	bh=JkauNm6pC/gg5o/nhWZUrrZllPbrbY72e5kDS370kro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df2IBYCTmx2H7Xb2CHjBaX3L/UsgJKuTauUYHn2J0ksX3s2Z3NUV8F9ESh1Iw0KwI2Ety4yPsp+8tYhW+6Ms5fT/v1FPN5OCE2L6Zo0aiO/9JNV0z/VIKRCe7ImSEVq0dl3gBhmlV0hBaNSsbSGrjOBv/5lLjhkJRjxbxOdxIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbMozRqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3222C4CEE7;
	Thu, 15 May 2025 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747315972;
	bh=JkauNm6pC/gg5o/nhWZUrrZllPbrbY72e5kDS370kro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DbMozRqqTGvMVhfxcs6cyYTl24flqdGKw2WVmZml7y08qwP95GiI+hnOr65HP1nap
	 D9P2e7K0VDTyuzRTffjSTn5ztIwsaS3udB7VrmpXUhJqDtETY1QCbydnaqSROjRpNe
	 EDRIrHExf1R1YbXWznReyrQMXS2tb08N5GatIsRmYiKYDs3Cnw9gPtFK9zZ006JpXA
	 XpduO+Dn4WIvzN74w/5ZQNuAD4UkoA3Cv1+43S5HW8uintsrfD565LgaB3P/hhECLT
	 aNHPlbHdrtrTJFQQjlY0W+8c4xQ+NyGyA3Ko3LcdmXk1VZDYdFu2uSALOB/MRVOFwz
	 BIx4SBODust5A==
Date: Thu, 15 May 2025 06:32:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: make mdio consumer / device layer a
 separate module
Message-ID: <20250515063251.24eaa37a@kernel.org>
In-Reply-To: <eab0da72-f373-40b1-acb6-3e3e3c3aadf7@gmail.com>
References: <9a284c3d-73d4-402c-86ba-c82aabe9c44e@gmail.com>
	<eab0da72-f373-40b1-acb6-3e3e3c3aadf7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 08:26:33 +0200 Heiner Kallweit wrote:
> >  int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
> >  int phy_ethtool_get_sset_count(struct phy_device *phydev);
> >  int phy_ethtool_get_stats(struct phy_device *phydev,  
> 
> Forgot to export mdio_device_bus_match.

What happened to waiting 24h with the reposts..

