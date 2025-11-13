Return-Path: <netdev+bounces-238319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D1C573C9
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96BF6355830
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B2346FD1;
	Thu, 13 Nov 2025 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ub/sFsU6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nC9pGQLk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F9347BD1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033734; cv=none; b=H2u4ogx2sj3x1ZWbtk36plCeC7WxcwRccmH+orK3pUdy/Ed6gXAwdV5sn/JY/Zp1pcxLSD5HyZ3VOILxLb3jjrD3fZyrTnB2kRi334wpdrbwpkhJlThUGCOjhCOF5pfGnsHiA9+VYX62bELL4kWuqx9qq51fLQdfkuexVbonfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033734; c=relaxed/simple;
	bh=fp63++1V0e2rfbzvo0CJD+DkxvCoDYR6emQAJ407hVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5Tp3r4shlR5X6QIi/OA/hMMbQoGu+LCt16TTxwCKHSAQ1J89Xp/chgCL7DR2/zU+xQyOxGOV0ZEuupbKtmBObi1n6y2oO5at1lSJCGGqpMaiHyAxmWOscXqvBFcm3dwcw6x255MsUe2ITaDbZ7uuqYWPDlOJAealsn+M0eBEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ub/sFsU6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nC9pGQLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763033731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6YTfwOkU3WoxTlG9t9+dRYuueXmgcFUpkZem7cnN1c=;
	b=Ub/sFsU6pUL8lCEE6psqQd3dukT0ucNnofUWDMns0Yl2PDWhzg7T1v415b+mmv1iAa0MKA
	mYyesEfMZsnIAnQ8Db/ImsFmbM4oG8BGmkS2x2yTlxEg8evgOYfye09HmNPG9FC5BMTGUM
	7cF836UivTruV88jb9OIyI7JNAzbR8Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ZjaI5DsSNeaJ_BYkvf-Acg-1; Thu, 13 Nov 2025 06:35:30 -0500
X-MC-Unique: ZjaI5DsSNeaJ_BYkvf-Acg-1
X-Mimecast-MFC-AGG-ID: ZjaI5DsSNeaJ_BYkvf-Acg_1763033729
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so8510955e9.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 03:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763033729; x=1763638529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6YTfwOkU3WoxTlG9t9+dRYuueXmgcFUpkZem7cnN1c=;
        b=nC9pGQLk/eKdFjIwarDwmSA0dkU8mZpx9IZH76cv6PChOl0Y4eFOeuEXJFMBmivzaz
         z+rGBrQwyXZhS5UIEf5lH+IVtQoezzYmkNkzWDfjovRu1tAURe1PIYT8n5W+WBtWQUm1
         ScUcVcyxyhKUEDqF3aU/jyiBNoecNqPMsshIyQBsCfVZSKxbefXUnhud2ySom7l63vtI
         wp6lTGbGBSGSwPSzksRICyiZeCLOm6U6RLaiu6P0gEospqmOq2c9O3N4b1CYrcVe/Ekp
         61sHqVGwd+geskvsMYQf7y90jTz5LcKdfX9uQyjt8hwBkHsfCzUZaMO8+dmX65sPe9fq
         PbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033729; x=1763638529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6YTfwOkU3WoxTlG9t9+dRYuueXmgcFUpkZem7cnN1c=;
        b=AdvGnJOMZ5IsIKIs2wBPqeabClHTn3xeN3+EwwGn7quPdABSXGXRJ9Kv6EgOgvAtJB
         hsSiCgE979TM6NMkM5uTjU/q/ftipqhrsurspUHXP9eMpogNg5uMcPyFZyLQMSgiFDwf
         KwPpKkPcVyfbAJzlcsH8Th8UWHAsxRcRhAq8SzHbZMD9+O2P2NygKhArE50lO0kZu3CL
         ED3W0fyTbyXUoadKqFlPZEBhhFzMwiX7ZrwRXQP3yaTgEP7eenIviMcMsv1oekI79Svm
         TgL+19UDwRFkpgP+p97gy1pTGyIi3vBGW6wdZ2rt/gLqYx/fa6w11TV2aSg4iullIDNv
         8iYA==
X-Forwarded-Encrypted: i=1; AJvYcCX+2ZI8g0pGtYIt3dt6/OQy5/QlWH7uNzM5lhTXGgtIKChVBw6+WZkLZW7VVtEdc+ojvrQr8p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFzHo6s5kjgmUkluRG9Cq1PyeQIG160+RHGTA1IGpCu9NhhyB
	430h/tnqqBFixqsAGGJr0/uLUH5AHuZ80YG9UHCDMdoMbnu2UdbClSdubFIW6VUpIwXLku4aSP4
	sc6ClyPrh8HFWpUa3V3H23PGuUBQrHE6MB9+baLXUFAkGCQkmB3vXoxhuQg==
X-Gm-Gg: ASbGncs0Lfsl91DNCQzWH61ZtRXIvZgM7ENuhEPRgkiNVEI2UAHvDF/zHRx/h/huMoX
	+dJZvCfyoux9Y9abNZ9sEyonnmGjTawwI+GLdDlD42fM/u8NEodkJZlWheWh/5cUN0NIGsOUecV
	vKlkt1qkUQYiNCYygpi/dJt5Lg8WxavwjbIfCkzaxsTAZAknLllRRVbwfZQYcS406KVU13heoq7
	azRS+kOKzXg6l1KfiURQTVciOpIDpe8rqbl2EQf1uZIJP155MthnC7GQJe58eK9a7hJCDTXVIUt
	y6QvxvrznSEkGCgPXwGAy/cz4NydmGVvcR/AgelnDf6Yusxnumz4i7ijsHXUKlHxropxL1S379/
	Wxdmi/5lc2xfl
X-Received: by 2002:a05:600c:46c3:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47787095d6amr62711145e9.20.1763033729378;
        Thu, 13 Nov 2025 03:35:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHovgs3xJAaDFCdTRQ+HPHalK2/dJ1kUrjxk/wksurzhmxWxvia+g4dTOLwghiwd15Dld1rTQ==
X-Received: by 2002:a05:600c:46c3:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47787095d6amr62710885e9.20.1763033729021;
        Thu, 13 Nov 2025 03:35:29 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bebe628sm16644845e9.13.2025.11.13.03.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 03:35:28 -0800 (PST)
Message-ID: <8c6d84bf-fb2f-4096-8725-9c398e7a985e@redhat.com>
Date: Thu, 13 Nov 2025 12:35:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/5] eea: create/destroy rx,tx queues for
 netdevice open and stop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20251110114648.8972-1-xuanzhuo@linux.alibaba.com>
 <20251110114648.8972-5-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251110114648.8972-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 12:46 PM, Xuan Zhuo wrote:
> +int eea_poll_tx(struct eea_net_tx *tx, int budget)
> +{
> +	struct eea_net *enet = tx->enet;
> +	u32 index = tx - enet->tx;
> +	struct netdev_queue *txq;
> +	u32 cleaned;
> +
> +	txq = netdev_get_tx_queue(enet->netdev, index);
> +
> +	__netif_tx_lock(txq, raw_smp_processor_id());

Why are you using the raw_ variant? This should be smp_processor_id(),
right?

/P


