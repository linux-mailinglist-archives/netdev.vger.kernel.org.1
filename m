Return-Path: <netdev+bounces-155052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED27A00D61
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCD51606C5
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585601FA8F0;
	Fri,  3 Jan 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8mr+8TQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8A1E535;
	Fri,  3 Jan 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927659; cv=none; b=qdZxddUmcBFp9Vc5nlA1GFL91E3td1Q62bWaPAYYlC7iVWLAynrR8wDbWGLNX6yr2RLj1LJD6YIxaHg1XFtmOdAJZgiRVpJk17p1WxTHjaerM8LX7pqzYt6jLuXBVa9y4JNN9QvDALzsVf7IEeZ7lpc131i4YyU2EeaxnRe7P2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927659; c=relaxed/simple;
	bh=VclUfTsbh5IoXG6Lu4dBSyCzArpH6mdIekP3I2X+5BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4VMg5fBiCx6raAprS1/cYQKtJjM5AjkdckNBhoYWq1/RDQ/2qDdZFarDHCDdpplhL+EWiZd81Zvk834gjqRLbXT5FcHeGENfRL7kdh6p1JFGFKUPFGBUr8+IVkZ5rRRBNfPV5Gm9oaqpXoA9JcfcaNKCdzS2jOVAW1KoyFuXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8mr+8TQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D770C4CECE;
	Fri,  3 Jan 2025 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735927658;
	bh=VclUfTsbh5IoXG6Lu4dBSyCzArpH6mdIekP3I2X+5BA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D8mr+8TQ0hzhp4HxNB2q+JgmiiDq419HnsPRBUgDI93HSnQv3FLbIQ9fNAolzFdzu
	 jyNi6iYNSHgUcVNjm44OfD2wTORYEKG0tj2qZyuCbdnrXi8s2mjjexAGYOpScyAVE1
	 bbwb95/AM3aUfTH6IiB50m8IgoMhigqyBWxAvEjWv0kfnz0jQDGQ65O7PJxEL1Mfxh
	 /oHfYXCpBOm8ULfwlh0RiRF82gDB2IhufZ5UtNejlqQz16KU3bUsfcqSVipxrahTy5
	 zFR8Q5j0b6Er9QZ1wYbzOXymQLat8Oh8YnsHpNrMXc23igQU3L42v5q7LmHlKEsoDJ
	 B4vCoSD8Chftg==
Date: Fri, 3 Jan 2025 10:07:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Su Hui
 <suhui@nfschina.com>
Cc: alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
 kalesh-anakkur.purayil@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] eth: fbnic: Avoid garbage value in
 fbnic_mac_get_sensor_asic()
Message-ID: <20250103100737.1f329212@kernel.org>
In-Reply-To: <20241230085249.4aa68872@kernel.org>
References: <20241230014242.14562-1-suhui@nfschina.com>
	<Z3JTFJgbzX4XGHwG@mev-dev.igk.intel.com>
	<20241230085249.4aa68872@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 08:52:49 -0800 Jakub Kicinski wrote:
> > It is more like removing broken functionality than fixing (maybe whole
> > commit should be reverted). Anyway returning not support is also fine.  
> 
> I defer to other maintainers. The gaps are trivial to fill in, we'll 
> do so as soon as this patch makes it to net-next (this patch needs to
> target net).

Having slept on it, I think you're right.

Su Hui, could you send a revert of d85ebade02e8 instead?
It's around 126 LoC, not too bad.

