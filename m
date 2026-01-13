Return-Path: <netdev+bounces-249420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3CD187EC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AFC73006A55
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199338BF63;
	Tue, 13 Jan 2026 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMcBXmgP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093138BDAD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303851; cv=none; b=fbfY/NMfsbvFBx5aMzQEEjhkb8b2x13uqVfvVhX+L6+hcojkCI8+xka0+rX+o7ia8laR9ZQO6Mh1Xz5RouX/bXAq3mRx4s4VziB16UirW/FJ7axlr2vNIjjYsxu5O6bP+mZps0otrwOM7q18UapIryR69Ql/w7Q7wE7VDfpAM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303851; c=relaxed/simple;
	bh=bgvUodXDUnIEvDzCkIlCH1wd2koKpEYANFLlqTzVhdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=HAeWQr2HYNMML/SOQzs+Us2zrDzHSf6Hu8pMj5lfoyIbO4if1vgbK2ph3/tbf5HFgvdahlGvNOt3Trjqkwo2ysQYZQOOWwZeMVXbKRadEsQDzdtD3EZhPEN4sVBhVOTTKNQ4srYjB4WAMMTgG9ONYFXJzj3tEOn/SU5Y5sG+vDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMcBXmgP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a2ea96930cso48131345ad.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768303850; x=1768908650; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlYhAj6Qmp6+pkbpgG8JbNmACj7mG4zQD/RWT+Cxx3c=;
        b=iMcBXmgP5puMRvpnIYGocdaP3r56Drpig5a3wFk2f6fp7DlFypKq5SXXoE8ZiMI/4b
         ZWL65l/Tgwl8BAIlO4sVAydYtve1pjFRap4TR5yCvZcr+ANoDsXSUnujCV3W+YEZnG//
         UuYfhYbT44F5ecDAtBsddXDSlNWmkt1i/5E/zX13o2aX9O0dHi3qo5KhmZuUoqkr4Tq2
         S/sVrqBg1+ie1+42hhadx/1tU0bPDDQqIGUCRGh9ebcUF5217k6VHXU8WghJqPaJF1d9
         0dM+iCl4sk9NhQtn5YpH78G8tZGvEanIfHIl1dLGHfIy+Twm0Nh2eHh3GLw2CKzOHCxm
         3BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303850; x=1768908650;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlYhAj6Qmp6+pkbpgG8JbNmACj7mG4zQD/RWT+Cxx3c=;
        b=IsjxErAyMlToeUcuA0wBXnFL+hgoSHck/oVhJ4JXCKaq8JkGIEXlp/IPYKV6vu0QGN
         b1a0J/jyuAVGWLI8CqpqCAaSUx/d/s4FFJChyhKHa01QdRvr0ncz5JzImjmKHzvwcxce
         /cIfCbegpNrVQQXMuTnOwqI70aHsdqvLT4D4NLbawQoeBw5WDg5kbwk3ZMYceN75b3+j
         HXdunwAX0ccUmMSLvBZZGfh1umDW8l6k2tl0Pv6w89I4D8WsR5zjXBRJ7NYePjvGZ/HV
         RaHWroUsa6EaJapl7JLku6ytUgWawygd4VwV4VQA5wE1WkJkdvbylzagbDIBRpSFeSpo
         pDZA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZBRjHtoeMMuLmu08GkgJiXqUOymW1CtKqNhJtPAP8UdZNTDkuQlfVO6usVcA9lau2LHSnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCqkLetdzuuhU7yGSDsxZSKhUqaM4qquN+zZ8vZ4+QBRZWaIW
	vyqnKvjAz2XIkJZI3tJE2GqiQ7Q3xwBxLNXFiG5D0olNjOEWpcyXUZZR
