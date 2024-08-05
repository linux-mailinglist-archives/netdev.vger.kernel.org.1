Return-Path: <netdev+bounces-115822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276ED947E44
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79EF281AAB
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86971156C74;
	Mon,  5 Aug 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="n8BrXNaP"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD3155743;
	Mon,  5 Aug 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872214; cv=none; b=uQZ+zseoBJE8YMsHLYaG+5t+nR9eN2SSRG3WO1QhsMLH9y5rqBxFepMon7GFH9TlwLilSoq8uHdIhmG6rB9ZAGfdBeXjteRe/ilQvGCm/mgI5hmVlr/Z+PBJUGpZYyAvyuTwP6nroGQOzMwFTLOaEr4D66f1mna7+Xbebimvjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872214; c=relaxed/simple;
	bh=lgm/CfF1kNtpVpadJCl2umPQwmOL+fdfXHSKuaL12Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hglyyhtZ8yD7alF7yC9DU6NvmfL9QfHwyAz9W3HEZKA667e8IRPcG+0mTf5oGSOqbdraaHD2bp8E5GcY5MntlXAvjqBvZWsTJoW2ErTY39HtdeZW4ztGFuL/gGThHFxDkCIzZLN4+FaPQSHGxMWZeLXneW+Ev87N383dCusvSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=n8BrXNaP; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3386CA0CB7;
	Mon,  5 Aug 2024 17:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=UC8/wb76Mrv0u+5zJN4f
	kYrLZtn41yWwBkZ85Mge7Is=; b=n8BrXNaPpZKJUg3bLp7y8JYrTB8l0XQSbA5O
	RwI9Ue5B2vQhbNqgj+XbouJbXEGaM3mmY0LjUajZ1pIb4nGIvK/9KNBxc7Us7/Yl
	T8ZBAgXkJYzBpsxK2ToeJKq9jZT0LT+OQVWCbbrSv5yowOjbxNjaVRCtefKvwEJa
	In6q/5JmXrl5cFedgXmOzegV0Sbq6s30YR6YDUYF1/q+2TPbls4bzJtXlGc0cJia
	BFZqDHyg2Pbv0U02A5cG+as3L5DG+XopGcYnBnbrAYBe1+fxe07heW745VYZ4E5M
	b/WBIzfxtxxITKgLM4r/8IGZPawBH2+Lz0pcJau2tVISH+nRd91Bx2iYSCTbsR8N
	zjzoxohfZlHF1/phKerX3NWEEaU3dj6wodo/SCTswkNYXApv7s0L+TyyebyhfPFM
	TNZ+5DrKebPnrKZxfP2ZahXFHAN+VLsI38qqzpmo+HoeNGa/k6EkY+MFUa0sAp/G
	Sco2fs9uzNdtcZkQYKv5wKCnWcTps49rubVfhuH5OXUSiSzQr/VWgLjoWqfLtG8x
	0R2bGwZfZ3riYpsdq91VpXpjscePdRqqZIYhN3TW9X35SeEj9SCs0XZyAPGeGwPa
	arGbZKUa5g4uN68Kg2QV/QI90sxYXBKrLGpzq9bIl/I2UxKasSK3ZN/6xa9to+dC
	Z1/FZ8E=
Message-ID: <1b13b44e-54b2-4b83-9649-18f36ad3bf8b@prolan.hu>
Date: Mon, 5 Aug 2024 17:36:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fec: Remove duplicated code
To: Frank Li <Frank.li@nxp.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
References: <20240805144754.2384663-1-csokas.bence@prolan.hu>
 <ZrDwRBi8kS6xgReQ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <ZrDwRBi8kS6xgReQ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854667C61



On 8/5/24 17:31, Frank Li wrote:
> On Mon, Aug 05, 2024 at 04:47:55PM +0200, Csókás, Bence wrote:
>> -	ptp_hc = readl(fep->hwp + FEC_ATIME);
>> +	ptp_hc = fep->cc.read(&fep->cc);
> 
> why not call fec_ptp_read() directly?
> 
> Frank

It is defined later in the file. Using the struct cyclecounter was the 
solution for this we settled on in 61d5e2a251fb ("fec: Fix timer capture 
timing in `fec_ptp_enable_pps()`") as well.

Bence


