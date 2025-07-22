Return-Path: <netdev+bounces-208948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1770B0DA8C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32387169F4A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51532E9EB6;
	Tue, 22 Jul 2025 13:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF1ADDC3;
	Tue, 22 Jul 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189841; cv=none; b=ba/vDxDkqvorXcxrvYPD2GCY5xkabV+xrf1+IE2IWeZbWwG0lUH+YuiU7pYtdWP774fFK1+7I+WNAVKaNcyeg6ttDHo7p2IWN/G5vWiw0dzfyge2F3eIc5iUihLX9Hx66+ew8GGNDFhOzTVLlRQvDAh916IGQYkTdcCtA1cns7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189841; c=relaxed/simple;
	bh=xhp3IAbv15GIwkAcxXSngNn7XHPu7+cNfK2ox5C6KZ8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vCai6HReg68r/X3+IIACB5F+bw2I41WBdI417ZRfrMpFC5XWpivvgnWKgDVhJa/zq9No8CKS9V/TYWvLIDlK4gOkcccMci9WDmeRMIkTRrykpSVEB95xVMRtuwYDSRzpyd51u2GCthC/oS8Z2X/7R+dF37l3i9gQHEirXEMgcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxJHDJjX9o0ZsvAQ--.55754S3;
	Tue, 22 Jul 2025 21:10:33 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOTHjX9ooeQhAA--.45201S3;
	Tue, 22 Jul 2025 21:10:31 +0800 (CST)
Subject: Re: [PATCH net-next 1/2] net: stmmac: Return early if invalid in
 loongson_dwmac_fix_reset()
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250722062716.29590-1-yangtiezhu@loongson.cn>
 <20250722062716.29590-2-yangtiezhu@loongson.cn>
 <20250722144802.637bfde0@fedora.home>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2fea78e7-9e0a-4c6b-9d86-6433e4c28e5e@loongson.cn>
Date: Tue, 22 Jul 2025 21:10:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250722144802.637bfde0@fedora.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOTHjX9ooeQhAA--.45201S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurW7KrW5JFWkGF47WrWrXrc_yoWkGFX_WF
	ZYk3WUW3W5Zr4fCwnFgF9xZrnrX34UG34UWw4UXrnrK345t3srGFs5Zrn5uF43Kan3Jr98
	Gan8WryaywnF9osvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=

On 2025/7/22 下午8:48, Maxime Chevallier wrote:
> On Tue, 22 Jul 2025 14:27:15 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> 
>> If the DMA_BUS_MODE_SFT_RESET bit is 1 before software reset,
>> there is no need to do anything for this abnormal case, just
>> return -EINVAL immediately in loongson_dwmac_fix_reset().
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> Do you know when that could ever happen ? I'm asking because this logic
> for the DMA reset is duplicated in several places in this driver, maybe
> this could be useful for other users as well. I'm guessing this is to
> avoid waiting for the timeout when the DMA reset fails, but that is
> usually when there's a missing clock somewhere (such as the RGMII clock
> from the PHY), in which case I don't think the RST bit will be set.

To be honest, I am not quite sure the root cause but this actually
happened on the test environment, I guess there is a missing clock.

You are right, the initial aim of this patch is to return early for
this case to avoid waiting for the timeout when the DMA reset fails.

Thanks,
Tiezhu


