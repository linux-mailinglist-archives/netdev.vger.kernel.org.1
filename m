Return-Path: <netdev+bounces-47013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658A7E79FA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3014E1C2097C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485BB748B;
	Fri, 10 Nov 2023 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2nbIZi9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9E4747A
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:10:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49318A5F
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699603837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GQjFWahYGq4tfrY4kZ+Y1bC9y7ReN8MIM0FcjIcMww=;
	b=B2nbIZi9AlgjDMqRKaH7w7Hmwo/VOmoo2eWARUfeN2WAc1eDQVxHoBCR0dgbQelps4m9xg
	b4uGh6Nt8ZB+mkXPTpO22VI5drXix8CTdpretnE3sKfeka4amguprJ9zD5wgdY1Hi/GKzZ
	mpfqoB9HodWYXBYCmstAzeM2xSe2s0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-v6VMaS5TP3inGFLqfefYRg-1; Fri, 10 Nov 2023 03:10:33 -0500
X-MC-Unique: v6VMaS5TP3inGFLqfefYRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67A0085A5B5;
	Fri, 10 Nov 2023 08:10:33 +0000 (UTC)
Received: from [10.45.225.136] (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E98BFC1290F;
	Fri, 10 Nov 2023 08:10:31 +0000 (UTC)
Message-ID: <ff619fd3-c6df-4ecb-a717-18449620012e@redhat.com>
Date: Fri, 10 Nov 2023 09:10:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] i40e: Fix max frame size check
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
References: <20231108151018.72670-1-ivecera@redhat.com>
 <d6114f2b-4ac8-ce15-19f6-483965daf3f3@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d6114f2b-4ac8-ce15-19f6-483965daf3f3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 08. 11. 23 21:38, Jesse Brandeburg wrote:
> On 11/8/2023 7:10 AM, Ivan Vecera wrote:
>> Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
>> a check for port's MFS (max frame size) value. The value is stored
>> in PRTGL_SAH register for each physical port. According datasheet this
>> register is defined as:
>>
>> PRTGL_SAH[PRT]: (0x001E2140 + 0x4*PRT, PRT=0...3)
>>
>> where PRT is physical port number.
> 
> <trimmed lkml, and a couple of non-existent intel addresses>
> 
> Was there an actual problem here? I suspect if you read all the
> registers for each PF's BAR, you'll find that all 4 report the same,
> correct value, for the perspective of the BAR they're being read from.
> 
> The i40e hardware does this (somewhat non-obvious) for *lots* of port
> specific registers, and what happens is no matter which of the 4 you
> read the value from, you'll get the right "port specific" value. This is
> because the hardware designers decided to make a different "view" on the
> register set depending on which PF you access it from. The only time
> these offsets matter is when the part is in debug mode or when the
> firmware is reading the internal registers (from the internal firmware
> register space - which has no aliasing) that rely on the correct offset.
> 
> In this case, I think your change won't make any functional difference,
> but I can see why you want to make the change as the code doesn't match
> the datasheet's definition of the register.
> 
> That all said, unless you can prove a problem, I'm relatively sure that
> nothing is wrong here in functionality or code. And if you go this
> route, there might be a lot of other registers to fix that have the same
> aliasing.
> 
> I apologize for the confusing manuals and header file, it's complicated
> but in practice works really well. Effectively you can't read other
> port's registers by accident.
> 
> Here was my experiment showing the aliasing on X722. You'll note that
> the lower 16 bits are a MAC address that doesn't change no matter which
> register you read.
> 
> device 20:0.0
> 0x1e2140 == 0x26008245
> 0x1e2144 == 0x26008245
> 0x1e2148 == 0x26008245
> 0x1e214c == 0x26008245
> device 20:0.1
> 0x1e2140 == 0x26008345
> 0x1e2144 == 0x26008345
> 0x1e2148 == 0x26008345
> 0x1e214c == 0x26008345
> device 20:0.2
> 0x1e2140 == 0x26008445
> 0x1e2144 == 0x26008445
> 0x1e2148 == 0x26008445
> 0x1e214c == 0x26008445
> device 20:0.3
> 0x1e2140 == 0x26008545
> 0x1e2144 == 0x26008545
> 0x1e2148 == 0x26008545
> 0x1e214c == 0x26008545
> 
> lspci -d ::0200
> 20:00.0 Ethernet controller: Intel Corporation Ethernet Connection X722
> for 10GBASE-T (rev 04)
> 20:00.1 Ethernet controller: Intel Corporation Ethernet Connection X722
> for 10GBASE-T (rev 04)
> 20:00.2 Ethernet controller: Intel Corporation Ethernet Connection X722
> for 10GbE SFP+ (rev 04)
> 20:00.3 Ethernet controller: Intel Corporation Ethernet Connection X722
> for 10GbE SFP+ (rev 04)
> 
> Hope this helps!

Hi Jesse,
thanks a lot for the explanation. I found this during preparation of my 
iwl-next stuff and found that variable 'i' is used inappropriately so I 
checked also the datasheet and found the definition of PRTGL_SAH 
register that is defined per port but I didn't know there is such 
aliasing for registers in PF BAR space.
I will send a new patch that at least fix the wrong usage of 'i' variable.

Thanks,
Ivan


