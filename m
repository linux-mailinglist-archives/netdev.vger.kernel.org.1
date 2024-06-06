Return-Path: <netdev+bounces-101257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF68FDDD2
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 06:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E0E1F24455
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7E29415;
	Thu,  6 Jun 2024 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C8wR+F9S"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1D32940D;
	Thu,  6 Jun 2024 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649081; cv=none; b=oacAeNWtR5UP/cdK33oKdKidA09fXbNxdly+1AfevY3sg+OLHEEQnQf4oMBTI7jzNoYP2OOQHpHrkHy671SLGkN4Lt+BSD6Cfef25t9qbdzt+mfnpwjOnlJKK1cSJbWtjIPhx9TFzbBfJDZEle4OiOjY4qW2R6ubL6/KKdBI5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649081; c=relaxed/simple;
	bh=X2lwsmQXMXKZBbMOZ4wY7TMr5k8lTSkDLqj/Q6OCCf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t3tuZ8/WaOauL830BScyNKTH3uB9lFmcdcCjJT5rNpoqcngfgHXpIiRz0K0ghIwxGUrNNh6urVJ5CirPrlRaIuftxjK4D3XOr1cYe5oMaM5Imsn5wE6VF64U+I+Tlscn8wl6pqjgAt0fDXYBqWO0Dk6UbCieXZ3MYq9IRK06kWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C8wR+F9S; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4564iAsX000499;
	Wed, 5 Jun 2024 23:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717649050;
	bh=X2lwsmQXMXKZBbMOZ4wY7TMr5k8lTSkDLqj/Q6OCCf0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=C8wR+F9STMO+Q/ueIHp+PbnqCbQ77Tgk+hqf7wV/c5aaejWmW7f+aT0ziP+scBKmj
	 chopCdJ4L/PnoNhU+I01iPKm9U3jUCd2PtN6IFVnMmLXUWQzbZ7PNvZOskMIQNmYoV
	 27l4aezm5er9CUjWwmaPGS20q9fzw5n8Nz54POCo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4564iAWB066870
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 23:44:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 23:44:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 23:44:09 -0500
Received: from [172.24.18.200] (lt5cd2489kgj.dhcp.ti.com [172.24.18.200])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4564i26G010676;
	Wed, 5 Jun 2024 23:44:03 -0500
Message-ID: <990441df-2432-4bce-a606-077f51168283@ti.com>
Date: Thu, 6 Jun 2024 10:14:01 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
To: Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <tglx@linutronix.de>, <tpiepho@impinj.com>,
        <w.egorov@phytec.de>, <andrew@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kip Broadhurst <kbroadhurst@ti.com>
References: <20240531165725.1815176-1-u-kumar1@ti.com>
 <20240605155659.GA3213669-robh@kernel.org>
 <20240605122330.169ea734@kernel.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240605122330.169ea734@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jakub,

On 6/6/2024 12:53 AM, Jakub Kicinski wrote:
> On Wed, 5 Jun 2024 09:56:59 -0600 Rob Herring wrote:
>>> Cc: Kip Broadhurst <kbroadhurst@ti.com>
> Kip, ack?


We can skip Ack from Kip,

For ti authors, I represent ti for this patch.

> Failing that (+1 to I'm not a lawyer, but) Udit, you both have @ti.com
> addresses, can you confirm the intellectual rights are with TI?
> In which case we won't have to wait for Kip.. Obviously easiest if they
> just ack.

