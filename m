Return-Path: <netdev+bounces-105568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31F911D48
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C299F1F22C86
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D410916C876;
	Fri, 21 Jun 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="nDHehLuQ"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC87E58D;
	Fri, 21 Jun 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956116; cv=none; b=sC4QwySbqJnvRdWBfrGklA0NkjevNGo/R2Xb5SHqu1Ds184Hc0zB3TvNVEcBQPelT3oDsOp/IYXDWf4ZNfb2ow3vAN/ZkYZ03junGObzi3fpeqBIM8WF1/9JK+U3lh0l4GX/Qpziw/PK7dp88NFidRcEeAfj0U3nAA5eIxnadHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956116; c=relaxed/simple;
	bh=+EhfIqDCxvAn5pgilOswqS+omcw5oGDRGBmQLYWykCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fyCtoXDyJOhpAVVQGnrjHZHz5ZurRu7oFSX+MVV7ovamWPPnncIYZK4E3gUv3zC+r8OGQnBCguvsQ8U/6i6N6iO5gQ0rMTlpXNZAcRRkGlPpPRiIpVH7WTfq+z4/EFVwQNngoKYJ5i9cYPOkvGsnDJzbVrqlt7AJFO1t5MfV01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=nDHehLuQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 4B13CA0796;
	Fri, 21 Jun 2024 09:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=OB0z767zdZiUMHyqre9h
	c5AMqLSuctfCp1/ZdkYsUxU=; b=nDHehLuQ8zSJZvveTYE1uUR/3yUw+67dLpnb
	mcU3XOmobcoP5xXN2vxGRMAh8EF2MQ3R+R69OPcj5BbzCGEu9T3iDbZbJTZTBUf7
	8QKmNf/Hy1S7wurNWqH2czXfp2JX3TYIiVgmsPN7XXXtANir7nRqJLrXauwHZ1u+
	Xg1ESDEorrem66Lmp6WDKuBaPG1OKFiTGxSke7SRcjNiE1Th0kKKk6Yw62COmnZV
	C7kkPVDn/uwHsOmdixuKbhR4mipBoopaxNIwuWxfLNrUgl8yG03z5nTS5ID7fJ5A
	U/0rD+ywxCtfTXgT4kliiPFLGWy3eiSnFn0nM5kNcIWv+O/E4Ur0Vi5JPP9c2Hi2
	1iaHGZD/mCRgL9L+jJplzwqolLtKI7paISpQmyS7cy4ToEk5+oHwuOKRvNxH2K44
	TuhhZYnf8yMvZc2wDWoVfLuZhFK731qkGcSe2Fe7n+gIH06iWrDKIAx//2LI0bpc
	/9CATeZr9vdAKQ/zhjXo+uvQrIwReB9/Po7D9Mr9V0AmCyzagBt2O8GxV/+EOEP+
	sQ/rFw9aSRKnhpt8dSB+FV5WW+jgSixk3akBEhjcDXJtROLoDvhwTIohDBZLXVMF
	Kng/TNt6UDVcTposUYp4fbHx10l+5S7cmGYjq30LuhHfZ8Jn9hNDkx/TVOt3lFS3
	FFlUlzE=
Message-ID: <f216c0b9-3d0d-4d4c-aa33-ba02b0722052@prolan.hu>
Date: Fri, 21 Jun 2024 09:48:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 resub 1/2] net: include: mii: Refactor: Define LPA_* in
 terms of ADVERTISE_*
To: Andrew Lunn <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vladimir Oltean
	<olteanv@gmail.com>, <trivial@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
References: <20240619124622.2798613-1-csokas.bence@prolan.hu>
 <c82256a5-6385-4205-ba74-ab102396abb6@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <c82256a5-6385-4205-ba74-ab102396abb6@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576C7567

Hi

On 6/20/24 21:07, Andrew Lunn wrote:
> On Wed, Jun 19, 2024 at 02:46:22PM +0200, Csókás, Bence wrote:
>> Ethernet specification mandates that these bits will be equal.
>> To reduce the amount of magix hex'es in the code, just define
>> them in terms of each other.
> 
> I have a quick email exchange with other PHY maintainers, and we
> agree. We will reject these changes, they are just churn and bring no
> real benefit.
> 
> NACK
> 
>      Andrew
> 

The benefit is that I don't have to constantly convert between "n-th bit 
set" (which is how virtually all datasheets, specifications, 
documentation etc. represent MII bits) and these hex values. In most 
places in the kernel, register bits are already represented with BIT() 
et al., so why not here?

Bence


