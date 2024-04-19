Return-Path: <netdev+bounces-89570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE07F8AAC4A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF66B23144
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E088005E;
	Fri, 19 Apr 2024 09:51:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9080020
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520311; cv=none; b=CdnJVav+zGsR9MExt/D0y7jS9SGo6Huu4TBJPscCwMqWzuZgtBm0mljkA2c2Oa1ehAIHx/TIrb/3Ib96bBUI03WM4+m03YfdWT43H7yfa3+wAO3LCukxkpqisROkp+slySbYZZQWWJIxxAhAjGnxLtCZpp+Cq4UT/+0dwPDbO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520311; c=relaxed/simple;
	bh=cFN/aI+5zfLuqoHxJOFDt2JTiuvP5XQdCg9UqO9XUwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diWZYPOl/xJU3AmtOdVtUW+PtTW4GR8BPDnl8w6rF8HbZoCQbvpAuGtqn1PggqhHs3MkmQiSgoZB+Tbs2qMFvAK+MIMeo7pO8fc6S9tyTvizU+w1abXKyq8N+45PFqO1LWLaa5xc2AqYGDK2Unj4yj1EEAsh9KaHZuamTlGJo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Bx3+uyPiJm5L0pAA--.28711S3;
	Fri, 19 Apr 2024 17:51:46 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx6xKvPiJmuxmAAA--.50026S3;
	Fri, 19 Apr 2024 17:51:44 +0800 (CST)
Message-ID: <6877aa3a-3147-4cfd-892b-f23a2b3a1ffd@loongson.cn>
Date: Fri, 19 Apr 2024 17:51:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 2/6] net: stmmac: Add multi-channel support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1712917541.git.siyanteng@loongson.cn>
 <5b6b5642a5f3e77ddf8bfe598f7c70887f9cc37f.1712917541.git.siyanteng@loongson.cn>
 <5v6ypjjtbq72ovb437p6n4fkq2z5a3nhkv6spjct2flvjaxmgq@ykrdiv7kk4kq>
 <636a0d00-3141-4d4d-85af-5232fd5b1820@loongson.cn>
 <juwqvnv22ky5avg72prgi2ocx7qy4kqldet4t4qfooerj3p6nn@lrnlkioxxevy>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <juwqvnv22ky5avg72prgi2ocx7qy4kqldet4t4qfooerj3p6nn@lrnlkioxxevy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx6xKvPiJmuxmAAA--.50026S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF47AF18ZF4rKr1UXw18WFX_yoWxZrXEg3
	9xCr43C340vFn7u3Zru3W7tF9rta40g3ykWFy0vr4Ig345JrnrJa1vkryfWw1xXayxGF9x
	W3WDX347Z34avosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU


在 2024/4/19 17:17, Serge Semin 写道:
> The change in the patch 2/6 concerns the_generic_  DW MAC DMA IRQ
> handler. You can't change the mask here without justification.
> Moreover the generic DW MAC doesn't have the status flags behind the
> mask you set. That's why earlier we find out a solution with creating
> the Loongson-specific DMA IRQ-handler. You have it implemented in the
> patch 6/6.
Sorry, I misinterpreted your comment earlier.
>
> So my question was mostly rhetorical. You should have dropped the mask
> change in this patch ever since the Loongson-specific DMA
> IRQ-handler was added to your series.

I see. I'll restore this mask.


Thanks,

Yanteng


