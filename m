Return-Path: <netdev+bounces-109353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7601928145
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 06:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE421F236A3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297D50A63;
	Fri,  5 Jul 2024 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AgQd8TjI"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291F2F52;
	Fri,  5 Jul 2024 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720154535; cv=none; b=qyLIJpGeC9T1jceqmLi+2/yhdlD9VuSUh6FU5vxbgo0+3s5LmQItjrePBVmimULg0IzkCKtJAZWXgIS3icZ4wOQhRSPEiUMgVCX0eH1yMdS2o17cWDfczVVAKVz/at9+PHt2agaHzRb06RCkHtLeT3MDxUMbhHqRtFlXZH7aMAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720154535; c=relaxed/simple;
	bh=L9WH9ZtdJMBuavqkRl5IH88P7wYkiGEG/QCkaYaacXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r9XjdcNy+k7zDcSwva/oTT5U34TaWLxmtF5wpMc/2q+bquHCyplP39VJqYb8zLIffwfd/wmdtSi9HZueKhf8RZiTOz8tcRIKp+WV6BwbZVgDCSR/f/f3hW+2RkChCZGP+C4Nmb+5QeM7kxFoYxtLvSDDr/rugQ30ppGnJY4ZpW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AgQd8TjI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654fxJE111320;
	Thu, 4 Jul 2024 23:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720154519;
	bh=lmttwY03WSt3Pnqn3iZ/8D9FkB0qHr/iG3F0P+miAVU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AgQd8TjIE+BDbKDMdFG4u/tgTyIGQH6+q+HBFya0ZcFd1OhtmjEmIoa+eP1uG62Es
	 1k99u4IueaELdTq6oCJIMPi2HOgZjd+x7wNO1BLM86XoFZiydLnSlrvvtQR5K1/dJ+
	 9q7sAy4CKie+G/nZDw4FIvTUPA361aQ4VB6uHtWs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654fxS4114043
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 23:41:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:41:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:41:58 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654fsAZ021774;
	Thu, 4 Jul 2024 23:41:55 -0500
Message-ID: <20f6bcae-42a8-4c34-9904-9f0a77326ab6@ti.com>
Date: Fri, 5 Jul 2024 10:11:53 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: ti: icss-iep: constify struct regmap_config
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean
	<olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Roger Quadros <rogerq@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
 <20240703-net-const-regmap-v1-2-ff4aeceda02c@gmail.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240703-net-const-regmap-v1-2-ff4aeceda02c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 04/07/24 3:16 am, Javier Carrasco wrote:
> `am654_icss_iep_regmap_config` is only assigned to a pointer that passes
> the data as read-only.
> 
> Add the const modifier to the struct and pointer to move the data to a
> read-only section.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

