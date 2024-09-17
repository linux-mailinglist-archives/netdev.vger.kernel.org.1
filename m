Return-Path: <netdev+bounces-128664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3C97AC6F
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 09:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF47F1C20EDB
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703A61FCE;
	Tue, 17 Sep 2024 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="F5UuLDUk"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D3847B;
	Tue, 17 Sep 2024 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559593; cv=none; b=O0RshdjYF2s8Mxz5IwSi7srIGNCvTn3ui77opzZGR6w++I8wUCgnezKiliwhmqdqqunn0fQGSDxoFrVJX/SbVwaJ9QNnIUvZVTvkWX4XcooUVam6IgUa0mJQEGUl/216hb9vPExq82C38xi+76qtAdiGTWpf2aHrU4ilUi8vAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559593; c=relaxed/simple;
	bh=Se4Ox4FdYkwXYp/fPyNavBt76V4zzgnJl2LUMhEtcx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZP2C/+zErKZnol0jrePZ4OKAnw2apKPxTg0SAh4Kl4KFm0Zhmrc4crx6t5efo3/W8/W2CGHHFkJ4u8e0HahD3StUg0VdtAHrB/fiJ1fobXTVjYuJU8ziWQmUmZAtorRmWees+eYhLqc87/wwevxjpvR480hpwd1iF9aVmhW57PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=F5UuLDUk; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 70E90A05EC;
	Tue, 17 Sep 2024 09:53:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=hWDsT5EXBtwnRc38qFl6
	l7996Q0pdajQg2k4m4ObVyM=; b=F5UuLDUksSYX6OEMczNeP058BfWKqveL83e6
	NRONq2tfTpdJaYCw0DOu81MywWbq2Ws/ze5Po5HVjeWzNl21OcVdWsHueinofmrn
	BM1lUCAgBXLfcY0Mmh/4kKyHOQD0C06om9htPxEEGHdM1ad4upj5AVr9eEpGMrWT
	xlZT/3jY5NgG+uDjU8HuM4/2yvz7pkl3KrICi10sS7CQK+Q/GXstAi3Z52yxfmda
	gVY2xQm6Bfz3zRx7ZZy5zV8bKQNq6UY72n5KKgYhZkJAQRCfZYrrN96GyhdjVSH6
	yOH2lq4UDO8FcigHVYlaAFcYSpQaEX4SSk9JedwDvUa5X0I/pLKQ8j4ToLreFkmd
	Ms8WE+20Faxt3gZkptgNxu7VKUe9ti+W6bZU5R3LBPWQkgOVkIinSGrSUx6c8goJ
	3VDKsOkzGFmprbT4y9i4+5D33pUBph9OKQFk/Sm8SJv80jedKRMo4cJMzL8g/xSq
	xs0gvZQny2bN38VLU4MxFS283KCynzmvBKMKTZCHRTr2CNuNdIJSJZI5UFLBnjGP
	PQy1WDK/sqBSMn9j+pUyRd2yxTJqsVhC8dQQAFHREZL4+tnlB54KhCuIK2v0CQxD
	n2x1GQCyUHKQ3DNYZCfoqqCpZ9j4PTaHGA9COWeApvr3LdyEQzaWXwmHNpxQz4v7
	ubmuW88=
Message-ID: <c70a049b-cef8-4b9d-8fd6-e9d8ec0270cc@prolan.hu>
Date: Tue, 17 Sep 2024 09:53:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: fec: Reload PTP registers after link-state
 change
To: Frank Li <Frank.li@nxp.com>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
References: <20240916141931.742734-1-csokas.bence@prolan.hu>
 <20240916141931.742734-2-csokas.bence@prolan.hu>
 <ZuhJJ5BEgu9q6vaj@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <ZuhJJ5BEgu9q6vaj@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948546D716A

Hi!

On 9/16/24 17:05, Frank Li wrote:
> On Mon, Sep 16, 2024 at 04:19:31PM +0200, Csókás, Bence wrote:
>> On link-state change, the controller gets reset,
>> which clears all PTP registers, including PHC time,
>> calibrated clock correction values etc. For correct
>> IEEE 1588 operation we need to restore these after
>> the reset.
> 
> I am not sure if it necessary. timer will be big offset after reset. ptpd
> should set_time then do clock frequency adjust, supposed just few ms, ptp
> time will get resync.
> 
> of course, restore these value may reduce the resync time.
> 
> Frank

There's 3 problems with that:
1. ATCORR, ATINC and ATPER will not be restored, therefore precision 
will be immediately lost.
2. ptpd does NOT set the time, only once, on startup. Currently, on 
link-down, ptpd tries to correct for the missing 54 years by making the 
PHC tick 3% faster (therefore the PPS signal will have a frequency error 
as well), which will never get it there. One work-around is to 
periodically re-start ptpd, but this is obviously sub-optimal.
3. If the PTP server goes away, there's no way to restore the time. 
Whereas if you save and reload it, you can continue, although with 
degraded precision.

Bence


