Return-Path: <netdev+bounces-110093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06E92AF37
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110DF1F21181
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02C712C52F;
	Tue,  9 Jul 2024 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vZ9wV88f"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206E1304AD;
	Tue,  9 Jul 2024 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501104; cv=none; b=nMYuNxkQUTrspigmogHTl3Jj7Yf+awMVJKsfVC9fDwQNTQgjjutZpUEMLljskb1N9BCqQ86jU/7Zsg9HD3/xqazcByCCWzzJlRc6hvxtqqv7+CsJ0y3O4uLvpqCBZf13P+fwE8cfSVGZ5wCHXGtlWz8pdtpuK3qdWE/ztlPAKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501104; c=relaxed/simple;
	bh=io3I2UB7plG1d6+h3PNOV0O7rfMKlDLuuTGMgWJ7qUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IhnQDFpgsOn0k65tOxV+8u+8vMlbm4P4eUCT9ST1/5GeJdD0p32ZoOOr/srG6PEYU9VDMPW2QAB9iOJ5hjdapYCVUSgSrzZ+yPp55/e6kqadFmuRXVzdW6Fy+x29i4ktHOyXvy3f1VkgYL4Btltz3Lg3HtmhJJSm1pQ1z5ikv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vZ9wV88f; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4694w5ft104257;
	Mon, 8 Jul 2024 23:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720501085;
	bh=e3okKmuFmJX+lqLAUTm7L/kYzutbB8Kxz0TPsG6nIlo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vZ9wV88fJIJOVqzmX4l6+gJLQbkrH+HqtaZfvDxnZ9DuZBtUnma3qqUyIJbAqoLvB
	 lcYch8e7ohRO1YVI+C8vFwzrPmM7SO+XEugSjTg4P4QdC9A2wSfHigbM6mkSij3aDC
	 g6KDIymkXRb2DKBoAOg1lZVtzuaUxf59i+4Nkf40=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4694w5GK091280
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jul 2024 23:58:05 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 23:58:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 23:58:05 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4694w1Vc004582;
	Mon, 8 Jul 2024 23:58:02 -0500
Message-ID: <6d433b6d-7256-44f1-a705-fbcfe5dbce7f@ti.com>
Date: Tue, 9 Jul 2024 10:28:01 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg-prueth: add missing deps
To: Guillaume La Roque <glaroque@baylibre.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240708-net-deps-v2-1-b22fb74da2a3@baylibre.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240708-net-deps-v2-1-b22fb74da2a3@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 08/07/24 8:01 pm, Guillaume La Roque wrote:
> Add missing dependency on NET_SWITCHDEV.
> 
> Fixes: abd5576b9c57 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

