Return-Path: <netdev+bounces-110005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0D92AAB2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155B61F220C9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E83BB50;
	Mon,  8 Jul 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UIsJfUIt"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707ECA29
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471364; cv=none; b=CCXNNmkpKvt5C05s+4S/slYFrBqJ0h9CwIxSFVb7bOT6iqF/gPsC5HCEPFN4I5s2Yf2XLeNPwOmCQZqU+sqbmBkZ3Cy2trR+8LqWGwifZV5HGcTwtIrgep1Ds7+eNYas55LmnMfWZNP4LMTcHo0PX4PsF1PAO7jt7LKGLgevgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471364; c=relaxed/simple;
	bh=f+q27AlPRDqvzLkRqiLRbnT+quV6jS+8qQej2+TsCi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euxDWmlKlsjI8a8YosTpPubqfxX8Uuh7h3aogAmINM8O3rddAMIyXOLNTswY1rxohjeWCXuA2uSqehEXwnd9lVUFfEt44+Z5akhrLpsu2ASmON1FZreQyWzCjMuFWK1pUsFCAU1Z7rf0WqpQ9knkGsXFe7rF/SplyRuSQQMEPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=UIsJfUIt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D47892C0372;
	Tue,  9 Jul 2024 08:42:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720471358;
	bh=/NOCrbSnsRAxGpPXpZU2kVbcHcKy3y55rBxxnjuQfRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIsJfUItSt13loZhXdVCCkYpf3WKZ0JorEgPRrZquG9uHUKAKE3OZmtZco0nrckIB
	 SIjDoM7+BsejSRijczsC7E40nvzr54jNTSBNw/iiWFw3Kr0oT7ZS40Dmtj1DAZRO0F
	 AgMPc5/RE98xrFKzNmATAuB5rRZjeCbe13hy61kf/wvQSEjgzLOeAyY5eFC7iqyiK8
	 NFPJInFQCwSJe4wY1Sy7IbwKd0yhAfLU0bnzaH1xbkZ0mYaezF5Io7N38eRNW/idOo
	 cBRKeVArpmnBcR6hyWg+b/XqbLnxlnNlbwEmjjRJ/4cXhy+9wEO51Wy3hQ1Ctwl678
	 7zBy8NYu37PUw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B668c4f3e0000>; Tue, 09 Jul 2024 08:42:38 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id B841813ED5A;
	Tue,  9 Jul 2024 08:42:38 +1200 (NZST)
Message-ID: <16eef908-3e80-458c-9e20-f29932298124@alliedtelesis.co.nz>
Date: Tue, 9 Jul 2024 08:42:38 +1200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: net: dsa: Realtek switch drivers
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "luizluca@gmail.com" <luizluca@gmail.com>,
 "justinstitt@google.com" <justinstitt@google.com>,
 "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
 netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <20240708142337.y5rwdxijvfnqftnh@skbuf>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240708142337.y5rwdxijvfnqftnh@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=668c4f3e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=m6f3igmo_ZS-6taM_LMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Hi Vladmir,

On 9/07/24 02:23, Vladimir Oltean wrote:
> On Fri, Jun 14, 2024 at 01:49:35AM +0000, Chris Packham wrote:
>> Hi All,
>>
>> I'm starting to look at some L2/L3 switches with Realtek silicon. I see
>> in the upstream kernel there are dsa drivers for a couple of simple L2
>> switches. While openwrt has support for a lot of the more advanced
>> silicon. I'm just wondering if there is a particular reason no-one has
>> attempted to upstream support for these switches? If I were to start
>> grabbing drivers from openwrt and trying to get them landed would that
>> be a problem?
>>
>> Thanks,
>> Chris
> What do you mean by the L3 switching functionality, exactly? Offloading
> of inter-VLAN routing? Or routing offload in general?

Offloading of inter-VLAN routing. There's also some multicast and qos 
capability too.

I gather the general idea is to provide mechanisms for the hardware to 
accelerate parts of the forwarding plane. I haven't got into the details 
of that yet, my first set of requirements is just around basic L2 
switching which I think is pretty well supported at this point.


