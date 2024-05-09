Return-Path: <netdev+bounces-94911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750AB8C100F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D934228445E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FAF1482E3;
	Thu,  9 May 2024 13:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068BD147C83
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259712; cv=none; b=tWOsToGbli8dEze8ZmVuAfo1wMuODBRB1w5+hck2/sq0fhQ8+RMnEpcxbgFNZiUOTsNpeKEtTiMBCHhYIeQ0LQlFAc9VWd2LAEgMizCwKKcXtZok2mxmEAeO5dMO0ugnQXBl0hLhoWpVcw5wlKg6qt6K6GA3Nwl//FIvQuRX/4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259712; c=relaxed/simple;
	bh=Q//Z5QwFXiCEgq1HiyCeRx9zjL8r4vevB19/ugkMHYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAcFaantw2xENVtE70/CsljRkJ82vIyaiyC+qb0dgmGInlks3/V6t/j0fYMW5hhEwgEhNiFrakHp/Nox7z4uVESmOh8TWLp1wFPeYl3tC0l5DSjsrkY0P44j4iArKwTIH2F/L0i5biYfSY1n0nP9GgoIVxDOKuTuCPm/W2twEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8BxmPA6yTxm8vkJAA--.26424S3;
	Thu, 09 May 2024 21:01:46 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxKOQ3yTxmcwYXAA--.43809S3;
	Thu, 09 May 2024 21:01:45 +0800 (CST)
Message-ID: <499acc4a-d178-4d43-9c0b-de28183abcef@loongson.cn>
Date: Thu, 9 May 2024 21:01:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/15] net: stmmac: dwmac-loongson: Add ref
 and ptp clocks for Loongson
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <aa9e291e181017146f88238cdeec9f18759915c3.1714046812.git.siyanteng@loongson.cn>
 <26kbmvputkbfuz7zdfa2wblsgz5sn6iwucwscswwrpbu7ttwmj@3btn75ewpdwi>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <26kbmvputkbfuz7zdfa2wblsgz5sn6iwucwscswwrpbu7ttwmj@3btn75ewpdwi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxKOQ3yTxmcwYXAA--.43809S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw18uFW5Gw18ur1kCF1Utwc_yoWxAFc_W3
	9Fva48Ja45G3WrKa9rtF1rZr43X390k3WxWrsrWr48u3s0vFZ8Zrs7uFWqg3WfXFsIyr4Y
	vrZ5Gwnak3Z2kosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xsqJUUUUU==


在 2024/5/4 02:21, Serge Semin 写道:
>> [PATCH net-next v12 07/15] net: stmmac: dwmac-loongson: Add ref and ptp clocks for Loongson
> s/ptp/PTP
>
> Mentioning Loongson is redundant. Just:
>
> net: stmmac: dwmac-loongson: Init ref and PTP clocks rate
OK.
>> The ref/ptp clock of gmac(amd gnet) is 125000000.
> What about a log like this?
>
> "Reference and PTP clocks rate of the Loongson GMAC devices is 125MHz.
> (So is in the GNET devices which support is about to be added.) Set
> the respective plat_stmmacenet_data field up in accordance with that
> so to have the coalesce command and timestamping work correctly."

Great!


Thanks,

Yanteng



