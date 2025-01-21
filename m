Return-Path: <netdev+bounces-160091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E7A1815F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0143A708D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44871F2C5B;
	Tue, 21 Jan 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ueoby7rT"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779711925AF;
	Tue, 21 Jan 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474721; cv=none; b=nE+dcbkdQZVK2ahY36eV45ioqwXZ2TdmgT5Pa1Y3w7k8ltD7QMCz8fIZ2Foc3c2A1o/dyrhGb/10cogH65BfyBdDlEeCEqCjTSL/JYLwfxlPHID/aRZf2YDEfhTq0sygH07bHcwJRW921ZjY7lWMbCfsp+CI8h6ZtC0otORXnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474721; c=relaxed/simple;
	bh=hrLE4NQBUtWVaPWjUAhety7mCtPHHYfaAoKZXs/C2vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N24dv39/KMoBPtDskQNDDzoGc5ePcB96+TSv4PSFN9/HfYXcYW0FcoirO/hpYxnRu0yjDMG2aYl86PYHMeVAw6nD2KjHBS3o5/2GrIjPqYSordbQYj8P7+E6KGh2pNSCEI+UNjJc0n8Am/XZzXUgvmL7L71njq0wcTnWg+GPtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ueoby7rT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 90009A1398;
	Tue, 21 Jan 2025 16:51:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=XQyC8tHCp/f195PB+HPI
	3Vhsql/BCqJM2YmMTdcDfGk=; b=Ueoby7rTn2ZaUPfRmgq/DJMMrI7008SA1zkR
	uZwVm3GwMYI7PmKD3KAUoc2+ILsS8KyEJb71bADqXF4heC1A2/e53ehTtlOoA+fE
	ZReuwvRi+LiUFpL5fayHBsbJUqIw9r85qFQnIhvKT6L4EsOUJgsNdJINv/v4rqeL
	fWXCSPp497Loh/ZkKyRSHxDRcEues6TFy9eK4CcdjqQS3ZPsu5jc/UxqjvJLvPK9
	XMJUYeItakW0xAJb1XMgzWpT8KAWcDVpFn/WC4nIA3HfUEEgejV0NWEP9aTkhuUo
	uXOtwJ6RCSAeaR0lRgWnhIKhIa8+5Ibll4IH5IW6VTD9WYZthva4hiGQtv+RcA8X
	UYa2DLjrwjLMgu6ckZk4zIvZNhHD6Aq+b03Hyu4Oga89zjsJv0KkJKyEWCkXP/P/
	H1hInaQbDkipk6NBnG/pkKlKNxV1ePwiKNNa8/BuHt4R09/MnsHF7cu48Aylwsm7
	z/0k4ucRJ1N+gM5l00zaT8zAigsg7E/hgafYobBSZsGeT78fCX3FODwiZ43cVG3Z
	313k9kKVX3GlmsWTEPgQEjrX3/cpOpfVrpNm12NfGSrlZ7fByIBbQbzLPlMd5ASF
	exi6aLYBZFEznW51X2dsMJIEJNR22rBY9lV1+2NnJGEcYzCRgUpOH15Ll3s+RCqV
	HZd8qD0=
Message-ID: <2ddcb00f-b5dd-46fd-a8f9-9d45c0ae82ef@prolan.hu>
Date: Tue, 21 Jan 2025 16:51:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
To: Simon Horman <horms@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Laurent Badel <laurentbadel@eaton.com>,
	<imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
 <20250121151936.GF324367@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250121151936.GF324367@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485267746B

Hi all,

On 2025. 01. 21. 16:19, Simon Horman wrote:
> It seems that this does not compile because val is not declared in this scope.

Ohh, shoot, I forgot a `-a` in `git commit --amend`... Rookie mistake; 
will be fixed.

> Please observe the rule regarding not posting updated patches within 24h
> when preparing v2.

Of course.

On 2025. 01. 21. 15:36, Ahmad Fatoum wrote:
 > please make the lines a bit longer for v2. 43 characters is much too 
limited.

Reformatted to 80 cols.

On 2025. 01. 21. 15:10, Michal Swiatkowski wrote:
 >> -	} else {
 >> -		writel(1, fep->hwp + FEC_ECNTRL);
 > Nit, in case of a need for v2 you can mark in commit message that
 > FEC_ECR_RESET == 1, so define can be use instead of 1.

This was somehow missed from my earlier refactor in commit ff049886671c 
("net: fec: Refactor: #define magic constants"). Adding this to the msg.

Bence


