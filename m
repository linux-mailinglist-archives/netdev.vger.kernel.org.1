Return-Path: <netdev+bounces-201341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEF8AE9132
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947424A4D74
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6632FCE17;
	Wed, 25 Jun 2025 22:32:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF312FCE15
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890751; cv=none; b=UzDX7xk0Y/iYtW8ffWsz1MuZDH86qHCfgPA8fxk/if+1MhRl4gdy25UGr33GmX8XRhAVobuLR+PxiCH1LfBCve987CXZxEfM2g2udAp12YkUXiJerrhqwhVCUJoxTYXZLIMGvLI0R6uBOYWVr9+7rDyWacH8TASy3h4juO+DnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890751; c=relaxed/simple;
	bh=yPUdvPWTG7vpHeRNsi8BDNEmU0Nh/+dDg9MPbf5sdn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zt/9BvKvZnnU7LtdJYCNNP6Ng2m/Pu/9CEyVqGxEZRwDehziu6mVRzTdNICDwZyuWzR0fbhwfV765ziFQJ8cCW3I47Mt1dbDsz4+dJA1Qu17mxsCXWUXVbfjvu5rHjWoodpYq4iURano6NbkUFp9Xty8wrvUld5dMXcL3Dc/hmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7c6.dynamic.kabel-deutschland.de [95.90.247.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 415A661E64844;
	Thu, 26 Jun 2025 00:32:07 +0200 (CEST)
Message-ID: <c4f80a35-c92b-4989-8c63-6289463a170c@molgen.mpg.de>
Date: Thu, 26 Jun 2025 00:32:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net 0/5] idpf: replace Tx flow
 scheduling buffer ring with buffer pool
To: Joshua Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250625161156.338777-1-joshua.a.hay@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250625161156.338777-1-joshua.a.hay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Joshua,


Thank you for these patches. One minor comment, should you resend.

Am 25.06.25 um 18:11 schrieb Joshua Hay:
> This series fixes a stability issue in the flow scheduling Tx send/clean
> path that results in a Tx timeout.
>                                                                           
> The existing guardrails in the Tx path were not sufficient to prevent
> the driver from reusing completion tags that were still in flight (held
> by the HW).  This collision would cause the driver to erroneously clean
> the wrong packet thus leaving the descriptor ring in a bad state.
> 
> The main point of this refactor is replace the flow scheduling buffer

… to replace …?

> ring with a large pool/array of buffers.  The completion tag then simply
> is the index into this array.  The driver tracks the free tags and pulls
> the next free one from a refillq.  The cleaning routines simply use the
> completion tag from the completion descriptor to index into the array to
> quickly find the buffers to clean.
> 
> All of the code to support the refactor is added first to ensure traffic
> still passes with each patch.  The final patch then removes all of the
> obsolete stashing code.

Do you have reproducers for the issue?

> Joshua Hay (5):
>    idpf: add support for Tx refillqs in flow scheduling mode
>    idpf: improve when to set RE bit logic
>    idpf: replace flow scheduling buffer ring with buffer pool
>    idpf: stop Tx if there are insufficient buffer resources
>    idpf: remove obsolete stashing code
> 
>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   6 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 626 ++++++------------
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  76 +--
>   3 files changed, 239 insertions(+), 469 deletions(-)


Kind regards,

Paul Menzel

