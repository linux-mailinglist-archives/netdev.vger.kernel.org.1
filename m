Return-Path: <netdev+bounces-214177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC5B286D0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BFBAA83DC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6123D7E3;
	Fri, 15 Aug 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTaDgpa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3950276;
	Fri, 15 Aug 2025 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288075; cv=none; b=dTCXQiVCOAe2mLtfHV3w0OQrN7V9HAWYY7XXEwDwlHhV11bdhcSp4A6ENYjYMVJ8ZYXnrMpsUQAFncpdYBtyrpMAG9YiYGhyDqR9NsfoMvH4fG6fwKLiXM81vqwqLkFn8S2y+uouwS6G8mbnMxUv6zBnXGzew1vtYyN5tCKHhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288075; c=relaxed/simple;
	bh=6+LmKr2YP0pGP/eJQZgqSIGXevYjsw5ECpIPORp7Bl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEvJXoMmfR9h7IgM/ktEWdbbBcSV0hZFmIzTGtHWpx71wESBWx1aSccJcDvFXw0NAuEt4tYK2ZalOXHczeD92ugutyRmZXLP23p4roLHVYoccodrRR4zbHU0z9Zc2smNTZGbn9eydvYwLUimZKMARWFYWaGrpHF045KYJd0wguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTaDgpa+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78c77ebso370940366b.1;
        Fri, 15 Aug 2025 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755288072; x=1755892872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3m6kWmuzmZpkxa5qzINXaMzNRW1w5l7/WQfkLOFVU=;
        b=XTaDgpa+j32c50YtD5D+44YuWKMRfRWXv/oU00VTL6/9fZqZ9RVMiT7WJz5aUbb6LB
         0JmLwTny3NfjXhSZ4ZwNAMGtRRvcz4TzcYXIs7R1nOJUpX5ZdIlNyqDXgcoHphOhFulM
         3GJspJGM2JFBrgkauZBLuL/4TxZtE1rUR6KLkgY1XMBBJb8v02eI+ozHdYH0jft6HLL2
         nt5aCc7S8AUW9CpHiT/+UeuFGj1Xs/INaHAPVwUvlaiq/vLG4jSkhUx31ghV//dEJWwZ
         ixIPu1SMW5o/MGNRX+Q2xB+86GLGlqPSqIlV3bRDMxxUVirM3NcqhwmHoEQQZudt0c3i
         sUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288072; x=1755892872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3m6kWmuzmZpkxa5qzINXaMzNRW1w5l7/WQfkLOFVU=;
        b=h3l6cipSVnI/sZeFI1BtKwm27geEVotKn4pNzbZH0xiicDDE7xx53X2TPUC6pLVcN3
         c9SfZUvZVZkyPvKj/RODWeCeEFlsjZo52p0NIjONYRsAs7tVduJpc1W5XA1su9KhBigE
         1L42fnwaKbghJgV386iCVYM9MX9kTMpIWP60ld2ffKyYjT+7Vx9HP23V0rTgSlKDiSeX
         YMapiMaYT50qNwhY3O+G3O4w+llgoLXdFlE3mO2pXAMYJooH3HbqyM7ADLXEFJwRwXJn
         UgQ2SKThOOXoBAmK/F1b20dm9jeaLkYLz4O62bOSlvBScEbtBLW3jTE/OJ5AC3fV/LD0
         W7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgVA3Pww6cim2K8HWgXcVeagTUBmDw+O5DjEMhFTJOgye3VFLq4nFHtVxdZ/MovyD+dbLnXRDr@vger.kernel.org, AJvYcCUwBJOZzpgl5YdmlcXN1iVlLcbiZda/0nE3F9w7mrO3z/t2XcupuOmjHCHL1Bfyk/yrO9HzsNEUS23Rkjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLGnmsAZoRPi6gg/9I1rz5d0D50KARNvEXnIwm69sjLuk3YR06
	rlMKBGXNRhRPkzbRncEPf0Rlw5mKzxdezv0+UTqYsCdLMFvXTS36Wikv
X-Gm-Gg: ASbGnctdvmBKpigzsiS4DaaNlMl01HZ+mhHffF23WfeUnz206cHvbRN4VpK+azSB0Hr
	wmn8FtoChyGYxV5myLxIBPZw7msOtJ6N3fYzHmkMkgWhOf6SugFrdWTfMRnj3fkYzMVFUwgwJ48
	zf3xJPmSL7rDuidDmPR3kcNIdErrmfhxZNWPB6PiNmWJud2PCIthXFQ2igIcRnfObVu+E/A6PhK
	U/LBOCcDtVA1mB5hwStXCJJ2ZMT6xzUBQrDX9FAyV+BNUFiFPO/WI6aPYUEhmBi8zmXDZToRmPg
	5ukh6U/UGfVBD5cZa5Rq/h7VFjR4MJC85IfIGEqv40674V/jnMZqMkBr4c2Zwo76GLczNOMqCjT
	OQFuA5ewnuCg0wKLvnpjWRvPNkLdxOTqq
X-Google-Smtp-Source: AGHT+IGPPPKhW/xav02lZiADLlNsDo5PyvNUJXqYDQ74MG+hoLNbCFM4yKLAOmjs9ElOXbXs5nuHdg==
X-Received: by 2002:a17:907:9446:b0:ae4:a17:e6d2 with SMTP id a640c23a62f3a-afcdc22768amr269948766b.24.1755288070831;
        Fri, 15 Aug 2025 13:01:10 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.132.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010e7dsm207430166b.89.2025.08.15.13.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 13:01:10 -0700 (PDT)
Message-ID: <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
Date: Fri, 15 Aug 2025 21:02:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
To: Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Mike Galbraith
 <efault@gmx.de>, paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 18:29, Breno Leitao wrote:
> On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
>> On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
>>> On 8/15/25 01:23, Jakub Kicinski wrote:
>>
>> I suspect disabling netconsole over WiFi may be the most sensible way out.
> 
> I believe we might be facing a similar issue with virtio-net.
> Specifically, any network adapter where TX is not safe to use in IRQ
> context encounters this problem.
> 
> If we want to keep netconsole enabled on all TX paths, a possible
> solution is to defer the transmission work when netconsole is called
> inside an IRQ.
> 
> The idea is that netconsole first checks if it is running in an IRQ
> context using in_irq(). If so, it queues the skb without transmitting it
> immediately and schedules deferred work to handle the transmission
> later.
> 
> A rough implementation could be:
> 
> static void send_udp(struct netconsole_target *nt, const char *msg, int len) {
> 
> 	/* get the SKB that is already populated, with all the headers
> 	 * and ready to be sent
> 	 */
> 	struct sk_buff = netpoll_get_skb(&nt->np, msg, len);
> 
> 	if (in_irq()) {

It's not just irq handlers but any context that has irqs disabled, and
since it's nested under irq-safe console_owner it'd need to always be
deferred or somehow moved out of the console_owner critical section.
Maybe there is printk lock trickery I don't understand, however.

> 		skb_queue_tail(&np->delayed_queue, skb);
> 		schedule_delayed_work(flush_delayed_queue, 0);
> 		return;
> 	}
> 
> 	return __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
> }
> 
> This approach does not require additional memory or extra data copying,
> since copying from the printk buffer to the skb must be performed
> regardless.
> 
> The main drawback is a slight delay for messages sent from within an IRQ
> context, though I believe such cases are infrequent.
> 
> We could potentially also perform the flush from softirq context, which
> would help reduce this latency further.

-- 
Pavel Begunkov


