Return-Path: <netdev+bounces-175666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D5A670E3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618393ACAC6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A15207A04;
	Tue, 18 Mar 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQpgYCmf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8400205AC1
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292809; cv=none; b=Sx3yNsgNw0CKcImBFu3xCX3LeX2fzII6HbL9r66zJ3V4UxEdaT/YjIsfxqB1yBkm/ldAIXrXhowsI9jB+N2Nc4SLuJrBpStFUmNbVXy5Cmx6GXFyyfChhqZPkAkgf22i7kgMC3GczNpxX1uhSfqYwlqONKIQFdE7RpsYOQve1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292809; c=relaxed/simple;
	bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRRD+Mrb87PAge4goUPB3eYhG3Zzyv5p5qf/YVX/2EFo8/r+eIhQUzxc1Ete6dFS+S80zDUVg7STUI6HLiwao7avma2Zd+wiEItgRCubXrOrohTHQX20Ui9KlSgCBXW11CyH/wLoLSwSWIK3rYNy3DlKB3tckrymFGrHa72OVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQpgYCmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742292807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
	b=AQpgYCmfpA2TBL9C2S2jkX34ddR0CnZKOoYKQbKX/3evvYkWW+bPjcFOit+tFC/2noS2Sc
	pyp1YrNhQ7zrpCScspKNxPf0WUP2hGBvrIKKkpyQYCY+Iy25TtxlD4uXMvxSsRhl3DfwEw
	zoXJeNtVbPahL/3ghvYnAf2svs3QQh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-s15r23kPM0yIhuXV98v35w-1; Tue, 18 Mar 2025 06:13:25 -0400
X-MC-Unique: s15r23kPM0yIhuXV98v35w-1
X-Mimecast-MFC-AGG-ID: s15r23kPM0yIhuXV98v35w_1742292804
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so15410975e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292804; x=1742897604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
        b=uEk+PETvCCiOIYhbA8RfNGuHtv6A00dPq3wmH+xsXKQYz3hVkW7idE2dw/+Xpe/1NW
         5RaqN78mdfCC1z2i2JqoizmKcRAeeiiJWnZX0G6pO1ato8+XYdAk5d+LYqK8klliSC9W
         HIokxNM7pCKh8xIwe6H7WHGW9+37nXNgOfLHhyGIrbM+v8ekjF6m/AIGIMfJNtXf+c4o
         9OjxdlKx5vvMxMxQUdZCoOVkGZ5M1nTz2KDIOI8kWZ/2yGX15SWrJ/tQ1M94zkvo9Rrw
         nJcHrVOUs+d8lNtSlnYUNY1D3HKYd1a1BSirS17WRwBwZFuf2Y/aVfbfbPcM+XmKBxpm
         B4XQ==
X-Gm-Message-State: AOJu0Yx931z18kgNlbHo+xZQpMSblk+1gOLnTVtV5kC2tnUryEhgASkp
	9LmjEi43bTvWYBK5stiyKRIJJ3ZDK+C4HgriTCIpbUuqBmM81KEIIzJWhzIfv3vF/33QdNNogre
	47eejGvP+HIeDYcmG7oVxrF8IAKsn7F1v/AnE+H2rmkEuybS5Bz4Mvg==
X-Gm-Gg: ASbGncsxR0Z9muEssR/JawX91fgnXHvyygih7wsBDfHhVN14vQiyKpuVWmuFZur5kcJ
	pwepX1g7RB6qHGtaQBAZnAxp/48pSxlRR7fW9ixq4joTf0fPgIfV0gGWtf29PRBvFq9jviKeO+8
	CUi1KZ43q5CV9McSc11cya6DRyNOWnTsHS+QDSd5RIMsoiabkTIO+EjM6H4DqEA4HmgMmWAD0ob
	4ZY+oxJ5JQfKv8tu5Qpzu+0klwBeuLCeWm6y6IPxUGqi85tbG7OTg1ZQZv40HVLyMzS57vorE2k
	ah+MgMhvt7Oe2lG2AcdZinPF0fQ6y9LrglVQK3/E9mG4YA==
X-Received: by 2002:a05:600c:5112:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43d3b9cd704mr14645115e9.19.1742292804464;
        Tue, 18 Mar 2025 03:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa2x79C78ENEoyzPPniqeGCkHBce2M9I0jdc1yv0/RSaEENBZYufXun9PO4beIARs4YqnHHQ==
X-Received: by 2002:a05:600c:5112:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43d3b9cd704mr14644695e9.19.1742292804010;
        Tue, 18 Mar 2025 03:13:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609dasm129105475e9.28.2025.03.18.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:13:23 -0700 (PDT)
Message-ID: <6259af5f-f518-4f88-ada9-31c3425ce6ed@redhat.com>
Date: Tue, 18 Mar 2025 11:13:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 1:18 PM, Lorenzo Bianconi wrote:
> Introduce missing metadata support for some xdp drivers setting metadata
> size building the skb from xdp_buff.
> Please note most of the drivers are just compile tested.

I'm sorry, but you should at very least report explicitly on per patch
basis which ones have been compile tested.

Even better, please additionally document in each patch why/how the
current headroom is large enough.

Thanks,

Paolo


