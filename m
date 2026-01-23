Return-Path: <netdev+bounces-252823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJrEFIFfc2l3vAAAu9opvQ
	(envelope-from <netdev+bounces-252823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:46:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82875520
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E23F5301BB9D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7A368268;
	Fri, 23 Jan 2026 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsGXYe7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC131A7F3
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168376; cv=none; b=O9Zq15Dq/+X2ru/a5ctmsONC+Wmf2Hkzq98ON3KSuaWKRvWKEgTH3G8jfxgP12fxraK6n/wBDgApew8eD44KXZKwqbOM0NxF+jBmNv8CNsOxFRQLgj5I/zmtgCSJvbcNgrsckFLkIhPVbv3dp8TePQy6KWcbjp1lrXA5lfUwY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168376; c=relaxed/simple;
	bh=e00rI2p6widiQlsctKINS4f/UURiyMIh4PjZHXw1pN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJanfBLZ8kflP57E9Cc9WyZoZJv87Ps9KBe9Ac45f03usXedsSsG9EYpjojnMutRLTqeTmUDcmgE7shkhdkSCDt27kTahamMaN9uoy2G8vl2/NsH+637uUq7Gb336KVeBZgPcmJoBnVbgmL7C2ubcyIVJsO4S3YPJ9JaJnDK7FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsGXYe7i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso11058895e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 03:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769168365; x=1769773165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dtSusS6wGwWA1byYUxp/fX5EoC6jWFHLf+EUJ4a3Vk=;
        b=DsGXYe7iRqgBGivTpqVZfmBWmXKckpcrhswBOmrTrWLLPjOjgulhYuxYm6928c1gzk
         EcRhd/Dxn+n1FE5eJzJuaqgBTFDsjO84UasZS/ArDDULahkhTX0QPvUSdof6fPSCyASr
         Q/yPs8mryxPVUIwLz39j6W1GtRCRc7cH3zekvmA0lQODTS8foYwupgQyg4KH2oEt++yH
         FZovDZ0gzkk+EXuVCmbIHl7Ko/snFJ39T95Co3B3KrC9RWz/mMt0lHkxvwQFWu6kvz2y
         /NZwApndPT1Icqi6bB9DisGmLng6zmkoZMfqEn9WgNN4GhCDdKVW4HYgvQ6V+zcTjUrR
         kUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168365; x=1769773165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dtSusS6wGwWA1byYUxp/fX5EoC6jWFHLf+EUJ4a3Vk=;
        b=DbWZyAnnHYs6rnb8dTwoObP9QyOWh+39JUR3fxCgJDpNU5C9P/pkNStWFr0WGpNgl7
         BkaoIgLx9aOlM5uk5EVh1uSnx3fnr/cpJNLSr7bQoP+tFdWW+k6p0kRc0WYJMn/Of0k1
         K623UyUlckQkCyDnUYfqbt8N4oVq0HVvMnPk83ug5vhuCX+5TayDf++zSZW0n9z8HP8g
         W+KH6l5wBPOA9PyzTYAHaiijVCw866IC7gDh5MHei5iqxfzppKU1CDGknMWbh4txPMtw
         HS3vncPkbNL0UbE7HdKcuyxnvQlZBZkiWu2HB9icG8ej76lk4YhtzrunmMKohZMkxwYH
         +/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4jgyxX2PLps3YHwLbkLV+fJ8NV1SfSEIUlNRD8CqKiojbeeYP8zggxSVsfLTgvGLCLWo0DPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8fJxCtP4sOW1kWyUSi6i9tn6kdsaAFZ16S4/liYr8c5nZRg1
	iTgUgKxK+TgDckoBkl2qtJo6juSKSBDQKTbmcWFAcTAlJdNYS4XPNXrB
X-Gm-Gg: AZuq6aI7NtUyx6fIq+zIBfuA2FXBHc81HQQCI0HzwbpM4XHckyzEyeIxmHK396rXUzK
	rAp375gANFBYZtdUkhcq0eLCFo3Xw6JysZKNUkX2/sdd/h4TNGt39K6o6kwwPHcDbVeedGA+LyW
	Uf+x7Ozu1gM+BJzMu8xBdZTo3WhTaY1bFosfftOo1+LIf5tv0szkbLpeZZsIO06ReMxbinV0oX5
	qoy/+Tx67HWl2L4pf56T6dJDc2pmkZyl8I21ovmEYYwlKHzioIUR+FrfOKPYJt6GrBuqi9xxS4Y
	zd88ADwYA6lNGvQsFprjjRkvzt7DxcnnfnZ0loELn17w1g75AoSob4uroau9NZumqIxahlDWJnm
	SOceIW83fXy4qErUQVEy8tb8MAk5q2GohqkzttFbTtWDfpCtopdyqnJfHpd+CdJxZtHsgt9kLhz
	luUKVg/Tk16mAcWABn0S/6uGe93lXeWF2vbF0I5xPuD6WUQ+k3Ju+HPQI2oKkQM1/ThkhXsosRC
	7QTv8NRyeEehhelg/9ractGmqtgmH6yw06wQPaHRrrK+hSzl8M=
X-Received: by 2002:a05:600c:8b09:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-4804c960f04mr46598715e9.16.1769168364642;
        Fri, 23 Jan 2026 03:39:24 -0800 (PST)
Received: from ?IPV6:2003:ea:8f45:2d00:ecdd:bc87:ed5:6183? (p200300ea8f452d00ecddbc870ed56183.dip0.t-ipconnect.de. [2003:ea:8f45:2d00:ecdd:bc87:ed5:6183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbaadd0sm18881215e9.11.2026.01.23.03.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 03:39:23 -0800 (PST)
Message-ID: <66f110ca-3a49-46fe-a996-c5ad477b8f4d@gmail.com>
Date: Fri, 23 Jan 2026 12:39:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: make PHY fixup support always built-in
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <800595c6-496a-443e-92e3-37251195e610@gmail.com>
 <aXM96CNzkiSIPukf@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aXM96CNzkiSIPukf@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A82875520
X-Rspamd-Action: no action

On 1/23/2026 10:22 AM, Russell King (Oracle) wrote:
> On Fri, Jan 23, 2026 at 07:50:20AM +0100, Heiner Kallweit wrote:
>> PHY fixup registration is used from platform code in init phase only.
>> Let's move the PHY fixup code from the modular part of phylib to the
>> always built-in part of phylib. This allows to annotate the fixup
>> registration as __init.
>>
>> phy_needs_fixup() and phy_scan_fixups() wouldn't have to be moved to
>> the built-in part of phylib. But doing so allows to fully factor out
>> fixup support into its own source code file, and make struct
>> phy_fixup and phy_fixup_list strictly private to phy_fixup.c.
>>
>> phy_scan_fixups() is used after init phase only, then phy_fixup_list
>> is read-only. So we don't need the mutex when accessing the list.
>> Also when registering PHY fixups the mutex isn't needed, because
>> fixup registration is done sequentially from platform init code.
>> Actually there is only one platform with more than one fixup.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> What is broken today that needs this change, and why haven't we had
> reports of breakage?
> 
Nothing is broken, otherwise patch would have been addressed to net tree.

Recent removal of the dnet driver removed last fixup user not being
platform init code. This (and considering that PHY fixups are a legacy
functionality) allows to:
- factor out this legacy functionality from phy_device.c
- discard half the related code after init phase
- simplify the code (e.g. remove mutex)
- use modular phylib on platforms where fixup just sets a flag,
  e.g. apx4devkit_phy_fixup() in arch/arm/mach-mxs/mach-mxs.c.


