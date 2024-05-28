Return-Path: <netdev+bounces-98538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7961E8D1B46
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145041F23FA2
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D40716D4FD;
	Tue, 28 May 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPv1mMSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A416B722;
	Tue, 28 May 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899283; cv=none; b=c/z2wZz513oK2gHum//aswy6+0KWh5Y6aCds05YtcD/3XzytTS3m/s4Te71RR6xZHM/oRp/H3UvH+oVtTMldMOGT3jaUE+ySXUfRXzy+WIe9vDogToc+B8vq0b4GVa1dOLKYM95DB3msTAFdwKkbLv40KUP5+yrJZSq8zkzf1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899283; c=relaxed/simple;
	bh=TN6B4wemPGFuM+0dEnL3oARir5uEmA9oNtVFIzk/oZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKqVGt7VbcOvL98+6lQkDPmBXT7Sp3j4QhuUhiiL/DmgqIj0TxbWahZmf1NIrunNkPL46O52eKY/uGXZ1e3bH2TZcETOmhyScfEqsbt4hALaBO2utsM5RUWkv0bwbPmRr+5HZlLg8hT9GHB/S2nirxUO6a/cYSgA95KGd9jvVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPv1mMSZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57857e0f462so930686a12.0;
        Tue, 28 May 2024 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899280; x=1717504080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjBueRK+9PNOBq1jnz2aw5WpDDizWgajIzb98OM4pio=;
        b=XPv1mMSZtbrT2+SwAKby+NYTIj1GAsvvVsw3Q7jAT1MFuH6H/haVsHmujbwsps1Ddq
         BHNFORni0UGKzxJ396yxyHLBmLxiXzxk+k4i86Cj/lwax3IW7aFUkGAnLux8QXkOdw8N
         o8kMDKUCESOSN8kRX+Y45HG/Uy73xCZ5oBI+2DGyJBv2WgwuSG/1vXBHyoN8geAKhYGD
         vuH8OjuRI4J8J/HC3iomXB21WgvumBs9zndk3XfG3cH8g48YwD6v8gJLbF3WZA6UkS6J
         GoJBlV4RhdPOrRsQlbrk7nDlnbw+RNsys5zYVGTmqwMyWD2UReDAEYbHMcng5ZxCqQEO
         5Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899280; x=1717504080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjBueRK+9PNOBq1jnz2aw5WpDDizWgajIzb98OM4pio=;
        b=qUJ6uxd72OF8ReIGiVt57L9o3SCFzqCMUpVRqlfuE9M+JLc8eQzzBQB39Ufn15FqW3
         zKObmK8LlhQhSHjNI3XWKHsQLeZmg82BEgg959netY1pC3Tmae09oZbH0+r01w8iM9s9
         2rHeBw71L66P2YrmAvVhpEEJQfGCss+GJ19io1XMwiBQqG29u6+1vZPc+maBjHmGutA+
         XFOz2ZQ3StbYtmzxImj2PsdcnEdWdSSHAaTG+HOySRSUP3MVGfTs9Ot2+ZQu2BJh/p1m
         oEK3gOJ+19JramRj4eXoKUL/Hq40Ju42HRkz+emoUTFhCznv8+JCGfCS2O4QX+3qiL7E
         VUjA==
X-Forwarded-Encrypted: i=1; AJvYcCW3a6vPk+Ley+nzy8mPEdI1hoCJanvnu1IomSZ5DWw/VcxOjJAWvHTrOp5Fe5oXemJKUiohbBjkRmIWePTTdz4B0kfCvgfVF2pdxw210A3yfxKCXI2lGvj2tDyorKJR9P+eXzKi
X-Gm-Message-State: AOJu0Yzalb7A2kbhwjoZDx9PWlyL3sh5+r/JPw5h3f7C+9CUp4vpdXTq
	On0Z7G8EuvS2Rm5iDu6teyyiPJHHpqAS1zv29UmwqBwUpVvqATqN
X-Google-Smtp-Source: AGHT+IEeKIeslF9UUaFTayvvIRx7EUYUl2mXEus+Ohn9HxMLrFCJp8GUxWFrs7BdkBOiVulaUmFtrg==
X-Received: by 2002:a50:f60b:0:b0:578:610d:b889 with SMTP id 4fb4d7f45d1cf-578610db9f0mr7322307a12.24.1716899279615;
        Tue, 28 May 2024 05:27:59 -0700 (PDT)
Received: from LPPLJK6X5M3.. (dynamic-78-8-96-206.ssp.dialog.net.pl. [78.8.96.206])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d65934ddsm2555316a12.38.2024.05.28.05.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:27:58 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: vladimir.oltean@nxp.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com,
	willemdebruijn.kernel@gmail.com,
	Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Tue, 28 May 2024 14:25:58 +0200
Message-ID: <20240528122610.21393-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527140145.tlkyayvvmsmnid32@skbuf>
References: <20240527140145.tlkyayvvmsmnid32@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hello,

I'm working on similar taprio bug:
	https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723 
I think I know what is the root cause.

The function advance_sched()
[https://elixir.bootlin.com/linux/v5.10.173/source/net/sched/sch_taprio.c#L696]
runs repeatedly. It is executed using HRTimer.
In every call to advance_sched(), end_time is calculated,
and the timer is set so that the next execution will be at end_time.
To achieve this, first, the expiration time is set using hrtimer_set_expires(),
and second, HRTIMER_RESTART is returned.
This means that the timer is re-enqueued with the adjusted expiration time.
The issue is that end_time is set far before the current time (now),
causing advance_sched() to execute immediately without a context switch.

__hrtimer_run_queues()
[https://elixir.bootlin.com/linux/v5.10.173/source/kernel/time/hrtimer.c#L1615]
is a function with a long loop.
First, please note that now is calculated once and not updated within this function.
We can see the statement basenow = now + base->offset,
but this statement is outside the loop (and in my case, the offset is 0).
The loop will terminate when the queue is empty or the next entry in the queue
has an expiration time in the future.
The issue here is that the queue can be updated within __run_timer().
In my case, __run_timer() adds a new entry to the queue with advance_sched() function.
Since the expiration time is before now, we need to execute advance_sched() again.
The loop is very long because, in our case, the cycle is set to 3ns.

My idea is to create throttling mechanism.
When advance_sched() sets the hrtimer expiration time to before the current time
for X consecutive times, we can postpone the new advance_sched().
You can see my PoC here: https://lore.kernel.org/all/00000000000089...@google.com/T/

Could you take a look at it? What do you think?
Is it acceptable, or is it too aggressive with too much impact on the TAPRIO scheduler?

Radosław.


