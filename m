Return-Path: <netdev+bounces-124971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA196B747
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3797D1F25F8B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88091CEAA4;
	Wed,  4 Sep 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="i3uf3rRD"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F31CCECB;
	Wed,  4 Sep 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443243; cv=none; b=X6fsmqdEBOZl8+ywSKJkepiO+KOEOLrHzxRZUjwiuoDiEiPGZrvmZvg9LqPQLHMl3KcRiL84/lOSK6An74s52VSSfFDacYSroSO/dU4RD+ms9BqTucLROLY4MtjSSO7yi60zentbyi3fEbeqMR+VdtRkZNfX7RwTP/V3S8gj0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443243; c=relaxed/simple;
	bh=NJJlypCq1LVHV4kyZNF2O/nW1CPY7AkFuVbyQeuM/+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eGClNfK6+kx/bsuQdxFQoopAraoUxy/P2Pwb4zRLqHZBiUHs+ftSSeCSwK3wKBFLIdMC5gE1lE1OZEuWEBuQ0p5T/pFZePz5zzu7muXav8rLKMijVdFsTujrfkc0JPAWp46GPaBSQEeZZckLoxvvVlFitxUmCp1/dX1b794QhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=i3uf3rRD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EA863A06B4;
	Wed,  4 Sep 2024 11:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=RkK3vo5zWN5RQH6TthlM
	e0arEoVY5UTrRohbXOD6Lbs=; b=i3uf3rRDs7r/xLGMYq/RAl4dWIIQbgaYWzzb
	Lq+OsXwnk3Rk8xmaLi3dsm/B8tOB62DBPMUeHD2hE96NQfA+kejLqr637cIOCjwU
	FFy6/7Pctfy0DSaJqG25rsvvHINPar+gsAAWjuMaJBYOgXEWDWhfyv8TTod0R+lr
	EdPlUrE/hGxqx4NpsKEd7KfjKgzx5pPVNGW6U/STjq86dLsClIeMcOusq6gSNw7z
	/DdfjuwbaUwSHNfzY52KD3jenDpGw7cfKPrwviXQFgEPEKabtPjqDVzZYAPmZRMr
	y3g2XiifDfzSEL7vWcdHl3ENytLL5myMQURGvVYmV12Y37dgWrZKYTYAeEL88IQa
	BHXi0X8f2J/2UP2lHekgJx1rRS+93818OB2rNGNQ5PihCiv1XUmAcleypVnJfT/d
	4hillteqVdEcSd2u0+5iA6pVGfgkIcuYGYEQKLTQMQpvcBJGI8es0k63pLEenYZV
	ygZY5HhvV1HPX48yUAKodmSuVnvIcLeaZDlQqBfI6nFwG7YsSAeIpNEIthyxvd+V
	ZQMFi60n0J4hazbWL18VUF9JelcnSj42ACFmO9qcbn0gQPPEAW7EcagH1Ci/k15O
	kCfA4lM/gXsldW+3Uocf/gBHfvE2DMNCKxAvUJpozoEJLFVqExuUexNTtZ3Bzj/p
	5C1bnOE=
Message-ID: <c39614d2-2bac-4b05-8e50-3cefbfd8ed0c@prolan.hu>
Date: Wed, 4 Sep 2024 11:47:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: fec: add PPS channel configuration
To: Marc Kleine-Budde <mkl@pengutronix.de>, Francesco Dolcini
	<francesco@dolcini.it>
CC: <imx@lists.linux.dev>, Eric Dumazet <edumazet@google.com>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Linux Team
	<linux-imx@nxp.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	<devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, Wei Fang <wei.fang@nxp.com>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20240809094804.391441-1-francesco@dolcini.it>
 <311a8d91-8fa8-4f46-8950-74d5fcfa7d15@prolan.hu>
 <20240903160700.GB20205@francesco-nb>
 <20240903-keen-feathered-nyala-1f91cd-mkl@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20240903-keen-feathered-nyala-1f91cd-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854627461

Hi!

On 9/3/24 18:57, Marc Kleine-Budde wrote:
> On 03.09.2024 18:07:00, Francesco Dolcini wrote:
>> On Tue, Sep 03, 2024 at 04:10:28PM +0200, Csókás Bence wrote:
>>> What's the status of this? Also, please Cc: me in further
>>> conversations/revisions as well.
>>
>> I am going to send a v4 in the next few days to address the comments
>> on the dt-bindings change and apart of that I hope is good to go.
> 
> Have you read Richard's feedback on this?
> 
> | https://lore.kernel.org/all/YvLJJkV2GRJWl7tA@hoboy.vegasvil.org
> 
> There seems to be a standard interface for what you're trying to do,
> right?

Yes, he was opposing the sysfs knobs I added, which is not in this patch 
series. Back then, I got moved to another project so I didn't have the 
time to address it. But once this series is merged, we can work on 
run-time output switching using the API.

> regards,
> Marc

Bence


