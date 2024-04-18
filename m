Return-Path: <netdev+bounces-88972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8BB8A923E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38ED1F21960
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 05:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079234EB32;
	Thu, 18 Apr 2024 05:04:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE954FAF
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416680; cv=none; b=JHe3rB/1SVmkUrJBT0k1/JyjF27V0xMHWVOmqK45+sQRNajZe0s1rXIM1FufT7MYbW9OpusZDrtojtXEMrZqrwkMZUVwVRzDE9OWvsYrlGblAoMYiu3h2AwcbteAi9qYff9eWniuyeyXtuh7Orp/IzCUgkt0qchN/7CG52Twmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416680; c=relaxed/simple;
	bh=yPXNpAWsj0uRaeG+0sySLboQIrR362j/4oKcGu9NYNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFoLulVn9BMvF6x/ao/V5D0slcuYi7RxKt/4mw2oHZe6/Wc/BFkNjVffn9Yb2ydBrbx/3MeSiUD/IGd18WM93WsVgg4JN0PU1Qhp6XK34ybmZRazt6NpXEPwu+TW8gPoGWi3fTqus7972qF0EBvb9GHrfTds8foZZ8K7cdfRhyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Bx27ppqSBmpRwpAA--.12094S3;
	Thu, 18 Apr 2024 13:02:33 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxzxNkqSBmj7Z+AA--.55123S3;
	Thu, 18 Apr 2024 13:02:29 +0800 (CST)
Message-ID: <83b0af5c-6906-44b5-b4fa-d7ed8fccaae4@loongson.cn>
Date: Thu, 18 Apr 2024 13:02:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/6] net: stmmac: Move all PHYLINK MAC
 capabilities initializations to MAC-specific setup methods
To: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <df31e8bcf74b3b4ddb7ddf5a1c371390f16a2ad5.1712917541.git.siyanteng@loongson.cn>
 <zrrrivvodf7ovikm4lb7gcmkkff3umujjcrjfdlk5aglfnc6nf@vi7k5b4qjsv4>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <zrrrivvodf7ovikm4lb7gcmkkff3umujjcrjfdlk5aglfnc6nf@vi7k5b4qjsv4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxzxNkqSBmj7Z+AA--.55123S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr1UZFyxAFyUtF13uFyfGrX_yoWxtFX_C3
	yqkry3tw4UJ3WqqF1kCF45AFsYyrWxZ34fKryrWrn3K345JFnrWFs3Wry3Zr1rW397uF15
	Xr9Iy39Iqa13uosvyTuYvTs0mTUanT9S1TB71UUUUb7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jTq2NUUUUU=


在 2024/4/13 02:32, Serge Semin 写道:
> Just submitted the series with this patch being properly split up and
> described:
> https://lore.kernel.org/netdev/20240412180340.7965-1-fancer.lancer@gmail.com/
>
> You can drop this patch, copy my patchset into your repo and rebase
> your series onto it. Thus for the time being, until my series is
> reviewed and merged in, you'll be able to continue with your patchset
> developments/reviews, but submitting only your portion of the patches.
>
> Alternatively my series could be just merged into yours as a set of
> the preparation patches, for instance, after it's fully reviewed.

Okay, I've seen your patch. I'll drop it.


Thanks,

Yanteng


