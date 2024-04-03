Return-Path: <netdev+bounces-84324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8A89689A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5225628187B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF3129E72;
	Wed,  3 Apr 2024 08:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428AD6F07F
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132637; cv=none; b=GcWppixKfQEjPlq/2/cu+awdrjTjjSjy/R8FJYQ/BDwnfKE76wYw/29T45KcOctPrm9e1ewbzFGuluiuZnXtDMm0CQtnWDoLnr/XBjQIPNPBF2WvyBgtnUpX18ZgKe3DL9HwQKOswuWaGjl/4QIv9NdlDRGFjyhJw/gG65ADV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132637; c=relaxed/simple;
	bh=tz2aWWshY3gsOg+VxFCIHfz+sZ7zw/OGdUO9iNw6wkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNOdF03ePVEXp5LTvoswdIFf/0u5QnOK3njynOCv8qVj354hCY2rPhCi5vKgVfOlRc4nvjQjBwVl5+ZPk3KUzDn0ZPYV5EY/R8u2BSbqzpsbPskRbnmXQlLthhdvSNTkDg57u9lnUc67NJI5MSdvcPNkW4vobKjfE4JbRenhHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8AxjusWEg1m_LQiAA--.13926S3;
	Wed, 03 Apr 2024 16:23:50 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbRMREg1m4U5yAA--.24407S3;
	Wed, 03 Apr 2024 16:23:46 +0800 (CST)
Message-ID: <f9ad55ec-8e37-4818-b3e2-5516a6f0f197@loongson.cn>
Date: Wed, 3 Apr 2024 16:23:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 07/11] net: stmmac: dwmac-loongson: Add
 multi-channel supports for loongson
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bec0d6bf78c0dcf4797a148e3509058e46ccdb13.1706601050.git.siyanteng@loongson.cn>
 <eqecwmi3guwda3wloxcttkx2xlteupvrsetb5ro5abupwhxqyu@ypliwpyswy23>
 <e1c7b5fa-f3f8-4aa3-af4d-ca72b54d9c8c@loongson.cn>
 <f9c5c697-6c3f-4cfb-aa60-2031b450a470@loongson.cn>
 <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <roxfse6rf7ngnopn42f6la2ewzsaonjbrfokqjlumrpkobfvgh@7v7vblqi3mak>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxbRMREg1m4U5yAA--.24407S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
	Ij64vIr41l4c8EcI0En4kS14v26r1Y6r17MxAqzxv26xkF7I0En4kS14v26r126r1DMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==


在 2024/3/19 23:53, Serge Semin 写道:
> Then those platforms will_require_  to have the DT-node specified. This
> will define the DT-bindings which I doubt you imply here. Am I wrong?

yes，dt-node has specified irq information，and this driver also work with ACPI
configuration.

Thanks,
Yanteng


