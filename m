Return-Path: <netdev+bounces-117579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA894E649
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 07:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FBD1C21447
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3214D6FC;
	Mon, 12 Aug 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NGHtsoAk"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84E1411C8;
	Mon, 12 Aug 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441893; cv=none; b=UcJCvPNB60S+YDqkLfqsA3rWb7DXWy4mECdyoEb/RawRYs2NIkWHWAIfj5BCFIVypJQCpCSWJzOZ0A0O4GZCa64fULpPZnvP5b3sK7tx7Iu8gLtpfaBVq9+zPrgVUi4hKdmXkbfSBeQvZPJ3pIswUOf9R1gCd//VOvJ25b6xmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441893; c=relaxed/simple;
	bh=5aJVH7Jn/vxS1JdnXEPulZCKKW80Js9R+aWunwrcqzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bnzdbfK8FxapO/tif9g0+si1zfOyIbJceXkB1+cN0F4qMwMFMwj7TaWzUDfRWIk7Iyz6YS2Kbt4Pbe2OrIS6y16ddqOyDHv4FgClmh1SWzqR3cN8WoE/DuBPLg2C7y7YzvCimRqEeRp99HgMoCcHY7tnCh2bd/77hmeFoJwxBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NGHtsoAk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C5p5EY052993;
	Mon, 12 Aug 2024 00:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723441865;
	bh=ZaFDlrTmZWUH5tuDn+gHntc4hv0oJDrngbUk7wLXlb0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NGHtsoAkhNkcBeLgQCQHK46Sx2WoYVfaLskPChYnVSQgrqUhvDjQWHut892dQepK6
	 VdfgkxdgTVNDkjy3aTA7cbkukussrjAIiQR0xvRfD3FPpKAIPKfTGPL8PwdKImu+qq
	 nU3QSgjCJok4Bp4cewhtWyeXK1qw2rd22+0O2XOs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C5p51t011171
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 00:51:05 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 00:51:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 00:51:04 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C5ounr099300;
	Mon, 12 Aug 2024 00:50:57 -0500
Message-ID: <39ed6b90-aab6-452d-a39b-815498a00519@ti.com>
Date: Mon, 12 Aug 2024 11:20:56 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: soc: ti: pruss: Add documentation for
 PA_STATS support
To: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>
CC: Suman Anna <s-anna@ti.com>, Sai Krishna <saikrishnag@marvell.com>,
        Jan
 Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        <srk@ti.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240729113226.2905928-1-danishanwar@ti.com>
 <20240729113226.2905928-2-danishanwar@ti.com>
 <b6196edc-4e14-41e9-826e-7b58f9753ef5@kernel.org>
 <20240806150341.evrprkjp3hb6d74p@mockup>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240806150341.evrprkjp3hb6d74p@mockup>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 06/08/24 8:33 pm, Nishanth Menon wrote:
> On 09:42-20240805, Roger Quadros wrote:
>>
>>
>> On 29/07/2024 14:32, MD Danish Anwar wrote:
>>> Add documentation for pa-stats node which is syscon regmap for
>>> PA_STATS registers. This will be used to dump statistics maintained by
>>> ICSSG firmware.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Reviewed-by: tags should come after Author's Signed-off-by:
>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> If the net maintainers are OK, they could potentially take the binding
> patch along with the driver mods corresponding to this - I am a bit
> unsure of picking up a binding if the driver implementation is heading
> the wrong way.
> 

Hi Jakub, Paolo, David, Andrew,

Will it be okay to pick this binding patch to net-next tree. Nishant is
suggesting since the driver changes are done in drivers/net/ the binding
can be picked by net maintainers.

Please let us know if it will be okay to take this binding to net-next.
I can post a new series with just the binding and the driver patch to
net-next if needed.

-- 
Thanks and Regards,
Danish

