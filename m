Return-Path: <netdev+bounces-201592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BBAAEA032
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4021722EE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC552397A4;
	Thu, 26 Jun 2025 14:17:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx-b.polytechnique.fr (mx-b.polytechnique.fr [129.104.30.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F541C7017;
	Thu, 26 Jun 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.104.30.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947461; cv=none; b=IoGTKF/hbLr38RnlrxxMILBEkAh7eTKdEMHJNqkzcLELOOqQ3X8b1+Y6vVnm0SAFczf4C7md6Oz27rJVNVAOuxETSqQpJIlBbdMoy7/TwO0UU6J2Gpeow126uaR7JBZ2cCJOuSKR4qmS2hsKIhnB+dK3SypNQT2he/eI4piNzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947461; c=relaxed/simple;
	bh=qVlqwudT1xgdU1YLTSFQQod7Vl2jcxZ9g9rmavYcnho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7JtGG9VZjqMrUEiGAK8xbEBCnWTdOfcTdsNlNbtjboTL3rd7E8prcW//2AyDk4xxziThU+fqgzEPfGJxM/ir7zaQmkyy1SEngoGailAke8eS5dZiKaghGotWuJ4525sGj+ff2FedSPpTLMTqUIcEH9cy0EWEKB5m4UMpIJ/Z+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=129.104.30.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from zimbra.polytechnique.fr (zimbra.polytechnique.fr [129.104.69.30])
	by mx-b.polytechnique.fr (tbp 25.10.18/2.0.8) with ESMTP id 55QEC7JO002049;
	Thu, 26 Jun 2025 16:12:08 +0200
Received: from localhost (localhost [127.0.0.1])
	by zimbra.polytechnique.fr (Postfix) with ESMTP id AFFA9761F8D;
	Thu, 26 Jun 2025 16:12:07 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.polytechnique.fr
Received: from zimbra.polytechnique.fr ([127.0.0.1])
 by localhost (zimbra.polytechnique.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id QqbVE9ZZ6jnZ; Thu, 26 Jun 2025 16:12:07 +0200 (CEST)
Received: from [129.88.52.32] (webmail-69.polytechnique.fr [129.104.69.39])
	by zimbra.polytechnique.fr (Postfix) with ESMTPSA id 749C0761E90;
	Thu, 26 Jun 2025 16:12:07 +0200 (CEST)
Message-ID: <fab602aa-f4ed-4a33-9ce9-f7f10890f5c8@gmail.com>
Date: Thu, 26 Jun 2025 16:12:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atm: idt77252: Use sb_pool_remove()
To: Simon Horman <horms@kernel.org>
Cc: Chas Williams <3chas3@gmail.com>, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250626075317.191931-2-fourier.thomas@gmail.com>
 <20250626110619.GW1562@horms.kernel.org>
Content-Language: en-US, fr
From: Thomas Fourier <fourier.thomas@gmail.com>
In-Reply-To: <20250626110619.GW1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/06/2025 13:06, Simon Horman wrote:
> On Thu, Jun 26, 2025 at 09:53:16AM +0200, Thomas Fourier wrote:
>> Replacing the manual pool remove with the dedicated function.
>>
>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> Hi Thomas,
>
> Unfortunately this patch doesn't apply cleanly on net-next,
> which is a pre-requisite for our CI to process it.
>
> I suggest reposting this patch once your other patch to this file [1]
> has been accepted.
Hi Simon,

My bad, I thought it was applied but I guess it was on net, not net-next.

>
> [1] [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
>      https://lore.kernel.org/all/20250624064148.12815-3-fourier.thomas@gmail.com/
>
> The code change itself looks good to me.
>
Thanks for the review!


