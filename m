Return-Path: <netdev+bounces-233326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D3C11F92
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422C119C0DD6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021432D0E0;
	Mon, 27 Oct 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZO0EsU3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21C2E6CD0
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607211; cv=none; b=F1aAtsXKRsMvmNEwQek7qjox2SQ1Ba2+tCkug3H3aq8zj0Km0HEpAWom3ANTOiN3FtjyMRiI0Y/bhH95ncuQNtxkVW3kl5JnMz1XXo6TVkCG7AVyoVPErabA6eFHAuOlTOewOrcsfXXI4r1n67O9NKplQYsHA1zbrOuMS6TXNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607211; c=relaxed/simple;
	bh=II9+d2ApwC/wxNtqBbQr4o0FZhWbU3TZTEczkDQu3E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IF7MrvAkjfMClm1cYC6XxmRie4voS/FF24UGNB7ezlyOCWAxWzOMzE0HNVSnR3VvzZ/8hwq/Ayl5vFUPODm3FdchpMbRP0X/r0O7eHgPc0ksnOFT3DdliVdgNgehvwp5Z3bGB3fZl4fe9Ux3VysukCuC1Ut0Wgg+Qw/VJ5ttUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZO0EsU3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2697899a202so43184785ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761607208; x=1762212008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xi63kXliKsSMCxzduN4k+9oFp4ypHAQf4DADOGFNDwc=;
        b=EZO0EsU3zBoIMOu/bBoRCDE3x38BDbaFvYTUX0QRmU0u+LJm5b58SFhtE23vQtt5+q
         hTk6C9uzVI2/SBoLCeiB5ylN7rzHpf/uCDpl5/rovlbpnmxMoOsbmdJg4yZdmYoXmZ2S
         mVBVoxI/AF1YhD/nZd2Xu71Sy7jJd8ds3dWUOR0OBydSO+xEdS07b7JBQbW4d5kxn4YT
         wWbVluggBTde5l7Q3VhReOlIx230niKDVGs7vcyLBZHmKjn34iQp9re3QigPdMvtgPeb
         TTMbtD6vUJJICN3Jlc4xyRmQB9jKaKCw3W04WjGE9IQNGTaAGOYXtct8CS0MIt0vxshw
         LIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607208; x=1762212008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi63kXliKsSMCxzduN4k+9oFp4ypHAQf4DADOGFNDwc=;
        b=oiNkNSgeX4avBXkDdfCcgV3WzNb2BpSO//ZQkTXJbjSJxagxwjhunh7q8uGrBvCI46
         pvaxXkkRr2pBpNAKjXomYPfy4aaJnt1WRa/xtTfqCKmwHbEJAH1GsWW8B6OPJXQhTd+d
         nllSK1IlwU+khzS7oMIFkdlquSphJ0au07WUJuafe4JlnhAcO2S7TjFVHquc18jpqbkF
         D07ZTOvr91Reh8tQLCXRnALEGrukos/l6ySWDEoQ/SvRY7JsHfM77m7tTHNF45pIYpoW
         eKXWdf7cba5q2hf4VgE9yAM0GB8vi1JdtcNewLF5dPKUsrKzlQb5vry1Mu0uNxZLj9nf
         JkEA==
X-Forwarded-Encrypted: i=1; AJvYcCUn/1jGfpqcLxJrsfR3GScjzqOxx3w8ZomcSv3k1/PGo8yh/a3oxGMilBXYgzgz5gs+zyjBV5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HnRpHN9705YlKFtQLjmljPdwiJWw2yByTFkiSAL7OjL9tIl8
	f+7kc1+GA3Ss7nHqtysiH/EySfssCu6dzvkFeqFbedaTrZkhTOawhgF5
X-Gm-Gg: ASbGncu6zU99amtP7R9cZlevA9D1S+jfbvcpCOGCko7RET3bQY2kvzamyTBAK21dd/+
	AVM5i63AIEiwksAKQxkt3gqqBXIT+5xy2qUdzGjmJ9q+wexeKUNMaSHca+sQdDJP0YsKJGQTMU+
	q5rAxJqa5ok1ZYJogwz9A4GbvBB4K0xBl4M01xzEYKlsnG8jCKNTSlYRFiQwLq/ahZPG+rqGYfK
	dFS6JMX9lSWfbeCV8cBzX05qBicfY/Jz8gVkx7+PFaaXqENdIn0WnO/kcAyw5MiCJ51xJkzvnGs
	74UZZmU/w4uDm9rLVORGUf+Y5jPyIdnDZPkRq0M5vWfpBQ2mHJtUsfYnVhKzRzNFIbekLSzRTkR
	T4Raza9/O7am3gcEN7qUs4nWuDZPQoDzLwHsWAe2bxCMOXh4gVY/3xIbK6W3oOEWFzdMRgREqOf
	6yXfjQiPFxcMmq0X4UQDo=
X-Google-Smtp-Source: AGHT+IHZ2qadCM5rYqMQYVKyhlBv5HvKNvb9k9ckLfbx8eC9hrLnINLgfUIlXvdTpmdKdXhJAT5K5w==
X-Received: by 2002:a17:903:2f06:b0:290:ad7a:bb50 with SMTP id d9443c01a7336-294cc77aeeamr10558295ad.27.1761607208375;
        Mon, 27 Oct 2025 16:20:08 -0700 (PDT)
Received: from [192.168.0.150] ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm95993255ad.8.2025.10.27.16.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:20:07 -0700 (PDT)
Message-ID: <e1d057e9-0ce3-4049-8667-24c5050ff996@gmail.com>
Date: Tue, 28 Oct 2025 06:20:03 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] documentation: networking: arcnet: correct the ARCNET
 web URL
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <20251027193711.600556-1-rdunlap@infradead.org>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20251027193711.600556-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 02:37, Randy Dunlap wrote:
>   For more information on the advantages and disadvantages (mostly the
> -advantages) of ARCnet networks, you might try the "ARCnet Trade Association"
> +advantages) of ARCnet networks, you might try the "ARCNET Resource Center"
>   WWW page:
>   
> -	http://www.arcnet.com
> +	http://www.arcnet.cc
>   

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

