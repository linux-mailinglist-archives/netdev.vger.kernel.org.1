Return-Path: <netdev+bounces-154854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C5A001EC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B6B7A192A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D678BE8;
	Fri,  3 Jan 2025 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2JnRr/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F5611E;
	Fri,  3 Jan 2025 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735863543; cv=none; b=hoSuTnclL81A3Bs4FI9sZiL+uIZ0bKG2JZg0Ma+HhjcW7HY3R2vRhoc9OmZ7eIsrAo7I5SoUwH6XIbjLlmuB9RSpzbcnXcMgECJzkvhCr89ofVVeUCtb08Q6zToGlDa+MKbSIUnlv+0suO7UMwqNfxQYDcgHebM2kh/NGpGlbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735863543; c=relaxed/simple;
	bh=f9RrOFH/7Y9d1F6utlkYtenxPmcCn5o41N4bDVdcIk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jh8WtTNV9fVTaSy35iWYevOSQ5ZCHa32qn9YU4WkkrYmIiPTxCp2Vht+7syTpK34OELMsVeUFqqgjVvIVlXnK2cm9XA92G3RJl0/tb+sAtwlVC8oY4d2bt+v6v6Nx7b2IQRzSkekhUkX9PzgSnLCyozsugX4McwdsMYi1vpZ3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2JnRr/Y; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-84a1ce51187so175965539f.1;
        Thu, 02 Jan 2025 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735863541; x=1736468341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7V4bAfpSrgzHRrKhnU0RY23sESakg9KYX8aE6pqMf8=;
        b=j2JnRr/YPknaFqTv0vA4oLvCfzGw8+yzPGoCIyBi4ZfoKhem/uzkuuvB2/vRrnmoFt
         yQ3bOAelYMnCAWDDjHeUQS6nAJDqBn20UBKrKmcjIdgtKtOoIQwNw1DiB8uHyCokv8HT
         mj+w58dJPqoIf25LvCVrVe5LKUuvY4834pdN6twC0QEGt3OF4UsiH8oX/HT57UBnZ9qQ
         Mv/ZRx3M078CT6Au0bGITEeigIXknOHlr5WqeyqdBky4ydyPro2KFmW8APWFKVm5Vtrl
         nTLF1cy+Vwd9yMJ7jBWpwFLtVd+IVki0LeSUAJ2zE4FekhUMWzbhIMn+nC+Qd8vjJX73
         rwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735863541; x=1736468341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7V4bAfpSrgzHRrKhnU0RY23sESakg9KYX8aE6pqMf8=;
        b=rEhBtMRq6eAdb9A+3qGaelw3A34HGopkMUFBYKDa8aIzrR+Bb8gUMHevKub3ElWrEf
         wsYGaFS1kCd9Qk7Tgwm3vxYvWwEHCbJGxaSd4CiUw/1pFFKR04bTzJZTHy9IGJI+hV6D
         7trAp8kpdD0LnX9Rj0rf5NKWiQA1MW4g+g+lok0pNdGnjSf3ttHLwP/nIpNNkutiFJzV
         Ae9RP6BL+2G5pNr8OSOGog1EqUWG+zbyAiASHvSxcGG3ujkSQITY56QpAh4UfofDILph
         zZJ2Hb87UcS24F8bZtHt0BP+b8aoYlbji0TFVv3G15khgnuJrz4VWhcAqyvw3jK4+rM5
         iiTw==
X-Forwarded-Encrypted: i=1; AJvYcCW6GVx7Ef6RP0IAnRGVR0YAKjgJC0NBcqOHrZbSaq/kTiQH24fBGupQrh7AEC1FLHWbhU15pinuHnZOvm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3thZCCZw/mfu8ls4N+q5aPHtrbFBTr2AW+EDoKlGC5/jxOKo
	y8utstUFmaOEmSS8s9lT4k1tbDYE0Hw/LfmZ1GI6PKsksSg9KTB5
X-Gm-Gg: ASbGncv6pPiDZDOksfS4iTbWa5M3MJTJbStMN4ypS3zihaiXfA4iElJ8MdCBEwsmUe0
	QbSgYGELWBcN8/AA4jJ6SklgaGYyKjeHL9zJdzZMa6DDjGt3e1Tio1CdK4tJW/se510vf6JWppn
	nPT4qSRMjJuO14MNcjpgIBRHwUteM4ruA/To58CrhQjtBwPW6Uvr1kx7BaKtqrsx2BKbyWnh82s
	eRMNDvu+MWPanOv+w5lUcDd+WJqV/sp9vVTV/r3Dry4pY8PZ31dMGfDH4L6F1f1IxjxtKbPcFa/
	IvPCwNZXtSJPjKJo0iG/1QVufbukNgAHyncg7bpAqkGXUnNeMtvwGt2Xcg==
X-Google-Smtp-Source: AGHT+IGbVazfxc8VMDqxtWaUgSqIKNaJ9Yw4qonAp/j77RqVf7QHI8uT7NHp430EbiV9dRviy1w0RQ==
X-Received: by 2002:a05:6602:6d0f:b0:841:a652:b0c8 with SMTP id ca18e2360f4ac-8499e4d86a8mr4758276039f.3.1735863541396;
        Thu, 02 Jan 2025 16:19:01 -0800 (PST)
Received: from [192.168.128.127] (bras-base-toroon0335w-grc-31-174-93-21-120.dsl.bell.ca. [174.93.21.120])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d7e0cc6sm694459339f.15.2025.01.02.16.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 16:19:00 -0800 (PST)
Message-ID: <62d899b3-dad0-4e61-b4da-4ce969dc7cf2@gmail.com>
Date: Thu, 2 Jan 2025 19:18:58 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: 802: reset skb->transport_header
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
References: <38130786-702c-4089-a518-cba7857448ca@gmail.com>
 <20241228021220.296648-1-antonio.pastor@gmail.com>
 <CANn89iKkrZySKRidPLFa=KsM6h6OeO2rgW6t5WNY9OWfJazu8g@mail.gmail.com>
Content-Language: en-US
From: Antonio Pastor <antonio.pastor@gmail.com>
In-Reply-To: <CANn89iKkrZySKRidPLFa=KsM6h6OeO2rgW6t5WNY9OWfJazu8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Sorry, this patch is wrong, it does not fix the potential issue yet.


No worries! Thanks for your patience with this. Much appreciated.


> Note how skb_transport_header(skb) is used in
> find_snap_client(skb_transport_header(skb));


I've spent so much time trying to figure out why the offset is wrong I 
lost sight that the core issue is that it is being used to begin with. 
Paolo Abeni hinted at that too.


> The proper way to fix the issue is to not rely on the transport header
> at all, only reset it after pulling the network header.
>
>
> diff --git a/net/802/psnap.c b/net/802/psnap.c
> index fca9d454905fe37d6b838f0f00b3a16767e44e74..389df460c8c4b92f9ec6198247db0ba15bfb8f2e
> 100644
> --- a/net/802/psnap.c
> +++ b/net/802/psnap.c
> @@ -55,11 +55,11 @@ static int snap_rcv(struct sk_buff *skb, struct
> net_device *dev,
>                  goto drop;
>
>          rcu_read_lock();
> -       proto = find_snap_client(skb_transport_header(skb));
> +       proto = find_snap_client(skb->data);
>          if (proto) {
>                  /* Pass the frame on. */
> -               skb->transport_header += 5;
>                  skb_pull_rcsum(skb, 5);
> +               skb_reset_transport_header(skb);
>                  rc = proto->rcvfunc(skb, dev, &snap_packet_type, orig_dev);
>          }
>          rcu_read_unlock();


Will send V2.



