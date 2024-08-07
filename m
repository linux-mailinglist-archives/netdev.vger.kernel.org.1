Return-Path: <netdev+bounces-116458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC5894A791
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0241C208CC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F71E4EFE;
	Wed,  7 Aug 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OO4Vzh6j"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE51DF666;
	Wed,  7 Aug 2024 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032857; cv=none; b=CxAzE88fUNhiWbjpC2teo2dqlolVnD4ybXR3vbxCtry25hezET4zlUeQB1Mm2KsjayUfQVvRknPI6NqWLVjVOHm1J/rEO0lH4aM4avxUlvgUnHYhVcQu1KxkTTrWKoXoKXao4bKcruxGFBUZFiGmSzfYuqBPIwDWbgawiU8dimg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032857; c=relaxed/simple;
	bh=LFPJMtlLbenGGCI4dDdxDXEBfb57dIFJy6G4BLuOYUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZJ/pG2cYpj7C+DnX3J5HukADRbGA492nugFumi7k8FVf4am2dlDylvMtOQW7Uw/qBaBCbGXlTLxfn6LCl1cu7SKSpXpQgFEPgvBoO9aGPBeVa1CBn6YPgka+W4+SWPyx28XRbgzhZ9CCkoXPOMHbEzpxVZ3SqDeK3QVL7nrzOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OO4Vzh6j; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477CE1Z2077096;
	Wed, 7 Aug 2024 07:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723032841;
	bh=yhWtHAww4/pgImc14EqvstwFJuhtEjx3b6vd+ptekds=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OO4Vzh6jjj7wz3KkJNbng7HiwdbNa11YmJK7bBZEJPutO+uaYWbpGXvPBNMcf7GnL
	 PlitW6XgIi0QtDI++FrZfQNOfk+bQUBFrrCNDzszAaodDZbRyUFRm8ZWCdxEEgzVdv
	 bga3e9upUbaLoE9YRLIeLL69+cgV6GFdoJGgyAvo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477CE1f1095265
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 07:14:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 07:14:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 07:14:01 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477CDvSB017338;
	Wed, 7 Aug 2024 07:13:58 -0500
Message-ID: <f5d75a64-6517-4303-984e-5857118b2142@ti.com>
Date: Wed, 7 Aug 2024 17:43:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: populate netdev of_node
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
References: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 07/08/24 5:42 pm, Matthias Schiffer wrote:
> Allow of_find_net_device_by_node() to find icssg_prueth ports and make
> the individual ports' of_nodes available in sysfs.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

