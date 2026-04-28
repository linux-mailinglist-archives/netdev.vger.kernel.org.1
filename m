Return-Path: <netdev+bounces-282145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A8nDshH8WmBfgEAu9opvQ
	(envelope-from <netdev+bounces-282145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:50:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9609A48D859
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0266B304F7EF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C983890F3;
	Tue, 28 Apr 2026 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xs8mugJ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB381724
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419877; cv=none; b=qfuN0DjMj0Xy6f7X1RKlRd/0sXW30m+7rp/tHslFvHvRqVSrccKvM6cOhMYk+Nm9X2ZQGMqznB82w9Or2g3Mj7eMgDqpQ8WlEmZfxsGZvinzJ+oaHlsuROoRofb5uXCAHZfOFXrk2jFGV29F7R2NCTTu+vaXTm4GbtUGbJk6L3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419877; c=relaxed/simple;
	bh=IuxQRiyy0/gNUhVgRVOIcDbTtobF1ENXh8yhyhcBOhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5248if6wdRZHZl28sqRyfVu3lpNGaWclYOFy00zvzwfywNbqig/A0177QZG007Uk975J0BVm+nDiIJL2bIAtZ8nC1N3HG9+8asV5JWKsv/dY20cLL4RoFbTzThzgxf9JJ61E3UL2TRmthMDw8RtuhxSJB5uygDkkeL+92svCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xs8mugJ8; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7baee75f874so104099887b3.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419875; x=1778024675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ca9oYQurQZFQOhczluVtK7t6N6NNGwOw95jCbgCaeyk=;
        b=PmYypU/myhjlJxTvEmBqI4UYZk1BkorCX6OqJPcF8IZJm6wGzfdPnoeK9f7aju5xCX
         mlxkUtJAxo5nvknEN9gAT34fz8f9elJQy9sTV4wsUqcTsYG8SLHkqo39I9eivn8RldHp
         ioy1EZE6y6Vrs7ERZj34XP7VRHcHezV69T/sikyrcnvjhhAZu9QsR/WsYlWX37V7yVeW
         SiMPDbdC1SR+af2/SrPUAbYhLVsBZWM3R1GMWmHbgnY2yyG7AyJi9dcCwylk9xtUXcow
         wh77JX2vWd6qw6LHkAEEA7ZWn8EMo8R4m89M4uPYQUgJk1LGc0i6L95JRHclU1zWJ4Pw
         DDVg==
X-Gm-Message-State: AOJu0YzLtFAn7gcqcqqOk6+Dnu84PStHqAKhWOWexlkgt03Fi1bNyKpB
	8lya2wNaXc7GQFzKJjqLVA2q6h5kL2HvsHpkrqzYcsFpG7YPBYj/iL/CfIKHPr6yTG/PRtXD8yK
	wm77vqlTLtI8+AhEF1kG+QprQoKTEscqtu9x8FRiDpgKhch9+NITm4pRsHzBEDwe0byv/0w9o65
	d0tGdifeU685XlbglkccWQRhnkOrNZA3Uh1ExX5eJqGf9/pqJ3V4h8EerbOEm1Qe1DgwwrdACKP
	+awyKl2qw==
X-Gm-Gg: AeBDiethizp55d9DEOykSm03Iqv9BvFiwhiR5qWvZTeTR9dgkynGc+sHNNVgo61j5zj
	VwFa2ontwVi8ShNO3WXWIOURof2UPeADg1IYk9QN+lkIBX1HsK+bvLNel72htNPrRaJE1G6LbGB
	UplmIbmz46tvg9YCAq2cIlahiv97mkoIItVhJC+U0I2yeKFrKcxBVtiyH7HWOVzhoce73W4bNzi
	ZbTtLnMw0Pfw46Ac5I1pxDKwVfbhtZce403eeRugpto81IBa4MkqGwOkBGzIpkTGUVOFIikasyu
	lvXxJr9rGHFzFVpeyv8qqe3ILPXaA3VIaXOXitxmNjcLo73p4E4eLM9SZ8iB9iuPpi4NQvjrkRu
	wlLm64uf+0zuf1LF5gB6fHT+i6ShE2Rv3GT0jvVVcWlV6/xS4kVIS/u8c0GFz5mcXVn7t2zyB02
	0hh5IsNw2NANu0XJjLcDDJYOO69FBHfBcmAPYVS6Vphl09zgHGqJrfhLSH0fATVTauJQ==
X-Received: by 2002:a05:690c:c145:b0:7b7:c5a2:fa89 with SMTP id 00721157ae682-7bd1d4af257mr17493927b3.20.1777419875361;
        Tue, 28 Apr 2026 16:44:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7bd252b21e6sm440647b3.7.2026.04.28.16.44.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 16:44:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso15708513eec.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777419874; x=1778024674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ca9oYQurQZFQOhczluVtK7t6N6NNGwOw95jCbgCaeyk=;
        b=Xs8mugJ8JokDU4GTjpln4m1T81ldE6bFz4vtqgdiVvZ8j0fXBFJFbHQV95uREWvXL0
         F2mzjdFqMiYTUGUfcnwo19B02X19DF4M4b4AhiofZpUrW7gb3Otv7wxaf5r8CDm82Ifp
         PsfU4zElkHev6E6kghQG3MW46c4QQC1C1Rn9E=
X-Received: by 2002:a05:7301:1003:b0:2e0:909a:b9c with SMTP id 5a478bee46e88-2ed197fe7b3mr832149eec.15.1777419874124;
        Tue, 28 Apr 2026 16:44:34 -0700 (PDT)
X-Received: by 2002:a05:7301:1003:b0:2e0:909a:b9c with SMTP id 5a478bee46e88-2ed197fe7b3mr832139eec.15.1777419873609;
        Tue, 28 Apr 2026 16:44:33 -0700 (PDT)
Received: from [10.14.6.173] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d315sm365718eec.1.2026.04.28.16.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 16:44:33 -0700 (PDT)
Message-ID: <cf01af09-a980-435c-95e8-a0ba4d436902@broadcom.com>
Date: Tue, 28 Apr 2026 16:44:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bcmasp: Keep PHY link during WoL sleep
 cycle
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260428220858.2076469-1-justin.chen@broadcom.com>
 <20260428220858.2076469-3-justin.chen@broadcom.com>
 <cf941a1d-efe0-4692-b627-2dc529ff2bec@lunn.ch>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <cf941a1d-efe0-4692-b627-2dc529ff2bec@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 9609A48D859
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-282145-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/28/26 3:23 PM, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 03:08:58PM -0700, Justin Chen wrote:
>> We currently more or less restart all the HW on resume. Since we also
>> stop the PHY, it takes a while for the PHY link to be re-negotiated on
>> resume.
> 
> So you are just interested in getting networking working faster. This
> is independent of WoL? Clearly, if you have WoL enabled you need to
> keep the PHY powered, but faster networking should be orthogonal to
> WoL.
> 

The thought process was if we are keeping the PHY up for WoL, then 
keeping the link will not cost us anything. But if WoL is disabled, then 
we incur a power cost for keeping the PHY powered and PHY link up. So it 
made sense to only enable this when WoL is enabled. But yes, I should 
explain this in the commit message as to how WoL is related these changes.

Thanks,
Justin

>> -	bcmasp_netif_deinit(dev);
>> +	wake = device_may_wakeup(kdev) && intf->wolopts;
>>   
>> -	if (!intf->wolopts) {
>> +	bcmasp_netif_deinit(dev, !wake);
> 
> So given your commit message, this i don't understand. For the fast
> restarting of networking, it does not matter if WoL is enabled, or if
> the PHY is capable of waking the system.
> 
>      Andrew


