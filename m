Return-Path: <netdev+bounces-236398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EBDC3BD27
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE341A452E3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C04344043;
	Thu,  6 Nov 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgf44Cyz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4z6QpY6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CB341650
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439895; cv=none; b=SXqaaFIMnGxO4mRjofkcggpApUiGuG3J7RzbjFb+8xt/QJOtjQ+EWQsAatn4q4mukQLgceLknmOj+gcdPr19qJ+MOXhS+IDkltkNiVkWO60KBoTJV5yQh5Ud7fYEsvXm9e/0MATr3ZjzJ04oEK1yFdnTHTshIaf7kLqKYOQYjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439895; c=relaxed/simple;
	bh=mcaG189xlcIkE5tjhRnZe+YQe6MUH5qoWIjXSQ5hL30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5hmj4zQMWGflgDs/vaG0pUFZP9WQ6CcVA32gJtplpQicjoPBrxl7RvqmK6qxWz4CPAEjqygc7lLCkJLumcCODNyHFPs/jxDdrswFf3qH1IJzRAB39Ym4N/kGPbs1pjmh+EBG521/m5d+EHbZ50QcOM7xikL7eH6vihYGm+yDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgf44Cyz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4z6QpY6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762439892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ0Mt1B/hGHxx4iD1iA3p/tTogAhoOqLETv0Eaxd5kg=;
	b=hgf44Cyze5IqCap7optA6WEtXw+zRt3Qnjt9fylwzwKmlAh8AfJV9tUX8EBnc8QXb0WGrz
	4xQWfF/9BOp2iv1T/V5WMewLBuoDnALmJ3bE8iQ68bOCOChxvg0hh7lrE/yUOFhgjAbxfo
	2kxypzU+H4z+kJVlRnmmnUFsgwFN9Cw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Dg22u40TPLeuqyXl2T5ZjA-1; Thu, 06 Nov 2025 09:38:11 -0500
X-MC-Unique: Dg22u40TPLeuqyXl2T5ZjA-1
X-Mimecast-MFC-AGG-ID: Dg22u40TPLeuqyXl2T5ZjA_1762439887
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563a0c75so6721945e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762439887; x=1763044687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ0Mt1B/hGHxx4iD1iA3p/tTogAhoOqLETv0Eaxd5kg=;
        b=d4z6QpY6o4+Y3iztxwO6oQ1UXuHaa3H/K1UBQopkqJpFObjPwE7+Z2BNAiff4oOK5F
         FOISe1SqXgCKjfsQzQQ2bwd89ZwOe44tD2IZgoQmGYwmnQdn7oc/uSZRCKOVooRT7SUg
         ewWPVcODme9WVoVIGdsMewsWPXCENFUz9Hr3FNehvmog1P9X3qFslAUuYXCl8EfmVAV+
         zQiyGEXvN6QQKUR8/d/r/Yy7PNmQbwjkmL+ia+nbS9wjiuDvdhhI0NGIJDAdAvNdFphu
         CQfA4QCvqknp1hKyRNBn8T6p2klJol4Ox/yElpBKWm6NZfAZg9paOMNeChT333gyu+0p
         SFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439887; x=1763044687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ0Mt1B/hGHxx4iD1iA3p/tTogAhoOqLETv0Eaxd5kg=;
        b=i0MFH93j1aE6uHCiJCYWZVimc5fiMNPeIYIHgB5Hl796z8YEmUXsb33aPyOY70G21f
         PcB8HdkeYavfK3tlQCzSnsb62iEcuw62+N8KH95fIBJ/lY4EpX+x9LHFu1OmglA2mOzK
         asu+2WIrMPr7xz/WEFZ8p2RWBgomb/1dtKHJhEATmJkeDpimNblXeesnacNSWtB/ZdSX
         mCKVMZiuDKCoN1SpTVqwtxbP/m5vbUEW/GwzxzyDoEqfd/8neYrIX3AbCjCp+gak4qOT
         QFZ+Y0mZB9Gto11YA9co2hVRb84TQNsNtiMdc8QLdfyBKkL9We8LM2GBFCgAz5NOu18V
         pYXA==
