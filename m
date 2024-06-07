Return-Path: <netdev+bounces-101749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D98FFF02
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D261B241E1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1315E5D9;
	Fri,  7 Jun 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="JLHm3qN6"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786715E5BB;
	Fri,  7 Jun 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751582; cv=none; b=U4JHtzZOMyLO2+w8ClWbO2SXK2BFrweVwxKOB5NNoQsyoHnx9Paw29IPVqJE0dMhIUtyG7DPZ2yfvdTZDPYbK1HNab3G+Q1G7Yf4HEU8in7Rh2jM/6ugpnuYVR1KpscG2Ll66gXoMDMJ56NOlLnwURZygOX04q5YUcKt+drkfKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751582; c=relaxed/simple;
	bh=CpoWk9tqECkn4nbQhMbf4yMd845I5p9Btv2YBKK6sMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ovxoxl9wAnmsAo7HG+Ydlck71sC1oIQD6TJ2+5m7+swJ7syQ/9syZsNAKD99zsNxfeMJfb2x/My2ZOR6vPr/GcXvY20s0jCtse9ma6Bd0UJVaSiJuWK+aJkBiOW3+3z6xlWKv3xHXXlwOCH9aCifmA+QLKwRumLjHdJonnxwmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=JLHm3qN6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 03306A03B1;
	Fri,  7 Jun 2024 11:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=cH3JNZ+ofwZaBIUkuSYT
	MJjaGGVzDFJZcT+TVGds2Ik=; b=JLHm3qN68bCyKXUsP5w0jTBP0MxLRvTRsqPQ
	hUtL+ZBZENRQwfwtxXvV8qHm97t09Ae3c9iN58LavCrXU4rrxzg8gu8RhS14hhtN
	tLgAzJmrSa7lh0gSbb7fu9Z+DDb50icbhSG6lSxYdf+OHAPO3ulCaU57p6pZL0LH
	FL/m7YK3yMzPZeMMq/vOhNJ5we/t/sgSc9cAfUKF7D+RuASp7xxnKFJCs3ALG92E
	FQNT52quraKXwRgJ7fPFtRIoquB6O+pEgxJhKy94N4B1RlXRNzwGSNmVfiyOjfep
	cZGta+0QVbZokmsR6FZVDDUMKN8KuBu2XskY04YCT0tqxNBJaK21nfoB29ruRa6J
	IEJyGrNkCL/iIyhOKuGg3cErdg+thzA0lcO434HUW682wapQCkNCgIEgoMbBmB8M
	TIAU5fCZXVmtstkerrUOFQtTUe4aDu6TGmjhOLP+QlSPS9UPe6ZDn1wYeNvZy8om
	LXmigJly3R8Mklt5zJyXNwAzpLbBLdhs/Zi9Vo0fJMH276xonCx4uMAtF8VfQYo4
	CU80fgaQ6rbJrLE51OCy8qLSuGuwNrQXSYbj85X+TbCX4OIxmpbwExNa0Z1ajRDR
	EQ8cDsC6EH7x4Ya/Cd5+c60NY3uaYOsZ/PDk9S/7gSAyWSxOXWjh3daOLBVz+hFG
	wMCMzZ0=
Message-ID: <8be22ec7-0d91-46ba-b45e-4499b547a8d3@prolan.hu>
Date: Fri, 7 Jun 2024 11:12:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being
 cleared on link-down
To: Hariprasad Kelam <hkelam@marvell.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
 <PH0PR18MB4474DC325887DE80C1A2D7F0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <PH0PR18MB4474DC325887DE80C1A2D7F0DEFB2@PH0PR18MB4474.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627061

Hi!

On 6/7/24 10:32, Hariprasad Kelam wrote:
>> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which makes
>> all 1588 functionality shut down on link-down. However, some functionality
>> needs to be retained (e.g. PPS) even without link.
>>
> 
> 
>      Since this patch is targeted for net, please add fixes tag.

This issue has existed for "practically all time". I guess if I had to 
pick one commit, it would be:

Fixes: 6605b730c061 FEC: Add time stamping code and a PTP hardware clock

I don't know if it makes sense to add this ancient commit from 22 years 
ago, but if so, then so be it.

Bence


