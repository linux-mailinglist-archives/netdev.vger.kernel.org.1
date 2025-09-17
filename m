Return-Path: <netdev+bounces-224131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220ECB810D5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23337B2453
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD532FAC00;
	Wed, 17 Sep 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q0ERZa5t"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A22F9DBB;
	Wed, 17 Sep 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127111; cv=none; b=QRJSpHBBHKs2Iwz8IuIsK2p4Wbcc5nAlXhP0upPkJHZWOgD4wyTC4FXfluTclzacHbZ24q7SopDpeBBd6fjCFD4PMkoVwUswOln9QNeIMwDlr7ntaWucwqfRkSk/+/Gf514v3lhdjFiIV5gab03JCmeYloDVYS8zUYoyZHV5kZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127111; c=relaxed/simple;
	bh=OBlEWnVjEbpj1lDN0s0regPLqqWIbwrgcbV5Ph1zy7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q3ZwK8dCeaGi+9UXtBCiCs8hLbXGz8aCMjn8palgHPoXTsc1mS1SfATcjdlbWE1HgkNKNCQpIvYqyp7WXvXv2X4Rts60DK7jUqmxRvlCYmiD5RHSQCERlBA1Snwh9BRC0DJrab5VHdpZPD1np0Yr3jIKh0O9C63lFuQybQ8z5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q0ERZa5t; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58HGbcFp1655272;
	Wed, 17 Sep 2025 11:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758127058;
	bh=6BD0XefKDj9yNlwNGnApL1S2MWmUQptL4sGSYMNTzvM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=q0ERZa5tqZqU4zCPUnv1rj/OdqwUCgq2yIoNfx9SuMVkU4OcYwD5RChM1gSOiaI+8
	 LrbmZdc1KQIlqXwSZbu9NpLP2ShxIdOn0BwI4vqHo/975hH3Odtd+Fg+QrvMp+Wx50
	 JH1pfcoft4byTIaa6aw1dQu6syisj9+1ccjnz7F8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58HGbcDA1459556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 17 Sep 2025 11:37:38 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 17
 Sep 2025 11:37:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Sep 2025 11:37:37 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58HGbafA3364151;
	Wed, 17 Sep 2025 11:37:36 -0500
Message-ID: <65a98655-68a1-4bf9-b139-c4172f48dad4@ti.com>
Date: Wed, 17 Sep 2025 11:37:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/7] Add RPMSG Ethernet Driver
To: MD Danish Anwar <danishanwar@ti.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Nishanth Menon
	<nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Xin Guo <guoxin09@huawei.com>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20250911113612.2598643-1-danishanwar@ti.com>
 <8a20160e-1528-4d0e-9347-0561fc3426b4@ti.com>
 <7cd06f8f-bd74-429d-bf2c-71858178950a@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <7cd06f8f-bd74-429d-bf2c-71858178950a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 9/17/25 6:44 AM, MD Danish Anwar wrote:
> Hi Andrew,
> 
> On 11/09/25 9:34 pm, Andrew Davis wrote:
>> On 9/11/25 6:36 AM, MD Danish Anwar wrote:
>>> This patch series introduces the RPMSG Ethernet driver, which provides a
>>> virtual Ethernet interface for communication between a host processor and
>>> a remote processor using the RPMSG framework. The driver enables
>>> Ethernet-like packet transmission and reception over shared memory,
>>> facilitating inter-core communication in systems with heterogeneous
>>> processors.
>>>
>>
>> This is neat and all but I have to ask: why? What does this provide
>> that couldn't be done with normal RPMSG messages? Or from a userspace
>> TAP/TUN driver on top of RPMSG?
>>
> 
> This is different from RPMSG because here I am not using RPMSG to do the
> actual TX / RX. RPMSG is only used to share information (tx / rx
> offsets, buffer size, etc) between driver and firmware. The TX / RX
> happens in the shared memory. This implementation uses a shared memory

This is how RPMSG is supposed to be used, it is meant for small messages
and signaling, bulk data should be send out-of-band. We have examples
specifically showing how this should be done when using RPMSG[0], and our
RPMSG backed frameworks do the same (like DSP audio[1] and OpenVX[2]).

> circular buffer with head/tail pointers for efficient data passing
> without copies between cores.
> 
>> This also feels like some odd layering, as RPMSG sits on virtio, and
>> we have virtio-net, couldn't we have a firmware just expose that (or
>> would the firmware be vhost-net..)?
>>
> 
> PMSG sits on virtio, and we do have virtio-net but I am not trying to do
> ethernet communication over RPMSG. RPMSG is only used to exchange
> information between cores regarding the shared memory where the actual
> ethernet communication happens.
> 

Again nothing new here, virtio-net does control plane work though a
message channel but the data plane is done using fast shared memory
vqueues with vhost-net[3]. Using RPMSG would just be an extra unneeded
middle layer and cause you to re-implement what is already done with
virtio-net/vhost-net.

Andrew

[0] https://git.ti.com/cgit/rpmsg/rpmsg_char_zerocopy
[1] https://github.com/TexasInstruments/rpmsg-dma
[2] https://github.com/TexasInstruments/tiovx
[3] https://www.redhat.com/en/blog/deep-dive-virtio-networking-and-vhost-net

>> Andrew
>>
> 
> 


