Return-Path: <netdev+bounces-158732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BDFA1317F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1DC3A06C1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 02:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B8578F3A;
	Thu, 16 Jan 2025 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPasyAZ2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736B1862;
	Thu, 16 Jan 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995268; cv=none; b=GKHq5DN2VtGNtfBYKwHmjMONnbQx3y8S0U7rBUKS/zwgAaGezrZwXNPAti/kUA7g2XvIwt5LgkvWLwV+Q0hEhRNQCoiCE3WW5urD18Wk5RyRmZ/1RWfp/tYw9fMj1GHNKYSbXj+ij1tRXZ71rruf7diXhKm7dGsnyWq4Xwkof2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995268; c=relaxed/simple;
	bh=357X8ueNSmXmBC6zxKI/63tEqCXBjNeDU6GK2yNvUAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3n6Jm98K+ammeKvIR1XIBS3WEV5oWPQIzdXeTa4vFoaUn2TGDB0BKJy9GCfc2V04ZBSn+OKpVGWXf3F2nSX1xDOI0ay+YErjMwdpWtukedSzG6lkduZrCSZXTn+59FZWAhv8/qmuAuO/mMacnuvA128XY0vtv7Y8RAB0PdWjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPasyAZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E850C4CED1;
	Thu, 16 Jan 2025 02:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736995267;
	bh=357X8ueNSmXmBC6zxKI/63tEqCXBjNeDU6GK2yNvUAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JPasyAZ2pXyo8qbSFD7ZwIEuV1EKK/LSSeua5vU//cH6s7iu3tSTYwGQSny2KAC7D
	 VznLxn5ygEAW5jlVKrZMx3n+Sb+AI/Jy66mm7E0ZwL2ppZuSFXd1dwS8tP+plcfKUj
	 QEWcn41dyqz32+oVWK4tkBXlo6v9cCydSkC7dtKql1zZv0dq7H7lIlVi1/HTR0NrFa
	 coEvsEQlICfRbB9IWB+lIvHzUMx1DQzdBK8NXErtZL694f3SCcyssiyaNNhzDscAwg
	 o/LC8tuOBCs6gsUPk/KAvTSKdjKbY5lditIZMMnjqOkQdiPRWKRMWU3mjDNdvkOG2J
	 9YoR6N03JSnOw==
Date: Wed, 15 Jan 2025 18:41:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>
Subject: Re: [PATCH v2 net-next 07/13] net: enetc: add RSS support for
 i.MX95 ENETC PF
Message-ID: <20250115184105.139aed9c@kernel.org>
In-Reply-To: <PAXPR04MB8510B52B7D27640C557680B4881A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250113082245.2332775-1-wei.fang@nxp.com>
	<20250113082245.2332775-8-wei.fang@nxp.com>
	<20250115140042.63b99c4f@kernel.org>
	<PAXPR04MB8510B52B7D27640C557680B4881A2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 02:24:10 +0000 Wei Fang wrote:
> > Why create full ops for something this trivial?  
> 
> We add enetc_pf_hw_ops to implement different hardware ops
> for different chips. So that they can be called in common functions.
> Although the change is minor, it is consistent with the original
> intention of adding enetc_pf_hw_ops.

In other words you prefer ops.

Now imagine you have to refactor such piece of code in 10 drivers 
and each of them has 2 layers of indirect ops like you do.
Unnecessary complexity.

