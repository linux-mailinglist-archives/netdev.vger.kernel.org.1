Return-Path: <netdev+bounces-231103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1E7BF513A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB0E481319
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21D2C2358;
	Tue, 21 Oct 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2iM//S8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09812BE641
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032929; cv=none; b=YiJCdzo96x1S0lghojElCcJS+gCDXLXhUONfzeTGgh7/+nV7IOkEeKpcR1BrXR1lO8PvdAJ/nrQ7+hOuOHuq57mSe2xxzXRkplYpGVAEbf0MMBYSnVK4Er0nETYhkcUp4FA0OtAzc6PlKiIX1wkG3/RYor+oMGbExtRu0vNi924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032929; c=relaxed/simple;
	bh=VHRBJsfAr2qGt0Z8v22p7PNBUWoA/PfLkGuxYAgfMAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5aWe/e9Wx3fsCpZ7UvnY0w0kF8llCd2DLoyU+i1vkQ+hR2ERpWh0vczU8/P7OzhCIbVAtR1rjlvUE/ESfKnQ4nv5+7nuIgwYggWEH/SfLbnv1IdIeLTw9DVOswoZI8g8DbVq4cEfWPo5dXIA4Lu168ted7CBB9i9JdN2/aEG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2iM//S8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761032922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+vFSNeJbrIcTbTwCLbwJ6HuwmqBgLQ/0qJEsgp2yBo=;
	b=i2iM//S8p2kT/1zy65sigkKHhHwx/kF6R2eVyyOoh4+NyN5IA4ImFBXcRSLbzz35X1qxje
	bmUoXOH106xPOyPBdFWyC9u7Ta/ZWkELk54LpkIWUCT84ib6wtObdPlO5Y9w8ECnU/7htt
	g19NBrO/K57bUN0tDlOsfUYbUVfpNT0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-i79itEZBOoOr47mLw3b6KA-1; Tue, 21 Oct 2025 03:48:41 -0400
X-MC-Unique: i79itEZBOoOr47mLw3b6KA-1
X-Mimecast-MFC-AGG-ID: i79itEZBOoOr47mLw3b6KA_1761032920
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4283bf5b764so1593945f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761032920; x=1761637720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+vFSNeJbrIcTbTwCLbwJ6HuwmqBgLQ/0qJEsgp2yBo=;
        b=Q7zW4DQ+wg4yEp0gnkGEcphMd7YzNlknWjNqp/AIs6U2RJXJOgggPb+xu23Z2Fb2Ot
         chBLqJPgXbogDXSn13XC6GwpB8iidYV0dTmeLEulvtXVrATEyrwyJvyXnFCAo++9OCfg
         vJbJEjKCP5pslqyozfJYHdKqbPHWNZ/e766RJG+/vOuHY9IhfEzOdxT3fN9jqxo1dFh7
         gkDNXWmzhEeJ18m7h1G0C1qeLiDTHljNv8+M9XfzrWir17HZa+ZgDrVZnBJ2XAfCrV/B
         73atIPKMHO8ViadbDxQshmruhAt9lLKvG0W7MkC6KnapQ4XVLmkyG8owOXlHl7huohLW
         2E8g==
X-Forwarded-Encrypted: i=1; AJvYcCVfQ/5F82wgtw0HxBazich/s1LNyMKr9EJvWQFc4p5TA5QsuJ7LNEZyRBMpxkoVSu9/1DEcvew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtneibhIKAgmTM4URftYMlSiPvVoQKD+mqNuCrhg88jXAI8Xa
	CtCkJq1NaRkIIigO1KWl9LQnCmiHRCAQ6U/NdOmbETh2K1XonslmgflC0/iJp8aSlUKTg2abTii
	r/oz/zsJuuPwtMX5fm9fGwn4aQwOkcPAwa2hhqtr524ZakcxQ/Rjj7aKI3g==
X-Gm-Gg: ASbGncvbTcWcUqT0cZY5ISAfyMyWR6myHscogLBUaASycAHrIaEKcf28HgNGwoIGdlp
	5aya4IXlDnTxopLmqI1eyCxLv3b0hua5+Z6bHX508y1VpLwDh333fGCSTY4m7KRnZ1vyWh9FWgk
	aMdFggIR0RuQ/qTzUtvojE+gTO1B/V5pVyOWu3yJuvDI3e2Wb2a8V4GrWNgTDkHK53poGtIYvyV
	Q2xHCO+xNCtHTQSBU/KyR4f5JiEYnkXgJQuy5kmzbMWuLoIJN50R90pXR6pC8A2eDRMs4AsGYtv
	Gq65uSaBOdzShyo/JXzY2tdXFtYntSsfnnMoGgWN52EkbHlv3I1uPAx+HZAH50jy0fqv0m/rlGS
	nqDEWdER06xp75LiUWxaHIkpb/A/dxOa2MUA96PBfUhPenTM=
X-Received: by 2002:a5d:5d85:0:b0:3ee:152e:676e with SMTP id ffacd0b85a97d-42704d4997emr11399017f8f.11.1761032919849;
        Tue, 21 Oct 2025 00:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLdFK8T7upYxlEKY6DXMSi7+r6EJWeeJzPKMSgemaNQXjS9D08i6Xm5X8clt9Cy2vapfV1/Q==
X-Received: by 2002:a5d:5d85:0:b0:3ee:152e:676e with SMTP id ffacd0b85a97d-42704d4997emr11399002f8f.11.1761032919471;
        Tue, 21 Oct 2025 00:48:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm18521219f8f.19.2025.10.21.00.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:48:38 -0700 (PDT)
Message-ID: <4bd71307-fec6-4a73-8b06-dc270a2c705f@redhat.com>
Date: Tue, 21 Oct 2025 09:48:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/5] eea: probe the netdevice and create
 adminq
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
References: <20251016110617.35767-1-xuanzhuo@linux.alibaba.com>
 <20251016110617.35767-4-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016110617.35767-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 1:06 PM, Xuan Zhuo wrote:
> +int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	dma_addr_t dma_addr;
> +	__le16 *buf;
> +	int i, err;
> +	u32 size;
> +
> +	if (qidx == 0 && num == -1)
> +		return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL,
> +				       NULL, 0, NULL, 0);
> +
> +	size = sizeof(__le16) * num;
> +	buf = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

AFAICS all the callers of this function use num == -1 argument, why is
this other case needed? I guess it could land in a follow-up actually
using it.

Requiring memory allocation to perform cleanup operation is dangerous:
it may fail under memory pressure, making the memory pressure even worse.

You could instead pre-allocate the buffer at initialization time.

Otherwise LGTM,

Thanks,

Paolo