X-Gm-Gg: AY/fxX4d2DbkPvmwwm9gmSbJcM1DsbYbWDmLd/lMt/pYvReLMZyS2V0JNacpNELSkTj
	UYIjTfJiA/VXfTIMlodu44GsP/5Nsf5nMYhhXEl/uxSP0UkDWc5Bf117/cXsClJigtsDtn1d086
	U/IhS7HJtUbWOkmXYe0q8P0noxUq5nPcz99gNJ7Ap8DZFpF6y3N+IDQm9WcnMhEDSk0XhceuryB
	bphRUhg5cCpXl7uIo9Vaw5w3JommwNBMeavRLbmNCV8o9WF+lu52tOz3VuTH2E/iUwz0ZfbxXNd
	65eRY1K7vSImFfhJiIF2VRDSNrx9bBzAZccm44l7TO0c7wqzdk4/qUGXfec1S66UW1MgYjLPyQK
	wTA6BiVDs7L2Aoha1izMxo3h2xCC3ksPjKfdp682dXgcwwvFcb5SJUuNyQaObnWMS9cNXfcWimo
	4rC8iFvsBfnwtS4qE=
X-Google-Smtp-Source: AGHT+IHHyPdLQhLMJv85R43imUk6lt/OSW7jCE4knZP06M839c71Oz4y+wEJKXpkd+gtJJxZn79utQ==
X-Received: by 2002:a17:902:d491:b0:2a0:b02b:210b with SMTP id d9443c01a7336-2a3ee4fe86bmr201095145ad.41.1768303849578;
        Tue, 13 Jan 2026 03:30:49 -0800 (PST)
Received: from localhost ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4a41sm83557315ad.100.2026.01.13.03.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 03:30:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 20:30:45 +0900
Message-Id: <DFNFEBZPHG3I.1YEOOHK1BTI3N@gmail.com>
To: "Andrew Lunn" <andrew@lunn.ch>, "Yeounsu Moon" <yyyynoom@gmail.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net-next] net: dlink: count tx_dropped when dropping skb
 on link down
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260106122350.21532-2-yyyynoom@gmail.com>
 <b6ff2078-86d7-4416-a914-e07ae13e2128@lunn.ch>
In-Reply-To: <b6ff2078-86d7-4416-a914-e07ae13e2128@lunn.ch>

On Tue Jan 6, 2026 at 10:44 PM KST, Andrew Lunn wrote:
> On Tue, Jan 06, 2026 at 09:23:51PM +0900, Yeounsu Moon wrote:
>> Increment tx_dropped when dropping the skb due to link down.
>>=20
>> Tested-on: D-Link DGE-550T Rev-A3
>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> ---
>>  drivers/net/ethernet/dlink/dl2k.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dl=
ink/dl2k.c
>> index 846d58c769ea..edc6cd64ac56 100644
>> --- a/drivers/net/ethernet/dlink/dl2k.c
>> +++ b/drivers/net/ethernet/dlink/dl2k.c
>> @@ -733,6 +733,7 @@ start_xmit (struct sk_buff *skb, struct net_device *=
dev)
>>  	u64 tfc_vlan_tag =3D 0;
>> =20
>>  	if (np->link_status =3D=3D 0) {	/* Link Down */
>> +		dev->stats.tx_dropped++;
>
> Do you see this being hit very often? It should be that as soon as you
> know the link is down, you tell the core, and it will stop calling
> start_xmit. If you see this counter being incremented a lot, it
> indicates there is a problem somewhere else.
>
> You might want to consider converting this driver to phylink.
>
> 	  Andrew

Sorry for the late reply. I recently started my first job and have been
a bit busy settling in.

To answer your question: this path is hit extremely rarely. In practice,
I only observed it in rather extreme cases, such as forcibly
disconnecting the physical link (e.g. unplugging the Ethernet cable). I
have not seen it occurring during normal operation.

Given that, dropping the packet in this situation seems reasonable, so I
added a counter to make such cases visible. However, I am not entirely
sure whether this is the right direction, or whether this is just
masking a problem that should be handled elsewhere.

Do you think this should instead be addressed by improving how link-down
is propagted to the core, or would converting this driver to phylink
help avoid or improve this situation?

    Yeounsu

