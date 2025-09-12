Return-Path: <netdev+bounces-222649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661FB55427
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83ED3BCA02
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893BC25B695;
	Fri, 12 Sep 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlkGAl9O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACE242D9E
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692243; cv=none; b=u6/9CpDkkmxzo2m58dkcwKeQT59d+rg+AsAXl2KsKPkFQ8fMAuCTjdCmklwtJQhhf4DDuDc7fBciNQ5J6AsJQ26+SXaN+lsMPmQfGxF9AwiE6uk0Pcsjb3W+xPvO8PshLHb6H2A7435AIacCywd3B8pBq/5VjcZlMM+QnCrI3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692243; c=relaxed/simple;
	bh=QAP8xPRbr/UWVUxzhd8ZCmVofjt9pXTb3Og3/f9CxgM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Pj+IWYOW8Wz4Uwde+4qh3SMUTrOYptuCqMyuIAX75r+B7zGBUajjlGyPU4Bdclonlf9RYHLpwl/obRjbMs5644O5h9OMob3mFuh/uctmM8Pslwpc9/I8gqwkjL5KF/JJz5vR/PrcEU45MwVXfhXrNUUDO9ik4+Nm06hIRl+Z79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlkGAl9O; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2071021b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757692241; x=1758297041; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmHZZLM+jLINLbKueG0GF/VWczCVBfuAc7hrSwl/VJw=;
        b=NlkGAl9OLlmIbal17GWxuT/1qYkQJp1foImzAhBNvwwrT93cziY8UwKEcgdHGZ5LvI
         nBiVvYm2b/cBmmGUppPZHEvkDrX7H8k5zcKIKJK2FyExN1ZatOMqtuFOMy6L+MmQ3I2k
         EIzXpEMBhOYGtUg+Ib/8zE4MDOjfzQH1IWVxiGY9cA0m31pz27F67u5hOoPN1fiz8emD
         jZYID1FqfgwwddPrStfvDJeItDbvdyNb4IWcaDUHcEPY6uTHcU9k1T1hYakoVYZqadK4
         qme7BPpnrYkJpnpeP4SQLcIxh2ANjrIYr1wE5MQKCdXPNSiiD5dXHpXGSzYNhK9u2nrR
         apqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692241; x=1758297041;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmHZZLM+jLINLbKueG0GF/VWczCVBfuAc7hrSwl/VJw=;
        b=sesQQlqq352vYDFERo8eNq/ojD7ZSPo2ZR7e+8pVq3KA+4qwCd2d63HR1VrILXQRpz
         aOyjgDFcaTy0RERsGHoGXzILbIGnTAlL6d22ix40WsLY8+85a4vX9zZ2J/2DcZceiVEw
         F/1kTXMaO5XuAssD4aVFAghLNLzP+T/jq3dOK0XZWsUgE5BsjOCTU9p9F8PoKkODJz/n
         VflWM/ZQFbYubol74pgIPeD95GGwQAacy6C/CfVYOQ7O3VE9LjQShNI+BnEk0TlrFyDI
         rF/srAxLJ5B93gy5pF5n2M437T6s8i/p5bzLC3lfA4MuX7zYNErWZtFx2znFebEjN8AB
         jznA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1iuk5Wi0ta77n765ndiF9nbsF0y6+F1mnhN6UF6E/GfERf8G4Z7CEUjkUT8dV+oBqFIuQp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrdKibRy1HTjNgyPIHw9dTL+E8y0hNiE+qboOMYks/EVW1R6T
	R67q6ehlweOL+cM058Gpv/XmXSHt3o5MOFJR2Hmc7hpyWIe+orE3S7dI
X-Gm-Gg: ASbGncv7q5PALi8IwGKPYhEzAEiooYbH2eKf+8TxJUzNyeajR8ZMTVd+yo8IotghQyW
	v5GWwaQ5X7PujifsK8KHOlVi3bDNRHObYYmEEpaQthOvdjFNExy91xw2JVOdHDUwdxxDeH74bmZ
	YM3C6zaop0EdiaQumMzFbhHvmjsT+EUTp35m2E9Vj4zR+L/TQqRBvoJcPSpgw+btK0+CMt7q5tN
	UjSMNPDVPld+snlVQ8jpGMBtnUtLsTTfmsykKRThoehlIL7DjScQcEsu2K+4EoeMPHuK3tgkiZS
	fKsUQEGxxXDzyWgyGnxuPsfXGG7A6zl9ZWPGVIaOLXaL72gzPhye9XQfwLt7dPCwyrPcGuSKPFr
	p3gEJ4VsZZAqqlaW0++xPJW8C+R3yKJTrhHMmsvAMnU3tb20/Lh8VgL9RunBNzVE=
X-Google-Smtp-Source: AGHT+IHplBs4rBxiEhWoleYLgDAH+C3KFfIe+pRXRtODawS1+YsgRO5KAu5iqzqSv2dZN+qba3zvNA==
X-Received: by 2002:a05:6a00:4644:b0:772:2f06:3325 with SMTP id d2e1a72fcca58-7761218ddc4mr4436593b3a.17.1757692241092;
        Fri, 12 Sep 2025 08:50:41 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c54a71sm5807277b3a.102.2025.09.12.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Sep 2025 00:50:37 +0900
Message-Id: <DCQXWATX22EF.1AWF6AGWZ639S@gmail.com>
To: "Eric Dumazet" <edumazet@google.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on
 `netif_rx()` failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250911053310.15966-2-yyyynoom@gmail.com>
 <CANn89iLUTs4oKK30g8AjYhreM2Krwt5sAwzsO=xU--G7myt6WQ@mail.gmail.com>
In-Reply-To: <CANn89iLUTs4oKK30g8AjYhreM2Krwt5sAwzsO=xU--G7myt6WQ@mail.gmail.com>

On Fri Sep 12, 2025 at 11:19 PM KST, Eric Dumazet wrote:
>
> I do not think this Fixes: is correct.
>
> I think core networking got this accounting in netif_rx() in 2010
>
> commit caf586e5f23c (" net: add a core netdev->rx_dropped counter")
>
I hadn't considered that the Fixes: tag can refer to code outside of the
changes being made. Thank you for pointing this out. I also noticed your
earlier work from 2010.

I'll update the Fixes: tag as you suggested.

>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> ---
>>  drivers/net/ethernet/natsemi/ns83820.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethern=
et/natsemi/ns83820.c
>> index 56d5464222d9..cdbf82affa7b 100644
>> --- a/drivers/net/ethernet/natsemi/ns83820.c
>> +++ b/drivers/net/ethernet/natsemi/ns83820.c
>> @@ -820,7 +820,7 @@ static void rx_irq(struct net_device *ndev)
>>         struct ns83820 *dev =3D PRIV(ndev);
>>         struct rx_info *info =3D &dev->rx_info;
>>         unsigned next_rx;
>> -       int rx_rc, len;
>> +       int len;
>>         u32 cmdsts;
>>         __le32 *desc;
>>         unsigned long flags;
>> @@ -881,8 +881,10 @@ static void rx_irq(struct net_device *ndev)
>>                 if (likely(CMDSTS_OK & cmdsts)) {
>>  #endif
>>                         skb_put(skb, len);
>> -                       if (unlikely(!skb))
>
> I doubt this driver is used.
>
I also honestly doubt that this driver is still in use.

I came across it while analyzing the `netif_rx()` and `rx_dropped` code
paths, and I noticed that there are quite a few unmanaged drivers using
this kind of code. So I started to fix that.

But If patches like this only burden busy maintainers and reviewers,
I'll stop sending them. That said, I do think leaving unmanaged drivers
as they are is also problematic.

As a newcomer sending patches to netdev, I realized that there are quite
a few such drivers. I don't necessarily believe they all must be actively
maintained, but it feels like some action is needed.


> Notice that this test  about skb being NULL or not happens after
> skb_put(skb, len)
> which would have crashed anyway if skb was NULL.
>
I think I wrote the commit message incorrectly.
The main point was not about `skb_put()`, but rather about the `if`
statement that checks `skb`.
That said, after your comment I realized that `skb_put()` itself also
looks problematic.

Thank you for the detailed review!

	Yeounsu Moon


