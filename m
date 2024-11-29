Return-Path: <netdev+bounces-145474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC49CF9AB
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B197B62B77
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7C1FA276;
	Fri, 15 Nov 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNapsh+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669931E412A;
	Fri, 15 Nov 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708276; cv=none; b=HobFAlnVVxHucs2U2uYAW0JICWlHNWgR4ZM0CW+f+fbb8PrVBImPA3bs54ug5DMAOhfUGliQJYcg5onEsBKJkNoDUSNSnshOOIpn3xOlUGjDecGBtO2Y9IcNqCgyuSAU2AT4RHUwa8HFm610zBQo9AbtLKwZGXtwmB2SBtvQ6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708276; c=relaxed/simple;
	bh=s/oaTJ92LOLtErWBpsl2hcdFm5LunYXQJfDrYlkVx/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Twh+kPxOwhfFAEL2SmH/KA+HJKR6iGJgAkr0kgDS3wcxu2ZptCKdByhJPLq/Vj3aXHd206QEE6l+EZFQ2MdSxRHXiIBF7bZvvIlahjCPhWx5z2mfiKvVoM0HQKU/wF7zA51m3Flj7dePqN10QHfXucvll+mYKZ3mM1Ca8IKA7Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNapsh+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377E9C4CECF;
	Fri, 15 Nov 2024 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731708275;
	bh=s/oaTJ92LOLtErWBpsl2hcdFm5LunYXQJfDrYlkVx/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNapsh+nIWwnrX72qvT/6FhSVUcKj26uVVnjtQG0JnoproZt03ReaeI7JP099JFGF
	 mmQT7aq9E0wZ6WeTgWmth3OT11bGXB+OmGl4fmbrjBYInMoZ1FGpReR+JW48DD05tX
	 Yz1bm0K87do35tnBWyxBmaHhQzALsRpf7wCYvrD/DNBosrCbN1xpjtesCRSzwTx1XG
	 3PpfjbM+yewf9Znw0zlGKZxYLhYnI8WrAmI3XbUKSS9v4Mwuf0/Gz/vUHEB9TOT4z1
	 3QyGu4LXoTConxzGWKAbjxOPdo8949jeRGEyl9r27oZnvHtHDpMD0n1bIMGQ8MevMy
	 y0y0RSuX9G4lw==
Date: Fri, 15 Nov 2024 14:04:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <bhelgaas@google.com>
Cc: Wei Huang <wei.huang2@amd.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <helgaas@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <asml.silence@gmail.com>, <almasrymina@google.com>,
 <gospo@broadcom.com>, <michael.chan@broadcom.com>,
 <ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
 <andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
 <Eric.VanTassell@amd.com>
Subject: Re: [PATCH V1 1/2] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20241115140434.50457691@kernel.org>
In-Reply-To: <20241115200412.1340286-2-wei.huang2@amd.com>
References: <20241115200412.1340286-1-wei.huang2@amd.com>
	<20241115200412.1340286-2-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:04:11 -0600 Wei Huang wrote:
> +static void bnxt_irq_affinity_release(struct kref __always_unused *ref)

unused? you're using it now

> +{
> +	struct irq_affinity_notify *notify =
> +		(struct irq_affinity_notify *)
> +		container_of(ref, struct irq_affinity_notify, kref);

this is ugly, and cast is unnecessary.

> +	struct bnxt_irq *irq;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);

since you init irq out of line you can as well init notify here

> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, 0)) {

You checked this function can sleep, right? Because rtnl_lock()
will sleep.


Bjorn, do you have a strong preference to have a user of the TPH code
merged as part of 6.13?  We're very close to the merge window, I'm not
sure build bots etc. will have enough time to hammer this code.
My weak preference would be to punt these driver changes to 6.14
avoid all the conflicts and risks (unless Linus gives us another week.)
-- 
pw-bot: nap

