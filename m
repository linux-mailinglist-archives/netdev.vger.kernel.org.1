Return-Path: <netdev+bounces-210825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98885B14FFD
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1F83BD6F7
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF1279798;
	Tue, 29 Jul 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MKJFsGf/"
X-Original-To: netdev@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53727702D;
	Tue, 29 Jul 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801685; cv=none; b=GyBFLYyIA7MjZ2UwMff5O3eCX6G6iTj8Ww1WbCe21c4s68V7W7KJg7UbM26MkL8pnOZwB2WDYHA/j5+41uxa+mD3nl4ZLpNkvt9xgjNqcKLVWcedrt2rexTNgzIy+d04TDiVoxUpLdyAnQVwDiuJwKjkrFF9B7SL0o9bl+t2DOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801685; c=relaxed/simple;
	bh=PBOkQyQ2DhJSvlZwtpvSMJYClY321RSVjLSe8tXXnZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L6tAFQ8KpJuOgs9yCG/cSIZ2gPt6RhnM0hJbHOt3XjgjG7fvT7gBlJonJC/ACKYqNHRrBknHn/N+7iRt946I4DwVPIr6bx9QHjIyrotk7+LpAJfC9nbrkH56i9v6mTqzmgtNBQEUAl4prN0pUYDLYJsgPHNiK0R4pxOWJJmUuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MKJFsGf/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TCpPUJ031980;
	Tue, 29 Jul 2025 17:07:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rxNeNoGx1mH4GH0w94NI93U/kEXE+lSVdRaFrGTDI0g=; b=MKJFsGf/y754Tnvr
	xLdfD2hsDaNECBNZBmwKrazssfYyHo9DBQ4DdKdsN13xS5PgKmEbmoBLTAjq5s5E
	v3ee1pbRlyhjybenzVv6IpWfpM2LeWqmZlsEdD82pfYmXEt/uTJfL/xTj5mzz2eL
	euCEtL895eMzGzW9sCNXyqlw/cEEx5yjok5wH724M83/XgT3JmaLoH78eBlGZjRi
	ZDKRdC763CR4ysxOXrUsrNHxNUsPB7GEWk2L3FhzR3VS+XwT6F+thDHNSwq9XCEU
	ycCwSJG9uoYj+fy+vzJP7mVRbfKOJNc4FNNgIUUNYYKbMPu5lsfIJ631pbzkjFET
	4YtQmg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4859ynjf35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 17:07:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CEAB44002D;
	Tue, 29 Jul 2025 17:06:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C5FA763987;
	Tue, 29 Jul 2025 17:05:40 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 17:05:39 +0200
Message-ID: <b25eff85-73fd-45b3-b92f-5cc0a86011c7@foss.st.com>
Date: Tue, 29 Jul 2025 17:05:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: stmmac: allow generation of flexible
 PPS relative to MAC time
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250724-relative_flex_pps-v1-0-37ca65773369@foss.st.com>
 <20250725172547.13d550a4@kernel.org>
 <424f8bbd-10b2-468c-aac8-edc71296dabb@foss.st.com>
 <20250728085818.5c7a1e45@kernel.org>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250728085818.5c7a1e45@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01



On 7/28/25 17:58, Jakub Kicinski wrote:
> On Mon, 28 Jul 2025 10:15:07 +0200 Gatien CHEVALLIER wrote:
>> Maybe we could compare the time to the current MAC system
>> time and, if the start time is in the past, consider the
>> value to be an offset. Therefore, any value set in the past
>> would be considered as an offset. I see some implementations
>> doing either that or replacing any value set in the past to
>> a safe start + a fixed offset.
> 
> Let's try this.

Ok, I sent a V2 with a proposal implementing this behavior.
Thank you.

