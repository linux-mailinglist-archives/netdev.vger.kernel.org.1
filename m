Return-Path: <netdev+bounces-236451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D52C3C78E
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E1501E2B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B835771D;
	Thu,  6 Nov 2025 16:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1E357721;
	Thu,  6 Nov 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446001; cv=none; b=nqMHvEKgWahtJFYvN6HTg3EpjF1YnPfKsmNfqZH5p7ckQNF09IZwBc5Th0LD1aHDHSLpiKwp5oYAPLdNjgv3kqUMUhzopp9c3zH4JawdFL1W7w0SNT663q1VZsSTrpXF2H+2LlKKrhj0LYK5liO9j+9muiovp/QrkBtQ00ToaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446001; c=relaxed/simple;
	bh=OVcOtVk12b2dUh33QkalNDOXz+aQqlvRcKVr+4p/xFo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DsDfoemOeNIEJmJjYQnHE7IiSkRMY58m/gOkMmNQl6E1KJ3o2BRLkMhGo5bWUCaucOcpCpgo51vmCDKiZZxGaD4vB0jHOW08CvzBHdIPXJ2asRn57moBDbfD8FHwrf1MHmmkeoyZGlBaZ1kGt2PSDTXgep/2btOSJPqNj+g5MH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d2S7m0blvzJ46Dq;
	Fri,  7 Nov 2025 00:19:32 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 134F1140277;
	Fri,  7 Nov 2025 00:19:55 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 19:19:54 +0300
Message-ID: <64893d23-157c-4cd4-b1d6-5f120bba7a03@huawei.com>
Date: Thu, 6 Nov 2025 19:19:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] ipvlan: Support GSO for port -> ipvlan
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20251105161450.1730216-1-skorodumov.dmitry@huawei.com>
 <20251105161450.1730216-7-skorodumov.dmitry@huawei.com>
 <CANn89i+iq3PVz6_maSeGJT4DxcYfP8sN0_v=DTkin+AMhV-BNA@mail.gmail.com>
 <dfad18c7-0721-486a-bd6e-75107bb54920@huawei.com>
 <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
Content-Language: en-US
In-Reply-To: <bd0da59d-153f-4930-851a-68117dbcc2de@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 06.11.2025 18:41, Dmitry Skorodumov wrote:
> I see that currently there is no any tests for this ipvlan module (may be I missed something).. Do you have any ideas about tests? I'm a bit  confused at the moment: designing tests from scratch - this might be a bit tricky.
>
> Or it is enough just describe test-cases I checked manually (in some of the patches of the series)?
>
I just got few ideas how to implement tests.. I think I'll provide some tests, at least for the new functionality.

Dmitry


