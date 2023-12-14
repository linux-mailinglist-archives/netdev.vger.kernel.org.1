Return-Path: <netdev+bounces-57406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957C48130BC
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4037F1F21A30
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78A4E61F;
	Thu, 14 Dec 2023 13:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B9116
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:00:22 -0800 (PST)
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EF94261E5FE09;
	Thu, 14 Dec 2023 13:59:57 +0100 (CET)
Message-ID: <f5b560ed-783d-49fe-ba51-c4f77e30c479@molgen.mpg.de>
Date: Thu, 14 Dec 2023 13:59:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: enable WB_ON_ITR
Content-Language: en-US
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Joshua Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org,
 maciej.fijalkowski@intel.com, emil.s.tantilov@intel.com,
 larysa.zaremba@intel.com, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, alan.brady@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231212145546.396273-1-michal.kubiak@intel.com>
 <78ecdb9f-25e9-4847-87ed-6e8b44a7c71d@molgen.mpg.de>
 <ZXmwR4s25afUbwz3@localhost.localdomain>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZXmwR4s25afUbwz3@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Lieber Michal,


Am 13.12.23 um 14:23 schrieb Michal Kubiak:
> On Tue, Dec 12, 2023 at 05:50:55PM +0100, Paul Menzel wrote:

>> On 12/12/23 15:55, Michal Kubiak wrote:
>>> From: Joshua Hay <joshua.a.hay@intel.com>
>>>
>>> Tell hardware to writeback completed descriptors even when interrupts
>>
>> Should you resend, the verb is spelled with a space: write back.
> 
> Sure, I will fix it.

Thanks.

>>> are disabled. Otherwise, descriptors might not be written back until
>>> the hardware can flush a full cacheline of descriptors. This can cause
>>> unnecessary delays when traffic is light (or even trigger Tx queue
>>> timeout).
>>
>> How can the problem be reproduced and the patch be verified?

[…]

> To be honest, I have noticed the problem during the implementation of
> AF_XDP feature for IDPF driver. In my scenario, I had 2 Tx queues:
>   - regular LAN Tx queue
>   - and XDP Tx queue
> added to the same q_vector attached to the same NAPI, so those 2 Tx
> queues were handled in the same NAPI poll loop.
> Then, when I started a huge Tx zero-copy trafic using AF_XDP (on the XDP
> queue), and, at the same time, tried to xmit a few packets using the second
> (non-XDP) queue (e.g. with scapy), I was getting the Tx timeout on that regular
> LAN Tx queue.
> That is why I decided to upstream this fix. With disabled writebacks,
> there is no chance to get the completion descriptor for the queue where
> the traffic is much lighter.
> 
> I have never tried to reproduce the scenario described by Joshua
> in his original patch ("unnecessary delays when traffic is light").

Understood. Maybe you could add a summary of the above to the commit 
message or just copy and paste. I guess, it’s better than nothing. And 
thank you for upstreaming this.


Kind regards,

Paul

