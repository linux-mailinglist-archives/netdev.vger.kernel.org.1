Return-Path: <netdev+bounces-114289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7EF9420A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D25C284A4E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5B18A92F;
	Tue, 30 Jul 2024 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM1t/mRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4D149C41;
	Tue, 30 Jul 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368047; cv=none; b=DHlZjCASvfiFp5yzLlA7gp/a1EzqlalfSKWEoK4+HgbxPmh9eynKRVYWfIERp5+2Jgi3CaPYSLE9RvAdRL2c9wDLH6tORzhqS//4IPbBnKZBdnO+zBSG2VAX+NoVNY8pNl0D36WeL6yXA8MEu47xkkD90SIbrBYNlvytNHogtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368047; c=relaxed/simple;
	bh=FhPI3D4Up4mSEqnjxv04I9iXdF1lsYrSVCPP18m8sSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSM8cf6gDcPwVMEam5yP5KEax56q8zDj3qqirL/bj5oCpW8Kejd3CLfrMtZy43sJpvar8tklJt9vrr4PAw1ek9No25QPYsambG+fSI960M4VrewjsJVn+5Z8yI2Snw3OP5f1FAJi3XcvtEL5QZ7XwvriN6qms89TVYUPmKxz7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM1t/mRl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9a369055so553332766b.3;
        Tue, 30 Jul 2024 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722368044; x=1722972844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DimM2qW47D0KGqO+UWvtQPMpV2TxkKC7cbw0eZA/Q9c=;
        b=QM1t/mRlK4a0QJQ4QdjEgIyhmQ0W/tJGqDPDswR3Obg3UqrO53jdp+1PHNO4VUXTkd
         Eo/pDhdN/cf54AvnPjjfuYtMQSafVdXhrM8pPGq50QX+sjnkPELRl9uMDkW9Kuj4ORRz
         mlXyiIfx58nMCPfjqRjCOtFzkZMO4/cMlKaPA5L91bCJz0rjhiIrQSV+YWiCUqXArlVW
         sMYPV3IN9/BKicL6X5MY9+MhbBFXVYAnXFDHvnlCpyaZIMr93SZb3NQKy1Quf8NvIY9z
         IKd4MG5MgXDlDROyYpvmG5HZxznHNoilukkFJv+6GRJiWFVBJZmhafgk8rJ8dF4WEIyA
         0i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368044; x=1722972844;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DimM2qW47D0KGqO+UWvtQPMpV2TxkKC7cbw0eZA/Q9c=;
        b=cvDVVSYtLy2/MHh54awdXO63ZvkorxdlN4XPFXytHtpGoHAgUTXN4E1gvOWzHSEllB
         2KZxFZIabtLmVcl1GMrk9yQqyFyhrMkeOdl/xU9T1xLNyDHq+fCVVgckEl1ByISvB50U
         WFTxlu2SIDIEPouHZAS4rBoFLJCZwKxkTc61Kwz90+bCKIilUMf5/9h7b620jRjG/igN
         4jgEGqccHqjw7ZK5knf5oDfBzLPnPzzc2cLfWUA0rG3mgcr6xPSrLugy7n0RlBqAlxJ6
         0Jxlo39XWj7Ap05hmh3VCwnImZ0ZAXhk+AgUjhDYP0D1f62jOYBhrGXYhtIOAodHWxLE
         G9UA==
X-Forwarded-Encrypted: i=1; AJvYcCUXnPwZmalMBP1ctsn+C1PKTjRPx1kMl2gpLYeZQjOd9/wPzQF9YCdMAZbmkwj/wDEBMefCwABHX8FfM4p55EV0pCwi5bFPzG9knIVS1gWxGEbVZcdeRwbGGIGfBwCvTWJkVuM/
X-Gm-Message-State: AOJu0YwrnfNrffmagBS00zdt6Y6qrExe65Yjwm5xSq4b01VCluGHrycM
	tyvFaPiHP70m1Ljt1C73jJcbdXOU7oon5BbwfeoZ6cTKOvlWD6HyTrczYg==
X-Google-Smtp-Source: AGHT+IEfZ7peEdopuHJBvzjMyJ5jaGJqAaZLzTPM85cTSm/kvvMN0Y3oiQFGcmcCq+6/1tRYt9qOOg==
X-Received: by 2002:a17:907:94cb:b0:a7a:a30b:7b92 with SMTP id a640c23a62f3a-a7d3ff57ac6mr1003605466b.1.1722368043667;
        Tue, 30 Jul 2024 12:34:03 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7794:3300:25d7:7636:631b:2706? (dynamic-2a01-0c22-7794-3300-25d7-7636-631b-2706.c22.pool.telefonica.de. [2a01:c22:7794:3300:25d7:7636:631b:2706])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acadb98dbsm681647166b.216.2024.07.30.12.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:34:03 -0700 (PDT)
Message-ID: <69af4321-6c4b-42a0-b183-9f73bcf479aa@gmail.com>
Date: Tue, 30 Jul 2024 21:34:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 06/13] rtase: Implement .ndo_start_xmit
 function
To: Justin Lai <justinlai0215@realtek.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "horms@kernel.org" <horms@kernel.org>,
 "rkannoth@marvell.com" <rkannoth@marvell.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>, Ping-Ke Shih
 <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
 <20240729062121.335080-7-justinlai0215@realtek.com>
 <20240729191424.589aff98@kernel.org>
 <f43b61ec5e624ae78dc5d564e8735ef3@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f43b61ec5e624ae78dc5d564e8735ef3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.07.2024 11:27, Justin Lai wrote:
>> On Mon, 29 Jul 2024 14:21:14 +0800 Justin Lai wrote:
>>> +     stop_queue = !netif_subqueue_maybe_stop(dev, ring->index,
>>> +                                             rtase_tx_avail(ring),
>>> +
>> RTASE_TX_STOP_THRS,
>>> +
>> RTASE_TX_START_THRS);
>>> +
>>> +     if (door_bell || stop_queue)
>>> +             rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
>>> +
>>> +     return NETDEV_TX_OK;
>>> +
>>> +err_dma_1:
>>> +     ring->skbuff[entry] = NULL;
>>> +     rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
>>> +
>>> +err_dma_0:
>>> +     tp->stats.tx_dropped++;
>>> +     dev_kfree_skb_any(skb);
>>> +     return NETDEV_TX_OK;
>>> +
>>> +err_stop:
>>> +     netif_stop_queue(dev);
>>> +     tp->stats.tx_dropped++;
>>> +     return NETDEV_TX_BUSY;
>>
>> If you're dropping a packet you should somehow check that the previous xmit
>> didn't enqueue a packet to the ring and skip the doorbell because door_bell
>> was false. If that's the case you have to ring the doorbell now.
>>
I briefly checked and this may be a common issue, e.g. stmmac_xmit() behaves
the same as r8169 here.
Hitting this error path should be a rare event, so we could ring the doorbell
always, w/o any further checks?

>> Also you shouldn't increment dropped if you return TX_BUSY.
> 
I'll take care of this change for r8169.

> Thank you for your response. I will modify it.
>>
>> Please fix these issues in the driver you're copying from, too.
> 
> I will inform the person responsible for the R8169 of the issues we've
> identified and discuss what modifications need to be made.
> 
> Thanks
> Justin
> 


