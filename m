Return-Path: <netdev+bounces-242380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC931C8FEF8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478C73AB28C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5922F547F;
	Thu, 27 Nov 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="D+70OC6s";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="KvgjOPa8"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3B2EF66A
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764269296; cv=none; b=Lf+gSoh0mxLI6QZyRHqGmvZI5JBsud9SBuvdmdo7D+a6nDa2nKtiR2GCuu5Uz5XfrTM9bsBKBJHp22YRTJopx06HH0RHPmRL9wLWeOprB0av2YXOqQsuMe+oUctk2J5C8/fgomcu0f9SWE/uIaroyXpKaqkqQz9Zj2aknqVTDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764269296; c=relaxed/simple;
	bh=AKd5JruA5dOQ9PJ/Iru1lgxyPoKrrAoOhG3sq5bddFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kc3EcbXx9z9SMnPStYAuXVnQdjgmN/CUWR/ZzckVBsZn+0F72dNW7cDld1gtr7JF+QPck6U2iqa5/8fPkaOlSXEfsecbXYg//RDEcaHJB1fCiehUnp4fqoqrxLiO/e9nYlX9+B20xrRqZpEEdP1v6tJW2BQzhBcRtEa5fmz3GBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=D+70OC6s; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=KvgjOPa8; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764269292;
	bh=AKd5JruA5dOQ9PJ/Iru1lgxyPoKrrAoOhG3sq5bddFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+70OC6sh4Rk5OsY10NpZ5IKDjuu/Fje9W6WO10IrTE7Svam1Bf+Sy3mbzA+zbAho
	 tbRUgNPKvqYYLFY8vFlGAYDaQB2AUradTqAaoYvBBSK3WGthG9N6WYvCLGntcUOf5t
	 gLUrIUQ0lQ1zFpWOcDvDBbpw10tSiEsugruQMeUbveIjfDwFnmS+mbo9XIEvdJSfPE
	 mymx3d7FvKnty1qKO3jmkTuRePcOsWpi+4TmkrWbAbzJBf1IHKfZtDBQPSurIKaixL
	 NU96ocCoAgfd6w3i18KUYDNs2K3q2+IZufmBWfDkbqAGRp0BdRLrHlmKXJWBMLyy+c
	 WPMHK8ySP7UeA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A28BE3EC03; Thu, 27 Nov 2025 18:48:12 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764269291;
	bh=AKd5JruA5dOQ9PJ/Iru1lgxyPoKrrAoOhG3sq5bddFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KvgjOPa8Tuor2T70vwcknQEVn9cstC+C9lvXNc+MESk6Mqnq0n8hYcw4FWfBOPgYc
	 Q6ROQYFKWHYCn+81WW9ExML1cuTHqTv8Umdb81FtG+FauvI9LxGapcRw74KeRLa9n8
	 IT1QWMpjP3vUrtNbYPCGkhErVjCZPgOeawDJ3yo/y5SgM5uZ5r5QeK17nOm8LHIQdE
	 bfw9t0dF9cnyBuHfkGGZHWSkzdx6eyU0gA98QnJZNIBAp+VWkyAep9eojybfKGirRf
	 Y8FaZO3U72mZh+i6ABEpttDgHhQW0mMMLgfDmdB5DH1P9bkvDN48ZRaTocsVRa4hqc
	 LaolrHES4vJfg==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id A099A3EB6E;
	Thu, 27 Nov 2025 18:48:11 +0000 (UTC)
Message-ID: <49020773-43bc-4c46-8f95-a5436ca78891@birger-koblitz.de>
Date: Thu, 27 Nov 2025 19:48:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rinitha S <sx.rinitha@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
 <20251125223632.1857532-4-anthony.l.nguyen@intel.com>
 <20251126153245.66281590@kernel.org>
 <93508e7f-cf7e-40f6-bf28-fb9e70ea3184@birger-koblitz.de>
 <20251127080748.423605a3@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20251127080748.423605a3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/11/2025 5:07 pm, Jakub Kicinski wrote:
>>> link length requirement isn't met?
>> The ixgbe_identify_sfp_module_generic detects SFP modules that it knows
>> how to initialize in a positive manner, that is all the conditions have
>> to be fulfilled. If this is not the case, then the default from
>> ixgbe_main.c:ixgbe_probe() kicks in, which sets
>> 	hw->phy.sfp_type = ixgbe_sfp_type_unknown;
>> before probing the SFP. The else is unnecessary.
>>
>> If the SFP module cannot be positively identified, then that functions
>> logs an error:
>> 	e_dev_err("failed to load because an unsupported SFP+ or QSFP module
>> type was detected.\n");
>> 	e_dev_err("Reload the driver after installing a supported module.\n");
> 
> Got it! perhaps add a note to the commit msg or a comment somewhere to
> avoid AI flagging this again?
On second thought, and while thinking how to formulate such a message, 
maybe it is cleaner to set hw->phy.sfp_type = ixgbe_sfp_type_unknown
explicitly in an additional else. Otherwise, if the context of how 
ixgbe_identify_sfp_module_generic is called could change in the future 
and then something unexpected might happen.

I tested adding the else and it works as expected by not doing anything, 
the variable is already set to ixgbe_sfp_type_unknown. And I also 
verified again that the current patch is also correct: I made only the 
length-check fail and indeed the default kicks in with the correct 
outcome, that the module is unsupported.

Since the patch is now submitted in a series from Tony, I guess the 
decision is with him. I also am unsure who would submit a fixed patch or 
added comment and where it would need to be sent to at this stage.

