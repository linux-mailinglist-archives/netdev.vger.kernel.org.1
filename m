Return-Path: <netdev+bounces-223991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE3B7C870
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FE44846E9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A730C34D;
	Wed, 17 Sep 2025 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GYYj+jDD"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6332EC0B9;
	Wed, 17 Sep 2025 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109792; cv=none; b=ECNqg5Xhz4pf8ZEgA9mlDL6xEIHZPbqi6vba1PlrBn8TPgLIPie7nXgHd0sjR0XI+/SccVdLA3GhGSgV8K3Y+qMXv/ehfw6dJhkrQiVcyeEaEAMCqdsAJ9A8NC2yZOPDtj96IikaowXWIpHqB67vkctnmdadS7iU14WxnUjbzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109792; c=relaxed/simple;
	bh=ee5UiMtEunJ0B5ZQtmbMrdcHQzYVMO4el/bZHCHvql4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EjVqlzBJoe/AYzfEfJS27oxL9C4bqufp+frWjHAWWLgyvnj/uEqXxzUFHM/bemkKUeYnRGwMeMGF0eHApM/ChIef4PDg33omDWH5lLrt5gPmpDmo80QuLxp5EJjUUZ47jL8blOJAEMi2LsVR0cb09OixqOjI/raTICrVe1/6634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GYYj+jDD; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HBnZiE241612;
	Wed, 17 Sep 2025 06:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758109775;
	bh=o5RI0cwCpMESoyhhUyJOMYzRr0pXrL8WMtTQZ2c7IaE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GYYj+jDDc5/As1obPU9MJvrA/pG/jdkCq1TT16Ft5meisQMuRNN+BFx2jLQh9jh+Q
	 BFqdsAq4G1RWYoV6id/bRnySFxBv05ay8z5ixH62di4M9E/9KGDaNP5/n2BjvSTQcw
	 +EFe4PMo2qmVs3i5TVC+TsnqKpjecKOfNi1ndJoQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HBnYlD2314382
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 06:49:34 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 06:49:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 06:49:34 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HBnTao2982599;
	Wed, 17 Sep 2025 06:49:30 -0500
Message-ID: <219398b5-8d09-46cd-b1f4-580a26ddab67@ti.com>
Date: Wed, 17 Sep 2025 17:19:28 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: am65-cpsw: Update hw timestamping filter for
 PTPv1 RX packets
To: vishnu singh <v-singh1@ti.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <mwalle@kernel.org>,
        <alexander.sverdlin@gmail.com>, <npitre@baylibre.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <c-vankar@ti.com>
References: <20250917041455.1815579-1-v-singh1@ti.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250917041455.1815579-1-v-singh1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 17/09/25 9:44 am, vishnu singh wrote:
> From: Vishnu Singh <v-singh1@ti.com>
> 
> CPTS module of CPSW supports hardware timestamping of PTPv1 packets.Update
> the "hwtstamp_rx_filters" of CPSW driver to enable timestamping of received
> PTPv1 packets. Also update the advertised capability to include PTPv1.
> 
> Signed-off-by: Vishnu Singh <v-singh1@ti.com>

Patch prefix should mention which tree you are targeting. Since this
looks like new feature and not a bug fix. Prefix should have been
"[PATCH net-next]". Please note that for future posting.

The patch however looks okay to me.

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish


