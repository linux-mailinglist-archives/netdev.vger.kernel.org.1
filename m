Return-Path: <netdev+bounces-143703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9929C3BB7
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07C31C21B2E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58908170A0B;
	Mon, 11 Nov 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VApo6Z1I"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BA149C4D;
	Mon, 11 Nov 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319965; cv=none; b=uKRhuDm2elP+IbyeDSM253J20kZj2R3H4jE29byCbKQeWGEQM35uJGWlPXO4ee5w7Ft3Nvsxgf5XGH/R7xevQDSljjs69n6gKMt4qjDMbLtoVimPVN0yqFfeF0SCdB7NfaE4DrbohaTIel7+vzESFHdQhCpK60+vzGc+mELBuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319965; c=relaxed/simple;
	bh=GTZlMUC1Us8QiYF+impVLj4hxNZlEi9ZSIdAGQPgU7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LL/2yk7tYQxF6LV5GGE2U80MV+6eayja/6KgnLXDzwaEda1I7YwNqhx1T9np90RNL01V8zkLySKVxp4/TNzn4iYLI84K0WIMwDx2ov6DUJg62T+zr5e5V9JicZiGmO36Ej2S4bCZJB2TbdOT4c0t5y6m1YtlHwzmhbK0xvfaduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VApo6Z1I; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ABACGgg049298;
	Mon, 11 Nov 2024 04:12:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731319936;
	bh=GX/AmvvLGmgAHR+8d75DNySRXdN/85YH9dV5UHe/s2c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VApo6Z1IcC1HudRJYq174QMyhUULGZ1XzQXAJio7rsSAnaivS1GzljPFKoWkvlU99
	 RS+6kSBSMAKeItq9fbC+zFufmFxAKIgdtpLlKWhlT8Y+SAYBRi+uSKjLzfnEXGveod
	 7Zo1Ws2YuNJ4Uf8Lwy3t+Rp9e+4/KppW/1zAO5As=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ABACGeP010887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 04:12:16 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 04:12:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 04:12:16 -0600
Received: from [10.24.69.13] (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ABACBIA026399;
	Mon, 11 Nov 2024 04:12:11 -0600
Message-ID: <73f3de15-7cb3-4527-a06b-2a86e73d75cc@ti.com>
Date: Mon, 11 Nov 2024 15:42:10 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Fix 1 PPS sync
To: Jakub Kicinski <kuba@kernel.org>
CC: <vigneshr@ti.com>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <pabeni@redhat.com>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241106072314.3361048-1-m-malladi@ti.com>
 <20241107111542.19dc55e2@kernel.org>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20241107111542.19dc55e2@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 08/11/24 00:45, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 12:53:14 +0530 Meghana Malladi wrote:
>> +static inline __u64 icssg_readq(const void __iomem *addr)
> 
> two nit picks:
>   - since the function is now fairly special purpose I think a name less
>     generic than readq would be appropriate. Maybe icssg_read_time() ?
>   - __u64 is for uAPI, to avoid type name conflicts, in the kernel
>     please use u64 without the underscores
Yeah sure, I have updated it.

