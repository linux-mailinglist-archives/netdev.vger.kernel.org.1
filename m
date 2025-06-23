Return-Path: <netdev+bounces-200367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C33AE4AD6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F079E4429EB
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272C2BEC55;
	Mon, 23 Jun 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCqJVVsF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8128DB59;
	Mon, 23 Jun 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695637; cv=none; b=Gne8X+fa82zUjD3/Rrm1Kv3qh4bxV8AIIqYV+k/pXWNUs/NwfJE6cAsk+8ZZACchmEraC7fOKJV04by5/LBSLsC6LzWLmKzXpI0YDZFU9qOgki7AAQmG/cyJumvgFjO/mmLsPJ8Z5RI5jo87wqpFg3EIPV8U7KucGcOQVsF/4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695637; c=relaxed/simple;
	bh=ghy4DPgcI6c8nygLNevpmDIsNbsgcFIhd8rwOHjZ4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt9MBguuUIN8zozZ46vFc83E9/dpidbrCjjOGMpVruWzXztb77VFg0hE0EOmFa0rla2QU/Yosiq0tyrSLfd5ml2vZINxixa3M3nm5qPL2JqlAeBRdnMg2MPgM8G5KfAM+81u7TbeFidgOqsG3IRLofizgIc9Z1gQLD/fe+SE24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCqJVVsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE59C4CEEA;
	Mon, 23 Jun 2025 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750695637;
	bh=ghy4DPgcI6c8nygLNevpmDIsNbsgcFIhd8rwOHjZ4ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCqJVVsFGirXl78BUR1zqYsgcE3iurRB1CAvoT3bbrZITcGkwRxePpBgvwV/VTPMk
	 FF+ESiGGZVMSU9ebqgpMfaMV5g1CgAU2cOGlsVrKrqQIOmZZ0ojAYcIclHNAT8fqt9
	 gokBLExkwgb1ml9gblL7akCyCPkhY9zo8ZMHAtGvH6TRK5YKkWpNhLlIw41wb9s9wD
	 lq80Sn0EjEojukuDF9Iy1gP0sE6C+cIvRpPmghdU6XNCpuTSyeCrJf/JxYrwdpMG80
	 yJUfzRDak9p7VPgR+VfZgp73n3acVrLLYJGJLjytOl3jfaGtO8pRqZVf6YoFcek8IU
	 2mt+gWm2R2wAg==
Date: Mon, 23 Jun 2025 17:20:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Match VF MAC deletion behaviour with OOT driver
Message-ID: <20250623162032.GB506049@horms.kernel.org>
References: <39898c5f9a1d6172aa346ad96a831a899a58ec54.1750633468.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39898c5f9a1d6172aa346ad96a831a899a58ec54.1750633468.git.jamie.bainbridge@gmail.com>

On Mon, Jun 23, 2025 at 09:04:41AM +1000, Jamie Bainbridge wrote:
> When the PF is processing an AQ message to delete a VF's MACs from the
> MAC filter, the Linux kernel driver checks if the PF set the MAC and if
> the VF is trusted. However, the out-of-tree driver has intentionally
> removed the check for VF trust with OOT driver version 2.26.8.
> 
> This results in an undesirable behaviour difference between the OOT
> driver and the Linux driver, where if a trusted VF with a PF-set MAC
> sets itself down (which sends an AQ message to delete the VF's MAC
> filters) then the VF MAC is erased from the interface with the Linux
> kernel driver but not with the OOT driver.
> 
> This results in the VF losing its PF-set MAC which should not happen.
> 
> Change the Linux kernel driver and comment to match the OOT behaviour.
> 
> Fixes: ea2a1cfc3b201 ("i40e: Fix VF MAC filter removal")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Hi Jamie,

I hate to be a pain but I'm wondering if we could rephrase the subject
and patch description to emphasis that this is correcting undesirable
(incorrect?) behaviour. And as a footnote, that the new behaviour matches
the OOT driver.

Correctness is what matters most from an upstream PoV.

Thanks!