X-Forwarded-Encrypted: i=1; AJvYcCXcm9O6PcDRhkwW0QgsE08he7nO+Z0h2zpVbJR88xTjDRIj14868s2rKTcOSIwGDAHBY5qxYZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ZmRw1NitQpvpDT6yV2RyqRypL/rqHdQ8s7kkGzOxS6prd/H9
	p+g0hxs9lJ1u1KeEpQbVrmOAoeXNYKGAyoh38yAU91zw3w5olCq1SrcS4NsHZ61mnG7VJHEBNe9
	o/PnAVk1U8cH4YZ3flUt4CkpFdL+fg0ImnRSooHdsg+RkTByDhjiAypB7eA==
X-Gm-Gg: ASbGncvis2btvXPHBqcXWslPjlou+8HVazH0v8FRxuGtYGp/jWrqmGalQ8lXBg7XV06
	v4BeQ3Ksjd7rKCqUofOpoZOnqunL/3Ixmajszk2y5W+r5MMnA9wK7hBte+UM9BdAZalUIluwJdq
	QHnHX2KsXlawuTkQjWSpXR0bz9mCLfjv06Ce83BfFld2CVLPYg7V6H9onP45IzhFJSsFRCPFTxN
	dD9oGo4Qmr/fjQb8bQ+G5oHRUPDO45yJRPiWfjAD00gTnd3x/dHQYKp9rdLz4SlpJBCv73dD0yA
	TUXnsiA7+VdL0AmubWHWP4sWXWAMNid7w6tn2at7+rO0ABe8yIO+opVg75m78b28clFKXZClf5J
	jMw==
X-Received: by 2002:a05:600c:1382:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-4775cdc726dmr54634415e9.13.1762439887020;
        Thu, 06 Nov 2025 06:38:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwYGaPXsfyXghHHgV3EvN9aRSLllKOcPb1ZAnPIoyOIa32RSLzXlSwU+ogtbRh9YNXBdlyDw==
X-Received: by 2002:a05:600c:1382:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-4775cdc726dmr54634295e9.13.1762439886572;
        Thu, 06 Nov 2025 06:38:06 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776363da40sm48483375e9.2.2025.11.06.06.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:38:06 -0800 (PST)
Message-ID: <df47ae11-5f54-4870-bea8-8392a7fa47de@redhat.com>
Date: Thu, 6 Nov 2025 15:38:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
 <olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
 "lxu@maxlinear.com" <lxu@maxlinear.com>, "john@phrozen.org"
 <john@phrozen.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "yweng@maxlinear.com" <yweng@maxlinear.com>,
 "bxu@maxlinear.com" <bxu@maxlinear.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "fchan@maxlinear.com" <fchan@maxlinear.com>,
 "ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org"
 <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>
References: <cover.1762170107.git.daniel@makrotopia.org>
 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
 <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 9:03 AM, Sverdlin, Alexander wrote:
> On Mon, 2025-11-03 at 12:20 +0000, Daniel Golle wrote:
>> Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
>> are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
>> and Intel GRX MIPS router SoCs. The main difference is that instead of
>> using memory-mapped I/O to communicate with the host CPU these ICs are
>> connected via MDIO (or SPI, which isn't supported by this driver).
>> Implement the regmap API to access the switch registers over MDIO to allow
>> reusing lantiq_gswip_common for all core functionality.
>>
>> The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
>> 2500Base-X, which can either be used to connect an external PHY or SFP
>> cage, or as the CPU port. Support for the SerDes interface is implemented
>> in this driver using the phylink_pcs interface.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> thank you for the patch!
> 
> Finally I was able to run selftest/drivers/net/dsa/local_termination.sh
> with only 2 unexpected failures on a GSW145 hardware (with TI AM62
> host CPU and its CPSW (not in switchdev mode) as CPU interface).
> 
> The problems I had in the past were neither related to the GSW145 code,
> nor to am65-cpsw-nuss, but to the test itself:
> https://lore.kernel.org/all/20251104061723.483301-1-alexander.sverdlin@siemens.com/
> 
> The remaining failing test cases are:
> TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
>         reception succeeded, but should have failed
> 
> So far I didn't notice any problems with untagged read-word IP traffic over
> GSW145 ports.
> 
> Do you have a suggestion what could I check further regarding the failing
> test cases? As I understood, all of them pass on your side?

Could be that due to different revisions of the relevant H/W?

I tend to think we are better off merging the series as-is, and handle
the above with follow-up, as needed. Any different opinions?

Thanks,

Paolo


