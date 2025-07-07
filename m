Return-Path: <netdev+bounces-204516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05831AFAF78
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D4A1AA3362
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0AF7B3E1;
	Mon,  7 Jul 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dn08LDGN"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46811DA61B;
	Mon,  7 Jul 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879877; cv=none; b=qGAtTAyNxJ7NtWipVVrb385Ov+Ttc5iKvFNxgSxxzdtFVRpJj5D1IH1HUPNtwQWN5Vnn0ndqw9il63KAohAzpYJn3buXfo/mY/cHcQSowfPN4Ofiw7teU8h6+df3JeSOiNNqf1u60JB58BeU8Qt5HWCenBTergNMNEMiZXSVdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879877; c=relaxed/simple;
	bh=1XdBHyS/TdX5GE0UMDNbHyzwdZxMDzmN0TovPALsqow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2m1FwTt43f7XEJxyr+VjeQ2ik7/Bd/NyDoRNotka0SYhTgfOBZGUQQdueAqO/NCcnBYGqFM6ak/nc1e0/dRT90oguYRhW1H1Pb6i/JLguKmu9Fx53mzBgVqYpL8gMGECt8BEmvKjp8YQAyKN0sR8vWQ/c1yggLyerbQds0rmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dn08LDGN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=BUqPmG1O7JzrnieJR9Ab76YUZOfd8wn7vgsa0nO9wJc=;
	b=dn08LDGNj0yFFA1fHIbkp3GS4IE9C+AlqScgjyxRgeo4rRaHWo7gV4grsRwfD0
	m0bdBzlf+JBtjSgvpYHPt6YYnz0XxzY/iirXuP2yR0daxk4WM7My2U/cMvp8xJ+P
	AFk95Hn/LqB4OXeZ5Ip9xtxR2PmueLiChX0qfrrPJgh+o=
Received: from [172.21.20.151] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3HWCpkGtozG4IBg--.20542S2;
	Mon, 07 Jul 2025 17:17:30 +0800 (CST)
Message-ID: <a2834142-f683-4947-8fff-60727481d7e8@163.com>
Date: Mon, 7 Jul 2025 17:17:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] af_packet: fix soft lockup issue caused by tpacket_snd()
To: Eric Dumazet <edumazet@google.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707081629.10344-1-luyun_611@163.com>
 <CANn89iKZRpJVduH0WZ57pqRaEma-HB2ymi9P9Q7aK-f7Q8r5XA@mail.gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <CANn89iKZRpJVduH0WZ57pqRaEma-HB2ymi9P9Q7aK-f7Q8r5XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3HWCpkGtozG4IBg--.20542S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13Jw4rWrWUKw1Dur4DJwb_yoW5JF13p3
	y5t3y2yFnrCr40qw1rAr4rJr1Ivw4rJFs8GrZrKryfAr98tas7trWxtayY9as7urZ2kw4a
	vF42gryUu34DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfnY7UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiWxaDzmhrhbjP4wABsT


在 2025/7/7 16:56, Eric Dumazet 写道:
> On Mon, Jul 7, 2025 at 1:16 AM Yun Lu <luyun_611@163.com> wrote:
>> From: Yun Lu <luyun@kylinos.cn>
>>
>> When MSG_DONTWAIT is not set, the tpacket_snd operation will wait for
>> pending_refcnt to decrement to zero before returning. The pending_refcnt
>> is decremented by 1 when the skb->destructor function is called,
>> indicating that the skb has been successfully sent and needs to be
>> destroyed.
>>
>> If an error occurs during this process, the tpacket_snd() function will
>> exit and return error, but pending_refcnt may not yet have decremented to
>> zero. Assuming the next send operation is executed immediately, but there
>> are no available frames to be sent in tx_ring (i.e., packet_current_frame
>> returns NULL), and skb is also NULL, the function will not execute
>> wait_for_completion_interruptible_timeout() to yield the CPU. Instead, it
>> will enter a do-while loop, waiting for pending_refcnt to be zero. Even
>> if the previous skb has completed transmission, the skb->destructor
>> function can only be invoked in the ksoftirqd thread (assuming NAPI
>> threading is enabled). When both the ksoftirqd thread and the tpacket_snd
>> operation happen to run on the same CPU, and the CPU trapped in the
>> do-while loop without yielding, the ksoftirqd thread will not get
>> scheduled to run. As a result, pending_refcnt will never be reduced to
>> zero, and the do-while loop cannot exit, eventually leading to a CPU soft
>> lockup issue.
>>
>> In fact, as long as pending_refcnt is not zero, even if skb is NULL,
>> wait_for_completion_interruptible_timeout() should be executed to yield
>> the CPU, allowing the ksoftirqd thread to be scheduled. Therefore, the
>> execution condition of this function should be modified to check if
>> pending_refcnt is not zero.
>>
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> I think you forgot a Fixes: tag.
Thank you for your advise, I will add this tag in v2 version later.
>
> Also it seems the soft lockup could happen if MSG_DONTWAIT is set ?

If MSG_DONTWAIT is set, need_wait will be false. In this case, once 
there are no

available frames to send (i.e., ph is NULL), the while loop condition 
will not be

satisfied, and the loop will exit and return immediately without waiting for

pending_refcnt to decrease to 0. The soft lockup issue should no longer 
occur.

while (likely((ph != NULL) ||
                  (need_wait && packet_read_pending(&po->tx_ring))));


