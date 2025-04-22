Return-Path: <netdev+bounces-184556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37537A962F3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 10:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D807AC2B2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C21EEA56;
	Tue, 22 Apr 2025 08:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B3190472
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311561; cv=none; b=EuvrpdrOrMWczrJCvHrhAvFCWrQTz8PDH9qCboMDx1sbP0Fij/PVvJk9hnvmyvZteaLasKG93d2czXWVcW+YNKPy2FaERoFAGxN6C4m9C6utJsxYA05QxAiix5844UlbCb6XjXmEbe9oZfNOi5hhV48PomPPwra3nM/KffmfLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311561; c=relaxed/simple;
	bh=j2gLR+gqbdCq4gkSRUhrRYAJ/a4ydFvHkWItYJc5b3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8Gho6RNVJfdpj/2j9DDf+9rBpGtkAdN1qjCDLdUHWyvieNz6uyEo5yzMItHS3pzWtItYEk/BhGK/Zp9ine3AXHHTT/PfALu5LfPIxh2fFB9r3g/KpxYeDtQMOlAsn+jnpZqUl5oyyFp+7svA/gFVkXvl7uX9zzzsBQkFY3Ofsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from [10.200.238.150] (unknown [111.199.68.190])
	by APP-05 (Coremail) with SMTP id zQCowADXEgs6Vwdop+UtCw--.6356S2;
	Tue, 22 Apr 2025 16:45:48 +0800 (CST)
Message-ID: <131a4587-40d1-4cee-8f5f-52d9f6920034@mails.ucas.ac.cn>
Date: Tue, 22 Apr 2025 16:45:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [?bug] Can't get switchdev mode work on ConnectX-4 Card
To: Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <8b96e37c-842b-4afb-9c61-f71674874be5@mails.ucas.ac.cn>
 <091ec8be-34f6-4324-9e79-d2fbc102fd6b@nvidia.com>
 <90e40d18-ad31-4408-95e8-0cbe4fb12786@mails.ucas.ac.cn>
 <39f1ff89-787a-489d-8ff5-9b90897afd28@nvidia.com>
Content-Language: en-US
From: Qiyu Yan <yanqiyu17@mails.ucas.ac.cn>
In-Reply-To: <39f1ff89-787a-489d-8ff5-9b90897afd28@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXEgs6Vwdop+UtCw--.6356S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JrW5AF4UCw13CF4xWr15Arb_yoWxtFg_Cr
	ykWa48uw17Gwn8K3Wrtry5Arn3K34DXryxZanFvw4aqryjvr45W39rAa47ua13AFyrGrnF
	q3yUZ3yav34qgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	c7CjxVAaw2AFwI0_JF0_Jw1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUmFAPUUUUU==
X-CM-SenderInfo: 51dq1xl1xrlqxpdlz24oxft2wodfhubq/1tbiBgwAB2gHJ8bGdAAAsx

在 2025/4/22 16:14, Mark Bloch 写道:
> so you want to do QinQ (not sure cx4-lx supports qinq)
> or just different vlans based on the traffic?
> I don't think cx4-lx supports vlan push offloads.
Just want to grant access to different vlans through a single VF, the 
command with ip
  $ ip link set <interface> vf X vlan Y
filters and tags a single vlan. I am wondering if there is a suggested 
way to "pass-though" multiple vlans to a VM that I can create vlan 
interface in.

Maybe this patch is for this: 
https://patchwork.ozlabs.org/project/netdev/cover/20170827110618.20599-1-saeedm@mellanox.com/ 
but it is not merged yet...

Or I have to put the VF in promiscuous mode/pass-though multiple VFs?

Qiyu


