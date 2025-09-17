Return-Path: <netdev+bounces-223989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD5DB7C891
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7DA483832
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E129B8C7;
	Wed, 17 Sep 2025 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c31U7ebF"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE820E03F;
	Wed, 17 Sep 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109575; cv=none; b=N+wYAHEw1p1g1+odNFHOmQK4VgH+BP34kSA4tariNwpoI50nZRfCt+ef/2dQwKe3/CafcRS5zjCd4BMsqo/D1nNBAH9H91ixxSkW7VEodvcnOpI+Yxk3iAbcbZy+ckjc41O3PRHq+bxXunef8bHQ5bxERjU/JmDWtMj4ckBU1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109575; c=relaxed/simple;
	bh=GE1ZvajMjR1jpdcyQ23SFnVuz3QmYfCASBO13hwms0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VEFe8TkLGPiV3YPVwaYYI9L0gEUYM336U/YFilgfBMO3NN8NdlWsl2pOouTfIVpuBrDMazOvE1V7lZG061tvdeeQqieDWFVYlndh9py9ZUAtQEoatzPNR7eC3IAuxGglNIbPtE+pgqtNPjYukBm9tz5lsrvgR1+wL1J71FQzANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c31U7ebF; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HBj7G91597639;
	Wed, 17 Sep 2025 06:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758109507;
	bh=CESIdT/b5vC34F/eerVXaRdloEbeJeSQadVRXpn30xo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=c31U7ebFlqU6kZuPjeR3YrLRk3pu22idBxlSh8Qez5VPn+A9Pd896Vfs9dUFchjaq
	 WQwPgC5USgoJu/BmU6RwfRFBd+IXgVYn/3y/Td1AAmKwptbKrDi3dYpM36blp2qNPj
	 QyUxKkARwRsEFJiJufjePXpCFZiDDPIr7n+JX6Ro=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HBj6CM2312628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 06:45:06 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 06:45:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 06:45:06 -0500
Received: from [172.24.231.152] (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HBivYL2975345;
	Wed, 17 Sep 2025 06:44:58 -0500
Message-ID: <7cd06f8f-bd74-429d-bf2c-71858178950a@ti.com>
Date: Wed, 17 Sep 2025 17:14:57 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/7] Add RPMSG Ethernet Driver
To: Andrew Davis <afd@ti.com>, "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        Lei Wei <quic_leiwei@quicinc.com>, Xin Guo
	<guoxin09@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Fan Gong
	<gongfan1@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Parthiban
 Veerasooran <Parthiban.Veerasooran@microchip.com>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20250911113612.2598643-1-danishanwar@ti.com>
 <8a20160e-1528-4d0e-9347-0561fc3426b4@ti.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <8a20160e-1528-4d0e-9347-0561fc3426b4@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 11/09/25 9:34 pm, Andrew Davis wrote:
> On 9/11/25 6:36 AM, MD Danish Anwar wrote:
>> This patch series introduces the RPMSG Ethernet driver, which provides a
>> virtual Ethernet interface for communication between a host processor and
>> a remote processor using the RPMSG framework. The driver enables
>> Ethernet-like packet transmission and reception over shared memory,
>> facilitating inter-core communication in systems with heterogeneous
>> processors.
>>
> 
> This is neat and all but I have to ask: why? What does this provide
> that couldn't be done with normal RPMSG messages? Or from a userspace
> TAP/TUN driver on top of RPMSG?
> 

This is different from RPMSG because here I am not using RPMSG to do the
actual TX / RX. RPMSG is only used to share information (tx / rx
offsets, buffer size, etc) between driver and firmware. The TX / RX
happens in the shared memory. This implementation uses a shared memory
circular buffer with head/tail pointers for efficient data passing
without copies between cores.

> This also feels like some odd layering, as RPMSG sits on virtio, and
> we have virtio-net, couldn't we have a firmware just expose that (or
> would the firmware be vhost-net..)?
> 

PMSG sits on virtio, and we do have virtio-net but I am not trying to do
ethernet communication over RPMSG. RPMSG is only used to exchange
information between cores regarding the shared memory where the actual
ethernet communication happens.

> Andrew
> 


-- 
Thanks and Regards,
Danish


