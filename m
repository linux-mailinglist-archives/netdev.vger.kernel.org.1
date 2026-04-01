Return-Path: <netdev+bounces-274206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AXlCAhVzWk5cAYAu9opvQ
	(envelope-from <netdev+bounces-274206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:25:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B196837E9EE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C956B3012E47
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B331F43CEE4;
	Wed,  1 Apr 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GBMj890R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FA32E143
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064261; cv=none; b=Pn7Tsz9PYHr7QSU0liRTSk1KA/ODdG2Z1B8Wt4AQ7UIzTtsR54ngXiC3Wa1r3vxaGSGqPdwGwRKX+TSQDjDhdnWZWkXFfBPoiFOj85UJ0EXIJJiPy/zXWYoJpqdSyyhV6F76AiyD6dgoZalrsuTGIp+M/aNMBaLZAaTJv+tqnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064261; c=relaxed/simple;
	bh=qVQKVZBz0MTMXXT3L8jbh8ljE7dPEalrrjj2yneqMsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTSmgmZTgyw2jA0DoiPILuwTPzhHCSNrYleahPzct0Sijx2SFjaY1tanLErCc3GACDKO4UMV9+tcWBRLCPRgLdvz7/fJ57zNZjm2fN5sZ9iIrV4WuyzHzLtWQDSkLrwWNmvUJ0HtrLip8Uxm0xGlOKwu4VfJSa8qd3moTJtcVIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GBMj890R; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso12724845e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775064259; x=1775669059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKU2ZunSRFR2nbe/LptJhAukoIHGjJ9ZB7qHKKyexwI=;
        b=GBMj890R1gWZ/l8kdU1YtVddQ6nkeWETFJiAYLh/EWgEqDoBiRQe15/VgGLiHfcnYg
         IWrh736cf+85LRQcpdEfRWxN45dbDx3Yyf1S63amcH3qeXP1zwM4R14dd/wvuyNb5+jF
         rgIfowthu+4uaBzllPNd8eiBu1zY+R9ufSF6so7MLDLJhKjN4m8MUi6H3FRuVeHgyU8U
         QYSp7VPt6zJZwLi8nGhmqrgtG+7DzIF/lxUXzNDtJbEJRJCQimVFCjTiq/bfQ1KxMzgq
         rxMOAKGZvFeYdnQGZHsIrsdR/uWTiOCW2O60lx9kQbqYVAG09vOPCwvn8aCQUdAhOd6x
         oiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775064259; x=1775669059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKU2ZunSRFR2nbe/LptJhAukoIHGjJ9ZB7qHKKyexwI=;
        b=OABhuxZq2zadX9PYOhR1PQCC1RNOzMkMc2ct6+5h2QMBnYBnTZywk8JtMHkSyq01c1
         u/EhCXbM6qk6/c0rbheG2Mb2grGxruAwBnFA4aM7VCjROQmjNAlTRG1eZLfmq//W2N6q
         byz2pYSmRd6mbXjEDkKs0/JqJ850zY7Dyh9T6l40i1Zmov64FBk6GT8ImCvmzEtPLqy9
         +oNrvM+qGVFPO/j2rULOsu2jVWUt85NTn2xPO3eX6MFWz+RnO2zzJPQ+DK2h5ec7ZZYI
         V/Oy8rmD5em3qN743BiD1WcUbfyIo+7g8d6FLKNppMbB1gnWYDk6JoyJxAadlK6VMU6o
         rZ4g==
X-Gm-Message-State: AOJu0YyULYPPhjwOo1J448RWMlcsQ+E/0OTF/RCrbmDs5ypMKcrvPN2l
	FvzCRvXNjMNQ5AKEihQH1am56GgWq4d3fodVdRDDoZBHQxZGu95Helt9aHd2Mh8livI=
X-Gm-Gg: ATEYQzxHJRYcNpaY3+1hQiIebXO0eGM2sh0qAePXITlBUzB4BQgi+vBi+AkNeza8Vwo
	HOzwFkEkcOe5kHY2tDmbRxxoLijgeSccZ+EdYqaXlkTRVYGeSWvIgXKEVXDLmnttSFZGYd9pWa1
	Te8LP9i7LBfB8GeVUW0raxmwBCUin9H6TVK7T1o/ze17iDlJ7Ijs7JwfCskTtkkoPRKdZY8W6Sl
	RqfWaiS5JV+YukV+eQYCXvuvtBVcMrVbZTysbi9iBt5G5KDDYT6belD2/kUX2pKamFVBa9EfD8V
	DH0aIeKzkA/w2hVwYZ1fqVLJbEZW+JtsjljU715d6C/FW7T9sXW/K5RYRiLVGKFevofjcWV69tx
	h8tJ09/t0Bt6UieoJJRZ6/zpsJm7Xl+DA8wwvm6uxV2O8PXonYJvIEIoYiTHVxmKFM9KxJiwobo
	wYK/QCfNEa2hnjHDE9R1LZN5qK9E15NyCxU+B0VY1Z2phFKZ5MbuQuYFI7g6xhVC6nzjfQsr4WB
	iQ=
X-Received: by 2002:a05:600c:450e:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488835d17edmr74956605e9.14.1775064258714;
        Wed, 01 Apr 2026 10:24:18 -0700 (PDT)
Received: from ?IPV6:2001:a61:1391:2f01:bda6:de6a:c701:93e? ([2001:a61:1391:2f01:bda6:de6a:c701:93e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc52b2sm48393685e9.12.2026.04.01.10.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 10:24:18 -0700 (PDT)
Message-ID: <8fe179bd-417d-4624-9e35-04c75978dfc8@suse.com>
Date: Wed, 1 Apr 2026 19:24:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: usb: smsc95xx: suspend PHY during USB
 suspend
To: Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 piergiorgio.beruto@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, steve.glendinning@shawell.net,
 UNGLinuxDriver@microchip.com
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
 <20260330134222.67597-4-parthiban.veerasooran@microchip.com>
 <1c660862-de30-428d-a772-8bee9b990a59@suse.com>
 <2e9bc390-c870-46a3-b673-c7cdb5187cc3@microchip.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2e9bc390-c870-46a3-b673-c7cdb5187cc3@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net,microchip.com];
	TAGGED_FROM(0.00)[bounces-274206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: B196837E9EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 01.04.26 05:18, Parthiban.Veerasooran@microchip.com wrote:

> Thank you for pointing it out. I agree with you. I didn’t note it
> earlier since the issue did not occur during my testing. I will move the
> phy_suspend() to the appropriate place.

Thank you.

>> And, as a question of principle: Why do you suspend the phy
>> in suspend(), but take no action in resume()?
> 
> In resume(), I did not call phy_resume() because the resume path already
> invokes phy_init_hw(), which internally calls
> phydev->drv->config_init(). This reinitializes and reconfigures the PHY.

Thank you for the explanation. May I suggest that you add a comment
to that effect to the driver with your patch? This needs to be pointed
out. Your code as such is fine. It just needs a comment.

	Regards
		Oliver



