Return-Path: <netdev+bounces-96263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E98C4C0C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC38D286BE6
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74561862C;
	Tue, 14 May 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zRqe3R7J"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ECE1802E;
	Tue, 14 May 2024 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715665744; cv=none; b=YrFmP6Du0Ayxjufv+3z2XJY9A4YuHMHkmD3maWGsvrrBfjUhlFnQC+FJub6rk1XD6RooWI30GtG6+uNbP5TUhoV10kbfj79z8obmGhHmNSGpCvx6sCQdS/zxSyDoP4ad+ycs/DXCQMzqVGnZdmVfctO2TLqQI6XU+FhVVUSZDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715665744; c=relaxed/simple;
	bh=QEsA9rVW5PEd0GIZ939vlg+hTw7lyZxJmxlffqRFvYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OHbJGgKaovkgZ7I0qaaS3z5VK/Sqp6jAgncKgZm1TQbyOoqWn/oiJhGI9c+lNdw28OSOunOY25UT2XzTi7AGy9JpRgeIHL2bCgSlgf51nojIBsjHO4IJRcD0P8lEXIyzYvksSkVTl0/GRP+VoqGnLdBnNSQ8LUrBY3xPJMk/lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zRqe3R7J; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E5melc116320;
	Tue, 14 May 2024 00:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715665720;
	bh=QkSC8tfDasMCgcVuKaxBBhub6zp3UOWi2j7PTS//D/g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zRqe3R7Jirxm7EdWdg4qhWIO23t+ETRx3OxlZIuMq2pVCgJc+WcIFH9P4F82DxlBG
	 mul7VJHG2S4lnwCrnslucpAtqQRVW+ZH1fn9B40ajVcx2jTt2f6VhYehm1tdByyOOi
	 lzsxCabMPO4vvaAPH+nD/TWQC9yoJVFFAuLANU68=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E5mebX046157
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 00:48:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 00:48:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 00:48:39 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E5mYcY009227;
	Tue, 14 May 2024 00:48:35 -0500
Message-ID: <f0586fff-c47a-4610-bb31-5a5ad743a1be@ti.com>
Date: Tue, 14 May 2024 11:18:33 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: ti: icssg_prueth: Add
 documentation for PA_STATS support
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240430122403.1562769-1-danishanwar@ti.com>
 <8ce66e56-7f41-4f2d-ac10-1328784a51af@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <8ce66e56-7f41-4f2d-ac10-1328784a51af@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Krzysztof,

On 01/05/24 3:56 pm, Krzysztof Kozlowski wrote:
> On 30/04/2024 14:24, MD Danish Anwar wrote:
>> Add documentation for ti,pa-stats property which is syscon regmap for
>> PA_STATS register. This will be used to dump statistics maintained by
>> ICSSG firmware.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> index e253fa786092..abf372f7191b 100644
>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> @@ -55,6 +55,11 @@ properties:
>>      description:
>>        phandle to MII_RT module's syscon regmap
>>  
>> +  ti,pa-stats:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle to PA_STATS module's syscon regmap
> 
> One register needed? Then use phandle-array syntax - see examples.

No this is not one register only. PA_STATS is a set of registers. My bad
I should have mentioned *registers* in the commit description. Just like
MII_RT and MII_G_RT modules, PA_STATS is also a set of registers where
different statistics are dumped by ICSSG firmware. Moduling this as
syscon will help the driver read/write those statistics using
regmap_read() / write() just like the driver currently read / write
registers from mii_rt and mii_g_rt regmaps.

I have tried to describe this node *ti,pa-stats* the same way as
"ti,mii-g-rt" and "ti,mii-rt"

> Explain in description the purpose of this register in the context of
> *this* device.
> 

Sure will do that.

> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish

