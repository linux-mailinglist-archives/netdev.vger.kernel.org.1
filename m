Return-Path: <netdev+bounces-137395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636B9A5FE1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE471C21594
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0C61E2824;
	Mon, 21 Oct 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNhjluE9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E861E32CA
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502624; cv=none; b=DhmJwwENo2hdmL9VdsOPvfo5Sr4K1z49JNwtTc3309IjmcG2+T2i9XoRmxs8tc+fq5Jikcvtvu4gbR9F2H/Ffs8+kUQGgg5Pivc9kqK2xcC0B/AsI9Nf4sBD3PYG/rZWhlaw3lmna7DZSzMNwHO8mZ7fBDE7paQH62nXjku0ZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502624; c=relaxed/simple;
	bh=XAazZYLkwAGGoZZOx7JUiyLm2ipHe+8hLTq1JrfcDJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGCTWCqgNChWQIfDo4IJnjf9xTeQsrIeuWsxiXm/95X8qC9o+hoy1eL7XKX+ZxFOf/vDg8yzNJq0zXs91NAe8LvzTUsa7IUxnrmiEKxwGZO7gLpIJK9t+l1e2IKFIuCbiyrBjNDnnviEuDfWoHXYBtaLLy1+DcdbpX7aTYteQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNhjluE9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729502621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOPzM8nTUFqwLn8ohf0g1jVEfJikuSPUMDsCZxkKDsM=;
	b=SNhjluE9FVyBzX2V8kO/9R0rhp4H+mZCg2Y6mDktaQYBdc8BymrhnoKkMR7UuCSwi4UiH4
	k2th9grbdLxKW+2Bov6boZBBc7LwAC9zBUKEm1EbnLeJR+5wR8KnIKDA+0HFzsDBKY0mg5
	ATSgepVKc8QbC9IBOCtU++uXD/Bix3s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-5iA86wRSOYSmUk-0LZs7nw-1; Mon, 21 Oct 2024 05:23:40 -0400
X-MC-Unique: 5iA86wRSOYSmUk-0LZs7nw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d603515cfso1883077f8f.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 02:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502619; x=1730107419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOPzM8nTUFqwLn8ohf0g1jVEfJikuSPUMDsCZxkKDsM=;
        b=lh8Zmz7RX+Nw7Cp5zkJ/0+G9nEoTayWGff6CR+utOX6dho18+tGXY4xJoLDLULepXg
         vM3qVMQMhZi6eyBL0qq4p/nqQQmVG26JFAhl40z2+7SqYKSZ5xPnGTaJBKX+K3+FwJaG
         ywvB5VgaU0hf8pAooTplA4xhm4UxZMYu7Wftt1kF3XiZ7ZG6zYctyh6MS2fNxsmy2EOx
         jrgDLYqmq8NzzUpVUYT3QBLkBQZxZCJ4RbdaL3X3JufYStDtu73jyb24qV0z6KD/fcjG
         I/E+HvLL+KZfccUunV28VQmZyijHC1zWDcPztrBrblHH/YdOJpLoNX7ovrEEy7QadVM9
         HNmw==
X-Gm-Message-State: AOJu0YycPKoLzffxLAjnM5fiYGuXGSV2zyuT6gDzBaj4qFe1GiI086fi
	kqfpATk01DMJp+GOK0gsXpAkQynXJ1YcBnDBVsKb8oxlrkxMD22/C/A4Kh7qq3IeblR46msLmNG
	H8Vj7e+/HgL+vL3p4/5FGqXRke99eAc5SzQN3wifAOKrwmlWbMmgUIg==
X-Received: by 2002:adf:f591:0:b0:37d:39df:8658 with SMTP id ffacd0b85a97d-37eab72a94dmr6219402f8f.58.1729502619021;
        Mon, 21 Oct 2024 02:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHysyLKLLu8ecA+EiDeIyFSZdEdGbiDbJIKLmvhlv8Jpyw7lbNkChKbBAKP5wBfWcUaSVANmA==
X-Received: by 2002:adf:f591:0:b0:37d:39df:8658 with SMTP id ffacd0b85a97d-37eab72a94dmr6219383f8f.58.1729502618678;
        Mon, 21 Oct 2024 02:23:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cbe7dsm51045765e9.39.2024.10.21.02.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:23:38 -0700 (PDT)
Message-ID: <6b95c3c9-3b8b-4db3-b755-a3652c1a59cc@redhat.com>
Date: Mon, 21 Oct 2024 11:23:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: ethernet: mtk_eth_soc: optimize dma
 ring address/index calculation
To: Felix Fietkau <nbd@nbd.name>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241015110940.63702-1-nbd@nbd.name>
 <20241015110940.63702-4-nbd@nbd.name>
 <e67883e3-b278-4052-849c-8a9a8ef145f0@lunn.ch>
 <695421bb-6f31-4bae-8c8c-6d4fccf1b497@nbd.name>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <695421bb-6f31-4bae-8c8c-6d4fccf1b497@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 15:07, Felix Fietkau wrote:
> On 15.10.24 14:54, Andrew Lunn wrote:
>> On Tue, Oct 15, 2024 at 01:09:38PM +0200, Felix Fietkau wrote:
>>> Since DMA descriptor sizes are all power of 2, we can avoid costly integer
>>> division in favor or simple shifts.
>>
>> Could a BUILD_BUG_ON() be added to validate this?
> 
> Not sure if that would be useful. I can't put the BUILD_BUG_ON in the 
> initializer macro, so I could only add it for the individual dma 
> descriptor structs.
> Since the size of those structs will not be changed (otherwise it would 
> immediately visibly break with existing hw), the remaining possibility 
> would be adding new structs that violate this expectation. However, 
> those would then not be covered by the BUILD_BUG_ON.
> 
>> Do you have some benchmark data for this series? It would be good to
>> add to a patch 0/4.
> 
> No, I just ran basic tests that everything still works well and looked 
> at the assembly diff to ensure that the generated code seems sane.

Since this series is about performances, some related quick figures
would be really a plus.

At least we need a cover-letter to try to keep the git log history
clean. Otherwise cooking the net-next PR at the end of the cycle will be
a 10w worth task;)

Please re-send with a cover letter.
Thanks,

Paolo


