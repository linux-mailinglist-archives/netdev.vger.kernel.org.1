Return-Path: <netdev+bounces-111713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8D93234B
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502F2B24C54
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F99198E6D;
	Tue, 16 Jul 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amvzQQGB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3D198852
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123178; cv=none; b=ZdsW1+CT2Bt52lBnxk9boGl0GDzegiAYLCJYhcaF6p6ksCfI9bw42klw2Fo3Ie2a6EfUZi7eflSDemKN4axtljTcpGkm0+fu4oAGCZPhGDNzqciM+5CB+jpZjxJhqMkY926WXCVOVvGwepJr0qfYExVdxI8X/zf5jq/ZWxltZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123178; c=relaxed/simple;
	bh=MuJNU1T3c+rq29kKQ/IzwJetlpRBmyymvehDVeTlyUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pwwmxaFlGXRCOhwfqrNynxkDR2und3f1Syl8Nj3die/shc5vS+Dq92N9wtuAcZ60bes/d2hk3dAXpXD8Tu/zyNgXpqX3W9DIBqlIaTiJKfum4/WAgkYlYpw7ypZGvNwKifal23zpCDxW4zAsXxgEjM2kfkZyULFsF7ecba99O9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amvzQQGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721123175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVTAsXyhEhNtCMOyvfccNfT6abKfoWaC2WG7+Z3JHng=;
	b=amvzQQGB4Ep70aesAjZxXYl4VXhGrYqcffW2CDu805fUBxHKkOsmnbimeS4OEeSvCJ9+t3
	loUpywOfAC+772FvdQsF3Afw+lx8THe6t13NwK+RniRvDev9pvI3OkL9rHWlRcDyea6OVK
	paWlzcQmd/tDwm6Os1w8DJ09CAw4WlI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-Kw5H5_T5MVqAf0jtpNtuWA-1; Tue, 16 Jul 2024 05:46:11 -0400
X-MC-Unique: Kw5H5_T5MVqAf0jtpNtuWA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367a13df177so46427f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 02:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123170; x=1721727970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVTAsXyhEhNtCMOyvfccNfT6abKfoWaC2WG7+Z3JHng=;
        b=fV3eGBUs50c/9Q/DG5wECq0Li7M/8y7OQQmRpknHH5xsDQylArImWnlcfz+EGzyIQH
         2n3PYy7b5pIYjOcZoT73iFvuZkRmkfzC+JTGyMI7nL48yvVgm4qCjizYFaWvbLm4I55u
         LuFYTyKUBMVwENB/1/ZyZExHKmaMK5Q+znN0s5HGKGMK0ZychZeEsbdeywPn6U9oW5fm
         qtCDApVWtbDAc9Uiabw+iqky7Tgi+jo/zdQJQ9bhJGTU9/qZLjg4c4TUIrNxhyBuh7B6
         g6JEMwltjFagRZL2x0Bq3adGCUouGV7UkuW4bl4ELClHyZmLCG2j4dXNgvPnsL8usq5z
         0AOA==
X-Forwarded-Encrypted: i=1; AJvYcCVnk7KIPWmJzEL5Kwt079i4OcMooF2GuBdygIO8mDA48dZj3WcJbD0Zo2TCAgE7UIz4Ccdcn6tcK25SLLv69fNZHHM8m14T
X-Gm-Message-State: AOJu0YwgaKYM+u9svkefmM+iBxPbF7tlRpiiD34sNAK7aJ2n/pcLAwcf
	85hT5qHJ8PHVlmuB75c1ykgd+MkOlBcjwK8SH8Pjf0R7ztRb1chD7mVFxDR/yGwv6RVxCTVqh9i
	WFlsWLIN3oxAbv+s74pguKQV/nrIbDDXftiwSLLnKxGEllJTCsXuV2g==
X-Received: by 2002:a05:6000:178c:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-36823e5933bmr1052627f8f.0.1721123170615;
        Tue, 16 Jul 2024 02:46:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5xQI8nA3bO4/vGaWiWPyzzVJObEGcNTe+htH+LhWyGA1wvfDs8jCXpBBEiX25SDN9niA1hA==
X-Received: by 2002:a05:6000:178c:b0:360:872b:7e03 with SMTP id ffacd0b85a97d-36823e5933bmr1052615f8f.0.1721123170269;
        Tue, 16 Jul 2024 02:46:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb449sm116993465e9.35.2024.07.16.02.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:46:09 -0700 (PDT)
Message-ID: <b5a2f43e-790f-475c-bb63-539af91513ac@redhat.com>
Date: Tue, 16 Jul 2024 11:46:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: lantiq_etop: fix memory disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, shannon.nelson@amd.com,
 sd@queasysnail.net, u.kleine-koenig@pengutronix.de, john@phrozen.org,
 ralf@linux-mips.org, ralph.hempel@lantiq.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713223357.2911169-1-olek2@wp.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240713223357.2911169-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/24 00:33, Aleksander Jan Bajkowski wrote:
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
> index 0b9982804370..196715d9ea43 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -478,11 +478,11 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
>   	struct ltq_etop_priv *priv = netdev_priv(dev);
>   	struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
>   	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
> -	int len;
>   	unsigned long flags;
>   	u32 byte_offset;
>   
> -	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
> +	if (skb_put_padto(skb, ETH_ZLEN))

You may want to increment tx drop stats here.

Thanks,

Paolo


