Return-Path: <netdev+bounces-82549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B624188E89F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E787F1C2A025
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFB412EBCF;
	Wed, 27 Mar 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JU5CiExG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EC4F890
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552242; cv=none; b=IOy+ZeQFczUekeucJ/gSoSCjjRYqPIj8lmenSiFoqACPSATyFJnldgcd+RXdifzX9/zZ/0L7VsLlm9MIsyS6/v1dvMgtDb/m4El5RqmLO+m9GYmUQSoxvF9Y2FcbtfxSQRi7H4MqNEwlbVWDdqCQQWy6BXCxW8tuX8J9LmYYrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552242; c=relaxed/simple;
	bh=xSl+elXw6TGnfDDxTuwZc3OijKW+bN4Ubbs24XJFxWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaShBuRfE3k0Q1PNPfnr1dZm/Q6vvTaOBVC87SLZ6zVLJAGWwtpgVeWiiMdLfB6tNq5EpBjYY0j4S+pvZUdmr3XmuEbvNaQt30xo6eEv4H0ybuuj/r8XuFZRHx6JsPwfcLnVKBbgkxKWGlc3DUfHxEK0Hc3Nfh/8hI+qY1cjl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JU5CiExG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so9425361a12.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711552238; x=1712157038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg3QzX5qREXmVZsGaqo0PzIOFIXQE1IbveON87ikDwQ=;
        b=JU5CiExGX2fWxeAmFJzOzhGwjmo9bvN5OJ/5W3s11sF16i8OXUMOe5F/pBm76Go78K
         hBC6XSl0UIB6l1qrL1CW7g8K/2XbIftE+yGsoUacfC3KOd3MXzrTCcrlgVAo8ZSidJZI
         B9bYh0AHyTi0Dh75aQhLByihVplja8peRlycoXedc36fWXesh4Qut8qQVrkpIa2miVBC
         blI0uZ1p0/q9qT4iq8nAj8XB7kPceKzwfPkKjn9NMeLN39iZmbRXwEMIk3IefFw4yEli
         thw+qo0uqtpTn0QpODta8N3GGOX/5ITLRLURxRNq/RJR7FxSe1dMUHXkrJEHdHZAy9uY
         P6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552238; x=1712157038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg3QzX5qREXmVZsGaqo0PzIOFIXQE1IbveON87ikDwQ=;
        b=A/I0xMGs6NbRvcjZLZd5f7qccxp2Mg5+rUV2/ZoRKLmjIsJunJhKWUJiq+WrZ0jR0o
         du6lr3yxzECrMzFzx8NiXZBGqCV/QcsNTVkzhK4XV8tgPJm8LZfJ2m3gLe5jJtahfu9B
         cD0Rh30OqC16o85uUVxqvyh19Kx7kqLFF9NOa7Gd8AtatzzypsZjaPhtEv0S0Twe/xSd
         gUS0ui8bm+IM4BnZfNYXFFjYuhXMk6GhXVysWyfWsTp5FdwK5IKZwWIlhmzDhLqnY+8n
         kav/8LRAA0AVHVp6ipv1cvoYgmdglQ/po+poZ/vyrL4lJ+27luonCBfDQr924nCm5M+n
         3Uaw==
X-Forwarded-Encrypted: i=1; AJvYcCWMlcdygCvWVfiCjZi+7X1mozyl7V33pgJ7CisfnxtkogT6q2AdD8dz8qsjLMW0jwnJNQHyvWAJ8DsIHd9WvthsGsSSMCzS
X-Gm-Message-State: AOJu0YzcuqoB0BkSUfNzWowuXfU6DgEN3DgkF1nCljyRMSjxvZGNBamz
	UDOeL25XgyEmJGVfF64Q0xm1ifBv8i/SpjeEARzzE/y8AMje7nt0EjnHpsh8fOE=
X-Google-Smtp-Source: AGHT+IEG6gS6qYe0E+lUJL//xh4zBdNakL80EjwnyIFcIwgzZrLzz6D+EK8zTW1O20qHE7z/Fw/K4A==
X-Received: by 2002:a50:f61d:0:b0:567:737f:e910 with SMTP id c29-20020a50f61d000000b00567737fe910mr80250edn.3.1711552238517;
        Wed, 27 Mar 2024 08:10:38 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:b2db:904d:e0b0:46ec? ([2001:a61:1366:6801:b2db:904d:e0b0:46ec])
        by smtp.gmail.com with ESMTPSA id dm28-20020a05640222dc00b0056b7ed75a46sm5403800edb.27.2024.03.27.08.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:10:38 -0700 (PDT)
Message-ID: <04cfa214-4d45-48b1-87ba-500e3e501977@suse.com>
Date: Wed, 27 Mar 2024 16:10:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 Oliver Neukum <oneukum@suse.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com"
 <syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com>
References: <20240321124758.6302-1-oneukum@suse.com>
 <SA1PR18MB470955BBB332D3A9F9A6F247A0312@SA1PR18MB4709.namprd18.prod.outlook.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <SA1PR18MB470955BBB332D3A9F9A6F247A0312@SA1PR18MB4709.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/22/24 18:43, Sai Krishna Gajula wrote:
> 
>> -----Original Message-----
>> From: Oliver Neukum <oneukum@suse.com>
>> Sent: Thursday, March 21, 2024 6:17 PM
>> To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: Oliver Neukum <oneukum@suse.com>;
>> syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
>> Subject: [PATCH net-next] usbnet: fix cyclical race on disconnect
>> with work queue
> 
> This patch seems to be a fix, in that case the subject need to be with [PATCH net]

OK
> 
>>
>> The work can submit URBs and the URBs can schedule the work.
>> This cycle needs to be broken, when a device is to be stopped.
>> Use a flag to do so.
>>
>> Fixes: f29fc259976e9 ("[PATCH] USB: usbnet (1/9) clean up framing")
> 
> Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: f29fc259976e ("[PATCH] USB: usbnet (1/9) clean up framing")'

Ehm, what exactly did I do differently

>> --- a/drivers/net/usb/usbnet.c
>> +++ b/drivers/net/usb/usbnet.c
>> @@ -467,10 +467,12 @@ static enum skb_state defer_bh(struct usbnet *dev,
>> struct sk_buff *skb,  void usbnet_defer_kevent (struct usbnet *dev, int work)
> 
> space prohibited between function name and open parenthesis '('

I am sorry, but this is the context of the diff. You are not suggesting
to mix gratitious format changes into a bug fix, are you?

>> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h index
>> 9f08a584d707..d26599faab33 100644
>> --- a/include/linux/usb/usbnet.h
>> +++ b/include/linux/usb/usbnet.h
>> @@ -76,8 +76,26 @@ struct usbnet {
>>   #		define EVENT_LINK_CHANGE	11
>>   #		define EVENT_SET_RX_MODE	12
>>   #		define EVENT_NO_IP_ALIGN	13
>> +/*
>> + * this one is special, as it indicates that the device is going away
>> + * there are cyclic dependencies between tasklet, timer and bh
>> + * that must be broken
>> + */
> 
> Networking block comments don't use an empty /* line, use /* Comment...

OK

	Regards
		Oliver


