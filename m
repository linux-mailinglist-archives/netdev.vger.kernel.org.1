Return-Path: <netdev+bounces-69863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160184CD64
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80ADF1F27505
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807B7F46D;
	Wed,  7 Feb 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="EQIt4bmE"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50777FBAB
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317754; cv=none; b=OIsIdsdVu7BFVErbHT5Wqx0pZ7uSZvf6CqWYJOhYLUqofsZtbjOMbPQyazefjZaRrRMIyQDtVs/e5uWQftXIglzK3BbuBBLG7lFM5/PFEzkMEeU3BCVZkXdjm+3tUaT+VYwDY9ZDmy6p7FHue9TtHZPxuXLcDh09HCIKYgHdsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317754; c=relaxed/simple;
	bh=EUywNukbxarR8KH4uEj8D1crL4rJ8t/Aukpfyf2R9YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=manUbVxiieHFCyVc/knFrPcvVRxbmuQfZIHLaBSxqA9VW2xJFlhEQS4+NF8ueCAO1S2/UR2fTr3GE9hHtc9R+H8uWGQBdwk6tce7+tayZzc/NdPo/8gbYej1TIM57sdTp7YQwkXRBS7/ebJ0sOWdKHMwP3uc26BwUnpHHOtYKa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=EQIt4bmE; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AAFEBA0688;
	Wed,  7 Feb 2024 15:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=mgsn4ISTOJ6U/7FAnSlP
	R7rvBR2Ef6fV52YT814qDdE=; b=EQIt4bmELlFNm5ddr3jWsgFpM9QsPxsZwc+v
	wVVD0h/W3lRNH0+jDW4nSJIcOldYLyZQ2BB6a0fuLvWmg1VtlJOK2BIyU4HmHz9k
	ZdJH8fSiQZZZc3imoxjCZyg98YZobi4kXtp9o0ZoO3PplRcfCF8u3t/BfaTlpaQ5
	FSTRqKN1dODXvXCrKtGuHAs2xg7wLi5mWZ7ElqcLJXgrBa6irytyuuAGTJhcffVY
	TSgVZAu1D/MRmcv5tSBu6+s2ZoxiNkY+R1IaL5uPVLdcp8+1JMkZfjSPwmA3Xj1a
	TonrBbjLmYmn0JGVvra9EDt1q8wsZCKE7NCjCXdeEoZAT20xUfRpVu2YD2QBHL9G
	XO8S1jtK36//WUM9JMJY7qKe2cf4xHLVdXEvZDQZ0enVZ4Dqx3gKF8Hx5/mXSWG+
	AyV0pnlXg1EGIzosgDfpdr1g2diFJvH7xqBxh4tzvhSw3VTMv8XKzheNO9uiiCmS
	wtIZzGYSk6U0Qqet9L877+NyuP7QWtuMB6bbaPjXRnDCUPP8D35T2s+jClIniwOZ
	ZeUX4kySd7SQTDOcA6FfjvfFxIOoubRow3Sv1vCPQ6JkMao6Y4FSqOZ5kHIgJiAU
	EzCUWquDOy/yYrJmSnDX3xVDszTqxDM5me3iyjle6jRvhJIIKhvF7IwLzInNtx1p
	FMgLh2g=
Message-ID: <bcb0b71a-ca56-4c7b-9200-d994b0fd7252@prolan.hu>
Date: Wed, 7 Feb 2024 15:55:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resubmit] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588
 being cleared on link-down
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
References: <20240207123610.16337-1-csokas.bence@prolan.hu>
 <8c0e21da-4f6a-4a42-90c0-011b226ffae7@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <8c0e21da-4f6a-4a42-90c0-011b226ffae7@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55617162



2024. 02. 07. 15:44 keltezéssel, Andrew Lunn írta:
> On Wed, Feb 07, 2024 at 01:36:11PM +0100, Csókás Bence wrote:
>> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
>> makes all 1588 functionality shut down on link-down. However, some
>> functionality needs to be retained (e.g. PPS) even without link.
> 
> This is the second version of the patch, so the subject should say v2
> within the [PATCH ].

This is the same as the other, just added the rationale text to the 
message body.

> Is this fixing a regression, or did it never work correctly?

PTP on this family of Ethernet controllers is utterly broken. See commit 
f79959220fa5fbda939592bf91c7a9ea90419040 (reverted). I plan on 
re-submitting that entire patch, if i can figure out the locking 
problems that have arisen.

> Please could you split this into two patches. The first patch
> introduced the new #defines, and uses them in the existing code. That
> should be obviously correct. And a second patch adding the new
> functionality, with a good commit message explaining the change,
> particularly the Why?

Sure.

> There was a request to keep the indentation the same. So the BIT()
> need moving right.

> Reverse Christmas tree, as pointed out in your first version of the
> patch.

Ah, sorry, I missed those. Also can do.

> Thanks
>      Andrew
> 
> ---
> pw-bot: cr
> 

Bence


