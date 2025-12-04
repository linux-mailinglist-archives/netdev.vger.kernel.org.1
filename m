Return-Path: <netdev+bounces-243538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C80CA33E9
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD5E300FF97
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2242E88BD;
	Thu,  4 Dec 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk1ePPHL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwC7Zos3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BD27B32B
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844547; cv=none; b=RhaZU6oe+AOPgMWuZQaXo5m3WQGjSp//0nzolXQuCPtxwDFTVR4AnkTwfMfEoDRDZLAUoVWufuui+fb6lFaeneJ6pjnfwnDasIPXEQ/QW06Q0N5waIsoqP5jqAGFhIDplDtBnCcwxstSO9ArNV8xSllmEdkyYTR7MzBrvp6u7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844547; c=relaxed/simple;
	bh=uFor36czUrjG0dgwIDCmf2o6kpsWmTe55mUkyQcjhkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPW3kZ4KVsYo2fDisMs3mOzUIqaE+6P1pNCbpOjQ71Gd/q/q/1cHL3hj1lBo1iD4+2yNchfuiBpHr8YzTaCxj37+XyqXYSbC6d1Wzrygo6FbpqtIJ9m5fXT9dLt0tJ0pNX856ysTy3CILIRAmGAcmW0x/tb3bmrJ5NQi4aqadq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fk1ePPHL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwC7Zos3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764844544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozfZnozNInALPdRCnz4vV5+xZLy8wMlQy75f9uWAaQg=;
	b=Fk1ePPHLXOANu+Pr8YF+PZg1CgwCqY32FfwwWyWUs+uqsR8QxZwWi9FyfbEhSBXrEi+Xu5
	54OPWhP+DYrr3cSa7dVrlDgTnmJVadIFNogzBtvDtQB6EItQu/gD7qNzOGOS6gr2p4jdUo
	9cyTqq0rd27Jn5ldGnfp/DvWGrdPcpI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-UZsw6IDgOJ6so-FSZYXXmQ-1; Thu, 04 Dec 2025 05:35:43 -0500
X-MC-Unique: UZsw6IDgOJ6so-FSZYXXmQ-1
X-Mimecast-MFC-AGG-ID: UZsw6IDgOJ6so-FSZYXXmQ_1764844542
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so5967675e9.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764844542; x=1765449342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ozfZnozNInALPdRCnz4vV5+xZLy8wMlQy75f9uWAaQg=;
        b=XwC7Zos3hjRFU9vbrOk4bWPxEk7WJg0C6fCk2phuLqqt+AcmboiC7hqqoPPDZDuTTu
         LyzN42l3OzU1Po593lkISOE+jPR2vk1Fl6C3/b/i9pt044pGShRw7Ev0JuVIPI0ib/39
         GSUwOAdf4N6jmA77UpbHGsbr/9CJ6Gw5xuPaOFdTfMpkt55lsTQrI+0FA99bUbOor+Br
         uxGee0MG/q8Y27miutIEjXhs8ch7sDxGXgs93oIHHb+sINpEVYVJGB7ddnJUXGuoTQEh
         c3RIeb2qbGWiIF/0j2e93CIrYFeeM2fJe9S2PFZNIctGR4vr1T3JNMuNWalmLr1D1mAU
         GhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764844542; x=1765449342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozfZnozNInALPdRCnz4vV5+xZLy8wMlQy75f9uWAaQg=;
        b=wn6RYMflVRjhIvlgwltgMekNpfxYhkN01lNiklG4mnJ+24jAUIFRqOwyp5t5AdPARM
         IJ92ZusieTTR4q8Kkr/e8HjMajL5I5VEMKZvd6PxPbmpTrSZvXSQuzv5nEnzWXtiMYnf
         riLvmMi9JsXk9kfZA6fQk++6+g+ErgNI78VaDxeSp8eS9cY54a/zo7S7ClQToQo9aczW
         V3VvjmH217xU8QaSUyAqR2x63sH2g/cMtAJIURiw52w4OFyRkVDnOhNDgth53A84czpb
         PJXjzM5IKsnckZS2XFSaju2EaGOZ10xPBW4UyyqkNayeBUwQH8uC40fiE1cXDOtGsz8F
         Js/A==
X-Forwarded-Encrypted: i=1; AJvYcCVpQTrt4Cngb3XQmgXee77emXajkgMcA++nNFXZzd5qIZIJ5IpV8UeQdJQMXQA5nxZNzx0e/WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGbHPzyyeL5g4Chia2Z7YytVUUPPGjH2IKiEZ8U2QV0QeQyAV
	PJnuN/+n6IDY6PvX9kHTrSHcby7YmOAWStc6zLVaqoL5dWfCa23KJYSODSmGjDDJuoBFSoilBR1
	Ww4/4TnRA8fRIVltHtRZgbGTNAMnlFjM8UJLIlOaX8AVT2Rj891zTnF/FBg==
X-Gm-Gg: ASbGncvS5IM4z8uabdmi7Ru1yJGY1erBNY0JSgFlUXijG038pAv4dbKd2n9OMleW0G+
	tv0pYyKgL8U7A+hjx7nR8txAulXtCA51C0YYNLkdoZSlMkUhkfBV6JNeVVm/15TJzAo6HDqgHVj
	bOE6Vhb4Wi+f1BA7NubBv4S8EOG1lE/h/eFZTEKxe2br29Gwx262pe9E302pPQr0OX5qpXtBU5l
	k+YSxKBW31ZSqkLSobpoYY2IY3LtPzxRRTEJFT2x9vFxbb9JLE2XlZRZFSAGzMnTbwVEVUz/8aR
	Chckn3AmKrW63nDC9zuvR+8hgCMtwcU5xKBswt5yFHfQhZTzgLuUW0WWCbyVdQFyx1RCfobrHB0
	NAZCJLYxtbPJ4
X-Received: by 2002:a05:600c:314b:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4792af3d3c2mr56924085e9.24.1764844541671;
        Thu, 04 Dec 2025 02:35:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8gptBLReJPUISffURobPtpWsCKdYSKrcu6ukQl+6Of0teYy307j/lVeci1rwunYXMAOTS3Q==
X-Received: by 2002:a05:600c:314b:b0:471:1717:411 with SMTP id 5b1f17b1804b1-4792af3d3c2mr56923735e9.24.1764844541179;
        Thu, 04 Dec 2025 02:35:41 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331aeasm2391343f8f.37.2025.12.04.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:35:40 -0800 (PST)
Message-ID: <70b71e0c-e1dc-4c9d-a75f-7adb9c92e394@redhat.com>
Date: Thu, 4 Dec 2025 11:35:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: atm: implement pre_send to check input before
 sending
To: Edward Adam Davis <eadavis@qq.com>, horms@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <aSxpOjsmyMPlB-Mg@horms.kernel.org>
 <tencent_E83074AB763967783C9D36949674363C4A09@qq.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <tencent_E83074AB763967783C9D36949674363C4A09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 5:31 AM, Edward Adam Davis wrote:
> diff --git a/net/atm/lec.c b/net/atm/lec.c
> index afb8d3eb2185..8a9660abd134 100644
> --- a/net/atm/lec.c
> +++ b/net/atm/lec.c
> @@ -340,6 +340,23 @@ static int lec_close(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
> +{
> +	struct atmlec_msg *mesg;
> +	int sizeoftlvs;
> +	int msg_size = sizeof(struct atmlec_msg);

Please respect the revers christmas tree above.

> +
> +	if (skb->len < msg_size)
> +		return -EINVAL;
> +
> +	mesg = (struct atmlec_msg *)skb->data;
> +	sizeoftlvs = mesg->sizeoftlvs;
> +	if (sizeoftlvs > 0 && !pskb_may_pull(skb, msg_size + sizeoftlvs))

AI based review noticed that negative `sizeoftlvs` values will foul the
above check:

https://netdev-ai.bots.linux.dev/ai-review.html?id=8b2b0db8-e11a-4215-85a6-a0735c7d908b

AFAICS the lec code always interpret `sizeoftlvs` as u32, regardless of
the type used by `struct atmlec_msg`. I suggest doing the same.

/P


