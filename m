Return-Path: <netdev+bounces-163023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DD2A28CC8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E1D3A4381
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A0149C7B;
	Wed,  5 Feb 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="N3qbXKjD"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C4FC0B;
	Wed,  5 Feb 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763638; cv=none; b=il40EihCLrnRitvovRS6+7o7IwBo2zkTVA1FukSzAwgfgeR/p9rkV39nz2ZlnaeQs4vAKVL7ad79a9p9NM6SYlHH42SJd1tmboZvh6q6oY7fTJ4/7Qk06uNJ7WkFS/GIBAVNViyJ0ywKcu9NYknTYth4feTubqlKEgDQ7SMLdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763638; c=relaxed/simple;
	bh=y3CiBkw5TX3BsdV/FD36Lb1NBMtemKSZtBYTWCzcAgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bEUxXh6MN2IfYYzrXOes3xEY0o059YLvW3xaETX9NJMzqUdrekGhK1zoURqgiVnGqHwl/sRy0l8Ci9xTV/23OCv+QDGdaIORHAF8lkCX/W+dFU2B/pQkgkDONT0uWZ/TN/Z4D0VmZAIEORWb3IlwMKSBNL28UcgJCATDV2Vd6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=N3qbXKjD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 91186A0397;
	Wed,  5 Feb 2025 14:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=0IKFTDRpezqJ0hTkQTF4
	PSBLn0guyPuTMu30l2R43VU=; b=N3qbXKjD27mtNdAYnL3dXw3b/rOVUSBua3th
	MJbGegBlh94DeX2g5hnYVCGNeWT9ngiL1ZXpjYSoOQAIQvY8wCgnbl5SscLO+NNu
	7VGMrIazgL7pYZMgtG3KIraw09Z5Zo0vCrPL72v6PEyIYm2muI78gqLoMiT84bBu
	KQC31eVNghQwFi1z4nUug6OvQPTtYuBlxoYDu9jyAaPTMlTzfM6qxM7rq87FThg7
	V+G/KLkSbskqUJeEsYZHB+hGIXFh2E968xlL4ldEepKvzA8q7wZIFBL4794v9ocn
	RLDE7qagS0NoWfV6NPjXm7qjEgHSd6oiyZdVkP7nS96xCjBLEKQ/ZpXa3Q9Qgntu
	2TLMqDFdyzyKXw6+8G2T5v8v5GFWw8LjW6pwau2AdblR7cjWU8Rqu2ClEzaTIAfG
	LeHUabapaxLyjJTz3yg5P0IhY6lWCtk+V/4DF3Bu6BJ6psuYcWnATZVkZHJBeAg0
	eGXDVy2RextY2QJyfdMaZrDWjI4HVm2+pgX2bf472tVDE/tzik8fRwjknNqncCsF
	E4fdN/TiRgCQ1VMXM2EL6Z0AKvDeZBC1ynPhu9+SF9tVXpa0JYqHN8PJWZ6JIwlN
	j6TaBsSR9LyILS1R9YWct9zyuwOuEUuPuwUyP9ScUeJSq/21IQwkmlDkwTs+rWA9
	AjEQsJU=
Message-ID: <7501c8ee-9272-4c13-91a9-5c614c585fcf@prolan.hu>
Date: Wed, 5 Feb 2025 14:53:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: fec: Refactor MAC reset to function
To: Jakub Kicinski <kuba@kernel.org>
CC: Laurent Badel <laurentbadel@eaton.com>, Andrew Lunn <andrew@lunn.ch>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
	"Simon Horman" <horms@kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20250122163935.213313-2-csokas.bence@prolan.hu>
 <20250204093756.253642-2-csokas.bence@prolan.hu>
 <20250204074504.523c794c@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250204074504.523c794c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485266726A

Hi,

On 2025. 02. 04. 16:45, Jakub Kicinski wrote:
 > Please don't post new versions in-reply-to, and add lore links to
 > the previous version in the changelog.

Will do. Is it okay to only include the last version, or should I 
collect them going back to v1?

> On Tue, 4 Feb 2025 10:37:54 +0100 Csókás, Bence wrote:
>> For instance, as of now, `fec_stop()` does not check for
>> `FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
>> a PM power-down event; and `fec_restart()` missed the refactor renaming
>> the "magic" constant `1` to `FEC_ECR_RESET`.
> 
> Laurent responded to v1 saying this was intentional. Please give more
> details on how problem you're seeing and on what platforms. Otherwise
> this is not a fix but refactoring.

True, but he also said:
On 2025. 01. 21. 17:09, Badel, Laurent wrote:
 > If others disagree and there's a consensus that this change is ok, 
I'm happy
 > for the patch to get through, but I tend to err on the side of 
caution in such
 > cases.

I understand he is cautious, but I'd argue that the fact that two people 
already posted Reviewed-by: (not counting Simon, who since withdrew it), 
means that others also agree that we should err on the OTHER side of 
caution, and do the check in both cases. He also mentions that the 
reason he didn't do the check in `fec_stop()` was that he believed that 
the only time that gets called is on driver/interface remove, but that 
is not the case, as I outlined in the message already.

Bence


