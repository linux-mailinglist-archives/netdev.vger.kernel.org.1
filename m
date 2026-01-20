Return-Path: <netdev+bounces-251349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1631D3BE51
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 05:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 573FF34A4BB
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63F33C1B0;
	Tue, 20 Jan 2026 04:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80D33C188;
	Tue, 20 Jan 2026 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768882641; cv=none; b=NEIxRzfOegfOhivdL3vZB9WbYDesXnclpdn9us/J/aq/s2hqdUkUeyIVTMIJ7gu20Dx6f9JXeMsyqWJzYoJ6sCfYdwNkqJUCbSiozwqMAcPeLBlLT13/2jKmaw7UcpYYYmI+4lIscxyX+8HuLkRqepzccpwiDC2NLQY4frXuWMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768882641; c=relaxed/simple;
	bh=ygUdyNkfE2jAIcPl2nsg7XS1NoJnGgnoD7iI5CL6pEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjVJp0UjhiZavlnxTTKiRW9J0YzLzKimKZciJFrRSZCYUIvebGP3bwvq1jfxGVIxfqpTO/Fh5fQ8c3kQFxrLHHFYHKxLjGQyJqvZdS5U4L3a5Xjty6R9zS/orIbia4doeaur9fGui8Om+jOgaAJUO6JkkgASCifw/Ir+NHs8mvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.18.194] (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAAXqg21AW9pXw+3BQ--.1431S2;
	Tue, 20 Jan 2026 12:16:54 +0800 (CST)
Message-ID: <f63d455c-7593-4382-86ef-9c31a1ebd283@iscas.ac.cn>
Date: Tue, 20 Jan 2026 12:16:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: spacemit: Check netif_carrier_ok when reading
 stats
To: Andrew Lunn <andrew@lunn.ch>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dlan@gentoo.org,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org, pabeni@redhat.com,
 spacemit@lists.linux.dev
References: <e3890633-351d-401d-abb1-5b2625c2213b@iscas.ac.cn>
 <20260119141620.1318102-1-amadeus@jmu.edu.cn>
 <48757af2-bbea-4185-8cc9-2ef51dbc8373@lunn.ch>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <48757af2-bbea-4185-8cc9-2ef51dbc8373@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAXqg21AW9pXw+3BQ--.1431S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy5KryruFyxJr18CryxuFg_yoW8WF1kpF
	43Kw4Fyr1kt3W0qF1Ika1DA3409rZ5tFy5Gr1Fg3s3Aa15Xr1Svr4fKrWjgFyUWryvgw1j
	vr1qvF4YvFWDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUgHanUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 1/19/26 23:09, Andrew Lunn wrote:
>> root@OpenWrt:~# ethtool -S eth1
>> [   71.725539] k1_emac cac81000.ethernet eth1: Read stat timeout
>> NIC statistics:
>>      rx_drp_fifo_full_pkts: 0
>>      rx_truncate_fifo_full_pkts: 0
>>
>> I just discovered that adding "motorcomm,auto-sleep-disabled" to disable
>> the sleep mode of the MotorComm PHY prevents the problem from occurring.
> This suggests that when the PHY stops the reference clock, the MAC
> hardware stops working. It needs that clock to access
> statistics. Keeping the clock ticking will increase power usage a
> little.

As per suggestion from Chukun, adding realtek,aldps-enable to the DTS on
BananaPi F3 (with, obviously, a Realtek PHY) also reproduces this
problem. So this is a good indication that it really is a problem with
this power saving thing.

> I wounder if anything else stops working? There are some MACs whos DMA
> engine stop working without the reference clock. That can cause
> problems during both probe and remove, or open and close.

At least DMA reset seems to work in this case, so it's probably not as
big of a problem, but at least I would conclude that the HW design
didn't have the reference clock stopping in mind. AFAICT from the DTS
files a bunch of other boards also have motorcomm,auto-sleep-disabled so
at least SpacemiT isn't alone in this.

> So it would be nice to have a better understanding of this. If this
> turns out to be true, maybe a comment by this poll_read_timeout()
> indicating if it does timeout, the PHY might be the problem.

I'll send a patch updating the comments and error prints.

Thanks,
Vivian "dramforever" Wang


