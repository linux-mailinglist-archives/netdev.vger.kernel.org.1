Return-Path: <netdev+bounces-138633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3089AE6CC
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFEDB2910E
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A41D9A7A;
	Thu, 24 Oct 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GVX50f+R"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D01D89E3;
	Thu, 24 Oct 2024 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776824; cv=none; b=UZZcJFxP6UwiI3B0ma+PejpOJd8YoogMYFzuTxbt1sWXEd+hQu5VGzhR+dvIMlnGSb/bk2ixPBsSfupMoFZj+44scIXzDUYvHeF9BMjlBA0bNowoDbN1EJG4+OG+pS/1k53IBH13I/fbJZ/TBOA6P6U92iVPLzDZ5utmK9VhG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776824; c=relaxed/simple;
	bh=ZHgORxfe3kioAfx2RJFF5hlnkaO0u7suDksQ4MvruQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PgW/Vb1zGLumUEqRU+fy0fdVHMev7gqCKerOMMKQToNXOZ/lcynJ6gjRAVu9niJI72KUlW5IWFYyfjg9DoCfePZEJeqkeFdqC8F9lCj+vD9X2C99GXsuw+8kSeZhRM62Uh/ytjTQMnu2693DEWV53q8/FKbrZRQS+/ImU3gDPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GVX50f+R; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ODX71e095658;
	Thu, 24 Oct 2024 08:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729776787;
	bh=D7HwCNyuL9Jhrwz5cj3lk7hIhMKnCQguwQsDKfb7b+E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GVX50f+R9KxL1K1v9jdi7uP/BZHBrF3l0nAL1zLSmSNeJ0B1zloneMzv7JXgZKQba
	 yUfE6wiymTgkXUGHCP7Xp/uX2IEsewTkStJmtfGvdec3NIL15YWg4qLD+lhsaoxZrX
	 FQs8A60qa7L2h7DLLbTBy5yaimg7fOyRv5ZSX8+s=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ODX7JV043401;
	Thu, 24 Oct 2024 08:33:07 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 08:33:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 08:33:07 -0500
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ODX15L030296;
	Thu, 24 Oct 2024 08:33:02 -0500
Message-ID: <c735f62e-c9fc-4698-ae9f-305cd5519dbd@ti.com>
Date: Thu, 24 Oct 2024 19:03:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix 1 PPS sync
To: Meghana Malladi <m-malladi@ti.com>, <vigneshr@ti.com>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
References: <20241024113140.973928-1-m-malladi@ti.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20241024113140.973928-1-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Meghana,

On 10/24/2024 5:01 PM, Meghana Malladi wrote:
> The first PPS latch time needs to be calculated by the driver
> (in rounded off seconds) and configured as the start time
> offset for the cycle. After synchronizing two PTP clocks
> running as master/slave, missing this would cause master
> and slave to start immediately with some milliseconds
> drift which causes the PPS signal to never synchronize with
> the PTP master.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Md Danish Anwar

