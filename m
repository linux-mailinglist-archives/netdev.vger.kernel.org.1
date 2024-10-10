Return-Path: <netdev+bounces-134147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A12BB9982C0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F75B282D9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F671A0AF1;
	Thu, 10 Oct 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvGtc7rx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FD33CE8
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553673; cv=none; b=m/tL9kilMScJOjjIAbPWAKjHK3hMswZ3mM5JMpGfrsvf/2HB66D368H+i6O6PncRs7eIILibn/s/mOb9q85hFwoltXybqllBebCAuaWPX95Sh2pmg96albKYEYY/HOb6PU7grWxjRlqMMYJEv/tu4WDfrltME86dPFJzUe6PcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553673; c=relaxed/simple;
	bh=Q9NcM+0y9Mj8hejQEG+Gp9K6oieZcVvzTgIWfpwquaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgmh1nWMmAUQ1kY56IHsW0r504XzQplIlBGJMByP7jp/i0oNpeemKR0O2qm1n606X/wgI1DsTuGlCXuHTAYjEryUAftikEXBeb4LEKSFLl7ejT3cLb7obM3e0byXvIHAW73lOKQ0iPBETbl5/cdnlKsHtpOSsfwWfCsDCgYMCrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvGtc7rx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728553670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlfUSD4fluJGFd+3+HUe6Nvf85IYNmfQTynP/z7jIcI=;
	b=YvGtc7rxhgUVccwXbwGXRM5OCn2z1FecA+a8bHyVqlciU5lV8B3TPUXpLFIXnwkEIsZmoM
	7iwRe5Kl8jr8WAADN33pY6KLtE9FnGEuB/Xq8VeIUKCqYWfU0x4okT9Yk0rYc0haMvIYww
	G1mBCufo0Mx6GA1dnmJkDQEs8zO7Gac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-mkFfjzPTMcCepIMuDbE8lA-1; Thu, 10 Oct 2024 05:47:47 -0400
X-MC-Unique: mkFfjzPTMcCepIMuDbE8lA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d49887a2cso360121f8f.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553666; x=1729158466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlfUSD4fluJGFd+3+HUe6Nvf85IYNmfQTynP/z7jIcI=;
        b=bpp9HwRHCac1wnHs1VaE9G4UJPsNettGTp+r9QOjAY7Wy8bRLjEg0Hg7uXesuENe2V
         M3haMFNMSMDCysV88cqjisUKinMnnSRzMQ19RLNFbdIZkExFffnwmnneTiI3v9SjlXyH
         T+qQSuDVfEZVcYGqhoReEe3VKNIF0Y7wDtnPdngUWUf4W6GQK1kYW5OQ3OCCzJf8bMIh
         +dkbKHs2ULfXkjSCoBU/cjjADxlRXh6PbAXSuyz+LJ4ar6uWEvRpPwN52+nHq7JelYxM
         cNq+vEnxOhXuW0G1K+wQ9zISXbLRT9kGQcl3XBGmGjgBBlft33SBp3jdnCOHDthr/mWB
         AcrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWUsLg+y8l9EZxkXbLtjKwjKEyVBNkReHMab01qUYXhpWzBLcrG6PmChzj9ce1EaNTVuHyxdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJp22Q/ATi/cTyN5RCGhPc/5Wp4qy89EiMHE9ijiuMPaoTGQZK
	wdk/abTk9iZaIZyGPtLd59XIF5UmJEVpQLffVoZItOhmXWtngn0M2jQZDwRHI/LtY5pCJo47XLl
	CT8WTwHLNsr5Nki2FHM7BcSTikR1xpLpk4hWQvqYBXSl9cS+WwgwXIw==
X-Received: by 2002:adf:f00b:0:b0:374:c692:42e2 with SMTP id ffacd0b85a97d-37d4816552fmr2357489f8f.9.1728553666525;
        Thu, 10 Oct 2024 02:47:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6BvFXoHtzwsbDsBb3oWUypHolSIJeTy0/OIxHk/x5JzCJDp3ddyAA1GQ9vaB+yIOF9RLjjg==
X-Received: by 2002:adf:f00b:0:b0:374:c692:42e2 with SMTP id ffacd0b85a97d-37d4816552fmr2357470f8f.9.1728553666135;
        Thu, 10 Oct 2024 02:47:46 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4674sm43606645e9.38.2024.10.10.02.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:47:45 -0700 (PDT)
Message-ID: <8c690df4-dabe-47bd-9f40-dde8df2cea79@redhat.com>
Date: Thu, 10 Oct 2024 11:47:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
To: Vladimir Oltean <olteanv@gmail.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241009122938.qmrq6csapdghwry3@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 14:29, Vladimir Oltean wrote:
> On Tue, Oct 08, 2024 at 03:41:44PM +0100, Russell King (Oracle) wrote:
>> With DSA's implementation of the mac_select_pcs() method removed, we
>> can now remove the detection of mac_select_pcs() implementation.
>>
>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> ---
>>   drivers/net/phy/phylink.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index 4309317de3d1..8f86599d3d78 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
>> @@ -79,7 +79,6 @@ struct phylink {
>>   	unsigned int pcs_state;
>>   
>>   	bool mac_link_dropped;
>> -	bool using_mac_select_pcs;
>>   
>>   	struct sfp_bus *sfp_bus;
>>   	bool sfp_may_have_phy;
>> @@ -661,12 +660,12 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
>>   	int ret;
>>   
>>   	/* Get the PCS for this interface mode */
>> -	if (pl->using_mac_select_pcs) {
>> +	if (pl->mac_ops->mac_select_pcs) {
>>   		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
>>   		if (IS_ERR(pcs))
>>   			return PTR_ERR(pcs);
>>   	} else {
>> -		pcs = pl->pcs;
>> +		pcs = NULL;
> 
> The assignment from the "else" branch could have been folded into the
> variable initialization.
> 
> Also, maybe a word in the commit message would be good about why the
> "pcs = pl->pcs" line became "pcs = NULL". I get the impression that
> these are 2 logical changes in one patch. This second aspect I'm
> highlighting seems to be cleaning up the last remnants of phylink_set_pcs().
> Since all phylink users have been converted to mac_select_pcs(), there's
> no other possible value for "pl->pcs" than NULL if "using_mac_select_pcs"
> is true.
> 
> I'm not 100% sure that this is the case, but cross-checking with the git
> history, it seems to be the case. Commit 1054457006d4 ("net: phy:
> phylink: fix DSA mac_select_pcs() introduction") was merged on Feb 21,2022,
> and commit a5081bad2eac ("net: phylink: remove phylink_set_pcs()") on
> Feb 26. So it seems plausible that this fixup could have been made as
> soon as Feb 26, 2022. Please confirm.

I agree with Vladimir, I think at least expanding the reasoning in the 
commit message would be useful.

Thanks,

Paolo


