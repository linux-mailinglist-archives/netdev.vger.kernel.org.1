Return-Path: <netdev+bounces-147852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA09DE6C9
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384D916508A
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 12:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1D19D8AC;
	Fri, 29 Nov 2024 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7kF5xOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF719D8A4;
	Fri, 29 Nov 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885104; cv=none; b=W5W5r2Mh99uCmCOYNb3LWfWvwXbhPyr/9d+pcy5cauwbNqt6z7G+RwihwqdoJDQdd4w6Cw0rXiIM4FLkl4cwayPiCeoUQ13m5KSGRjZ3rFyuZY/Q5sglY0mkL8LODuXF8WWFZEtCjwbXqh+Qe6m4nVrVdfq6XeRPiJg4/nVUD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885104; c=relaxed/simple;
	bh=sq/YLAb/fB+2vkIJfrLd/Ha67t4otVRZ7+d52cxNFXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyyUf5ODjesyvRVRa3SOGKlaVNInI/c9gPc3XMXXqOi6tY6CAnnTUbYKHFMs++EVUg62ScuXmaW++WK4ZpsSBoa8k1CO//XC+F+NEuDbjTzb3gKc+vV4wZ6pzJq3meaRCdgCk1ZzGeynFhHXQQybYPc4zGEKdUslTySjcooiwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7kF5xOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F656C4CECF;
	Fri, 29 Nov 2024 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732885103;
	bh=sq/YLAb/fB+2vkIJfrLd/Ha67t4otVRZ7+d52cxNFXI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q7kF5xOB27aQnYfMlebD1tv+LucTFpSonUqh4/C42D2KymsHuuuYHJfajqQ2GiK1n
	 HYKcPvcK5X+a/go5MSnR17aKSyiocpm7v74tmP/1DAyX7V5UTiqFxOrXtaoMrHb6Nd
	 epuar4o9D8HJHP8E8N73bMSwpBUwAoljsbuva5MUKbsuHJ8Bsahl5atHbawjX4PbvC
	 kHoMKvDUAb/e/1JvtDMdC3o5e/QJ73hIRYwpxTtoteEowCZZFOq1CT8gCqWfl4BM4E
	 AUdY/pOBO0IX6XJc7oqsuaOm2rrTBMBdPzLDaBjPVGJnWuvnA0GqozwSDmK0ZIHjcJ
	 tq7y5/qjbHmJA==
Message-ID: <5b6cf8f9-fdaf-4719-b1b2-f4745c671263@kernel.org>
Date: Fri, 29 Nov 2024 14:58:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] net: ti: icssg-prueth: Fix clearing of
 IEP_CMP_CFG registers during iep_init
To: Meghana Malladi <m-malladi@ti.com>, lokeshvutla@ti.com, vigneshr@ti.com,
 javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 jacob.e.keller@intel.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241128122931.2494446-1-m-malladi@ti.com>
 <20241128122931.2494446-3-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241128122931.2494446-3-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/11/2024 14:29, Meghana Malladi wrote:
> When ICSSG interfaces are brought down and brought up again, the
> pru cores are shut down and booted again, flushing out all the memories
> and start again in a clean state. Hence it is expected that the
> IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
> that the existing residual configuration doesn't cause any unusual
> behavior. If the register is not cleared, existing IEP_CMP_CFG set for
> CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.
> 
> After bringing the interface up, calling PPS enable doesn't work as
> the driver believes PPS is already enabled, (iep->pps_enabled is not
> cleared during interface bring down) and driver will just return true
> even though there is no signal. Fix this by disabling pps and perout.
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


