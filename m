Return-Path: <netdev+bounces-144100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA0A9C595B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDFB61323
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6315821A;
	Tue, 12 Nov 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdTHs3Lb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F9142633;
	Tue, 12 Nov 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418830; cv=none; b=C5VetoR0F3RrSCAdqTleYZnsszYlYrb6P3iM1PtfAozpjEOCgcTI09r+YOuPriSwlff3Ip99NyRgulhVrAJbutTvBzq1+by+ryzqp23GuCDX7djp9GzTj5HQ/kZk2EKERdZypLQX+91KAN0b0BYC2XmdGfEqsoIURJJdYbhPadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418830; c=relaxed/simple;
	bh=vn5HadZZJqgXEsUauuMsbRcdotaIqBAdXUbV3GKDiMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS4karXbOOsqWtroeBF8RZlBXchqNrCZqK8+mWb/DZHzeJratEMiXuLML1nU2I5tzYYRzUKObbZdb7UPn9y8Pv0XqinPMq4rYBxqFKy1nIo6xWwMfleNK8A9wY+fXYFAssfslbdVqz14TWG/9kljq4ZJqWp6i1QlG5EcBT0XfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdTHs3Lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A8DC4CECD;
	Tue, 12 Nov 2024 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418830;
	bh=vn5HadZZJqgXEsUauuMsbRcdotaIqBAdXUbV3GKDiMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdTHs3LbK0M+Hq+UjYfMeKDW1lua79bw72xAzshy5r3kk6Y2xC0BNQ6P2Ws5WgQ1R
	 ujVTxPuBJX4ILpNbPETb8Q/DaseKW8SoDPwM7ZTbELS9Kdzd8F3z8Bs4r4gDy9vJYv
	 9MD5vb8T5bP60dP/5Xv056Utb1IC3GrNRgxsTmeS5GbRb3xoOgRVD+2EujMeNqBtu0
	 /Ak86KZc4NiPPHiFSP3EMj8yy4L6KVS2gPMukSx5xo3O2XbU11c/Zih3mu/brVTpeO
	 EUxQS6rtf+YMCZUOhuAvwzTPsK2nQQmRTbKgaFeDYfGEhjbfKSS5pKhzOtsw7rdfWj
	 gDpGHq2oVtPvA==
Date: Tue, 12 Nov 2024 13:40:25 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next 2/2] rtase: Fix error code in rtase_init_one()
Message-ID: <20241112134025.GN4507@kernel.org>
References: <20241111025532.291735-1-justinlai0215@realtek.com>
 <20241111025532.291735-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111025532.291735-3-justinlai0215@realtek.com>

On Mon, Nov 11, 2024 at 10:55:32AM +0800, Justin Lai wrote:
> Change the return type of rtase_check_mac_version_valid() to int. Add
> error handling for when rtase_check_mac_version_valid() returns an error.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Hi Justin,

The cited commit appears to be present in net. So I think that this fix
needs to also be targeted at net rather than net-next.

Also, I think this patch is doing too much for a fix.  I think that
changing the return type of rtase_check_mac_version_valid() and updating
the names of the labels should be omitted from a revised version of this
patch for net.

...

-- 
pw-bot: changes-requested

