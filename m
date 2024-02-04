Return-Path: <netdev+bounces-68896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3EB848C43
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073111C230EF
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DE8F4D;
	Sun,  4 Feb 2024 08:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D714011
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707036479; cv=none; b=hx70vzt2es2zn4x0DKyY3yiPlAmYZ9vb4v2/O73aPVrjny5IAN6A2C/n+hYAaZZhZLZWm+M6wmG2H3ue9q5U428U5xVVaHZjq7OCAWKFmAfujeEPsNWa0wH3H8PE6odAcr+0BVbUIWMwS6hCSiTi8FaIxn5QeFMrUBLh97o9FeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707036479; c=relaxed/simple;
	bh=niDXBfNwnOWxdoBKbLeGMhoxmn3LGfyE9cCbqoncwpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2Eesdo1UBFXyMUtWYNn9bM3f26prS+/ND/IqoLL61heRhkLYtC3WyANYg3nIzrV44MvNsS3wbMCTd3yJmqH526wSPvbnURzOMWZKNMwSkHrj57wL77wtACJGvqBHQyH7w6uVaL5HnCT6E5C3/J0u7ydWAidElyGDQNzTRfhg9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.18])
	by gateway (Coremail) with SMTP id _____8Cx77s6T79lNIwKAA--.10535S3;
	Sun, 04 Feb 2024 16:47:54 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.18])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxHs84T79lJUYvAA--.47238S3;
	Sun, 04 Feb 2024 16:47:53 +0800 (CST)
Message-ID: <5deddbfb-a8bd-4117-b948-313528d8e022@loongson.cn>
Date: Sun, 4 Feb 2024 16:47:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 02/11] net: stmmac: dwmac-loongson: Refactor
 code for loongson_dwmac_probe()
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <6a66fdf816665c9d91c4611f47ffe3108b9bd39a.1706601050.git.siyanteng@loongson.cn>
 <20240202123336.GP530335@kernel.org>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240202123336.GP530335@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxHs84T79lJUYvAA--.47238S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWruryDZw13GFyxtryktFWDtrc_yoWkKFc_Za
	y2ka48Cw1kZFyS9a4qgFW3Za97Wryq9F1rGF1qya4Fq3ZFvFZ8Ar45Grn7ZF47Ww48XFsI
	9rnrGr4rC34UZosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU


在 2024/2/2 20:33, Simon Horman 写道:
> On Tue, Jan 30, 2024 at 04:43:22PM +0800, Yanteng Si wrote:
>> The driver function is not changed, but the code location is
>> adjusted to prepare for adding more loongson drivers.
>>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ...
>
>> -static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +static struct stmmac_pci_info loongson_gmac_pci_info = {
>> +	.setup = loongson_gmac_data,
>> +};
>> +
>> +static int loongson_dwmac_probe(struct pci_dev *pdev,
>> +				const struct pci_device_id *id)
>>   {
>> +	int ret, i, bus_id, phy_mode;
>>   	struct plat_stmmacenet_data *plat;
>> +	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>>   	struct device_node *np;
>> -	int ret, i, phy_mode;
> nit: Please consider preserving reverse xmas tree order - longest line
>       to shortest - for local variable declarations in Networking code.
>
> This tool can be helpful here:
> https://github.com/ecree-solarflare/xmastree

Okey, thank you!


Thanks,

Yanteng

>
> ...


