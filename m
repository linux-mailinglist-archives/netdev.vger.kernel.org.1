Return-Path: <netdev+bounces-116373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434E94A2FD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3577281B13
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA21422D6;
	Wed,  7 Aug 2024 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="p7U6K7sM"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5E18D640;
	Wed,  7 Aug 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019719; cv=none; b=EOesbeT76nSNcuCKE0gw24IODpVTM5duX3z6cDCywREuRIfwssfc2oRs/FZK5zqDy+kj8lOq0CKnu6ULz4NNQkAP7Fm+pKAht3k6UvX+7grvqx4SMN5bEARPC23JUazTcGIkkLF4NhwoNrlTBVKY/5gGJ+QpK4tat7J2R76SPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019719; c=relaxed/simple;
	bh=CFIVoZfM0mdsYSyF0ORbV4gOz1SQzIjEY1X6zrYWV4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hoMKeh+k4kA7V4iEQrcf8YypLrRGS/ADo58N1Zvwb9gE3LNmbMc46++KjCjC5/rCOelCeXblQI9CEXQIns/avLYBAQ1auuw8sqGzAjpjwh7W7/HKWY30GUs/Hswtm5LXavqoD1GE7orNCWX+tyVMBr5k4P2+bwh7pSg3VbWSRcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=p7U6K7sM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E3485A0CEC;
	Wed,  7 Aug 2024 10:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=+4q3VBIj2FO2RpMFosL0
	eyJHJ3IvPI+U7bKp+4E1ccE=; b=p7U6K7sMxMZ0AFW5Yn+HFKukr1JDWBeh002u
	0BDDhPnnuUjlkDOkX1DAlIBFkC1yTZ9yuNRm0o/DmVuZzyCUjZ+hQZRTxnG1kA25
	OhHz2Q4oHimzVdtG7Tb6WDLXQxZidQfDhzraiikGst+pSXV9aFzgorBUiaKGbeho
	K2O+ro7GOSHjo7S7PZrgFFDf8IoRjwTqq0Nu5Ix8+G/fTgpb0W6PYAK93JuEOnCe
	9QHUoG0eQJrVYdob8DxbxyNod6RTxaAaLWe6n8cx3qenUKjFA1RJrA2ojKOpIY1Y
	Ts4cHXoEPMbXMU7VXtepXeaxNwIkEBhKeg/DGG+D5zFyrnIPJUF9MejDbQdXLzx9
	hCOmLMiEnRQCAByBfcr3YuatvtmOhhugMBP55FFtZy7avgubU+pH0eXuZoIah/2u
	Q5k2EZ1+xROyu7XwZdjDDpUBNAqEkrhiHflPznrGASjsjJPkBSjK23YK4exICDF+
	RsQawH7IHfir+c+fWLOX/5Y6LOa9nDnxScj5MQZ51MHw645qg1iEL+lb1eNrU8kY
	bBkEEabQM/GUBt8WE5zVuqaF9KJnAcwmax6nfW7e8dOBHZOcJ60pWecORgg+Gnl5
	9fPcGexuMAesuxzh20uo+oYMc3/RSaXLaP6jwzs39W00/WeOz64NUCKJ/Z5GwbMT
	ILXo6Ns=
Message-ID: <317c3565-b1ea-4cce-a4e7-a52e62ee9f6a@prolan.hu>
Date: Wed, 7 Aug 2024 10:35:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
To: Jakub Kicinski <kuba@kernel.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Frank Li <Frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20240807082918.2558282-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854617461

Aw, crop, I meant to say -v2 instead of "resubmit"... That's what 
happens if you mindlessly re-use format-patch commands :/ I hope it 
doesn't bother you _too_ much...

On 8/7/24 10:29, Csókás, Bence wrote:
> This function is used in `fec_ptp_enable_pps()` through
> struct cyclecounter read(). Forward declarations make
> it clearer, what's happening.
> 
> Fixes: 61d5e2a251fb ("fec: Fix timer capture timing in `fec_ptp_enable_pps()`")
> Suggested-by: Frank Li <Frank.li@nxp.com>
> Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>


