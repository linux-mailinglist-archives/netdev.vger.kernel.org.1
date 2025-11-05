Return-Path: <netdev+bounces-236058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA7C381EC
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 242CD4E6997
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90B52E1EE5;
	Wed,  5 Nov 2025 21:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516302DFA40
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379738; cv=none; b=X5SdFqtaSFFZsUl+m4iyKqbU6n2GUDKI1m78KDpy+19XB0QCgO9OBmPqaLbTzb+KDXEc/dtKubRXUQYE0+dhmT92tHo9LKnV7O7QwSOxrTF3PNUr7ZHMOdk+9cKGPAG3Nb37p4OHddBn95HdbpbQjdSzt0tfSvn/rrc2yDWDd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379738; c=relaxed/simple;
	bh=o+upkX391+0VrLVDVlvNb0q7K6Y72v81B9HOBXgZB7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PVAhavlTqusFInvQo3dEY3vEq4qwp7tVguQcUBk/4wiw9zvIwL5707IX2RWH+bYVprMTdpQqYP+d1sBT63UkAebhy300lOEin+kNZAmQJ7zlxmgq2/Sy9KS8AeI8L3Cs13iKrjUTGSdPjUiJ0QmoEbMko3lzTBqyyyBUbpHtKdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43335646758so3715595ab.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 13:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379736; x=1762984536;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwBf7ucm3+56iKVW7EZm+Ks9LT5jYkGcEHRVcLbxAI8=;
        b=s9PFzhyrZTmuCWQVcdtBezoQEevPGBI3KMKKgDKJyAkdpCur6/rk1n9W0Y3YZAIMnb
         MPOtpO3Uq+d8daOlDbIWemnp2JjEHbEghgH8rNMLZqz+P6G7mEcZOrZKFjf7DfYFRNj/
         XhPU6RaMFErRCT9FN0wJEi4Toe9mOvwu4aLw1A0gJdED3SC/NlxP5ZmdM3VPJvSXeuCd
         U6vXywbjIF23+J0e9GucbVU2HMGNZMMg2YPbhqw/BwqIptD6X2MPPCZ7DjZuZrYFreB9
         qI2Pz4AW8afiR6iJI39IQB6jRw62RdM529ME/UfVKBZzFvWHcFXYA5/weu9eJBjZ1VkF
         Bapw==
X-Forwarded-Encrypted: i=1; AJvYcCUV4atkH9zEz1bBBuIAc8GQw/VWKB13/fVHFZfBIeocUqBbskdmG8cNJXMWJVFbwqBHnrerpSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5hDyjts2JAO1V2evUXOLVz0vCTM1cOkjOhx/hJVDWw+Xttcw
	YI5zJ1s/9B4JSPFPJbHnuCur15eSVRdN2QkGec13VN6CZfXlWZ3YVdshHdClnYJyl/ru+HWT5dW
	T4wxabqQEZA79PxvQt639p0HWv59sDehKfQ1Yk+fqOJ+l31+272mLFLLyPi8=
X-Google-Smtp-Source: AGHT+IErvgVX2lT1VTeExtwe7VxD3tNx5nEjEm+MYjbP3l+C8+JnOOqZC+bupe05ezRup0sS7ESz+GO2T0H8DuOhhyPQ9mBXn6Id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b21:b0:433:2389:e0b1 with SMTP id
 e9e14a558f8ab-4334068a78emr65038635ab.0.1762379736577; Wed, 05 Nov 2025
 13:55:36 -0800 (PST)
Date: Wed, 05 Nov 2025 13:55:36 -0800
In-Reply-To: <a5ddc43a-5354-4951-8691-1f3887743e3d@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690bc7d8.050a0220.baf87.0073.GAE@google.com>
Subject: Re: [PATCH v2] usb: rtl8150: Initialize buffers to fix KMSAN
 uninit-value in rtl8150_open
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: jacob.e.keller@intel.com
Cc: davem@davemloft.net, dharanitharan725@gmail.com, edumazet@google.com, 
	gregkh@linuxfoundation.org, jacob.e.keller@intel.com, kuba@kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

>
>
> On 11/5/2025 11:47 AM, Dharanitharan R wrote:
>> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
>> index f1a868f0032e..a7116d03c3d3 100644
>> --- a/drivers/net/usb/rtl8150.c
>> +++ b/drivers/net/usb/rtl8150.c
>> @@ -735,33 +735,30 @@ static int rtl8150_open(struct net_device *netdev)
>>  	rtl8150_t *dev = netdev_priv(netdev);
>>  	int res;
>>  
>> -	if (dev->rx_skb == NULL)
>> -		dev->rx_skb = pull_skb(dev);
>> -	if (!dev->rx_skb)
>> -		return -ENOMEM;
>> -
>
> None of the changes in the diff make any sense, as you remove the only
> place where rx_skb is initialized in the first place.
>
>>  	set_registers(dev, IDR, 6, netdev->dev_addr);
>>  
>>  	/* Fix: initialize memory before using it (KMSAN uninit-value) */
>>  	memset(dev->rx_skb->data, 0, RTL8150_MTU);
>>  	memset(dev->intr_buff, 0, INTBUFSIZE);
>>  
>
> This isn't even in the current driver code, but its shown as part of the
> diff context. Based on your commit description this is probably what
> you're trying to insert? But its obviously not a properly formatted or
> generated patch. It reeks of being generated by a bad LLM.
>
> Please don't waste reviewers time with this kind of generated nonsense.

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


