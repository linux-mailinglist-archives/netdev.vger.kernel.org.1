Return-Path: <netdev+bounces-251338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B12D3BCF1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4771F3021047
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F823A99E;
	Tue, 20 Jan 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX5ryuac"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23222A4CC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872890; cv=none; b=Sw/5qMGqQanKlp0jDxybzWYdLig75byNfwaMsqn6EMMNg/OMU+NNNfShQovqumm6uRALfI6OjpMzLIVZuh8qy4VDVsJ4h4e1ohJv6ljj+Ckv/QUrRYyevrfls27DD5yL20titSX4QSnFSSwZFC2GHCZe9nLxrqbOkjw/5V11lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872890; c=relaxed/simple;
	bh=1I0hYB2Z1ZSz2CEv0rmui0vLDSp/UK+vYwUnat+Zg00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXB3Yu+xG6OBGFt0Ec0g94DzS6eh+mDrNgMvWIJt9mRcclo7lLJXZMdT1PyGBh+eSgSRzDHH+cZev9SXtOG1ClheSOhaputjTfAQK348QC5EPGY+u+/a7DjCWDGEJxSbH5tfBm1SnCfL4zHJAFf5YzyY98MWQInVTdDQQmpjDdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX5ryuac; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-352c5bd2769so73949a91.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 17:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768872889; x=1769477689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrH9sDwa3QtPj5gSU1d7cy8zDFpQYEGB5vrm976c5QE=;
        b=SX5ryuacBAyon+/mamd9tOhqqNmBb9km+ZSZmER02XBAbhiiBTfkPeRGMXVPhEGzPT
         uW5XAcanzd50N9dXzRklTT0QYmj1mGisIy+k7eRV/0sT9D1BFr91qXSocfE/PqEMXUUU
         sKaL1/fgFqimYIkaG/w1MKb0EnKPKOhVtCeVkNhh1IqFF/EAvzdtz7vqtz8fvLbWosfU
         zr/8WvO1RO5pvQiW7WeTrdyZdnv2q+S3TqNVP9rbt9dNnWuLvf5v2zeVN5caK9J/LV0c
         UXb37p5hmjCNxqh32fsAn4OmihpLp66jiC7mioQxeK6FavjIe/6KWJb+a4Iot+DhL2xn
         NXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768872889; x=1769477689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrH9sDwa3QtPj5gSU1d7cy8zDFpQYEGB5vrm976c5QE=;
        b=C8Mn//MbRzM04UaAncpHfSfnsOMGdsEivvNDgO8vUv1kUBGOq8ejCpU1CDrOg0QOmv
         7PfdSPI67psYyCYCMcHKfOSEqk0m5pOyVU+sFOFYQoauKOaN9VKdV/eyl6hOSdqajdyr
         Sl2bi2TpTWje3o5P00JXaqBGGeJg9DXMJVvxVHHroMZIoQDA0z1af+9YGbD1XjSBgzHX
         ldMf0VuY0Z0xm1SHcBVST7TOHZc/JNVlYFeL0J1AmMEfPb1tH0umVw6ktU89Wvqb0O1d
         2BtqMFY5jojqdo0AdTJW94LvfeISPJrBkScWK/PgPt9UPrWNSTSvG50jbLBnIIo+2oLh
         Rj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4RzL/IEIRfrf2WpfOr+JpDjRyVS4DMnX0XB1OcFiuaZWQY1aCvJcLDO2DkkJAmW5a4bmDHbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTKRRYaJjz9LCEogdSgFUxs9Z34r0ndgvmtRnc21lDU7LKVil
	6wH+6gRbpAcVomE3U3NHaWe53FY0gt1bdiVMXB3r17S3sYCLIUFnZET0
X-Gm-Gg: AZuq6aINDGgtoPJi8S/b2sJcr3vXD7R3s6JpHLWcqN3+tc0loAGSfZr5sPdPc87TL2M
	v6U2r5R4EVisY0sv3Ut2EOLhhODijCn8k4DIkJu/GOFin0uxYOzMOm3eUJR+kcpgxJ4H5Ty3z0Y
	f9/au/k+5kBnHtzHlro3zM4KIduuj0rB8MrNmURN6vqN2EhtWdeFHUa6QN0dKaIULcEbfjKjbiB
	i84vUl+5Oj0rcLie0a5HfvOdXZRtBZTx1t0vekv6YbE1gAHtBJz2uww9KU5IH/X0S5LgVyoTweo
	VEXQc9GBZt6wkgfXVjNXhAXl8uQYen1F9u1oACHuq9aXznxyzQPg4QeMZ5IIAB4GgAWrLmWxegh
	UxEQ0cMW49GsRGH4iz89NRb5itvCRUrvJ2unJOUKCmSyFqx6W3HKMellgFejKbYTMOtz9i0dEdp
	ItFHlukpbD/BDjlY563qTeLOROyWQkaULSb6VfYdKJS5gVNQBvQ7R3blnzJYTwkm4gvPQqkpmea
	6Y=
X-Received: by 2002:a17:90a:c110:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-352c407a272mr335012a91.23.1768872888766;
        Mon, 19 Jan 2026 17:34:48 -0800 (PST)
Received: from [192.168.0.102] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ca9acsm12931529a91.1.2026.01.19.17.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 17:34:48 -0800 (PST)
Message-ID: <a5cb949f-34c1-470c-bd04-0b35c249455f@gmail.com>
Date: Tue, 20 Jan 2026 09:34:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 2/3] arm64: dts: nuvoton: Add Ethernet nodes
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260119073342.3132502-1-a0987203069@gmail.com>
 <20260119073342.3132502-3-a0987203069@gmail.com>
 <04df4909-4fdb-4046-917f-2f2e47832c62@lunn.ch>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <04df4909-4fdb-4046-917f-2f2e47832c62@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andrew,

Thanks for the clarification.

In our design, the Ethernet PHYs are located on the base boards, not on 
the MA35D1 SOM.

The SOM base board routes two RGMII interfaces from the SOM to two 
external PHYs on the carrier board.

On the MA35D1 IoT board, there is no separate SOM and carrier board - it 
is a single integrated board.

I will update the DTS accordingly so that no PHY nodes appear in .dtsi.

Thanks!

Best regards,

Joey

Andrew Lunn 於 1/19/2026 11:22 PM 寫道:
> On Mon, Jan 19, 2026 at 03:33:40PM +0800, Joey Lu wrote:
>> Add GMAC nodes for our MA35D1 development boards:
>> two RGMII interfaces for SOM board, and one RGMII
>> and one RMII interface for IoT board.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   .../boot/dts/nuvoton/ma35d1-iot-512m.dts      | 12 +++++
>>   .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 10 ++++
>>   arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 54 +++++++++++++++++++
> I'm somewhat confused with your naming here.
>
> A SoM generally needs a carrier board. So the SoM is described as a
> .dtsi file, which the carrier board .dts file can then include.
>
> Where are the PHYs? Sometimes the PHYs are on the SoM, sometimes they
> are on the carrier board. If they are not actually on the SoM, the
> PHYs should not be listed as part of the SoM.
>
>       Andrew

