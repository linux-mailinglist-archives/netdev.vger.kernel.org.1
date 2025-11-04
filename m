Return-Path: <netdev+bounces-235568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA00C32742
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81323BC0E8
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C88F33B96E;
	Tue,  4 Nov 2025 17:52:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24632F77C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278768; cv=none; b=aYEamsp4+U6LEIudY7Z0EhI+X6KmXsSZCEHaE0wta6fX90kXmp0qz9jV3SAxe4JupSsAwgjrsYRLMgb1x0cz6e/ylcOcFkXLl32uQOEujNExoKC6/z3QGGRz0oHpipQtLDzWvu21f9+oP4cXa9eyPtkBy9j3ArGxG4x8+HoKfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278768; c=relaxed/simple;
	bh=M3XGml+8+ve3rsexdBQyTjM3q8Kmjfd/ND3yvhWe8PQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RFqonVCyvsVwCNsU70CSCjfugfCE7+OIJE0SIzY3AsubNqj9+ZwXzeMXs5e6V5NIp0ig2WZT23YSTNqKqbs3eEg+qs5aNsbkFdexGpPRveA3b3YLE56zd0O12JieEjsB1sZ8HDSe+KnqLQmFyLc57CdVm5lacO5ATctEvwFSXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4332ae73d5cso20858955ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278765; x=1762883565;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpFOGuPutw7wJGPq0GSLdfYhbwZhDvMJew+wME/lNf4=;
        b=NNHs7gtj2jVsNu3Ry0PVikNS9e1DmJAqejGXGOIJjrn65P5I6KwGZMSwl/8eKAFcor
         H7VK8es3I8uB1G0LR4iHrU24oPKuL3h8RxXb7uCn7ebw1tXo0UtyglxmtVNp5WMunaQY
         5X4uNWqD4/YphYWkbp0iPPkEldYkD5SypwNaeT1n/5C+xvkPFnDDSMj5gXDt3J/Yp+3a
         DXx5F2NgX3EtntOXShTYTfSEA2d8Z4+NRAAK2fcCn3XpRW0E9Zvyys0ZUOwuh5ziIrKk
         qBZSrjde0hAIlTN7D2W1pFHKjNfToCz0kxF7ll6SNNbzOA+LjnNJpjwgyCIMyf7g+Mey
         k/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNQe+Qmg/iZlwbAnvgEMuQ3I8C9J6FwIpa6bdiBDyN8Tot3e/LqvEgJ/lS5FQkxEfHZXJdGmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdymGqpfAC82vh/nqsl4UE2bomBvNNTIhyJcGNeyRxUMuH67R
	fOjyqIUFqMq2W00FrK64ly+CD65fQV0OLL2u9I5Dw361gH6/WoFVZ3EjsAVzavQFy2wN0crrh/3
	Xy7t0UhObHloA3YaZ6Avyck6e3aTuZkLTx8H11BNhH2n8h91t6jmbyySZWFA=
X-Google-Smtp-Source: AGHT+IE9Eqckv8N6UfM90WIFhve0UGHfhbHNHJwnfe9KOIkGR0rD6N2S8bfcglrNLefFBnmMbgVzCt5LZHUs9GMf2vzxafAMk2sP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3303:b0:433:330a:a572 with SMTP id
 e9e14a558f8ab-433407b03camr2833605ab.13.1762278765743; Tue, 04 Nov 2025
 09:52:45 -0800 (PST)
Date: Tue, 04 Nov 2025 09:52:45 -0800
In-Reply-To: <ea06bbfb-d14b-4c61-8394-c536ca2a67ce@lunn.ch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a3d6d.050a0220.98a6.00b6.GAE@google.com>
Subject: Re: [PATCH] [PATCH] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: andrew@lunn.ch
Cc: andrew@lunn.ch, davem@davemloft.net, dharanitharan725@gmail.com, 
	edumazet@google.com, gregkh@linuxfoundation.org, kuba@kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Nov 04, 2025 at 04:27:16PM +0000, Dharanitharan R wrote:
>> KMSAN reported an uninitialized value use in rtl8150_open().
>> Initialize rx_skb->data and intr_buff before submitting URBs to
>> ensure memory is in a defined state.
>> 
>> Reported-by: syzbot+b4d5d8faea6996fd@syzkaller.appspotmail.com
>> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
>> ---
>>  drivers/net/usb/rtl8150.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
>> index 278e6cb6f4d9..f1a868f0032e 100644
>> --- a/drivers/net/usb/rtl8150.c
>> +++ b/drivers/net/usb/rtl8150.c
>> @@ -719,14 +719,15 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
>>  
>>  static void set_carrier(struct net_device *netdev)
>>  {
>> -	rtl8150_t *dev = netdev_priv(netdev);
>> -	short tmp;
>> +    rtl8150_t *dev = netdev_priv(netdev);
>> +    short tmp;
>
> You are messing up the whitespace here.
>
> Did you not read your own patch and notice this problem? checkpatch
> probably also complained.
>
>     Andrew
>
> ---
> pw-bot: cr

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


